Return-Path: <netdev+bounces-202511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4941BAEE1A5
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7EF16AAF6
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545F828F942;
	Mon, 30 Jun 2025 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Adl6fq9x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com [209.85.167.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7D828ECE5
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295368; cv=none; b=iAHyUIeEKly6HVn/8fA+mjE0V4HCbi8V5LFq7Uh6E/o3wDOu1KPXsWTNjj/yrY4qWerFlCEQBIvYbbbpAOL4ouOE62b5rYW63KUt8BwLUYvu9EmLvxhrsmeulDZnMhYUe8tsQx/ZnwMZ3WjkCazxL7t685TXQi8QOtsLLz3PSUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295368; c=relaxed/simple;
	bh=b/MLUTvAHWDKsti2t5RDbhiqLp8iyT2sUofs2jAYVyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sHBaMEj87cbivIeSZq6+CYonfFwMTllBTmtjSUcfZy2/h9l7ZgDfDVcUf2i7+5L5+ulPlxxPaLpFAOS1pmn3w976fdqA9yKIxaz7SQlTkp69BEZzfjU3jNaVQ0EjdQQDbbihrbpJ1exmfOr16YRsCSZPSIdS2LEvuqhjP0RS3FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Adl6fq9x; arc=none smtp.client-ip=209.85.167.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f100.google.com with SMTP id 2adb3069b0e04-553aba2f99eso552899e87.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1751295364; x=1751900164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ifg1M7lXXgjGKUsbjpe4LWLduI28OaQlYi+QefG8F/Y=;
        b=Adl6fq9xKfVTfoUhnmOVGz8+r3Boed1+GzIgJCS3FYtcdU5kleNfEY/yvsRXmGggaa
         l4yDQmDYwy3OxW2PVst1oN97SfYeXBDONMLfrFyXOUGUQKOXUFbRvIx9a2Dn7IopilZC
         jUGCcdgXq1T/jMOIKqBOMMcJbrNg5bYZkSHuhaUgTs8GHr0Y3TetUSOakp/EhRDj2T6P
         wdXn2ImIRPyOdC3WkgE6KfszcucEYymQZ+om2ogPuufrM0llBTBU3FEzPlMLMcBiJU8L
         w1dwsa94nCUwcAyd6VWnf9636CuwjZWx+L6Z27FGCzTKn+3L8ktczaP8Wt0Mf5fgDNkb
         vGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295364; x=1751900164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifg1M7lXXgjGKUsbjpe4LWLduI28OaQlYi+QefG8F/Y=;
        b=U56UPY2tWXQXb2tz3DrHrUdiS3vTnP/sRRmiU7E2cKmiieSjmv8oMw9aJS4o7nxx93
         ZK1jvGJ/9H1vgpG3MOslbhVKJLpxmmmHY57Bou3Ab8t9foFCZNmsmimHjarD/PeoTphs
         m/eJCQbLiZAUEeZMt4umzBp4g1wpXyNQeD+MENberD/KpobsLM0uHFa2BiObqvLvAumm
         OS4biExd0Zc8xlm00r7D1ueisGVQMOL1BKS2FEW+spAC4DzeLazUOS+ok7+nYqeqjgAJ
         DGllb8/qVUAXQ3awb3f6hSQ3xG3HTwvZ9SFkYTKWo7uqGedLVjmqke16Zc4OH3gYhJKO
         BJDg==
X-Gm-Message-State: AOJu0YxtaUK51K96Hbk7BS3e5xmtfr435tOrVMurFtIBrQ5W9SMGBmto
	F9hAM7pavUIqPEAeAdG+5y6r1Lkj181y9Nj7hZk/8TDqgLXFm4iontT3U/XgcgB28oyEozYKdPQ
	VW12vf8W0bpkYHQSrdu6yAszJ9rUkZp6I7/Ol
X-Gm-Gg: ASbGncuogfcZ9DGvMk5ydFW5+zWRcOOhOHCqvurRbLIB+5mabxYcTu88K329Wc0vA+/
	7FBRpdVHySUN2/o66IihCGJybqU3lsJLTOJ8ElbL32WzdFddC6G4KZvK/jXXINYvOauIRqlxMK8
	i6U5rEbytWUW9GwKVeMpvqriVOUGkAh8C2zXPwa5EL7oZpeJDIkh59UOXb46LLFhmRP403X9EB3
	Si9EiHRw8asNeuTXCjWORv+XMGqx7jS42erUZAajKhAxMf1MyYnoUTl1xxXPntRERU053XVcOjX
	BhSG8fVmK6A69cuF7//x/3vGEkLlp5zyiaoW2aUbGokqxgmVEtNwdOx5J8IF0FWGz8UlqYlEGdZ
	8qg==
X-Google-Smtp-Source: AGHT+IGhr9OGpv4jLYq2+b3ez/NrRERhsNQVCxbfZBZc7pb7njSz8g8cyLEm479f2Ec0ymiHndsJbhhtcLJn
X-Received: by 2002:a05:6512:33cf:b0:553:2bf7:77bf with SMTP id 2adb3069b0e04-55513404691mr850358e87.8.1751295364308;
        Mon, 30 Jun 2025 07:56:04 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5550b252ef1sm653164e87.50.2025.06.30.07.56.04;
        Mon, 30 Jun 2025 07:56:04 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 0E8D810567;
	Mon, 30 Jun 2025 16:56:04 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1uWFvP-004JGv-PX; Mon, 30 Jun 2025 16:56:03 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net-next v3] ip6_tunnel: enable to change proto of fb tunnels
