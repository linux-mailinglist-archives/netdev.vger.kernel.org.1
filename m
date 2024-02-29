Return-Path: <netdev+bounces-76255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192E586D034
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF902843BD
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D5C4AEFA;
	Thu, 29 Feb 2024 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="V7j+Fdvp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744996CBE3
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226719; cv=none; b=aq1d4593YVv49CvpUacmaxt3grWtKrNVh3fGmAE0yq0/zE2qmJaTyBa/VXUpxsg7ikMmv2IGHa+iDE0f6IDUQgdICNLDI1zCuRQlFzRXluOqJu9JO1MmpU94ZPP/eGhENffL+/uezeyc6CcM4MxpZrWGj7SHTKu2ilsCQC8/m0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226719; c=relaxed/simple;
	bh=p86JPbWlAAq/Pr2OfGMi2zSo0jei99EzmjU+Zsm+4Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoorIDCdZNy+PCitftMkU4s58IUEttumKiMBaAFhJcBDmbotlgRLJxIpUbnvuB5RnQKDpTjr3aOmSfFcdxjv46IRc76Pgs7DmUb1al/jQDG4oJoIldG0xdwpdmuIsaPWeT+d/1ZC+ymHzn3wmOZRta3F4g57ZvkyE9Gxqhe67kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=V7j+Fdvp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d6f26ff33so737587f8f.0
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 09:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709226713; x=1709831513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s5eN8ce01A8BAkNdozuKOgaWIKTHka0I2pmhvQwmmHs=;
        b=V7j+FdvpUIFwX9dCnFPY0zkWFe5LNN8reuSgzMtz8u/VKP+MoXEKa+SuW0EZZG8dUO
         qVYKAvY5/mNup0gwUOpX4YkAFT3xLNRBFHWErifQLqEwokQCAXG6nWuLCNdwPbIzEpcm
         8VfuRXxd9TFZKorOEuJOo1LOOgRLFmNd1//s8DM/s/lt/UNd3nStn8uTUwjUGWC3bNjM
         63IqbgYJAOOcTCDkfvlVTbbdLeCDh9xQ6FHswl5+jgIMC2v0Ga143Ig1wBd8zyE9nBhU
         r1PLSTTwZpR3hRjG7PzIs4lyDNj8GKoRymWerde9GuX+y3/JPzsSNSABJXdkzCu1S/B2
         besw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709226713; x=1709831513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5eN8ce01A8BAkNdozuKOgaWIKTHka0I2pmhvQwmmHs=;
        b=dToJJNZ5W19S1+0NGmBD+85Lb4WJS4nuJGaqnWFoNma4aoO4jsOTRZednkICbFk2nL
         87VnJ9uzn61983HqC+arqWNjrsV/FLjIhGWBWqhYooBswBm+gdaeF2t0rKBPkQ5JAQzM
         EGzPszPkkN2fpIbkYelu2i/y7SiXqyTJtkxemr++YtDBXAIkTksL+iPWG6cEErn5RRQR
         Plin9dl+sVuwBsWbKSmUeSlhVB0j8ACaZR9y7XPR8Qe+nIXYVENyb0Er75sLBoIUztIQ
         VKkHyNjZKynDVmqj9DQrJJv9KWhUWLqNgKVsALHWJPlM8fQx8jmZN4Cp9DOBZGzjFBMS
         PceA==
X-Forwarded-Encrypted: i=1; AJvYcCXJpPuT0MuiAGLcl9uFtuQxVFWLyqJH7UJ1oKpNu+iGe3+FSg8lcwrio5et4adKse2vp4PKgUYh5avKg9ydPnaAvf0z7oAC
X-Gm-Message-State: AOJu0YzcTIBTKLiwruQwbObRT3imwzh7lwKEJxfJr85h0CoFSxNqc2Yp
	9aDptzfs+DYtF4GMNXKTSUDPxTTG9ANzewazbq+4daqmKvd15+kWRBFlVsEnWqU=
X-Google-Smtp-Source: AGHT+IH1zEuJ86P10M2lAIVIYyql0ngHGu3kWSlbRqz+Hk6flSRnX9pE+3LpyAZr9/9QnUzu3VoEEA==
X-Received: by 2002:adf:e7c1:0:b0:33d:9eef:4f25 with SMTP id e1-20020adfe7c1000000b0033d9eef4f25mr1910315wrn.51.1709226713513;
        Thu, 29 Feb 2024 09:11:53 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d6309000000b0033e122a9a91sm1645422wru.105.2024.02.29.09.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 09:11:52 -0800 (PST)
Date: Thu, 29 Feb 2024 18:11:49 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com, richardcochran@gmail.com
Subject: Re: [PATCH net-next 1/2] bnxt_en: Introduce devlink runtime driver
 param to set ptp tx timeout
Message-ID: <ZeC61UannrX8sWDk@nanopsycho>
References: <20240229070202.107488-1-michael.chan@broadcom.com>
 <20240229070202.107488-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229070202.107488-2-michael.chan@broadcom.com>

