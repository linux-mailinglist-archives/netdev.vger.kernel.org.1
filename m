Return-Path: <netdev+bounces-160915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E55A1C2B2
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 11:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6753A4107
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F431207A33;
	Sat, 25 Jan 2025 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDKGy+au"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CD11E22FA;
	Sat, 25 Jan 2025 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737800416; cv=none; b=Js5Y6q+HhDw3DucLOoONR1B7qQzJSqLPN49rK62TXV8S1PTN0BBjnidaqx3vhT0099l09vBLyojWsTICd3pGRmfHb7ozFjcYCC5SXO+zKJAAxt3tKWP9abRbQ0RqROmJiFSjkXgMgAf22VUuNlxYY9MYRuI4qpZmR6v07i7+vPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737800416; c=relaxed/simple;
	bh=p1cX+47M/YK8hisgffkIVlD9QZQbKffZqY8fbEVUxCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcnDSnEL1OgASm8cmj6INIkpOSHxRdaj77rfdI3kwONdZM36PelGACKkBIKyP4jhsPo01nA8o66pxVKiSQYNvQFP7dVZ/VEPL+jV3UpDoakVzCzUJbVsLZnqGBvTVzAo1OimPoiyqCjNKfgz9KPZoJtewHBqo2tZZeL0XT+Nwz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDKGy+au; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2164b662090so57357905ad.1;
        Sat, 25 Jan 2025 02:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737800414; x=1738405214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nY2pY2qTfJ1hmO2xyCvTiE0MYO/8Hj3wARJQO2vqCU=;
        b=dDKGy+auIVotSYb3CMRL2w2WLPgjMaRiOljA+CWTGNpeZvQDLqfTNgwhJQ67mOP7Jh
         YOBaamJ08e4CzpnC6H8jV7opQsGBqOWiwA0oyJoQ80JfjMGx0O8C9Nf+af7iSBWbG+Zh
         V/lkN1EllYiIW8IS7IoB+ioYkFsXPuV4kDPPvmjDSQ7WOF2X7n1CHxmlcCXsgaNdFOdn
         huWsl/WZgkvBG/at9XY5uFwXi5JA9Sl8Tr2Lobz5gb2ppc/9m5Wl3RpBKsF8cpjUbj/H
         YbuiSvkA6w0J0snmvHp3cEwDt6imfshRitQhvSinwDkwyoi9T2H1Aqaa30phbK/Sdv4e
         QZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737800414; x=1738405214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nY2pY2qTfJ1hmO2xyCvTiE0MYO/8Hj3wARJQO2vqCU=;
        b=wAnNit47eZ6adxpZEGvef73USnQ80bXVjEmxp7qmTIKmthx9pfaAkNkpu5M5dyV+Du
         XbM+nUKdmR41T5sOieYzFXzTkSx+fk9FGGjRHxJcuuv2b6jFiGyvXW1qqR9s3xZBhO3+
         IbKhlCH2Pe13x1uaFLhOo6Gz7YDajFgBXv4NlJ5qaoBiXlxqTbx0qkjbCne759hdQoqD
         lOnGEScpzpMEgBCuQNhrFeIHpi3iJmbLi7eJCdKb0eI+duzmtuGrAYFiD2eoGu6Zh4NY
         xWxtmaCyJy6A9V3mYndn/NJgieRIptyo1kTQrp6XTAaLbHgmizpLmEIY1DIbNrwvJOCn
         I+uw==
X-Forwarded-Encrypted: i=1; AJvYcCUZWVeIg8hKGwZmlblkvdPqAsKy/bG+EfUtdgKyR+YVUxBpC1nsvfzckgPTM2Q+6Epj0usiOnhftcCazcTKmPI=@vger.kernel.org, AJvYcCW1jGhUTZw7QIgwFfO5U+gLR3FunX+ltB6EGpY+AhXnSJ2oCiLz+yO3jh8jO4VpvssEWXEBzr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5G3TbMHtEEBLKVhpvFWTLsJMJQHIDpzJw5YQL8naHUbrG22sp
	luCcWXhItaiDgooRPuhg4EiuAOI8HbUFiRVqvz9K/Up1j9xNgkZ4rpI0H7V+
X-Gm-Gg: ASbGncshlMTTeatx7pqm7yQlQH80GqtzcVY0K47ZQoCfvWWK1eD20SdkVGIrMVvvWOQ
	MsGIehqenqz2L8DDRwJCGaalT3UJhtSuuDMENy/O117CJl7RN8GYafM1k197v8mck20Glq7rdw6
	dYpafqC18rODGjuqre9Pv8K/vZ/CXPPgDOuFY5bXPfJj2KlMEYbeNhL9kzAuBN5Y4sBoCKWbwOb
	o66Ntu/eJoOk5h92ZPzCzyyMKOm700vvJsskuMzws35uwIGEwJqId2IFaaa/rUXd6ibmtcZWuR6
	1HvcmZkMihIrCONOUQxsJRoWbz2gw8b/mcdBozP85+rMLMvlgpSzPnKo
X-Google-Smtp-Source: AGHT+IHQVhGkX6ttjDPwZ8GRNul36L1073PwK3wZnL5SgGDM+14JUptIWnnviS6p3upTwTZ7bV9Cgw==
X-Received: by 2002:a17:903:2bcb:b0:215:8847:435c with SMTP id d9443c01a7336-21c353e663cmr515798275ad.12.1737800413726;
        Sat, 25 Jan 2025 02:20:13 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424f344sm29461155ad.232.2025.01.25.02.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 02:20:13 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Trevor Gross <tmgross@umich.edu>,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	arnd@arndb.de,
	jstultz@google.com,
	sboyd@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tgunders@redhat.com
Subject: [PATCH v9 2/8] rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
Date: Sat, 25 Jan 2025 19:18:47 +0900
Message-ID: <20250125101854.112261-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250125101854.112261-1-fujita.tomonori@gmail.com>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PartialEq/Eq/PartialOrd/Ord trait to Ktime so two Ktime instances
can be compared to determine whether a timeout is met or not.

Use the derive implements; we directly touch C's ktime_t rather than
using the C's accessors because it is more efficient and we already do
in the existing code (Ktime::sub).

Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 379c0f5772e5..48b71e6641ce 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -27,7 +27,7 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
 
 /// A Rust wrapper around a `ktime_t`.
 #[repr(transparent)]
-#[derive(Copy, Clone)]
+#[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord)]
 pub struct Ktime {
     inner: bindings::ktime_t,
 }
-- 
2.43.0


