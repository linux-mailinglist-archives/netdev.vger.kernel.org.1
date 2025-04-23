Return-Path: <netdev+bounces-185263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBEDA998C6
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 21:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF4E1B86D01
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 19:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FAF293B65;
	Wed, 23 Apr 2025 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcbDT5XT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD0E293B44;
	Wed, 23 Apr 2025 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745437306; cv=none; b=J0qaU/ptAAI4R/MKSEIErzwqN4pvmG5LHUQ+B6HJCpakwA91uFc4/Uq9BiavCdZmGuJ2Qz6bJD6PMcietxOhvHKO+8Ccdte+mF+zoOoP3Bfs7t+OYWRK5g/qIRApE1O1OcoFbme5dDXgxZFKB+wvZ90dl9EQepXEeCHEEfAU4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745437306; c=relaxed/simple;
	bh=kd3vW/wW1gabeQG7Fy0PVk4IKsLzJY/aNs7T6WdurXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuuzH/smUaY4GEIwMdZERTcQ2W398iFLHC6xm9MCwNSi/qe9MdVDmUoYiYxHh+lQYpgLzQuS+KoAyNECSNgejIXnbuHTnlbPh/RXflvk3AoI4U4G4EqJbPlAHA2Xz0bo8NF5aAzsf1H3iJNxMYBeSzCFfxzdp9hnJkngoCoeJX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcbDT5XT; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736b350a22cso131617b3a.1;
        Wed, 23 Apr 2025 12:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745437304; x=1746042104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OA/MmqYliLwWhi3o92n3t+JslJEn4NlsVVnjQQ5ihp8=;
        b=DcbDT5XTeCRNDNQhJtXDgq/SPN0RvlC2LaLszxQFCfWgLvLIx2pRKvEgf1UyjKvByM
         +xKYYSEjHmOqkEKl2FT9n3SEz4GLsWh7WgEElp9vRvM4StUDcBWWuPtv00sj0e+W5yMP
         MBenClWpyQKo6vh566uF17oR7EtYbv506n6asrNmjcbK3FL+2SwOOPa8aFv3N3kSeTvH
         SEcEx74qL9HH+nP+/6Qygi6fMFaRTZCz09fR5hx8kUI7mNLCNr8VuU9r8W0goygIYRN9
         QRbDHArhAoHtcg2EvJTQi6C9wswVUlo1xLnSg8d5wdSyQWn0c4Gz1Taihs2mYTlHN8WY
         e1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745437304; x=1746042104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OA/MmqYliLwWhi3o92n3t+JslJEn4NlsVVnjQQ5ihp8=;
        b=KvIDWPYNJgF6LCYlJBsGMsu6bushDNOwNAOJG0Llxs2+tO+6/bgnpEfI2VOa2VDUM1
         OFhOThXU2mD+VFVVjLRcNhEBEXPC8aOhjOrZqrEaduqMRwsWI5aUqy3NGoLFMioMFt/2
         5fYpjpqKsGxAKei7lt9Vm+khKyXBzVsgB7f+MJ2gGZafekwYwsvWt4fQNKgxagj+X3j/
         6Xo+Phzvl98RplDg61IKbMZKbiLVe+IzFKKKg2PaBOM85mdQe9KusXllgC881CxWc0U6
         4TRW2pY7nibpIbRtSFK/ia+BKl8PM+AKHqcz/Bh3cy35UOYASGR7OsE3+RBjiJ+wD3og
         /vpA==
X-Forwarded-Encrypted: i=1; AJvYcCVk7ViRIsaxvDGoo94oVMVMvYJilxrgxK/0Ple6dDJCFSv8taSmlfdIU/som4h0iOVNEbvntZOr@vger.kernel.org, AJvYcCVmK7b/jDDp6YMsoO+WWovFd3+zY5AfwkRc5OeixV99uRevNwMCKQN/6Q1JS56o8cmnozZyV+tM70q/jsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQUiCx7NmKTLwLgbUZb1uHbNSEJ8IkuFZTe23TGxF1p5sp404Y
	oarJq/dbg79Lm0NWYgTsfSuyV2iN8PZIKhpE6fEP24f3J6c6A3hlOoLll9KZ
X-Gm-Gg: ASbGncuUs8QLArXU0dcmD6/bFylJfa0oF5gIpD0zGAkU0pQ5NpLkzTsgASk873CEqWd
	sQlzoTsbSX26BBoit/nBSQ+5620pyuamffCh1wQDXEjE5lVpjUiZu4KGw139ZAIf6jZLVzmve70
	o/xDIArwl9DCiSX0hXspF3lI7ma6FV1B8cQPixdsM1EoRm5I2s52FFWzNzDV7Ah420kWCGADqs8
	jt13VSLQ083EV2wwhlZdD2NkLCJWcXA7cnMAgsSqejx+rybNVzWrKOaC4KKcZIy4h8E9kET5h6B
	z6on6wL3yI++nMYGT+R0jRF4OzkzR46vEOVJ9mUAVEeyFArqMbgNLOyv9f4yZKMcgQomzNP9ACa
	V83IBgAfgptEZ2HEM9g==
X-Google-Smtp-Source: AGHT+IGe651eQjpQv7GYiZJqK+wZMAvZfN0N529BpieIeKE8v5bPuQGA4huF3ee5i6pNHtAXddDmRw==
X-Received: by 2002:a17:90a:d60f:b0:308:5273:4df8 with SMTP id 98e67ed59e1d1-309ed27c10bmr94092a91.10.1745437303713;
        Wed, 23 Apr 2025 12:41:43 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309df9ef918sm2056475a91.7.2025.04.23.12.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 12:41:43 -0700 (PDT)
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
	david.laight.linux@gmail.com,
	boqun.feng@gmail.com
Subject: [PATCH v15 2/6] rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
Date: Thu, 24 Apr 2025 04:28:52 +0900
Message-ID: <20250423192857.199712-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423192857.199712-1-fujita.tomonori@gmail.com>
References: <20250423192857.199712-1-fujita.tomonori@gmail.com>
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


