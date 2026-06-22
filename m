Return-Path: <netdev+bounces-300944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o+y2KZysOGpHfgcAu9opvQ
	(envelope-from <netdev+bounces-300944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 05:31:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F07206AC4CE
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 05:31:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ucloud.cn header.s=default header.b=mDlclvaB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300944-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300944-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ucloud.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88A16300BDB0
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 03:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B2725B0B9;
	Mon, 22 Jun 2026 03:31:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m2425.xmail.ntesmail.com (mail-m2425.xmail.ntesmail.com [45.195.24.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C51175A81;
	Mon, 22 Jun 2026 03:31:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782099097; cv=none; b=Z7szuyUUWua+AWZPmVHYKJGwTA/7BfF9LQgyqAbAcnbMdcUNsBazhjDokFsiNUIEfcK2fzH/rzoCVM9pv9kOLMa98BCaADYmCRBu0PoDHbXoV4VyOd6OM5QJiGk61A816cbB0TTwM/qVu7AZRjPu4IrU24AtLZxr1Y1RdBttWVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782099097; c=relaxed/simple;
	bh=4CJ0BW01+ZHpO4AApHrpRXqwxTEX1606TuvSpOUiNyA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Drz36k1r2mKTD3En2qT9HA1fqvGG8ZaQJJYS+Hy0XyihfeeG0Ee/kJyTLnjuP9ONMIjT4+5b+femoUOyT41MFIQdLtBPtogOMyL90oEWquP+fJaR26qNiV0Dr0az7WaxAwMR44U2ABHrc/2VprLiH51ti57cj1VFwONTpve97rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn; spf=pass smtp.mailfrom=ucloud.cn; dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b=mDlclvaB; arc=none smtp.client-ip=45.195.24.25
Received: from yuangap.. (unknown [106.75.220.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1bb5e51a5;
	Mon, 22 Jun 2026 11:31:24 +0800 (GMT+08:00)
From: "yuan.gao" <yuan.gao@ucloud.cn>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Yue Haibing <yuehaibing@huawei.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Kyle Zeng <kylebot@openai.com>,
	"yuan.gao" <yuan.gao@ucloud.cn>,
	Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dst: block BH in ipip6_tunnel_xmit
Date: Mon, 22 Jun 2026 11:31:17 +0800
Message-Id: <20260622033118.244651-1-yuan.gao@ucloud.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eed6205350229kunmfc98e48e1ebcce
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHxhNVkhPQklISR1PTRpLSVYVFA
	kWGhdVGRETFhoSFyQUDg9ZV1kYEgtZQVlKS01VTE5VSUlLVUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=mDlclvaBkntOfGbokVPG4PYZDUp8QwI31TUFiq3I1ksLgVM8YyOeYiA9z8oGuBTu1xknGKzC5DtZ2UKWVW6lQjAgqUa3MBfTUgSLbTwYQC4KMJyyH92ALJqJJ3C4SMf5L6D1pkDwqnCjWWmBytC6/XxjV1HAPsOg+Gl3idJxJlo=; c=relaxed/relaxed; s=default; d=ucloud.cn; v=1;
	bh=mcu0Q7TU4nmlPL+qM/x69lH/sYmnRorYukFsshfAN5A=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ucloud.cn,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[ucloud.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300944-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:yuehaibing@huawei.com,m:kuniyu@google.com,m:thorsten.blum@linux.dev,m:kylebot@openai.com,m:yuan.gao@ucloud.cn,m:kees@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yuan.gao@ucloud.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuan.gao@ucloud.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ucloud.cn:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ucloud.cn:dkim,ucloud.cn:email,ucloud.cn:mid,ucloud.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F07206AC4CE

Similar to commit 1378817486d6 ("tipc: block BH before using dst_cache"),
the dst cache helper functions must be invoked with local BH disabled.

This ensures proper synchronization and fixes a potential race condition
on SMP systems.

Signed-off-by: yuan.gao <yuan.gao@ucloud.cn>
---
 net/ipv6/sit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 201347b4e1274..2a63b346634e7 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -934,14 +934,20 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 			   IPPROTO_IPV6, 0, dst, tiph->saddr, 0, 0,
 			   sock_net_uid(tunnel->net, NULL));
 
+	local_bh_disable();
 	rt = dst_cache_get_ip4(&tunnel->dst_cache, &fl4.saddr);
+	local_bh_enable();
+
 	if (!rt) {
 		rt = ip_route_output_flow(tunnel->net, &fl4, NULL);
 		if (IS_ERR(rt)) {
 			DEV_STATS_INC(dev, tx_carrier_errors);
 			goto tx_error_icmp;
 		}
+
+		local_bh_disable();
 		dst_cache_set_ip4(&tunnel->dst_cache, &rt->dst, fl4.saddr);
+		local_bh_enable();
 	}
 
 	if (rt->rt_type != RTN_UNICAST && rt->rt_type != RTN_LOCAL) {
-- 
2.32.0


