Return-Path: <netdev+bounces-138955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 057269AF840
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 05:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A200C1F24E28
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952FF192D9D;
	Fri, 25 Oct 2024 03:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mb0vxuoQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C8E18C029;
	Fri, 25 Oct 2024 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827271; cv=none; b=n7tKpLvp9Vi5Ix1xbe29xYM6Q2jIWoVqAWMUjOgzEppr3zBO3KFpKDxZe/Gcek7A/7qRyIXIwUlgOfv1UW3frgG5WXynJCGjcxtpUaQN16y295v54rq1XRbZMOyBIugqZfa5BCjFogVZgiUYxbZdeAgoIcRgIGw8AN2B/bCo+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827271; c=relaxed/simple;
	bh=YZIDna+Nw7Nb23XtlYPw5rT7pMv1qHX5PotS8Nu/1Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xl5mpQikZYaVLyVljocVZHYwhXIrtfr8w7kBGbcsAPt3oEEm1THMqDYiMCakqSlnk2eKIg4XaRCDlo2859+j3CZK+ezwq7hiFbg5ZC7Ep7FLiwp0y58Q16lPMQBSR41T3bO5VlgSw0bYpTs8KsG4mX4o0Z4aTatMvg5paK+LJQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mb0vxuoQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so1067347b3a.1;
        Thu, 24 Oct 2024 20:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729827269; x=1730432069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjDi4l6vEO1+WFS2aicMTlZT3n6TL7cER+Vr/4E6ZEo=;
        b=mb0vxuoQuU5XF1bjDLkAaztl+jxOpNdh9lXOoF8WleSOR5xUfs42hbwcw8T/5uCKQh
         siMQZDsSaozrScWF3oamxkZhOIXZVBO+1zvSzu1si9LEhLvOUypBB+2yPU/BRbUGx2Tv
         HmD/qHrd/4lHIukr+8JjcZCJOheuRRNT4BBcBWyYVXLqQb2wGFWkgDaGtg7xCYoXaW02
         JqvdyyQFzwM1sLONEMnP0PiOFQyLxHPvrMq3eC/nq9fl4fEuTk9C/bYZ8O4x+KLwu7uY
         3uKqZRSQnc0BYOrgb3khwWnIAoL6R0lBgnUX/kdrGYi7FuUWQp0pOo2sc/4vSGOeCNFO
         W26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729827269; x=1730432069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjDi4l6vEO1+WFS2aicMTlZT3n6TL7cER+Vr/4E6ZEo=;
        b=igU13Cl1rGKkdZhCZFg2tG03Y7nrmgltoxFyN6Po/dx2Jvr+VLcQI3WPhf7O3bXSFJ
         1MCTu3WLzWpH0BeqF06jH0ORwNXvkDup8NSeSo3BWmn76fbkyzEa/TzLG1Pl9JwnHhm6
         CQmQ4QJKddk5kis5Ubwkeep1vbddk78BpO832LVxneyXrM3buai51Gj8iIyLpJuspbwx
         kw6UH7IPTJbXVVmt2P+9GLmDGMQqrNZlmGXsFybjrZUsDHD1tbe4KT+Dd1dsaUA/RZd0
         3aYaI6q24a0TzjcpIlwbvc+qchVjhUMAdD4Z2I9xNvMnKWsdZNClNXNeGAMO9FnA38E0
         9VAg==
X-Forwarded-Encrypted: i=1; AJvYcCUEKv9GfSnEp0WCsZdxNHATtY9rX4o7gSfSc65Teazvy7R1wjww2kqrAx/EVGp3/FoCQ2RGkFnHfj8snuY=@vger.kernel.org, AJvYcCVkNtNgVV3T0iCykNsKotCW1sXitoluYSvPvZwiKPJT1+mnYTNnAL+DaQLboUSuEkwzwG94n6KaXVbR0C/YlBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+Jna7U3OWOU0jgjZI8lCNGA4T1FTEunJulUm5kWyJFjPtWHs
	CfDFpmfvZYGGS6zi2hexY+rylKIZYjfNyrtcMnGplvPUsrsSsxLH
X-Google-Smtp-Source: AGHT+IGj8D98wvdlX2ZQTp8eyWXOuPeE4coGL4RY/0PkUBoLKhcwVaWnypW9CYrjTNiIO7nwt++/Iw==
X-Received: by 2002:a05:6a00:22cc:b0:71e:6122:5919 with SMTP id d2e1a72fcca58-72045f8ebaamr5022392b3a.20.1729827268930;
        Thu, 24 Oct 2024 20:34:28 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791db5fsm180188b3a.11.2024.10.24.20.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:34:28 -0700 (PDT)
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
Subject: [PATCH v4 5/7] MAINTAINERS: rust: Add TIMEKEEPING and TIMER abstractions
Date: Fri, 25 Oct 2024 12:31:16 +0900
Message-ID: <20241025033118.44452-6-fujita.tomonori@gmail.com>
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

Add Rust TIMEKEEPING and TIMER abstractions to the maintainers entry
respectively.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2250eb10ece1..6fb56965b4c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10171,6 +10171,7 @@ F:	kernel/time/sleep_timeout.c
 F:	kernel/time/timer.c
 F:	kernel/time/timer_list.c
 F:	kernel/time/timer_migration.*
+F:	rust/kernel/time/delay.rs
 F:	tools/testing/selftests/timers/
 
 HIGH-SPEED SCC DRIVER FOR AX.25
@@ -23366,6 +23367,7 @@ F:	kernel/time/timeconv.c
 F:	kernel/time/timecounter.c
 F:	kernel/time/timekeeping*
 F:	kernel/time/time_test.c
+F:	rust/kernel/time.rs
 F:	tools/testing/selftests/timers/
 
 TIPC NETWORK LAYER
-- 
2.43.0


