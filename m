Return-Path: <netdev+bounces-150678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B84589EB2B8
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BF418832DA
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DD71AAA02;
	Tue, 10 Dec 2024 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b="jtn+ltjn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0241AA1D4
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839622; cv=none; b=caJbUMVKyynWrxkJAulnVAFNNqa5ELFLv6xHrKKWMOa+zuAcH25RdFMuqb1Bur+VWVcMEmY3+rrFbzUmgZGnrCygciRp166ky8BWfCCOJUCkQsAvgwEi2qVJYrhNcUo1QbAd2eHIUMk65u67ZuJuSexUylf2olq02bFU/0Y4p30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839622; c=relaxed/simple;
	bh=0YZNKtXDfP+8QyyPpsswSj+2vSc/K+kIjLDDq3tOwC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FkWV54DZ5Uq1iwIamYUa1tJH0M+wkqGXyooLMS78ImGSjjYpYQmddh7ceqhXpUDoanVEsYyYGakLhRdpKi0P8899Uk0EP/SGEXpdyIVqKx7sJz1+Vo5zBYYJ5L4XlBbYg01Vfk//uATeI4sEwWvQdbQgurX02mjuqzpvWNEvLRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de; spf=none smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b=jtn+ltjn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bisdn.de
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434f3dd3b6dso1352875e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 06:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1733839618; x=1734444418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fwVBCYlKvSJ/tb5KPR5pkdXQVWY08bYiN1DG29AvgxA=;
        b=jtn+ltjnSyk9CMKcApHLhJCwh1RGTJ/2JxlE+jocUIRWgDDSkWeHr8VyVjyrjFzVNt
         QqmLvVVeZB4kdMS70kDqkUOK7wQofjkqBVdykLFjRojy/Ku9d4/e2g0e+/4X3GM94NbQ
         l0fjHW3r3NcthbixkiD/jG17PVr235v4NkkTg+bmIhs58jjgDwWwEBiSrH9WozKlQguk
         AK1bysOZ7MEOfiEhOw873mzCJHRtGdmYrBiNCy1VIbwFyZ00LzPX7h0O7zJGjFtyyRD7
         szDTLSqMXsPplsY8IYoSya2H+hZ8YRIWmuIgdugsKdmywABojZiHeVqS3l7T9znfQC8d
         ucGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733839618; x=1734444418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwVBCYlKvSJ/tb5KPR5pkdXQVWY08bYiN1DG29AvgxA=;
        b=I2YKQB9GslUTbN4PL9v2Oy9eoKg8VSkR/QwargeeFUM84LVmNRfTKajm0R/BZirZri
         +wSBDKnlFWh1ZwfWdE557p0JtOfaTdX4tyuS/64b9mqJYMeTtOgDXc4FKPBLOXNwduif
         Fv672bmM09t8XetZqLF1EwLGUMBUZlT53enZ50tILkjcsOqpy2eAOEzPTid1VOX7a+S4
         kvgZ/Mo91OPF9I8n1gTWlq/OlyJsrqbowAve2smtHQ4JVjqoToVkz6CEasaXCfbSfUIp
         npyRWEut6W5bc7YETtgdBGcUO8zcclnzMT0uYJz7SN10Wyr5DAmLqON0QxJM4qWBhivc
         t6Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVw3SIYTK03lUeraOQiSpz5xqKhta7frhWzf3WBvLKY0Tktgv+WNf6mprM5DQFI7T+48Zn90ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzkD1EJPdeq8ILmzuJy5rrPgYlKhXvKybGTNxeFoEoPjFoXBds
	gdpXTUICBst1RCrtikflFmHuPNUIRMjfMCqYAROyrm0pHx6N95qrtj2qhTKQ/t73PNRSIrHxxRf
	YjpdcimAVhQf7et4vuv/OSzV1ss4enVmgbWU+rYSbqaE0c14=
X-Gm-Gg: ASbGncvxRV1Vy8JJ/+knUWi7sPOfmwsrkwzefSM1pzrStt+MCwZsVqUCx7TuXh2e9H5
	/+FrxDkvs7iUYrMwarZrDnPJpcBRn2gtel768d4+ydD4iktiwMyjO3mBk4BE3fRWy4q3Di+tvZ2
	KMenU73i5yaMQnTI3nr/VBhMAZV55VRw2s6oExftJHYTK9pLzgiG0I6vYAzwCPh76x3IDLHyiOn
	/1mKYDiFAg1RlSPWutV62LOVUyybl6Dfwpw1IQH/zWH1ayEfW1qIsbpi6IfDfzmmiPLiqD3Q27c
	kaF7ZaCgLAWJNB1583t8ipRgnL+bZhs=
X-Google-Smtp-Source: AGHT+IFjq3W+OtWrcW1iL9JDh1ARCh77V77C27ZksusR6Buk46t4KtFCOIUWlMbJwNxtHZvhPesjCw==
X-Received: by 2002:a05:600c:46cf:b0:431:4983:e8fe with SMTP id 5b1f17b1804b1-435019c8d2fmr12174395e9.9.1733839617559;
        Tue, 10 Dec 2024 06:06:57 -0800 (PST)