Thu, Feb 29, 2024 at 08:02:01AM CET, michael.chan@broadcom.com wrote:
>From: Pavan Chebbi <pavan.chebbi@broadcom.com>
>
>Sometimes, the current 1ms value that driver waits for firmware
>to obtain a tx timestamp for a PTP packet may not be sufficient.
>User may want the driver to wait for a longer custom period before
>timing out.
>
>Introduce a new runtime driver param for devlink "ptp_tx_timeout".
>Using this parameter the driver can wait for up to the specified
>time, when it is querying for a TX timestamp from firmware.  By
>default the value is set to 1s.
>
>Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
>Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
>Signed-off-by: Michael Chan <michael.chan@broadcom.com>
>---
> .../net/ethernet/broadcom/bnxt/bnxt_devlink.c | 42 +++++++++++++++++++
> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c |  1 +
> drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h |  3 ++
> 3 files changed, 46 insertions(+)
>
>diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
>index ae4529c043f0..0df0baa9d18c 100644
>--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
>+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
>@@ -652,6 +652,7 @@ static const struct devlink_ops bnxt_vf_dl_ops;
> enum bnxt_dl_param_id {
> 	BNXT_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
> 	BNXT_DEVLINK_PARAM_ID_GRE_VER_CHECK,
>+	BNXT_DEVLINK_PARAM_ID_PTP_TXTS_TMO,
> };
> 
> static const struct bnxt_dl_nvm_param nvm_params[] = {
>@@ -1077,6 +1078,42 @@ static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param_id, void *msg,
> 	return rc;
> }
> 
>+static int bnxt_dl_ptp_param_get(struct devlink *dl, u32 id,
>+				 struct devlink_param_gset_ctx *ctx)
>+{
>+	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
>+
>+	if (!bp->ptp_cfg)
>+		return -EOPNOTSUPP;
>+
>+	ctx->val.vu32 = bp->ptp_cfg->txts_tmo;
>+	return 0;
>+}
>+
>+static int bnxt_dl_ptp_param_set(struct devlink *dl, u32 id,
>+				 struct devlink_param_gset_ctx *ctx)
>+{
>+	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
>+
>+	if (!bp->ptp_cfg)
>+		return -EOPNOTSUPP;
>+
>+	bp->ptp_cfg->txts_tmo = ctx->val.vu32;
>+	return 0;
>+}
>+
>+static int bnxt_dl_ptp_param_validate(struct devlink *dl, u32 id,
>+				      union devlink_param_value val,
>+				      struct netlink_ext_ack *extack)
>+{
>+	if (val.vu32 > BNXT_PTP_MAX_TX_TMO) {
>+		NL_SET_ERR_MSG_FMT_MOD(extack, "TX timeout value exceeds the maximum (%d ms)",
>+				       BNXT_PTP_MAX_TX_TMO);
>+		return -EINVAL;
>+	}
>+	return 0;
>+}
>+
> static int bnxt_dl_nvm_param_get(struct devlink *dl, u32 id,
> 				 struct devlink_param_gset_ctx *ctx)
> {
>@@ -1180,6 +1217,11 @@ static const struct devlink_param bnxt_dl_params[] = {
> 			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
> 			     bnxt_dl_nvm_param_get, bnxt_dl_nvm_param_set,
> 			     NULL),
>+	DEVLINK_PARAM_DRIVER(BNXT_DEVLINK_PARAM_ID_PTP_TXTS_TMO,
>+			     "ptp_tx_timeout", DEVLINK_PARAM_TYPE_U32,
>+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
>+			     bnxt_dl_ptp_param_get, bnxt_dl_ptp_param_set,
>+			     bnxt_dl_ptp_param_validate),

Idk. This does not look sane to me at all. Will we have custom knobs to
change timeout for arbitrary FW commands as this as a common thing?
Driver is the one to take care of timeouts of FW gracefully, he should
know the FW, not the user. Therefore exposing user knobs like this
sounds pure wrong to me.

nack for adding this to devlink.

If this is some maybe-to-be-common ptp thing, can that be done as part
of ptp api perhaps?

pw-bot: cr


> 	/* keep REMOTE_DEV_RESET last, it is excluded based on caps */
> 	DEVLINK_PARAM_GENERIC(ENABLE_REMOTE_DEV_RESET,
> 			      BIT(DEVLINK_PARAM_CMODE_RUNTIME),
>diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>index cc07660330f5..4b50b07b9771 100644
>--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>@@ -965,6 +965,7 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
> 		spin_unlock_bh(&ptp->ptp_lock);
> 		ptp_schedule_worker(ptp->ptp_clock, 0);
> 	}
>+	ptp->txts_tmo = BNXT_PTP_DFLT_TX_TMO;
> 	return 0;
> 
> out:
>diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
>index fce8dc39a7d0..ee977620d33e 100644
>--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
>+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
>@@ -22,6 +22,8 @@
> #define BNXT_LO_TIMER_MASK	0x0000ffffffffUL
> #define BNXT_HI_TIMER_MASK	0xffff00000000UL
> 
>+#define BNXT_PTP_DFLT_TX_TMO	1000 /* ms */
>+#define BNXT_PTP_MAX_TX_TMO	5000 /* ms */
> #define BNXT_PTP_QTS_TIMEOUT	1000
> #define BNXT_PTP_QTS_TX_ENABLES	(PORT_TS_QUERY_REQ_ENABLES_PTP_SEQ_ID |	\
> 				 PORT_TS_QUERY_REQ_ENABLES_TS_REQ_TIMEOUT | \
>@@ -120,6 +122,7 @@ struct bnxt_ptp_cfg {
> 
> 	u32			refclk_regs[2];
> 	u32			refclk_mapped_regs[2];
>+	u32			txts_tmo;
> };
> 
> #if BITS_PER_LONG == 32
>-- 
>2.30.1
>



