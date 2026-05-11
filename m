Return-Path: <netdev+bounces-286475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHOKHoyEAWoFcAEAu9opvQ
	(envelope-from <netdev+bounces-286475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:26:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C13509210
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB8FB3008235
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AA63264D2;
	Mon, 11 May 2026 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="ZIluVEVf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43B11C5F11
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483724; cv=none; b=BSVzEV8vgLieUtnDqy8CYvb3nnflE5Foe/zzm+IMlDecb/EXZsGzG4gC6GF8z0xmsNI2kpGtV9av8ZneTeWxaDyRRspvTvcDeq3S+LvyEreafbBmTGuzyBPah+7Ux/dVfpDdKMdN8sOLpR8hKk4BuuxRSyYT/b+jK6SfFuA/4FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483724; c=relaxed/simple;
	bh=vGFIatIHrLsxc3UubS7cgmZ+PBdkO30U+QEcBNjSiuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SXshJ+WZajXjhtkctPBuqePJtZIf8/USRBP5USYjR4H3X5YUTAE3UEClL6gSqxNf3YMRY9XNr4mV8IMMp7+GU3ZBNZIP8T6uwJc9CHBK/buimsnDlMjoxBWGMNncWfJDseu2NlWdkK4wQ4ODY3GOnQbWRvLppp2D//yRPBmxOss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=ZIluVEVf; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c15849aa2cso4836115eec.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 00:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1778483722; x=1779088522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kiaJrtraolgj0wCROKZyZgIfyemQaPI+nuWr7JS5sng=;
        b=ZIluVEVfZd+vZbvVxsLslpADBBfufMuYKF0HX0gKnMl7HL9FKpYBu14a9NqKemk2SS
         7tJlADhGl+LMomgqZKbtisK/TTeNwY770xGwmMHb0XcKdZO+roP05fWliSiw4M7Z1mgI
         W5q9U70b8ftLWqN2CAZEbxN4oinw2hGQQzCIem+b8aPP9DtNmhTFpEzqFyjWgi8X7fJB
         fngQfKcHruc7rwb5aMIuUG8TmwGhr7nyRCUOvn5H11/mcKHc+dtMGhkfZNBRfuLc/qJ/
         dxDfTvu8cUs8dRmA2VZ8sOr2tq3oIdf1GAWAG4fQ+XJW45TYSceiJBIK0/Xt8sxOXWia
         vkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778483722; x=1779088522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiaJrtraolgj0wCROKZyZgIfyemQaPI+nuWr7JS5sng=;
        b=VUA1dsC5I1BgxcqbY2qgcke7dCM9cVjgl8hNHwCjvaMmiQ57X7zzVypcAPuBKfEYbb
         HrhRUVEuKo+vGG90RulWDWd7+Jc0hFzrdWT5ju60N8xYrjxajJ8QC/p2BdoKPKvUiNrB
         AhXj/6JRahPrtwTdTYBeDV3FoGtUDRUG1PmldM6nSN0wue2/qAoR274KJyXixypaYvC2
         mNkUmg8LIP8SQWNVKk8NLv0bhHYOtA6FjB44kvufB0ddlenKFUb5aXLEANs8bOoWsnJN
         j1/vYwa2Yon7BqCXH+ngcOIcLZ9LE7f9rLQuiiXVduEY27MqFTXu1acPA9Au01sl8nxq
         0fVw==
X-Gm-Message-State: AOJu0Yx4s9IKhBlXPTXBZj4B92cfKb9n8Gp+xlMduy36Xkm9u+L6o+rg
	8OWIQREJOOkOD2R+peyIl+7z3Ht7A+2yWEowhQZayyGe+Fb1yrXZ8rieEq/Uspm+siPczdej4/y
	5Y0wxEM5x
X-Gm-Gg: Acq92OHChbLQGhAqMBJCL8bNOK+G3XtR8JG9Y8CK6VHddlecExBa/D5PRiCGbUE0KR0
	hI9nTZmhpTTay+fF86j/6KUxAMP5TqePcpyWklc33ItAe8UlEgCmvr2B4cYi+liWBfQXdEV8zbh
	FF3tBVGI5ajzXGLQMThxXy0voC/I5LSXD19Kaxk8AF5kgtZYBXJQcyiXdgfb9+i+H+jP4g5BQ/G
	KCmTINv1DA/FsJzTSIKKSKuf6ez9ThdcB9J5INrG/GJRwXDiB/PoaeawdE/AtijCtTUI5O0+rbf
	ZFMLuxG2CsJBVKD6x8ATiIFpcUQWNVB2gx0vCt6HTcMg9qf4aTOG+zy4GxRoHv6OJQotL5fzFce
	xjcOku2gNWds6bJY4iBVa7pssqAN+mGhDWaLWtW1h8UvANMQGSkVyJYNS0kRf0C9svaGgOa3B2l
	/tDDGNqr1aYdAMYBLGm7zx6SWzGtzRLGx/5TLd+OBeMOq9UDMVCa6GSg==
X-Received: by 2002:a05:7301:578d:b0:2ed:935:aa33 with SMTP id 5a478bee46e88-2f5482684a9mr10863021eec.5.1778483721640;
        Mon, 11 May 2026 00:15:21 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88885be8esm12501628eec.22.2026.05.11.00.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:15:21 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: fmaurer@redhat.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] net: hsr: fix NULL deref in hsr_get_node_data
