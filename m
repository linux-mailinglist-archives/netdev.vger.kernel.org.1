Return-Path: <netdev+bounces-243848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A4FCA8986
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 18:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6165301B4A6
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 17:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A763491DB;
	Fri,  5 Dec 2025 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5YTeIx5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD61B345741
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954749; cv=none; b=J/q4prabhE1f+7yhRJiMfg8kyiyfJ1kfqz+nP6ckES6suvUqfvYjBs226TwXYixQaOUKwlMMsLLb59MTNVlXY7F77VNVEoZyON8rQb712qZRk0QCwuJ04y0WzjffOKb6PJs3POOIIRFIA8yyEG/awVo+pgjQVS73tgaL5D4MPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954749; c=relaxed/simple;
	bh=M2vFDyyUfG7JkznxChmdBB4qNaHZV2aWYVJ2i7s0Hfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLkq1GTseskIsDkt5ETC9s3JTHq2z5fhhpIc3a9x19xjeZk+kDSLWKqktpbM7JvBxo9Lx/PXpVUIG/8dCLvIr3latK7FhpjRJcGFnvvpIOYvH4FlKSMvWk33+Y0SycW2ieEAJtyKaZCDlrRm38dwMHou0cFFsmlmHVIwKDIdPR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5YTeIx5; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bf1b402fa3cso2162342a12.3
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 09:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954738; x=1765559538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vBZwIvLvx6D7o9yPmhW2hQH1LVZ8ZbPnLZnaPeYgfI=;
        b=b5YTeIx5tQetKP0xsFxE6Xqgr9WAqiYEYngVQjIgoDX2C4ZRKp7GYZSP7ZtcQZr2er
         R4Cz2RAbfV9iq/ksTAFCv+o4JpURo0vMtLMSORnEHm+OCO3z2z3mfZivv/64YEHqZj9h
         GcVU9Dza2wZwaiRxEGtE2TpZuZpUatV+A1yudGhDm19BYNlaU+TBw1csq/jK6kfqM7UJ
         thgHXCzMba1QflmatWQwucm8GjeeDPYR6Iph7yrZszQJ4GzsybIoLz7qYWMc8iK7p9iE
         8sMPlpWsdq2ZOJO8bh/+cPiK8sv7oeCFB6ktM/IRHzhwsqcY/3IRmpcxHUI5o+eEANZM
         v+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954738; x=1765559538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vBZwIvLvx6D7o9yPmhW2hQH1LVZ8ZbPnLZnaPeYgfI=;
        b=cIN/QDMqTi5mmbMKr1QjXdM916yPsDxKYMsvgqawcw4IYDcpXGya5BOEDJbPIF9115
         Dh131K3GztssgQB/IvuwXomM/GReyndy1aEwjM0jV02CejBI8viEUF+xuZ2cd8iQB34d
         02Z3Aid39EUnakLHgd9D0C8gKDnihSmpWOkTBcUFjSud9c8buF+C8W+iTchNL+2T13qW
         m5RDbwlRCl3nJ5JwR8GYhFe19OgHLTc0BuVQHcyUdJOHM304FqrPSVhUcnZp+Q6udQdN
         yTCNEVcZmyUwN2ghde6a2Hj2rWnWxvHXR9e7Yta4JEyVpIfEXqJCpuezz6AB8kEsdU2f
         6LKA==
X-Forwarded-Encrypted: i=1; AJvYcCVFbDFO1teBR7mLM9YjTOR3qkti4D+Xyr1JcJMl3TRn6jIiUR5mzg0XmU4LSVegCuEdITn/qCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhpUlNs2toQrZ/eea1fzpOGHrZlZ8+jZ+dm1JuqFD+Q58hTfrL
	5liSKIMvN8E4SBCJ9F8Pe7WBMFc71a2UBbT8ZLC5KIxUpsOy5YJf16tk
X-Gm-Gg: ASbGncvFRbTg+q8OYwYvwsIsSuTdZ4oJehISTcFvOwIqrZg+i1X6NR9zbWIiWTa9ArE
	jZbenQiukjoj8PPqxB8mEuTAogBFh3+tZ+zyU2MptpGqRtkycEgnndfFOjBuYtkYwTTgSgqr5R8
	2j6sdasNaHJNJpXJQOaVBPAMKFSo7qCcFyaafIi39Wula/cR+KMK5KfLA4/u9u3p4SAUTs6eAPR
	wv2TSBz23HpDcx3KFPN/eGq6BImOZL2OulJS11wNzBCUwuQmi/S7rAKge/kqOITS9TPzkd8upI/
	OB4VRnrYmnkqu9NzKdjyQUViGPlaGbVrYSy4t2ttnF+XAsJzGe4XP/fCL2PPusJbFWkA9HhvLoY
	QpGUz/8c/miUj4gXR1s55CvdVpRKuR4pUpb8GpFuZ/591+mRv7ryiaO3UHVl7/zy9+9OHIETEsh
	qTuH+meebFVO75H97z0IXOZ3OTzgwLSntXew==
X-Google-Smtp-Source: AGHT+IHedJC93D+L43aGh0gHVYz0R+imftKPymAfmBV+49IIc8qNl+K0a9+Ao52i2Vy/p8ADlA4ahA==
X-Received: by 2002:a05:7022:6722:b0:11b:d561:bc10 with SMTP id a92af1059eb24-11df0cae991mr7658546c88.41.1764954737734;
        Fri, 05 Dec 2025 09:12:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7576932sm20209499c88.4.2025.12.05.09.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH v2 06/13] selftest: af_unix: Support compilers without flex-array-member-not-at-end support
Date: Fri,  5 Dec 2025 09:10:00 -0800
Message-ID: <20251205171010.515236-7-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix:

gcc: error: unrecognized command-line option ‘-Wflex-array-member-not-at-end’

by making the compiler option dependent on its support.

Fixes: 1838731f1072c ("selftest: af_unix: Add -Wall and -Wflex-array-member-not-at-end to CFLAGS.")
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Just using cc-option is insufficient since it is not defined,
    and if it is not defined it just disables the option entirely.
    Include Makefile.compiler and declare the function locally
    to solve the problem.

 tools/testing/selftests/net/af_unix/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index 3cd677b72072..4c0375e28bbe 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -1,4 +1,9 @@
-CFLAGS += $(KHDR_INCLUDES) -Wall -Wflex-array-member-not-at-end
+top_srcdir := ../../../../..
+include $(top_srcdir)/scripts/Makefile.compiler
+
+cc-option = $(call __cc-option, $(CC),,$(1),$(2))
+
+CFLAGS += $(KHDR_INCLUDES) -Wall $(call cc-option,-Wflex-array-member-not-at-end)
 
 TEST_GEN_PROGS := \
 	diag_uid \
-- 
2.45.2


