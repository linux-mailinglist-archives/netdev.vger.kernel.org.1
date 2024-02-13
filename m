Return-Path: <netdev+bounces-71299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3674852F5F
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 12:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88691C22689
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353A136AE9;
	Tue, 13 Feb 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="O+h1WphY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E183F249F3
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707823927; cv=none; b=WmeAKyQbRe36Wtx7O5zFvJUBsBG4nwIwP6BrQdIIdSDfuFhTY/ZCVZ0sR4sY+d34pEWdPNlcn5ImTZFzgfKBvSWZcMNlwgkMVPMfPsIv+oTkI7dzFn3lbU+DqEFRNr1bSPVc1hA76kN9WWgCrAKleB8dVxKepzzM5AUANhGRNeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707823927; c=relaxed/simple;
	bh=rA1inrAlUKbk9UD2xcjnO3b0XJsEiHOjanY5gy2Pt3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdIdMojKlq1ljAx8GOrWjSQV0gZsHeM4Ujbpf6Ft07IY24rUMq2Q7BVjWFFwExLWC1AT0qBeng+sv4B6ubJYIvmCoxKZCEiWhf/cf4ODUI/X8aj++DMvbPVSaXtgnxVxYHGz+l5PbNaCmMyA6wbUlzpqqGrZ0yd3xEmRGtxWsJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=O+h1WphY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4114e0a2978so10837365e9.3
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 03:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707823923; x=1708428723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M0PO875PhhAYhDyIsyAO3fJrS0i6HoS78JQscxH3CNk=;
        b=O+h1WphYZkMhuYkMbcH//2d1L4wVlXWv6+kFbd5RTC/sarxfLF+aS5aQVISKgFmYdj
         TJUOXykxkHAk82EkYJdkiqcwWi8z6X+J5NH4opwLh619yRBVv++6Kpdv9ZiSeXj2SSyw
         vlGhNfL2WKX0XHuJRPVpbew24/DGSFSIbIsat2HkpsPLbJpxZaAfzUb78Duf5q+3fSSo
         6bGFut6ojFlwDSAvKyYczvpId4kiuuY5kxfRXNDw9BlmX0PdlWSMGE9SCjgm/w/ccEEI
         leRlY8QAIVtDTPmrFVNPLolopR4ZhymuoCzKqXZt7AQ+9mzI4ciT+EnCKASpigB7NYPW
         gY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707823923; x=1708428723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0PO875PhhAYhDyIsyAO3fJrS0i6HoS78JQscxH3CNk=;
        b=mtKXfmgGkjGJbpE7zisadwy/sKyVt7OgzshMuYsWWUUhWDno/9B1FDdjZImq7MT+kc
         pVCK7DqU6TA+9WT+MLr9Vj/o7vaAMSS7zY8u1yGwTtRY+F+aPi4CWWeei1lKaDTG4Cao
         4P6Y5W6Isbs8g2ZDTfA1r7xO/D0GTE2RirF0hWCGD8956/5NalbUzMSMCHwb3O7Ht4UT
         Xrc7sVcwffrPsBNoRIyIo9vWHg2NA8BlfSWlsBCf8vK3q46wPNGGyvtvYNVPr+sDsLNw
         X1D6b32bnPfpUNwqpFYIH4nWy77NFhFewd8kJ4UWhFHtM3iOPnXKgoSdubujFD+geogp
         TMdg==
X-Gm-Message-State: AOJu0YzJvk1NI3xPrJ/peuv3Bi+xJANmgJ4vfXvutlkJwkiikcKr1Wlo
	PdEdrMUhGViYby/uDYfZ1tx0x68EpoQ1K9AJWiKn8Lf5ooKB0hWy1NW9a7Fr2ss=
X-Google-Smtp-Source: AGHT+IEgc/x4ACnJN+qqpr/xpdcr6E2ce8z1u9xzeG5MSVVhW2G4Pczb+MAitkRAxkc9X1+RSLF3sQ==
X-Received: by 2002:a05:600c:4f91:b0:410:e43d:24e9 with SMTP id n17-20020a05600c4f9100b00410e43d24e9mr3770756wmq.22.1707823923018;
        Tue, 13 Feb 2024 03:32:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXez/RU7XT8Jj/a1wuebiLAeKt5BOQsXEnaBxV8W4vI6DaCLbHsB+lJYtAZJQr67eAU5yJbj2nrcyaboRryla1nHEc8UaKzVD/grY5IU1k4sLH1uAurSArl4Hyrmfv0uTTBEub6249M0Lsxnazvg5bsB5WOHcAdV6cvci8qEMF4b0ijOY75CWBGlw5otF3KfheYN/wPmEQfsVH3gBWqChJclIMB0LBn5PhloPX8HoMPuP3Ej3YuPJomItc0xklzvFkguBcaOaX8pH5KVO2JkDZ/HE8AHJAbOFeyu97iwa8kmhxdEyg0EULAPI9uruvK+pAMg5uAvHu8nUDesv7TqteALSUfo60fxxUfkaGLK2K0jXQ6jEiZvqOvy0szbF+J2+39JkK3KkH8KERLZBV2VVTvS+kekZQY6aO95u4RbYk0B8Pl4pFu5zpYZgFZUMKYiioESNWd
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id c24-20020a05600c0ad800b004107dfa6aebsm11207098wmr.28.2024.02.13.03.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 03:32:02 -0800 (PST)
Date: Tue, 13 Feb 2024 12:31:59 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	pawel.chmielewski@intel.com, sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com, pio.raczynski@gmail.com,
	konrad.knitter@intel.com, marcin.szycik@intel.com,
	wojciech.drewek@intel.com, nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [iwl-next v1 1/7] ice: devlink PF MSI-X max and min parameter
