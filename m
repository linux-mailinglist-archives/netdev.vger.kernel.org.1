Return-Path: <netdev+bounces-168430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F24A3F042
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA4F67A6A75
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853D7204584;
	Fri, 21 Feb 2025 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E3Yjg3gh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C0E202F65
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130176; cv=none; b=AIy70GooZSGj53PRLlWIgeAklojQ9OHozz5Z4bpnjNfPHIbzhszwdarSI3+7QPRnf155Tyc2+ks3jwcXBL90nQ6gBoSqZPqlYb2mqjY9LVqYnL9OieF9qcvBvGyuxzauP3vH9QvtqrtOiPbJ7H2Tn4yMH1EGO8I2f8h2zOGRMX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130176; c=relaxed/simple;
	bh=7cZv0BgxF5jJprXMW3cvbv6kUZ2EnUPtZtIgmxGtY60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPxgWEiFnQ2aTSeYFYr20FTN3+36hT6xB/J3LDry9tXdf4izIyZlohrLYW/O/j4CO4L9GY8xWHmREhp9WO6WMs+YK4oYTE0kG8xZ1dSlzBogEUyphg0nfRUZyxuaoTX4TZy/m38wTXAITqFOVbUfAAKFR972icWx3kYCyHaNnQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E3Yjg3gh; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so2474428a12.3
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 01:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740130173; x=1740734973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvvclMQmVyssf6JcFG2R3FXsfh+E91zb+qvSYhFBtZ8=;
        b=E3Yjg3ghvUaiwYlK+yVZNWwLJkqNdPFSm2lQX8d+sTQvBntWazwSbl/5ueVFz099Ej
         Hnm3LIEHupiTdnqHfcbEJs9UKFwq1pA9QhHR6CRnQC/7G2nB0yKq7MlfLe7BxPOMKzZ3
         PORHjv2At+TVecI99LcET8OCkWi4TybuIb9svef6jp6I7QwL9ZL92B7E5g0dWZX7PVrc
         x0b3cU7Ww36HOXe3aYthXH1IP4QXCdyA/DhCtG/z0zvSkCIwsOJjPjUimg1Uoq3Xg8H6
         mNOQHkCmJpYhOjUXEyx1ieYS78/pNkTpsr9yTSezdFEfBUvb3P/Ac4zeOCSwzsCTo5g/
         xAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130173; x=1740734973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvvclMQmVyssf6JcFG2R3FXsfh+E91zb+qvSYhFBtZ8=;
        b=amRRtkVF0Ld5zmwxeFmUzrXLHZnsbrjIkV1gSfkY1WgbB/8BMYrpxG/IvAW1hxW2xJ
         55pFFV4PApq1DTd5b5gQ5eyAPYRy9+kXtyr9ZKSJAiDvRwxehmzDGn44V25JA4zviScE
         S85YmGbmOE5TQt5CJThxn6Cg0Ejf/WEPUPKkrJd1WKF0z3y3AhVhRwUzAoD+1pkbXro0
         aLHeUdzK+fqDpPA/B6XTujQsyXxBWqTaquomKfxVNg7Gs2AvRf2TFpdZ2jHImtuPfH1A
         3j7gnAOMS89+VNwfjT0qbZggGQ9Oxpvs/KKoPz6jP4uBE+8ejWMSwR0Cx7IP7lg4RTd6
         85nw==
X-Gm-Message-State: AOJu0Yw54aztpc3urgvJ5NTcLQQhDK/k04EkVPnBdtwErcHHZi5M6qoB
	d7eDnnNA/u/nZW0T0nasZHsmpjWxRsP2/HIShy00cMWeSowEzA7b9JNtGOkbQuO3qNwXsa2dFEd
	Zt0RVpQ==
X-Gm-Gg: ASbGnct6cuFhTb3vVbHfSGn7tUwFLpu9JTgNylXC3jvK4MGJ4vjJ2f2D0noZcWt9JMY
	HpvmM8zlekMnRzcE7IBpV74zux3ZbgXYLlSAKpnyZAoQtH+O4VtwRt+fPd5mkq/FFuhKylrgoPS
	Gg/JXSRSuqH/TGiJrHim9qBDupwz66tLYhsXGQ6Z64hRy+EWfzyDufW1vR7ZQjB71xLgvWZ4L1H
	u2ptluDssuQKkSj1UTR4wsazb18HDF4ySWHICkTTYTUFHZXGqA5EMYNNZtIZmKen439UCqS5MHa
	d4fxYWC2F4RILAH2Lub1rKFEp4Y4
X-Google-Smtp-Source: AGHT+IHpAZFYIaeC+s9BJR5qnApensqJUtP600yHdDN2jTuNav8Bt4kWjGa2+93Tc3LBrShzvyd9Lg==
X-Received: by 2002:a05:6402:3554:b0:5de:594d:e9aa with SMTP id 4fb4d7f45d1cf-5e0b70df4ddmr4756492a12.8.1740130172708;
        Fri, 21 Feb 2025 01:29:32 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b5415sm13272161a12.4.2025.02.21.01.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:29:32 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: netdev@vger.kernel.org
Cc: mkoutny@suse.com,
	mkubecek@suse.cz,
	Davide Benini <davide.benini@suse.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 2/2] README.devel: clarify patch rules
Date: Fri, 21 Feb 2025 10:29:27 +0100
Message-ID: <20250221092927.701552-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221092927.701552-1-mkoutny@suse.com>
References: <20250221092927.701552-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 README.devel | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README.devel b/README.devel
index 60c95468..1c80a336 100644
--- a/README.devel
+++ b/README.devel
@@ -16,3 +16,5 @@ aligned on the mainline Linux kernel (ie follows Linus).
 The iproute2-next repository tracks the code intended for the next
 release; it corresponds with networking development tree (net-next)
 in the kernel.
+Patch submitting rules are akin to kernel
+    https://www.kernel.org/doc/html/latest/process/submitting-patches.html
-- 
2.48.1


