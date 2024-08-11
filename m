Return-Path: <netdev+bounces-117513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A8C94E256
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 18:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D831C20918
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB731537DB;
	Sun, 11 Aug 2024 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="vFp97ioO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CDD17552
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723395313; cv=none; b=b5/KH2aNmrY7bXbpgt+SBsvCSUNyTSPJyr38+2CRL+CchRZn2aGJ1zkOK9VjHRgUHE8ACWxwPnSH2hnloo6c0ckiUG2m8CSKRVXRWQRgvb/1S8trbmC5knE6QrOsX8qMTpNLnMMRovYCQIh/BcmWcyUqAIFmDITFEO9PuVHLPnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723395313; c=relaxed/simple;
	bh=gpDVLqtVtGtsMEghmW/Ps6M4S8n0/VOMG87fkRJYB2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=De1bYyYUC6SMLs7EdwE/ixk9CWNA2mUVwtSzacS24OA85fbur7AfR0QEo7N21/iUM1TPVurXcaZBfoEmQec48koWBt6y5s0PpX142EtJAWYBMc14e09n7p0asFujZh//s6fraXh7/x/6nJUXbUSVSIqLP3zdzkauq8YY5QMbsag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=vFp97ioO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so3381385b3a.1
        for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 09:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1723395311; x=1724000111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8gPb3fWluRf96j/RzI4M1rebGfclpZ2gSoUOj2ePA6g=;
        b=vFp97ioOwQIpmueKRSHJ6hsgMGDfghRzmf03kruxmniL5aD18HyvhxOJPaZSz9jiPS
         AhaO/hvIHMHuAcY7+8BWkMupDnm6Q+yEHFIri7mXLaDXWb/lKMHS+jMScm+U8xLbtmY3
         dP+X1t/hzrThuZLTDnImxqRHePROYN1QJS/mPwgm5P5N9EbzgwPb6RFYuMM9pzMOWKaR
         789mxcuZnSB+5ZUI9aWdymOnJilsmj0se/1rIEj5Uq7e9puQJMUH7Yrhn88Vog8xEM+t
         OQIfKRK0tuZ3zQmbJ3GaMdJk1QK+dpDeLNeLvDPRrYgXhDdS45hiCbYuj0cHuxpjqNf9
         W3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723395311; x=1724000111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8gPb3fWluRf96j/RzI4M1rebGfclpZ2gSoUOj2ePA6g=;
        b=CJK/ea5OwVoEjhodVQo7M3/dzlrq4JPSCgKf9rgDD01PXi3xJXCTeG+0NuIxKqkUHR
         jQpph9TycKQrQvH1aJh3PLn/lkPAEyl+Yl21yT+km4BCzLlChRqd3STtSGvHrSx9pQXi
         UtKgMoqjfayuOMjOD2PUSPTIAXMHMbeWQ+kCCvgJl5e1hmwSf50Epvw5LusaX+gQ06zh
         FphMUaui4esNm9ngZPVTc7E7ILvMhIflaWRPPKLfd5fNAvzNBFqf72rZUKcf/Xj5sCMm
         fWImt3SSYFAfdIZF6QCQCWEc/sLaa7a73kdBIYFjrHmrrzElYLh7GBKGWOFlCvXIAkt4
         /bjQ==
X-Gm-Message-State: AOJu0Yx8y5WwPW6Z2LBnm01jt055f0dWr9rhiWPZv80aIwFInLUoExEU
	Cx5e6y3PnkHMS75s6UkHu/bjbT7rpmyl/DNQW7ybQuevxmsnWRQx1wHZp58Y5aFvyzsqueDsKi/
	4
X-Google-Smtp-Source: AGHT+IGqz/z0sOk8gnSvgZF/dYkO9Yv63IOqdthjNB9GSQ5kQ+11gGepgkRKG9EaMGVReHqaXvzoSw==
X-Received: by 2002:a05:6a21:1193:b0:1c3:a63a:cee3 with SMTP id adf61e73a8af0-1c89ff2128dmr9972091637.13.1723395311073;
        Sun, 11 Aug 2024 09:55:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a89e22sm2655315b3a.170.2024.08.11.09.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 09:55:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute] man/tc-codel: cleanup man page
Date: Sun, 11 Aug 2024 09:54:44 -0700
Message-ID: <20240811165501.7807-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of pre-formatted bullet list, use the man macros.
Make sure same sentence format is used in all options.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/tc-codel.8 | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/man/man8/tc-codel.8 b/man/man8/tc-codel.8
index e538e940..7bf08667 100644
--- a/man/man8/tc-codel.8
+++ b/man/man8/tc-codel.8
@@ -22,12 +22,17 @@ CoDel (pronounced "coddle") is an adaptive "no-knobs" active queue management
 algorithm (AQM) scheme that was developed to address the shortcomings of
 RED and its variants. It was developed with the following goals
 in mind:
- o It should be parameterless.
- o It should keep delays low while permitting bursts of traffic.
- o It should control delay.
- o It should adapt dynamically to changing link rates with no impact on
+.IP * 4
+It should be parameterless.
+.IP *
+It should keep delays low while permitting bursts of traffic.
+.IP *
+It should control delay.
+.IP *
+It should adapt dynamically to changing link rates with no impact on
 utilization.
- o It should be simple and efficient and should scale from simple to
+.IP *
+It should be simple and efficient and should scale from simple to
 complex routers.
 
 .SH ALGORITHM
@@ -57,7 +62,7 @@ Additional details can be found in the paper cited below.
 
 .SH PARAMETERS
 .SS limit
-hard limit on the real queue size. When this limit is reached, incoming packets
+is the hard limit on the real queue size. When this limit is reached, incoming packets
 are dropped. If the value is lowered, packets are dropped so that the new limit is
 met. Default is 1000 packets.
 
@@ -113,7 +118,7 @@ interval 30.0ms ecn
 .BR tc-red (8)
 
 .SH SOURCES
-o   Kathleen Nichols and Van Jacobson, "Controlling Queue Delay", ACM Queue,
+Kathleen Nichols and Van Jacobson, "Controlling Queue Delay", ACM Queue,
 http://queue.acm.org/detail.cfm?id=2209336
 
 .SH AUTHORS
-- 
2.43.0


