Return-Path: <netdev+bounces-275304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFHWEHxW0GmR6gYAu9opvQ
	(envelope-from <netdev+bounces-275304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:08:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AE03993BD
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7FA73023DFD
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 00:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A06DDC3;
	Sat,  4 Apr 2026 00:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXeYDDY4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CC5883F
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 00:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261176; cv=none; b=lyv79sNkF1Ye6HUD1m1DQewH/GzeaaqwZfqwg9SdBj1VnCo6Mu1WR9nvAP5xPR5naBd9z/l9Yu0zVYoK1qM9ziTfNIY+0VNrO96lqdIaJjVGjTqAnrA3TMe85+AHf1C0/V1lYSOsb82HXPh/SJ3vnx6Tdk/bNMjQEFqrph11KXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261176; c=relaxed/simple;
	bh=1xDBy71P961WNCshi0lkp4Cuq0YsiTGkzdTX6l5JObg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjQ9V3ICEwTgVZD9wrqU2rwYuWkmmObeuAbcr+goqZfLQnQBZGCPgF+aWh13c7SR5ej58hHkBDx+3QQzbM1S8C4brjqbc5wlcDs83O5XIe2vF7lwNDjnFlYcPe7vYQmCVppCB6ycoOKWaW4sDsYtl7Jl0x69ZTn+/2SOK8k7vwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXeYDDY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EE2C19424;
	Sat,  4 Apr 2026 00:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775261176;
	bh=1xDBy71P961WNCshi0lkp4Cuq0YsiTGkzdTX6l5JObg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OXeYDDY4UcRrDlH5sl6+9sbPPw0R4zdORNo10kCkN4icLxbxWCWWV6u3CFst2RfTj
	 q6MGtHawVyoRH+SehRRL+a4PwnkSRXkYId09LyBpuNOKb2AyB1rj1KmXYSGh3PTrc0
	 cLI7/ghz45AtVJBB3zfYyEPHJPw2ZuQmeHdPF3kLd0d25m8YPbgxZ5nD6koarq63LE
	 eFgwW/F4cTTE8doBPj6MxjOWQymyOBf94dc9qqT7cIUCPKqvo2EUkf3xwaq6NKN2my
	 eolXMBDVE3PAAMFWU0TiwvLMUORDKmxgnEt0C76Wm0GBUjjq6Ib4ib+/juxR5LfYCU
	 SkbId/f8qTQGg==
From: Jakub Kicinski <kuba@kernel.org>
To: sdf@fomichev.me
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	jv@jvosburgh.net
Subject: Re: [PATCH net-next v5 09/14] iavf: convert to ndo_set_rx_mode_async
Date: Fri,  3 Apr 2026 17:06:14 -0700
Message-ID: <20260404000614.2414164-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402225535.4124525-10-sdf@fomichev.me>
References: <20260402225535.4124525-10-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275304-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 92AE03993BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
iavf: convert to ndo_set_rx_mode_async

This commit converts the iavf driver from using ndo_set_rx_mode to
ndo_set_rx_mode_async. It updates iavf_set_rx_mode to take explicit
unicast and multicast list parameters and uses __hw_addr_sync_dev on
the snapshots instead of __dev_uc_sync and __dev_mc_sync.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1150,14 +1150,18 @@ bool iavf_promiscuous_mode_changed(struct iavf_adapter *adapter)
> -static void iavf_set_rx_mode(struct net_device *netdev)
> +static void iavf_set_rx_mode(struct net_device *netdev,
> +			     struct netdev_hw_addr_list *uc,
> +			     struct netdev_hw_addr_list *mc)
>  {
>  	struct iavf_adapter *adapter = netdev_priv(netdev);
>  
>  	spin_lock_bh(&adapter->mac_vlan_list_lock);
> -	__dev_uc_sync(netdev, iavf_addr_sync, iavf_addr_unsync);
> -	__dev_mc_sync(netdev, iavf_addr_sync, iavf_addr_unsync);
> +	__hw_addr_sync_dev(uc, netdev, iavf_addr_sync, iavf_addr_unsync);
> +	__hw_addr_sync_dev(mc, netdev, iavf_addr_sync, iavf_addr_unsync);
>  	spin_unlock_bh(&adapter->mac_vlan_list_lock);

[ ... ]

> @@ -1210,7 +1214,7 @@ static void iavf_configure(struct iavf_adapter *adapter)
>  	struct net_device *netdev = adapter->netdev;
>  	int i;
>  
> -	iavf_set_rx_mode(netdev);
> +	iavf_set_rx_mode(netdev, &netdev->uc, &netdev->mc);

Does this code iterate and mutate the live netdev address lists without
holding the required locks?

Previously, iavf_set_rx_mode() called __dev_uc_sync() and __dev_mc_sync(),
which internally acquire netif_addr_lock_bh() to protect the live netdev
address lists.

Now, iavf_configure() passes the live lists (&netdev->uc and &netdev->mc)
directly to iavf_set_rx_mode(), which calls __hw_addr_sync_dev() on them.
__hw_addr_sync_dev() iterates and modifies the lists by updating sync_cnt,
refcount, and removing stale entries.

Since iavf_configure() is called from contexts like iavf_open() and the
driver's watchdog task, it appears netif_addr_lock_bh() is not held here.

Could this cause list or RB-tree corruption if there are concurrent
modifications, such as IGMP/MLD timers adding multicast addresses in softirq
while holding netif_addr_lock_bh()?

