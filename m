Return-Path: <netdev+bounces-184023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE31A92F70
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C8D1B66456
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658081F8AD3;
	Fri, 18 Apr 2025 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="lNSpkuJR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EB620297C
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744940548; cv=none; b=H1uVkGLoRXb9RqbMuWnaBc5aVIm+4qE6b98j5dDQlJa4tA8yEgbdKnYiDZiAGYV/ChM2Q1zwm8eqej0ha0Yc5A2I8xrENuyQstlFdHxVFh9PF0TiQF7jmjntPX6xagoh+VBfNhiEmsq07WS1SNS0ndmRQ26Kzl5RTitQrUSN0O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744940548; c=relaxed/simple;
	bh=OjAsY8Aeq5Ueru5ZAiLzHF/EyHc73z1XNs7APpOHEWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2hhaAH22neGvlOjXbBYNB+kZIuWiT3A28JNVyU1miCXS/yst2ssY7h0tw6sJOkznlqhks+eKdxynkqJhESEtUXvsaAavTsC3B0LPSaQJD/7Zl8VRfMXNEp3YyqDn5z1Hq4AXspUAAgVhz3cs51lEzeRGx59zoqje+NMiwxs2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=lNSpkuJR; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7043db8491dso13822107b3.0
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 18:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1744940545; x=1745545345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACdKqDtHD6BESg+aNrA5JEShMOuHrL3BKvU+zPowCQg=;
        b=lNSpkuJRc6Z1epKiGSFMcxIF8xXhS/B+f7Dys0qh7GDvBwCQGsJjhZt4hEBWq8DM0a
         sXMtpLSbG3mZOSk+MCA3kImFHJH1DFosBiqnY8F+T49Ba4gmTDRZKfmg2bk0FQy/rbYL
         4NOjEdlPGklM0oANxSRewrDs1PyXlmC58ZPg2ypkDmFSIrxlhCNOF4a3Hf6K27tjqOIB
         YqvHl+i3zvtNYbrMof3RGMRC9Wo1fIAY541CKWh3j1C6F2W8cMbaSaK7SWvdZpgOwi/E
         s4jLvUmtNr2EuhIu+1raKQVZ1Pu5Y+e0sXdZAx/OQjGsFWYP7/nQVNlnWV7DzuU96iIR
         IZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744940545; x=1745545345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACdKqDtHD6BESg+aNrA5JEShMOuHrL3BKvU+zPowCQg=;
        b=PoiOxTxJFkZXOFm3ntzF62aluBj1Yh/yqtOXe+z1pph4A/HH0Hd9vidSBpOu1lT1Aj
         wT4wZNWQj8oK6WWo/KTY/zioGo9gpg6BES7jtC/CXD99uF2+r03GjKMiz1bwsjEaEfj4
         EvPOodxaBS+5fpGTOz+CVOjtACflqXf8ErYlF2utk30U5evBbJr++jb8AHgH2++HV/1z
         hMm0N0c9u50k1MLDraM/vQuBAUvTZTxMSSXmptcJS00/GCFFg95EQFHAr86BqUeGqmSp
         943vdY9SDo8thBKGIwNEVsdMDqQFhEIO3ZmfnQtvS4zf0C3uLAmZYA3JWsZVBT6OsDkT
         qMrA==
X-Forwarded-Encrypted: i=1; AJvYcCU1sYAMxyKhHrQCAcKtZuquVgincrTvA4g4OZhTLfNnHSBNaggM1bI+sFTQ9A7Z6gNVunT2gK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWK6EIrGF1X8kHHb+xuRmdPHaPmrFx75hwKI5QfhIMvvncVCIC
	th9y9wyRem1HlQ4kpYPgqxc6b9FP29ip4HRI4KprK0rFVkksLXUykC5W5qsBZtg=
X-Gm-Gg: ASbGncv64K7R+pzBRPc8vFfKY3CDLoTzaIgdWtquEPoQpU31Gnvt0ZMn69UsQbiPUB6
	0tLvPpMkACurMKXgGDLBoSM+PlLmtL1va9Bee3Pz6QBDw/jm25Da4cIBXY7GilH9geEBpf2JzgJ
	v3SQkMQZSE75J3gyZL3/Pk2pug3jU+gGGhPTUwat1nno47M2S1eS3y0xDStG63reITVdv/lfa63
	00gm2GZH72JlBPo6WDvUGeGXy3YNmV4HpblTwoMZTQU/lUrg9HSoY9pQrZe1DgZWehh/bf1EqZc
	ot9dNV0r+ux2sbJEeLjeja/+V6T4WD8IKG+B2Y+6gNyL62kcVTLfRmF+B4pHXlXacNUMQAxpiI1
	JWhHVXqiy2CyDPPdWcwBMGufDd9fUOQpPpysC
X-Google-Smtp-Source: AGHT+IFFnPj29gWWWt5rHJCynoVqA+g7Bu3K+6B674boBRW55BGIQRBULHvKIBq0w4As+NszEYgvdg==
X-Received: by 2002:a05:690c:3609:b0:6fd:3ff9:ad96 with SMTP id 00721157ae682-706ce084512mr16517447b3.37.1744940545611;
        Thu, 17 Apr 2025 18:42:25 -0700 (PDT)
Received: from Machine.localdomain (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-706ca44fd13sm2804597b3.20.2025.04.17.18.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 18:42:25 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/18] rust: net: phy: refactor to use `&raw mut`
Date: Thu, 17 Apr 2025 21:41:30 -0400
Message-ID: <20250418014143.888022-10-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250418014143.888022-1-contact@antoniohickey.com>
References: <20250418014143.888022-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of_mut!(place)` with
`&raw mut place`.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw mut` is similar to `&mut`
making it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/net/phy.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index a59469c785e3..757db052cc09 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -7,7 +7,7 @@
 //! C headers: [`include/linux/phy.h`](srctree/include/linux/phy.h).
 
 use crate::{error::*, prelude::*, types::Opaque};
-use core::{marker::PhantomData, ptr::addr_of_mut};
+use core::marker::PhantomData;
 
 pub mod reg;
 
@@ -285,7 +285,7 @@ impl AsRef<kernel::device::Device> for Device {
     fn as_ref(&self) -> &kernel::device::Device {
         let phydev = self.0.get();
         // SAFETY: The struct invariant ensures that `mdio.dev` is valid.
-        unsafe { kernel::device::Device::as_ref(addr_of_mut!((*phydev).mdio.dev)) }
+        unsafe { kernel::device::Device::as_ref(&raw mut (*phydev).mdio.dev) }
     }
 }
 
-- 
2.48.1


