Return-Path: <netdev+bounces-136023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322ED99FFC3
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 05:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665B01F2165A
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527BF189F57;
	Wed, 16 Oct 2024 03:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHpJwzws"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D412E18B48F;
	Wed, 16 Oct 2024 03:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729050831; cv=none; b=OIxRLTgUKoy4S7uxqta3R9gECqy/cD1hzNWSoA4zswH1kWt2NTr+Iis+Hci8TVjEdQ92LsgeXyJr3vLGes1OdmKjMcbC/QLkE5PsgWvxW/cUhtGLYB7PDASnrlBke04sped/BwT1wRlfzvlGoVhKe4krBobDQ4M198ZrqZbshEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729050831; c=relaxed/simple;
	bh=oO8kIoSHWWi7gATVjc5bDLg8mq2ATSDBxjtZ1uzqZCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AulVPxbepM02+SoiGntZsWDoWj6m1r4lQ4IKOsdm1vxVulQgnbTLvgXqNVrGCscQD32vzUZk3PoyUTWiM5EJR6HeuoD9LFkwCLZpUB4qeMY6yyhHba6GzUcDmij4CxW84pRgmmd6oiq2y+QPr4ibtgIH/XDNLrFo6EaJILd+LYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHpJwzws; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e28b75dbd6so4321928a91.0;
        Tue, 15 Oct 2024 20:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729050829; x=1729655629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHwlHcER/lC/9sWgy6T/4Ohgbzy5c4D+iN/+N5JPfic=;
        b=gHpJwzws2tuiRs3M+wlPd8vmxEyFpZv65wtYe6TPHY/TaTA4rBncK68oe3CKrJdABl
         BHEiOPcxq1TFczoFnT1fKhlC0qetw40zDy+QV5ekZ7b+/uwlzkNdb/J95z2pMgWOZQx8
         E/x2TvzRLqn0Kdu8ep9Rp1OxWXNktIID3K87j8sB4NYsauAWFIDAhWzL7LjGncO20NBP
         OY3mKZxuvY3xYvZmP5Y+OOT/L9qrEYLjLU79/GwZIiBso2kWUFQVB25IZ9Om6QyXffOL
         Rgc+JLedfGPcSLwL1tBl97f+jYfuhhOZYSNMdzoiU1RjhhMZw5PcIAT/C/aCuqtmbpBR
         NTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729050829; x=1729655629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHwlHcER/lC/9sWgy6T/4Ohgbzy5c4D+iN/+N5JPfic=;
        b=jFwx1fOHDomwetcNnGO4TPPEFEd4YwwAN9+ZpSsLv8Aht0T3yjBAjLV262ClX5tBsn
         f3n48JbPO6+uJrDrFePBaZo9xXgPbELuZ9BVco7NU7/IDX03v2NqqozAKeXqjwK5kOd/
         FKN66S/rp/XZg5ezl3TpNXpFDsH7tanVVGKVT44wmkomyH9upvOZZNra71k91rFvaOCZ
         3tXH8N+EyZSoCBTa656jkk2UFDGQ4jTOgbPa+R3Z5l8bI58UsaLIMVdQFNE6RUCeFdBX
         +PlL8sAGhGve4OSRF0h/la4QQmg/l1GXNFCB53M/b4o830sDBa+ziQxH/XsGVXYPkq+O
         cHNg==
X-Forwarded-Encrypted: i=1; AJvYcCWsz3hASlVGMiNGs0S4Ir88gkNp1kx7YpwwO/Ytx3zptVdReq/5JOhPqlLZ43v/3kEhC7bhNScITIgPybM=@vger.kernel.org
X-Gm-Message-State: AOJu0YymOP3+EgjeZpI2ms//oaSG/kzGAqicuola49vqTgnzTsQJr94X
	yoHs0kkiJbpImKEkLbfxHt5WFRapPxrTwW6Bb7mvYlphiwqsZp0DmCQyX+sn
X-Google-Smtp-Source: AGHT+IFuOalD9KF2WAnb9fVbVduiq+Te+F77S13d6FsanJftfnhzfksVT+LghStx3FKQWiNlidzggA==
X-Received: by 2002:a17:90b:224c:b0:2d8:3fe8:a195 with SMTP id 98e67ed59e1d1-2e3152b0100mr18083336a91.4.1729050829007;
        Tue, 15 Oct 2024 20:53:49 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392ed1a4fsm2885691a91.17.2024.10.15.20.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 20:53:48 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	arnd@arndb.de,
	jstultz@google.com,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 3/8] rust: time: Change output of Ktime's sub operation to Delta
Date: Wed, 16 Oct 2024 12:52:08 +0900
Message-ID: <20241016035214.2229-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016035214.2229-1-fujita.tomonori@gmail.com>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the output type of Ktime's subtraction operation from Ktime to
Delta. Currently, the output is Ktime:

Ktime = Ktime - Ktime

It means that Ktime is used to represent timedelta. Delta is
introduced so use it. A typical example is calculating the elapsed
time:

Delta = current Ktime - past Ktime;

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 38a70dc98083..8c00854db58c 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -74,16 +74,16 @@ pub fn to_ms(self) -> i64 {
 /// Returns the number of milliseconds between two ktimes.
 #[inline]
 pub fn ktime_ms_delta(later: Ktime, earlier: Ktime) -> i64 {
-    (later - earlier).to_ms()
+    (later - earlier).as_millis()
 }
 
 impl core::ops::Sub for Ktime {
-    type Output = Ktime;
+    type Output = Delta;
 
     #[inline]
-    fn sub(self, other: Ktime) -> Ktime {
-        Self {
-            inner: self.inner - other.inner,
+    fn sub(self, other: Ktime) -> Delta {
+        Delta {
+            nanos: self.inner - other.inner,
         }
     }
 }
-- 
2.43.0


