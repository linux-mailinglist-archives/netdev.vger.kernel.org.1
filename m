Return-Path: <netdev+bounces-163983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C6EA2C3A1
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3773AC76E
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96151F4E21;
	Fri,  7 Feb 2025 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLmts1JB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D21A1A5BB1;
	Fri,  7 Feb 2025 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935104; cv=none; b=Q6zytJBbCT9fmG5aDnBtT1Dav0lufQxniKcWNLHRe1GIvMkjHiO8df0ema/YIrv6yfdyJhoe7AV/osPu6PRU76Ml/ItK4clwSQC0W218C1FxhraGHjAIxlb7xzBNLv/xO75ZPzrMrZhU+61+ie2vG/eEef1W8VaEmFvsfB5eZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935104; c=relaxed/simple;
	bh=LoBGIidzr+b3R8h++Tx7qCa9b+hY5XCB/xrwCgA9bpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjI8KkSdriSdVax9hNqBon6ThfBVBgIpTyHDu+XwFWskQ8vQyxv1uPEYhxoZ98bDB62bfL2HvlOPYM1xdvGGpcC5ItTjMC4sPEnQ6tS6O4eIsy1SqRGXgfEH+j8kU9a782DzpgjSKzz6qvqZ+I/6HFGKvYwtJoiiSsfgWNxdN0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLmts1JB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f20666e72so42872645ad.1;
        Fri, 07 Feb 2025 05:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738935101; x=1739539901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zg2LvfJwtwHDxNRHkkZCVAVibFr6XigkDjBCaMe28f8=;
        b=RLmts1JBKvxAJ2aSc5BjIR6rDJiIHlEJahpRLkEGXhzYFDX70BL0pPplANcTP3lloy
         cAFw9n9zxZ4fDgRBaYVlcWE0OIOrAC7HDSvzlOmJnktqH/37nwXEsoq7rmuLQLyRHjvG
         2m1L88up7iNNKHA/U68vTDn5sA5gZChJ8m12jYkvQVTWATf4JYcWN3aW0jyO9UMwCZl6
         8fKx5tIO03QoydwfCEbigG5pfnVOYwupvTaPWfR2K51IrIMWF4OT9xwtutVxcZTuL1+I
         yTvbUTVGFViakTijpFWkNFnPqoMlWTjvpZ9MgZgSWNmKjVFLYkinW6N7RerQ0gQN/aXo
         EUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738935101; x=1739539901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zg2LvfJwtwHDxNRHkkZCVAVibFr6XigkDjBCaMe28f8=;
        b=muoz1be4JA4Zs9hHS0hLnx3K98r4+9BcBx4SsqXQmgL545+L8FHpt0BbfIBdRMdQH6
         D/B5OAU754CeWVhogFDLgZTg7RWcV4tAZJG9Wlv0H9pOFie70aT46CHAXA2JoqXK0ooJ
         cf34j8MiQo7h+JO2yYnSy2pwwUAqpHE443FyVUaN8SgQvfHDOKfGNRLjsPyYcFVv2KbF
         ug6oOg5qWE0zWf1USLYbTRedBEJ490idNrwKg8dXh9Rc2Rsan17f3Wa8NohU4w/DUnnD
         jOjrVFb80gdNZbWj+UAvyburIkK3fowfkzpiP8Zt1Jev02SaUzxzonUYqCYP39c0sNa3
         36qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhJs2tl1jLDhEHY2prihESvlNfguGJUJHEXeg6yFtleUyXhGfcb8WqlHZKZQk62+hpTfVfjQ2JAWIeo4oH0vQ=@vger.kernel.org, AJvYcCWTZUaquNLyntpadjpCqBpQAtQJ8+I9irH/g7lErxJlrxBA1XV82K/fTMpeW7kqc67DU1d42zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGTzouV8y81daAViJLNmOb9NIiiT68xj+LXjZOkR8Yuly/IITV
	zXHEmC009jHkJ5vQ0VD2vf+Glz+rvKY7JLt+UUDbdzgug9rxC2T/UldNRB7B
X-Gm-Gg: ASbGncueQnM6BbI6SkHxMk5MeHbcLbmNUxA8DPUG9X9Nk3BqIhqk7Q+jAjufDqfq6sd
	lseJ+SbsppfnRfCmaJ7Pjz7PUwt5/N7Ge+95WlJpg+EM+ILFTQXo2u7NU2rFp0Y9li70WyxV17G
	571wGeVehCh0a41Fopmg4LNq7i0HyYt6sxkEdVf1GT+pIfJz2RdlywyIEKENrlh0iHyaExDzlGR
	7m3fwfQqO5VFkYonZa1zlhGlnMcwfR81qOA0X0ahphF0gapx8vPj4apeeXzGOGz92V1pqkh8qeR
	D0PazhWmzuD7sZs+71UYPuFw3ulAzinx7Pgiije45Z+5x5Nbf7JvFS+YI885Auvs3AU=
X-Google-Smtp-Source: AGHT+IHGMQicG3T0EcYkxJgmH1f/39a0QSgF398SGP0dohsSSfw8A3Nknz31U06ZwY/r0HEIDbTuQw==
X-Received: by 2002:a05:6a00:1a93:b0:728:9d19:d2ea with SMTP id d2e1a72fcca58-7305d4adb54mr4525387b3a.13.1738935101122;
        Fri, 07 Feb 2025 05:31:41 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51ea79a47sm2877843a12.76.2025.02.07.05.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 05:31:40 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Trevor Gross <tmgross@umich.edu>,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	Fiona Behrens <me@kloenk.dev>,
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
Subject: [PATCH v10 2/8] rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
Date: Fri,  7 Feb 2025 22:26:17 +0900
Message-ID: <20250207132623.168854-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207132623.168854-1-fujita.tomonori@gmail.com>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
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
Reviewed-by: Fiona Behrens <me@kloenk.dev>
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


