Return-Path: <netdev+bounces-110998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F4292F376
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 03:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2A1282D13
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 01:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECF7539A;
	Fri, 12 Jul 2024 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="xj/G0U0Q"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CB85256
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720747907; cv=none; b=hE4NE/FDuQpQIJJLu9BsGv/IqatO1l+XM5/g/23h2cK2WfGXSLb/kkNXrGTTuZ/kZ4v5K1Dy2vOO1pdOfstcuhT/5nCurhT1l+netXriAY2Srn9ba0fvfjvpUwOUbeiRwUQYuHVOFhybv4Hp3j81BNneG6C8A0UxrFt5qmEaNvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720747907; c=relaxed/simple;
	bh=3/q9B6tyTALdrwrlYFzWdoLByod0br2tREAPeX0aEVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XTk39k1Sd43LtryCKhcss+S9mywdWmpl4LuhgzQBSj9DoYVGjB6BREjS/bNylCOmNvVClO1QsSA+MhSNGT8M/Es5pzi9gMwGrUze0VzGE63OooTvgdUAHx6MyWVRKyPLyiDFHBHabtP8BkZUGf5IueSVIk9k9+joe4eqhtRbw8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=xj/G0U0Q; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A1D7B2C0132;
	Fri, 12 Jul 2024 13:31:41 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1720747901;
	bh=DIYv3e718Fg4fkXAoW5E0eSKPEr8QymU9zQGfqZK45w=;
	h=From:To:Cc:Subject:Date:From;
	b=xj/G0U0QAS82rcfmEhBuSzVi2j+i8R8Qd+aJqALVONmm4N+HwOAISTC71iL7ajCkF
	 hp1T+QvEhL9WEt5dlwkkS6rE/0zhCSwVLlbAEWppxZIcVaaaMZdMm5sCrJQVPBZVVy
	 TTbuMWEvipBwTeCjN8rnV2Zst8GrgJo1xsksgbdVp6NWXz9d7jIn6InbdWcsLFz9zJ
	 dovkKerr2KEaiatU5FtwOaQT+GrRGfJK6/v31N23v/HBK0hhlPL7t86UJCIrrVGyeU
	 ElGUao/X+uEqL1Nu5UGuMJEOVjqBFK7v7eaS5GBoqwz9TuBflJgtnRKloasGkHT/GM
	 7GlD79QJwzdDw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6690877d0000>; Fri, 12 Jul 2024 13:31:41 +1200
Received: from elliota2-dl.ws.atlnz.lc (elliota-dl.ws.atlnz.lc [10.33.23.28])
	by pat.atlnz.lc (Postfix) with ESMTP id 3750D13EE2B;
	Fri, 12 Jul 2024 13:31:41 +1200 (NZST)
Received: by elliota2-dl.ws.atlnz.lc (Postfix, from userid 1775)
	id 309A53C0681; Fri, 12 Jul 2024 13:31:41 +1200 (NZST)
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
Subject: [PATCH net v3] net: bridge: mst: Check vlan state for egress decision
Date: Fri, 12 Jul 2024 13:31:33 +1200
Message-ID: <20240712013134.717150-1-elliot.ayrey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=PIKs+uqC c=1 sm=1 tr=0 ts=6690877d a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=kEPFZq6BU9ta2gAs10EA:9 a=3ZKOabzyN94A:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

If a port is blocking in the common instance but forwarding in an MST
instance, traffic egressing the bridge will be dropped because the
state of the common instance is overriding that of the MST instance.

Fix this by skipping the port state check in MST mode to allow
checking the vlan state via br_allowed_egress(). This is similar to
what happens in br_handle_frame_finish() when checking ingress
traffic, which was introduced in the change below.

Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode=
")
Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
---

v3:
  - Properly reference port state to fix compile error
v2: https://lore.kernel.org/all/20240711045926.756958-1-elliot.ayrey@alli=
edtelesis.co.nz/
  - Restructure the MST mode check to make it read better
v1: https://lore.kernel.org/all/20240705030041.1248472-1-elliot.ayrey@all=
iedtelesis.co.nz/

 net/bridge/br_forward.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index d97064d460dc..e19b583ff2c6 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -25,8 +25,8 @@ static inline int should_deliver(const struct net_bridg=
e_port *p,
=20
 	vg =3D nbp_vlan_group_rcu(p);
 	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev !=3D p->dev) &&
-		p->state =3D=3D BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
-		nbp_switchdev_allowed_egress(p, skb) &&
+		(br_mst_is_enabled(p->br) || p->state =3D=3D BR_STATE_FORWARDING) &&
+		br_allowed_egress(vg, skb) && nbp_switchdev_allowed_egress(p, skb) &&
 		!br_skb_isolated(p, skb);
 }
=20
--=20
2.45.2


