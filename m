Return-Path: <netdev+bounces-90753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7A08AFE89
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 04:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A83C282152
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 02:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F43E54F8D;
	Wed, 24 Apr 2024 02:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="B8bo31gk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E33143C56
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 02:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926200; cv=none; b=tcIkGYIVJF1aU83bNlqp0rH+Dy+LoV7jayjaqfa74w7ys6ruqZx2/RsE152Uw/kkn2hrLe0kwpsPXsLSP/vA84KZw8Zk8hu8y95g7zWyeJ77pYMElKxvwAT0kbJW35uxuvwc1uNtTUqat3eoBetQu0kge0QlqhZ0mgHwgSUT62w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926200; c=relaxed/simple;
	bh=KUp/04RpW3KKxiwqMv8LaxLK0bhUX5nbJt3oCrrA1k0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rzM88pPEEJBBOBc6IKpNyPi/m7bj1yAWCkQabXn+JCttk9I5HQ7Vnvd0aJAM2oJbJm1QA86E7osg2qAcn7nq8FjqtdM+FfhcjUlXWwtEkHy4gocPjR/op7jloWcTji3OatFioZc+XUTNChfzY10l2NtQ5TyZpkwnWlcO0wZvFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=B8bo31gk; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbbc6e51d0so3228190b6e.3
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 19:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1713926197; x=1714530997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+EMNAplyPqNbVNFmx2hZseM/BBWGxofk66ga5pEmbmY=;
        b=B8bo31gkvMfhvB7VHTuAqSi43XaaTHbjqPTVbbLTRhEG5PnI9c5MFbKgOUGCLMiC86
         QWm7IYXXVS2m/wT24SQReiirrewiuW+TiVLcBr6WHVQyOoI6chCqNmubIIXRWtf/sV9f
         kNu1pFcv53pybtRdME2qt0mjuTjiC5+tUU4i67b2Xhw9ATovHCa2uS6HSEgpqa623dxh
         WpyQyVq3vAPu5v/lcG1pU2CgTh24bcXBQ65tOANay0kKCynKgncrodGiJJx2G/NnzrsX
         X/yCO1xWizTDLGE7AkjBn6mR2jgsXu41OeW4VycFjanSws8xNYR5MerrYzsBu9tAC9bK
         4Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713926197; x=1714530997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+EMNAplyPqNbVNFmx2hZseM/BBWGxofk66ga5pEmbmY=;
        b=Y/63akO1Dc+rEZjCtlLmU1HPZ8o14Kgaq0fu7aBy2SL0Mv0X2KqVmaxBZIVl/YGPHW
         bSL8EG1fxRgX3QndGlOMGhEvLywQARx5F4KeCkOSGL6rQ8pv2caVIUZMiLemPhIdC4Mw
         c9rwBy/qVc0bhh7yhVXJjVxsz8shTGL+cCLNDShGHd+LY0zZCAzdRnpzi2ZkDBBhDy/e
         0bH21qdtRxWJwkOHdb5dibhUWDvD8DK3Do34MOR52pgV4ZV0girpqkGe0/sNkr/tFxcd
         SZsryr9A2oByqjiJAMqu7qCDhvneSPLcIHDo6a6hIOFeWDs+1qEZ2Z9h5zpTdZqQLyuI
         YnRg==
X-Gm-Message-State: AOJu0YzFulBDAL9ZDl8stS5KgPGVchJdEgo1ZdkKL1/UBFZrlxHlSt+c
	xUPX946wjoT1af06AiAFUjq7OJ9rRhU7ibq/891z8NArMs51e8VpA7yfjR6o4JKitnLdXCGkNK7
	8
X-Google-Smtp-Source: AGHT+IEAAKMxWkBX0tl+ACmY7szmxRW1dMjcKB1lS81jfqSWrat89l8fCLR3k2XjMPe3xugSTlx2VQ==
X-Received: by 2002:a54:481a:0:b0:3c6:4c9:9888 with SMTP id j26-20020a54481a000000b003c604c99888mr1097088oij.17.1713926197409;
        Tue, 23 Apr 2024 19:36:37 -0700 (PDT)
Received: from localhost (fwdproxy-prn-111.fbsv.net. [2a03:2880:ff:6f::face:b00c])
        by smtp.gmail.com with ESMTPSA id z23-20020a656657000000b005f8072699e1sm6545162pgv.45.2024.04.23.19.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 19:36:37 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 0/2] netdevsim: add NAPI support
Date: Tue, 23 Apr 2024 19:36:22 -0700
Message-ID: <20240424023624.2320033-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NAPI support to netdevsim and register its Rx queues with NAPI
instances. Then add a selftest using the new netdev Python selftest
infra to exercise the existing Netdev Netlink API, specifically the
queue-get API.

This expands test coverage and further fleshes out netdevsim as a test
device. It's still my goal to make it useful for testing things like
flow steering and ZC Rx.

-----
Changes since v2:
* Fix null-ptr-deref on cleanup path if netdevsim is init as VF
* Handle selftest failure if real netdev fails to change queues
* Selftest addremove_queue test case:
  * Skip if queues == 1
  * Changes either combined or rx queue depending on how the netdev is
    configured

Changes since v1:
* Use sk_buff_head instead of a list for per-rq skb queue
* Drop napi_schedule() if skb queue is not empty in napi poll
* Remove netif_carrier_on() in open()
* Remove unused page pool ptr in struct netdevsim
* Up the netdev in NetDrvEnv automatically
* Pass Netdev Netlink as a param instead of using globals
* Remove unused Python imports in selftest

David Wei (2):
  netdevsim: add NAPI support
  net: selftest: add test for netdev netlink queue-get API

 drivers/net/netdevsim/netdev.c                | 209 +++++++++++++++++-
 drivers/net/netdevsim/netdevsim.h             |   8 +-
 tools/testing/selftests/drivers/net/Makefile  |   1 +
 .../selftests/drivers/net/lib/py/env.py       |   6 +-
 tools/testing/selftests/drivers/net/queues.py |  60 +++++
 tools/testing/selftests/net/lib/py/nsim.py    |   4 +-
 6 files changed, 272 insertions(+), 16 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/queues.py

-- 
2.43.0


