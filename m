Return-Path: <netdev+bounces-115741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D968947A6F
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3DF281C63
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 11:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B705315666C;
	Mon,  5 Aug 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="Qa3Juw/+"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D591C155743
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722857742; cv=none; b=CpdlP3QFPFT1G4fRv9p3X8nK9Blh7KOr99CP2tI8TUajcLw/4hzMBN7Y9a8HiJxynqGG3KaFVBIlkSXAaftRV7moDtS8HyjnqPGhwnsV7WwZWbTUffyLgFZDelOQCAoMIpKqEn3huVYQpbwaZvUMLmKQhi/zSt5UexOPWXWx/hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722857742; c=relaxed/simple;
	bh=QXZyng/tUeIvLBk/wMdEksOX6GZ0b3apLidcra68gLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hAuVX2owug8uf12YRVWtd82988P25sOC67WmfJL2ryv0F+HJMaSx3EvHhlVWFT0oPdkFJ59e6XBz5Tt3OINfoogqlNuQP1zQU89HbT+X8Gwa/lSHpEcFgu3UDKPjstr1u2YhVCijzE+9zNw1Cp4BcBNhEgoojv3fRYLxSW7FTec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=Qa3Juw/+; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:326:9405:f27f:a659])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id EB95A7D9B6;
	Mon,  5 Aug 2024 12:35:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722857734; bh=QXZyng/tUeIvLBk/wMdEksOX6GZ0b3apLidcra68gLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[PATCH=20n
	 et-next=200/9]=20l2tp:=20misc=20improvements|Date:=20Mon,=20=205=2
	 0Aug=202024=2012:35:24=20+0100|Message-Id:=20<cover.1722856576.git
	 .jchapman@katalix.com>|MIME-Version:=201.0;
	b=Qa3Juw/+Xh/bj95H7U6WieRZWnu0qwGh3oVTCxspDv76VTVSQeavt0zN5Mrt5HUc1
	 IjfIj/Ka6ehhMHc4oS8NrA0ylRoj/a1K5LTmMzgQsTiLN2HwH6nP5Vj62k6AE28ZSr
	 IEqjMGVwOIk9x3PfY5azRNBS0UJz8i0RiWvCGaNeodZoELV8yf9mGLhjRTvTpTswjM
	 JJYEvPzaj7MNLYu5jBGczZ1lL6iUiSnL2Mtmo+YsRy4ZX8b+SMJrTjGw8orJGChraZ
	 abmx214YLTVqTABvudqqsCItZU+rRqbH24UNF+cfTlBjpfbwXiN590Km42loL2EV/7
	 AX3BV1ulAD1oQ==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [PATCH net-next 0/9] l2tp: misc improvements
Date: Mon,  5 Aug 2024 12:35:24 +0100
Message-Id: <cover.1722856576.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series makes several improvements to l2tp:

 * update documentation to be consistent with recent l2tp changes.
 * move l2tp_ip socket tables to per-net data.
 * fix handling of hash key collisions in l2tp_v3_session_get
 * implement and use get-next APIs for management and procfs/debugfs.
 * improve l2tp refcount helpers.
 * use per-cpu dev->tstats in l2tpeth devices.
 * fix a lockdep splat.
 * fix a race between l2tp_pre_exit_net and pppol2tp_release.

James Chapman (9):
  documentation/networking: update l2tp docs
  l2tp: move l2tp_ip and l2tp_ip6 data to pernet
  l2tp: fix handling of hash key collisions in l2tp_v3_session_get
  l2tp: add tunnel/session get_next helpers
  l2tp: use get_next APIs for management requests and procfs/debugfs
  l2tp: improve tunnel/session refcount helpers
  l2tp: l2tp_eth: use per-cpu counters from dev->tstats
  l2tp: fix lockdep splat
  l2tp: flush workqueue before draining it

 Documentation/networking/l2tp.rst |  54 ++++-----
 net/l2tp/l2tp_core.c              | 192 ++++++++++++++++++++++--------
 net/l2tp/l2tp_core.h              |  11 +-
 net/l2tp/l2tp_debugfs.c           |  24 ++--
 net/l2tp/l2tp_eth.c               |  42 +++----
 net/l2tp/l2tp_ip.c                | 114 +++++++++++++-----
 net/l2tp/l2tp_ip6.c               | 116 +++++++++++++-----
 net/l2tp/l2tp_netlink.c           |  72 ++++++-----
 net/l2tp/l2tp_ppp.c               |  62 +++++-----
 9 files changed, 440 insertions(+), 247 deletions(-)

-- 
2.34.1


