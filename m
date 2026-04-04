Return-Path: <netdev+bounces-275301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJrDKUtW0GkA6gYAu9opvQ
	(envelope-from <netdev+bounces-275301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:07:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF9B399390
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51261308C0D2
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 00:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6471E511;
	Sat,  4 Apr 2026 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKF0AeF8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B77EDDC3
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 00:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261171; cv=none; b=ZZsbnCRqFWa0oDVCWN29JbrYNqPIDvzr5GL5vqIecrgMVyEpRvxMdhUoe1wYDRTykQMfffciu1/PU/DNDn9sIaAUcc39MXTL+OcGSvN3wfsJ5oXibEa14Gxw49PCbT+BOGJF9ZQcMwfrW5SmE9+xRQ4AeZ9ACO5kAX6DkYcEiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261171; c=relaxed/simple;
	bh=kZGEyS4InSb4Lw4mS+3AynO5GElC33jAeGSZaeeMk3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bh7/GLwLGpXSFU7hAYjK0ph6kOTMdhwfIBjIXhOzU9v3h1eJx+3gzxmkyzSkS5qG5jKTT4jjeoDDvClPot1RPyJYVYgeUjg1VkcMfZ/CgJMvQQsGo78nqs4L5XkihqPKwRypE6y15S1ZjOUEPZNT2fRFQvR2MUdpCX1zBAFMg0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKF0AeF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD5CC4CEF7;
	Sat,  4 Apr 2026 00:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775261170;
	bh=kZGEyS4InSb4Lw4mS+3AynO5GElC33jAeGSZaeeMk3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sKF0AeF8SoZx/IMoZ5CIhhUwVVfnyiOcVtCpOVTk8+mYsgxMXbBetclTj0sHVj6DR
	 TS4WLgBSa/KywSaNfGpUq8lpWWahrPqzwrkUlRD1NiNam10By/qherbVPmKPiqSHPC
	 9J5F4/IvjQXvCLmU1liTgp4z/atbuJwL4YWQZ7l/AvQZQRXJzSGg/dosvXORlmmFUS
	 8IyHW4Q4w2Ob+LiUTnFDS+g3N1vQ0NzXHsN+ZnjmX7uLWl2QlLHwqIF16JZTGkaSNQ
	 Ib5x/3OmDFTQ+YSVmXGtsTAOceWZvDta0gVOq3Pnt+9plILe6Mn8YrnVzanDzaXiWk
	 65K9FZknaLMgA==
From: Jakub Kicinski <kuba@kernel.org>
To: sdf@fomichev.me
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	jv@jvosburgh.net
Subject: Re: [PATCH net-next v5 06/14] mlx5: convert to ndo_set_rx_mode_async
Date: Fri,  3 Apr 2026 17:06:09 -0700
Message-ID: <20260404000609.2414051-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402225535.4124525-7-sdf@fomichev.me>
References: <20260402225535.4124525-7-sdf@fomichev.me>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275301-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EF9B399390
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
mlx5: convert to ndo_set_rx_mode_async

This commit converts the mlx5 driver to use ndo_set_rx_mode_async. It passes
the uc and mc snapshots directly to the internal work handlers instead of
queueing work and manually iterating the address lists.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> @@ -609,20 +609,26 @@ static void mlx5e_execute_l2_action(struct mlx5e_flow_steering *fs,
>  }
>  
>  static void mlx5e_sync_netdev_addr(struct mlx5e_flow_steering *fs,
> -				   struct net_device *netdev)
> +				   struct net_device *netdev,
> +				   struct netdev_hw_addr_list *uc,
> +				   struct netdev_hw_addr_list *mc)
>  {
>  	struct netdev_hw_addr *ha;
>  
> -	netif_addr_lock_bh(netdev);
> +	if (!uc || !mc) {
> +		netif_addr_lock_bh(netdev);
> +		mlx5e_sync_netdev_addr(fs, netdev, &netdev->uc, &netdev->mc);
> +		netif_addr_unlock_bh(netdev);
> +		return;
> +	}
>  
>  	mlx5e_add_l2_to_hash(fs->l2.netdev_uc, netdev->dev_addr);

Can this lead to a torn read of the MAC address?

When uc and mc are provided, this path now reads netdev->dev_addr without
holding netif_addr_lock_bh().

Because ndo_set_rx_mode_async runs asynchronously in a workqueue, this read
could happen concurrently with a MAC address change in mlx5e_set_mac().
Since mlx5e_set_mac() updates the address using eth_hw_addr_set() under
netif_addr_lock_bh(), a concurrent read here might be torn and program a
corrupted MAC address into the hardware filters.

[ ... ]

