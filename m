Return-Path: <netdev+bounces-136020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A1F99FFBD
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 05:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A812823AE
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C2416630A;
	Wed, 16 Oct 2024 03:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJ4HGJTW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952231304BA;
	Wed, 16 Oct 2024 03:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729050819; cv=none; b=ucoz8lbWpLpiWdIVL7fvH3hZ/B8lp47ojZzkbjzXyBuRJ5t9TnDERU61EjLU/l33CP8O3ehwsgf/ye7XANU4oUlUhZPaezhtfVYeOuyy/L2GHiI4xCNKE5jr96C8MA/UGHxSUHqDd0wWDMW204BWGU3wrrDKDtSyyVcVYpL41aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729050819; c=relaxed/simple;
	bh=w2ecT24Kyn76nmgnQevViwuwRFcLvtFR/VWNmAeR4AI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eHXOtmZNVZvoFJuJ36YNxQwFQkvYUdLkUcdTcu7leO6n3406PXJGy79L1vFwdQd76n14kkOwATkYIQwuNJNfcz2HqAStPFTgdAuff6fFLzP9uDWJCF9Qc6MBPmN5AQvOayMqjEnEwOIQEaFmERRzwSJdkGK69C6m9ZkBB/BAEOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJ4HGJTW; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2dc61bc41so3919623a91.1;
        Tue, 15 Oct 2024 20:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729050817; x=1729655617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xsDQGvqFbk9A8NMt3RcQDdNjWrv9GKnKY+O+O8W7yyI=;
        b=aJ4HGJTWfCVVKEzs2D/zJZW7myebX74o1dsVycE42R2EVDDKdkWujyFGTvTXAdrQAS
         D2ezr347q/olnBRZaQEZwg6DpUe51xzMbuMzmxRcHXSA6aducckj0wJEKB5Y5ARGKIYv
         fVrQ7nkmIdhhyEhn4OeNOrjPLO70pQU5ShrOfuPnW7YK4jyvHcPmXAifzxDWjhCbELJz
         ySIsGLmreUsrqoh+KN0BbtMH2Cf1r2ScTUjSpklOnCXRBPCrbydqRwpshyho8sG21oiu
         KP4q1X422il/QlzyPf7+yx/BsGWoTl134lLT1kQV3W2+vSQjLlLfjT9QZWAwJeqyyALJ
         MBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729050817; x=1729655617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xsDQGvqFbk9A8NMt3RcQDdNjWrv9GKnKY+O+O8W7yyI=;
        b=ZGsf3bcBcWhtrEK3CUr6VkpMpG+sHo6iIILJJPoEehKQmlmTNzvsHZ0+oew79lcEd4
         k7rSCZw8fEPT4GMAvKsi1+H6AVwGJG9G+/Tup9rsJdHt58otubi+cO2F/1LRKOhkPHQM
         1l/Pu2V0JFeMxB2lnrwy8VVdZwwtTPelodLejUoSnZuTAwZ8o90fv8ANlpmsUMez4GIR
         X57KK52OuB5ebrj3dHEXjiG/Z+Q+cLj9rMGyLxZOJSKuu2FRiSAK3izmsAMSH7OsiHaQ
         BskyrIppXtBHkLEml/iavFWYcm9JCQbsjvK9UjD5eslIwsWRLmLvzhKh7tTOWzIrLzA3
         5AGg==
X-Forwarded-Encrypted: i=1; AJvYcCWW4H+oOaHzmDhI6XcUxUe1VvrUr4aKSe96SJ+5NqrhEtZgZZ3P/9EnreB+7oCST/QRMPnh3fPzgNr6d7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDCszaI0DOdcFZnpTUKwJxm3QilKuHyBthi+5Y+wrvoVDntfwg
	RDv3qtyky5A0qdozHDBnbpdWJOOiypJoiqbQjntuqytyVBrxqUW7BpUC7E7i
X-Google-Smtp-Source: AGHT+IHC27WpHhPPnyuyQIiYpsCEcj3Vpq1+oLDHjIegNo5o8Qbn5NnGfSLpWWEMxFd+Cl+y7FDBtA==
X-Received: by 2002:a17:90a:8a92:b0:2e2:e660:96d5 with SMTP id 98e67ed59e1d1-2e3152f4b3bmr17504386a91.24.1729050816524;
        Tue, 15 Oct 2024 20:53:36 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392ed1a4fsm2885691a91.17.2024.10.15.20.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 20:53:36 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/8] rust: Add IO polling
Date: Wed, 16 Oct 2024 12:52:05 +0900
Message-ID: <20241016035214.2229-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

polls periodically until a condition is met or a timeout is reached.
By using the function, the 8th patch fixes QT2025 PHY driver to sleep
until the hardware becomes ready.

As a result of the past discussion, this introduces a new type
representing a span of time instead of using core::time::Duration or
time::Ktime.

Unlike the old rust branch, This adds a wrapper for fsleep() instead
of msleep(). fsleep() automatically chooses the best sleep method
based on a duration.

v3:
- Update time::Delta methods (use i64 for everything)
- Fix read_poll_timeout to show the proper debug info (file and line)
- Move fsleep to rust/kernel/time/delay.rs
- Round up delta for fsleep
- Access directly ktime_t instead of using ktime APIs
- Add Eq and Ord with PartialEq and PartialOrd
v2: https://lore.kernel.org/lkml/20241005122531.20298-1-fujita.tomonori@gmail.com/
- Introduce time::Delta instead of core::time::Duration
- Add some trait to Ktime for calculating timeout
- Use read_poll_timeout in QT2025 driver instead of using fsleep directly
v1: https://lore.kernel.org/netdev/20241001112512.4861-1-fujita.tomonori@gmail.com/

FUJITA Tomonori (8):
  rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
  rust: time: Introduce Delta type
  rust: time: Change output of Ktime's sub operation to Delta
  rust: time: Implement addition of Ktime and Delta
  rust: time: Add wrapper for fsleep function
  MAINTAINERS: rust: Add TIMEKEEPING and TIMER abstractions
  rust: Add read_poll_timeout functions
  net: phy: qt2025: Wait until PHY becomes ready

 MAINTAINERS               |  2 +
 drivers/net/phy/qt2025.rs | 10 +++-
 rust/helpers/helpers.c    |  2 +
 rust/helpers/kernel.c     | 13 +++++
 rust/helpers/time.c       |  8 ++++
 rust/kernel/error.rs      |  1 +
 rust/kernel/io.rs         |  5 ++
 rust/kernel/io/poll.rs    | 84 +++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs        |  1 +
 rust/kernel/time.rs       | 99 ++++++++++++++++++++++++++++++++++++---
 rust/kernel/time/delay.rs | 31 ++++++++++++
 11 files changed, 249 insertions(+), 7 deletions(-)
 create mode 100644 rust/helpers/kernel.c
 create mode 100644 rust/helpers/time.c
 create mode 100644 rust/kernel/io.rs
 create mode 100644 rust/kernel/io/poll.rs
 create mode 100644 rust/kernel/time/delay.rs


base-commit: 068f3b34c5c2be5fe7923a9966c1c16f992a2f9c
-- 
2.43.0


