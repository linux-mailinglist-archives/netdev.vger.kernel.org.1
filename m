Return-Path: <netdev+bounces-149319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3B19E51D0
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB4F28391A
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BA1216602;
	Thu,  5 Dec 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQEu1Npl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0794C2165FE
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733393193; cv=none; b=gunOowpWaOxnafBm3yd7SZoxeDOdWu90pZaBIw2javxyoFk5jh5VCJ9Zh2uuu5RRcFHfHuLw+o5GNLP6sOL6Z4uP+b4ZbReBGNTjAVMApwY85H7Tvhn0hYDe9BYTlB0pCB7ctWRW3gdjFRggGDTywRXTgZpm1+AHh3VxozOt07Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733393193; c=relaxed/simple;
	bh=FcvQcysm+c5oPoIcxMdRPIJwK+iLPLslyJMnMh8l9zQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GguQt/3D4rIiFuDcvSfLSA3KQVrFxkNE3ZpwJhq6IUFDpFV09tsUys4C+bX6MslFi6Nu+wYlSmjITQLLIBRMu+Wwm2T33pbWyu/bzkl+J+ZX5NTVT/u4rQSaOS6CLSbyPYtbjKEb7pR+v2jr+lwS2aedVhJ77mfKwm/KnrUrXBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQEu1Npl; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53e274f149fso274524e87.1
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 02:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733393189; x=1733997989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aDfYy8U5RVYIb7nYvGBkbaGRKPvJ8Sl5k1IsgAg1NzE=;
        b=aQEu1Npl0IdMsKldIL5Ob2e2o55NKiJZ0RTQ2jBASvVDF6SZvdPEyokXxCqLTNRMv3
         69pMEUOoRbwVkGgNxQwgeneibD0PoFxqrvkUT131GGacR093OC38FjZE4zway/pZV2Gs
         Sxwp9/I4s8zBCfBvjmnyTXb5bBN05fuNgIOkNVUr0tRkQ+YZfzrOKOmhZ8hrQXe4d8La
         xkeV/4QRPG07O8aXnZ+c2armmRQMaJvDCLvmD00WdTRSNjOSConG0qWoT6fQ8SGtjlwo
         WAXMJbABv+q4nWj8j1L32HROAKzDCgB+yl16APkikgwCZDkQKoFKhCWnDiSCUHB5Imy0
         Cq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733393189; x=1733997989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDfYy8U5RVYIb7nYvGBkbaGRKPvJ8Sl5k1IsgAg1NzE=;
        b=QSwJAF/TlZ2jqY94sCrmbC6NB/hkRrWomFNSiPTy+2aDDX+PwolOCeDkRcIoVDiX/y
         czwQgP2GdoOJgRkoVcm4mILmVzTdeSzARUEabGFautF1/QO0xtjQmr2SZdwDleOJeahf
         Ryv69dGQV0vqIZ2nVLk2tAO4GmEolXM2uz5r0NUDrqxFmWeK5pcELGL3XTU8XPYhIubj
         xH1PnImnZVMSg+NJSygTYTbhXggo+fNjuDz0YlGtJSVm5H5jMdi7AP0Ii9KlOGOetbbJ
         wekttUtkxc/xsy1Sw5WneAFOJlwl+jXm10sfUk+2cWWP4u3QYC6tlo9zstU66l3/rokx
         PRFA==
X-Gm-Message-State: AOJu0YySW6LPGjUWue+h5MFv4fho3PiKTAwp857vdw+TkWX4eZK/Ktro
	llGi7jv8EzSDqzRp6O/UZeaokDupZBm7DFKiPJmkglc/PS5MaE9a
X-Gm-Gg: ASbGnctzwNXgCBJD/GytegOri/JVHHSDI74BWBx1Hn2SMPzwUqLbMkLNtejyEZaZ7iG
	+Jdkf0O9pJ30ASznwcX5avqayGMMNMO4GA1ex3Qi5Eklq8nXvKFtpUn9kaL1wm/XeFVSO07FML4
	7Se9NYPI/QwgAK5BYV4oot21YPe3oDGgAyrlC2Z/zS8SlbQA+J/sxu0aYQE29tgvTAKRgBZhmL+
	AJDorDe5u4rjGZzg6ipMokBOO1vOGHPeFifORx3nD+82eXmbSkJAO46VYfJ1mjr827jBt4U
X-Google-Smtp-Source: AGHT+IHSGlxlvfJiRgtipbQrXmdkgbhujCPAWbZZ6CgsBxXSj4l+d3sIOjzIMPhiE3O6KHS1RfCpFA==
X-Received: by 2002:a05:6512:23a0:b0:53e:284a:70f6 with SMTP id 2adb3069b0e04-53e284a7161mr141446e87.44.1733393189198;
        Thu, 05 Dec 2024 02:06:29 -0800 (PST)
Received: from localhost.localdomain ([178.219.168.21])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ca28dsm186262e87.257.2024.12.05.02.06.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:06:27 -0800 (PST)
From: Dmitry Kandybka <d.kandybka@gmail.com>
To: Pravin B Shelar <pshelar@ovn.org>
Cc: netdev@vger.kernel.org,
	dev@openvswitch.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH RFC net] openvswitch: fix possible integer overflow in ovs_meter_execute
Date: Thu,  5 Dec 2024 13:06:24 +0300
Message-Id: <20241205100624.91017-1-d.kandybka@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'ovs_meter_execute()', add warn on multiplication of 'delta_ms' and
'band->rate'. The value of 'delta_ms' depends on 'meter->max_delta_t'
which in turn calculates based on user defined burst_size it can leads
to integer overflow.
Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
---
Not tested. I am sending this as an RFC because I am not able to 
reproduce the issue in-house and I am not found any proof in the code
that 'meter->max_delta_t' can't have a value large enough to overflow.	 
 net/openvswitch/meter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/meter.c b/net/openvswitch/meter.c
index cc08e0403909..4811af859405 100644
--- a/net/openvswitch/meter.c
+++ b/net/openvswitch/meter.c
@@ -646,11 +646,14 @@ bool ovs_meter_execute(struct datapath *dp, struct sk_buff *skb,
 	/* Update all bands and find the one hit with the highest rate. */
 	for (i = 0; i < meter->n_bands; ++i) {
 		long long int max_bucket_size;
+		u32 result;
 
 		band = &meter->bands[i];
 		max_bucket_size = band->burst_size * 1000LL;
 
-		band->bucket += delta_ms * band->rate;
+		WARN_ON(check_mul_overflow(delta_ms, band->rate, &result));
+		band->bucket += result;
+
 		if (band->bucket > max_bucket_size)
 			band->bucket = max_bucket_size;
 
-- 
2.39.5 (Apple Git-154)


