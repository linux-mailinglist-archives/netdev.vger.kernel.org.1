Return-Path: <netdev+bounces-77966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF09873A6F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10311C204F7
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394FA131745;
	Wed,  6 Mar 2024 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="U6GuLDw7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0647FBBD
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737969; cv=none; b=dtD5aIK82TpPUXm5BrpZcKvwvUGtVQ8/JCtedBiymKeWtoKbQokANEfx2Z9WQVdcsToNqoCgNuuCyBEGYfpaxG7HFoROieVp3hICi2Bmtt0i0XxeoEogh0O/Bp8U7zr6VUUc6LpqA2rLntZR+3WeomcuvCBPnVhd24pkdVjpbc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737969; c=relaxed/simple;
	bh=4pwNsbjRBS8XeEKKfJsqtRtZb7NjFLl8TvS8Zykr0JA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uuLgAmLrP0RD4ogtnCLDN04aWIrNtNO/o+BW6+23gRe2lolq+0x/A9wkemz0fGLVycgWMRDortdBJvN2Eq7v69ukN0s4qwn+cpP4KXMd/HTr45JMMH/0bjTCdsGOlSpTA9HfX6Mm+vM/Qn4NGlV8qBILfPOHbB8BzrTgnetEhZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=U6GuLDw7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412f0655d81so10944835e9.2
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 07:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709737964; x=1710342764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8WFrTMhWZDJbGiqTg8tNNHHgTGFz0bEI2mqQkh8mZs8=;
        b=U6GuLDw7T8qiV/ihm5Ym8a1Zw0Rejn+VtG6XYVHfuKB7s1xg6Ra1eEqF327fWwJnPz
         fJl0d9SPqAfPpWnN+pQFyazJJHEUb6xeGNvAU5mTBYAU2yZl7d7bf9vLeAscU7wyLzcs
         UByb9C9+Cmq9pTHbDHR09dOpNgxxYx1Xt5OjBIzOggDKAf6cz853IKD7I5wvIa83v+Hf
         gygTL4mpvdMazk+IkvBNzFhOP8nG09O9Cp0WaXwuzannGTFt3ZxiqngFRcw6AHsDXtFX
         5EqZoMQ19pMgjMRg6qCkekWf/X2SblUMnAeYLcf63KWnsR9m4Ep/PZlreP1GgnWcqpXg
         8b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709737964; x=1710342764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WFrTMhWZDJbGiqTg8tNNHHgTGFz0bEI2mqQkh8mZs8=;
        b=EsZorxnnBo5DRO/fwkdtbUOV2B3GUvzCqauniTYCgkDC1qWABGG6ikTZNMkkq3wvF8
         NgmbKZYSg/wBwF0dTW87nyYtNJTVHFBIPDCrP65JMJ8WLn/+Xq/8zAkaxvaoEDbAV0x9
         uiVrqQr0irHttj3iCBDLvsXajE7fv/GDOlXAUFhyVmMaCYlQOfsDUP0vLFwktCwvOxkO
         AQaIW7yM8eIgh8gNq7m2Loe9OvhgJr3XhPrrt+E8Qp/T0UG07Vx9a75sbaJD/p6ymS/1
         duCcYRcsD516FL5tRsEAxi7jE79vedigmPAul5HQrvMEA6fpFJhuybGyobwJeeAQ7m5q
         tQaA==
X-Gm-Message-State: AOJu0Yx2D1Ta+GC1sETbqco4uOLM48+uJopsjKMTBIbHA1OxFcn4qtKb
	IrQBKyg1NTat6XX18EqInzzhM+Ml3koG0QMwuLhXupdSiqXAr0x93ckf8yq1zD6JPBXchS7qcWp
	1
X-Google-Smtp-Source: AGHT+IFHqsz95nFay6L28h+N/f2iXncgk3vjHS6oE1DNlqT+M100hj00ZWelDrJmMdK4fx7uo2cmnQ==
X-Received: by 2002:a05:600c:4e0b:b0:412:f6d0:5e43 with SMTP id b11-20020a05600c4e0b00b00412f6d05e43mr1293948wmq.5.1709737963581;
        Wed, 06 Mar 2024 07:12:43 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id o38-20020a05600c512600b00412f478a90bsm2475879wms.48.2024.03.06.07.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:12:43 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	milena.olech@intel.com,
	rrameshbabu@nvidia.com
Subject: [patch net] dpll: fix dpll_xa_ref_*_del() for multiple registrations
Date: Wed,  6 Mar 2024 16:12:40 +0100
Message-ID: <20240306151240.1464884-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently, if there are multiple registrations of the same pin on the
same dpll device, following warnings are observed:
WARNING: CPU: 5 PID: 2212 at drivers/dpll/dpll_core.c:143 dpll_xa_ref_pin_del.isra.0+0x21e/0x230
WARNING: CPU: 5 PID: 2212 at drivers/dpll/dpll_core.c:223 __dpll_pin_unregister+0x2b3/0x2c0

The problem is, that in both dpll_xa_ref_dpll_del() and
dpll_xa_ref_pin_del() registration is only removed from list in case the
reference count drops to zero. That is wrong, the registration has to
be removed always.

To fix this, remove the registration from the list and free
it unconditionally, instead of doing it only when the ref reference
counter reaches zero.

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/dpll/dpll_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 7f686d179fc9..c751a87c7a8e 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -129,9 +129,9 @@ static int dpll_xa_ref_pin_del(struct xarray *xa_pins, struct dpll_pin *pin,
 		reg = dpll_pin_registration_find(ref, ops, priv);
 		if (WARN_ON(!reg))
 			return -EINVAL;
+		list_del(&reg->list);
+		kfree(reg);
 		if (refcount_dec_and_test(&ref->refcount)) {
-			list_del(&reg->list);
-			kfree(reg);
 			xa_erase(xa_pins, i);
 			WARN_ON(!list_empty(&ref->registration_list));
 			kfree(ref);
@@ -209,9 +209,9 @@ dpll_xa_ref_dpll_del(struct xarray *xa_dplls, struct dpll_device *dpll,
 		reg = dpll_pin_registration_find(ref, ops, priv);
 		if (WARN_ON(!reg))
 			return;
+		list_del(&reg->list);
+		kfree(reg);
 		if (refcount_dec_and_test(&ref->refcount)) {
-			list_del(&reg->list);
-			kfree(reg);
 			xa_erase(xa_dplls, i);
 			WARN_ON(!list_empty(&ref->registration_list));
 			kfree(ref);
-- 
2.43.2