Date: Mon, 30 Jun 2025 16:54:54 +0200
Message-ID: <20250630145602.1027220-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is possible via the ioctl API:
> ip -6 tunnel change ip6tnl0 mode any

Let's align the netlink API:
> ip link set ip6tnl0 type ip6tnl mode any

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---

v2 -> v3:
 - reformat the comment in ip6_tnl0_update()
 - don't redeclare the variable 't' in ip6_tnl_changelink()

v1 -> v2:
 - returns an error if the user attempts to change anything other than the proto

 net/ipv6/ip6_tunnel.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index a885bb5c98ea..436e077061d1 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1562,11 +1562,22 @@ static void ip6_tnl_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p)
 	netdev_state_change(t->dev);
 }
 
-static void ip6_tnl0_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p)
+static int ip6_tnl0_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p,
+			   bool strict)
 {
-	/* for default tnl0 device allow to change only the proto */
+	/* For the default ip6tnl0 device, allow changing only the protocol
+	 * (the IP6_TNL_F_CAP_PER_PACKET flag is set on ip6tnl0, and all other
+	 * parameters are 0).
+	 */
+	if (strict &&
+	    (!ipv6_addr_any(&p->laddr) || !ipv6_addr_any(&p->raddr) ||
+	     p->flags != t->parms.flags || p->hop_limit || p->encap_limit ||
+	     p->flowinfo || p->link || p->fwmark || p->collect_md))
+		return -EINVAL;
+
 	t->parms.proto = p->proto;
 	netdev_state_change(t->dev);
+	return 0;
 }
 
 static void
@@ -1680,7 +1691,7 @@ ip6_tnl_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 			} else
 				t = netdev_priv(dev);
 			if (dev == ip6n->fb_tnl_dev)
-				ip6_tnl0_update(t, &p1);
+				ip6_tnl0_update(t, &p1, false);
 			else
 				ip6_tnl_update(t, &p1);
 		}
@@ -2053,8 +2064,28 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
-	if (dev == ip6n->fb_tnl_dev)
-		return -EINVAL;
+	if (dev == ip6n->fb_tnl_dev) {
+		if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
+			/* iproute2 always sets TUNNEL_ENCAP_FLAG_CSUM6, so
+			 * let's ignore this flag.
+			 */
+			ipencap.flags &= ~TUNNEL_ENCAP_FLAG_CSUM6;
+			if (memchr_inv(&ipencap, 0, sizeof(ipencap))) {
+				NL_SET_ERR_MSG(extack,
+					       "Only protocol can be changed for fallback tunnel, not encap params");
+				return -EINVAL;
+			}
+		}
+
+		ip6_tnl_netlink_parms(data, &p);
+		if (ip6_tnl0_update(t, &p, true) < 0) {
+			NL_SET_ERR_MSG(extack,
+				       "Only protocol can be changed for fallback tunnel");
+			return -EINVAL;
+		}
+
+		return 0;
+	}
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip6_tnl_encap_setup(t, &ipencap);
-- 
2.47.1


