Return-Path: <netdev+bounces-158752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4340AA13217
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5113A57E2
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 04:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D9E154BF5;
	Thu, 16 Jan 2025 04:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMx2pg9U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FCC158D8B;
	Thu, 16 Jan 2025 04:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737002585; cv=none; b=CVCVnNSknY4NGPwtKfNvgPMExZw/nZbNYmZyBFVMgiDSCu7zMhHmc5aVZjsYZNv2QnKWs2llEtxzBfCmiUQzRAkg5dr9ldS/8ujHJftQYV3jfnGCspfoFgqv9Cm6TF5eetWJnCTk8CCBMzbpCM/ob7ZYV4mc/BitW6b4i6hGeLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737002585; c=relaxed/simple;
	bh=QCMniBBTurKlsiy0RrGlj3k+lcWNbYodF8V4zYwePL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCQzv8FIRccxkUljELaIuSVWbMmHvi5IKkyJTNg6gZhrPY2YYzyNONST+Wf26S0OqYgYaL3jGLxvYcNbgbilgLHdR4P0fcu7gS4sIuIcLLTcgjoettU0802SoZ3z4/V3qHYT2ajQWst1WEwERs1kimrL5lZwezbYMpHpC3ooj6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMx2pg9U; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216728b1836so7058015ad.0;
        Wed, 15 Jan 2025 20:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737002583; x=1737607383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sR/+/dZXDRQ7/mF/Sv1q8TJwB25bHgFlrdQuIhySF5k=;
        b=IMx2pg9UXc31ArQimcDPm7mGVD7BKxNJLRQp22N+f+NubQLaXQ6QggoF+4vOA7rkze
         XyWUNMf5gtdcmBA9njWx4rsucp/LPlBwFs1LC4+hcvJ+mn34wqKMdxrWIbNJONzr9fYp
         wDMrC4aYh+V4eFVFdif6sJleVX/sn+7autgkpL2HTwgkc7XKwcOtIHs6snwPFptGIUMM
         hwKXZItehFuNuHxeuo3LCv4+zzFNYWqeAGmZabpLc5hkm0nyS55xcgTxepfMb2tMCJt0
         H2ESFG+/+1wKoDTSwQPcnoh9sWnkOHq8gM7is6oenjGqhu25KHo5hwpk/wO8LsDLWvPv
         qNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737002583; x=1737607383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sR/+/dZXDRQ7/mF/Sv1q8TJwB25bHgFlrdQuIhySF5k=;
        b=cZ4xilK5YuER5pSqWB6UCEyRjGxo0xqxDZvlKp+UCpSAesJAiJUwwK2kst1D1bCBnX
         PPtXAiNVtMXYrcFUxoKl2gXMt7T/YbERptukBumduzDCjYTPpwxGj5eulHrS6YzsbVN/
         MFBFu5V9neVWjAos05j6VPhD9LXOKhB51C0wRLgJr1OxXyduWCUeE67zGD8xvEcn4Sys
         UwBPkPB/i+0Cej1XDpWFBmXgDoKh7GhPgkWYSSTTevQTDYaiE88TWy8zVH+CQCOXXVc9
         bcdEqph1vGSllNRABiv7OX6QXMQCrxLiLVdfg1GoEEUumIV9c6JU5Ru/tkzIo+5atjEi
         C1VQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/8OXN68VaDE1WfOybyM9wp6WPHLlvWGouG3BswdrFPrXzCelUnqVapFI1nSkymvEgWa8cK7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwapblyfCkmRLDg1Q6IiFHNGJLNjhdfhhjN+1CfDKR2IJb+s4Wb
	fgsbTq4G8rWyJAOqTbYQS2OCnqBTRdu8yk/1RE3Cm5S3ARG2Y2egPNgXLzRm
X-Gm-Gg: ASbGncsoADUbb6bNtden5oTh/XM3ZRKfPx+b4TVtMv+7m0WgSFOATzqAeg7c3YaUOrg
	Jts6s1Vi9XW/Qin2sXDtvD8GHhePmvJSJX0StSxHpKO48msd35mpNGKjjYbVIc6bNJnpijh+cbl
	6SkKaASsSZZutzGpHXohln27fQo4vJkIEBykAQUTFnvJB7jO8vcixwbP2w0iMBg96K9oHoxDwcP
	iIwjf/+zIeW/R4FEk7s75Yxkbw0a41A97sIonoZ1S1wL0zVSnAD3xmfbm6c2Lu1azYzM/zpc9I9
	dvtxdAVuvoAnxG1YSJbczV7IMc9jPe2U
X-Google-Smtp-Source: AGHT+IFpmhSnVVzlqkvJXV3QbkNm28zgOpZwKPS/NqCuF5ndEvlcjPRKOS3coyLV++pkNSPPKVrIlA==
X-Received: by 2002:a17:903:2308:b0:216:779a:d5f3 with SMTP id d9443c01a7336-21a83f546c3mr540495325ad.14.1737002583007;
        Wed, 15 Jan 2025 20:43:03 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f217a60sm89161045ad.158.2025.01.15.20.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 20:43:02 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org,
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
Subject: [PATCH v8 5/7] MAINTAINERS: rust: Add TIMEKEEPING and TIMER abstractions
Date: Thu, 16 Jan 2025 13:40:57 +0900
Message-ID: <20250116044100.80679-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116044100.80679-1-fujita.tomonori@gmail.com>
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Rust TIMEKEEPING and TIMER abstractions to the maintainers entry
respectively.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index baf0eeb9a355..77bf1d2e6173 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10251,6 +10251,7 @@ F:	kernel/time/sleep_timeout.c
 F:	kernel/time/timer.c
 F:	kernel/time/timer_list.c
 F:	kernel/time/timer_migration.*
+F:	rust/kernel/time/delay.rs
 F:	tools/testing/selftests/timers/
 
 HIGH-SPEED SCC DRIVER FOR AX.25
@@ -23643,6 +23644,7 @@ F:	kernel/time/timeconv.c
 F:	kernel/time/timecounter.c
 F:	kernel/time/timekeeping*
 F:	kernel/time/time_test.c
+F:	rust/kernel/time.rs
 F:	tools/testing/selftests/timers/
 
 TIPC NETWORK LAYER
-- 
2.43.0


