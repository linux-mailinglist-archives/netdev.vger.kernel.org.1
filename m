Return-Path: <netdev+bounces-182531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B07A8904A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83AB51896268
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C1E383;
	Tue, 15 Apr 2025 00:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="cOVSaD/p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A723380
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 00:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744675405; cv=none; b=HxSyhFQQvqvCed+iW2bE/BV2da46WI8WzL7IVjwxAQzYNsskm9cWhd41XqUZfuLJ5jjiRvRFlLkZruJxhj4ESk0MZOi0S0CuJ3soCpHDe9SFBmw+QbpwsVCFt0hJPyy2nmBOoDGgfv2TV2G4RN7a+Sp2reOdprpJcFgR9ZA8fgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744675405; c=relaxed/simple;
	bh=c97wLyQBDP0lGs+3vPSCmLZvPomiXSOkXh92WiKpsHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJXVAnadEy+t4p/fH3SoExrca/Y6McLRjVbUrfDy5JvHscOU0RtNsMcgqJ3fTgSZc/ZjvbNtjDyEy8hcZ/mYAOA72EDuHO6986sZKDUrJuIEaPCnoRHUYmszVgCrDyWUXWFIXc507JdLVF3G9iIJ7fXTGCDailLtHMo10GV5Lvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=cOVSaD/p; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2295d78b433so51317255ad.2
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 17:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744675403; x=1745280203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S3Sbjqj7/E9GOnSGuJSTWsxD50kObrJVQlheSNF/rKA=;
        b=cOVSaD/p5mBnKjQ+tfInsm1dF8KbNUU8N98tyGjpOmKmZUEooljI5+Cp58i761ShIS
         sobxYAF9t5R3DpADu1qn1Im9yad3IfWolCFZkfAI+7VQIozZT4bkEzcjqfkGqrQb+Dih
         vBvUudqEG16Mbmm1dRq2e1Rkn/Q5Mztm9x3i/8jUB7b3khF9a0cUmxPPDmJb8DWo7GNI
         y2EK7un/Fp4dleRZde/OhUMyszgbUNSN38SmZo0xMTHAeZNejH+hgq2fANnig/pos3Jh
         f/Ia2o5QP/dAtbnoEKe5TRfGjMO6kvNzG60+yeaQmXW5SHgIeZtRCtHnkTDhW0VVQbae
         dVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744675403; x=1745280203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3Sbjqj7/E9GOnSGuJSTWsxD50kObrJVQlheSNF/rKA=;
        b=S3eIBQgEgJyQnaproXwc717gGwOfJFqO29fND8d0fCo75SNLSbsYbzgHcNq7q08T4u
         UBHM+2v5dz8MraNWQfQZR5Lw3flHgJtKEN5IAwvpDVE2EsoZQqTevLu7z048q44S3rwj
         zi8XKaq98yTS08EKOottNaVp20twWGo6ofIUJAcvPnb+d/RRcNCKhk3NNjfci7WfnjyY
         fvOFkiTer2J8XqNUGBMT91JEHeAPUdihs/EgHmkOhgt8XYqIvQQc1/WKmQBf840KXeyU
         iRBp7dIwLUkNBoy9aSEUjfj0x9jJcUGN6cWsx/Ar6qnFlq2ksGvalj+RwpaWNtawc2Iy
         ozcw==
X-Gm-Message-State: AOJu0YzIAs3V5rhqJQQEwY98Yk9V3pXL/0pBNwT+N99klBIEuRamD0Z5
	KvK/1Z24V308DcVZ/iYQaTwJC4CnpIDPwcMQOVLzqpA4wNkNXJVQJTDZMwyFEnoqmizVjVXXFxk
	=
X-Gm-Gg: ASbGncu+Hol6CuL1SwAcoc09YHsSKQWmVFlglPGgmg1a5PJdvYuXN7i+7KjSik1q6DA
	wIcJndUJBgElu2YQdHOdf1YIJkHbl23QyUdXTIAGCwnBWflJrcNGhsf3tT8oDp3PRrU2rEeJ4Ed
	0bGJYnOft8K4m6RnxSrZ+cBfwm1pswfS5azN3JkfzskgTQj+RVDuYhRcWmVtMyFq1GEF2t3iTt/
	xkpviolprdTQIMiB3ZvAapNkgy/udOIljesInj1eamx6z0k27Ht104y9u8kn1Dae5+FopwiIouO
	UlL6jqIySrgvfi5LeGtNvDVD+zQNVJ8L2a+C7uZDHHqD8rAFlwwAj4O0cOGKX/EvGBEY6iwi5Mk
	=
X-Google-Smtp-Source: AGHT+IHXZLe31zvxxR2xM8vxvI95kbefw+hJhdt2qizQunqAh9ENG2XupSiNydb9drNR6bXtf/HM/g==
X-Received: by 2002:a17:902:fc45:b0:216:6901:d588 with SMTP id d9443c01a7336-22bea4b32famr214992495ad.15.1744675403133;
        Mon, 14 Apr 2025 17:03:23 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c4db9sm7445615b3a.58.2025.04.14.17.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 17:03:22 -0700 (PDT)
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
	pctammela@mojatatu.com
Subject: [RFC PATCH net 0/4] net_sched: Adapt qdiscs for reentrant enqueue cases
Date: Mon, 14 Apr 2025 21:03:12 -0300
Message-ID: <20250415000316.3122018-1-victor@mojatatu.com>
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
This RFC addresses these issues by adding extra checks that cater for
these reentrant corner cases.

[1] https://lore.kernel.org/netdev/CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com/

Victor Nogueira (4):
  net_sched: drr: Fix double list add in class with netem as child qdisc
  net_sched: hfsc: Fix a UAF vulnerability in class with netem as child
    qdisc
  net_sched: ets: Fix double list add in class with netem as child qdisc
  net_sched: qfq: Fix double list add in class with netem as child qdisc

 net/sched/sch_drr.c  | 11 ++++++++---
 net/sched/sch_ets.c  | 11 ++++++++---
 net/sched/sch_hfsc.c |  2 +-
 net/sched/sch_qfq.c  | 17 ++++++++++++-----
 4 files changed, 29 insertions(+), 12 deletions(-)

-- 
2.34.1


