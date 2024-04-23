Return-Path: <netdev+bounces-90691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5502A8AFBE7
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 00:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82694B25371
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 22:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF3A383AE;
	Tue, 23 Apr 2024 22:39:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C622C1AE
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713911978; cv=none; b=hwhauQB2QEnN8NO5gdSeezAGEsxLzaAgMBXi8ZD2AoTP1bXB7eDaFG1WQbxYY1+L9Jb437xDseIRhD/QysGPrRt3ByKf0n1kOBJY8t8NoXxRftWW+TJypjLivw0ppNXagM16y/o+M7D5NxEAqaCpCpqIDT96eIxCKw9bFmCI4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713911978; c=relaxed/simple;
	bh=kRYHVesnCL6lusCF3yKfyW24XGjQesdZBz7sCIpDA9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h60gcoaHV7tDervpzQu3PyXPZx1JH6gMEniwBlGRZZB28CmApSEpr295JGDLF7avkn/7OMgAlVSIHPwd2pCj9ysz4gusH8oGGysLzs4NIKuSXoecmfdO4UunxRHx3SuIhDYXiuEey6Nieum9MrqKLgmdSYSYQUKRHY6ESgNUPKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	laforge@osmocom.org,
	pespin@sysmocom.de,
	osmith@sysmocom.de
Subject: [PATCH net-next 06/12] gtp: pass up link local traffic to userspace socket
Date: Wed, 24 Apr 2024 00:39:13 +0200
Message-Id: <20240423223919.3385493-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240423223919.3385493-1-pablo@netfilter.org>
References: <20240423223919.3385493-1-pablo@netfilter.org>
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
index 2fde4f2268c5..2afcf1887592 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -250,6 +250,10 @@ static bool gtp_check_ms_ipv6(struct sk_buff *skb, struct pdp_ctx *pctx,
 
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


