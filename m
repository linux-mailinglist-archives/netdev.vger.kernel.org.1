Return-Path: <netdev+bounces-109345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 893EA9280D6
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 05:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9D51F255C9
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 03:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BFB61FF0;
	Fri,  5 Jul 2024 03:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="f+0magwH"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE781643D
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 03:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720148455; cv=none; b=uZZ2IX7k5VNDUZhQYCJ73JMCijHPMl1G3QZWFWwBvXYdC2zU7varIissaBEddjEbnAva6vBQi2FvwUlFUjM9DHjqEibyNA/smgFSX0x5IIi41DS8q2oI/8+5lINdM4Ma+kQckl+7fMHmyS7h5lfr4/rMwM1cKd+9a5y1bE1O6PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720148455; c=relaxed/simple;
	bh=JiJY+j6TyfBV9LR9ycgqUi+s3rgLJnFnQqqJZj6khuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQHnwQuI5yWFJLGPr6wACk4Bf9fcDLWr6Vf81G8OVMlnIspjWm6UbDHIWItOADRTI3e2iEvAF9qDvWp5oSRKjj5FQ1AgbQsJ3wO1MuzD4Yi1EUa16w2JoR56sujgOdfsnJAofsiPlLSlQ/jCGnJqXRyOo7d0DmZWKOJJp9u4thA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=f+0magwH; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4CCCD2C01D5;
	Fri,  5 Jul 2024 15:00:49 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1720148449;
	bh=zJySgUg5KnNtBOK7uwX7TCw7Zzzq8wJpmdXhs5nEk7I=;
	h=From:To:Cc:Subject:Date:From;
	b=f+0magwHpL2OOLtrVrykxqerhRCQYet1UYpaJElC/3DEQG4WQGgpACml20paHoggc
	 Dg4HEMN2UlB2wom/Ttt2rfs9VsmWcRYjLanEriHJ8+d+2Nm/6cKJ9iveEOoH06Z5Zf
	 PTiTy1bTqxdss9DATnbRX3LqNLXVv3FekWjjDGBd5M4KtMhMUd0MDinHex3lrgX/Cr
	 /2wxHnH0wSKLtUeSHr60xQO805UWuJbgqOtiXB0HE7tGg/7ShNRAAbeQcuo9+AnlOn
	 mfK8VSeOl9ULl5hyoKdOUf3IBGCuTRMdXqNDc+pvNyU2uZjtQPa+06bx1eL2Q9SjXn
	 2qk7Kz5J8iPPw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B668761e10000>; Fri, 05 Jul 2024 15:00:49 +1200
Received: from elliota2-dl.ws.atlnz.lc (elliota-dl.ws.atlnz.lc [10.33.23.28])
	by pat.atlnz.lc (Postfix) with ESMTP id 18FC013ED5B;
	Fri,  5 Jul 2024 15:00:49 +1200 (NZST)
Received: by elliota2-dl.ws.atlnz.lc (Postfix, from userid 1775)
	id 136623C0681; Fri,  5 Jul 2024 15:00:49 +1200 (NZST)
From: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
To: davem@davemloft.net
Cc: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: bridge: mst: Check vlan state for egress decision
Date: Fri,  5 Jul 2024 15:00:40 +1200
Message-ID: <20240705030041.1248472-1-elliot.ayrey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CvQccW4D c=1 sm=1 tr=0 ts=668761e1 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=4kmOji7k6h8A:10 a=JXkHKJOXY2Ndxws4tuMA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

If a port is blocking in the common instance but forwarding in an MST
instance, traffic egressing the bridge will be dropped because the
state of the common instance is overriding that of the MST instance.

Fix this by temporarily forcing the port state to forwarding when in
MST mode to allow checking the vlan state via br_allowed_egress().
This is similar to what happens in br_handle_frame_finish() when
checking ingress traffic, which was introduced in the change below.

Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode=
")
Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
---
 net/bridge/br_forward.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index d97064d460dc..911b37a38a32 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -22,10 +22,16 @@ static inline int should_deliver(const struct net_bri=
dge_port *p,
 				 const struct sk_buff *skb)
 {
 	struct net_bridge_vlan_group *vg;
+	u8 state;
+
+	if (br_mst_is_enabled(p->br))
+		state =3D BR_STATE_FORWARDING;
+	else
+		state =3D p->state;
=20
 	vg =3D nbp_vlan_group_rcu(p);
 	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev !=3D p->dev) &&
-		p->state =3D=3D BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
+		state =3D=3D BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
 		nbp_switchdev_allowed_egress(p, skb) &&
 		!br_skb_isolated(p, skb);
 }

