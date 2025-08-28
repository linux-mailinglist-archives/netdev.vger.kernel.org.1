Return-Path: <netdev+bounces-217756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F209B39BDB
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3CEA1C238C6
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C11430E0FF;
	Thu, 28 Aug 2025 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="phxQHyyR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDC530E85A
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381404; cv=none; b=J1QEO92K/gkmr59EO+m271ftusMWRo1qxSngcGpo0dLXkkMtx3Kona8YwhwTtD4Ra+8g0l7YaQ+YykSGr8Th0YHfYIUj5hsKbD57FUeykpBQlt8vHPJO4HBJ1AYQk4dwaR5ZY0uSYY0Jwm4DdBlJpqbDMrto0C51mhinRfd6eU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381404; c=relaxed/simple;
	bh=/GYKhU7LOws9JatgpRFjGVQ6UqWLEhWUQCwyHOycCQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4KFa1+/BNEcaqi8bEP6UPeV3o9juZSyaSGt/ew3eLmTqzuoAWYgXN9BMr+ppYQxA7yEM+0NXyZ8LX0JkjXMp0NkLW9Trt6eQwK0g05UITCe4HZnhi1vuG0VoYUCNhHoWthPNWsTZ5eYcdP6S9oW89rYlo+6+Mf+v+pfZZw43mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=phxQHyyR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c6ae25978bso642203f8f.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 04:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1756381399; x=1756986199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=At/+UKG7o7s9yjCycozJFd+LEEjzdxgvXyjaRDSFnb8=;
        b=phxQHyyR8HqNWfGC3v/bWXoVqNAIroSh+pcAdeJfGWJjr8u5KfoHSt9s9oyzl3DIVy
         Husrad/8Q9mTaMTkbPapvOtoTjjTXMjELHogOqvyxH9pUHYx1kJB7d4ROH50NjIu7JTv
         1/yCE6Q4ocEQw/eQag4VCD4qDSqH4bGH1vv3pCWeTrPpANKragyqa6RKq3ik4/FCxanv
         ZuD8BjNQvCoCOFXxlAgGXSJncpusMgmt6T78+bjmv13ga0qeXCYO9+UV6qU02TQu0Mgo
         pXrrAMZQ4VIhDkGuZIfxZF1ZKdVmDBC/4OUgeZIBSQqq5N2u9ljdRJzCLEsgEft8xD2x
         k+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756381399; x=1756986199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At/+UKG7o7s9yjCycozJFd+LEEjzdxgvXyjaRDSFnb8=;
        b=KPozQGgki8gu856W3/b1KyCs28DSBdgNmNv4wzCKbv/ZHTj4tY3bgYJsVbuvP+WmWr
         5eXGYUZJd6imO6By2tKawiZt0BLeCiaUEFo7R31XALfUhklMxGlzUAoXXzQAufPI11yt
         Tt7KrJ9s3MnaDWmmyGDLz9XGLbyrzduAnRd3fXsAO7+5ACuIJ42ggUVWgO6waBazs9eG
         UPA5Fe0NHr8fxnGanqHqtgNSNjOluZrm++BoNzZ50ty/TQFRjuSxympCesX1BRDmpQtY
         Lax0rpNm/5U8OP1owI4A2OsSIwGnGNNxMxlPuFU2GbQi8QAlQeu4fhV4JOHLpK7tNP0m
         897Q==
X-Forwarded-Encrypted: i=1; AJvYcCX11OiBym3VNFBsIHYFdXUALDvMGQJGXQUov/8A7y0E6MMGexM4XYeCWiqbncmXcgXq6ASKoxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdXN2HIueG3xvqxb/mfjrAP3oNllcF1oC2EQV2CWHMm5v3XYMD
	Qe6EswRyyEZqlAvlaLZ0qC8CZ9z/UDWVAoA+AG1DIF/kjkjJY52Oq3vtW/nrsiZkODY=
X-Gm-Gg: ASbGncvWCzS2l/XwE6noT2sBusc5lR2kkxNgL3wrJSd5xrVVNeK0Ak13kJ5BGeYqlXE
	0Id1l27d9wWgB8SM6ymw7BzWi3gHFoumR9PbjsmiKvSTDDXHjNrzrtUjmqH5oVucx1aK7SzaQuY
	kalyPBE3pNUem6j7bmAD6IcjFKZy+zkD5wdT1Udl0277rKQJkA66fAj9yeG9cJtS8UHzQUYd9lV
	CnWHISJhbFspZ+QJve37sCSqY3oQ52kU0ZJWyvvG/ifwXqIMc3Ws/Tck1tuyh/xLWAs2bYLWGsB
	GggiUUR8mo1n/U1Eav2WuH8j7XqSsi3Nn6ehrdpFOwu2iqMiHnRLOCfEUktPhlhZENIkdGJyrJ6
	JzoE10EWDrMU1OXwQcfsAHDIh2d98JJfEfnw=
