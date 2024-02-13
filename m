Return-Path: <netdev+bounces-71229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2CC852BEC
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E631C20D97
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62281B7EB;
	Tue, 13 Feb 2024 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Hh0kURNr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C949225A4
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815244; cv=none; b=fjMB1jVYgIyziz8mTDj58zioTluScvENpajuvi27ZxUSG2UGcPyao7LfJ1DF9klfLgqFydM58MPCJGgHmUmB1SLBWNvjRrrZePf5VhblgHMwIJloRa/Gz1mZJ8Pg9aFIka1jGITCLT1AVUelzRit2ebGwUFYw/e7tln3WVsF4wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815244; c=relaxed/simple;
	bh=fUq96z65R9AzDPb9NCabKbffXQSpCOIFqFfzirPKR6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbgUyjDpMYT0I7f8THDsJ6sxF25VtBdhuJZvWceqglvysbv6byiuTtRYmt1dyszC5xkS4tWV3JnI/NouQ2q3pguarEmCDHsGjJihNf41NbREHRp4ZHDIJqbvjnuHJtqCG7GHI+7OmmlnLkdvlaJAeavxKNPRRGCmdq/oHYn9+ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Hh0kURNr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3d0d26182dso25660366b.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707815240; x=1708420040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ffmqna1eQFY7XCg1bFJY3BzV7/JNB64CH2MEWM1SEao=;
        b=Hh0kURNrQ9OSFXUbDXUFHbOEB83vDWfB53YXU839wFodhF8rB8/Q5ZHv89oZv9OBIH
         oCEYo7+Y1yBdQyPWMHTviNfiXKZ+Zia2UcCGmkIdmznAFtddw09x/xfXaL5iOOwWucRF
         8AAaea2MZNYIgE5NiYAXPGC2PcdT9dhhK2/xbtrCp7YzDpHpkIKs18StWsUgR5jiRCIw
         pEG9q+0joHDSQfShcVqsMvsy+SJ9gpdq18es57G0TdpJi1mbHuYI1omqzzh0bd5GMhpE
         ZZFHqigHpW72Lht/vOKKHbEyQnOlNnAsIfoKEL2D+C8glqxLAacg7ci9Xb7zBtgMBdHJ
         LdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707815240; x=1708420040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ffmqna1eQFY7XCg1bFJY3BzV7/JNB64CH2MEWM1SEao=;
        b=Z2ROJ4ilpDJr4d+hB7xWAkYKVLq9zmTldJWz1+vwkHZDNbwxxesE88a6fe79lB5ESM
         vobP4JG0ypClHYS3S3yiJpXkqAR18JLol5ZQeoWrOMNKfYbCcDyfWcbwqT7dTRXj802E
         RyVB45UwFnhsK30H+c5VghoQlszri5UkIsU1WG5zmIIlTXVKrBWa+Lw/B8Wyt5d4kGAS
         hU0UO76YQsz5FLX5bPQJDc11RXRbIQACM8qfRqGFsb0ZhE851Ck6jXJbM7Co6u7k2G37
         /fUIrz7rlr/QhiV8FMXuHMe29ctfM0/kwEwL7L8c0llRxO3/MuUTO5LI7mFUwXcCysHy
         7tBw==
X-Gm-Message-State: AOJu0YygbSLgqqYGF9TR6sA+pXJxTKeIaKDkVPPejD1V4Pak3eq6idvk
	TAe7Vahv29NneNCYGiwcFfz3RUwRv2pAsgWHmKGiTTRfeQ2P5uBYSkYvKL8qDfg=
