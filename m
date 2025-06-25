Return-Path: <netdev+bounces-201129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359DAAE82AC
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 14:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777C73A58B8
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E572609C2;
	Wed, 25 Jun 2025 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI/e6nso"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921E425EF8F;
	Wed, 25 Jun 2025 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854349; cv=none; b=uOvrnnIgFORGpD+ITMCp5M8nZSfD+EPjR5dv/ru2QQDuPgLYK8nLWu7nZu33su0uwq3BXihYplQvYT5PIxxHqw03O8ORofgMryC+XbOhV3JvA6QqeC9N7jfCqhbh+6+y7ZXW0P8Eq/shDpzNgF0h0Gw9kJpPy95Ue6LSfIyisX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854349; c=relaxed/simple;
	bh=GWlhp73LNm/7EbO3DbUYo/TyoyteULAA+bKvzRvitdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FLI9CuM4w1WZush1+cHt/P1G5A4jhOhMo3NsvJGnjVh1p1ul82tcyIj6r3CMLGN2V+Lo7MJ+XRk7IPfkkt1JH0g1M8rrheSDs5/bUOSYbj8+/FGVc42ZLdMsLuaF/0Mgh0I4Gs8NB9fvl0NE6DuHLKckVuIP8N763XAim4gOJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI/e6nso; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-237e6963f63so27646925ad.2;
        Wed, 25 Jun 2025 05:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750854346; x=1751459146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gK8Hp/mA0/WB+LCIYX3QIzvfFd0YpHU2lftvUglJLEk=;
        b=AI/e6nsoLKUx+iWuYt2f/94E9X5rQPiqg9t+uIjN3jD0U8Gk5tdz8/H12ENO2VaNtD
         aMRst/y384qHnr9w7+PKVyike9C8kHj/5aWqq4LH0uWYj54Lqfl8adVqfA7qKKajFtUY
         gHeR7IeXz+yy8OsjZrM6V9TTqzIM4j8zdJ9uNfkqcFuqpq/M/rSU6orgCviMaNOca2hA
         kJFmvQqRHGwWmPXQh1yHECuz6yDvINxXsmiPeUOkwB0S8fkwF+JK/SYSZSBk9UsqENoa
         id6+BjrlpkxZFNlWu280qZw+MvVrq74wovackoPy50bSWbXO/33VHqoTONPnWERocmKD
         SQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750854346; x=1751459146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gK8Hp/mA0/WB+LCIYX3QIzvfFd0YpHU2lftvUglJLEk=;
        b=UB732ojk3QsPiDp+Lb5rpHvJVFz6OO/ERUm7XcpeU076aVkmzaMTDLq7l2+eVqD+/J
         wcvRQ/6QAJLCSXh0Ui9ZUzDGynL3a1VhrxChtnH3365i5X2oobQGP8BJ1hQMAH6VrlY0
         rnEQAGNj/yhqj07oEUfamLXg9Zpnq0oNKi5Cr+e4+nTk5yO0YJOf8xM6HqRCZcDJo08g
         NfPmitthd0/MQBG7Lp5zJH2TBh1UBEVYdMNLs1MQhXrDTE3tWoVgRgTCshoQdL0fJcRT
         h/Zc+sVzOU6F6cVngbHLmeSDi1lZBeb1r6u11XygatxNc6ImB3iE9rFKBbfxnUnY3ACi
         R5MA==
X-Forwarded-Encrypted: i=1; AJvYcCV0/LskhkyJHYVtgtp8QKz+7LAXJMtL4Z7QSWGK5UH1Of0oud7Cdyx7Uu1giM65ym/geveBQQv0C4ZOlxq26Lw=@vger.kernel.org, AJvYcCXH+Dokr9M2ytngjMThbna7XbpKWo4BYZizzqZD3qYcvAbQwv8ma3vpagsASQ4citf3SO8WcGYcFQtfrG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq4hL/0HQtQPEUHPlsQT1zHPzMZFuqOjDlKu22dMbYE5fDNpaw
	j6OdTcZXvrWT+BtsZc0amaFvsrN+VhgEQXwgHqtgYFMTKXgGyXowB0JY
