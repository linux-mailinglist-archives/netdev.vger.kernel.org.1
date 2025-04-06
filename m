Return-Path: <netdev+bounces-179446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA3AA7CC74
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 03:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B940B176DAA
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 01:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED6D22301;
	Sun,  6 Apr 2025 01:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1iRBB7t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5FD6ADD;
	Sun,  6 Apr 2025 01:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743903328; cv=none; b=Hh3qGZyP3pMQvaudE+RYv+ZXn9sV6I8FNZgn70FvB/R8MUAoqNvYFl1spvDiczM+ywfgXB11FVv1xYixPyaSXgCfjYnqRJCvkZNt5IOBSN+/jVYEKl1lnLwhvRu79rfLmE6nwLb1pj3nP0jP4EHKADx8qfBSQKM4XCPkPPDOdaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743903328; c=relaxed/simple;
	bh=kd3vW/wW1gabeQG7Fy0PVk4IKsLzJY/aNs7T6WdurXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gl6xyjgh5MseFmLxM9E+dq/OBXEMjvr7mtSAR+DmORRv36H0xedTYjWjxDQl8aayNsBL45ZyXovK+4Lq+KIfoxc+2lzI7/C6STzmjf+TuwR+sCyzRh2o/T5N+aWxdDrNCJ1wfPkfD9/8ktYAGJk9zoD/ahC0RHciBS79Dg23Trk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1iRBB7t; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22438c356c8so31542325ad.1;
        Sat, 05 Apr 2025 18:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743903323; x=1744508123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OA/MmqYliLwWhi3o92n3t+JslJEn4NlsVVnjQQ5ihp8=;
        b=Q1iRBB7tOkeSDHqL6rUgY+4EfHAeQlu2X/ABvhI1lvs9XL9C8A5Y6aNSmkB7xrGx5b
         n+4XZCbiDXZj4jiSZ75ZJ6e+SazXB6sKneAkdWVxaY/j3fYctc7OSl/geahamfLMIqcK
         ES/i76Po+FWU5XyQ+B6lec0NyQRcAjTxv/tnKIqyKe3tAZE+JliHHpQBqrrrxKS2SoqV
         91UzuAyaq8/fIiP5s5bBFDvxuhcaw/YABiNK5IpdUM39DTDU6/dMlu+W0jBOC7yLWXJq
         EJ/LX6vqEEsQjUCAFsYrJY6INjlCok2EdFaZUkjkhxFyNqqIKyHFQCRaHgrv35T3AtQb
         EWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743903323; x=1744508123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OA/MmqYliLwWhi3o92n3t+JslJEn4NlsVVnjQQ5ihp8=;
        b=rFh+teBjlWSMwansO7jJ+niwuKuFVKGGuoGVsJEmOyV4ctV7i+2FquUZ18aQGwAgRn
         UYBFxb4EPs6WS0sEbZdbppthV5ggGpY2BL0j5cmIzMhdrYQKjWXLQZqDOdZSEKrUd0/+
         zA12A4wQbKYPyJXn0QGc1oUxkCf7kL7Y+3H5xbWPl2cCZaP6ZlOGSzwZvw71chYOmeYP
         Cu81zthK8/lR/loJ5S2fvkRnl+60t8vfj7LPWlVZhKVAVlV6whB9qIvktB86VLvFl8NQ
         D+4DrlMV+Gve0EebOuXaOcHH2x8yX2rvVSIy/F8VjtPOtgsmgPoKmWX9AuJNVAUNpbns
         fksg==
X-Forwarded-Encrypted: i=1; AJvYcCVrNBtL1fzXPVTkrYcf5AwCpMyVeZoO/nwc+fhxN0DYYUxQ9T51Kc0VO6k8vIwzpESQ3/JH3uQSx9gVGiI=@vger.kernel.org, AJvYcCVzTgtlc6Um9ybobvwiA+pW+9Vl8f1ybZ/KkxU3UkNr7W5LaT+39ioXuD6WzqGi6ylptYm6qQlt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7+NbbaoAIa6Lg8X0SLLoT6c/N1M55ZeO1zSQ3qlQqkmNv20pH
	t9wtVZfGziAIdbLhu9RJ0la28sCFeGMsYmH+uat17F6TI61Q4zdqw9jRbfEg
X-Gm-Gg: ASbGnctOCtBMy9rbWvzlqoGbXseWK/p/Mk+ElJ5hcKXEeLYGakBjpsccBS0XpPR2xhZ
	i+4sW87e9qpmRy1MbTvO7yeE1qPEm3YvM+y4+R7yLRFNGDt6KHtykeXZePXpFhmsJadp/+QV5GU
	oVTWlLWKfN6dgSOihbZlBL7ohNW1TZEfnzWTeqOr3HulzkxrLbXjYJfFd5CzDp3X2SBFFbq42B8
	dSkcBS/42CNY23r7COY3GcrFgjCOwo2O5Va0du8yPYFtjZUJDaCEcREhdB0vnjaK9d/Ty5s2zOI
	kUwNBVU0AvGk2RBAQAGuog38o+Ht155v5wBruzWRhXd3DPN+a2WEa/rTuMPzj3VuFDc5ZUBOj7u
	HFNwQ9mVJ7CkdhbwlzbXc0w==
X-Google-Smtp-Source: AGHT+IE57Dl+F0N1TQEaOsi/sbH5n6hJ/G3XQQLk90KL0m8ajkTtv+vVbK/m8UqmqYQVoEPK4WSnsw==
X-Received: by 2002:a17:902:ef11:b0:21f:507b:9ad7 with SMTP id d9443c01a7336-22a8a8794a7mr123090205ad.25.1743903322983;
        Sat, 05 Apr 2025 18:35:22 -0700 (PDT)
Received: from mew.. (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0bc052sm5846849b3a.156.2025.04.05.18.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 18:35:22 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Trevor Gross <tmgross@umich.edu>,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	Fiona Behrens <me@kloenk.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-kernel@vger.kernel.org,
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
	tgunders@redhat.com,
	david.laight.linux@gmail.com
Subject: [PATCH v12 1/5] rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
Date: Sun,  6 Apr 2025 10:34:41 +0900
Message-ID: <20250406013445.124688-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250406013445.124688-1-fujita.tomonori@gmail.com>
References: <20250406013445.124688-1-fujita.tomonori@gmail.com>
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
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index f509cb0eb71e..9d57e8a5552a 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -29,7 +29,7 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
 
 /// A Rust wrapper around a `ktime_t`.
 #[repr(transparent)]
-#[derive(Copy, Clone)]
+#[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord)]
 pub struct Ktime {
     inner: bindings::ktime_t,
 }
-- 
2.43.0