Message-ID: <ZctTL05gEf_7XbhX@nanopsycho>
References: <20240213073509.77622-1-michal.swiatkowski@linux.intel.com>
 <20240213073509.77622-2-michal.swiatkowski@linux.intel.com>
 <ZcswSYA5GqtOb3ll@nanopsycho>
 <Zcs95HiZz5g4QUwt@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcs95HiZz5g4QUwt@mev-dev>

Tue, Feb 13, 2024 at 11:01:08AM CET, michal.swiatkowski@linux.intel.com wrote:
>On Tue, Feb 13, 2024 at 10:03:05AM +0100, Jiri Pirko wrote:
>> Tue, Feb 13, 2024 at 08:35:03AM CET, michal.swiatkowski@linux.intel.com wrote:
>> >Use generic devlink PF MSI-X parameter to allow user to change MSI-X
>> >range.
>> >
>> >Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>> >Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> >---
>> > drivers/net/ethernet/intel/ice/ice.h         |  8 ++
>> > drivers/net/ethernet/intel/ice/ice_devlink.c | 82 ++++++++++++++++++++
>> > drivers/net/ethernet/intel/ice/ice_irq.c     |  6 ++
>> > 3 files changed, 96 insertions(+)
>> >
>> >diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
>> >index c4127d5f2be3..24085f3c0966 100644
>> >--- a/drivers/net/ethernet/intel/ice/ice.h
>> >+++ b/drivers/net/ethernet/intel/ice/ice.h
>> >@@ -94,6 +94,7 @@
>> > #define ICE_MIN_LAN_TXRX_MSIX	1
>> > #define ICE_MIN_LAN_OICR_MSIX	1
>> > #define ICE_MIN_MSIX		(ICE_MIN_LAN_TXRX_MSIX + ICE_MIN_LAN_OICR_MSIX)
>> >+#define ICE_MAX_MSIX		256
>> > #define ICE_FDIR_MSIX		2
>> > #define ICE_RDMA_NUM_AEQ_MSIX	4
>> > #define ICE_MIN_RDMA_MSIX	2
>> >@@ -535,6 +536,12 @@ struct ice_agg_node {
>> > 	u8 valid;
>> > };
>> > 
>> >+struct ice_pf_msix {
>> >+	u16 cur;
>> >+	u16 min;
>> >+	u16 max;
>> >+};
>> >+
>> > struct ice_pf {
>> > 	struct pci_dev *pdev;
>> > 
>> >@@ -604,6 +611,7 @@ struct ice_pf {
>> > 	struct msi_map ll_ts_irq;	/* LL_TS interrupt MSIX vector */
>> > 	u16 max_pf_txqs;	/* Total Tx queues PF wide */
>> > 	u16 max_pf_rxqs;	/* Total Rx queues PF wide */
>> >+	struct ice_pf_msix msix;
>> > 	u16 num_lan_msix;	/* Total MSIX vectors for base driver */
>> > 	u16 num_lan_tx;		/* num LAN Tx queues setup */
>> > 	u16 num_lan_rx;		/* num LAN Rx queues setup */
>> >diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>> >index cc717175178b..b82ff9556a4b 100644
>> >--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>> >+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>> >@@ -1603,6 +1603,78 @@ enum ice_param_id {
>> > 	ICE_DEVLINK_PARAM_ID_LOOPBACK,
>> > };
>> > 
>> >+static int
>> >+ice_devlink_msix_max_pf_get(struct devlink *devlink, u32 id,
>> >+			    struct devlink_param_gset_ctx *ctx)
>> >+{
>> >+	struct ice_pf *pf = devlink_priv(devlink);
>> >+
>> >+	ctx->val.vu16 = pf->msix.max;
>> >+
>> >+	return 0;
>> >+}
>> >+
>> >+static int
>> >+ice_devlink_msix_max_pf_set(struct devlink *devlink, u32 id,
>> >+			    struct devlink_param_gset_ctx *ctx)
>> >+{
>> >+	struct ice_pf *pf = devlink_priv(devlink);
>> >+	u16 max = ctx->val.vu16;
>> >+
>> >+	pf->msix.max = max;
>> 
>> What's permanent about this exactly?
>> 
>
>I want to store the value here after driver reinit. Isn't it enough to
>use this parameter type? Which one should be used for this purpose?

Documentation/networking/devlink/devlink-params.rst say:

.. list-table:: Possible configuration modes
   :widths: 5 90

   * - Name
     - Description
   * - ``runtime``
     - set while the driver is running, and takes effect immediately. No
       reset is required.
   * - ``driverinit``
     - applied while the driver initializes. Requires the user to restart
       the driver using the ``devlink`` reload command.
   * - ``permanent``
     - written to the device's non-volatile memory. A hard reset is required
       for it to take effect.


[...]

