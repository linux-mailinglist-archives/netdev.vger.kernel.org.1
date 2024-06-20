Return-Path: <netdev+bounces-105215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4F091026D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9341F21A89
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44981AB8E0;
	Thu, 20 Jun 2024 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="BAJRUU8B"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0671E1AB535
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882574; cv=none; b=SX4jNX7FfBOOBq/2UzDTJYN/F8sgzNdI8SCAm67LIoQTNtgGbYGUR7arJVBzcNFDoiswzKTR/djN5ue0kenAbUPm/MIOqOXEGnGMQhrVbDM8+BAUkicgvMvu3UsPpn+giVVIFF0hT/gCYA/eCNDmqfmVd0PKVaCkzs9GWcDQ+E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882574; c=relaxed/simple;
	bh=SWftHl/pCtq/O56kJsjEgH1Yma18ptdLWx/F81r9FOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WY/UGzijpFIfqyKSYrB+8BRYAJWqLgTYFfp4TbWzhrjlTOE+2h+SvKO9Ei9X0uaImlwofCxHUfo7FtnDGafZ24zbR4AvZpbOGNcwuktDRcsf34+ej2L7FMVjJfPP5YIahJp/Defc/DRUz0FRzCH7JZBfObi25I1i/g5b3LQEO6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=BAJRUU8B; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:530f:c40e:e1d0:8f13])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 4BA207DCC8;
	Thu, 20 Jun 2024 12:22:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1718882566; bh=SWftHl/pCtq/O56kJsjEgH1Yma18ptdLWx/F81r9FOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20gnault@redhat.com,=0D=0A=09samuel.thibault@ens-
	 lyon.org,=0D=0A=09ridge.kennedy@alliedtelesis.co.nz|Subject:=20[PA
	 TCH=20net-next=206/8]=20l2tp:=20use=20IDR=20for=20all=20session=20
	 lookups|Date:=20Thu,=2020=20Jun=202024=2012:22:42=20+0100|Message-
	 Id:=20<0a8131c0f65eb904db44aea4ebbe8c935f7f03ad.1718877398.git.jch
	 apman@katalix.com>|In-Reply-To:=20<cover.1718877398.git.jchapman@k
	 atalix.com>|References:=20<cover.1718877398.git.jchapman@katalix.c
	 om>|MIME-Version:=201.0;
	b=BAJRUU8BU8jgv3yl18crCo9NSFHE0jenXzgiMxPOfg384zIcI5PjYSo+PwJN1gUFG
	 XdFJje2O8RWoKPAXhas8N1J5OqZ2POTnb4HHl6ZHqc6QC3kjDhaDY/8pWJSf39VogS
	 3d1qdyIdTxtyn9k5OgNPP39ZQ2z2g7eGuxWRT7PoIdppuT6BHpbtAc6pTUdBEFoCvG
	 ozS6gylZH/ChRIGlUvy95suC6l7hHXGjjGbeXrbP7nkPj9mID7i6yOqFESfEoSep9n
	 lU+03HKRHcBExNjokIXnFMLRqC3aN1WaaODwiCqOSqts6kCTaUeCPSE+QnSTDNfBAe
	 WfmLa6D8mB7Bw==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: gnault@redhat.com,
	samuel.thibault@ens-lyon.org,
	ridge.kennedy@alliedtelesis.co.nz
Subject: [PATCH net-next 6/8] l2tp: use IDR for all session lookups
Date: Thu, 20 Jun 2024 12:22:42 +0100
Message-Id: <0a8131c0f65eb904db44aea4ebbe8c935f7f03ad.1718877398.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718877398.git.jchapman@katalix.com>
References: <cover.1718877398.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add generic session getter which uses IDR. Replace all users of
l2tp_tunnel_get_session which uses the per-tunnel session list to use
the generic getter.

