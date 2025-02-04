Return-Path: <netdev+bounces-162794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEEFA27F26
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 00:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB6F3A043D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47DF218EBF;
	Tue,  4 Feb 2025 23:01:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2CD204F92
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 23:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710061; cv=none; b=cPH8CjDjzlsG73C5b3Hk27RTabGCoxMyju2dsJDUTYeHK55o/ldx1G1tkwl+k2ZIYtevj6nOcZtRwWbSOVdYKo3L7OlHwZORmi777ackp+poNxPcU2E5TOZVgn53OfXz+ULMgxV27Dv2vD/UDFeJ/wRy73exluoWOYzkQs4DjLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710061; c=relaxed/simple;
	bh=LYGuAS8r0zMhR912mKQvTBCkR1GnXAawQlCSnknOpnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=prFPRUzYHRtGsY56y+audHV68h5NNiCqHCW7MmilL9+y3Bc6KsyPMkqW8yxV5I5Onc6XONu2spNtb0Mu7DsIiwSN/GwJ6w8p9EKeo9evqaowFSbETvlW+tfn+t/dMwqZE+KTwZK3QEj2sADyaP6dX1xDy6ENMI+5FejuNtlmTpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2167141dfa1so5079505ad.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 15:00:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738710059; x=1739314859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XkCFEvfh5dS42/YlD2ZSZiyEMGhsj4+jMVuJyY1UhTc=;
        b=jmqrlrxisaCaeRwkDuQ1LiF+JNhuKcF2Qlpj2GKJrxI+DMpewHzc+q6I0AnWOYditr
         EU3H8HZkWsOgYhMG9q0CfbWSQlFB7dpu1QqoIGz3R78R/aW4PgvvENe+cKA/4AvRD1wn
         j+SOyq8ry3iHDM3hs1lgcD7QnllV2Py8jTw/IT1Yi4RkcpjovqiSCL9NsKsbBy/2T8qT
         M24xuLmUM1iXuuZZ9oUGbOnTYKfbUv8rejaL568Qkc48ohAFipFRN3yitY+FqOs0j6tn
         r1NR0r1Et6de2bCJmGnI+ezfgzCITC06XR8T9PPlhGpwZ0glN72eXIqJxhwrbITXfw0V
         eGkA==
X-Gm-Message-State: AOJu0YyhwRIYWGthKDAvhKrcU74SYN0JxXB2mCBZo1YczrD18qxCzPpU
	59Pk9b9RHBzxx8feBU0kxXpwjEg1od92W0uUg9fab7c+gSH6+3rFJr6b
X-Gm-Gg: ASbGnctTPzsYTaoF5S6g4hXfDXZWzo3lb5pzkiXkqBtfJ8cedPeuKquhCuNAG4xFazo
	MVaT+KtVeVMSQbiIHxIAcSEtu+Mxf6hUPi8eny3ulJtIHRDclTUg6F1OneN7TEXEijVkZyRmhda
	rJt4AvcGrCJ7erJVeaM7HvqnrkHWa55wJHzynlj6XIsjbiFrS9FTI0dk7HMLOLD6189MEpwOGMC
	6wX9G4KY47ka+sens8wmlsP2Z3B92xHwYRLwC4+pNBX0f/Hgnga3gwoEYHYn402/QkF+22a/1eO
	VsjRwI1gT9g16v8=
X-Google-Smtp-Source: AGHT+IG4JVbVOygQCNTty9cVHhkzyMmKacPhGBkxJ0y66g+r3clBkSh6AORpX/jAYuUQkyFL82Klxw==
X-Received: by 2002:a17:903:18f:b0:215:6c5f:d142 with SMTP id d9443c01a7336-21f17ac8cf3mr11023865ad.20.1738710058698;
        Tue, 04 Feb 2025 15:00:58 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f0bfac8dbsm13477705ad.236.2025.02.04.15.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 15:00:58 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [RFC net-next 0/4] net: Hold netdev instance lock during ndo operations
Date: Tue,  4 Feb 2025 15:00:53 -0800
Message-ID: <20250204230057.1270362-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the gradual purging of rtnl continues, start grabbing netdev
instance lock in more places so we can get to the state where
most paths are working without rtnl. Start with requiring the
drivers that use shaper api (and later queue mgmt api) to work
with both rtnl and netdev instance lock. Eventually we might
attempt to drop rtnl. This mostly affects iavf, gve, bnxt and
netdev sim (as the drivers that implement shaper/queue mgmt)
so those drivers are converted in the process.

This is part one of the process, the next step is to do similar locking
for the rest of ndo handlers that are being called from sysfs/ethtool/netlink.

Cc: Saeed Mahameed <saeed@kernel.org>

Stanislav Fomichev (4):
  net: Hold netdev instance lock during ndo_open/ndo_stop
  net: Hold netdev instance lock during ndo_setup_tc
  net: Hold netdev instance lock for more NDOs
  net: Hold netdev instance lock during queue operations

 Documentation/networking/netdevices.rst       | 52 +++++++++++++-----
 drivers/net/bonding/bond_main.c               |  9 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 54 +++++++++++++++----
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 11 ++--
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |  2 +
 drivers/net/ethernet/google/gve/gve_main.c    |  8 +--
 drivers/net/ethernet/google/gve/gve_utils.c   |  8 +--
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 16 +++---
 drivers/net/netdevsim/netdev.c                | 36 ++++++++-----
 include/linux/netdevice.h                     | 27 ++++++++++
 net/8021q/vlan_dev.c                          |  4 +-
 net/core/dev.c                                | 34 ++++++++++++
 net/core/dev.h                                |  6 ++-
 net/core/dev_ioctl.c                          | 44 ++++++++++-----
 net/core/netdev_rx_queue.c                    |  5 ++
 net/dsa/user.c                                |  5 +-
 net/ieee802154/socket.c                       |  2 +
 net/netfilter/nf_flow_table_offload.c         |  2 +-
 net/netfilter/nf_tables_offload.c             |  2 +-
 net/phonet/pn_dev.c                           |  2 +
 net/sched/cls_api.c                           |  2 +-
 net/sched/sch_api.c                           | 13 ++---
 net/sched/sch_cbs.c                           |  9 +---
 net/sched/sch_etf.c                           |  9 +---
 net/sched/sch_ets.c                           | 10 +---
 net/sched/sch_fifo.c                          | 10 +---
 net/sched/sch_gred.c                          |  5 +-
 net/sched/sch_htb.c                           |  2 +-
 net/sched/sch_mq.c                            |  5 +-
 net/sched/sch_mqprio.c                        |  6 +--
 net/sched/sch_prio.c                          |  5 +-
 net/sched/sch_red.c                           |  8 +--
 net/sched/sch_taprio.c                        | 16 ++----
 net/sched/sch_tbf.c                           | 10 +---
 34 files changed, 266 insertions(+), 173 deletions(-)

-- 
2.48.1


