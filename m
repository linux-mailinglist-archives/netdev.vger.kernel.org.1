Return-Path: <netdev+bounces-146389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9957F9D33BC
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 07:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B844B22402
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 06:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D75B15A856;
	Wed, 20 Nov 2024 06:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GhZGcIMz"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E826C156886;
	Wed, 20 Nov 2024 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732085301; cv=none; b=GFmUNUjmIwWPLPqgdFiOZj9oDQuFrzok3tde6opGFcYMFoKbeHCPenkEI5kLBm142iqRoSfw92b2Ze/q0Gh3BtGMF6ioRkxLJvMIImEp2C2adnSWaPLL3HpVi03qJG6SYQ7avkz6FXwyAoE03pl5TxqMEnXVuaQBWbyDAR1XGnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732085301; c=relaxed/simple;
	bh=Bpf3UQciUdLeGpw8ynEuhL1pC0E4+0wanK7MM8qv68s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P6r2YP+oX27r/bpJyUoI4E5BjQbNfkrC6JiqhbhU+7zFyL23qatyb7fR34+XBwGixhfupnZ8+YmghUxaxB428rLCm3pTJ+eFdYPB2cuyWjUXJ+EY1JC3FMxWiFzq7p2QdSgnbW1cXt3iMwiZAVVFeGb9kFGb/14yNtT5HrbwzDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GhZGcIMz; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9zHgM
	HyBAZTaYIrUIlI3oJ+gzGXjJga3PUIz5mbiuZc=; b=GhZGcIMzAFBwmGuHZq6Io
	HCEoGPX4zPbGEzOS2B1rgQcjFO5QjE3QKs2wLM1OCz4J44P84nu9gKtim/ty0PvP
	rLa4ldRlarKX1c84H0qlGfIf1KjtVWNpeM0Wx44FU51gfw04mLbuELGtnkHtRjLU
	BC2OGTsI5sIqwU+71A+/DY=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnD1j4hT1nTO3OIQ--.22522S4;
	Wed, 20 Nov 2024 14:47:21 +0800 (CST)
From: Ran Xiaokai <ranxiaokai627@163.com>
To: juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	pshelar@ovn.org,
	davem@davemloft.net
Cc: linux-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn,
	linux-perf-users@vger.kernel.org,
	netdev@vger.kernel.org,
	dev@openvswitch.org
Subject: [PATCH 0/4] Convert some simple call_rcu() to kfree_rcu()/kvfree_rcu()
Date: Wed, 20 Nov 2024 06:47:12 +0000
Message-Id: <20241120064716.3361211-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnD1j4hT1nTO3OIQ--.22522S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFy7CF4ktry5ur1xKF4rXwb_yoWxZFb_ZF
	WfZFWUGw47XrWY9a12kF4kXr1DCF1ktr1Fqw4DKay5Xay7JwnxJr13WFZxZr9YqayxKFZ8
	Jr1jqFyxtr1fZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8e6wtUUUUU==
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiMx2dTGc9f3WTogAAse

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

These rcu callbacks simply call kfree()/kvfree(),
it's better to convert them to directly call kfree_rcu()/kvfree_rcu().

Ran Xiaokai (4):
  sched/topology: convert call_rcu(free_ctx) to kfree_rcu()
  perf/core: convert call_rcu(free_ctx) to kfree_rcu()
  net: openvswitch: convert call_rcu(dp_meter_instance_free_rcu) to
    kvfree_rcu()
  net: sysfs: convert call_rcu() to kvfree_rcu()

 kernel/events/core.c    | 10 +---------
 kernel/sched/topology.c | 10 ++--------
 net/core/net-sysfs.c    | 11 ++---------
 net/openvswitch/meter.c | 10 +---------
 4 files changed, 6 insertions(+), 35 deletions(-)

-- 
2.17.1


