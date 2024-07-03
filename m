Return-Path: <netdev+bounces-108694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C14BC924F9F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 05:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30B91C228FC
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 03:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B103EFC12;
	Wed,  3 Jul 2024 03:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SWGEtbgg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC881863C
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 03:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977730; cv=none; b=p0i1E/zedShQAVz4HYU3JDPuqPHB7/2ZMWpntvSwmdMfV7XbISq3xtg+SzSMKjRbXqwHUVnCu2aaIkRsHVjnDHkat+XEO+4ti7JGcPK0YEC0QsOtDKqagNyA1gnTOGv4D9hi5adT4ZHgXxVy2QRU7MpuNUY7a+fytG1e6+s4Bic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977730; c=relaxed/simple;
	bh=0MtbJMA/+8ihgmJ+5Ez1oXOdjou2VOJkvxQgDc17iqo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V1wi8kGBGQiYB6L7oBSzWcnKlFKuUy+CJqGZnotnYDJfoSKgS5WTjVWGSFcSIKiV7b9gXZjF5QoTOKDFJXtRtrveOmWZKS/a11S6PzeD7N5z8ruHIHib//V0DTzwDRCTt0jPYVaImlsn1rvsvpU7+/VcyVgqOe1g3c+cU1HmYdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SWGEtbgg; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719977726; x=1751513726;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kq5XMYQ1mMfr575+LEMeiWYqqNVE3XqMMXpin+oXLs4=;
  b=SWGEtbgg0sGmed47zBAxHFJFXF46vwbjgjsGwhdfbKmzrA+eHjn+/NYv
   oovQ0WBQW/1TTsSMLJaLP51G2o7tbuuAlnJDI5jycSVQtrpWqOmQBLBww
   aMdUrmOPTBrVDrt0zNZulwfIV/ZmiDOa1C2DJlCBPNRHZ/jA7JbywjudV
   E=;
X-IronPort-AV: E=Sophos;i="6.09,181,1716249600"; 
   d="scan'208";a="215776923"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 03:35:23 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:15885]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.105:2525] with esmtp (Farcaster)
 id 7c6073b9-4d3b-438b-8f29-931ae89acd85; Wed, 3 Jul 2024 03:35:22 +0000 (UTC)
X-Farcaster-Flow-ID: 7c6073b9-4d3b-438b-8f29-931ae89acd85
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 3 Jul 2024 03:35:22 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 3 Jul 2024 03:35:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: David Ahern <dsahern@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net] tcp: Don't flag tcp_sk(sk)->rx_opt.saw_unknown for TCP AO.
Date: Tue, 2 Jul 2024 20:35:08 -0700
Message-ID: <20240703033508.6321-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When we process segments with TCP AO, we don't check it in
tcp_parse_options().  Thus, opt_rx->saw_unknown is set to 1,
which unconditionally triggers the BPF TCP option parser.

Let's avoid the unnecessary BPF invocation.

Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_input.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e67cbeeeb95b..77294fd5fd3e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4223,6 +4223,13 @@ void tcp_parse_options(const struct net *net,
 				 * checked (see tcp_v{4,6}_rcv()).
 				 */
 				break;
+#endif
+#ifdef CONFIG_TCP_AO
+			case TCPOPT_AO:
+				/* TCP AO has already been checked
+				 * (see tcp_inbound_ao_hash()).
+				 */
+				break;
 #endif
 			case TCPOPT_FASTOPEN:
 				tcp_parse_fastopen_option(
-- 
2.30.2


