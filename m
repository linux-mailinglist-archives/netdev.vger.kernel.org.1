Return-Path: <netdev+bounces-91266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F64F8B1FA7
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 12:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CC21C209FD
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 10:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A762D044;
	Thu, 25 Apr 2024 10:51:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81C4208B0
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042313; cv=none; b=ONDONi0g9f9h7ESOKTO3Z8+5mMgOtDZepG2TgreSA+yCO+Num7hFuI1B0Ss0yyAwO6gyOgdsN7cvAEnmMon9IzI2phKQEJX//f3/vn2rALBFrTqVqSMgbGUiRW2SDKdazEfzdbqBPxwtzYeMJmLFd4Ut6D5zdgvk4qWRfcocRIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042313; c=relaxed/simple;
	bh=BOCD82kL2fqn3VqATkh8Fz9IGGRFmeJlIzfds41+m2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iDVIVN6vg/7nBmExMc+oGy7PEk4tuYoPR0Z39NyWV5Qq/K/gLtshC4kXFrHBSclTzsrnOei+SehvIq6LhwlSbKu8XQTVXzwXJTS0MEv5HOhvwqkzt5ycuTfsSPFnXiUXqHgfw3QMlMvQZGVlkR2IaKLYbLHDOfW+D4JRiZkiskY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	laforge@osmocom.org,
	pespin@sysmocom.de,
	osmith@sysmocom.de,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 06/12] gtp: pass up link local traffic to userspace socket
Date: Thu, 25 Apr 2024 12:51:32 +0200
Message-Id: <20240425105138.1361098-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240425105138.1361098-1-pablo@netfilter.org>
References: <20240425105138.1361098-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to TS 29.061, it is possible to see IPv6 link-local traffic in
the GTP tunnel, see 11.2.1.3.2 IPv6 Stateless Address Autoconfiguration
(IPv6 SLAAC).

Pass up these packets to the userspace daemon to handle them as control
GTP traffic.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 drivers/net/gtp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index ca3b1df19e6d..52f4aeecb8f8 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -251,6 +251,10 @@ static bool gtp_check_ms_ipv6(struct sk_buff *skb, struct pdp_ctx *pctx,
 
 	ip6h = (struct ipv6hdr *)(skb->data + hdrlen);
 
+	if ((ipv6_addr_type(&ip6h->saddr) & IPV6_ADDR_LINKLOCAL) ||
+	    (ipv6_addr_type(&ip6h->daddr) & IPV6_ADDR_LINKLOCAL))
+		return false;
+
 	if (role == GTP_ROLE_SGSN) {
 		ret = ipv6_pdp_addr_equal(&ip6h->daddr, &pctx->ms.addr6);
 	} else {
-- 
2.30.2


