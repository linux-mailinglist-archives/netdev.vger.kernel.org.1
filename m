Return-Path: <netdev+bounces-196523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1396AD51CF
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 12:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E53F3A2F98
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28CC228CA3;
	Wed, 11 Jun 2025 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXnEMOaW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112DF26058B;
	Wed, 11 Jun 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749637732; cv=none; b=COrH8aYcjgBJvZgyTKN7CHsCp4fSJ9HBLXs5YahxzN8EleCcvFj+ekesBYe7VAsKMo+0TIMCZv25sMX5UT0N5XMkYZbyPVEqj5ypyNPy5+9IoFx13h2qIqhLmJtAa/3N9nZUguyChe4tG8zt+FysVweLLo3BkBzMx5KUGkh5xUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749637732; c=relaxed/simple;
	bh=IDRc53NqDCpcrV6aw56Dpua8MOPqDY4aqlcO9iCxAQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SE1qNDPplKcx9HnR09NH6yIR0GKK49PkJMrgncdBpkvgNQNEAHzsCrN4DARxk6PoCZ9uw4Ir+BzdiyvfzohdOGOjNe9FcMiWXQ2kQDCWmEjy+KnklQ/tWrjpCZpeus2z1B6WOHXsBhr8UfiKbJ8ghgrC6J3XfgIVT4u+4zdw9VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXnEMOaW; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a58f79d6e9so71148591cf.2;
        Wed, 11 Jun 2025 03:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749637730; x=1750242530; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=znsXXWlpLwmtt17S+WR/1ngYo4zWZtKruO9NdSqNJUI=;
        b=KXnEMOaWR7qmGyYDjKxpodp7WHjZEBw6elAROZBwtSSBlMkoHhvkh9j1VFYBLAa+dv
         sD8olYWIvPQQtmmTl7QIok+m4aEQfez4HlkIE/7Ur7b3yFbn0LRZJprGbU8b3Z6Qa/UA
         9zcfi1OSjJ4wlcoGG5+T6iW9/ajnlOOGs9qKYGERDGjhEI8rtm7i5bQpYctrsPegvU59
         EbCzRDk9ihR7r+ti/9Gp5cduF4pKgy7mr6RumyjuarSuKUP2lxH0m1nvH5jnfk1QdKoh
         ytgv0jFR0CH7EJwPb9NSq3tw823Ta8QTJn/njHDIhuwB7MuaX43gTrJxGKGXPXiGxcHQ
         KljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749637730; x=1750242530;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znsXXWlpLwmtt17S+WR/1ngYo4zWZtKruO9NdSqNJUI=;
        b=j/qQoU4XEWp3/Gfz/He+Zln3G9S0/tzmXM8DAfHUVdxTDQtCnGNLfnNtquigmxk5zA
         KfZGo2rNRolmHeqXTm+bpPgWats2vRMCSGAcMG7+8LyZSC52k9+EyB87ii3gJvzw5Y5z
         C51wtS8GbEJxMYG4H1Z9vdlPAC68zvhcDKaG93wYQB0g5MJtk1i+Glt2IOHrmGRdKDZE
         cubU8YZfmtkRqat2A6iCycZg13JtTeiJzsQWkxnvfk7Rs2nadHmF/w7Xlek1kTe+K7yO
         3dj7Jg+EisrPurClKlzYkauIUSbomZmursPgXZklt4XKu5KawgAzdMDXgY7YPMVu7MOt
         KWOQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4TNXPSV7566T1GIt95zInLF1g0yPco2erH/eWMgXHgAsKysg+PR5fGMC9DAlgRbvxQatzdX2SUMM/Gjs=@vger.kernel.org, AJvYcCW8IxLgW3n1EOt1XVG267EkzVjMKUAFQANMfmgFCU0BFX0sF+LnFq2bOEs2rt17f0L2xnrDe+ovsjx2/v88ZPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxggVBJ5c5daglsC8W40kZmVQ9AR2lukbFmT7Xp97AVVuiEAnY
	RMVUVTGDMRuUEpImtNsZ+eNetJl94/7p+/VHigbdIXcHiuzgtboeN1EO
