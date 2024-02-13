Return-Path: <netdev+bounces-71228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DC1852BDD
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D701C21718
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 09:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EA41B7E2;
	Tue, 13 Feb 2024 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jAM5pc/L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883B5225A8
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814993; cv=none; b=uo4U6hq3MyumwVgH7inaS/q1lOyf5LVXcwjV7fQ2LIYUS09uCkPLLk6L8RVK/w7/kWSzA+4G6Qwt3nOtXnO5XcozmNNvs/X4le/9e5Q5KbnGgCTsboczP6k4Jd0mMGyB/WEMBmknuIg/wSFuGWQPk7MkvI9b+msliIzN0bx00r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814993; c=relaxed/simple;
	bh=usvP9nS/d9ZIdp/L596z5VdW6uQvum1YnGN4xQAZeuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAkWU6cub7DcwK6ja0wHl+PyaQ7kR/1O7Wt3dJ2W+kFTywq3qnTKNKQYed3o0k3Ue6WkWbKdaFLhsb8fAjoPvrY2AUkJELYb+KSiuuRuFzeYLt1PH2kFbrCCe7jL48quHlsgnMr8NQ3RfSZWY+8lXlS4FJO0XXKAEt7zSwFsPHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=jAM5pc/L; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55790581457so6259112a12.3
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707814990; x=1708419790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j5ArfzYXN0Gx+Is8EX0U/hVLoCA2YC09SY9D27ZQazs=;
        b=jAM5pc/LvX+vdj058Mom2cWLnt8VDFjp4KbHOxPJNS8pwCuAu1Vbp/gRYgYTDO4xaX
         21aQhMBEtynUDx5uRe4R1mRW5xk7sa8k93i7pahj4KsHCljXezPjlK3aTWE2ikeIhcJF
         jaujI4MdUqWI4R5lvz4c9ZvdEX3UgaQrx95rXMejka5iiLxsG5b9gfrdY1V57CR1Vf/V
         GF2kvf1KN85mTFTXPoejb1aRfuWPh77iZC8WMxkiS1usysBVdV4vYxziXLVg472w5SiK
         JDvlR16oG+7M2AF0JXAEeEMOP9iCVETv29isDi1amVdRzOgHm0Eq/IzL55jdEGtjdDo1
         bTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707814990; x=1708419790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5ArfzYXN0Gx+Is8EX0U/hVLoCA2YC09SY9D27ZQazs=;
        b=gSV3daU8eaw/pZDKEDxtSptY/8a1lww9Speur5HV7kGBZ5ndKNUdqq9rJRMQrZm9D/
         Poa9S12kBaBCFUd3eI0/J9NeLevAOaXub6mKLdCBXt91k9VIeSxNELq11bNDnvO0p5Sa
         EJQhnsk+sWwlaVwcV6RxzTAEkYIKV8XUvIBVpwXUKfa0gqzlWHkPtshig1PYb7IxE0Te
         8AJ9Lag4Gh4EpZh3g5QypDHfE7w6rf1/woUkNPCqjwnEwcllOwgeEUCqmZNG+4ESmxk1
         rPMdIpHFHO0avtPV447ZrzScDAvv4HZggZa8uXjiSYHs2+knFrDAaO9tPSUupxE4lmLG
         dqBA==
X-Gm-Message-State: AOJu0YwIjgwXnwlyh1Jrz98BFNbhp9DfbiPvtr+E+Hemk3NK6fkHjQHZ
	QsZnzw8SijJ/mdHS4frK7EgZ9QNxygtlLXQVAOd7ngilsgQQFEJfmIDaOwHZyLI=
