Return-Path: <netdev+bounces-297957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V0YDKIdVKmpCngMAu9opvQ
	(envelope-from <netdev+bounces-297957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:28:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB2566F059
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:28:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=l3RkNECM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297957-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297957-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A655430066A6
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BE8360ECA;
	Thu, 11 Jun 2026 06:28:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BE835E1B6
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 06:28:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159301; cv=none; b=kRHwXtI8heI0JTOprQ/osgcBvaz+nu43r/esXlytZOdeyNjIycqe46Gb4wUDfFF11DDflVMeOfdb9kUUzUyETuRmUFfVwwOMnO30sfZV80qUW075ddtw/wCx6IiFKtcBvWkHGfIIUwCqcO+eUyQkM+axL/uynA8g+tXNH83PpkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159301; c=relaxed/simple;
	bh=ABoF11LlsjDImEw0o01Srl9sxas+dXW8rwIo0VibxEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kiq+7arRwktqzsP/FCUQmbCanB0DzopxFiZFd6+b1BqnXSGeVvdELOqcgxlX/XjQAPuFv14Mx+DYDUcrs6Z28Qd5XpNyCDAk0oOScEJtfxuC5Zh9zwCsUtNP3pG0nEv9ZHfJ4Hb+zPjbGs9P0gqd3PX87p+weOZ7QzcIWKpa92s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3RkNECM; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c168baac83so36184935ad.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781159299; x=1781764099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FKHDbTRgcEA8qLlfBQUFErqZeMY2tu7A8JF88+7Bp4w=;
        b=l3RkNECM5FfUFpqSDDFIUENv3a1Eo2a+uYFO2u9U5X9a/ASFmNjDmfXR3O8RruskIt
         dkUTgYtzny5JquUyprUQ58nqo6ptMOHQ+ybSQUla1pTeWoy3PVrQ//pcbl7jgo68KpZj
         QmxIR/5aSScusWaDxczdO21WZMZHKY77aMYWSQ4yKxYKt2uiqmuMiJVtVoeSg5lWmKak
         W8pfbwlqyZoPa1Sa+cjtws5xaPFDSJRQO3oF9lO7LTb/6mPn/9rwQTb6yLUmpGDaXoO7
         0TBAExRREgzy+Tc7rAmLBtgMpOFFIqjdtg+P3Evs6K4klB5/WZMB7IMqdSVyiDHA0ZlX
         OvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781159299; x=1781764099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKHDbTRgcEA8qLlfBQUFErqZeMY2tu7A8JF88+7Bp4w=;
        b=F+i58FwGGPE0Df1HMdlbHMlMS70K5v5QvMRIRxLJYShRz6VHU31MeVW8U8Sg6XQPE0
         RBRwcth6Vhiyuun1rUkUr9VgTcERmfj1nzRmj7z56ZSMoX+Baf52h300jmhSTGH28Slh
         wtz/Gotc11r11Tht+2LZ3+qkAdzO8G/FWsI6ZfwVd15g0tqlE0cLPsu7xelxlOXlxWLj
         pTwbvD1tVKR614OvJi+EqKbzOAT0KBg9FPUBjpGcEu7M8BhELb9yqRusnOnt8DomoArY
         KPrUGWdUoHd9/VYlEILmVehI5cT2IeKRPMGlFQq5Y9oqfwWYr2Hrx9LnEeKVtMVopPmA
         4oXg==
X-Forwarded-Encrypted: i=1; AFNElJ/6+69fDD5eW8wA/RLYzWxSK9NaosYfSoYroOGg92LxFqSBOPW/IvJvi9IwuHGQTvwwmJxmOa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV4A0wsd/PVtLJxvFxPTDu3O5wHtkW2/KqnrZP8Mq8FFeb0MFx
	z8Rgjuf/cwL2eXN26ue/V2g3wUhomkw7dBo8dR7gux/9ohjCtJSmi7zr
X-Gm-Gg: Acq92OEwQi80y0Zew3O59lh7nAMl2LbZzUtVHenW4MgNmHrDRigQtxUp7r19xOeYSIw
	mpt1nPxBZfkiAOsgfWHT793QXDhud3XSNhKXnWndi76f+4gjixJUvFG4kBC3pIC7xsCNEADSs7i
	ZLS8rgW/XO58zkcBnf6pMffH8VrUuBA2D9opOLeoewZULZJN272+j39Q0EdTGueskxZRGd5Nbk0
	GcBqnIzdN9Ed0MDxMWUSUaKpNsgb1A78sCH4EevlRGTnsS1S40LUxgLUz40JBA6J3JZBHPQT4QN
	bXefNPV0ucpFJqcZXR0XtZy5oEMtYcZy7ufoqFwDQPYFS9dknjjnV8tTPbA+TWq32Dj5osvZ9VV
	5T/vAiwNlAalm9UTsO0BQpJxU3iSWUfd/rok3KmPPtzEigoLnhMfd3jMz+j//2UNV1zJPiGw2/5
	2CRtQo2WHW1zWXUkHqHhtB9yQHX2IPhPXc9cpr32YOWcHgIsa3TeqUvhcQobU=
X-Received: by 2002:a17:902:e88f:b0:2b0:b016:773f with SMTP id d9443c01a7336-2c2f10174dfmr15989465ad.11.1781159299332;
        Wed, 10 Jun 2026 23:28:19 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm282891565ad.1.2026.06.10.23.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:28:18 -0700 (PDT)
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
Subject: [PATCH net v5 0/7] net: require CAP_NET_ADMIN in the device netns for tunnel changelink
Date: Thu, 11 Jun 2026 14:28:07 +0800
Message-Id: <20260611062814.2528793-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-297957-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:shawleon@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,secunet.com,gondor.apana.org.au,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ip6_tnl.net:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BB2566F059

A tunnel changelink() operates on at most two netns, dev_net(dev) and
the tunnel link netns t->net. They differ once the device is created in
or moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in the link netns can rewrite a tunnel
that lives in the link netns. Commit 8b484efd5cb4 ("ip6: vti: Use
ip6_tnl.net in vti6_siocdevprivate().") added the same check on the
ioctl path. This series adds it on the RTM_NEWLINK path.

Each changelink is gated at the top of the op, before any attribute is
parsed, because the per-type parsers can update live tunnel fields first
(for example ipgre_netlink_parms() sets t->collect_md). The check is
skipped when the link netns is dev_net(dev), where the rtnl path already
checked the cap.

The check goes through a new helper, rtnl_dev_link_net_capable(), added
in patch 1 next to rtnl_get_net_ns_capable() in net/core/rtnetlink.c.

Tested on net/main. For every tunnel type in the series a migrated
fake-root changelink is rejected with EPERM. For vti6 SIOCGETTUNNEL
confirms the link netns hash is left unchanged. Legit non-migrated
changelinks still succeed.

v4 -> v5, addressing Kuniyuki Iwashima's review:
 - Move the helper to net/core/rtnetlink.c next to
   rtnl_get_net_ns_capable(), rename it to
   rtnl_dev_link_net_capable(dev, link_net), and drop the kdoc.
 - Reword each commit message to state that changelink() operates on at
   most two netns, dev_net(dev) and the link netns.

v4: https://lore.kernel.org/netdev/20260609163110.1717419-1-maoyixie.tju@gmail.com/
v3: https://lore.kernel.org/netdev/20260604125055.3254652-1-maoyixie.tju@gmail.com/
v2: https://lore.kernel.org/netdev/20260601034148.1272080-1-maoyixie.tju@gmail.com/
v1: https://lore.kernel.org/netdev/20260527070824.2677331-1-maoyixie.tju@gmail.com/

Maoyi Xie (7):
  net: ip_gre: require CAP_NET_ADMIN in the device netns for changelink
  net: ipip: require CAP_NET_ADMIN in the device netns for changelink
  net: ip_vti: require CAP_NET_ADMIN in the device netns for changelink
  net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for
    changelink
  net: ip6_gre: require CAP_NET_ADMIN in the device netns for changelink
  net: ip6_vti: require CAP_NET_ADMIN in the device netns for changelink
  xfrm: xfrm_interface: require CAP_NET_ADMIN in the device netns for
    changelink

 include/net/rtnetlink.h        | 2 ++
 net/core/rtnetlink.c           | 8 ++++++++
 net/ipv4/ip_gre.c              | 6 ++++++
 net/ipv4/ip_vti.c              | 3 +++
 net/ipv4/ipip.c                | 3 +++
 net/ipv6/ip6_gre.c             | 6 ++++++
 net/ipv6/ip6_tunnel.c          | 3 +++
 net/ipv6/ip6_vti.c             | 3 +++
 net/xfrm/xfrm_interface_core.c | 3 +++
 9 files changed, 37 insertions(+)


base-commit: 512db8267b73a220a64180d95ab5eebe7c4964a8
-- 
2.34.1


