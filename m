Return-Path: <netdev+bounces-186157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A29A9D519
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A989C52F2
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABD422ACF7;
	Fri, 25 Apr 2025 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="gE+/8cCs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079E2227B81
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745618840; cv=none; b=BqIC3x5JPoT9IwvhxquSQmVwV5WIWrbLOfV2Nqaapg5zWUGUv9mBcPSelZnnGPlu4b+k1OxUX4codb76zpchq5kTEx/i5pS9wTHYodGgjzVXs61fGP3npVtWtLGAOrKb8qTuwq1ZkxGAhok/rrAqq/ILl2XLAWoUso9WKyL23dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745618840; c=relaxed/simple;
	bh=OFF9iiInhWuwUizQJ9O6lcqyhTMcozvMyG3KSVdTnO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+pmgJDPf6okl+7iE7p0bdx/K5J5lgh9BSXrgUqQMS4cFqr5VE8zIGUInvg9wCO7gBeIrs0vLzTQSo5OJ+aJG7IdE+T3ijESumiz+sU2qN9VZkDifE89D/47tMQb1vSXYxWEg/YBzl7U9AsnrFXiljIFzP0EFSTUD/FOJXZ0vlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=gE+/8cCs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22da3b26532so27125265ad.0
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 15:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1745618837; x=1746223637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nc+WOroywuFjmLewxdD8Mv7VBqmDvO1IBMU68v2QPww=;
        b=gE+/8cCsshG7S7504AATc25ZqB5dLmomS4c6zzdQ1hMKPVYPaFIJ7L5rNjolFDOim3
         kbsveHq36NtnixOEzGASndusCvfxICJ/1fBCBdkxrJ9HRVIIAUR8ZWf0HbD5wE/UkDwN
         +WkkbG2U5iPCH1vXYhG4kTmGLPirFA0coWqFVLRGsE5Z5kFtjfWFeTge1qwHtjZpJx4J
         F9LpFHbJG6BU+P9QL83c7SsQoFI2SZkzeSTCOvPFC9Fhy595gajNGeDAIZIyg9Y0rB/C
         AML4Vdxho2qb5V4AIZ0kI8QoXJT6qD2XOGXbPvvchxxsqLVa9JjcNXMPHaulP0SYuSG6
         9LUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745618837; x=1746223637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nc+WOroywuFjmLewxdD8Mv7VBqmDvO1IBMU68v2QPww=;
        b=orBlL/dtCCQzKbXwh1RZ7DwgkYSfDK9wUMlYSWK8kEhGF4s49DrC6CIzFxLdtJyj5q
         onDbqheDMGYQuzcjg5fxIpF1YrrY6w/0K/wCWhmqvXp5tlWdCOkTRElGu+QnSIxG2A/+
         aS3Vv6naoDM+U3lXE5szLFfEfOcWya6j7fW6d0cof1kTpj+jXwsXgnnTKUuQDJb1g6My
         xaDcEgqpGYdJ2CAmMldNTHCQ0jw/RKH32aLqdsDIIF+bs5zSHoSwrXcex0puN0gDXwKI
         NkeB1JqSdP0bRasfAXuAXqeSlM+2JcgALuFYDlMBhJgLkIm7JLzsWqRo8P8zGx7C10vm
         jbkQ==
X-Gm-Message-State: AOJu0YyRO4S92fof+RfrKkGNf+hZvAsLGgGqP8XdBhQQyPhcEj+734Ax
	Z5CuBpxK95hHD3s1brCY/QzpeDPRFpNEk0/WMJRo2o1AJRjVJAJOam6uvr9S4wGueb/eFJut0JE
	=
X-Gm-Gg: ASbGnct6Ehw+aa/PhTWWlaMYVxbH+KGcVrJCb+Xfb/NO1fnAX+dmcA22kvbZJNtWa3o
	hKHWxuMKJpGOdQf5BGtR+zVS2EPVis8P8f2S8dXTdxIy8OkxlY7C2r4nsWqC4OW+KHLg4N67kxa
	C5h1bXIm7XfJziaClVHWg1VDEm0A8LRBBxoiC1hRbQeAZnXRUdk4fidEuaacWtRuDuhRAY3ZP4y
	lQWUpQhl71ehODqW8a4JVXXu9cxp4jQFhl35HfCBNG9F4S5ssIAgKXzFqEDBNdYVRJWF+Cl8jps
	5VC5oV6JTqTMsp0anhgpmKZthWKB0wu3LLBgCIj0JOGYA7AM6AAbEqazcUV9MPm0
X-Google-Smtp-Source: AGHT+IHIw7hJLf0Cm34UyaWAuxaGDut6XeyFSYH6g0JJq4xAsZ5CjmeHo8dJlxmZ3/4UHCKKneFUcg==
X-Received: by 2002:a17:902:f550:b0:220:c813:dfce with SMTP id d9443c01a7336-22dbf62c3b6mr60649905ad.39.1745618836981;
        Fri, 25 Apr 2025 15:07:16 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c0:73b:9a6c:c614:cc79:b1ba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dc3b7bsm37753185ad.100.2025.04.25.15.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 15:07:16 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	gerrard.tai@starlabs.sg,
	pctammela@mojatatu.com,
	stephen@networkplumber.org
Subject: [PATCH net v3 0/5] net_sched: Adapt qdiscs for reentrant enqueue cases
Date: Fri, 25 Apr 2025 19:07:04 -0300
Message-ID: <20250425220710.3964791-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in Gerrard's report [1], there are cases where netem can
make the qdisc enqueue callback reentrant. Some qdiscs (drr, hfsc, ets,
qfq) break whenever the enqueue callback has reentrant behaviour.
This series addresses these issues by adding extra checks that cater for
these reentrant corner cases. This series has passed all relevant test
cases in the TDC suite.

[1] https://lore.kernel.org/netdev/CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com/

v2 -> v3:
- Rename cl_is_initialised to cl_is_active in drr, ets, and qfq
  (suggested by Jakub)
- Remove redundant check for qlen being zero before adding to active
  list in drr, ets, and qfq (suggested by Jakub)
- Add new test case where we have netem under a nested DRR child
  (suggested by Jakub)

v1 -> v2:
- Removed RFC tag
- Added Jamal's Acked-by
- Added TDC tests
- Small cleanups

Victor Nogueira (5):
  net_sched: drr: Fix double list add in class with netem as child qdisc
  net_sched: hfsc: Fix a UAF vulnerability in class with netem as child
    qdisc
  net_sched: ets: Fix double list add in class with netem as child qdisc
  net_sched: qfq: Fix double list add in class with netem as child qdisc
  selftests: tc-testing: Add TDC tests that exercise reentrant enqueue
    behaviour

 net/sched/sch_drr.c                           |   7 +-
 net/sched/sch_ets.c                           |   7 +-
 net/sched/sch_hfsc.c                          |   2 +-
 net/sched/sch_qfq.c                           |   8 +
 .../tc-testing/tc-tests/infra/qdiscs.json     | 148 ++++++++++++++++++
 5 files changed, 169 insertions(+), 3 deletions(-)

-- 
2.34.1


