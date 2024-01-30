Return-Path: <netdev+bounces-67349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CA8842EC3
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 22:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260701C22538
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 21:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A4378B55;
	Tue, 30 Jan 2024 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="CbMuDcqJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4BA78B4C
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651184; cv=none; b=mD6COv3HWFBk1satt/vOs7bq9gI1eMc1qNX22DWtH5oSKlUps5x/ac2YcBuzlZ04pXGitIAHSw48V02NnFMPzUY+MNPEaN37KCi6Yy5Z6kmTUJJIeIeGg8o2t890FKG+SC2VEXm4klhB6VyM7LRB9yfjDz/6Lpvhv/4ldwHa9yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651184; c=relaxed/simple;
	bh=uoHsfgqmmj8qAfjefCu+YxKn9X4nXcB1CIF0tcjhjGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J6prgPeUuJ0296/wIIIYSjjCK+IFmKtLvQAuNqqLWMl9pi49pcB+fEZ0jBNNmORxQGASKmJs9qxFFUxI9m3FXyKECEnyZWsPWXuWU41/U/Des00UhhbVtTySNIG/cEaThADY6tw+NuKe6fd5qDS3Rk1YXZP4LvWtTH4EJW9H5wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=CbMuDcqJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so3388171b3a.0
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 13:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706651182; x=1707255982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TsFYywSn8u5FZ6SFd2tdZIt5pOveHIu7g3mqWAObFOY=;
        b=CbMuDcqJqrb7Z3F4WhWur1M5AK3c3K6K5D7KxJIB7MOvecKeIJsZx+i8+0CH/XNzyi
         eex4hfdUp5Yq797qy5gOLVnfWABdWBtZfrCxPgKFvjmZk1GHX3Wt8YOkl8emeO9UrbrX
         xi12W5UuP0Bq9lkeIE4+FKhUm6ohy9Znnhu6jiwXhpiwHbhg6Pd6pY5t4Zj/0+E91Ogo
         Sj2mNk3kih2hxJTF5twkT5NcO99SexG1asPlEP7tGFQ9dq2bqeWxlkjQuGmefRn9fkh+
         AqActA7yyZLh0AursrmNGE1OMMmMJT52yaDPwneyAcyowVFaDe8WveYQKefZCgxhxLGY
         7i1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651182; x=1707255982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsFYywSn8u5FZ6SFd2tdZIt5pOveHIu7g3mqWAObFOY=;
        b=TvDG00MWYlzR58Ss4LuLwkpCiFCGn/cAyHYU5jn1kQqfyKk4MptFRlM3dLB9EEOx7G
         EmzZnaX7/bowXovqgoLNYz3tPUE/RK9EZi3ig1dbKssVsy7rxMv7ACxkZcuYiiLPrdq8
         GQUl3XhtYOLSSs9LolAVNjveBZv+ikoS9sBYOEHyhD2mNffWeHs/Jcr8RS5mSXKJ1tBl
         2/ibmcKiccBciIJKnylnA0ucjbr9WazAd//TW+v24CHPdpBhRZgK3qrgPPr2zdSJPgGw
         gZVYePgqHP+wSftWjtmMhiUAaDIllx0ZiHig2kOoukwEw0qxt5kDXHcseMM8WcVWJIpV
         WYbw==
X-Gm-Message-State: AOJu0YzPyAaOpgltLFnSSUi/5IXZGBum+V7VsxQ+mmdofLj46ttYOpqS
	WUnFkhxKSRT/Jd9R2VChOuCxAwOx+drYsSi1ftR/KcjsN/IacY+NbqppShIg9K4=
X-Google-Smtp-Source: AGHT+IHKo5wLSBkruAPBquk4bfEGnfyOllOXzyEoynVl7+C18sP1NFY5IIA/wTuXLiH3YFv2U1PvaA==
X-Received: by 2002:a05:6a00:2d05:b0:6db:cd50:a716 with SMTP id fa5-20020a056a002d0500b006dbcd50a716mr9160420pfb.1.1706651182192;
        Tue, 30 Jan 2024 13:46:22 -0800 (PST)
Received: from localhost (fwdproxy-prn-005.fbsv.net. [2a03:2880:ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id n1-20020a635901000000b005d7b18bb7e2sm8873025pgb.45.2024.01.30.13.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:46:21 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v8 0/5] netdevsim: link and forward skbs between ports
Date: Tue, 30 Jan 2024 13:46:16 -0800
Message-Id: <20240130214620.3722189-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds the ability to link two netdevsim ports together and
forward skbs between them, similar to veth. The goal is to use netdevsim
for testing features e.g. zero copy Rx using io_uring.

This feature was tested locally on QEMU, and a selftest is included.

---
v7->v8:
- fix not dereferencing RCU ptr using rcu_dereference()
- remove unused variables in selftest

v6->v7:
- change link syntax to netnsid:ifidx
- replace dev_get_by_index() with __dev_get_by_index()
- check for NULL peer when linking
- add a sysfs attribute for unlinking
- only update Tx stats if not dropped
- update selftest

v5->v6:
- reworked to link two netdevsims using sysfs attribute on the bus
  device instead of debugfs due to deadlock possibility if a netdevsim
  is removed during linking
- removed unnecessary patch maintaining a list of probed nsim_devs
- updated selftest

v4->v5:
- reduce nsim_dev_list_lock critical section
- fixed missing mutex unlock during unwind ladder
- rework nsim_dev_peer_write synchronization to take devlink lock as
  well as rtnl_lock
- return err msgs to user during linking if port doesn't exist or
  linking to self
- update tx stats outside of RCU lock

v3->v4:
- maintain a mutex protected list of probed nsim_devs instead of using
  nsim_bus_dev
- fixed synchronization issues by taking rtnl_lock
- track tx_dropped skbs

v2->v3:
- take lock when traversing nsim_bus_dev_list
- take device ref when getting a nsim_bus_dev
- return 0 if nsim_dev_peer_read cannot find the port
- address code formatting
- do not hard code values in selftests
- add Makefile for selftests

v1->v2:
- renamed debugfs file from "link" to "peer"
- replaced strstep() with sscanf() for consistency
- increased char[] buf sz to 22 for copying id + port from user
- added err msg w/ expected fmt when linking as a hint to user
- prevent linking port to itself
- protect peer ptr using RCU

David Wei (4):
  netdevsim: allow two netdevsim ports to be connected
  netdevsim: forward skbs from one connected port to another
  netdevsim: add selftest for forwarding skb between connected ports
  netdevsim: add Makefile for selftests

 MAINTAINERS                                   |   1 +
 drivers/net/netdevsim/bus.c                   | 130 ++++++++++++++++++
 drivers/net/netdevsim/netdev.c                |  39 +++++-
 drivers/net/netdevsim/netdevsim.h             |   3 +
 .../selftests/drivers/net/netdevsim/Makefile  |  18 +++
 .../selftests/drivers/net/netdevsim/peer.sh   | 125 +++++++++++++++++
 6 files changed, 311 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh

-- 
2.39.3