X-Google-Smtp-Source: AGHT+IHcMNYSPv3TFmzsr88My6TJDfmBtLt4LLJ/x425cm8XpRVWxNRqsM04X921LBX5Ywt+xIICtg==
X-Received: by 2002:a17:906:24d8:b0:a3d:1457:446 with SMTP id f24-20020a17090624d800b00a3d14570446mr357503ejb.54.1707815240574;
        Tue, 13 Feb 2024 01:07:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtE76QMANdSm1O2nRZA21Hdn+XmNYaeFVUB338l0GJUsr92Naxy9O11SIbXIOu5ek+3pJ/ZIyJ9n8mhnjQ0HDDl0pzBST3VLWJ2oDNKD9rZm3db2+yUhPcJFSOzn7Rrf0V9OzhB97dyRIKse0LeIuHuljfvHmEx3TdlJ2eal/5avIzOFcR823ygH3OLlXdXIhM+VOfh7vAbOU2nSTNc9FLqyHn68ee4r2NQAo3zxqr+0abQWm2IGwGxgj45/s5r1vKJScPLFB6xBcv5PvPF2Z20WGN6CUGzsD4x5aoLH32uGayOFPOx0pE4j3UnzpSE2RN/Iy3/3HwtCOzEynk0RssX98N7LiYc/86ONpe6S/vyTdz4DoCUD1pKfJUDf7k2acIVDs9A13w6KkW2Cv5sPx7McPiL56JXG438n38VoH2rS+lf73r+EdEL3+v6MJ15Ctwpt0Oy9gPdVcT7g3I04B7GiepZk4y6bWdRxejBO8=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id qb8-20020a1709077e8800b00a3ccd1c7424sm1076247ejc.132.2024.02.13.01.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:07:20 -0800 (PST)
Date: Tue, 13 Feb 2024 10:07:17 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, pio.raczynski@gmail.com,
	konrad.knitter@intel.com, marcin.szycik@intel.com,
	wojciech.drewek@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com,
	Jan Sokolowski <jan.sokolowski@intel.com>
Subject: Re: [iwl-next v1 6/7] ice: enable_rdma devlink param
Message-ID: <ZcsxRRrVvnhjLxn3@nanopsycho>
References: <20240213073509.77622-1-michal.swiatkowski@linux.intel.com>
 <20240213073509.77622-7-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213073509.77622-7-michal.swiatkowski@linux.intel.com>

