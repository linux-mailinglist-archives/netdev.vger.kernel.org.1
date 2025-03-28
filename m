Return-Path: <netdev+bounces-178162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0FAA75158
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 21:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A2727A2495
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 20:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0819199223;
	Fri, 28 Mar 2025 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Zvu01vF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373B01537A7
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743192999; cv=none; b=s3H9GHmMIBLe00LGYa+oyA+M1miEGFzvi4Z6gCdeQBQPndAAvIa+WBOUWqISgOkQtqGwQDMGFNJY4y8QkcPgHeG8BA43nrhdRzrhJvf+s7CS4Jp5f9voa+GBTHjW0MVN+9VCGUnWYv80zc0uDcJcAjAkoOWY1Y9/TQ2iYUWXHWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743192999; c=relaxed/simple;
	bh=t7ZbHG/Uk33WAs7z8cJr4Zvm9GEwxOXRANCC0ys50aU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Xf0lNpTYz+R2CdKzx2ESUkZigK1J225fThZ4eKTtD7172lpvaWZdQs0VTu+AbAIuGPMhemnD44o9ipvS7EnSY97+8bhHW2IARN4QIsITGjBgm4jpeNHmKlH34cxA7g/U0O1mrlMF/eNdaCTDQazlKyPv9SHu59zUzIgoNwULpw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Zvu01vF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff64898e2aso5816988a91.1
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 13:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743192997; x=1743797797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fnM+I6bdfyN3hHY8mcasSfE+0NjsyOw3CRgHELMCjE8=;
        b=3Zvu01vFGtyKycNpC4RwjReRH2XgstOBAQtW93NeoOb+Wwa9rPMCUOKbjao1UfckRe
         xTwJmfxH8RRj4QwGusCaBMz0GJBdHhIvSsF5cpCuCQKXQE5T0iwwAL9UGFkrNISvqzRg
         Ff4VQ7KKqJxrv0LlmxgFxxgJEZzZnXvC4meC90HxjBGycRNSIESg20wVBQu4DaNBNdBz
         meWSNLo5MkuO7oVSin86z7InRDkUs2pdlf6DXoNbcJBs0S33JifoUh7fSnA7AgnNWmpc
         YIQxPQYmFDDtQRjARx1x0Kb9+2ZT0uu/8CKCzo2+PJM9wMnKPnUwRHnP//lY6Scisil1
         QYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743192997; x=1743797797;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fnM+I6bdfyN3hHY8mcasSfE+0NjsyOw3CRgHELMCjE8=;
        b=l6ah5A4bz6VcB2WSTVHhiNGj6hG3sCP+RL6CSqxPim3l4Vy2MjSzFEabIBvwSJTG10
         YX2M+vE5PrgR3mM1QtY04I1OZW88vpqPip0U/VwYQwZOjB2UQrFbRQ/SplPXUiVBvEl6
         6uk/sU9cLutKDXrmqtKTLKeM/w00+hDOBe1qHvq74P0N4vMunZZRxu1iLTfb8CBbydZn
         84WI+HYkJuSnsc9yRY4AFKBpUPLKr7OVB9X2VkzzPp1u/V7cXoPcXwH/eYL7XYc9+m6U
         +a2xpo/mTrCr3SsBxu/tLqBQLUqEyCTxQdavmGnRtx9Lz/cQCSl3ZWI0f+bLxKEPdzh7
         maBA==
X-Forwarded-Encrypted: i=1; AJvYcCU52niiueaMWk31IrMc2El0QoTIHO98LEsJ5s7ceUBLXlvaBSXFj5gtW4P3cKp4QnYiiqDYmIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwanJd4bXsuj1/c1L+mlItAof4adHOzLdyRi3kfxAlcKxYRIg3k
	K7Jrn/i/DScSF4ntfDlL55r+0dsurhoLPDt6NWFBNAi1HmCiJSrFUQ/lu5v5ukjb7ouj0fLO1A=
	=
X-Google-Smtp-Source: AGHT+IGjpJG6jDdI38F6Z17ArQ28WQv2+NXaq9LO0xuUiNpqQtBGHhT8WFPTSMcbk0nrIZiSH2MFiXkC/Q==
X-Received: from pjbse5.prod.google.com ([2002:a17:90b:5185:b0:2f5:63a:4513])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c887:b0:2fc:aaf:74d3
 with SMTP id 98e67ed59e1d1-3051c85e2a7mr6572128a91.4.1743192997413; Fri, 28
 Mar 2025 13:16:37 -0700 (PDT)
Date: Fri, 28 Mar 2025 13:16:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328201634.3876474-1-tavip@google.com>
Subject: [PATCH net 0/3] net_sched: sch_sfq: reject a derived limit of 1
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

Octavian Purdila (3):
  net_sched: sch_sfq: use a temporary work area for validating
    configuration
  net_sched: sch_sfq: move the limit validation
  selftests/tc-testing: sfq: check that a derived limit of 1 is rejected

 net/sched/sch_sfq.c                           | 70 ++++++++++++++-----
 .../tc-testing/tc-tests/qdiscs/sfq.json       | 36 ++++++++++
 2 files changed, 90 insertions(+), 16 deletions(-)

-- 
2.49.0.472.ge94155a9ec-goog