X-Google-Smtp-Source: AGHT+IGp5dBjpRzjY49aqe/QenUi3apAjO5ZEefw6f+AyK8a3dUeRX3nZIMy7HD2Rg7v9smMeUcwHw==
X-Received: by 2002:a05:6000:1886:b0:3cb:1cb3:70e2 with SMTP id ffacd0b85a97d-3cb1cb37c94mr7767308f8f.23.1756381398563;
        Thu, 28 Aug 2025 04:43:18 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba1eesm25961792f8f.2.2025.08.28.04.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 04:43:18 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:43:11 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: mheib@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, przemyslawx.patynowski@intel.com, 
	netdev@vger.kernel.org, horms@kernel.org, jacob.e.keller@intel.com, 
	aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net v2] i40e: add devlink param to control VF MAC address
 limit
Message-ID: <pdanf5ciga5ddl7xyi2zkltcznyz4wtnyqyaqm7f5oqpcrubfz@ma4juoq4qlph>
References: <20250823094952.182181-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823094952.182181-1-mheib@redhat.com>

Sat, Aug 23, 2025 at 11:49:52AM +0200, mheib@redhat.com wrote:
>From: Mohammad Heib <mheib@redhat.com>
>
>This patch introduces a new devlink runtime parameter that controls
>the maximum number of MAC filters allowed per VF.
>
>The parameter is an integer value. If set to a non-zero number, it is
>used as a strict per-VF cap. If left at zero, the driver falls back to
>the default limit calculated from the number of allocated VFs and
>ports.
>
>This makes the limit policy explicit and configurable by user space,
>instead of being only driver internal logic.
>
>Example command to enable per-vf mac limit:
> - devlink dev param set pci/0000:3b:00.0 name max_mac_per_vf \
>	value 12 \
>	cmode runtime
>
>- Previous discussion about this change:
>  https://lore.kernel.org/netdev/20250805134042.2604897-1-dhill@redhat.com
>
>Fixes: cfb1d572c986 ("i40e: Add ensurance of MacVlan resources for every trusted VF")
>Signed-off-by: Mohammad Heib <mheib@redhat.com>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>---
> Documentation/networking/devlink/i40e.rst     | 22 ++++++++
> drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++
> .../net/ethernet/intel/i40e/i40e_devlink.c    | 56 ++++++++++++++++++-
> .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 25 +++++----
> 4 files changed, 95 insertions(+), 12 deletions(-)
>
>diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
>index d3cb5bb5197e..f8d5b00bb51d 100644
>--- a/Documentation/networking/devlink/i40e.rst
>+++ b/Documentation/networking/devlink/i40e.rst
>@@ -7,6 +7,28 @@ i40e devlink support
> This document describes the devlink features implemented by the ``i40e``
> device driver.
> 
>+Parameters
>+==========
>+
>+.. list-table:: Driver specific parameters implemented
>+    :widths: 5 5 90
>+
>+    * - Name
>+      - Mode
>+      - Description
>+    * - ``max_mac_per_vf``
>+      - runtime
>+      - Controls the maximum number of MAC addresses a VF can use on i40e devices.
>+
>+        By default (``0``), the driver enforces its internally calculated per-VF
>+        MAC filter limit, which is based on the number of allocated VFS.
>+
>+        If set to a non-zero value, this parameter acts as a strict cap:
>+        the driver enforces the maximum of the user-provided value and ignore
>+        internally calculated limit.
>+
>+        The default value is ``0``.
>+
> Info versions
> =============
> 
>diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
>index 801a57a925da..d2d03db2acec 100644
>--- a/drivers/net/ethernet/intel/i40e/i40e.h
>+++ b/drivers/net/ethernet/intel/i40e/i40e.h
>@@ -574,6 +574,10 @@ struct i40e_pf {
> 	struct i40e_vf *vf;
> 	int num_alloc_vfs;	/* actual number of VFs allocated */
> 	u32 vf_aq_requests;
>+	/* If set to non-zero, the device uses this value
>+	 * as maximum number of MAC filters per VF.
>+	 */
>+	u32 max_mac_per_vf;
> 	u32 arq_overflows;	/* Not fatal, possibly indicative of problems */
> 	struct ratelimit_state mdd_message_rate_limit;
> 	/* DCBx/DCBNL capability for PF that indicates
>diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
>index cc4e9e2addb7..8532e40b5c7d 100644
>--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
>+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
>@@ -5,6 +5,42 @@
> #include "i40e.h"
> #include "i40e_devlink.h"
> 
>+static int i40e_max_mac_per_vf_set(struct devlink *devlink,
>+				   u32 id,
>+				   struct devlink_param_gset_ctx *ctx,
>+				   struct netlink_ext_ack *extack)
>+{
>+	struct i40e_pf *pf = devlink_priv(devlink);
>+
>+	pf->max_mac_per_vf = ctx->val.vu32;
>+	return 0;
>+}
>+
>+static int i40e_max_mac_per_vf_get(struct devlink *devlink,
>+				   u32 id,
>+				   struct devlink_param_gset_ctx *ctx)
>+{
>+	struct i40e_pf *pf = devlink_priv(devlink);
>+
>+	ctx->val.vu32 = pf->max_mac_per_vf;
>+	return 0;
>+}
>+
>+enum i40e_dl_param_id {
>+	I40E_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
>+	I40E_DEVLINK_PARAM_ID_MAX_MAC_PER_VF,

What's so i40 specific about this? Sounds pretty generic to be.



>+};
>+
>+static const struct devlink_param i40e_dl_params[] = {
>+	DEVLINK_PARAM_DRIVER(I40E_DEVLINK_PARAM_ID_MAX_MAC_PER_VF,
>+			     "max_mac_per_vf",
>+			     DEVLINK_PARAM_TYPE_U32,
>+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
>+			     i40e_max_mac_per_vf_get,
>+			     i40e_max_mac_per_vf_set,
>+			     NULL),
>+};
>+
> static void i40e_info_get_dsn(struct i40e_pf *pf, char *buf, size_t len)
> {
> 	u8 dsn[8];
>@@ -165,7 +201,19 @@ void i40e_free_pf(struct i40e_pf *pf)
>  **/
> void i40e_devlink_register(struct i40e_pf *pf)
> {
>-	devlink_register(priv_to_devlink(pf));
>+	int err;
>+	struct devlink *dl = priv_to_devlink(pf);
>+	struct device *dev = &pf->pdev->dev;
>+
>+	err = devlink_params_register(dl, i40e_dl_params,
>+				      ARRAY_SIZE(i40e_dl_params));
>+	if (err) {
>+		dev_err(dev,
>+			"devlink params register failed with error %d", err);
>+	}
>+
>+	devlink_register(dl);
>+
> }
> 
> /**
>@@ -176,7 +224,11 @@ void i40e_devlink_register(struct i40e_pf *pf)
>  **/
> void i40e_devlink_unregister(struct i40e_pf *pf)
> {
>-	devlink_unregister(priv_to_devlink(pf));
>+	struct devlink *dl = priv_to_devlink(pf);
>+
>+	devlink_unregister(dl);
>+	devlink_params_unregister(dl, i40e_dl_params,
>+				  ARRAY_SIZE(i40e_dl_params));
> }
> 
> /**
>diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>index 081a4526a2f0..e7c0c791eed1 100644
>--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>@@ -2935,19 +2935,23 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
> 		if (!f)
> 			++mac_add_cnt;
> 	}
>-
>-	/* If this VF is not privileged, then we can't add more than a limited
>-	 * number of addresses.
>+	/* Determine the maximum number of MAC addresses this VF may use.
>+	 *
>+	 * - For untrusted VFs: use a fixed small limit.
>+	 *
>+	 * - For trusted VFs: limit is calculated by dividing total MAC
>+	 *  filter pool across all VFs/ports.
> 	 *
>-	 * If this VF is trusted, it can use more resources than untrusted.
>-	 * However to ensure that every trusted VF has appropriate number of
>-	 * resources, divide whole pool of resources per port and then across
>-	 * all VFs.
>+	 * - User can override this by devlink param "max_mac_per_vf".
>+	 *   If set its value is used as a strict cap.
> 	 */
>-	if (!vf_trusted)
>+	if (!vf_trusted) {
> 		mac_add_max = I40E_VC_MAX_MAC_ADDR_PER_VF;
>-	else
>+	} else {
> 		mac_add_max = I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs, hw->num_ports);
>+		if (pf->max_mac_per_vf > 0)
>+			mac_add_max = pf->max_mac_per_vf;
>+	}
> 
> 	/* VF can replace all its filters in one step, in this case mac_add_max
> 	 * will be added as active and another mac_add_max will be in
>@@ -2961,7 +2965,8 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
> 			return -EPERM;
> 		} else {
> 			dev_err(&pf->pdev->dev,
>-				"Cannot add more MAC addresses, trusted VF exhausted it's resources\n");
>+				"Cannot add more MAC addresses: trusted VF reached its maximum allowed limit (%d)\n",
>+				mac_add_max);
> 			return -EPERM;
> 		}
> 	}
>-- 
>2.47.3
>

