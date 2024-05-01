Return-Path: <netdev+bounces-92851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B270B8B9251
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33011C209AE
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 23:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC402168AE6;
	Wed,  1 May 2024 23:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2o/lKUz+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548FE168AE2
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 23:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605959; cv=none; b=USeOXx8jvESbTOpswhIK+J6bknUZxjzSohtc7EfddL34U4+QJplBHxfvRVq36B3fFPNydc+YgGFraxFSd1uZLhqiQw5IQih04S5yO5l6uXyVPCMv04RmHdzYtldmxoEuBedOy/CYaxQDVKBXV5z8+CZJHkX79OO9UUbIeKblPjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605959; c=relaxed/simple;
	bh=kLcD9vnf0pbow7JEtV9tPyLuBa2KoL1+QFDCO9+0wiE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ajjsA4i0MMAo5mHTFQpbNsDbmiK1EUCaA0pJI9wQuJXQieSZxPAdtn+zsQdeD+F4PtmYbI3yRMC5+4kWqSFbjnVGxtSlQSjsguBBJC7T2KLgABZhV2IWXRTdmHVpe130Ofl/2CsoCkCIn0WRCt09ohW3nWlr+MlcX7HpYeLPrR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2o/lKUz+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de60321ce6cso6286907276.1
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 16:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714605957; x=1715210757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wk7TUh1TrMCiZ87nVHRQUsS/RN/7uEuicVRWEl6bjpM=;
        b=2o/lKUz++N2Fl3v+V8gijR66U9Vyldhn1CJ2KKr+mnPzp8zNO9dernSMmaMswhdyaF
         QrpU654VCIaVyTGa9UynBxi0Cy6cCzKUjvWYWWc/18vDi/aE0rekLdK5VJPuOW5oJVkN
         OCBLLl7Q3PFZmPdTjx7J8ysuz16LD4wX9CKrJUTEyh+O80bEOOBMNilFIxs9YZ7YvuG+
         id7/GlJQ8bxmj0w50IxsqEK51HLWxI5V8uLHYaWG+U5LdXIgIlVKL+k9zoYZpaN5L4l3
         XNFx0NQw8RA60f134i6p/lsZJ7K5fU3r1r4bx+HYgPTZlCyDGdoj6jXf8sTDcXDHsSq6
         LrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605957; x=1715210757;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wk7TUh1TrMCiZ87nVHRQUsS/RN/7uEuicVRWEl6bjpM=;
        b=cjaTbQa1jVUcBd9KzYe9SB7cmkWwGfd3h5WZ5dcBhohFDOn/kCFgBeI18r8WmIAOEq
         OIKNn7dmBNRTrcwFEsVEZ+7eOcwRKWLF9jX/sDOSzBTNuoPBm0hlDzIoa8NKuJRHFsXG
         O0pdNdWtZMrpuefIShBENN7hIZPKd2f8chrm6SZpwBulDBMAmZzz5GZifTaFE/1oVfz+
         torQuSa6DuqhYC8xOdFYswQS/7GK0XsDohiXbxKye2sSpblVaj2giD3CdppVphmeqGLY
         bL8NeDTcxP19J5agIAy5Wp9YygDM0mMba+km+I/bXdT+xYr5I1yr3XlAb9Uq5rBpDoN2
         1N2Q==
X-Gm-Message-State: AOJu0YzDe1aEH7CEauO5cbcWNhrBN9iZWNjIxlBtVbDGgP3P/aFU4H5a
	nZlj4HKnkWNBqzO8puQs09OHPdc8/L3K+URaZLIPxt2E2wrOMuJ2eR8PPmepY6zonKRjpZdKbBj
	2wwB38xDInwIQqy2tzbV79RsKsiqS4Ezt+i3truibIhDB5BSOQf1xlFotBJC9LOt9Oi8RA3DNUZ
	oJ06OljJmGyfAF/VMPfDDrCDsYYWRpMyubkdC9yui6/Os=
X-Google-Smtp-Source: AGHT+IHYSzxqWaEht4ARSChpYft3C5aRHEiO/m953Ji8mjVDTuW7xXTSLh7PjGfZFf2OS1leIEJ1e/tE3+gjDA==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a25:2d06:0:b0:de5:4ed6:d3f3 with SMTP id
 t6-20020a252d06000000b00de54ed6d3f3mr89821ybt.6.1714605957310; Wed, 01 May
 2024 16:25:57 -0700 (PDT)
Date: Wed,  1 May 2024 23:25:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240501232549.1327174-1-shailend@google.com>
Subject: [PATCH net-next v2 00/10] gve: Implement queue api
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, rushilg@google.com, 
	willemb@google.com, ziweixiao@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

Following the discussion on
https://patchwork.kernel.org/project/linux-media/patch/20240305020153.2787423-2-almasrymina@google.com/,
the queue api defined by Mina is implemented for gve.

The first patch is just Mina's introduction of the api. The rest of the
patches make surgical changes in gve to enable it to work correctly with
only a subset of queues present (thus far it had assumed that either all
queues are up or all are down). The final patch has the api
implementation.

Changes since v1: clang warning fixes, kdoc warning fix, and addressed
review comments.

Mina Almasry (1):
  queue_api: define queue api

Shailend Chand (9):
  gve: Make the GQ RX free queue funcs idempotent
  gve: Add adminq funcs to add/remove a single Rx queue
  gve: Make gve_turn(up|down) ignore stopped queues
  gve: Make gve_turnup work for nonempty queues
  gve: Avoid rescheduling napi if on wrong cpu
  gve: Reset Rx ring state in the ring-stop funcs
  gve: Account for stopped queues when reading NIC stats
  gve: Alloc and free QPLs with the rings
  gve: Implement queue api

 drivers/net/ethernet/google/gve/gve.h         |  37 +-
 drivers/net/ethernet/google/gve/gve_adminq.c  |  79 ++-
 drivers/net/ethernet/google/gve/gve_adminq.h  |   2 +
 drivers/net/ethernet/google/gve/gve_dqo.h     |   6 +
 drivers/net/ethernet/google/gve/gve_ethtool.c |  48 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 575 ++++++++++--------
 drivers/net/ethernet/google/gve/gve_rx.c      | 132 ++--
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 137 +++--
 drivers/net/ethernet/google/gve/gve_tx.c      |  33 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  |  23 +-
 include/linux/netdevice.h                     |   3 +
 include/net/netdev_queues.h                   |  31 +
 12 files changed, 677 insertions(+), 429 deletions(-)

-- 
2.45.0.rc0.197.gbae5840b3b-goog


