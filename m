Return-Path: <netdev+bounces-183880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAC1A92A33
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 20:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279191B62FE7
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF8A256C7A;
	Thu, 17 Apr 2025 18:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eB3kMnfA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C4253340
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915661; cv=none; b=oVD0K9RBEI0GTulHXhFF1Y6ftRW7lt9v266a0xbqcChTC6kIa3eUTaIz3HWkeFxd3wEjRJIlOzmD9Ul1WAJsj/j1cxetqAACyCAa3BZcdRPMdNFbabefv/IZY+UQSgTy3eyIefoBozlkiPjyL4910PSNUgaV2F24dnizJxC6NSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915661; c=relaxed/simple;
	bh=C6FGWR9cagcWXC8JfgVQgDy7QYgfNbeFEaR6HNgqrmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U62m+Yc5an+RhRsLWhGb9PRHhLlwNXyamMlWMw2zNjT4biy3hOdITnfaJ366qBduAhVu3+9umMxKdhiXJLU6BRf31vrcbiDYI6R1sr/59ARHgsZ2fufyMLIbAr3NBhJItGcSxmk/AH6ZxwXb/KN7/5cr/OfZPy+T46EbfddirMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eB3kMnfA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7376e311086so1555169b3a.3
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744915659; x=1745520459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yel4VDgUQY+pn8ZbG6iwZSeDlSNJe51qg4wtvM8xfg4=;
        b=eB3kMnfAMl6psenDxGyGnXNik3VkfSiUC9iIP88SSVeuAity47Uvb0x/+/zOEoZN8O
         6BMXEOGsZQ15mWmCBY3+VgMJgyUhKJ9DU+ye+3Pk2zu8ufldeHECOFvJb3wYXGHQvI7l
         afdX1zZpwWFItmzfN08zxnVwS1ZibgvSv+FWxie80X8LEnh3eutYiqxEtHvicVZ4Yy47
         DSmUK+jC/tLFWldIu0HY37kx6seX0kTTM1wAXPL/TRMeJvNBov6Wd777ZtYMK24gzfy5
         mDKKyX72xBOI88oIK++J+xL9CdxP3uWdEkKd11ymtcMo8mVoGWhdxv4usyHvEsqmNU9o
         fT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744915659; x=1745520459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yel4VDgUQY+pn8ZbG6iwZSeDlSNJe51qg4wtvM8xfg4=;
        b=ZCxEAg3qmA8Fdt+X4NlhIyjYGHLtI5nMwlYCYtz6f4vi9l9dX3PzjBYbxBimaYMVMW
         jEaykhO4dMSilGqKB1DHioLJJGqO8fyqtl4Foa1EXM8V45DjnyAAUlTVAqBES1s2Rw6+
         GBuDik7Sx9p4R2BG6XHu7+IJMxbL094V6Ojprdfn65yqV6PrOGh/tV16/hNnvrJVG1pX
         9QqnHmZTVUDXHarahMKAHGi3Fwgi10B/UVjplqTEQro1Z+JGbox3iK7EtcyYdL2keWaA
         RxA0EfhQH2KzUlHwB/uehUto4dkoZc+gsWfyr8nr9NZnXCVYkncxypfA0jypAKbj7KU1
         1pqA==
X-Gm-Message-State: AOJu0YyXVo5+NkbISYNas3kYPffSoKV00j4LUy93NlgwfF9FyIRGks6y
	1FdtExV8fIGlOP4VzsTIg/qF288YVuQyj6yxNh4z4E1DmkSxZvo/UWYXuT69
X-Gm-Gg: ASbGncsDX0KevqXsNIbtJjLBdWMAuZscGHx7P6N32RHgV+840f9oYOVHY8taOe/rg1n
	Oq3+/rjhAt2UtuRylDHwzy7uXtr1Ycg3xB2Rf/FP3Qoef6XFqTexnGF1bluFc9l05nc5E1yc0WI
	aGkIAxeIb1xZAgqBkRXltYSqpdWI8gj+smvCN1EjoB0go2NFx1BdKufTVCCwyD/LcC+yBVYa804
	Jyhq3oYDAzyD8dOF56ryZDAK5riTq4D3wCCFPbOYKoQFf5XITEyILQQoUjHs2XwsQ0JVMBI3zfS
	Wp/L+sCYd7Fg8cu8Jr6NFDdGQeUx956LpWRA8TiTTeRTDlgf93M=
X-Google-Smtp-Source: AGHT+IE5Cx0BlvGxiKUIvF8lvLz/HgUEy2tQOnvY9StQZrzjgcW7pLHxkuOPhpIREKTInCVxYckBMQ==
X-Received: by 2002:a05:6a00:acb:b0:732:a24:7354 with SMTP id d2e1a72fcca58-73c266c6598mr8787897b3a.4.1744915659203;
        Thu, 17 Apr 2025 11:47:39 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaad645sm187773b3a.150.2025.04.17.11.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 11:47:38 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Konstantin Khlebnikov <koct9i@gmail.com>
Subject: [Patch net v2 1/3] net_sched: hfsc: Fix a UAF vulnerability in class handling
Date: Thu, 17 Apr 2025 11:47:30 -0700
Message-Id: <20250417184732.943057-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417184732.943057-1-xiyou.wangcong@gmail.com>
References: <20250417184732.943057-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a Use-After-Free vulnerability in the HFSC qdisc class
handling. The issue occurs due to a time-of-check/time-of-use condition
in hfsc_change_class() when working with certain child qdiscs like netem
or codel.

The vulnerability works as follows:
1. hfsc_change_class() checks if a class has packets (q.qlen != 0)
2. It then calls qdisc_peek_len(), which for certain qdiscs (e.g.,
   codel, netem) might drop packets and empty the queue
3. The code continues assuming the queue is still non-empty, adding
   the class to vttree
4. This breaks HFSC scheduler assumptions that only non-empty classes
   are in vttree
5. Later, when the class is destroyed, this can lead to a Use-After-Free

The fix adds a second queue length check after qdisc_peek_len() to verify
the queue wasn't emptied.

Fixes: 21f4d5cc25ec ("net_sched/hfsc: fix curve activation in hfsc_change_class()")
Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Reviewed-by: Konstantin Khlebnikov <koct9i@gmail.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_hfsc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index ce5045eea065..b368ac0595d5 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -961,6 +961,7 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 
 	if (cl != NULL) {
 		int old_flags;
+		int len = 0;
 
 		if (parentid) {
 			if (cl->cl_parent &&
@@ -991,9 +992,13 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		if (usc != NULL)
 			hfsc_change_usc(cl, usc, cur_time);
 
+		if (cl->qdisc->q.qlen != 0)
+			len = qdisc_peek_len(cl->qdisc);
+		/* Check queue length again since some qdisc implementations
+		 * (e.g., netem/codel) might empty the queue during the peek
+		 * operation.
+		 */
 		if (cl->qdisc->q.qlen != 0) {
-			int len = qdisc_peek_len(cl->qdisc);
-
 			if (cl->cl_flags & HFSC_RSC) {
 				if (old_flags & HFSC_RSC)
 					update_ed(cl, len);
-- 
2.34.1