Date: Mon, 11 May 2026 00:15:17 -0700
Message-ID: <20260511071517.3013445-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E8C13509210
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email,asu.edu:dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,vger.kernel.org,gmail.com,asu.edu];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286475-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[asu.edu:s=google];
	GREYLIST(0.00)[pass,body];
	DMARC_POLICY_ALLOW(0.00)[asu.edu,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.039];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email,asu.edu:mid,asu.edu:dkim]
X-Rspamd-Action: no action

hsr_get_node_data() looks up a node's address-B port and dereferences
port->dev->ifindex without checking the return value of
hsr_port_get_hsr(), which returns NULL when no port of the requested
type is currently attached.

node->addr_B_port is set by hsr_handle_sup_frame() on every supervision
frame but is never cleared when the corresponding slave is removed.
If one slave of an HSR master is unregistered while the master stays
alive (the other slave keeps it up), node_db entries retain a stale
addr_B_port. An unprivileged HSR_C_GET_NODE_STATUS query (genl op has
.flags = 0) then crashes the kernel:

  Oops: general protection fault, probably for non-canonical address
  0xdffffc0000000002: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:hsr_get_node_data (net/hsr/hsr_framereg.c:892)
  Call Trace:
   hsr_get_node_status (net/hsr/hsr_netlink.c:366)
   genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)
   genl_rcv_msg (net/netlink/genetlink.c:1209)
   netlink_rcv_skb (net/netlink/af_netlink.c:2550)
   netlink_unicast (net/netlink/af_netlink.c:1344)
   netlink_sendmsg (net/netlink/af_netlink.c:1894)
   __sys_sendto (net/socket.c:2265)

Default *addr_b_ifindex to -1 and only overwrite it when the port
lookup succeeds. The caller hsr_get_node_status() already treats
addr_b_ifindex == -1 as "no address-B port" when emitting the
HSR_A_NODE_ADDR_B / HSR_A_ADDR_B_IFINDEX attributes, so behavior is
unchanged for valid setups.

Fixes: c5a759117210 ("net/hsr: Use list_head (and rcu) instead of array for slave devices.")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/hsr/hsr_framereg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index d09875b33588..8018d5c0c878 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -887,11 +887,11 @@ int hsr_get_node_data(struct hsr_priv *hsr,
 	if (hsr->prot_version != PRP_V1)
 		fill_last_seq_nrs(node, if1_seq, if2_seq);
 
+	*addr_b_ifindex = -1;
 	if (node->addr_B_port != HSR_PT_NONE) {
 		port = hsr_port_get_hsr(hsr, node->addr_B_port);
-		*addr_b_ifindex = port->dev->ifindex;
-	} else {
-		*addr_b_ifindex = -1;
+		if (port)
+			*addr_b_ifindex = port->dev->ifindex;
 	}
 
 	return 0;
-- 
2.43.0


