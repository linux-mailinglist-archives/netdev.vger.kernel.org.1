Return-Path: <netdev+bounces-92294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7818B67BE
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 03:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85FB2282556
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 01:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA995C96;
	Tue, 30 Apr 2024 01:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="anpv71SV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1B6FB0
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714442337; cv=none; b=RZP5cWMnJ+i+s+wRz0WoQDDnStHhewk7lvOvgUt6KsmdIhr1muPhnQS/+GVjBft4SwgSJDB4fHlAtFck6FlapB9oQBnZLl6ZMg/TJ3+TpCx2InWSHvTdnZ5W7cNoqzGyYKJYbYZFpj5LoLH/KdWU+uSfi5EqwHcghqqnV95Ki38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714442337; c=relaxed/simple;
	bh=uCOmAoqMz19Yew1YDU0a3XbyL720lmv8ZVwH2aCnMnY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EopeJwJ9wLKZNzZvuiH6AhuCOKsajJmMTQaLD8aejc0M+Opp0S37RB17tCTGe6k1g0RZFYG1rq9kWMRWhlHFVOEno1Hh2kjMWDLqAmD+mG+jQiIPeNHxpblJuwk5pIT+mw9yiP7ZX74zPYpiVWsLNwE/ATa+Rnt+D4cFj1EeCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=anpv71SV; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714442336; x=1745978336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w8/AwnpuGsPRfABxQF//F/qaOZAknYKOjVg/eeaiuYk=;
  b=anpv71SVHaLDmovcbjk2J03lidOOFkjLIMYVV2PbMJYNzXG9pYSfMHgS
   PExEKFXZ9mtLfEBlxmWeb8hFCIgZjHOw5J7QKAhjCFPAqJckyK+76Dalg
   cQiUd4vGTMhA3NCMcOQyrAnIhWW9F4ct+mQOVyyFQ80J4PZxW1xyblXqW
   8=;
X-IronPort-AV: E=Sophos;i="6.07,241,1708387200"; 
   d="scan'208";a="415573305"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 01:58:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:42157]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.42:2525] with esmtp (Farcaster)
 id 2b1105ce-aee0-4cbc-b2ba-ecc598c748aa; Tue, 30 Apr 2024 01:58:50 +0000 (UTC)
X-Farcaster-Flow-ID: 2b1105ce-aee0-4cbc-b2ba-ecc598c748aa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 01:58:50 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 30 Apr 2024 01:58:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 1/7] arp: Move ATF_COM setting in arp_req_set().
Date: Mon, 29 Apr 2024 18:58:07 -0700
Message-ID: <20240430015813.71143-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240430015813.71143-1-kuniyu@amazon.com>
References: <20240430015813.71143-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

In arp_req_set(), if ATF_PERM is set in arpreq.arp_flags,
ATF_COM is set automatically.

The flag will be used later for neigh_update() only when
a neighbour entry is found.

Let's set ATF_COM just before calling neigh_update().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/arp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index ab82ca104496..3093374165fa 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1054,8 +1054,7 @@ static int arp_req_set(struct net *net, struct arpreq *r,
 		return arp_req_set_public(net, r, dev);
 
 	ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
-	if (r->arp_flags & ATF_PERM)
-		r->arp_flags |= ATF_COM;
+
 	if (!dev) {
 		struct rtable *rt = ip_route_output(net, ip, 0, 0, 0,
 						    RT_SCOPE_LINK);
@@ -1092,8 +1091,12 @@ static int arp_req_set(struct net *net, struct arpreq *r,
 	err = PTR_ERR(neigh);
 	if (!IS_ERR(neigh)) {
 		unsigned int state = NUD_STALE;
-		if (r->arp_flags & ATF_PERM)
+
+		if (r->arp_flags & ATF_PERM) {
+			r->arp_flags |= ATF_COM;
 			state = NUD_PERMANENT;
+		}
+
 		err = neigh_update(neigh, (r->arp_flags & ATF_COM) ?
 				   r->arp_ha.sa_data : NULL, state,
 				   NEIGH_UPDATE_F_OVERRIDE |
-- 
2.30.2


