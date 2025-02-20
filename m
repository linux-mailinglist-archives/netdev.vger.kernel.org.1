Return-Path: <netdev+bounces-167998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1278A3D1D0
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D257189D4FF
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBEC1E5B66;
	Thu, 20 Feb 2025 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpTQkaia"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBD61E5B63;
	Thu, 20 Feb 2025 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035430; cv=none; b=NCrynUb9KJ6J6NQKSSYSZJ1qENM10ZquTKK3t5HK5JpdIgx6HDZ6H8oP2cpnSTmj5WmLEwRDfushjz+gLrBkEDvmnNrfl5/qY0WkcVGbzr0N8ehMrSk+EI3wwS1q1uW/3I+rsOhRS31tLGP66+cQ+edXp4eEepqUCz6BbMlnl+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035430; c=relaxed/simple;
	bh=F4MQ13dRTvjdMRvvzGNbECYKc2DSsjjEfJe5kqp6TkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlKkQBbD+64CJydm+VflDO+O+RBGdu1MrJ1/PMxpW5AokQHvLkz5MLvbD3w04l8qxw8Q8QIe9kO3hyy7KTuOh01dsGMYWTU5PRcr1QzojanYdsAEz/TQ/lnukiHq9xcknGbIaQCdpSpNhsB4ShVxD/uNAxv5rHxLERh6F5xiDwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpTQkaia; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-221206dbd7eso9761625ad.2;
        Wed, 19 Feb 2025 23:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740035428; x=1740640228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+v1QyRz41BbOlaQv2erYxdSScozwJORMKo7m3a8Kic=;
        b=cpTQkaia4PFwYeo0jBHTaxi54eksqyJuC6MY3RlqYB5hP5jmAgQg26CflQV9s9IsKs
         8/Rp7AuXsSAykD4gPHyOmgPDG2RgvCuRQuG00xG2abrqlAAwC2BuuzxlMnXgXY83dqLv
         qce3+WV/HZdn+8kUb4U8kqR0/eJfrYcROHW+h2mmnMlj7a7+GWukRCOpBMxrABOqXOQD
         A1IN3rTDRWpmdzdEDJtNmrUi6I7yj7yfDqXpYD8a3lO35R7gRmPlkbqshRAXSk/GEmhL
         YEVyHAQGnG1UIy7ZGX48xWA/OqSTl8CNf4/KW7SKlKjEurVuNDjI2YljLZjuH3mUJF3j
         AsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740035428; x=1740640228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+v1QyRz41BbOlaQv2erYxdSScozwJORMKo7m3a8Kic=;
        b=XBa4d1GzGPTWWQbuiZAVo2cFFRHQfd4juWgoiEdjznll/aIFNaejTZUbIAKR31UdzE
         PKu6KqQ6rq3yHUHMS4b0kH2wmImFRU9gIVXYswo6pW54Ro8+kitOX2FmnUbFwFfXxWod
         FykxcZ4h1BTnDHb3+p4UHrcJROb1Np4YEhKMeEbguMcybyDjIBzMYF1Wu9VzEbs80BwZ
         BJ+tOlYBE6P7hLHte2InxCYrY0VGVz/b+TswGL5eDkA8oGIztZKSl6NrKHtle7c9vxTG
         3TH1BXwtrGB4g3YWmqXPe6U3rfuomzAYBsQw1/Ys3Po6RTMDlVn6ZwQhI6ZQfc8afiRC
         8Gow==
X-Forwarded-Encrypted: i=1; AJvYcCUF5j4FNxjCFWDrcguu87GI7SfhynJ78W9sE1whVa4jJrC49+hLm2GZ3XC+2whGzIYIuIuVasI=@vger.kernel.org, AJvYcCWaDtMhguJVkO+wOxMK0oYXtEDqBc47bW36vK87Lz8agwGlQB98vZddjXqBY8gARoXDYSNPiKufe/iz+fyxWv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy0FwDJbFSqGzbxfJr5HUFpQV3S30i95hOO6WwQALCrWvVY0Zu
	ytFxSjGgcM4uYAcpnG4hNIdZX8T/uz+HFEc27OyLA8AWGqMInWNnacw8kaXk
X-Gm-Gg: ASbGnct5v+7rd9KyKMzqJOSVFXRHO0kaqgFQgZXozHp8Nm+Lc9GJbAi2c9kap9/ncgI
	xI21TKGvlPuCsnPn+38hNYPApfhnT8f1OXQkVEbvCyVEQGR5TeQgs0A/+SFfh9jkML3PKDOKcxa
	QPQ6W4zLbe87KqbGhEzno79lql1z7AGmP8GI/JMUKS9A+Qs7n0nq+gbL2LB9U/ijqy4z5+yIal7
	5LG0tYEA2lMv9V0HaPNRVW7r+2e6bZ485i+5WKJ/y9nEfBYOp27NI12VsDX9wJ7Qg+OyMpasB/5
	MMYPV/DJBKir43TTMsWZKS60YF/YSycNTxaAi9HHxxTxBqzfmHohA9+FHAGzH7IjLMQ=
X-Google-Smtp-Source: AGHT+IGn/7s0IeGlZEMDIjGUk6iLqy+keYxxiBJ9Djl3lxBK0ZN78N00biCShYeOIZ1LRgW96pnjLw==
X-Received: by 2002:a05:6a00:3a11:b0:730:95a6:375f with SMTP id d2e1a72fcca58-7329de47f9amr10483915b3a.3.1740035428155;
        Wed, 19 Feb 2025 23:10:28 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568af8sm13059672b3a.48.2025.02.19.23.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:10:27 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Trevor Gross <tmgross@umich.edu>,
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
	tgunders@redhat.com,
	david.laight.linux@gmail.com
Subject: [PATCH v11 2/8] rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
Date: Thu, 20 Feb 2025 16:06:04 +0900
Message-ID: <20250220070611.214262-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220070611.214262-1-fujita.tomonori@gmail.com>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
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

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
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


