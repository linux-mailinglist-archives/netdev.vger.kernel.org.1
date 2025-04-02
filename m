Return-Path: <netdev+bounces-178845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53904A79338
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4AF93B7C0E
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851281957E4;
	Wed,  2 Apr 2025 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lX+/e6Fl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01B2192D97
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743611283; cv=none; b=omynIW2RtB/qQ1G63Yepv7J2f+YgBGaLFDXY2Jh6f0dmqxa6NAFKYwPa+Q4mC4TbDrvKk6tOyoaGvxAPMz4q47GSrPECmdl/wH1vcxwhFWNBh7V/QbkW5NPEBGX6w83zEUzflpeeVkmFNAC9wF8z5tUolDa+N6zJsnH0HjFcLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743611283; c=relaxed/simple;
	bh=NabCfKEk+jDtCUqo51dY+Fm7DrJgCp/z6lc/7I1imf8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=f0Wx3SibAps+p+0JowFXFIXoxepNUEi8k7KGwR4aGrUDe7aJT+y5BFnTGorNl/cgWqBhmrzPgS9ED1riQidrqnY6DkBCCrssMwFnjv8h/pAO4lW1DGRqDEGnkeAP3vNHjSoyxfBppYf+xnYXzcXwscU07mEJ8QLz+Nfo42+GeNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lX+/e6Fl; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2254bdd4982so539465ad.1
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743611281; x=1744216081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vmK0n2b7Tm5fxdi1s6oVPnEt2drqi+8AVF7hNrZG3UU=;
        b=lX+/e6FlanyoaThYUp+LqhtTIlyL723eCRFZ8utRLZBQF21oFhOML/y+IsKhi9LX7W
         Woa9FE/K2+fh+lyEVpdjUtw05VWcDM+YmPaIW3EY5ZXyGg9ck6RFekeCB31p7IqQ5RZh
         Qk9GN8nobTvmJWF0/0yTxIzAtLWcZy8crTp1Tr2MlH0RxuaBa/KpKZeukkCvJvvWTNt+
         PlUzavB2jtrp/73qWYjelfkO4tH2hXbOgzNzKCdgHroXCLM8O324Aw9qcW9eTqUSamEu
         QwxA1N9utFPqPJWztvYUJx56FCoUWkAZR2YBoThV+m/M9gS7qsCFmvGrQGtns2Si/iiz
         Qntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743611281; x=1744216081;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vmK0n2b7Tm5fxdi1s6oVPnEt2drqi+8AVF7hNrZG3UU=;
        b=CGbnE4Fb7vLf78eZf5Slx58rQyX9y9gc62Mc1F8hEpF44kA6HvZ/XFkAkm3XvEguEV
         Hjy8XCThEAmCNzLaunQ8pu0CuJcgvYt+TLZycaZHSroEe65CCkFilZ6ckYp9higrSpk8
         z75+DC1r4XrkygKk6sGbevLZj/sZFvkuOKjxTjddZGTyRxCqGHIE+RfjQLM40XTLbsq4
         w5Z3CPNcgU1ny9zjK/LAejAbCNta9d1PWT6G2EpJdd5XGiIP4nfMxhLNQxeo4eMojfB7
         tPmg1ALYEV+eA/YafGE06zWGpqMGHA1N47v+qCTBVPYP08Ux12weTIAC8GnxVuJCv/QA
         DztA==
X-Forwarded-Encrypted: i=1; AJvYcCXFTme48YIR/ckNK4VSN/LPB/EXyLOHuE4oEPIUC8tj9YvQ/3C6nNt+L8q+qEIb6np/T0LVYOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTnT7AfGIhZKwgeY7cN7r9aPA6QT771vMIQWtC9hcwFHpETgNG
	hIzlF52GwVplYHX132tWAPH1+NBbH1uHPruocs24vq2+P0h0E376AKrEIp/+utJuIOHJV3oFvw=
	=
X-Google-Smtp-Source: AGHT+IHLvt7nxcJ4ahi2vlxqr61OfzG5gLVSEtv7MZd6BSH4snd0Cp+zSqgbzYNXIqWeP7SBw9Kg/GimCQ==
X-Received: from pfgs27.prod.google.com ([2002:a05:6a00:179b:b0:736:39fa:2251])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce0d:b0:21f:52e:939e
 with SMTP id d9443c01a7336-2296c688433mr48505845ad.28.1743611281096; Wed, 02
 Apr 2025 09:28:01 -0700 (PDT)
Date: Wed,  2 Apr 2025 09:27:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250402162750.1671155-1-tavip@google.com>
Subject: [PATCH net v2 0/3] net_sched: sch_sfq: reject a derived limit of 1
From: Octavian Purdila <tavip@google.com>
To: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

Because sfq parameters can influence each other there can be
situations where although the user sets a limit of 2 it can be lowered
to 1:

$ tc qdisc add dev dummy0 handle 1: root sfq limit 2 flows 1 depth 1
$ tc qdisc show dev dummy0
qdisc sfq 1: dev dummy0 root refcnt 2 limit 1p quantum 1514b depth 1 divisor 1024

$ tc qdisc add dev dummy0 handle 1: root sfq limit 2 flows 10 depth 1 divisor 1
$ tc qdisc show dev dummy0
qdisc sfq 2: root refcnt 2 limit 1p quantum 1514b depth 1 divisor 1

As a limit of 1 is invalid, this patch series moves the limit
validation to after all configuration changes have been done. To do
so, the configuration is done in a temporary work area then applied to
the internal state.

The patch series also adds new test cases.

Changes in v2:
 - remove tmp struct and directly use local variables

v1: https://lore.kernel.org/all/20250328201634.3876474-1-tavip@google.com/


Octavian Purdila (3):
  net_sched: sch_sfq: use a temporary work area for validating
    configuration
  net_sched: sch_sfq: move the limit validation
  selftests/tc-testing: sfq: check that a derived limit of 1 is rejected

 net/sched/sch_sfq.c                           | 68 ++++++++++++++-----
 .../tc-testing/tc-tests/qdiscs/sfq.json       | 36 ++++++++++
 2 files changed, 88 insertions(+), 16 deletions(-)

-- 
2.49.0.472.ge94155a9ec-goog