X-Gm-Gg: ASbGncu1YkOHW8BLwlDG+D3n1FqjOYh3RZLBJNmqvccR/ZLYwG0XrZ2bwLdOTdT/qvr
	7T06Dkg4ky/XhdcdR7nOQ/WUQh76AdLB2e/M2WPQoX/JJaLe6Hkz9iAnqd3fChDdmXTBTpP1Kcs
	u2iwBAAUSSlcZLCMbMoli0hCSZxvan4w7Q+5wK81EsYvfnew8xzYvrk0woOc7bMHgXWdlfYlbph
	wv6KW2RyI6bN31QjAptXeH2sfG7Nafo0yeZLwEKrPDTl3JB4ry14ktUTwES45+wQiXSTL96kHMW
	g6t/Zd5sYh4ic4uFAR4+wpawXf7bH/69aQuZq8gOevSuJ1i9yg6qMAlWE8u24mCrCbsxCyM8yaj
	ejQ==
X-Google-Smtp-Source: AGHT+IGqC9BsK9jAoZAYq7RLvabUq3cm7i6vxdBqy8Qr3HtuK5D04J+G6xhx7ck17XOA+7RI+agCYA==
X-Received: by 2002:a05:622a:7908:b0:4a7:1402:3b3 with SMTP id d75a77b69052e-4a714020447mr28368911cf.11.1749637729813;
        Wed, 11 Jun 2025 03:28:49 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([204.93.149.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a61116bfe7sm85555311cf.18.2025.06.11.03.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:28:49 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 11 Jun 2025 06:28:47 -0400
Subject: [PATCH] rust: cast to the proper type
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-correct-type-cast-v1-1-06c1cf970727@gmail.com>
X-B4-Tracking: v=1; b=H4sIAF5aSWgC/x3MPQqAMAxA4atIZgON4A9eRRwkTTWLSlpEkd7d4
 vgN770QxVQijNULJpdGPfYCqivgbdlXQfXF0LimdR0R8mEmnDA9pyAvMSF5GYa+8z4wQelOk6D
 3/5zmnD/zAJzEYwAAAA==
X-Change-ID: 20250611-correct-type-cast-1de8876ddfc1
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Use the ffi type rather than the resolved underlying type.

Fixes: f20fd5449ada ("rust: core abstractions for network PHY drivers")
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/net/phy.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 32ea43ece646..905e6534c083 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -163,17 +163,17 @@ pub fn set_speed(&mut self, speed: u32) {
         let phydev = self.0.get();
         // SAFETY: The struct invariant ensures that we may access
         // this field without additional synchronization.
-        unsafe { (*phydev).speed = speed as i32 };
+        unsafe { (*phydev).speed = speed as crate::ffi::c_int };
     }
 
     /// Sets duplex mode.
     pub fn set_duplex(&mut self, mode: DuplexMode) {
         let phydev = self.0.get();
         let v = match mode {
-            DuplexMode::Full => bindings::DUPLEX_FULL as i32,
-            DuplexMode::Half => bindings::DUPLEX_HALF as i32,
-            DuplexMode::Unknown => bindings::DUPLEX_UNKNOWN as i32,
-        };
+            DuplexMode::Full => bindings::DUPLEX_FULL,
+            DuplexMode::Half => bindings::DUPLEX_HALF,
+            DuplexMode::Unknown => bindings::DUPLEX_UNKNOWN,
+        } as crate::ffi::c_int;
         // SAFETY: The struct invariant ensures that we may access
         // this field without additional synchronization.
         unsafe { (*phydev).duplex = v };

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250611-correct-type-cast-1de8876ddfc1

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