X-Google-Smtp-Source: AGHT+IEUMKS5DtBbjBuFJ3GMudR12YrlAEVgDNF/7K45EDBfnS3CdK/DuVoSgtJ3+1ph0PaoH70unQ==
X-Received: by 2002:aa7:d7c9:0:b0:55f:f7bb:40fd with SMTP id e9-20020aa7d7c9000000b0055ff7bb40fdmr7531816eds.2.1707814989618;
        Tue, 13 Feb 2024 01:03:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXScrc9CW4/rq1Jdgxfe7VslxByeyTKI1/PwlqoVt62PQ8jmB6LnNmaxdfyV7H7yXJ7/G2InJH98OnUjYP82uyouKN17CWuwSk8aTKG0zDxs0Zgcn4w+SWOdcbjvtAQKXzathJdiMmjEObiKi7mrq2VbeJRYQUNzpr5FqLRIGaVSUNuHXF9Tun/Qu0jFrahiyQXzh0nn30JE9KD5f4m7FV8nSoVEiyy6IaU5toIc6bU3QH1dtPgLYCeqlBjL08QH8E0qORJ6/2pGm0YP5E1kuZb6KzGV2D2S7j5Ebgfu+dpnaxmelw75vLW+huZNj0iYqmOP2uR3QI8yiscClmCMiy4lT+3v7gzmtlqyiOaugoFpdiP8tJ5rQ0vhpHECwHaQH/YFUfSaBpzWiV4y3ycUuTQKlNG6t59ycYFAeGn1siVcsRKY3EM3h3VLZmx5Lw6SaV1MW/9
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id e8-20020a056402148800b0055ff9299f71sm3545447edv.46.2024.02.13.01.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:03:09 -0800 (PST)
Date: Tue, 13 Feb 2024 10:03:05 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, pio.raczynski@gmail.com,
	konrad.knitter@intel.com, marcin.szycik@intel.com,
	wojciech.drewek@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [iwl-next v1 1/7] ice: devlink PF MSI-X max and min parameter
Message-ID: <ZcswSYA5GqtOb3ll@nanopsycho>
References: <20240213073509.77622-1-michal.swiatkowski@linux.intel.com>
 <20240213073509.77622-2-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213073509.77622-2-michal.swiatkowski@linux.intel.com>

