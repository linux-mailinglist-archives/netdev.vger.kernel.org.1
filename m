Return-Path: <netdev+bounces-138951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422AC9AF837
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 05:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740B11C20D7D
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CE318C342;
	Fri, 25 Oct 2024 03:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFLL+782"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB3418C03C;
	Fri, 25 Oct 2024 03:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827255; cv=none; b=c2i7kuqP6zDKgX7dzkK5XSseGQogh6KnZR8XM3/ToZ2IEzM0KgTjSKkMDvK43FO3S6Q2WMA+zmP9pKmVv9pNqR2kbg6KW5F7wUJQlZUQsoKgcKzZGrasERuPgOGpBp3yieRWEZlwTSrI+KCA5zfUn2y2K2RVAogp/mbKqWv+D30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827255; c=relaxed/simple;
	bh=twzsMo9PnqE2SQYXonN8b7y9524aObqn6wJsaMoGgzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZeI15xvRSLN6fJhLK3RDU+eJkvnf3GTy6s8F620AN0bJdnYkw7jJYca2YXdn+OjRyMsRf41RxYcHBpz3xzV0/z8SW4hlwICZt6CMQrK2Hd9DCcoPZvU+I0CTBC5nJwBw2tNG5di8WwGXFEkOLQFRzJ/lU8KrVyzhSLAkU4PgrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFLL+782; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-656d8b346d2so1011838a12.2;
        Thu, 24 Oct 2024 20:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729827253; x=1730432053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o5N7q9DkGBoncN0d1LZtLp06+Ve02cWoasnsmTQcfc=;
        b=LFLL+782Qik4GERgYlJP18F9a4XSzoQpWSh1XsQYIjRxX6xRxmKTXSAoa1oHNdov2B
         qARt3gtM6f2IAoV3oTq6TeDHE7qJXqjPUh9S5e+KJrexpZL8lSsKx4bJ8ax7dM2EfD1J
         VJjP65IvVNeRK1gML2DL13Pabr9Arn2AKS5FqBvkHEPkwdPgTSUzOfit8DspgoXWlz78
         26cBHlxivooh57lUBYLxC411De9Xd1CDMSqYai7D+B9ii7VT9LeNN+VjeJLZMzQL3U13
         62S8eMqNkKjLTpovWtJTE2Fxtu/1BNcN5jXk6JnRe8fysHDUiNxlieHrSteANoTPiXzV
         AHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729827253; x=1730432053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o5N7q9DkGBoncN0d1LZtLp06+Ve02cWoasnsmTQcfc=;
        b=hiBoxiFYUHFnxZJ4GLM6Ro8NGAq/BBubFjZGe5o8amH0Nau7Ea2y+RivfJqah6pphS
         C4ofaEdKYzmS/F72xpTx+dFjbjJG1OtnOh8Ucu2QMznYqytuSAFA77RRNHboRSTlwleF
         d+JcsdJvhbxdaHummeemRODHYP8CWJEjexxEm8HZyBGMezxUFndakSix7Ti3zNAPAcah
         UcnSHAHrqJyl9earDoNeZYmyOkTcVqvXb0DLtLgWvZ8UInHlN9tYnmSla27qjzFulTtc
         4Y9IlY46hKMH7KLcec76Ah42Agq+IYS4AvWuJ1eD590NqmT1KimK048gLeHG1gQLwp5w
         4C8A==
X-Forwarded-Encrypted: i=1; AJvYcCVLv/wInCn0BlmGD6B2VEJQd2ejruf8V2a0JK9gBgz7GJQIRzVr/q52n4k00pSCNq9B5utzha1VgW6JvY4=@vger.kernel.org, AJvYcCXRjcTreBt+hEJ7/iUVVEOfoLBq7szcFXDffy41r1BvyV++fqa9Yg6mypcFtT541M5JZDpvsGDmpH7ql/tdFOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZRw+KPUx4hUbFa6K9BG5Hb/eZd3U3hEUkidzvCYy3YLFjFMHi
	Xw87KwAyo5gMc873TiyMYxx7vNXrQzknk2Q3TMwvqG3C+8y3XBsj
X-Google-Smtp-Source: AGHT+IGjLc7M9f2iO7YVpc18LmagGIS+w52tVqbv90ZJXP9NpG3GgF4k83ml1Oo8YOt0RHNh7QrBzw==
X-Received: by 2002:a05:6a21:399:b0:1d7:11af:6a with SMTP id adf61e73a8af0-1d978bae474mr8379273637.37.1729827252854;
        Thu, 24 Oct 2024 20:34:12 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791db5fsm180188b3a.11.2024.10.24.20.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:34:12 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	jstultz@google.com,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
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
	arnd@arndb.de
Subject: [PATCH v4 1/7] rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
Date: Fri, 25 Oct 2024 12:31:12 +0900
Message-ID: <20241025033118.44452-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025033118.44452-1-fujita.tomonori@gmail.com>
References: <20241025033118.44452-1-fujita.tomonori@gmail.com>
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
using the C's accessors because more efficient and we already do in
the existing code (Ktime::sub).

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index e3bb5e89f88d..4a7c6037c256 100644
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


