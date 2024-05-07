Return-Path: <netdev+bounces-94185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E27F8BE93B
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03EE1C23F5A
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6386B16F84A;
	Tue,  7 May 2024 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="e2q4jLfj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB24E16F834
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099552; cv=none; b=Fe4ZKsWussnGwf7k8r5ScDRIVUt9Fh5Kzm/jr2fh0ho2zwA7Yo0l2dKad+dEbVPy+rKfpSgy25Kbhi1VVmwi1fk+KCSXzJ/vYwObSkJT5jWOMwWpEhxQ+CCFC956URp+mOPWRmZ3kV4EKPYTeBLggb2asdDuQdRaRvs8TvYkDjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099552; c=relaxed/simple;
	bh=1+50RQ+u2CAmQ6ZKodbn3h5kYxQZjHl5oHtWRxHholw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R0ZtikJp41JYCt7C2WFUiu07Vk594jcVFFU5H/gNdpeYoper9JMDv7Meb+wgyuXwRbbK24tBxuPErNHQYZpa2Yo6zqCfLTc3I1WaG9HY+kG5eR7C0fvpabN/Eyptna9CxAPP4LhGdmjiLu4wEaB8uUuo+4I5egYXab1NU66e82g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=e2q4jLfj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so1903418a12.3
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 09:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1715099550; x=1715704350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KRpJAxDfYqdiM47EZ2U9ucZI8JIKy/CacIvbwM1R17o=;
        b=e2q4jLfjKgwhrDGg85SmtcQc6S8VqVYShgQI12fyoSSTLSMdCLuU8sApl6ty0BVmx6
         TheJVwrwnfEx05QkFjCXEwThdVHXoBi1xs4edl3uOo46bj65S7RHEq/xn/cMMgbpMMtq
         5vddMI0nStvZHtk8ROIexbtRNccN+/xt2iMmrXeqRih2+keFbqmf+WzgGfc0L5jap0FV
         y0hgiIiZgFLXp1qpYfn1r0PqnIn26AFBHD568MZMBHVhVcgmMUCIwv+S+7t2p5Gxo+ts
         jEuFPmdNCUt3EB+KhNk65pGkczWqjeCPUDvyKFS2J1nJacompYhoGJ5dRLw19RIg0G6R
         k9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099550; x=1715704350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRpJAxDfYqdiM47EZ2U9ucZI8JIKy/CacIvbwM1R17o=;
        b=JIcHib9mUn8NyF+93kib7UuH4b9glg6k7zgvKhbhigHWwG0cKQfnaO0tYST9gWXsSE
         ljLprOf7uV4wKqJXz+yveEAwJt4Zh0WOOhKD9Ela4vmpl1lw+1P8mfEeLAH2BSlo4T48
         IOyk7HJQI2VcfBwZxE6qkQWJ5nnPtohaKODj1j+sxnuPrQXD55j15yPYH5qdQmoE3Io1
         Gc1RFx7eb6Loql6364vHH8UTKJSDto9eCFOtudsJ3UGk91b3P26iuhZQPj3uLwKhxqfx
         jPd/G+PdU4Hvz3FGEy6aUPXRdxCBpayiDEFg6Pcyngx1WY4bUX3bL+Bpi54GLX/eLG73
         LqxA==
X-Gm-Message-State: AOJu0YypdXohPTClnSdpOWs8N3QvzvX/n5gKkaqjwKFjFTbG65GwfCTM
	L9UPjZBoMlZN+Tj477SEvpXlOUHuvh5la+bJHAs4EQGmEQaPMOUuDH7DseI9lKDXnh4RocNSGux
	V
X-Google-Smtp-Source: AGHT+IEzXdKPHO1QvO1ESEOY9m4fNbaNHy90A9zIumEh22YoY0lwIi/iXQ0S4sqFFz/i+xtjT3ne3w==
X-Received: by 2002:a17:90a:c02:b0:2b2:b00b:a341 with SMTP id 98e67ed59e1d1-2b61649c917mr99693a91.8.1715099549839;
        Tue, 07 May 2024 09:32:29 -0700 (PDT)
Received: from localhost (fwdproxy-prn-021.fbsv.net. [2a03:2880:ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id gq13-20020a17090b104d00b002ad059491f6sm10005292pjb.5.2024.05.07.09.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:32:29 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v5 0/2] netdevsim: add NAPI support
Date: Tue,  7 May 2024 09:32:26 -0700
Message-ID: <20240507163228.2066817-1-dw@davidwei.uk>
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
Changes since v4:
* Rebase

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


