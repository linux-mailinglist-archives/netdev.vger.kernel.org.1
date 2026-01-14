Return-Path: <netdev+bounces-249876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EB8D200BE
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2896C300E049
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A7239E6CB;
	Wed, 14 Jan 2026 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="RlwPhsBx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A503A1D01
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406584; cv=none; b=NLTheF1Jzw7Kewrj2XL8JxeL7H3uRqgsCtRemuFCqb2RCvnahQ0FIvxU8/9ykXmpdPAAy1kToQHAhO+4Tvo3exO4cHpKsdjKpQpQLzKmrXdC/n879kn8sNUiYHaVSjb0gtShhudrS54QPOXlDaWuFMyhTFEiAEB88kYSiT60tC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406584; c=relaxed/simple;
	bh=sY9pL49eI+iAaNRXDJUpPj2uwc2IYCChq6PaL6YbgsY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iPTrgwNiekPMchGrHEW4JT+BfeR9xLxvwbqrLK8q9xhO5oOLcAWnJyyWifZPS0P6AXtqI08j+LFP7uHF3RU2up1mXXDHma8U4avhMI6ckABDHZOrsZ/zJkfuE8LJVGOJ3pwRSVb23J4OXP/nrD6aFzegcxfZ8zBvtvy46UAinBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=RlwPhsBx; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4f1aecac2c9so12955071cf.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 08:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768406579; x=1769011379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7A6mLt5TKWKJHAxjxXm3B7k58nEHjMbCeaedAX1PDt8=;
        b=RlwPhsBxCMhjhDh3C4/o6sLOD2LWiH66DToMgo/cnoIHUGoyo9ZmZv+kCwUhLROkWC
         42Ff5IKtCn5N2Ief3VUy3bhgqN2+jF9As+qhCq0ixmtY1qyGlBIlQzvzVaK/HK92hoYX
         pHvpQx+SUdDHXGrAGOq0ve1+WPFCw7TpI5NVlLrTcqA2YC03pFn2wfRz5MTOlNshp7WR
         +QutcMNvSieD2HsjALLEQkb4qfbVfVMWY+wf+MId9BM1je5aEXD1BEh1f3vRHgepcWH0
         QWqkazQFYdu379WbHbRhyK1uYmYNCDhsIpcLTbbQ9q/qLSgOFZF20bdyemLYMT509ycB
         M0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406579; x=1769011379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7A6mLt5TKWKJHAxjxXm3B7k58nEHjMbCeaedAX1PDt8=;
        b=lD/46O7c3NGamXyV3BPeIv7AzuZ0YVXTBtEX3ls4rqGLwkKh9mPGKKkM87njFNxZAL
         pLEmZVJwbpuIW8OIJyboTlXVEC1XRU50cMIBwlpLQjjkzoWgHOExsEKWi371nC3ZcCeq
         v+1fB2g9qc5dlsuxxoITCZdAvBnjuwe+UEsL0qfhZUfBkXpsfYAFtWIFu+WBIzGou30/
         bbIS5zFLfr88lYTJ9WZiEAjVr2CAddC1dhfWxQZAyVDo6I56qB2oSFe2VCNX8EfiGdYY
         wS6JSuK3xFc15sPFmKsdxbZTNbNaD16TmEs9alFCqoqOzx5id+Hkn1Z40t8ZGgBeVLts
         L4xg==
X-Gm-Message-State: AOJu0YwlVkoU9ZLCZ+dXEd6DWn7Rv0tKgEYYelBIpJ3ECz87ry9a9UDW
	tic+nwiNDg9Ul8at7B8CrRZp4zF7PZ+pdwfWcdFlhkG+b2S6HP/t1kFCuOznVt9fCQ==
X-Gm-Gg: AY/fxX75tNYVtDObDMaaQiHvybkmck0Yyu7u19ASvejuyAT/JHGYqEhmq/LRT0PDGMx
	whw988pfCkvzlX12qY+ZO6WHnfN9cpxN7Xy+r1TQcOUzSuxL0ENzZEQ4LBlkegOjBRlxn7TWm+A
	Pw0I2gFbYnfGvO6L98C0souOe1X6nqhWjcfhKDnt2SS4kLeVPSaWZoABtu/jKqyFRF8QBwPqRem
	yFkAy+AX59fSE/WZpvoYiIJNaiafxje/8UkySiihIZUw7yHT8JrPS6Sa5oHbMzvF7vZwdLwWIeA
	D5xbqnjV8UNmMbu9gqDHdw7Xm3RTTLMrwqhnXiRWW1Lu1b3IBOlENGZDB42VrZYu9uQ3/Dj/10/
	xZi6/2K1IeQew8S6A8KC3fUGPq9o/G/57tcHKBuaYNVURDV8aH0OQ3twVBZeyBrl3vJjR0xNfZI
	V8qZJJjwiIww5nFj0sKwNwDw==
X-Received: by 2002:a05:622a:7701:b0:501:46b7:401b with SMTP id d75a77b69052e-50146b741e9mr42719841cf.15.1768406579169;
        Wed, 14 Jan 2026 08:02:59 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148ecc0e4sm15543451cf.23.2026.01.14.08.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 08:02:58 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	km.kim1503@gmail.com,
	security@kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 0/3] net/sched: teql: Enforce hierarchy placement
Date: Wed, 14 Jan 2026 11:02:40 -0500
Message-Id: <20260114160243.913069-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GangMin Kim <km.kim1503@gmail.com> managed to create a UAF on qfq by inserting
teql as a child qdisc and exploiting a qlen sync issue.
teql is not intended to be used as a child qdisc. Lets enforce that rule in
patch #1. Although patch #1 fixes the issue, we prevent another potential qlen
exploit in qfq in patch #2 by enforcing the child's active status is not
determined by inspecting the qlen. In patch #3 we add a tdc test case.


Jamal Hadi Salim (2):
  net/sched: Enforce that teql can only be used as root qdisc
  net/sched: qfq: Use cl_is_active to determine whether  class is active
    in qfq_rm_from_ag

Victor Nogueira (1):
  selftests/tc-testing: Try to add teql as a child qdisc

 net/sched/sch_qfq.c                           |  2 +-
 net/sched/sch_teql.c                          |  5 ++++
 .../tc-testing/tc-tests/qdiscs/teql.json      | 25 +++++++++++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.34.1


