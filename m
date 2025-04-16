Return-Path: <netdev+bounces-183063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904C0A8ACC8
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62CDF7A2532
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD641D5CD1;
	Wed, 16 Apr 2025 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DtQ6yEeu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5661CD208
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764194; cv=none; b=ofASuQYLdF98FE+x811hKrk47Vy6qI9Slh6pgR0RP2ASZDmtALJyf+SJMuiDA/L7wn/BFXF8NJpUaZgP3dMS30+NbGbVla45THhMbBMUgV8dVtKNwm4iOcyt2JAFyKSDcSOhMBKaf9m5F7vrNY7+qIuAqPYxy9dOVRDpx9A2CwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764194; c=relaxed/simple;
	bh=Ru81sSTS5rSeKtkx0AiOc7XjI7qOWO2SkUPVZEXYWvE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QK9J61KvovVPGlR5hzCwKg0ROL+au29vNYBrHx3+MyumHTk3rbO/lAnG1m4PjTAUNKdwWArzmvFcCrizAnEW2QDYa7IJmdxh6gnjMMYeH3DeTej54POkRMTyoOelnUpnVztVwxb44XxC3vwzMle0LSVSw7eNV+OUxTyfIytOuh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DtQ6yEeu; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744764194; x=1776300194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hgOFb0JOrIbHbZFiTQsch8DmQMphhTCIt0QRhsfjtrk=;
  b=DtQ6yEeuCJOhBF/EeRbGfjGxjGe38PCFaj8jWOc5J99ocMc62BVr00Z6
   IbZBNThHblX+JAfni7tyDtMBZUW8O46+ZhMeuc+jdfhZBWLI/23IrQ76A
   aKFASEeOxfZbFQHq3WeD7/jwyLBy/BtDpQCxCOO5ZJtMCBp9pBuyvyZqM
   E=;
X-IronPort-AV: E=Sophos;i="6.15,214,1739836800"; 
   d="scan'208";a="735932563"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 00:43:09 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:38917]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.195:2525] with esmtp (Farcaster)
 id 4683a17b-1cea-4fb4-a465-7ec71159e984; Wed, 16 Apr 2025 00:43:07 +0000 (UTC)
X-Farcaster-Flow-ID: 4683a17b-1cea-4fb4-a465-7ec71159e984
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 00:43:04 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.149.87) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 00:43:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/7] neighbour: Convert RTM_GETNEIGH and RTM_{GET,SET}NEIGHTBL to RCU.
Date: Tue, 15 Apr 2025 17:41:23 -0700
Message-ID: <20250416004253.20103-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 - 4 moves validations and skb allocation in neigh_get()
as prep for patch 5, which converts RTM_GETNEIGH to RCU.

Patch 6 & 7 converts RTM_GETNEIGHTBL and RTM_SETNEIGHTBL to RCU,
which requires almost nothing.


Kuniyuki Iwashima (7):
  neighbour: Make neigh_valid_get_req() return ndmsg.
  neighbour: Move two validations from neigh_get() to
    neigh_valid_get_req().
  neighbour: Allocate skb in neigh_get().
  neighbour: Move neigh_find_table() to neigh_get().
  neighbour: Convert RTM_GETNEIGH to RCU.
  neighbour: Convert RTM_GETNEIGHTBL to RCU.
  neighbour: Convert RTM_SETNEIGHTBL to RCU.

 net/core/neighbour.c | 208 +++++++++++++++++++++----------------------
 1 file changed, 101 insertions(+), 107 deletions(-)

-- 
2.49.0


