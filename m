Return-Path: <netdev+bounces-275302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B88H1tW0GmH6gYAu9opvQ
	(envelope-from <netdev+bounces-275302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:07:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9BE3993A8
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62BF730209DC
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 00:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0318D883F;
	Sat,  4 Apr 2026 00:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGa8cjBL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55FD1E511
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 00:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261172; cv=none; b=QQe4xn6/3XOMF/uWC1KQANVfqNsYquRhasoQMZjUtolv8j9Uno3ob7rPpbIqO/1XxdoYdg6ypwVqR12ulF6/34PuhyVDLTmWqvi7r8thzvqe45xeaXKyCCTa75koIkFJo5hJ3138Zz1GX2+ICJqsYAp70OqrA1e9LuTEcF293Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261172; c=relaxed/simple;
	bh=eEsuNQeC61w5I4x/YTvTpDPIHSt2B49ywFjiuKGI8r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LH8uZ/BpEarkbrtlEI6HOAnBEtGU//YwABs33dDY1z1VMoIwhtiwpMk4oWF4ywfpigH7LX3wMzExlIAOfBqhtd4WyYhKisiSz+phmSYAYogrVPj/ux4Hx66ij4FBH9bxBwp5232EXFribw5c3VlC2vzNDtGvXlqHzmol6haaxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGa8cjBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4887C4CEF7;
	Sat,  4 Apr 2026 00:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775261172;
	bh=eEsuNQeC61w5I4x/YTvTpDPIHSt2B49ywFjiuKGI8r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGa8cjBLuOvgLDelfS9Ht3t/RnGfoOyLD7bA0T1Ec+j2kkcLQzC1hdSerz74gXZ2a
	 XWqFLwM+nK4xIOiyTxU2Vri0PrQJERcSoZq+kSZ2WWJYdbEY3WvqP+c71fVW3pxS6F
	 rpXOBXM9a/QU+X9cEMiRMwNXTEHPBjSnsogHp76snLnGPBiKC9o97drvtUdrw90Mk9
	 ZmwVUnw7OOSKhnX2He0CH1HJYyf8Fe+H+VYMgGQqvW/on06yfhBjP9AzJgfk2kCEiY
	 9NS4T9EXX6xecLUb8EHtkN8TrDNbs4qEDq8pSgN0DNthCvDfkTEh/IlWJGUCPMYVQL
	 /zFECFgUePieQ==
From: Jakub Kicinski <kuba@kernel.org>
To: sdf@fomichev.me
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	jv@jvosburgh.net
Subject: Re: [PATCH net-next v5 07/14] bnxt: convert to ndo_set_rx_mode_async
Date: Fri,  3 Apr 2026 17:06:10 -0700
Message-ID: <20260404000611.2414085-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402225535.4124525-8-sdf@fomichev.me>
References: <20260402225535.4124525-8-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275302-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E9BE3993A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
bnxt: convert to ndo_set_rx_mode_async

This commit converts the bnxt driver to use ndo_set_rx_mode_async, updating
the rx mode callbacks to take explicit list parameters and iterate over them.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index fe8b886ff82ea..569c7de7c5e44 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

[ ... ]

> @@ -13523,17 +13524,17 @@ void bnxt_get_ring_drv_stats(struct bnxt *bp,
>  		bnxt_get_one_ring_drv_stats(bp, stats, &bp->bnapi[i]->cp_ring);
>  }
>  
> -static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask)
> +static bool bnxt_mc_list_updated(struct bnxt *bp, u32 *rx_mask,
> +				 const struct netdev_hw_addr_list *mc)
>  {
>  	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
> -	struct net_device *dev = bp->dev;
>  	struct netdev_hw_addr *ha;
>  	u8 *haddr;
>  	int mc_count = 0;
>  	bool update = false;
>  	int off = 0;
>  
> -	netdev_for_each_mc_addr(ha, dev) {
> +	netdev_hw_addr_list_for_each(ha, mc) {

When iterating over the list, bnxt_mc_list_updated() performs a memcpy()
into vnic->mc_list.

If this executes asynchronously while bnxt_cfg_rx_mode() is mapping
vnic->mc_list for DMA to the firmware via bnxt_hwrm_cfa_l2_set_rx_mask(),
could the NIC hardware read torn or corrupted multicast MAC addresses?

Even if a later patch addresses the explicit list TOCTOU issue, is a
driver-level spinlock needed here to serialize vnic state access between
the two concurrent workqueues?

[ ... ]

> @@ -15881,7 +15884,7 @@ static const struct net_device_ops bnxt_netdev_ops = {
>  	.ndo_start_xmit		= bnxt_start_xmit,
>  	.ndo_stop		= bnxt_close,
>  	.ndo_get_stats64	= bnxt_get_stats64,
> -	.ndo_set_rx_mode	= bnxt_set_rx_mode,
> +	.ndo_set_rx_mode_async	= bnxt_set_rx_mode,

Since this callback now runs asynchronously without the netif_addr_lock_bh()
that the core networking stack previously held, does this introduce data races
on the driver state?

With bnxt_set_rx_mode() executing locklessly in the netdev_rx_mode_work
workqueue, and bnxt_cfg_rx_mode() concurrently modifying vnic->uc_list,
vnic->uc_filter_count, and vnic->rx_mask in the driver's bnxt_sp_task
workqueue, can they race when accessing the vnic state?

For example, could lockless assignments to vnic->rx_mask in bnxt_set_rx_mode()
temporarily drop hardware fallback states (like the PROMISCUOUS bit) set by
bnxt_cfg_rx_mode()?

>  	.ndo_eth_ioctl		= bnxt_ioctl,
>  	.ndo_validate_addr	= eth_validate_addr,
>  	.ndo_set_mac_address	= bnxt_change_mac_addr,