Received: from localhost (dslb-084-060-024-069.084.060.pools.vodafone-ip.de. [84.60.24.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbd72sm231624085e9.44.2024.12.10.06.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:06:57 -0800 (PST)
From: Jonas Gorski <jonas.gorski@bisdn.de>
To: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Hans Schultz <schultz.hans@gmail.com>,
	"Hans J. Schultz" <netdev@kapio-technology.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC] net: bridge: handle ports in locked mode for ll learning
Date: Tue, 10 Dec 2024 15:06:53 +0100
Message-ID: <20241210140654.108998-1-jonas.gorski@bisdn.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

When support for locked ports was added with commit a21d9a670d81 ("net:
bridge: Add support for bridge port in locked mode"), learning is
inhibited when the port is locked in br_handle_frame_finish().

It was later extended in commit a35ec8e38cdd ("bridge: Add MAC
Authentication Bypass (MAB) support") where optionally learning is done
with locked entries.

Unfortunately both missed that learning may also happen on frames to
link local addresses (01:80:c2:00:00:0X) in br_handle_frame(), which
will call __br_handle_local_finish(), which may update the fdb unless
(ll) learning is disabled as well.

This can be easily observed by e.g. EAPOL frames to 01:80:c2:00:00:03 on
a port causing the source mac to be learned, which is then forwarded
normally, essentially bypassing any authentication.

Fix this by moving the BR_PORT_LOCKED handling into its own function,
and call it from both places.

Fixes: a21d9a670d81 ("net: bridge: Add support for bridge port in locked mo=
de")
Fixes: a35ec8e38cdd ("bridge: Add MAC Authentication Bypass (MAB) support")
Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
---
Sent as RFC since I'm not 100% sure this is the right way to fix.

 net/bridge/br_input.c | 78 ++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index ceaa5a89b947..f269a9f1b871 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -72,6 +72,46 @@ static int br_pass_frame_up(struct sk_buff *skb, bool pr=
omisc)
 		       br_netif_receive_skb);
 }
=20
+static int br_fdb_locked_learn(struct net_bridge_port *p, struct sk_buff *=
skb,
+			       u16 vid, bool mark)
+{
+	struct net_bridge *br =3D p->br;
+
+	if (p->flags & BR_PORT_LOCKED) {
+		struct net_bridge_fdb_entry *fdb_src =3D
+			br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
+		if (!fdb_src) {
+			/* FDB miss. Create locked FDB entry if MAB is enabled
+			 * and drop the packet.
+			 */
+			if (p->flags & BR_PORT_MAB)
+				br_fdb_update(br, p, eth_hdr(skb)->h_source,
+					      vid, BIT(BR_FDB_LOCKED));
+			return NET_RX_DROP;
+		} else if (READ_ONCE(fdb_src->dst) !=3D p ||
+			   test_bit(BR_FDB_LOCAL, &fdb_src->flags)) {
+			/* FDB mismatch. Drop the packet without roaming. */
+			return NET_RX_DROP;
+		} else if (test_bit(BR_FDB_LOCKED, &fdb_src->flags)) {
+			/* FDB match, but entry is locked. Refresh it and drop
+			 * the packet.
+			 */
+			br_fdb_update(br, p, eth_hdr(skb)->h_source, vid,
+				      BIT(BR_FDB_LOCKED));
+			return NET_RX_DROP;
+		}
+	}
+
+	if (mark)
+		nbp_switchdev_frame_mark(p, skb);
+
+	/* insert into forwarding database after filtering to avoid spoofing */
+	if (p->flags & BR_LEARNING)
+		br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, 0);
+
+	return NET_RX_SUCCESS;
+}
+
 /* note: already called with rcu_read_lock */
 int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buf=
f *skb)
 {
@@ -108,37 +148,8 @@ int br_handle_frame_finish(struct net *net, struct soc=
k *sk, struct sk_buff *skb
 				&state, &vlan))
 		goto out;
=20
-	if (p->flags & BR_PORT_LOCKED) {
-		struct net_bridge_fdb_entry *fdb_src =3D
-			br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
-
-		if (!fdb_src) {
-			/* FDB miss. Create locked FDB entry if MAB is enabled
-			 * and drop the packet.
-			 */
-			if (p->flags & BR_PORT_MAB)
-				br_fdb_update(br, p, eth_hdr(skb)->h_source,
-					      vid, BIT(BR_FDB_LOCKED));
-			goto drop;
-		} else if (READ_ONCE(fdb_src->dst) !=3D p ||
-			   test_bit(BR_FDB_LOCAL, &fdb_src->flags)) {
-			/* FDB mismatch. Drop the packet without roaming. */
-			goto drop;
-		} else if (test_bit(BR_FDB_LOCKED, &fdb_src->flags)) {
-			/* FDB match, but entry is locked. Refresh it and drop
-			 * the packet.
-			 */
-			br_fdb_update(br, p, eth_hdr(skb)->h_source, vid,
-				      BIT(BR_FDB_LOCKED));
-			goto drop;
-		}
-	}
-
-	nbp_switchdev_frame_mark(p, skb);
-
-	/* insert into forwarding database after filtering to avoid spoofing */
-	if (p->flags & BR_LEARNING)
-		br_fdb_update(br, p, eth_hdr(skb)->h_source, vid, 0);
+	if (br_fdb_locked_learn(p, skb, vid, true) =3D=3D NET_RX_DROP)
+		goto drop;
=20
 	promisc =3D !!(br->dev->flags & IFF_PROMISC);
 	local_rcv =3D promisc;
@@ -234,11 +245,10 @@ static void __br_handle_local_finish(struct sk_buff *=
skb)
 	u16 vid =3D 0;
=20
 	/* check if vlan is allowed, to avoid spoofing */
-	if ((p->flags & BR_LEARNING) &&
-	    nbp_state_should_learn(p) &&
+	if (nbp_state_should_learn(p) &&
 	    !br_opt_get(p->br, BROPT_NO_LL_LEARN) &&
 	    br_should_learn(p, skb, &vid))
-		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, vid, 0);
+		br_fdb_locked_learn(p, skb, vid, false);
 }
=20
 /* note: already called with rcu_read_lock */
--=20
2.47.1


--=20
BISDN GmbH
K=F6rnerstra=DFe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=F6psel


Commercial register:=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=A0DE283257294


