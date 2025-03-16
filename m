Return-Path: <netdev+bounces-175096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABECA63443
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 07:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E3117329A
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 06:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73701990DB;
	Sun, 16 Mar 2025 06:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="v9QkjAhr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BBE198A19
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 06:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742106048; cv=none; b=bw14c/oNUgnF+jNES0X5RUYJg5Km6O5rlMg/lEZsumNIV9Z4DlRADd7ShAA+QfZz/KjuwZgH4BIr1K2q3CIUnlg50ogqR9WYT9CwbXQRG5mg8/t/MRUa7gpXFMN0beu8SAol73Md5Hh136POru+A7QZKPkMhtBByKs09OW2u7Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742106048; c=relaxed/simple;
	bh=DCCZ3zSHAje0FWAK8UKvdqHAHS2xwd6Ei/WwMlNchpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBUmoi/CAoOHD0p5lIh+F3hjkZYLbHTy3+QWEb7Q/G6vpMUuBKE5du91NAOvOs3kID5SE+GUvE+OjSGytNphj0jFT7+f7s5wRSPlvdfAgEl9x/iJiG8SQ3182z/MtjOPe+PkxAmsKC5egl9lSzxIEBwE2FGX0pa61TruyUkL9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=v9QkjAhr; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e5ad75ca787so2890265276.0
        for <netdev@vger.kernel.org>; Sat, 15 Mar 2025 23:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742106046; x=1742710846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgXYCZoIbp3+FQSUFxgLFXAA6h9RyUssleXI5NM4+uk=;
        b=v9QkjAhrRPErcO5472Th54wIuu2Wru7bUTQJGZasm7OrPwRxpmuvOtJitzSxPMst7s
         EmNWry2wG+wJ0aVXIhZwWqYkCm6qrRpIUZ8vdYXMmQCYEUDEfz+GB0YVSW+gf0m3wzOI
         wwhoVDZROE7LgTJE4GsJsl2YZozKYKz0THCt5H2Rhnn9SPC9F1m9GGTEsBQe7ohVJtMf
         +M5BfbRf02rhE2kMNm/f27K3dVs+odRElOKXJv2/pjnHWLobExqFRAseltodeXTx0R8D
         q6XzaOO3Npk6S9ApCGQrOftSN1CoGLFNK2ybpCmrGCACvYK9Cy4KKW7UOEjD55d7qH7z
         p6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742106046; x=1742710846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgXYCZoIbp3+FQSUFxgLFXAA6h9RyUssleXI5NM4+uk=;
        b=w/g3O6UJzZ5eCnqbK/SzKMhLesUNi6XYKPnhI9j4Vu1XjJ1A4r14BpJn8Ks2Du5Yc6
         8BJDhnqFfMDTnO07gsCuixp65dGhX7/CAtWyO0EzfwoIAk2Z1MDxcBoCjbbfFUN3yE48
         VLmuSN90Hbm4wMZ6H2OHoYhhNVZbYyoEn9YRvZu03nmuKizUAUFCIr2hhbrIKY1Xg4pc
         fGWwiuUp0MTuYRUOg2z5MjmUjQbhGIP7l/0nS0qa+yxLl4BBPPRF+PbJuZl99+RxGqip
         FNjDkuwYF7tRMRLkvQQiRq0ySF9DDXkdIx7Kph9UftmaJ0Y3VPlD4QPSIfN2YumGm6XG
         N0OQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8p789+kNFU4GeJa3ZKXfoiAuWdyVDXyM2apbC2rAIxJPRs/uLlpxsOnJv0qXrJEohqHxa3lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YybWCHAVM3Ni5hwKF0gA+CGZBG9blbcQJQrzSi/G+3b90V8VnY5
	Kxtr52BLjPBzkUQl/lmrqdaKYRTLqcGUPmwQTuWMZw41jN1OMuzYBpxmqo5bqrw=
X-Gm-Gg: ASbGnct9j/kRxotvObPSMWxhoGA7EXzyf+QcliUQAhGEeQ1VEJeyT1PwKUnI2KNjJEP
	aDGENXVEZPZGCkgyaQT34mV6qCB8pN3V78QF9QlmESX7tqK334hSoYNgUTJOqxDZvcit2CdXPpe
	BCyj/16ccwiNqdYGUiSN8JEjY+TnDY/NAJ38+SDl6XVulHUGJrLZcyzfm599kcPtjZpP0y6LZkx
	k3Cro0dpw+qeKzKt/2Fk8aSRiwrJXCU8qZ9jRSBEGF6Jk4Jm5/rAphHaatpsfjfdDOHzupHKGYN
	nCt05N/o6GJ22B5ZjvRmSQevMA+sFcthzqgdcqvjEKN/j8BI/2lU1Bm/lIPf5zM80fQ2V47KTkv
	5rINKnuRQbJKB9feeCEW38a1BBB23HfzEE6nSUC27
X-Google-Smtp-Source: AGHT+IEx3oMNZnBzMXazeUa5U7og3XXby62pIZ4BVRtR8qqnmhOeVv1VgBmfkomrXokKtJVLbNQXTg==
X-Received: by 2002:a05:6902:2788:b0:e63:c936:c07f with SMTP id 3f1490d57ef6-e63f870c83dmr9695475276.2.1742106046218;
        Sat, 15 Mar 2025 23:20:46 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e53fd277sm1618673276.11.2025.03.15.23.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:20:45 -0700 (PDT)
From: Antonio Hickey <contact@byte-forge.io>
X-Google-Original-From: Antonio Hickey <contact@antoniohickey.com>
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
Subject: [PATCH v4 11/16] rust: net: phy: refactor to use `&raw [const|mut]`
Date: Sun, 16 Mar 2025 02:14:20 -0400
Message-ID: <20250316061429.817126-12-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316061429.817126-1-contact@antoniohickey.com>
References: <20250316061429.817126-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
with `&raw const place` and `&raw mut place` respectively.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw const`, `&raw mut` are similar
to `&`, `&mut` making it fit more naturally with other existing code.

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


