Return-Path: <netdev+bounces-79581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D6E879F24
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 23:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159022833B2
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89E54437D;
	Tue, 12 Mar 2024 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="YTQg5fR4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1E641744
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710284111; cv=none; b=PeZK4tzYz47Qt7mLku/5PIIK3t4z62Lg6Hi+5qQrIkqHaO/yI1lnkC1aNM8l572j1b3JskfWSNOA0MgsnIc8Ei2BCHES7fyvKKX2jt7iHZlQSfx5bKh2390VlyEqhn3TMvx+9azyYs7ducKLwlC97vmGjgk0qhsElb+R+PJQbBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710284111; c=relaxed/simple;
	bh=f+1keHxGrhlOVOzqi+hzOYufflwoOaXGi0GBxMo5RHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AT2E+e0MPk2U6k9pkXDOj45mTi12O60165rh3B+xeXw3irc7tQhNLVHhfjRhJsR3o5QXhJjl1dnYY+dOT7KAYHztZPFW1Tt2tRfWRk3yqY/YWGOpviXCoQVakd4cXJVfGTCxxoA50PBom5oSdt35Fw2V+EfznOVoDYZdtmzkfEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=YTQg5fR4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6b54a28ebso329657b3a.2
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 15:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710284110; x=1710888910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAWHcTxAB1nLta9qPuToaMmMW1t9lT6u/KzReuDs/+0=;
        b=YTQg5fR4ea27RB06Ue2R6++x9mKQ1rjBuC0IU1U2J1GKECb/+brHtUymnogmnwgTLG
         Llf3O08tU1p2G+kcT5K6hcn6WKG2CuLXDmy0e6KpSbp5lTNpAIcloyHZTYpMhTvmg2O5
         HLJRXxBWyb2hQI6GpuuUaBGQiupzY8ihGQc4dlSnCqDAe8NDNQNVI+fBGH3+aFgjEcG2
         xVHGTxPPqh29amUVP9KoNtyNJVPlITXoVO3PAhvj6A3ew7nFU/XpePiuwCeQ3GQ3XqEv
         a9bEsx2VEHLIFv+3rK2yNuzcrQ8lWr22gXjlBI+d1BkpoDKJL3ukjN2ozbqK/Bigz0jS
         kq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710284110; x=1710888910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAWHcTxAB1nLta9qPuToaMmMW1t9lT6u/KzReuDs/+0=;
        b=XskR3cjVlkfqrjFV6jJDCc+2v2wbDNJt1Czy2hQWgvUD9UpJrilfgiEjyrlRUgEXpl
         Hvr5iRM+2l0kDen1++SINUTM22sWhdeQPpYkvWiZvy6iKZAoMV+tS1peCt2L7s5cAlXZ
         E9vUfvtMZL2Av9n5KfeYtVjED/HWu9skTMDLmMoiGEuCGRASd2OGrRk+5f8hXAcHuSCo
         kOgWEi4s587nqTKm+kWyBGR3ZUBZe9qgq2DccdV7K6x8TJ2a6EjoOZQp/uE1uEcLxyTq
         MbjPo/ccmjMHC+ESkTUhFHqjuFDpbgt6lTjLPAJb/Duq16yAjF0HXA9f87bXcldB64Ql
         Q77A==
X-Gm-Message-State: AOJu0Yzb2oLqZBFwNnYH5tdp8oADAljHE/NdRggYTG1MniZg0WiTvu68
	ZsReQb3AtS+A11xP1kuX+baP8cdT2VNJcZ6Ncv3jPbbM5U1/1k3ADptc4zTLa2JOcskGyluKyvf
	G
X-Google-Smtp-Source: AGHT+IGUGSzFeT0a2jMSOMH7dinRVLrBvqpRLiLNdG/dGKvGg9G6ojMRNaFbJ1sYRuT2YcbMDVC7ng==
X-Received: by 2002:a05:6a20:938a:b0:1a3:2f74:e374 with SMTP id x10-20020a056a20938a00b001a32f74e374mr1743421pzh.43.1710284109765;
        Tue, 12 Mar 2024 15:55:09 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a8b0800b0029bb8ebdc23sm98947pjn.37.2024.03.12.15.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:55:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 5/5] tc-simple.8: take Jamal's prompt off examples
Date: Tue, 12 Mar 2024 15:53:32 -0700
Message-ID: <20240312225456.87937-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312225456.87937-1-stephen@networkplumber.org>
References: <20240312225456.87937-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The examples on tc-simple man page had extra stuff in
the prompt which is not necessary.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/tc-simple.8 | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/man/man8/tc-simple.8 b/man/man8/tc-simple.8
index f565755e5e11..ae1aec31d099 100644
--- a/man/man8/tc-simple.8
+++ b/man/man8/tc-simple.8
@@ -55,11 +55,11 @@ grep the logs to see the logged message
 display stats again and observe increment by 1
 
 .EX
-  hadi@noma1:$ tc qdisc add dev eth0 ingress
-  hadi@noma1:$tc filter add dev eth0 parent ffff: protocol ip prio 5 \\
+  $ tc qdisc add dev eth0 ingress
+  $ tc filter add dev eth0 parent ffff: protocol ip prio 5 \\
 	 u32 match ip protocol 1 0xff flowid 1:1 action simple sdata "Incoming ICMP"
 
-  hadi@noma1:$ sudo tc -s filter ls  dev eth0 parent ffff:
+  $ sudo tc -s filter ls dev eth0 parent ffff:
    filter protocol ip pref 5 u32
    filter protocol ip pref 5 u32 fh 800: ht divisor 1
    filter protocol ip pref 5 u32 fh 800::800 order 2048 key ht 800 bkt 0 flowid 1:1
@@ -71,7 +71,7 @@ display stats again and observe increment by 1
 		backlog 0b 0p requeues 0
 
 
-  hadi@noma1$ ping -c 1 www.google.ca
+  $ ping -c 1 www.google.ca
   PING www.google.ca (74.125.225.120) 56(84) bytes of data.
   64 bytes from ord08s08-in-f24.1e100.net (74.125.225.120): icmp_req=1 ttl=53 time=31.3 ms
 
@@ -79,10 +79,10 @@ display stats again and observe increment by 1
   1 packets transmitted, 1 received, 0% packet loss, time 0ms
   rtt min/avg/max/mdev = 31.316/31.316/31.316/0.000 ms
 
-  hadi@noma1$ dmesg | grep simple
+  $ dmesg | grep simple
   [135354.473951] simple: Incoming ICMP_1
 
-  hadi@noma1$ sudo tc/tc -s filter ls  dev eth0 parent ffff:
+  $ sudo tc/tc -s filter ls dev eth0 parent ffff:
   filter protocol ip pref 5 u32
   filter protocol ip pref 5 u32 fh 800: ht divisor 1
   filter protocol ip pref 5 u32 fh 800::800 order 2048 key ht 800 bkt 0 flowid 1:1
-- 
2.43.0


