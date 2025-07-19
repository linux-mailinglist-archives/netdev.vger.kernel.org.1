Return-Path: <netdev+bounces-208359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8CFB0B22B
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 00:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F41165784
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 22:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016AA224B00;
	Sat, 19 Jul 2025 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JI7Bp2sC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864E82F84F
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962651; cv=none; b=Z4f5AlF9S06zOPjPmo/gC2YGXPZu6VYB1shYqRcHKvNicnatFP5r2u+uw4858spVIIY/vVMS3pozlDWNiBSEVVC8/KF7GCFhhZc2XdlWUcoG1/gEPBsG+i9OFGaMJSmkLDBuj7XkfYb/g0NTQTlcxiSMcMCRLo/yzDn8QwPSIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962651; c=relaxed/simple;
	bh=oTlZvMqedNVhhVJ+yKfdhsYaTvmbp0Dar5N6YVhbKfs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nJ3WEh/DyaP9WeHeIdJGl/dIwnJ5pS0m4t0k7OkzPlMchxVbsjkGSBI1sGoRbHB/b26d5z3U5/iNUyh7BviZEdlkwA3KafF5zs+fj8xFriFXJ0KdhFDDgrqazTNw94DY7JS6N/T7//sb2thS64dKbUIQlvzq9TNOcPq13dZ5YaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JI7Bp2sC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7490702fc7cso1998690b3a.1
        for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 15:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752962649; x=1753567449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EAq/A3XygMi69nHQWvp3KpHKhkEVO72T0z+JUWXh4Yc=;
        b=JI7Bp2sCXUFcPXaL4LRdWy6kNYI2hI2NNCI/E948rmW74LTdfadFZMaci8EHU21H+X
         Cnt63ueS5apnW+gRAiCfrvEWjFyAyPdI8SkysETF0ppFyB5JjRMh/C14V1XKRTrRjdub
         s+aiohIfpOilVMapUW4+FR9Y0MJY+jbpBO8e9fvXbG9Ak9BOFvTr2yW/AQtnNfb6KKWP
         5p8KYUPUGFSWKiuanGj05876u6btEe3jZR71DNSNvYHh8ox2ZIV3avpfinJFJYaOpF1E
         hWz3vvusZpJM5j1AgWsb+IKRlJ76vUCOAXhC5gZuIfTZPCProX55HovnXF3oil0NHYR6
         Ti4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752962649; x=1753567449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAq/A3XygMi69nHQWvp3KpHKhkEVO72T0z+JUWXh4Yc=;
        b=rPQB0kJ06D0taDa7IzxRy+UYXhAOghYahBY2RRXsDMAFRRHPqz2yCQiQtqFz4J+K2Q
         CqPRkR6r6mZs2onoOBHXqb1e1ijCsOneHzoNq5RtXUF6LOC82cl8wIkBs+9vWTTJ+4/3
         /DtXgDk4zCJ2nJJ3vPptN9uuAM6eI8lLR3AT4TKed0SQp/n8HQzDBpMrgiLt2t0hy6Vu
         2yjtYixl72qcm5nloYwYZBeH1ytUTaG/3BrwPgfzxHdTqYopC7PqgBmUq1z5tO9unSsf
         LZ2LUg97UKwIimOmtFwGX/JFmgn55CDnRWY0cFsm6nGzbqwvVO+gu6aFW1kQKk94tkJG
         Pc1A==
X-Gm-Message-State: AOJu0YztYdAkWrUkhl7LteJzhovo+hMHpqp4K1x24cxgMzWk7YG9l3xo
	Fz0gj7RJ1BTQvQtTOSmm5ZjDkF+fwb34w3j3iBT8ll+vb5ftZYH4A3tbJNsIOw==
X-Gm-Gg: ASbGnctoZznMghXYVU9xpfkwMSl01w85di3eF8guyhaIIQI7Zt9IhOKM2Rhnja8y7RH
	wflTnq0weYi2gzkGjhHVQe/STqrDZVSq01Z7/QvcDnqVWR0If/f7GvJyEFw1hboCsNBDlPvQlmn
	gB/4vY7JsKjsqhw8j65Yoo8YVAG1GgvvLt784rFTJvGwkhBqFXtBqqJ56sa+41qk0eE0F5chuq4
	JkKOkd21MjzDE0QwmQQLq2iHO6wZmVGIo6kL8f7cZ3sSoSD5TJYpuQ0NmrZVmm/UPNOcQOu3Lp8
	mz9mMANOpvau9uvG3atsndkIloest5pAf41tuGjD/X6yStw4iJabMhTiKm48PBtsEXsQGadIbgJ
	dW8dOfUEQtG6JmxRdh5Oj1o8R1mI=
X-Google-Smtp-Source: AGHT+IFFidBN/m0IcD5ASeQnq/cZShPy3C6ziIeFmpycaJtsk8ZmZbz2z3N/R13FkxiV4DnKFPFYJQ==
X-Received: by 2002:a05:6a20:7484:b0:215:e43a:29b9 with SMTP id adf61e73a8af0-237d754ae65mr23617174637.33.1752962649142;
        Sat, 19 Jul 2025 15:04:09 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:b3bf:9327:8494:eee4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe6a09bsm3084040a12.3.2025.07.19.15.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:04:08 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	will@willsroot.io,
	stephen@networkplumber.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch v4 net 0/6] netem: Fix skb duplication logic and prevent infinite loops
Date: Sat, 19 Jul 2025 15:03:35 -0700
Message-Id: <20250719220341.1615951-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset fixes the infinite loops due to duplication in netem, the
real root cause of this problem is enqueuing to the root qdisc, which is
now changed to enqueuing to the same qdisc. This is more reasonable,
more predictable from users' perspective, less error-proone and more elegant.

Please see more details in patch 1/6 which contains two pages of detailed
explanation including why it is safe and better.

This replaces the patches from William, with much less code and without
any workaround. More importantly, this does not break any use case.

All the test cases pass with this patchset.

---
v4: Added a fix for qfq qdisc (2/6)
    Updated 1/6 patch description
    Added a patch to update the enqueue reentrant behaviour tests

v3: Fixed the root cause of enqueuing to root
    Switched back to netem_skb_cb safely
    Added two more test cases

v2: Fixed a typo
    Improved tdc selftest to check sent bytes


Cong Wang (6):
  net_sched: Implement the right netem duplication behavior
  net_sched: Check the return value of qfq_choose_next_agg()
  selftests/tc-testing: Add a nested netem duplicate test
  selftests/tc-testing: Add a test case for piro with netem duplicate
  selftests/tc-testing: Add a test case for mq with netem duplicate
  selftests/tc-testing: Update test cases with netem duplicate

 net/sched/sch_netem.c                         |  26 ++--
 net/sched/sch_qfq.c                           |   2 +
 .../tc-testing/tc-tests/infra/qdiscs.json     | 114 +++++++++++++-----
 .../tc-testing/tc-tests/qdiscs/netem.json     |  25 ++++
 4 files changed, 127 insertions(+), 40 deletions(-)

-- 
2.34.1


