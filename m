Return-Path: <netdev+bounces-268583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NZdCrRFuWmK+QEAu9opvQ
	(envelope-from <netdev+bounces-268583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:14:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 888622A9A4A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AFA83219374
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0769D3BC674;
	Tue, 17 Mar 2026 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2UI/KCu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E033B7B67
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 12:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749302; cv=none; b=kPzZyscqcHb8T9IQJqL3ozsYlamMaxvRQTTlLmdukZdFCriQCaQUbPSgM11gAaqHQhdnPO8H/FGJvUIo+jvO7AaFh8e71fyP6G/PRMc9a0FqQqxvLz+rHC4La+k03F0SIJXGZHxPJ/jhXDRgfrl0hxWGHnkqjkXQDIm+6/GAjlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749302; c=relaxed/simple;
	bh=xs1LoIyu6wA9qMtDrH92lf22DIh5iJvAvuHhaGq4R2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoNo7PIk31OgAcfHeSIT8fX2llWRXnhn86sznUdkPbwyRBmnWOH/hntnbeP3Yzd3Z7sl/pP4XEK4QcTNirEJjypiy8Yt3Xj40+pc5uQC+U/vLut7Ge6CSx+LuSf2fF4xO37IzoaqSw/N6dieUM+oHOR8OWHBdyJBILKcZoHdOrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K2UI/KCu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773749299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWi0P4vO22+fUdb+J0wcLHg3NJLhq6aK6f+WlF3LnGs=;
	b=K2UI/KCuGlPaeXRIm0Nb0voKY2exr97peH1W3bgcUTgDDvDcZLs/TpYj6ceZp2ORR/gpTa
	vQQcqNstHw/1KUslvJzP/94/YHnXIqrgdrPCl+po9HDbyYEVf/PLAs3Xz3sqSaWAJ6jw8f
	iZ1P0dbj/FhMU2wmvJoVB1+1c1fFGJw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-pE6JdfO2NfWyvqRUopxgyw-1; Tue,
 17 Mar 2026 08:08:16 -0400
X-MC-Unique: pE6JdfO2NfWyvqRUopxgyw-1
X-Mimecast-MFC-AGG-ID: pE6JdfO2NfWyvqRUopxgyw_1773749294
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 229DA1800637;
	Tue, 17 Mar 2026 12:08:14 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.192])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 505AA180035F;
	Tue, 17 Mar 2026 12:08:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: Raju.Rangoju@amd.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	Thomas.Lendacky@amd.com,
	maxime.chevallier@bootlin.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [net] amd-xgbe: synchronize KR training with device operations
Date: Tue, 17 Mar 2026 13:08:05 +0100
Message-ID: <20260317120805.163436-1-pabeni@redhat.com>
In-Reply-To: <20260313134210.3824872-1-Raju.Rangoju@amd.com>
References: <20260313134210.3824872-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268583-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 888622A9A4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
amd-xgbe: synchronize KR training with device operations

This commit adds synchronization to prevent device operations from
interrupting active KR training by introducing a mailbox mutex and waiting
for KR training completion before proceeding with stop/rate change
operations.

> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> index 23beea48ae26..3913eb7e1da3 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c

[ ... ]

> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> index b8cf6ccfe641..142eb952a29c 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c

[ ... ]

