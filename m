Return-Path: <netdev+bounces-144696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C019C83AF
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE561F23683
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 07:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBDB1EBA11;
	Thu, 14 Nov 2024 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw9PKj4k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01CD1E8857;
	Thu, 14 Nov 2024 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568009; cv=none; b=SRYjsp1YpW0eIOpKRv20AzEL7O9uFVq2oiDM2oN1FdBVRH8nnQHO5VwGp6qzyaaTPN0v9V4whctuyxjY1NBMV8JFXjesSVN7JLryhKh9+irg152yilK4Iig92YnwKrTcMyYfJbliY/1SsOlb+oJkzwPr715RV1PTp19kyOFNVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568009; c=relaxed/simple;
	bh=ty5/y7Xtb2hwXPXaqKl+csNiJiUlRX6POVGSNuNzKgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7Bc/0uRalEvVaE3tv/fv3qUKkfz4MZzfsIkFysliPZzsKow1qbjTtAkfMKdu019oYklJHyogEHaLO0maKliA5zdNcOQqxo+jdCUmPXldua5SkESNCBnAMRpD/S5ChgNy3CqY4pNtn9/oLcdAfmNioKJXa0JW2WjISSVL8BNVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw9PKj4k; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cd76c513cso2083775ad.3;
        Wed, 13 Nov 2024 23:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731568007; x=1732172807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UR/Ms0FQM0UCt080++CvJa6JNyMuRguxnIevuegujk=;
        b=bw9PKj4kE6MpNCOKFXy668V63xDMrXlDYx9ocx9/MM9wlkWTS/rp4dEBRpv81Qt6Js
         F6/+cRshbasnch09vodxWb5B4b4JP9OsI/zj4vkYj/FmkXkyQbCWqa2olciQnvDPfkfj
         xl3g9o08FNyv0LSkPVQzAB3kfq5S4cS0I0dfWKBXFkWEtCpD+09wYVeboKdweQ1K4RSs
         TcgkMKo9pO28RgOIYdiSOyRHvD4klr+Ac3VF7rWSUQp0ENcqRWByhEl1oz1/jmo5tp0R
         GmnxLKwC4ZDy4CZjsvWrPDaP59sBfCpJjTuDfuvx41cgZ5WjU/JrrE1PQ+hGmZjfIh/6
         XiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731568007; x=1732172807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UR/Ms0FQM0UCt080++CvJa6JNyMuRguxnIevuegujk=;
        b=DbyJeI68opn/yQZMrBKICV314ZvQRUNFrYtBWCxzBicEcEZzROztbaw+POetx2FOnS
         FLuvm/uqFo8KPx3u6uTZFKCB7fN11YBiW5EQGWPSqgcfGKegCoAh4KDyMRJOZvlmL39r
         rLtFTTNjG895kTDvYG3+F0VarQU7SzFmFhVQx/dhvQ0rCfr9wDbydPSUiwVqX9DMaZcs
         /KH670iLdvpicttCZAgMPm2HdA+sDmalS027vLr5HetdDU6zOe67DasjAOAH3TmWzK8s
         5rMQqeHIOYmwiyLnE9JG4iF6JXTFjj/gp252dPH7S9HEgpt0lk80Iyh0cmXtEAi0m7Jz
         OvCA==
X-Forwarded-Encrypted: i=1; AJvYcCWglPEj3jPBOSk44S1Pr+McRVYbVKW0Iz8zcXeBOfMgc4opgqJ4wotL22T7w97+Dpj2RyBXzBuDxSJUs9VSPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YytvUrvYE0/YUIT/FQ2pzyvnCPpmuUfBBG0PrXwZLlWn6cbMG8F
	cqz8JUtAL3dofUz1rZg1L7t1FPWZ2YZmH7ETXPQdV0mY7sIt6EGxuqH6nQh/
X-Google-Smtp-Source: AGHT+IGq/HvLxWaE0m8L7MssJOLCP6/da8B3DdYgcAMAuK1g2Gb9zfKbxCDwloOXe60p6VYw6d+E5g==
X-Received: by 2002:a17:902:fc46:b0:20b:96b6:9fc2 with SMTP id d9443c01a7336-211ab90a5b4mr130250605ad.10.1731568006900;
        Wed, 13 Nov 2024 23:06:46 -0800 (PST)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d24a00sm4260315ad.244.2024.11.13.23.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:06:46 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
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
	vschneid@redhat.com
Subject: [PATCH v6 1/7] rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
Date: Thu, 14 Nov 2024 16:02:28 +0900
Message-ID: <20241114070234.116329-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114070234.116329-1-fujita.tomonori@gmail.com>
References: <20241114070234.116329-1-fujita.tomonori@gmail.com>
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