Tue, Feb 13, 2024 at 08:35:08AM CET, michal.swiatkowski@linux.intel.com wrote:
>Implement enable_rdma devlink parameter to allow user to turn RDMA
>feature on and off.
>
>It is useful when there is no enough interrupts and user doesn't need
>RDMA feature.
>
>Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_devlink.c | 32 ++++++++++++++++++--
> drivers/net/ethernet/intel/ice/ice_lib.c     |  8 ++++-
> drivers/net/ethernet/intel/ice/ice_main.c    | 18 +++++------
> 3 files changed, 45 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>index b82ff9556a4b..4f048268db72 100644
>--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>@@ -1675,6 +1675,19 @@ ice_devlink_msix_min_pf_validate(struct devlink *devlink, u32 id,
> 	return 0;
> }
> 
>+static int ice_devlink_enable_rdma_validate(struct devlink *devlink, u32 id,
>+					    union devlink_param_value val,
>+					    struct netlink_ext_ack *extack)
>+{
>+	struct ice_pf *pf = devlink_priv(devlink);
>+	bool new_state = val.vbool;
>+
>+	if (new_state && !test_bit(ICE_FLAG_RDMA_ENA, pf->flags))
>+		return -EOPNOTSUPP;
>+
>+	return 0;
>+}
>+
> static const struct devlink_param ice_devlink_params[] = {
> 	DEVLINK_PARAM_GENERIC(ENABLE_ROCE, BIT(DEVLINK_PARAM_CMODE_RUNTIME),
> 			      ice_devlink_enable_roce_get,
>@@ -1700,6 +1713,8 @@ static const struct devlink_param ice_devlink_params[] = {
> 			      ice_devlink_msix_min_pf_get,
> 			      ice_devlink_msix_min_pf_set,
> 			      ice_devlink_msix_min_pf_validate),
>+	DEVLINK_PARAM_GENERIC(ENABLE_RDMA, BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
>+			      NULL, NULL, ice_devlink_enable_rdma_validate),
> };
> 
> static void ice_devlink_free(void *devlink_ptr)
>@@ -1776,9 +1791,22 @@ ice_devlink_set_switch_id(struct ice_pf *pf, struct netdev_phys_item_id *ppid)
> int ice_devlink_register_params(struct ice_pf *pf)
> {
> 	struct devlink *devlink = priv_to_devlink(pf);
>+	union devlink_param_value value;
>+	int err;
>+
>+	err = devlink_params_register(devlink, ice_devlink_params,

Interesting, can't you just take the lock before this and call
devl_params_register()?

Moreover, could you please fix your init/cleanup paths for hold devlink
instance lock the whole time?


pw-bot: cr


>+				      ARRAY_SIZE(ice_devlink_params));
>+	if (err)
>+		return err;
> 
>-	return devlink_params_register(devlink, ice_devlink_params,
>-				       ARRAY_SIZE(ice_devlink_params));
>+	devl_lock(devlink);
>+	value.vbool = test_bit(ICE_FLAG_RDMA_ENA, pf->flags);
>+	devl_param_driverinit_value_set(devlink,
>+					DEVLINK_PARAM_GENERIC_ID_ENABLE_RDMA,
>+					value);
>+	devl_unlock(devlink);
>+
>+	return 0;
> }
> 
> void ice_devlink_unregister_params(struct ice_pf *pf)
>diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
>index a30d2d2b51c1..4d5c3d699044 100644
>--- a/drivers/net/ethernet/intel/ice/ice_lib.c
>+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
>@@ -829,7 +829,13 @@ bool ice_is_safe_mode(struct ice_pf *pf)
>  */
> bool ice_is_rdma_ena(struct ice_pf *pf)
> {
>-	return test_bit(ICE_FLAG_RDMA_ENA, pf->flags);
>+	union devlink_param_value value;
>+	int err;
>+
>+	err = devl_param_driverinit_value_get(priv_to_devlink(pf),
>+					      DEVLINK_PARAM_GENERIC_ID_ENABLE_RDMA,
>+					      &value);
>+	return err ? false : value.vbool;
> }
> 
> /**
>diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>index 824732f16112..4dd59d888ec7 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main.c
>+++ b/drivers/net/ethernet/intel/ice/ice_main.c
>@@ -5177,23 +5177,21 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
> 	if (err)
> 		goto err_init;
> 
>+	err = ice_init_devlink(pf);
>+	if (err)
>+		goto err_init_devlink;
>+
> 	devl_lock(priv_to_devlink(pf));
> 	err = ice_load(pf);
> 	devl_unlock(priv_to_devlink(pf));
> 	if (err)
> 		goto err_load;
> 
>-	err = ice_init_devlink(pf);
>-	if (err)
>-		goto err_init_devlink;
>-
> 	return 0;
> 
>-err_init_devlink:
>-	devl_lock(priv_to_devlink(pf));
>-	ice_unload(pf);
>-	devl_unlock(priv_to_devlink(pf));
> err_load:
>+	ice_deinit_devlink(pf);
>+err_init_devlink:
> 	ice_deinit(pf);
> err_init:
> 	pci_disable_device(pdev);
>@@ -5290,12 +5288,12 @@ static void ice_remove(struct pci_dev *pdev)
> 	if (!ice_is_safe_mode(pf))
> 		ice_remove_arfs(pf);
> 
>-	ice_deinit_devlink(pf);
>-
> 	devl_lock(priv_to_devlink(pf));
> 	ice_unload(pf);
> 	devl_unlock(priv_to_devlink(pf));
> 
>+	ice_deinit_devlink(pf);
>+
> 	ice_deinit(pf);
> 	ice_vsi_release_all(pf);
> 
>-- 
>2.42.0
>
>