Signed-off-by: James Chapman <jchapman@katalix.com>
Reviewed-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c    | 10 ++++++++++
 net/l2tp/l2tp_core.h    |  2 ++
 net/l2tp/l2tp_netlink.c |  6 ++++--
 net/l2tp/l2tp_ppp.c     |  6 ++++--
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index cbc5de1373cd..0e826a0260fe 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -316,6 +316,16 @@ struct l2tp_session *l2tp_v2_session_get(const struct net *net, u16 tunnel_id, u
 }
 EXPORT_SYMBOL_GPL(l2tp_v2_session_get);
 
+struct l2tp_session *l2tp_session_get(const struct net *net, struct sock *sk, int pver,
+				      u32 tunnel_id, u32 session_id)
+{
+	if (pver == L2TP_HDR_VER_2)
+		return l2tp_v2_session_get(net, tunnel_id, session_id);
+	else
+		return l2tp_v3_session_get(net, sk, session_id);
+}
+EXPORT_SYMBOL_GPL(l2tp_session_get);
+
 struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth)
 {
 	int hash;
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index d80f15f5b9fc..0e7c9b0bcc1e 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -232,6 +232,8 @@ struct l2tp_session *l2tp_tunnel_get_session(struct l2tp_tunnel *tunnel,
 
 struct l2tp_session *l2tp_v3_session_get(const struct net *net, struct sock *sk, u32 session_id);
 struct l2tp_session *l2tp_v2_session_get(const struct net *net, u16 tunnel_id, u16 session_id);
+struct l2tp_session *l2tp_session_get(const struct net *net, struct sock *sk, int pver,
+				      u32 tunnel_id, u32 session_id);
 struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth);
 struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
 						const char *ifname);
diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index a901fd14fe3b..d105030520f9 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -61,7 +61,8 @@ static struct l2tp_session *l2tp_nl_session_get(struct genl_info *info)
 		session_id = nla_get_u32(info->attrs[L2TP_ATTR_SESSION_ID]);
 		tunnel = l2tp_tunnel_get(net, tunnel_id);
 		if (tunnel) {
-			session = l2tp_tunnel_get_session(tunnel, session_id);
+			session = l2tp_session_get(net, tunnel->sock, tunnel->version,
+						   tunnel_id, session_id);
 			l2tp_tunnel_dec_refcount(tunnel);
 		}
 	}
@@ -635,7 +636,8 @@ static int l2tp_nl_cmd_session_create(struct sk_buff *skb, struct genl_info *inf
 							   &cfg);
 
 	if (ret >= 0) {
-		session = l2tp_tunnel_get_session(tunnel, session_id);
+		session = l2tp_session_get(net, tunnel->sock, tunnel->version,
+					   tunnel_id, session_id);
 		if (session) {
 			ret = l2tp_session_notify(&l2tp_nl_family, info, session,
 						  L2TP_CMD_SESSION_CREATE);
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 6146e4e67bbb..3596290047b2 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -753,7 +753,8 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
 	if (tunnel->peer_tunnel_id == 0)
 		tunnel->peer_tunnel_id = info.peer_tunnel_id;
 
-	session = l2tp_tunnel_get_session(tunnel, info.session_id);
+	session = l2tp_session_get(sock_net(sk), tunnel->sock, tunnel->version,
+				   info.tunnel_id, info.session_id);
 	if (session) {
 		drop_refcnt = true;
 
@@ -1045,7 +1046,8 @@ static int pppol2tp_tunnel_copy_stats(struct pppol2tp_ioc_stats *stats,
 	/* If session_id is set, search the corresponding session in the
 	 * context of this tunnel and record the session's statistics.
 	 */
-	session = l2tp_tunnel_get_session(tunnel, stats->session_id);
+	session = l2tp_session_get(tunnel->l2tp_net, tunnel->sock, tunnel->version,
+				   tunnel->tunnel_id, stats->session_id);
 	if (!session)
 		return -EBADR;
 
-- 
2.34.1


