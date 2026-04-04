Return-Path: <netdev+bounces-275303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKlrGGtW0GkA6gYAu9opvQ
	(envelope-from <netdev+bounces-275303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:08:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C8C3993B6
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9710F309ED87
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 00:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731D91E511;
	Sat,  4 Apr 2026 00:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCGoCVVL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A6DDC3
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 00:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261174; cv=none; b=aOH+axn4r4ntWnHSJ6aAgnPHoiQ1AP+1hOUKhZB+Bo5Vcbn1cEhc1EIdkaCFNK4SjLfie3077GuRAnn/GH/dt0GCsmQhSNzxjO2TnJfrZ3GBgBOPPvJ+7nXV2/2B4E0Xjrr2SPHNsgKvc994e1el/8GUo7lyq4uh5imnPZYs/aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261174; c=relaxed/simple;
	bh=nGGQhNxPSTMnv9HcgCSLl7Kzd06PIjk21+AeY8M4cnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZNhMV1fBGSJ+QYECHbz5FMG29x0ZjvtE5sE6WlAjkNVsV6k5EjuTz9Y5f/NErF5zoo98Un1At4THE2GkUSE296iACpJbTvWGHqfVBOoSCKy561iXF2ILxr1MNSwmAu6anAzybj+oXAcwNT0TxOv7C7lj7+Kimm/5vqS2i5wE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCGoCVVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8590EC4CEF7;
	Sat,  4 Apr 2026 00:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775261173;
	bh=nGGQhNxPSTMnv9HcgCSLl7Kzd06PIjk21+AeY8M4cnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCGoCVVLi6KBq1HLUPTys0lsUnAMFjTLP8TWFbiSZlArBnb9ATVySLGtve5kzanDS
	 BwIxNoDPQBqmqDrW04AETsBV3tL9D9rf0Qve9mCu/ii4vvwoInSXB0+4JgskUUfeVK
	 sT7SfMgIyc2NnxBZ41eqjfVDDeblXO0XUIUcLb9ORelBWAX/5R+OoyYUwL+Q+YzDw5
	 R1gw7F40W8fuP1azoptHfRiJDn2izc3+i2phmztacqY+cZRwstx6xNdQXLev+mWdi0
	 k5KySY/ReaQPAhBS7NvjPHdC4FtnRIgwZfLLkGh9Z4pd2OS9kyJ9irxQaRsROwfAl2
	 mqXaqzxONDluQ==
From: Jakub Kicinski <kuba@kernel.org>
To: sdf@fomichev.me
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	jv@jvosburgh.net
Subject: Re: [PATCH net-next v5 08/14] bnxt: use snapshot in bnxt_cfg_rx_mode
Date: Fri,  3 Apr 2026 17:06:12 -0700
Message-ID: <20260404000612.2414120-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402225535.4124525-9-sdf@fomichev.me>
References: <20260402225535.4124525-9-sdf@fomichev.me>
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
	TAGGED_FROM(0.00)[bounces-275303-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: F2C8C3993B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
bnxt: use snapshot in bnxt_cfg_rx_mode

With the introduction of ndo_set_rx_mode_async we can call bnxt_cfg_rx_mode
directly. Convert bnxt_cfg_rx_mode to use uc/mc snapshots and move its
call in bnxt_sp_task to the section that resets BNXT_STATE_IN_SP_TASK.

Link: https://lore.kernel.org/netdev/CACKFLi=5vj8hPqEUKDd8RTw3au5G+zRgQEqjF+6NZnyoNm90KA@mail.gmail.com/

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
[ ... ]
> -static int bnxt_cfg_rx_mode(struct bnxt *bp)
> +static int bnxt_cfg_rx_mode(struct bnxt *bp, struct netdev_hw_addr_list *uc,
> +			    struct netdev_hw_addr_list *mc)

This isn't a bug, but is the mc parameter used in this function? The
multicast configuration appears to be handled synchronously prior to this call
by bnxt_mc_list_updated().

>  {
>  	struct net_device *dev = bp->dev;
>  	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
>  	struct netdev_hw_addr *ha;
>  	int i, off = 0, rc;
> -	bool uc_update;
> -
> -	netif_addr_lock_bh(dev);
> -	uc_update = bnxt_uc_list_updated(bp, &dev->uc);
> -	netif_addr_unlock_bh(dev);
> -
> -	if (!uc_update)
> -		goto skip_uc;

By removing this check, will the driver now unconditionally delete and recreate
all secondary hardware unicast MAC filters via HWRM commands on any RX mode
change?

For example, if an unprivileged user joins a multicast group via
IP_ADD_MEMBERSHIP, does this create a time window where the hardware drops
valid unicast traffic destined for secondary MACs?

Also, if any of the firmware commands to re-add a filter fail, will the
function return early and skip programming the RX mask entirely?

[ ... ]
> @@ -14684,6 +14675,12 @@ static void bnxt_sp_task(struct work_struct *work)
>  	/* These functions below will clear BNXT_STATE_IN_SP_TASK.  They
>  	 * must be the last functions to be called before exiting.
>  	 */
> +	if (test_and_clear_bit(BNXT_RX_MASK_SP_EVENT, &bp->sp_event)) {
> +		bnxt_lock_sp(bp);

Could this introduce a race condition with bnxt_close()?

bnxt_lock_sp() temporarily clears the BNXT_STATE_IN_SP_TASK bit before
blocking on netdev_lock(bp->dev). If bnxt_close() is called concurrently, it
holds netdev_lock() and loops waiting for BNXT_STATE_IN_SP_TASK to clear.

When bnxt_lock_sp() clears the bit, bnxt_close() could unblock, shut down the
device, and free memory including bp->vnic_info via bnxt_free_vnics().

After bnxt_close() completes and releases the lock, bnxt_sp_task() would
acquire it and unconditionally call bnxt_cfg_rx_mode(), which dereferences the
now-freed bp->vnic_info.

Would it be safer to check test_bit(BNXT_STATE_OPEN, &bp->state) after
acquiring the lock, similar to what neighboring handlers do?

> +		bnxt_cfg_rx_mode(bp, &dev->uc, &dev->mc);
> +		bnxt_unlock_sp(bp);
> +	}

