Return-Path: <netdev+bounces-298534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yfEyLxjLK2p6FAQAu9opvQ
	(envelope-from <netdev+bounces-298534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:02:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19894678066
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:02:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cwrQt5Cy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298534-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298534-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A62633FD3FC
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1809037C0FF;
	Fri, 12 Jun 2026 08:59:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F9379998
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 08:59:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254796; cv=none; b=pGIJLnYKO95NKY/AWT9LcFVS7So9SYQY8M/5wA4o+50K/N5vx2UcJhLQ2L5kAAZdPgfTZVv37YW2dWUDP35ApHf8BZFU9JRQQs0VndNNyPwkuJX07sby4SQ5YwiXgTAtl1Z7WfvGGZ2KP0CHqNa80aqRvo5sWsWDPRgaqAOwfLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254796; c=relaxed/simple;
	bh=9KELg0fF52vLssDqyULifU6gVEgt2TGPTvM2ovfjH+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AtXqcgqiyEfKu71laUHcnxSQPPZwXq3yuXvs13NYMyYZQcwe27U/GCuYSkaolX1m1mfTS6Wl52P5H1B6mGSJTI7QgWLGe7oV1NBDUh03VrDwuQtIzVoWxHaql7hQJdfqsiCKfmyuNubR4aKJm9tkWMVQK1RH2llLQyBLhyk0neM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwrQt5Cy; arc=none smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84275887a3fso1291757b3a.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 01:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781254794; x=1781859594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kTdniclDK6QIUDXwqEIxG+i53yHxIwhyl42LN144xs=;
        b=cwrQt5Cy48rJw6j8NEME6vSlVcJkPUcy7s+siaCuqjQkkEWZjhqboaOgN6W/r9t2Pl
         5xGQPwVxN9zwx8whdTJHHnzxqM5qe7MW/lFAZ0UJK0hXkxovaheirgUf5hWGSV4PI/0G
         Ojx1/jqByRt0sJPAwrlUtEZOUYcH8I815lQnTJUhvmmddOTSS6o5/KlyDHZ0TOKwqeJS
         yTD//4Gdp4TqvsTtQlku8hMU/RH8cnam35uXQDPQjIz065vB0j9NgHuT20O+TzbPu4ge
         i9uk39ycsnJX3t5lqQbs1RIkG2npVhMEXtdRHuEMHjSH9Jf3Gk3H9xyxBjWXXIfrxgvq
         fibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781254794; x=1781859594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9kTdniclDK6QIUDXwqEIxG+i53yHxIwhyl42LN144xs=;
        b=mQuH7h2VyxqY61L/9ZJjQKfccflh3aoFksNfwwWHCISbLdf7w4YZQHJEUroryhbrEM
         /meQkw0aHKIiCy5Qqa2bkBwcRqsbDcWbqsZ809NEwLdHRjSy31lUXgnMwx787YElX6ng
         W27d39C4hjY881KAByRaL2cD2zKBvvqbEnRA7Kg0hh+Y2HmZtmaHe5+Bn2yzsbUwQlO9
         nOb2VtsG5zv44cYD1BvvjLdg0HFEwzXUnmXfc+1WaOJDSKLBirdT/Y9pm6E1TViPD692
         H4SaAb8oVaA1hXmVzEMqwr+UuupE2y7xK+OowyCx9Q1OL31tpBtS5ZcwDcvKmYm5DkDP
         5v7g==
X-Forwarded-Encrypted: i=1; AFNElJ+C0ZnizgpX2VoxP5rOEH1ZKve7u8G5RDRlItQqzfi1RRuaIBpJf7CAqOvBO0R09zBKoLUrTzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnerkbBvSmjwqHKdhaaQe/wJGFWSGYftMB07OT0HtXpyY5eFSb
	MhlWlBMhBSJzcckJQvGf7rl2pDTD+tyOm6eylLE1oHoLrKDvKNSvxyVi
X-Gm-Gg: Acq92OHyAUlfsKmM5J7fjZN9z2UMjxuB95DYA3Qw0HdiPPM/4Fl5pNUjcnevTzHjvFW
	vC1sePh7CCUjTEMkzGYzqJnm97NJncF3l39bRs5RIgbZwqQ1ivMCzGi1m5BjjH04I3mtOTynN1h
	NzRwwD8xu19AbL7nOQmM2a3VWit3b0cXda6QkhBinjeUhIg1X9aDJ0gtsHzR7Luc+IEZIAWnUmG
	XRCkhfJIh4WNOOARYDXrnSXvguFV0Gf7SYwq+5vpojYGScePswegS+r5qHA+kJrjv4axPNLtqBp
	dCkr8wiCit2cSMrrjPUQDnZkw61Ezj8Ns3Be1+aIql19DuILr32rGo0jH2hZ5es/hylAfD+ann/
	+dygtK/cJe3OxQWRVVl5Y1Wzq5eXWiQ87SC1s8HIOQcelXU+U8Ie1r6o4kaQWM27DTKaQN58O3P
	x6BlXq9LOO/ISVw2mYaKXXQGw4XqvG56/FsXTOEy0o/p7nXkMI
X-Received: by 2002:a05:6a00:14cf:b0:838:5145:c1c5 with SMTP id d2e1a72fcca58-8434974f482mr2183604b3a.21.1781254794144;
        Fri, 12 Jun 2026 01:59:54 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434a934a97sm1646892b3a.0.2026.06.12.01.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:59:53 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH net v6 2/7] net: ipip: require CAP_NET_ADMIN in the device netns for changelink
Date: Fri, 12 Jun 2026 16:59:36 +0800
Message-Id: <20260612085941.3158249-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
References: <20260612085941.3158249-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-298534-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixie.tju@gmail.com,m:shawleon@gmail.com,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,secunet.com,gondor.apana.org.au,google.com,gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19894678066

ipip_changelink() operates on at most two netns, dev_net(dev) and the
tunnel link netns t->net. They differ once the device is created in or
moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Gate ipip_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 6c742e714d8c ("ipip: add x-netns support")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/ipip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index ff95b1b9908e..e7378569bd5b 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -494,6 +494,9 @@ static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
 	bool collect_md;
 	__u32 fwmark = t->fwmark;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip_tunnel_encap_setup(t, &ipencap);
 
-- 
2.34.1


