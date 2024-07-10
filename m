Return-Path: <netdev+bounces-110612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 884F592D743
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 19:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F571C20D4F
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD653194C73;
	Wed, 10 Jul 2024 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rWuSWWPe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A505194A59
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631591; cv=none; b=ubSsbDoEfj4c0PEqcKwfcs3J++zIWkQ3myPWURGaTKsP5RvRD14IwmUJ7oz3Z+fPLJAqvNMqZUiWsT0/gZ4qse9QIk2e7Cknh7hhjnGq6VQknIpeERD161ONGOCfTqDJ6hnaof68Wce6mb+355Go6iNKunxkmnC9XGX5HCfrfhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631591; c=relaxed/simple;
	bh=v2158gz0UIe+Ub7n+NdQNNpCbKM1NJd5UGcsa2rIMp8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EJ4TpS1qhNQPyqlBLu65kjUxwyV3l1wUscdlZ+tQbWEv/NUg2xmrdN8cLaqFh3DjW229L8Ld/FfW2l2Rdw1WT0/mxBR82z/wUMavsNbBBXtoNz7oe7YkSFRpP5JN9aYqFhCYiBRGLaMcZUGGS5//32EBMt/M3AYw2uNxHQNx1Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rWuSWWPe; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720631591; x=1752167591;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yGRMgZvvoYpj89deXlRWBrkSTqIrD7aSHBk06K60xAc=;
  b=rWuSWWPevmWh3i1udS+MS/daculqvKAKH41eusqCfIdL+0iPeHD1wpLX
   uy9Y6hRDFTLBkwSg1KAKPv2Bd0PEFumtrVcH+6AbrPysqjc27NiIrskZV
   HarM3nSElBHJDlxmS9baSkhvfVgipwetX4aW77EtpPNoDlY0cwN2PutaV
   Y=;
X-IronPort-AV: E=Sophos;i="6.09,198,1716249600"; 
   d="scan'208";a="740595359"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 17:13:04 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:28548]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.144:2525] with esmtp (Farcaster)
 id e96253d2-36ed-4d07-a3dc-3789edb18a7e; Wed, 10 Jul 2024 17:13:03 +0000 (UTC)
X-Farcaster-Flow-ID: e96253d2-36ed-4d07-a3dc-3789edb18a7e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 10 Jul 2024 17:13:03 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 10 Jul 2024 17:13:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 0/2] tcp: Make simultaneous connect() RFC-compliant.
Date: Wed, 10 Jul 2024 10:12:44 -0700
Message-ID: <20240710171246.87533-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 fixes an issue that BPF TCP option parser is triggered for ACK
instead of SYN+ACK in the case of simultaneous connect().

Patch 2 removes an wrong assumption in tcp_ao/self-connnect tests.

v3:
  * Use (sk->sk_state == TCP_SYN_RECV && sk->sk_socket) to detect cross SYN case

v2: https://lore.kernel.org/netdev/20240708180852.92919-1-kuniyu@amazon.com/
  * Target net-next and remove Fixes: tag
  * Don't skip bpf_skops_parse_hdr() to centralise sk_state check
  * Remove unnecessary ACK after SYN+ACK
  * Add patch 2

v1: https://lore.kernel.org/netdev/20240704035703.95065-1-kuniyu@amazon.com/


Kuniyuki Iwashima (2):
  tcp: Don't drop SYN+ACK for simultaneous connect().
  selftests: tcp: Remove broken SNMP assumptions for TCP AO self-connect
    tests.

 net/ipv4/tcp_input.c                           |  9 +++++++++
 .../selftests/net/tcp_ao/self-connect.c        | 18 ------------------
 2 files changed, 9 insertions(+), 18 deletions(-)

-- 
2.30.2


