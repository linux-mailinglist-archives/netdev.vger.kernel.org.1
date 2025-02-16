Return-Path: <netdev+bounces-166733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0DEA371D8
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 03:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76DF16C1E7
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 02:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293BCD26D;
	Sun, 16 Feb 2025 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhAdDnbC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F73BA4A
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 02:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739672733; cv=none; b=EgjlMK+Ipkms4Hk4XMZ7LLMR7FlcrGtsNST8BzZZ+4X+MsAv7/6TSTl5pbf27K77JUBwm5NTpsSvRAfuv1I+aEcTD0SE/ywffceTc4BM3Ak9pxKZcLuShg/dko/09Vweq8lB9MIn27j0oak44rDJqWOHtvgNsBoUFUjuLOB7pXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739672733; c=relaxed/simple;
	bh=KIoynSTrGPbwBhubec3dWE+Kk/BFWUsb1nYs7nKdIV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Eo8ceSbGFfU2Kj7DUw4LIs+k0tdmh/X4qCSlWh3bMaemHakckqtiz4BKyXqSkSloJpAEWOxxP2kADQ+T2t1ahamhZ98JYgMkB8DY42rThRFeilFlYLIgcDBj6webcq9GKmygag5td+veWxGo6KK1kEPuvhgT77b6BQi+hdkwE6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhAdDnbC; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-545054d78edso3496820e87.1
        for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 18:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739672729; x=1740277529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ASrEOVQkEZPh+kN+v1J+KP132rtpIrDrnqwoPnNxMqo=;
        b=FhAdDnbCTfLGsKyB2Zg1P/70T69xxVFIWe3S/8MGL6y0ibg9nsWsiiBlYU75JhDv4K
         u9Avp3HwdAdosDMh6BevGek9tFs6yzfQGTNVebYT//Wohu5FgtMH1gf6YJQg0Z/bVNMV
         RtNLMVABD+vprhwZRK0+buh5C5M8LQB1/SqBP3zSHlWwo4AQL6Nat1w4vgfn6Odmj3M5
         5F3DnpVqt0r8gfaTdmO30w1AMGkQHTUUcGUyNJaaMIKQ28gCxl2Nav9cAdDz/MK6hFcF
         799fDiBEDBp6pXNc5E4tkH8rlgEnOl/HtA3HUGYdh2qwYmV52XRrWavWtOjZ/cTBnVQf
         ZMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739672729; x=1740277529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASrEOVQkEZPh+kN+v1J+KP132rtpIrDrnqwoPnNxMqo=;
        b=VMc2nzV4x3XLiFBARfJXbDGJYOOorFZwh2PgSM7G8ORochwhLbR08XyqJEYl/WI6DW
         spPo02yOvILrKW9El61qSvyYS1SlmYORHRFuJk37umLMRNezD6Rcf/mDLTLnQOIiuEHu
         1cpXUuoTOpZYJajv8LmYMTGI22aV7BlROkISV66/lujEzgCb0ydRO07F3ip1ZmiEG/k/
         773oy0mfPHEKIZVQCC124ERTAyXmBtiAkfl7msnj4yq8TMTPjvkN8FAuSlrt4plndPrC
         zgbyWzcj8KDaybebMAK5G/6BbfvWZVEBgKVm+wG7FGNxkSP+PfxXPSAtAN25qt8P2oY4
         oacA==
X-Gm-Message-State: AOJu0YwCNvkzHVU6A4us17iuk6ONqhINv0fyxDuKubycOvJMtUUs6gn7
	vnpu3W7DjSJAi+RNt45z7t5OiWYzjEQnMDTM8LKgfZ9ANiqRnlbBdHFkR7ahaxR54g==
X-Gm-Gg: ASbGncs7za7z7hLN0JgH4MWLkS4YE2UtmQqP+7H/gYJf/i6bdtLXcu/9BVCzfK6q+dF
	tLMT9/ua1ZM1cbTwSH6IlCGPPYeV8rlmBuw2FQ8KJZO6aWgyHko4gkSinLrkSxrZIij+PpsoU/k
	PjmC1GxkzGApUBLL/WPb5gBjPz+ZQHpRjSc6svl991iJiIFJ2pYPZTSEjeaaIqgNO1npPuMPI2V
	eCbaPMuTxtIaOJBS9liblAYw9mp+5CXEQ7FIVKZY+rSqz8rbkjbZOTtHQ8upX6Rydz6l3KLDHuQ
	i8sC/3Qua/gB/XpmwtBKa2PM6FKuwoJxz/1hsMMWh59Km7dP/NKkx28B6DBGj6Imc+L6YpKV
X-Google-Smtp-Source: AGHT+IGsWwR48jmDHceBazEENbz4yzovPow4fCDUuhPmx/sHdy1RrAkcl69CJqNIdOaBjyhGYnaXxQ==
X-Received: by 2002:a05:6512:ba6:b0:545:271d:f8e with SMTP id 2adb3069b0e04-5452fe6533fmr1220767e87.29.1739672728895;
        Sat, 15 Feb 2025 18:25:28 -0800 (PST)
Received: from astra-student.rasu.local (109-252-121-101.nat.spd-mgts.ru. [109.252.121.101])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5453197f3f9sm303641e87.53.2025.02.15.18.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 18:25:27 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: netdev@vger.kernel.org
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] ip: handle NULL return from localtime in strxf_time in
Date: Sun, 16 Feb 2025 05:25:23 +0300
Message-Id: <20250216022523.647342-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static analyzer reported:
Pointer 'tp', returned from function 'localtime' at ipxfrm.c:352, may be NULL 
and is dereferenced at ipxfrm.c:354 by calling function 'strftime'.

Corrections explained:
The function localtime() may return NULL if the provided time value is
invalid. This commit adds a check for NULL and handles the error case
by copying "invalid-time" into the output buffer.
Unlikely, but may return an error

Triggers found by static analyzer Svace.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

---
 ip/ipxfrm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/ip/ipxfrm.c b/ip/ipxfrm.c
index 90d25aac..9bfd96ab 100644
--- a/ip/ipxfrm.c
+++ b/ip/ipxfrm.c
@@ -351,7 +351,12 @@ static const char *strxf_time(__u64 time)
 		t = (long)time;
 		tp = localtime(&t);
 
-		strftime(str, sizeof(str), "%Y-%m-%d %T", tp);
+		if (!tp) {
+			/* Handle error case */
+			strcpy(str, "invalid-time");
+		} else {
+			strftime(str, sizeof(str), "%Y-%m-%d %T", tp);
+		}
 	}
 
 	return str;
-- 
2.30.2


