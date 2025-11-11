Return-Path: <netdev+bounces-237720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2C2C4F64D
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 19:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A952E4E2E39
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 18:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A1F3A79C1;
	Tue, 11 Nov 2025 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHWwyDFi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E856E3A79A9
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884816; cv=none; b=nGWzLDqZn9Etw2o2eHzPUuglAE7JgUJO2J2Vo1oGeETDQM8UAV3CdY7NLVY1TOdT8nAY33jsS4iHt/U7gsKNZKSqSOTACYeIO1Xk//8BK6Tyqm2KRgl8YQThWe3N5ma1Y+9yrM/OM++X/AfLlzbXZY1EMaif4MdDPlKqEEnqtJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884816; c=relaxed/simple;
	bh=WGl8DP/e/+VnYn8C3uYrsdOuYr6SojLzWShAwr+tv6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4Q3Do33UewAM5EUDeQkucinLP5OgRQXj0oyxNadjCq3zQiuQCX9saMHdg48kmsoyl67Ug3ZciMVxtb3iqh9uTwwP4HioL3+qbiQdBptkyPUoD3/cJMlnC2Qju1X8SJ98Heftda5AqvOgj2jJqmWa4FwUATZI1LUVPqrgTrxXC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHWwyDFi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762884813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKzPhPd7GeQ9w5/pssxPxDnXDnFFtiQ8qQ0W7dttM3g=;
	b=cHWwyDFi0p3Y9qHFLKt/zsefdCg6tluCYPX9J8p+3/EEWC/GbRFMNeajEtxN4iVbkzeeUB
	kqf6E1IBceq26XGOUTmGuzWee+u2xVNOJJK8I6jKBnBkSkXtCYIql1TuvN08ImCLhYHMdK
	wvWOT8k9Zi41S+JsS8ISaRnCfrD/llM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-z5nNqTK1PxeQfpI2s1wwPw-1; Tue,
 11 Nov 2025 13:13:30 -0500
X-MC-Unique: z5nNqTK1PxeQfpI2s1wwPw-1
X-Mimecast-MFC-AGG-ID: z5nNqTK1PxeQfpI2s1wwPw_1762884809
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 904131800359;
	Tue, 11 Nov 2025 18:13:29 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.20])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C62321800451;
	Tue, 11 Nov 2025 18:13:23 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 6/6] dpll: zl3073x: Remove unused dev wrappers
Date: Tue, 11 Nov 2025 19:12:43 +0100
Message-ID: <20251111181243.4570-7-ivecera@redhat.com>
In-Reply-To: <20251111181243.4570-1-ivecera@redhat.com>
References: <20251111181243.4570-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Remove several zl3073x_dev_... inline wrapper functions from core.h
as they are no longer used by any callers.

Removed functions:
* zl3073x_dev_ref_ffo_get
* zl3073x_dev_ref_is_enabled
* zl3073x_dev_synth_dpll_get
* zl3073x_dev_synth_is_enabled
* zl3073x_dev_out_signal_format_get

This is a cleanup after recent refactoring, as the remaining callers
now fetch the state object and use the base helpers directly.

Reviewed-by: Petr Oros <poros@redhat.com>
Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.h | 77 -------------------------------------
 1 file changed, 77 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index fe8b70e25d3cc..09bca2d0926d5 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -182,21 +182,6 @@ zl3073x_output_pin_out_get(u8 id)
 	return id / 2;
 }
 
-/**
- * zl3073x_dev_ref_ffo_get - get current fractional frequency offset
- * @zldev: pointer to zl3073x device
- * @index: input reference index
- *
- * Return: the latest measured fractional frequency offset
- */
-static inline s64
-zl3073x_dev_ref_ffo_get(struct zl3073x_dev *zldev, u8 index)
-{
-	const struct zl3073x_ref *ref = zl3073x_ref_state_get(zldev, index);
-
-	return zl3073x_ref_ffo_get(ref);
-}
-
 /**
  * zl3073x_dev_ref_freq_get - get input reference frequency
  * @zldev: pointer to zl3073x device
@@ -227,21 +212,6 @@ zl3073x_dev_ref_is_diff(struct zl3073x_dev *zldev, u8 index)
 	return zl3073x_ref_is_diff(ref);
 }
 
-/**
- * zl3073x_dev_ref_is_enabled - check if the given input reference is enabled
- * @zldev: pointer to zl3073x device
- * @index: input reference index
- *
- * Return: true if input refernce is enabled, false otherwise
- */
-static inline bool
-zl3073x_dev_ref_is_enabled(struct zl3073x_dev *zldev, u8 index)
-{
-	const struct zl3073x_ref *ref = zl3073x_ref_state_get(zldev, index);
-
-	return zl3073x_ref_is_enabled(ref);
-}
-
 /*
  * zl3073x_dev_ref_is_status_ok - check the given input reference status
  * @zldev: pointer to zl3073x device
@@ -257,22 +227,6 @@ zl3073x_dev_ref_is_status_ok(struct zl3073x_dev *zldev, u8 index)
 	return zl3073x_ref_is_status_ok(ref);
 }
 
-/**
- * zl3073x_dev_synth_dpll_get - get DPLL ID the synth is driven by
- * @zldev: pointer to zl3073x device
- * @index: synth index
- *
- * Return: ID of DPLL the given synthetizer is driven by
- */
-static inline u8
-zl3073x_dev_synth_dpll_get(struct zl3073x_dev *zldev, u8 index)
-{
-	const struct zl3073x_synth *synth;
-
-	synth = zl3073x_synth_state_get(zldev, index);
-	return zl3073x_synth_dpll_get(synth);
-}
-
 /**
  * zl3073x_dev_synth_freq_get - get synth current freq
  * @zldev: pointer to zl3073x device
@@ -289,22 +243,6 @@ zl3073x_dev_synth_freq_get(struct zl3073x_dev *zldev, u8 index)
 	return zl3073x_synth_freq_get(synth);
 }
 
-/**
- * zl3073x_dev_synth_is_enabled - check if the given synth is enabled
- * @zldev: pointer to zl3073x device
- * @index: synth index
- *
- * Return: true if synth is enabled, false otherwise
- */
-static inline bool
-zl3073x_dev_synth_is_enabled(struct zl3073x_dev *zldev, u8 index)
-{
-	const struct zl3073x_synth *synth;
-
-	synth = zl3073x_synth_state_get(zldev, index);
-	return zl3073x_synth_is_enabled(synth);
-}
-
 /**
  * zl3073x_dev_out_synth_get - get synth connected to given output
  * @zldev: pointer to zl3073x device
@@ -341,21 +279,6 @@ zl3073x_dev_out_is_enabled(struct zl3073x_dev *zldev, u8 index)
 	return zl3073x_synth_is_enabled(synth) && zl3073x_out_is_enabled(out);
 }
 
-/**
- * zl3073x_dev_out_signal_format_get - get output signal format
- * @zldev: pointer to zl3073x device
- * @index: output index
- *
- * Return: signal format of given output
- */
-static inline u8
-zl3073x_dev_out_signal_format_get(struct zl3073x_dev *zldev, u8 index)
-{
-	const struct zl3073x_out *out = zl3073x_out_state_get(zldev, index);
-
-	return zl3073x_out_signal_format_get(out);
-}
-
 /**
  * zl3073x_dev_out_dpll_get - get DPLL ID the output is driven by
  * @zldev: pointer to zl3073x device
-- 
2.51.0


