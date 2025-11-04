Return-Path: <netdev+bounces-235608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782A0C33446
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8589C424C43
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C4A347BC0;
	Tue,  4 Nov 2025 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMLbSDWH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B58F328603
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295957; cv=none; b=PnHMsT5aIlZ2uzkXVz169TNamS0yMFF+T+c20SibSdD6b6hB64X/BJBKLnyOoSCt85efmegDNRaPUqzUiHS6cwbNjvD0N9T9FRu/XEcuIpR7GE6t0MSU7Nccm2GOEFb47fBQrVIiJEvhUh0E0GBOCcGtA83O2Pdoa0DTSQxXSpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295957; c=relaxed/simple;
	bh=hLx98oFksm1euOd3gRvzTKc2fkdp8CNEeWRtz4krUsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IouUeRBaC82OnbcIkmwVvRmQ6rkONIaJgRkgv/Q27kOkgXcyDCwlCLYkz9AwFqiN3vTzhUq066v1//z9TjIuVs1DyoBBD+WwU0NXrVD+tigSfrxaun9UUBzydLaBYj07SdgeEsI8DxuGl1mKPk0QxXlGaBZmaAuvWx1tpMDSUQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMLbSDWH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2957850c63bso3073645ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 14:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295955; x=1762900755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NPOoIdp5+m43RuZesJ5XJFKTqD36Mp7WZTcw49QJWI=;
        b=HMLbSDWHK18Avq74DI56BBSgIkRB2C/MfQ2JDwb8qjy1/Ukni4jFk6QZkjR+FXwzX8
         nNwUaMT306RKmz0Yr1I+ipGPg7c2w8HeYEfmpjXLGnGUqCo6QOMdBSR+oFlf0YTScCvM
         IEKWT1HKomSIRLODBZAfoDjImqNd6VZEcFmaSv3Ij2nZE2GxnvFrNJSNpG8TF0pyG5Gc
         sKSjbQ5kx/rF7b4/emj+U0gdEEgNj0exMS/44IaF2xDRMikgPqUNiZiF4Q+45mVYD6Uw
         C3gd9xqpoOVqw07SyeClO1Utou6poiEo17vC6Qt63HBlQQVQK8/u/epWSEL+XIb3pC61
         lugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295955; x=1762900755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NPOoIdp5+m43RuZesJ5XJFKTqD36Mp7WZTcw49QJWI=;
        b=T8RPbPKnBvsC+KSnNoiv5BOIMBrAr+21tb1LO0n5uV/okIn/RaIWDXm9ps3ntd7nQs
         +UOMnG7qVayNMoiEw2qmlX/zFmGlRADmBd1Fm3upkbOgVNJ/ckAPCdqenfaHkraZ+vLw
         1NjvSC8USNwOljMYHmKOYTsGwlAyqcLgfZFqNVx7ICZt4kyU1aJ/kLzwZOOnra+iu2r0
         JheeQCZq48crY1vU8+xGJ0eGQYCDgiGAFIOmQ0HmSA4rUIHDSrl7nPSvPVabVszko4c4
         OGQn58lpIsbOyKOModlNE9L8ChRY0psj0Tmv/mA0GFukdgVT9fEXu7wostT2nIWIynuY
         8e5g==
X-Forwarded-Encrypted: i=1; AJvYcCW4SFFGDZjL/m2NXcM+A+PHXPFfKId7NZJjtz+HcnnBk0s80xTNdWPy2Vyk62pKu0A7yDOy9cs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8mymR1YPR/S/bPczqTUFNXQZwETybES5NidHGy6jYq1SIcNd5
	VwPnO3RE83trW7JXnRdzYqqWOEqttwhyns+iGGHxLOTfohYq2IV7HLSnXHaF+w==
X-Gm-Gg: ASbGncvoIhvSjrYwwyQvC8XiwDS/4WVASAMyoNhgXKtXVFwm399T5AbCNYwjI0T1dbG
	JLEPkR7n+uSca+pCRYeIVlMjcHnFACaQWc1XxI40FxcCKRq6/IKotWFHXP3yDP7jUb0q3jXtBlf
	jxCifisRdr2u4jMxqhMhKVv6kx/jC3N+55vuJUonUSRa5+AIb4t+4sxf4Xw5zBw9kc5v8qOxeS/
	yp4nr0HmNk17GH2SYwqBH/TarbEU5iQv1zokMh4JzbAL3BJTnjiCbDotJXD8G10FwJH2YHD5TA/
	go5DyX2UtaWdS6WFF6ta21OZIabKPWpClhbeuKesTIxA6BnXt+bQgveAiBBytXgLJaR0pGGId9d
	pFe1qWUbZttzvbXBFOEJotSh3Z+feLdK8wBDdbwVTZ0JGg49LYmbjIbTwSw1IYHCZ/fnLBV208w
	==
X-Google-Smtp-Source: AGHT+IFcWJCIHYENfyxIioaojYZp29/Ndik7t8pPlyOLj+vibXcfDiidJwI3fcQfTIxtp/Uq8IFSMw==
X-Received: by 2002:a17:903:22cb:b0:295:55f:8ebb with SMTP id d9443c01a7336-2962adb7080mr13883295ad.21.1762295954777;
        Tue, 04 Nov 2025 14:39:14 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972ac6sm39637535ad.8.2025.11.04.14.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:14 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:56 -0800
Subject: [PATCH net-next v2 06/12] selftests/vsock: speed up tests by
 reducing the QEMU pidfile timeout
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-6-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reduce the time waiting for the QEMU pidfile from three minutes to five
seconds. The three minute time window was chosen to make sure QEMU had
enough time to fully boot up. This, however, is an unreasonably long
delay for QEMU to write the pidfile, which happens earlier when the QEMU
process starts (not after VM boot). The three minute delay becomes
noticeably wasteful in future tests that expect QEMU to fail and wait a
full three minutes for a pidfile that will never exist.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 81656b9acfaa..940e1260de28 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
 readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+readonly WAIT_QEMU=5
 readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
@@ -221,7 +221,7 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	timeout "${WAIT_TOTAL}" \
+	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 

-- 
2.47.3


