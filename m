Return-Path: <netdev+bounces-90361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE478ADDF8
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 09:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020D91F22B12
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 07:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0762C190;
	Tue, 23 Apr 2024 07:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3hYdkH7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7528DBC
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713855909; cv=none; b=R7mCYz0MauPGOWTrrN3SLVa71IKmvQNthWJNv4zpjH1p76JV4KZolxNccrzk/KtqetGW6TZ/riEcnmkGooyEU5vUqq8BBxid4TSivFBe6AgVKsYi7M3N3oDP6uhurZFMPUzm4kXL6ubPBnELxJPWM2ioa/AEiIVOhy4/vMpBcHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713855909; c=relaxed/simple;
	bh=milJy/hChBIXc/04Da5S/85tCIwYKn0BJEaS1othb0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aaxocbKELM1swLkA+2gXOeuAKj5tK6h1tUVYCm5sz6xs9LOAnr0oBJOUMQ4D4rXwL+h+NPuSaE4RpX4wm3qGovcv2RjqjyU3ipK6yRGqVb4xoYHohzmwCvQz6nzPEHJoZorMTIuQcNaKHwzIS8Omvq3vf9o/awVS5LjoFFzqwHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3hYdkH7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e40042c13eso38618895ad.2
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 00:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713855907; x=1714460707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W24cBgwZJ5NJChHJxn5xxRRYL+4YKeuKelHoBEGNKJM=;
        b=M3hYdkH7YH2D2TCdOdaZbhyLIU6jDwbX6v7ES9g/AETvHMlsfc9kfeD7KOt9KhoAcd
         MNaRJEK2mhPvVQNR7Qs1VhXQurqmKrXwYkaQ0awVgJ77itlcEV+ogfO/rgz+B5VO92kT
         80DRnqIwSd3Hy9jCYGSEhQ1KV1m23btfbmkrxclwq2K2Y+1vKbGJKPZPmLoeI8W04FaO
         tmAkL9oBe5I8PrZvIhIhfQgEh7iZLwRtn2bk0p6fGEbTTXQJuPwMgwsN7W8+pE0utVI3
         cQLpKVdptHhHdyP2fvbnqCLVkHYRfSV65MkttbP/gg63cuIbueg3dtXPZY1Ot7GbBI9o
         IVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713855907; x=1714460707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W24cBgwZJ5NJChHJxn5xxRRYL+4YKeuKelHoBEGNKJM=;
        b=RynU65e+p9NZNLoXV6SNNVNat+QVsP42bJ9F9jS2x5P7Kf9ay3cvKDmDmV2R67Vf2N
         wE0/BWdCI6+4ip91mvFXGCXi/i8P9D+csPzuVhvElKBd1xbsXgERJ5u4belZ+SFfbCSX
         KGijPugLM+LIlHyO3IbCutlbYOFfTgcsuig2nr3XUpSJTaIMKnnL0qeZ2D4YHjF5GOfp
         iz8v3TgmTKpfFwp5nnUet6kNmC1qjF61ZGQAeqEvl0DKpU9sXQJDDSSq/6E402nNHhB1
         P20gMztyg8H886rNRJqnw2iLoxldvoyi7Zg+Zf3B5iRvD1vMzMjORNwZafxS/tVoAxcO
         IWTA==
X-Gm-Message-State: AOJu0YyyJ1FrfEh8VqhSzOpd4HPhZC6DHG3UaEEfqygN+vcoaAKKbQUT
	zJFjc/K0UVvJejnz+rCfZeL4U5IcOKhtMBwjiZi+TOF2mK4X6QyG7ofwNKNJJg0=
X-Google-Smtp-Source: AGHT+IFDwYVwXq17MTcOel3inMmKC+91lU8s4TfsXsrWASNbwODfHmOOdDedeLeQePb479Rj3hUHlA==
X-Received: by 2002:a17:902:e54d:b0:1e4:9ac6:1f3f with SMTP id n13-20020a170902e54d00b001e49ac61f3fmr14753677plf.5.1713855906581;
        Tue, 23 Apr 2024 00:05:06 -0700 (PDT)
Received: from VM-4-8-ubuntu.. ([124.222.65.152])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001db66f3748fsm9284497plh.182.2024.04.23.00.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:05:06 -0700 (PDT)
From: Jiayun Chen <chenjiayunju@gmail.com>
To: netdev@vger.kernel.org
Cc: shemminger@osdl.org,
	Jiayun Chen <chenjiayunju@gmail.com>
Subject: [PATCH] man: fix doc ip will exit with -1
Date: Tue, 23 Apr 2024 15:03:46 +0800
Message-Id: <20240423070345.508758-1-chenjiayunju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exit code of -1 (255) is not documented:

$ ip link set dev; echo $?
255

$ ip route help; echo $?
255

It appears that ip returns -1 on syntax error, e.g., invalid device, buffer
size. Here is a patch for documenting this behavior.

Signed-off-by: Jiayun Chen <chenjiayunju@gmail.com>
---
 man/man8/ip.8 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man/man8/ip.8 b/man/man8/ip.8
index fdae57c5..e7bd9eb4 100644
--- a/man/man8/ip.8
+++ b/man/man8/ip.8
@@ -405,8 +405,8 @@ If this value is 0-6 or 8, chose colors suitable for dark background:
 COLORFGBG=";0" ip -c a
 
 .SH EXIT STATUS
-Exit status is 0 if command was successful, and 1 if there is a syntax error.
-If an error was reported by the kernel exit status is 2.
+Exit status is 0 if command was successful, and -1 or 1 if there is a 
+syntax error. If an error was reported by the kernel exit status is 2.
 
 .SH "EXAMPLES"
 .PP
-- 
2.34.1


