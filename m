Return-Path: <netdev+bounces-191515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3349DABBB37
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BFDB3BB90A
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FA41FBE8A;
	Mon, 19 May 2025 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3TcxBwS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2581EB190
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650732; cv=none; b=U1NdbySnBPMCOyyrlLqzPqHcB1zHE8P/5FgkKituBXTcHhxAMQCLHgP+0ZxmRTdZ3oXI6fcQ+60NcRnSESngh7LWSpThDGbleqswikIbH0AzqiDgBJZFlaIbn/zupamjGk7PrsPjU6SrJcw3mHa7SOaB9WnDi65yjLeWqPtSxEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650732; c=relaxed/simple;
	bh=heVVrzr7upRdLwcnKeTKuQ65Iq0XaBFntogT5dJAnu0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XDQT9bCsgTZXxujL9+W7jSOk9XDe+NF2IcZ2XafPJGIrC9OCfDZjnF8R2F/4mop2rtOQN6NHrfhiqsib89WbojcjbqnbnT43DMxBE/9RwAL+S3w9Lb6QO53iNOv5HDSQHptPcD4EuUKn0KCosYgzZKYi7odzGcKdhl/vWITxZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3TcxBwS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742c73f82dfso823942b3a.2
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 03:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747650731; x=1748255531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=doFhj/tFASXejX5nBETInlDqJ9qy7Ivn4NT9HRbgBgc=;
        b=P3TcxBwSje9SCBY4MDhb3f+SBmm/ajl8LiK0u+1wmXmrIyd3wJDNPvclRoppmc3MiA
         ZSm22d1NafKTRw6N9ecIdfBAjxTT+624S7tJvA/VgYQj4eA1R31aQrveK7KukBbGbH/j
         vCiUzMfPkfl8Ff/+tZGN3BoMMfa3nJedso7ROeWzUWhnRNmCSemz0p9Ww0OclsGGSoQw
         E50i+rrL+2ZKjHPvKjzVGlcSL4VTElQQf07yfsfKNb92s1J89kxdKZl9Nceuwi/VWKpF
         JsatH+SfJo0XOMRrxkFWroIJka0hKJcdOsKDLsTiSLl04WwqPGIQ7bjS2iVUHMd5fkhU
         S+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747650731; x=1748255531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doFhj/tFASXejX5nBETInlDqJ9qy7Ivn4NT9HRbgBgc=;
        b=jbVKJQYETifmbYBeqlMXBXO5kimaBnpd4yBuxrDb7szujfjeD1fJK7nZt3NFuLWmlj
         cQREnFWnZIp+yvOv7Q5zGbjn5IneeG8Q+hHTzaphHGvm+JhTdRmhhTbgdj+HgfsACn56
         Y0cVY2Wt+JNcIq6gFjzRA7sYbxtuMtZNS1LTNkFmPYlwW72Ywgv6ekAbezBomrffC4ts
         xDH4/UjG2zCe1Q/+4ASi0ybLO60+7zT8R1MkXl6XXlpHvude0MfGIFjjPovbHt/ia7Eh
         RWVRkmP10HZit1rTIEicZIoXxht7QpZgzRciFa/iHb6Xw5y/Ra5lUT1DBc3FYgNFoOEN
         pP9Q==
X-Gm-Message-State: AOJu0YxyKbISzU1mjto1oBA7WthSS+22Ld24nYfS11HP8oMCAIYQsHpa
	C/hlMTEZaBy9W72RmA9aze8UnnLDRjubJ/6Jy8iIyVJQyfW0UJ5QvNhV
X-Gm-Gg: ASbGncv4EVvt0eZjqbWG8GssobKYZHQFzALjiV38v/9V3hVktAmQAH66/sUyDOzG1Dn
	/ORMUgctVEZuQ/qsr8d/lNBSuwIuMYecgNozi5Onj2kM4FcrjWz60OqH9rlCLC+Rlq43Vw3uH0d
	nYIEAbTgXLGXnoCwImPlu5JRToGdtxPHp1je1R7lUozQBKs6SnreOL2fzlkMTMWBVOTVnCvHf+X
	SvA+d6TRmVqS9ZGOy1J8UFy3uouityb62X4tQUpVQxeAh4Ospqam7VYStuunw/9SGRyelsaJA1B
	95dx1RX48S87CENPNsswBNtLvTS8h7F4/UqlPhq0TfoKLjhEMQsaWCN35dDic0iUxrKY
X-Google-Smtp-Source: AGHT+IHtMZJNoGSPDqDBJJjXfrzyeaVXO2biuIQILDIm042Dfnt8bDL+8zzA4jYWSDzDQYfIokDoMQ==
X-Received: by 2002:a05:6a00:a88f:b0:742:a77b:8bc with SMTP id d2e1a72fcca58-742a9775102mr18248084b3a.2.1747650730523;
        Mon, 19 May 2025 03:32:10 -0700 (PDT)
Received: from localhost.localdomain ([139.198.112.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97395adsm5817872b3a.75.2025.05.19.03.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:32:09 -0700 (PDT)
From: Duan Jiong <djduanjiong@gmail.com>
To: ja@ssi.bg,
	pablo@netfilter.org
Cc: netdev@vger.kernel.org,
	Duan Jiong <djduanjiong@gmail.com>
Subject: [PATCH] ipvs: skip ipvs snat processing when packet dst is not vip
Date: Mon, 19 May 2025 18:32:03 +0800
Message-Id: <20250519103203.17255-1-djduanjiong@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now suppose there are two net namespaces, one is the server and
its ip is 192.168.99.4, the other is the client and its ip
is 192.168.99.5, and the other is configured with ipvs vip
192.168.99.6 in the host net namespace, configuring ipvs with
the backend 192.168.99.5.

Also configure
iptables -t nat -A POSTROUTING -p TCP -j MASQUERADE
to avoid packet loss when accessing with the specified
source port.

First we use curl --local-port 15280 to specify the source port
to access the vip, after the request is completed again use
curl --local-port 15280 to specify the source port to access
192.168.99.5, this time the request will always be stuck in
the main.

The packet sent by the client arrives at the server without
any problem, but ipvs will process the packet back from the
server with the wrong snat for vip, and at this time, since
the client will directly rst after receiving the packet, the
client will be stuck until the vip ct rule on the host
times out.

Signed-off-by: Duan Jiong <djduanjiong@gmail.com>
---
 net/netfilter/ipvs/ip_vs_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index c7a8a08b7308..98abe4085a11 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -1260,6 +1260,8 @@ handle_response(int af, struct sk_buff *skb, struct ip_vs_proto_data *pd,
 		unsigned int hooknum)
 {
 	struct ip_vs_protocol *pp = pd->pp;
+	enum ip_conntrack_info ctinfo;
+	struct nf_conn *ct = nf_ct_get(skb, &ctinfo);
 
 	if (IP_VS_FWD_METHOD(cp) != IP_VS_CONN_F_MASQ)
 		goto after_nat;
@@ -1270,6 +1272,12 @@ handle_response(int af, struct sk_buff *skb, struct ip_vs_proto_data *pd,
 		goto drop;
 
 	/* mangle the packet */
+	if (ct != NULL &&
+	    hooknum == NF_INET_FORWARD &&
+	    !ip_vs_addr_equal(af,
+		    &ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.u3,
+		    &cp->vaddr))
+		return NF_ACCEPT;
 	if (pp->snat_handler &&
 	    !SNAT_CALL(pp->snat_handler, skb, pp, cp, iph))
 		goto drop;
-- 
2.32.1 (Apple Git-133)


