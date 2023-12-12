Return-Path: <netdev+bounces-56463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E2180EF9A
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1051C20AB5
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083DE745F0;
	Tue, 12 Dec 2023 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="O0VS//xs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B33AA
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 07:06:09 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c9f85eff28so87005731fa.3
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 07:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702393567; x=1702998367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZvNMph3E1B1Qj51Fir7QeBjDM+Jb2la/yuZ9W8sQic=;
        b=O0VS//xsLWbkPbkNF/qruOaXkpCxvL8FITmUUnWEt+sdrW83J9fBh2rKnXhebwFXY1
         BJP/mnamY8Hef8+R2mT5Ml93WRa9wiF8OhW6iyWw13hy34zHdvNXOiO35f8odGFmmT/6
         mocfYfATvTY14JrQSxAU/CflxgW45I4e7kMAIoXU416/Ilig7FhV80NE3tHZ9waQkJJJ
         oB+TWElUJktpm1IVTiAIUClxKgSNEP8mc737PMe7KdxPH0gmuXuugRyYhef7GGxNOH2i
         lM1AZI0F8ppZM8tRFqSo4VjKOe296ZjRaSKXKp1AUwnF233g+lbF/wm+kwPVhEONsmOw
         gtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702393567; x=1702998367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZvNMph3E1B1Qj51Fir7QeBjDM+Jb2la/yuZ9W8sQic=;
        b=hSwxwi2mb8xMJykInkPFOm4EnCg4VrChGOCwXs/ZDujDEKYr8SCSnfrHYLcHQSj0Bt
         bYKZ8vwhnQsgNLb2F+yBCdGkYCvlz95A3C6a3mUpZKt3LUhUuqf8wflPTOejrllIroIj
         9Zabl18MMgbLIrnXRmnPqlh3z8DEv/5U38b3qZUtVUItkFzxYMNtwjUTTCmNHvafXZft
         NAEvC04KoSCNuZt/Eo19XbbdOeYxlQ0WMOmeXouvDElA8O8KPgNGkJjGueMKIqZCAfyJ
         arlurWRM7Ncx3jGt8um7dNGT5xANdBWlhFodQvhmDtWpyuDicUY9OwWyEns3ezgUGPSC
         i4eg==
X-Gm-Message-State: AOJu0YzlvaCpSnLpnnmmTfFYO31nAQ6n6zEHHl5G1J1cW+uvopv8n3jI
	KvCp0m/qJo4k0quzAygipwqTYhOK4KIfZra25fM=
X-Google-Smtp-Source: AGHT+IFfGn5e+wlN0blJ5oDiJS8lSjoJ9dSOiAxZUrjMsvRnHeVIuq2hR4XRTf6mF6fpvk6EWT8unA==
X-Received: by 2002:a05:6512:3d8f:b0:500:daf6:3898 with SMTP id k15-20020a0565123d8f00b00500daf63898mr3683109lfv.26.1702393567194;
        Tue, 12 Dec 2023 07:06:07 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id hw18-20020a170907a0d200b00a1cbe52300csm6403376ejc.56.2023.12.12.07.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 07:06:06 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com
Subject: [patch net-next] dpll: allocate pin ids in cycle
Date: Tue, 12 Dec 2023 16:06:05 +0100
Message-ID: <20231212150605.1141261-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Pin ID is just a number. Nobody should rely on a certain value, instead,
user should use either pin-id-get op or RTNetlink to get it.

Unify the pin ID allocation behavior with what there is already
implemented for dpll devices.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/dpll/dpll_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 3568149b9562..1eca8cc271f8 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -22,7 +22,8 @@ DEFINE_MUTEX(dpll_lock);
 DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
 DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
 
-static u32 dpll_xa_id;
+static u32 dpll_device_xa_id;
+static u32 dpll_pin_xa_id;
 
 #define ASSERT_DPLL_REGISTERED(d)	\
 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
@@ -246,7 +247,7 @@ dpll_device_alloc(const u64 clock_id, u32 device_idx, struct module *module)
 	dpll->clock_id = clock_id;
 	dpll->module = module;
 	ret = xa_alloc_cyclic(&dpll_device_xa, &dpll->id, dpll, xa_limit_32b,
-			      &dpll_xa_id, GFP_KERNEL);
+			      &dpll_device_xa_id, GFP_KERNEL);
 	if (ret < 0) {
 		kfree(dpll);
 		return ERR_PTR(ret);
@@ -446,7 +447,8 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	refcount_set(&pin->refcount, 1);
 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
-	ret = xa_alloc(&dpll_pin_xa, &pin->id, pin, xa_limit_16b, GFP_KERNEL);
+	ret = xa_alloc_cyclic(&dpll_pin_xa, &pin->id, pin, xa_limit_32b,
+			      &dpll_pin_xa_id, GFP_KERNEL);
 	if (ret)
 		goto err;
 	return pin;
-- 
2.43.0