X-Gm-Gg: ASbGncvGXUTsAoTRXNJZtDX7GYx6BUwrkfhPaeePpA1J0mJNP+27+dml6NE7K+CBDzo
	SLNY+qxPw63KJlct4dGT29tCEE1nQaRooS2/fQUm016HY4LwHZ5DftiDqVtMlSa/mVEsdoSpkNe
	s25kHJRcJir/brs/l4DOckWKrgHvlNG6yMOqAzLGzv76OEEoAl6uZZIG9rrZqO5n4rsm/0fqso2
	V2gBVVnXPJKIgdrf3gvte4k9M10Wz6/2Hg9V68MqFV5CPmeTopqD6hftm/e3rYD1/77+EmiyboV
	tvNIWEPRfmAQvdNJU8zAFnkY8BQXF+CefNNzzp1uItlv7UdrWF2b8LP4BD49QTlrh5n7mFlFaU+
	ClUKfpxebj1djc935sTJ4MtiAs7l7lDgSALuQJfZHprSBggIQzNfXJ0Jk
X-Google-Smtp-Source: AGHT+IHtv4E8mTXtJhjRtDr/sOzVXJ8chAiqbXjdQq30k70nkAEaKLwRixvhgJfDtHBn2buXrkIWeA==
X-Received: by 2002:a17:903:2f10:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-23824044733mr56789135ad.29.1750854345794;
        Wed, 25 Jun 2025 05:25:45 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([50.233.106.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83ea243sm137551405ad.72.2025.06.25.05.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:25:45 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 25 Jun 2025 05:25:39 -0700
Subject: [PATCH net-next v2 2/2] Cast to the proper type
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-correct-type-cast-v2-2-6f2c29729e69@gmail.com>
References: <20250625-correct-type-cast-v2-0-6f2c29729e69@gmail.com>
In-Reply-To: <20250625-correct-type-cast-v2-0-6f2c29729e69@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1750854341; l=1601;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=GWlhp73LNm/7EbO3DbUYo/TyoyteULAA+bKvzRvitdU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLiFIDwSMOyJlQHnf/QjQNXkpiIIChkOhXZtBSbgofNDN9br92N6eAa+Mq90ITZAPwF3itPMtkc
 2hu6u7BX0eQI=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Use the ffi type rather than the resolved underlying type.

Acked-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/net/phy.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 9b4dc09403e4..5fa6b7e97887 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -163,20 +163,20 @@ pub fn set_speed(&mut self, speed: u32) {
         let phydev = self.0.get();
         // SAFETY: The struct invariant ensures that we may access
         // this field without additional synchronization.
-        unsafe { (*phydev).speed = speed as i32 };
+        unsafe { (*phydev).speed = speed as c_int };
     }
 
     /// Sets duplex mode.
     pub fn set_duplex(&mut self, mode: DuplexMode) {
         let phydev = self.0.get();
         let v = match mode {
-            DuplexMode::Full => bindings::DUPLEX_FULL as i32,
-            DuplexMode::Half => bindings::DUPLEX_HALF as i32,
-            DuplexMode::Unknown => bindings::DUPLEX_UNKNOWN as i32,
+            DuplexMode::Full => bindings::DUPLEX_FULL,
+            DuplexMode::Half => bindings::DUPLEX_HALF,
+            DuplexMode::Unknown => bindings::DUPLEX_UNKNOWN,
         };
         // SAFETY: The struct invariant ensures that we may access
         // this field without additional synchronization.
-        unsafe { (*phydev).duplex = v };
+        unsafe { (*phydev).duplex = v as c_int };
     }
 
     /// Reads a PHY register.

-- 
2.50.0


