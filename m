Return-Path: <netdev+bounces-204684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EC8AFBBE6
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7E7D7AC333
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 19:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05260262FF0;
	Mon,  7 Jul 2025 19:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0OiCPXv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8AE233133
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751917835; cv=none; b=L71dtzkK0vT+OzGhCb8s7oAtDs7+UdIKQzxsNEngkaXdP4a9oXyKxV9R2zhTAbsHMl8Yd4Lv3hsv72Jt/00AUW3i24ZQlskhknC36YVAeNRA53fDRm43xVIeGzYu50idyQ2jLZMDUSKTrP22lZd+iQB/b07EBvLUwYI8tkYd8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751917835; c=relaxed/simple;
	bh=2MeJh+FQ7ljUYPhCAGcCNuXVwXJ3AhQBo9cMoxBenQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tODQ1DE0Cq+ydQ2TnS9uVs8377/V4XX+lKx2NEyohgiLGkc5Beyuy8U41cp3f8902hPupXjkrCpYvgWn9KmNvk25x0nq8CoJSq9pjeOlbIFlRmveTF00qYIyJL6aUqG9EtK5Ep3KWNBoJOzWGHbnMikt2mOmBlH6XSSKZhD/pZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0OiCPXv; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b1fd59851baso2505821a12.0
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 12:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751917833; x=1752522633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gfqVmDb5KDAzOCFQrsPNKqXq8Z9ZbJBGBRlfzT284PM=;
        b=g0OiCPXvB+M8PQt0PenZEHpB19yKJ37zrB8ef4q/sE2BHUP0vPDWoBprb2p17GE0uH
         irGD3lvMApnadiMFUFso7dr9feS/LrCg2tKtbzda225CZpM84OMJexnb8UkgVtWtDjFS
         QNbMwkcGRVXl2TKdsg852doAvjJ3MXgRRXIMaYEml1DxB/EWhc/f7GWm9BkyI4p5ndHZ
         4izDZCvnUCEk1hzLltvGYoXcD8Zv9f10LhuM7rgXBp3k3ntjXtzDPzmSolrYZZuSezXh
         Q9lYS2DckWNfq6spzxcLdGJ8jBI/oi3KSYhLa9vPqV1z1XAzarC09Qm6/VAIKaMBgqhM
         3eyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751917833; x=1752522633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfqVmDb5KDAzOCFQrsPNKqXq8Z9ZbJBGBRlfzT284PM=;
        b=Pc3tQe2pFMY1b1B0UefCfDo1wK7pdfUDC7Cjbuu+YWLLLh2UP+VVgm5M4nEERgVtTn
         /otcmuAXMJ1EwkFEQJFYE5dt/+72YorGQ0kQLlGVcQIrX2ejMZtCLJCvRjxguYuMs+xd
         bZCKKl1u833hCDmMDETvs8NcRt3X7rPar2hqZ+Gr74HsNyi0j7UX78aX53ohGQwYd2Yt
         1w1Zl+T7DHnN568ExEZemUMgGGqTgI/Bs64w6pUCEuz8tcEBlHl74LhubWR9ajUFgkCj
         KTb2k2o6t9aWkxHfxKPdacJiQgOaJucYBp4IMlNUKE8Ys6wj89plh4YNznXQlRrD3Gji
         OAdg==
X-Gm-Message-State: AOJu0YxasnImSzAUEwRqiXWzIM0X5wYlS8EFIFp1iLJxJenAz3v+hP71
	Ao/iX8D4461YlpRJ4t2gzMsfmU1bETgclJu6stte6bF9xuyKLISv8qgbCodheA==
X-Gm-Gg: ASbGncvBgNn36aAosqndJuYSCs17C6ioxZNMCqEHjATHp+ei6GqB16upKjLWnYK0VqZ
	1xICF4KBkTnQZK0PelnXXe3YYCZiduGeADEbaxF6nrtBufoUjPtnJtj6ejga28zv/kkI937rfUt
	0FuHu8Bs92eJVSnqcthKEDhFeweKY614OY7rFHQbYwnBAm9Akd8rxNAsv9Sugk5D/6DaLUMM1aY
	VmZZxbkmNHz3QLWGJl4TgUrASy2sdplO3M9gQjk7AEuQ4mugIqG6x7+ggIDSQHEwokWk5aTlBxu
	Zrlm9BuIiDtFSuJo1Eku4nwhNlPt06qtGNMVCViRirV4d8y6vZ8sqn9wL+LRkwz8irQvo2TvAKe
	v/hRcGeY=
X-Google-Smtp-Source: AGHT+IHY+sR3hqvHzixueUV/xzvRoLNSdvOu4gH+4wPOyzOr3WI/+z5BqCSbhjpgmHsjUwLAoEuMMw==
X-Received: by 2002:a05:6a21:6d88:b0:215:df90:b298 with SMTP id adf61e73a8af0-225b9484b16mr22295796637.26.1751917833383;
        Mon, 07 Jul 2025 12:50:33 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a2c10sm9648931b3a.136.2025.07.07.12.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 12:50:32 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	will@willsroot.io,
	stephen@networkplumber.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch v2 net 0/2] netem: Fix skb duplication logic to prevent infinite loops
Date: Mon,  7 Jul 2025 12:50:13 -0700
Message-Id: <20250707195015.823492-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes the infinite loops due to skb duplication in netem.

This replaces the patches from William, with much less code and without
any workaround. More importantly, this does not break any use case at
all.

Note: This patch only aims to fix the infinite loops, nothing else. If
there is other issue with netem duplication, it needs to be addressed
separately.

---
v2: fixed a typo
    improved tdc selftest to check sent bytes

Cong Wang (2):
  netem: Fix skb duplication logic to prevent infinite loops
  selftests/tc-testing: Add a nested netem duplicate test

 include/net/sch_generic.h                     |  1 +
 net/sched/sch_netem.c                         |  7 +++---
 .../tc-testing/tc-tests/qdiscs/netem.json     | 25 +++++++++++++++++++
 3 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.34.1


