Return-Path: <netdev+bounces-297165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I6kYG/xFKGqzBQMAu9opvQ
	(envelope-from <netdev+bounces-297165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:57:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5FF662AE0
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:57:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CRUSwy4O;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297165-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297165-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D96BF31FE91C
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCD64968F0;
	Tue,  9 Jun 2026 16:31:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0616F4968E5
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 16:31:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022699; cv=none; b=GIMdZ5usaV76Q5ucfADW3ugtBMyUfCJ1xFomDNDenZGwQVCFxHjBb/taT0lKf3VP/ZBjRLEScsjn3l+HKY8GtcI/W26RCav8SP1oJAhcxKZBZ2mDHV2tszH21WREjBsETVNQ1RuqRJV3nfto3idvIWCzFFkifU+Ecq5jya/dPfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022699; c=relaxed/simple;
	bh=w/92rqpxBcjX7hp01jRGc5Qwva6xnPaoYP6bbl5lgnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Peh6R08GJiNtwgjgJNg+EDh6g2o+SsTokC/SaIe3qMuKVKaW9tnGvycXOwPUJsrHqpTC5VMJB+rWbNAIrTSO5Al0BJP3vL9I2Qubh6auKwjrnawWYDMIDi2AGbNTPrgsove7rh4MuXHuEFRA44LApv58cS4mi2SxDYOA153bKy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRUSwy4O; arc=none smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so3610660a91.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022696; x=1781627496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBNB2vRgnwcfwhi+Xg0KULzMXGMj4ph1wDI4x7EyfeE=;
        b=CRUSwy4O/t3xNUyPhEyrv7OPqESyorVeQEJD+oWwOcio/w/TnfOyQv5QQW5N+QBr1A
         eywfhgBY0YYydFrTwHIhAJep1EWhRlkwGgCFaTJWlu434C6dS9ePP5xe3U0gDh/kgqT4
         JlctWmRcil+F9Q69tSWTTuQeg9d/f9Es6W72/iO1UGblIf+/VYFYffZdBAksLUxyDjLT
         FTKU2BmIRcXECpfuHVfudVl7FAA5X6zvCvoXPQL0G7UMVaWCQmYVmssEUp/SVVc7B4No
         EwDq9eCVd/0AotyjxPyt9ITKCuiClSyKz7sDota1ssHJShoCvdD7c1YXdjo3Rc5o0hrS
         KlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022696; x=1781627496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZBNB2vRgnwcfwhi+Xg0KULzMXGMj4ph1wDI4x7EyfeE=;
        b=eqtEWGmhyLCl2gi1qyzbhgiGHEXagmWV320QllPrNWR1y5eHJVScfjKUcSWqaVLpXK
         hyRjIoca2eTj//LB+9DfDOHcCmkCITs9XUcAcjefuzbhqMeldr8LymC5+TV/dU18KM2b
         mVl56k10H1olVNI2vBlxj6d8Gj5wqkqBFumHON/lV2EcygiQ8GWNdYHLscMpTkbqfC5c
         T+MSDwnpuA1gKjJ2V/mjriNOkDnH+ts8HZBiyJkVJLuo0qeH701MStO3n6XeYh4WIsn6
         5st0+4+Ti1gNmFRHylzbCHyXDriIxh8R1gtH4vSfM45nbao43I5sveoHk7d/U6T5WA2d
         3pGw==
X-Forwarded-Encrypted: i=1; AFNElJ/aal5sHyC1N1fcx3VRbhkTxu3UmIT/IrH+bIZah1eMro0IwCrTwIzHYzs70vTwKcRFkiM4/pY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu7c2GTCvnpG0JqzwEIsYiNi0+MY6rHayrYBD4kP0eGEbLIGUF
	QD6NhGyGODHYS4iVz00pfrxZzAHYaRyat3QfulB0E+RBSE9i3PhEsbcn
X-Gm-Gg: Acq92OGVku/JXoXLrvp+mQhu8csP/41tIg5xHf2L9YEf5bQCxEsJIgKE60Uf5W1BdmZ
	sUcZ4OhDBbi7WSRd1ZUL2cowiT96gBXq5tgpu4d+IVY0OFBJDAkiG7NMwqynio8xJaW/UbWrA18
	JQU2RXAe9Zu6+8pdN5bqU9SQWEYPARFDIsyZaQ6YTgwmLZ8s+a2jGkbeoU3AWZTidV1rwaHJ8Bq
	b22rPYMmEZF9OJi0qO7z3PMhjIfbdvmzJEmmsLAKSI/nk8X3QC3jwi6RmRx8YBmMH+mYJSY0Xkd
	P8yBkGPQrN44XYNbagCYoeU+EDrcUkGBkzw0XbG7bYvQGQVnwD6Zs0qwKaj+wz4hCy4A+/sG6vC
	OUrz6lJFfpxocH44wkI8PlSeovwb59sqdFSJqSPxDk6Y2QO1eTe5EseKVaIecIASHQNAG4qSsEc
	JPl5H8zzmBva8aBfgCAfRb+Kmk+a1+Q44925OGrBJaMzO/Ubf1kI74x23qpEI=
X-Received: by 2002:a17:90b:3ec6:b0:368:5367:d679 with SMTP id 98e67ed59e1d1-370eeff5ea4mr23914086a91.9.1781022696271;
        Tue, 09 Jun 2026 09:31:36 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm227710195ad.60.2026.06.09.09.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:31:35 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 5/7] net: ip6_gre: require CAP_NET_ADMIN in the device netns for changelink
Date: Wed, 10 Jun 2026 00:31:08 +0800
Message-Id: <20260609163110.1717419-6-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609163110.1717419-1-maoyixie.tju@gmail.com>
References: <20260609163110.1717419-1-maoyixie.tju@gmail.com>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-297165-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:shawleon@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,secunet.com,gondor.apana.org.au,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD5FF662AE0

ip6gre_changelink() and ip6erspan_changelink() rewrite the tunnel in its
creation netns. After an IFLA_NET_NS_FD migration that netns is not the
caller's, but the rtnl changelink path only checks CAP_NET_ADMIN against
the caller's netns. A caller with caps only in its current netns can then
rewrite a tunnel in another netns and pick its endpoint addresses.

Gate both ops on net_admin_capable() at their top, before any attribute
is parsed. The check is skipped when the tunnel netns is the device's
current netns, where the rtnl path already checked the cap.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 690afc165bb3 ("net: ip6_gre: fix moving ip6gre between namespaces")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv6/ip6_gre.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 365b4059eb20..829388d7b870 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2047,6 +2047,9 @@ static int ip6gre_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6gre_net *ign = net_generic(t->net, ip6gre_net_id);
 	struct __ip6_tnl_parm p;
 
+	if (!net_admin_capable(t->net, dev_net(dev)))
+		return -EPERM;
+
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
 		return PTR_ERR(t);
@@ -2266,6 +2269,9 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct __ip6_tnl_parm p;
 	struct ip6gre_net *ign;
 
+	if (!net_admin_capable(t->net, dev_net(dev)))
+		return -EPERM;
+
 	ign = net_generic(t->net, ip6gre_net_id);
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
-- 
2.34.1


