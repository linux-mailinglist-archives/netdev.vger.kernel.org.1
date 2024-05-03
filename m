Return-Path: <netdev+bounces-93381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1BF8BB714
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 00:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECDA1F237C1
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ADA2BAE9;
	Fri,  3 May 2024 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pl4RGIpX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C151D290F
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775530; cv=none; b=Hxe79t68h58OuMT9xFbrj55y4gfxOXoK3HrbIw7Ojci/QAo2mOhrXDanZj+7GE3HRbmHMYHpQjY7sskKZL+DAcBAzg5QrNwuQn3e7SfLvcY23nAPTT1E316U1wDxXpGnbD1ETD/5b3/jCCUi21pyQVqfwRpqk3+hOVljqeHsfrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775530; c=relaxed/simple;
	bh=GEFgvc+sklarGdpghXFkSOTLnJPXpME5+mmX0EOG6jg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=et/Hj+QQxRzRl3jhGUKfpJlWvE0/6XudRY3y4XtrPqsduqFMoiZWM8WVpQyyTOZ6Ot2/DWhIOJwRyWZoBBkCTyX/F/wFJCbRlCOysqE/ov/FIegKqpvNvna9wv2pazd3oELDCTjCRINXXhCXict/u3+GWIFllzqehSFRNLorbaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pl4RGIpX; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714775528; x=1746311528;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+/t9SlXJQG1l8u9CgNbWV6Y4cX9cwjhSYQ4E86rid3o=;
  b=pl4RGIpXNAtXn6jUelbRLyiifOE9K4ih9ZTAKA8SVf1+P8PCGMZUioSC
   oXNAMWY4dGDbqW+8wUkICyXuF4t5m2c+o9hHWDbhswh77MNpKQflMLfGr
   xdBNY7Qju50W42i/ZgqxQa9IdquSSL5t9X2ztnGSlnfbt7ynPKq2WqBTq
   U=;
X-IronPort-AV: E=Sophos;i="6.07,251,1708387200"; 
   d="scan'208";a="723557968"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 22:32:03 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:63664]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.254:2525] with esmtp (Farcaster)
 id 03f95ccd-f451-4024-ad06-910e8ff6c025; Fri, 3 May 2024 22:32:02 +0000 (UTC)
X-Farcaster-Flow-ID: 03f95ccd-f451-4024-ad06-910e8ff6c025
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 3 May 2024 22:32:02 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 3 May 2024 22:31:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/6] af_unix: GC cleanup and optimisation
Date: Fri, 3 May 2024 15:31:44 -0700
Message-ID: <20240503223150.6035-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The first patch removes a small race introduced by commit 1af2dface5d2
("af_unix: Don't access successor in unix_del_edges() during GC.").

Other patches clean up GC and optimise it so that we no longer schedule
it if we know that no loop exists in the inflight graph.


Kuniyuki Iwashima (6):
  af_unix: Add dead flag to struct scm_fp_list.
  af_unix: Save the number of loops in inflight graph.
  af_unix: Manage inflight graph state as unix_graph_state.
  af_unix: Move wait_for_unix_gc() to unix_prepare_fpl().
  af_unix: Schedule GC based on graph state during sendmsg().
  af_unix: Schedule GC only if loop exists during close().

 include/net/af_unix.h |   4 +-
 include/net/scm.h     |   1 +
 net/core/scm.c        |   1 +
 net/unix/af_unix.c    |   7 +--
 net/unix/garbage.c    | 117 ++++++++++++++++++++++++++----------------
 5 files changed, 76 insertions(+), 54 deletions(-)

-- 
2.30.2


