Return-Path: <netdev+bounces-297962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ENK2CnpWKmqSngMAu9opvQ
	(envelope-from <netdev+bounces-297962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:32:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2A166F0B5
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:32:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cxAjv7Nr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297962-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297962-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68EB2324AB48
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2623636308E;
	Thu, 11 Jun 2026 06:28:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A366F3624B8
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 06:28:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159319; cv=none; b=Y3zLu4gMdm7VsbobDru1apps5HrwZvQja+bTGShSR0LVqBsqxW/F2Iq+xYPf/9t8zVJwCDP5qx3SSVGWfWjovxqX3gKbLTOQCDnxeH1akSt17sHAkwY0O2iuuTq/wLYG5/BJChZrph0Ecnhv91Qc2qeYT5z2a6QwgqbcEoI0xcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159319; c=relaxed/simple;
	bh=P3DEwMDSz7QrnY6Nl3zghY4LlUKgR9E6EOx71pAzN7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mG6ombI3Ccp1q/ebpbMxHp7Gtm4jw5ghZmc8E4LssYaJFbvLGIyRLNV2cOwliIddcbKNb+bFY6TACfTERfwm4QA5Yet6f77lRn8DLh58cOgvwM1CNaPULDJuW23mF23FUw6R+b54RcsyrSti0TlLNNlNxZLM8Gg5jD2JRixbEM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxAjv7Nr; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c3543590so51317595ad.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781159317; x=1781764117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql1o+3bWl8+fth8gszVm+RpfzjR1vuCSvpffdbii/uk=;
        b=cxAjv7Nr/E6arf+wm1ermgrqZx26ssFX5tZvwulkODhW/OPkNeQIem+Amq/I7X2Dmx
         +wqHHT0R288aAKRoUIEBqF9Nc0l3VczCuIMvc5vZMlXinwj4msp+YeHrrwfRDZ/lJgn5
         dutNiotCD05zCM4V4CWp645k893TFKTosoTQayMThTO8cN9WJDT9TPXxFv4k1KUqpvom
         2qyFRyUk8ih5iIiUEDoIHn8yS7pWAlqzpOT1RguHDObZf1iApV4yjvxPKpknPEaL6LDL
         nVOrXUiauaKTztJmoRTmbKuYIeZ1tf1MTQn7Puw2/N4j4cVTrd/aA7GHpg3W0OPPNbIo
         XUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781159317; x=1781764117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ql1o+3bWl8+fth8gszVm+RpfzjR1vuCSvpffdbii/uk=;
        b=hBajK1CpjykShC6A3e1Wb7npuUB5soRuoXN+sAP+rzM6Vjx1EWD2v417gbYlHfrOQ8
         2GM0m1kgUxOrfASG7AodkbwoCz8t6QO2wG8e6ZLwEHC0gt+VurNTy7QeonlIkvBRtu5D
         fG/lgtOl8OUIiiO+9ka+ulDd09vG6Javf8/u0p5S+PaLlKtTvJNkobYK1rBbpmdrjwz6
         0ssC+vj+c6jnsAHo+AFMua/NtnvwGznRm/wIgPVOzbYtDCz25osMuv8bS2WeRkWD589e
         IEWvfwm/niL8FJuSl98Qf/Au58p4SKGM7y5Ac9tb703iLkWsW+o8iHc3ReFIhWtZP7jV
         o2fA==
X-Forwarded-Encrypted: i=1; AFNElJ/g/I7GdtUPd0gIPu82FWrd6fUDd+5zUsakp9dMptFem856GS2FvKDBLXMCRhOnSrY5BPb0a1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKCRZPNsFc2JqrnlIxKqxp826vGthbLXwLcRHmMa4FTLtQiGxA
	C6YBwI/QG3Pm5fh+eESkwcNlVwA+0tQk+ds+7od8+gd14u9jA4AXRynGfAcosQ==
X-Gm-Gg: Acq92OGVoQ9op4RejfTFVu9nc+9Pv5Z/6Em8ImXQwnt8IJZt0NLeOZl5iOC6qwSvXb3
	9pWDBnerFCfB/ao/Uh5umdtBRGMgnm+PqGo2QsFRoIY2sVqX/25poOiycBsbjAnkmZgn741Mwte
	cSXdshdBxZ+bj4rw6PwcsNOu8QzF0PQG/bDocwrZX6qH0WGEgCoaDMD53S1x8lrvc13byZU337I
	KEB6qqfj2rYsqeXyvT8xxPYU00rckU/LyqtzBauFQzF4ZXZlHiv1mHELMtVVhIU1LuLuCad4keK
	Ln51lAQmtyraaAoJJjjLhIMFRLBMMUGuJ2WP1n68FVVzBekOm+FLM8esWg1jGuXnVGhMbZlai9C
	J5lxXSAx/JtPEBsUiZqPC8Qi6yXVLLW5PZ0/iSy5RJDxu1imXYm++pEGQ6Q9UjrNCt8p0/laqPT
	b0WaIshb/abHuEmli+ACOF0ekDIY9rpk4aD92Ox9g2QTiUh/2dj0GDfy3Qc7Y=
X-Received: by 2002:a17:903:2385:b0:2c1:d49c:8398 with SMTP id d9443c01a7336-2c2f005eb1bmr18921125ad.8.1781159316899;
        Wed, 10 Jun 2026 23:28:36 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm282891565ad.1.2026.06.10.23.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:28:36 -0700 (PDT)
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
Subject: [PATCH net v5 5/7] net: ip6_gre: require CAP_NET_ADMIN in the device netns for changelink
Date: Thu, 11 Jun 2026 14:28:12 +0800
Message-Id: <20260611062814.2528793-6-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611062814.2528793-1-maoyixie.tju@gmail.com>
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-297962-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:shawleon@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,secunet.com,gondor.apana.org.au,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: AE2A166F0B5

ip6gre_changelink() and ip6erspan_changelink() operate on at most two
netns, dev_net(dev) and the tunnel link netns t->net. They differ once
the device is created in or moved to a netns other than the one the
request runs in. The rtnl changelink path checks CAP_NET_ADMIN only
against dev_net(dev), so a caller privileged there but not in t->net can
rewrite a tunnel that lives in t->net.

Gate both ops on rtnl_dev_link_net_capable() at their top, before any
attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 690afc165bb3 ("net: ip6_gre: fix moving ip6gre between namespaces")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv6/ip6_gre.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 365b4059eb20..8ebc99a299c9 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2047,6 +2047,9 @@ static int ip6gre_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6gre_net *ign = net_generic(t->net, ip6gre_net_id);
 	struct __ip6_tnl_parm p;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
 		return PTR_ERR(t);
@@ -2266,6 +2269,9 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct __ip6_tnl_parm p;
 	struct ip6gre_net *ign;
 
+	if (!rtnl_dev_link_net_capable(dev, t->net))
+		return -EPERM;
+
 	ign = net_generic(t->net, ip6gre_net_id);
 	t = ip6gre_changelink_common(dev, tb, data, &p, extack);
 	if (IS_ERR(t))
-- 
2.34.1


