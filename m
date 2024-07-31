Return-Path: <netdev+bounces-114672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7072A9436D8
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239EE282533
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7019145005;
	Wed, 31 Jul 2024 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EGZWHqAb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AEB381AD
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456467; cv=none; b=bmgInLHBMhfDlR+FbaklXh9dO9iC0m50WImLN0GVQ6lhbsrdQFzQMhfnRkSZSpgCs1JFElbV1bHYGbhVOSaAi8eeApfk+9Ree2PmqYuv9udoybjJB9lRT+h898+B185o0zMz4OFKE8opZ6Pok6KHCpEN+jGd5kgpF74Co/Uyd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456467; c=relaxed/simple;
	bh=rHOEeH6r80Xlk5/YwzxKY+/PpmbLJHN9xOqtkI40epg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IVbBDUUxMUredEpIaVGzb6ewOGQrpeq6eQmkAMjYKy8eJSFAOMJbLgN/PSKkfWxzDM+WH3gO1iPysLZxs6t+OkLZTMMgvX0pAl10bviSsUZU/n5ZTb8fLUJIVYRPfY6sSzgjSv73JBG2H7UdfeHkOSfmuiCu5tCB+kGIzXAbn74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EGZWHqAb; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722456466; x=1753992466;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OLXU5YGwzBWyH9AmtmGoT8ELdQHcUYZp5zhd9C8goKs=;
  b=EGZWHqAbfQurgnKF5KP0BLAfhbhaNDIkztf/n39QLtkiENdqqAPMuBCg
   KZlWEk00UfJj1MBcmmYmza8Iecxjm9a89ceh5mCUmyKu5jwvR5FV00tpJ
   RjF8c7LVF/nqxfxfa51kPAGxt6bbTFHO4Jyia/RDLQ5QpT9Qrsz/ByMM6
   Y=;
X-IronPort-AV: E=Sophos;i="6.09,251,1716249600"; 
   d="scan'208";a="746777353"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 20:07:40 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:57348]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.84:2525] with esmtp (Farcaster)
 id 7526b797-9330-4e14-9f47-9c781be59cc3; Wed, 31 Jul 2024 20:07:39 +0000 (UTC)
X-Farcaster-Flow-ID: 7526b797-9330-4e14-9f47-9c781be59cc3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 20:07:34 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 20:07:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 0/6] net: Random cleanup for netns initialisation.
Date: Wed, 31 Jul 2024 13:07:15 -0700
Message-ID: <20240731200721.70601-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

patch 1 & 2 suppress unwanted memory allocation for net->gen->ptr[].

patch 3 ~ 6 move part of netns initialisation to prenet_init() that
do not require pernet_ops_rwsem.


v2:
  patch 1 : Removed Fixes: tag
  patch 2 : Use XOR for WARN_ON()

v1: https://lore.kernel.org/netdev/20240729210801.16196-1-kuniyu@amazon.com/


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


