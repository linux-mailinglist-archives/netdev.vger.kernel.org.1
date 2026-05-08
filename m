Return-Path: <netdev+bounces-286038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBEpHgFq/mmIqQAAu9opvQ
	(envelope-from <netdev+bounces-286038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:56:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D49114FC883
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B32C4304D5F0
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEB93A7839;
	Fri,  8 May 2026 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/Ene4He"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EDE3A7599
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280911; cv=none; b=fJEdpM4iVcsWhDwrcAdxPhWghi8/aZQ/xvf/8cZ3nyheABlewkTU9a9B1UdYpfqar+OON6sXCNiFzDroBeFLz347s0D+iSaqnH1jiA/aUdtyUaM+H2gnmFHqgf8SNnBObh1Yt8dq8U4pppjBc4eJjIbpM/ToroRy2pVJRVVzQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280911; c=relaxed/simple;
	bh=CVqAl3h2sQiHll5+dUoDH42EkZ2/IA0LMeI9TrUtPcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkykklbKmpMVejtiMudCHp8MnajuwBO2TZJ7Z4X6Wcc2l84aAq8mQ23SDoIpiBXh+hqhAB/joSdRhYgGL068ZD8BQaH/+xdli3YuL8N26paAMHg6df/qNzFGcX0+cUMrpQmxNdzcSNEbdVVQ3RRS3rIH8hGVKXaUGvPaPdeJAh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/Ene4He; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DAEC2BCB4;
	Fri,  8 May 2026 22:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280911;
	bh=CVqAl3h2sQiHll5+dUoDH42EkZ2/IA0LMeI9TrUtPcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F/Ene4HeQIkSV9CXfZWfcSG/TQitL0pjk8aiSVofoaO0esbYFlnQ3FgflLD4PdY6u
	 VDnXuRhF4Y9RaTX5E4YqeVUNd2huqUpGcXfJMN4uMMYbPFIKWzijb7OCxSUL3ghgPN
	 OTeMOvmGeqleGubU1FFoNN8f4Qy7o/a8NNMoMDfT9EIhkhbaKmtrnS4CIWOa4AfNsz
	 Zw94XLdFM6gvnFLsrcwKAmQcd/9raw+Jc0N9gEf36x9OEYKaBEtRQLs94GDjp2kIIL
	 Du0aUs9MzRMjyw1hYscUVxxYxuV7rw6yqsD4E9fS32d9Xp4le7JQs0k0pSDLVYR+TB
	 rowR5DnSGhj0w==
From: Jakub Kicinski <kuba@kernel.org>
To: eric.joyner@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 2/5] ionic: Get "link_down_count" ext link stat from firmware
Date: Fri,  8 May 2026 15:55:10 -0700
Message-ID: <20260508225510.3420230-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506043526.64301-3-eric.joyner@amd.com>
References: <20260506043526.64301-3-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D49114FC883
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286038-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ionic: Get "link_down_count" ext link stat from firmware

This commit replaces the driver-calculated software link down count with the
hardware count provided by the firmware in the extended link statistics. It
updates the ethtool callback to read the counter from the device's port_info
and removes the software tracking completely.

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index 78a802eb159f0..af0c4cc8ad8e4 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -117,7 +117,8 @@ static void ionic_get_link_ext_stats(struct net_device *netdev,
>  	struct ionic_lif *lif = netdev_priv(netdev);
>  
>  	if (lif->ionic->pdev->is_physfn)
> -		stats->link_down_events = lif->link_down_count;
> +		stats->link_down_events =
> +			    lif->ionic->idev.port_info->status.link_down_count;

Could this lead to a NULL pointer dereference?

If a PCI error triggers device recovery via .reset_prepare, the device stops
but the net_device remains registered. If the subsequent ionic_setup_one()
fails during .reset_done, port_info is explicitly freed and set to NULL.
Calling ethtool in this state would crash the kernel.

Other callbacks like ionic_get_link_ksettings() guard against this:

	if (!idev->port_info) {
		netdev_err(netdev, "port_info not initialized\n");
		return -EOPNOTSUPP;
	}

Does link_down_count also need a byte-order conversion?

The firmware-provided field link_down_count in struct ionic_port_status is
defined as a little-endian 16-bit integer (__le16). Assigning it directly
to stats->link_down_events without wrapping it in le16_to_cpu() will result
in incorrect statistic values on big-endian architectures.

