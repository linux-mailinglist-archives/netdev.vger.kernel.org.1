Return-Path: <netdev+bounces-113818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE17940022
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A2B4B22A09
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E972F18E741;
	Mon, 29 Jul 2024 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vD5pdDPO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D9C18D4AD
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287302; cv=none; b=cVIheYr5Xv7B8KfbPlPqghVPschtvFjCPa/th+twSAVe7gCQfNBDY4qW/0HGGuFB8ZCQbAzhH99mfW6iue48xQliE7K9Bk9WAqB7lxD6OC9RMHYcZvupvarSbbxL0uFb/7uXoUq6IkE7ngnqojsKiQDm0yo/fsRHTePSgfgDwAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287302; c=relaxed/simple;
	bh=0vI3SAeS3lFDEMoDBm7XEVi0axlFXqdODNguZp7OzEA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AlWLVGO0jZMWDu2Qu73FFa75JbVvSpTt6UjhEJGgl2hn7rEnCzm7xohkk/hgvfqtVMxCbFSBEEpbDbFrGR31+D/M9ty0P31VteioOgSrIxyFEfF/pY98UFnSEXUlcICzj6d1AfPSNaSHESaf4mQEp4GVVPLr5eb3aHVHDq+j9Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vD5pdDPO; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722287301; x=1753823301;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DsO98fKEP/S/GrMkqn1RvnoDTommgxxPn8zbVA2ExEI=;
  b=vD5pdDPOS4DSSMr92e6b8r514Fh1FciEFKtZwEEox/nS0mIGxKGG39cv
   bxJuErvekLd4ujU3kDlpJhyVVlEeT28TEvxPi2OA7b/yO6l+IJ34pSOHu
   Rkqc249uKqO/QWvJM5c631l8T5CMR2eeH2Qw9NEjwy7cgICeZTzry+mW5
   g=;
X-IronPort-AV: E=Sophos;i="6.09,246,1716249600"; 
   d="scan'208";a="110424416"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 21:08:19 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:29632]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.1:2525] with esmtp (Farcaster)
 id ff13e1a0-6388-4c1e-bcb8-2dfdc2cf0478; Mon, 29 Jul 2024 21:08:19 +0000 (UTC)
X-Farcaster-Flow-ID: ff13e1a0-6388-4c1e-bcb8-2dfdc2cf0478
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 21:08:18 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 21:08:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/6] net: Random cleanup for netns initialisation.
Date: Mon, 29 Jul 2024 14:07:55 -0700
Message-ID: <20240729210801.16196-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

patch 1 & 2 suppress unwanted memory allocation for net->gen->ptr[].

patch 3 ~ 6 move part of netns initialisation to prenet_init() that
do not reqruire pernet_ops_rwsem.


Kuniyuki Iwashima (6):
  l2tp: Don't assign net->gen->ptr[] for pppol2tp_net_ops.
  net: Don't register pernet_operations if only one of id or size is
    specified.
  net: Initialise net->passive once in preinit_net().
  net: Call preinit_net() without pernet_ops_rwsem.
  net: Slim down setup_net().
  net: Initialise net.core sysctl defaults in preinit_net().

 include/net/net_namespace.h |  4 +-
 net/core/net_namespace.c    | 84 ++++++++++++++++---------------------
 net/l2tp/l2tp_ppp.c         |  3 --
 3 files changed, 39 insertions(+), 52 deletions(-)

-- 
2.30.2


