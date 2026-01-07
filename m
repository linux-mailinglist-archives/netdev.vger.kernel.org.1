Return-Path: <netdev+bounces-247613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D108CFC4C1
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 08:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 014F2300FE21
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 07:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171461FBEA8;
	Wed,  7 Jan 2026 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3OC9YTE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE25225791
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767769919; cv=none; b=UnTXfKVukWwnUY9dKauOUbaNOEUVkci4w/bsaLnnrWUQysQ3M25MuWTqPSqlVhiPlP2sZF++/kSvLYE881x21xBYbSmTr7uXErlpdHXsdIpcFIkeCVWL3mzV4q2kweDWYTPIW2sHIvPdARs9flswMnNglWoS6/89eAiRXF3O7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767769919; c=relaxed/simple;
	bh=WN4KWu9Z8YPUdjgdEWzrDq++WcBFuYaE18qeAhBUFQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ikz9vt3TVvGJjhPfRkwBe1j8nGurWUw4sM17kTG0wevKQ1THzXv2lqb2ck34PPoZIbMvZEcACNWpeZagF8xqeHcqBOTJaFar2kKKuLrMny2jTCBC/dINKeXN1hHjDbbkBVIQ17+pE2TPO9OPGcVKTSIeBkRDgMWtCrUIyV8P0Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3OC9YTE; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b04fb5c7a7so1109692eec.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 23:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767769917; x=1768374717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qw03kL8k5g6FpQDEJuydGBc7rwkI+zAgYvaC4pQzK1E=;
        b=E3OC9YTEScM3DloWocTbSn9XyLNzxHKlha4lJglShKZtPkiRbe8uzQCBa48lBDB7T+
         6d1cpdRnv9C/AvSdiyu2DLC2UMPuBR+rdCGpJh6D2yk9CKgeXLaCRqJ1K/HtnYxuNoa0
         99xGsTl0n0ZxLkchV8pMTwTxpMzioMJXzvu1CFeujQpj2+A4Em4pMt87fSmq4Zxe0gwz
         ujrtpDzR/aKV9/m48+X3l6VAtKhrU0DBPBNNvKECzG52AAQqHwJkgZyJiZfyIdDD1l3N
         Uj/m1VIeVsIC2ocl/paR3p9PvIvkOincmjgX59h2/Av97TyTcCDxfNrA7UcIZMLZH7ab
         YqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767769917; x=1768374717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw03kL8k5g6FpQDEJuydGBc7rwkI+zAgYvaC4pQzK1E=;
        b=lxNp83wAvPmfks10ueyckJ9eNMjHj7tlVPC9j8RhEfwQTUU46eXqCdmyqDwP2DmkQa
         JNKASg4v0CoNF5/TjtO08Jbvh5B9u0m5FpDG8+wwTn3cIeiNUgduqxPHwXawZGIYxm4z
         5PqUWImZoJnvWNzC0O9JeZReUF8RnLEvL29mpnwwF9Vmk7LwSSLfCX5/9A45Bp3/GcHX
         hcmHfWzgrUuFasktTWrnXZr5ywj+BSUAxnIVjA0Ydf0q1VEsrbJkPBEWVstnHIbEeyc1
         rdjqCv3IlDBq8a/0C+cJt/Oi+U2KIIae6T5F8z4mhBEAtLtKpQifVqqBgzOe/wFL6AFZ
         Rdug==
X-Gm-Message-State: AOJu0YwyAo3kKKgDEVWBKZE3F2o1p1E1xUqI28u28xBy9xw7YjA3qBwV
	/9JyJLIiZ7ShF4BpKVmc/HPfy5I8sJ0Bp75T3LYZ8vSD+L8g6b+XLvZJ2gX+8/dO
X-Gm-Gg: AY/fxX5PfmTTePw2iBZMM9Sc/hYkPacOhVaJpwRJpsLu5R9E6Wz1ii0PEVNOHKLBNe3
	oKdpXEgHbZjlwYlN0L6gfDVLquy6HM1tAfIt5jmjn/PLZburPnYqAoHqm8UwKaFRfo7T4x4BIOc
	a8lh/zp3Frhl9wvOXEkQe7DvMzRC5at71TxdzfI1C9Vgm4R5vHN1oZq2arfvmECmO65tmtlxGz9
	i8A5nVHFep04M/E9Gsd1Cmz/z8VvCWjajV3OzKNVt3Varck21W+IFjRdymsuDfLJsPjGX4ZoKXu
	K6f+u0ik7qTbryPKG87EqIYQ7ilIX4l33MOgz7AYCg8iHyOCLzE81w+hrxefh74lIGqxTxsD8cI
	uBWTtqkLmY0c4bpznDbiLd+yl3xVmJWiPQ/hOs8Xvr/I3FNOb9mgxA4U7Tky7gxv37+NPXeubZV
	G4J2GvqZ01Iz3Qe17it0HCZ3f+4CjVel15R7RaaeREmTCCOu0cJRNLJhMo6aRWlfvN6xr3heHwb
	GY6rhiFhAlw/NexfcqwTrZ3KQAk5EX4Smk9+aPgpSqs/7Y/h4furG3W3DV74EGh7lq+TQ1fBeDH
	KFIP
X-Google-Smtp-Source: AGHT+IFHTumoxGrmooLIYTheL8D/QlOQxxjNoUqx3pYmtECmJliyDvLUzHHiqiprweDws8Z0rK07+A==
X-Received: by 2002:a05:7300:640f:b0:2a4:3594:72e6 with SMTP id 5a478bee46e88-2b17d2f0e31mr1605460eec.21.1767769916617;
        Tue, 06 Jan 2026 23:11:56 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170673bc0sm6450959eec.5.2026.01.06.23.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 23:11:56 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH net-next] docs: 3c509: remove note about card detection failing with overclock
Date: Tue,  6 Jan 2026 23:11:45 -0800
Message-ID: <20260107071146.30083-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The id_read_eeprom() function has been fixed to use a time-based
delay, so this issue can no longer occur.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 .../networking/device_drivers/ethernet/3com/3c509.rst       | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/3com/3c509.rst b/Documentation/networking/device_drivers/ethernet/3com/3c509.rst
index 47f706bacdd9..99ec25225e56 100644
--- a/Documentation/networking/device_drivers/ethernet/3com/3c509.rst
+++ b/Documentation/networking/device_drivers/ethernet/3com/3c509.rst
@@ -177,12 +177,6 @@ While the updated driver works with most PnP BIOS programs, it does not work
 with all. This can be fixed by disabling PnP support using the 3Com-supplied
 setup program.
 
-3c509 card is not detected on overclocked machines
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-Increase the delay time in id_read_eeprom() from the current value, 500,
-to an absurdly high value, such as 5000.
-
 
 Decoding Status and Error Messages
 ----------------------------------
-- 
2.43.0