> @@ -2095,12 +2095,57 @@ static void xgbe_phy_pll_ctrl(struct xgbe_prv_data *pdata, bool enable)
>  	usleep_range(100, 200);
>  }
>
> +static bool xgbe_phy_port_is_inphi(struct xgbe_prv_data *pdata)
> +{
> +	struct xgbe_phy_data *phy_data = pdata->phy_data;
> +
> +	/* Re-driver models 4223 && 4227 are supported Inphi models */
> +	return phy_data->redrv &&
> +	       (phy_data->redrv_model == XGBE_PHY_REDRV_MODEL_4223 ||
> +		phy_data->redrv_model == XGBE_PHY_REDRV_MODEL_4227);
> +}
> +
> +void xgbe_check_kr_training_in_progress(struct xgbe_prv_data *pdata)
> +{
> +	struct xgbe_phy_data *phy_data = pdata->phy_data;
> +	unsigned long kr_timeout;
> +	int wait;
> +
> +	/* Only wait for KR training in specific conditions:
> +	 *  - Inphi re-driver is present, OR
> +	 *  - Currently in KR mode with autoneg enabled
> +	 */
> +	if (!xgbe_phy_port_is_inphi(pdata) &&
> +	    !(phy_data->cur_mode == XGBE_MODE_KR &&
> +	      pdata->phy.autoneg == AUTONEG_ENABLE))
> +		return;
> +
> +	wait = XGBE_KR_TRAINING_WAIT_ITER;
> +	while (wait--) {
> +		/* Check if we've exceeded the AN timeout window */
> +		kr_timeout = pdata->kr_start_time +
> +			msecs_to_jiffies(XGBE_AN_MS_TIMEOUT +
> +					XGBE_KR_TRAINING_WAIT_MS);
> +		if (time_after(jiffies, kr_timeout))
> +			break;
> +
> +		/* Training is complete - no need to wait */
> +		if (pdata->an_result == XGBE_AN_COMPLETE)
> +			return;
> +
> +		usleep_range(10000, 11000);
> +	}
> +}
> +
>  static void xgbe_phy_perform_ratechange(struct xgbe_prv_data *pdata,
> -					enum xgbe_mb_cmd cmd, enum xgbe_mb_subcmd sub_cmd)
> +					enum xgbe_mb_cmd cmd,
> +					enum xgbe_mb_subcmd sub_cmd)
>  {
>  	unsigned int s0 = 0;
>  	unsigned int wait;
>
> +	xgbe_check_kr_training_in_progress(pdata);
> +
>  	/* Disable PLL re-initialization during FW command processing */
>  	xgbe_phy_pll_ctrl(pdata, false);
>
> @@ -2115,7 +2160,9 @@ static void xgbe_phy_perform_ratechange(struct xgbe_prv_data *pdata,
>  	XP_SET_BITS(s0, XP_DRIVER_SCRATCH_0, COMMAND, cmd);
>  	XP_SET_BITS(s0, XP_DRIVER_SCRATCH_0, SUB_COMMAND, sub_cmd);
>
> -	/* Issue the command */
> +	/* Acquire mailbox lock for firmware command */
> +	guard(mutex)(&pdata->mailbox_lock);
> +

Can this cause a recursive deadlock? xgbe_phy_perform_ratechange() acquires
mailbox_lock, but when called with sub_cmd XGBE_MB_SUBCMD_RX_ADAP, it goes
through do_rx_adaptation which calls xgbe_phy_rx_adaptation().

xgbe_phy_rx_adaptation() has two code paths that both lead back to
xgbe_phy_perform_ratechange():

Path 1:
    xgbe_phy_rx_adaptation()
        -> xgbe_phy_rrc()
            -> xgbe_phy_perform_ratechange(pdata, XGBE_MB_CMD_RRC, ...)
                -> guard(mutex)(&pdata->mailbox_lock)  // deadlock

Path 2:
    xgbe_phy_rx_adaptation()
        -> xgbe_rx_adaptation()
            -> xgbe_set_rx_adap_mode()
                -> xgbe_phy_perform_ratechange(...)
                    -> guard(mutex)(&pdata->mailbox_lock)  // deadlock

Since kernel mutexes are not recursive, attempting to lock an already-held
mutex from the same thread causes a permanent deadlock.

>  	XP_IOWRITE(pdata, XP_DRIVER_SCRATCH_0, s0);
>  	XP_IOWRITE(pdata, XP_DRIVER_SCRATCH_1, 0);
>  	XP_IOWRITE_BITS(pdata, XP_DRIVER_INT_REQ, REQUEST, 1);

[ ... ]


