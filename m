Return-Path: <netdev+bounces-93070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 468818B9EBE
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 18:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB17C1F211FA
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 16:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51E61553BB;
	Thu,  2 May 2024 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="xzX3W43N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500E6155350
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667972; cv=none; b=akPuPfD5l2ji1Kga9u7T6YrWudQ7wjcZjNzC4fNdKF+VVSF6W5XZpoT0ODx5KzI8qv54U28YZGctyFNfKLu6HSaL8ZVE00VdLtEivjb7y6GJx5joIxI4tCT+OeGYcirk1zow/srfy3TgUPxGnBEe9OduT2fA2cHDep49cVCpekM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667972; c=relaxed/simple;
	bh=pR7WsnzDg71F3Zs0q90Zp62i3Sd4FEuNUWnOYoyNf4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jGBqVU60OYnBueRSiIHhOjQpSq1pu1ejfwLgBJeqQM6U5/yNA2wv23JbuypQzAktPgzot0uExDA6w0JfeJVs98zue0P7Yu+fJcARJ9bLA773NeAtgFiLmf4ERvPp8SybABjU70YzHP8mpQeeO66xSEYIjwSRyjdh2e1K0nYH9HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=xzX3W43N; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ed012c1afbso5718085ad.1
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 09:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714667970; x=1715272770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vGLGSwlYxcIytvrBd2+Ct7LXknMg54Rj99aq70yn6Lo=;
        b=xzX3W43NqcWkVKWsx00epmAQEWCQYzdQwNAGgHGDJxsxfBuLQ19sgjkczC2Agne2xx
         xAFY1vckX65/bP2+W0c+TwBYHxSwdCC+qKLPpO81CNGT9tCOF2K+4JdZSXce9UV9obkq
         Ay3+U09lHntSVqPNJPL+2cxHIUXM8u0vXRUrUKPZ62RR4OM5KHyq+OZ7dPgMRfij4Yw9
         vgJuJuMM3esTMAy999AW48D7+dWazbsF7+FJd5S79Sjc54x0rgLWtAJwvXW00a7SwWLk
         Z27aDY8/hLen/wLTHNKwLy/OBeYYJIzSkmVA2w7r3HDdAqCpVgDHsYBn8TV/OBu3h5Vf
         dEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714667970; x=1715272770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vGLGSwlYxcIytvrBd2+Ct7LXknMg54Rj99aq70yn6Lo=;
        b=AnHSWglH8tM9Ag6abwbBxfwIM+HG3jX5RH3TQb88RDJLNIfF+rY7ciyPL8/rdqgoO3
         BR2f4kfFq+ggqodH7Bsdx27jTBALOOd11eFfQ0dAScUJj1kngl5yRvlhCPmhSu7K5H7z
         uIUZhvAF82hvoQ12tI7eb/kw5ajDh7Fab8p2Ma3QG1oDQTgkZMKbLtvFasEOW9OdlILj
         +KLAMpAuOq3TZlXcEWsvC2U5kM1wOpwCX8bQNS2IkR3z2LiNlkxFCoc3/UT8lpdiOvl1
         FxAswxeON8FrXblHR5vx6TT5lpZJe0VYkSrejIib/YNcBfjZwt3rH4as3arVMn/RFoT5
         +6vQ==
X-Gm-Message-State: AOJu0YzzZkG8V07nkBIHD8d+DxolppWorSBSUUwG2X/nCgjNiVX52Xsm
	/XCSOGAqnEf3RxlYjRN3ZBqvBUMAX0865QbEctRuiAlccOI2JZ6mlS8lfv7tnCArLk3Q7+U4ILk
	U
X-Google-Smtp-Source: AGHT+IG6rEXqOb/tlvZZxCTBRG8eNO/EHeLQXFyU2G7sHlV+UeXYtFdx62/ZGA6cJmYcjZV2qKFFlg==
X-Received: by 2002:a17:902:6546:b0:1ea:691b:3692 with SMTP id d6-20020a170902654600b001ea691b3692mr4345887pln.17.1714667970274;
        Thu, 02 May 2024 09:39:30 -0700 (PDT)
Received: from localhost (fwdproxy-prn-007.fbsv.net. [2a03:2880:ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b001e0bae4490fsm1519321plc.154.2024.05.02.09.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 09:39:29 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4 0/2] netdevsim: add NAPI support
Date: Thu,  2 May 2024 09:39:26 -0700
Message-ID: <20240502163928.2478033-1-dw@davidwei.uk>
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
Changes since v3:
* Add missing ksft_exit() at end of test
* Check for queue-api at start of test and skip early
* Don't swallow exceptions and convert to skip

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
 tools/testing/selftests/drivers/net/queues.py |  66 ++++++
 tools/testing/selftests/net/lib/py/nsim.py    |   4 +-
 tools/testing/selftests/net/lib/py/utils.py   |   8 +-
 7 files changed, 282 insertions(+), 20 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/queues.py

-- 
2.43.0