Tue, Feb 13, 2024 at 08:35:03AM CET, michal.swiatkowski@linux.intel.com wrote:
>Use generic devlink PF MSI-X parameter to allow user to change MSI-X
>range.
>
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice.h         |  8 ++
> drivers/net/ethernet/intel/ice/ice_devlink.c | 82 ++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_irq.c     |  6 ++
> 3 files changed, 96 insertions(+)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
>index c4127d5f2be3..24085f3c0966 100644
>--- a/drivers/net/ethernet/intel/ice/ice.h
>+++ b/drivers/net/ethernet/intel/ice/ice.h
>@@ -94,6 +94,7 @@
> #define ICE_MIN_LAN_TXRX_MSIX	1
> #define ICE_MIN_LAN_OICR_MSIX	1
> #define ICE_MIN_MSIX		(ICE_MIN_LAN_TXRX_MSIX + ICE_MIN_LAN_OICR_MSIX)
>+#define ICE_MAX_MSIX		256
> #define ICE_FDIR_MSIX		2
> #define ICE_RDMA_NUM_AEQ_MSIX	4
> #define ICE_MIN_RDMA_MSIX	2
>@@ -535,6 +536,12 @@ struct ice_agg_node {
> 	u8 valid;
> };
> 
>+struct ice_pf_msix {
>+	u16 cur;
>+	u16 min;
>+	u16 max;
>+};
>+
> struct ice_pf {
> 	struct pci_dev *pdev;
> 
>@@ -604,6 +611,7 @@ struct ice_pf {
> 	struct msi_map ll_ts_irq;	/* LL_TS interrupt MSIX vector */
> 	u16 max_pf_txqs;	/* Total Tx queues PF wide */
> 	u16 max_pf_rxqs;	/* Total Rx queues PF wide */
>+	struct ice_pf_msix msix;
> 	u16 num_lan_msix;	/* Total MSIX vectors for base driver */
> 	u16 num_lan_tx;		/* num LAN Tx queues setup */
> 	u16 num_lan_rx;		/* num LAN Rx queues setup */
>diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>index cc717175178b..b82ff9556a4b 100644
>--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>@@ -1603,6 +1603,78 @@ enum ice_param_id {
> 	ICE_DEVLINK_PARAM_ID_LOOPBACK,
> };
> 
>+static int
>+ice_devlink_msix_max_pf_get(struct devlink *devlink, u32 id,
>+			    struct devlink_param_gset_ctx *ctx)
>+{
>+	struct ice_pf *pf = devlink_priv(devlink);
>+
>+	ctx->val.vu16 = pf->msix.max;
>+
>+	return 0;
>+}
>+
>+static int
>+ice_devlink_msix_max_pf_set(struct devlink *devlink, u32 id,
>+			    struct devlink_param_gset_ctx *ctx)
>+{
>+	struct ice_pf *pf = devlink_priv(devlink);
>+	u16 max = ctx->val.vu16;
>+
>+	pf->msix.max = max;

What's permanent about this exactly?


>+
>+	return 0;
>+}
>+
>+static int
>+ice_devlink_msix_max_pf_validate(struct devlink *devlink, u32 id,
>+				 union devlink_param_value val,
>+				 struct netlink_ext_ack *extack)
>+{
>+	if (val.vu16 > ICE_MAX_MSIX) {
>+		NL_SET_ERR_MSG_MOD(extack, "PF max MSI-X is too high");
>+		return -EINVAL;
>+	}
>+
>+	return 0;
>+}
>+
>+static int
>+ice_devlink_msix_min_pf_get(struct devlink *devlink, u32 id,
>+			    struct devlink_param_gset_ctx *ctx)
>+{
>+	struct ice_pf *pf = devlink_priv(devlink);
>+
>+	ctx->val.vu16 = pf->msix.min;
>+
>+	return 0;
>+}
>+
>+static int
>+ice_devlink_msix_min_pf_set(struct devlink *devlink, u32 id,
>+			    struct devlink_param_gset_ctx *ctx)
>+{
>+	struct ice_pf *pf = devlink_priv(devlink);
>+	u16 min = ctx->val.vu16;
>+
>+	pf->msix.min = min;

What's permanent about this exactly?


>+
>+	return 0;
>+}
>+
>+static int
>+ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
>+				 union devlink_param_value val,
>+				 struct netlink_ext_ack *extack)
>+{
>+	if (val.vu16 <= ICE_MIN_MSIX) {
>+		NL_SET_ERR_MSG_MOD(extack, "PF min MSI-X is too low");
>+		return -EINVAL;
>+	}
>+
>+	return 0;
>+}
>+
> static const struct devlink_param ice_devlink_params[] = {
> 	DEVLINK_PARAM_GENERIC(ENABLE_ROCE, BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> 			      ice_devlink_enable_roce_get,
>@@ -1618,6 +1690,16 @@ static const struct devlink_param ice_devlink_params[] = {
> 			     ice_devlink_loopback_get,
> 			     ice_devlink_loopback_set,
> 			     ice_devlink_loopback_validate),
>+	DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MAX,
>+			      BIT(DEVLINK_PARAM_CMODE_PERMANENT),
>+			      ice_devlink_msix_max_pf_get,
>+			      ice_devlink_msix_max_pf_set,
>+			      ice_devlink_msix_max_pf_validate),
>+	DEVLINK_PARAM_GENERIC(MSIX_VEC_PER_PF_MIN,
>+			      BIT(DEVLINK_PARAM_CMODE_PERMANENT),

....


pw-bot: cr


>+			      ice_devlink_msix_min_pf_get,
>+			      ice_devlink_msix_min_pf_set,
>+			      ice_devlink_msix_min_pf_validate),
> };
> 
> static void ice_devlink_free(void *devlink_ptr)
>diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
>index ad82ff7d1995..fa7178a68b94 100644
>--- a/drivers/net/ethernet/intel/ice/ice_irq.c
>+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
>@@ -254,6 +254,12 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
> 	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
> 	int vectors, max_vectors;
> 
>+	/* load default PF MSI-X range */
>+	if (!pf->msix.min)
>+		pf->msix.min = ICE_MIN_MSIX;
>+	if (!pf->msix.max)
>+		pf->msix.max = total_vectors / 2;
>+
> 	vectors = ice_ena_msix_range(pf);
> 
> 	if (vectors < 0)
>-- 
>2.42.0
>
>

