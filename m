Return-Path: <netdev+bounces-235457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9167C30DD5
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 13:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4112D424E60
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 12:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CEC2ECEAC;
	Tue,  4 Nov 2025 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="N7prUU2n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1037B2EBBB3
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257803; cv=none; b=TpkY1yVtXz8HweOACVb3NbXGUukApD8Toeq9gtne+yNHzS9kXL2nch+kajQcI05dJOY1x73QmYZfy8OKcrlg8rEszEpoHdSQ43AwEfd2ePhyQKII+oprzZjIYH542fozK29dk51w3bZZRVB++PQcpxkZEf/yR/Roo5ALKdDLSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257803; c=relaxed/simple;
	bh=uxs/iZONtkysdoEYh0TYj6L15sDcCF+xti3WB6jljeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szLuJQlYyGN7+U4TaEFklveB2FUOjbVTlrJhRzMmXFq4gLvzMkO2s4lydawHxPEAtr5+AM2hBDm4SdhdrhkcUKk+FBOiqrvCPlDnUg5mT5zNG8koWs3VGPbTUxivMv5B/KTLyobPe/ocDk2j7JJoS76YC7cvbge+y8X+oC9HqRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=N7prUU2n; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so9318098a12.3
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 04:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762257800; x=1762862600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cq+bG+eJXl71qSp6ixRRiwG9h8t8D2Um16KyxjJF7o=;
        b=N7prUU2nhaQZaOoIAQ8UkpaChdDTT9es59nHTIhGny9rVoI2AyA/JSRqO28hg1Zpjh
         xhmSSayr31TNtNjQGOVZcV1+yplgtM69Aw6QmZIiB9B8cigW/nBXbbIWP5AjSZi+LPcs
         r9ooCUVGEUmFxD1yJyEcRxsqQUpNYEUXiFhyLct1fQ21o04cb1Aki+QOCL7pWNEWWtw6
         dQy+clpQZqjlMpB3BzbpJ+XjjMXh1SGdE+V7cX0CEDjEfU0NML1p9yySgWgJ53TOiYHb
         6zCv5/3vbudvXEL2LS9YCE3CKnhlqLeQMCPiPwMjIQt9QWPss4fg/Oy4xTvwbZj8y0Bf
         cLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257800; x=1762862600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cq+bG+eJXl71qSp6ixRRiwG9h8t8D2Um16KyxjJF7o=;
        b=lUiEPKk8Xv5zd6VcND+Judyp2YYibGebQNwLxrfMO2Deoq8mgb5AY7sFcU4LhDFOQx
         lV5NAssQLkd1QoRBsywZMMiMlb33RIoZ8jH5WJYkz0ttzwNbEmvtDGKo+TFbN8njgp0+
         7vWB1aNRR0gosvg7BFvKQEFDjfPwP2FkNjKFcliY/XU7uGAp50ek5aZ2VX9rqmLGsEhr
         DFrmONJ4d12qeG9OgczJsetKyh5ltoxhfmy+3RhwmMYUq5fA0Gm/EEmhn2C9ylEUAYMQ
         57dnzaYwR0ZEHhBMqh7ChcNve+YfERdRibTbxq37tyFJEXkQ+iIsnHCuUw9Yd8/aK+lE
         s/ng==
X-Gm-Message-State: AOJu0Yz3KaOtuEGTIqYIfDvzKUWUC37eftqi5vx6ybOjnjRAqplFPPOr
	hA0W+OpLjp5z9QUG5nvms/RkUYdG8neI7IS32/X82u/X+O9dJoy/fT0hZy1yB5pYCOJDrr03mC5
	yMsC3zxxkFw==
X-Gm-Gg: ASbGncvvdr/FpSTc+codbsUazogWezb00fA+haYkgFNq6EuDNUyzmbXKA7HUkpeF11b
	q6Mswnek+2S7LJpv8+tomnwkfQvil3Hu/bATLhQuXXhU1uj7k8N7HcVn1648VuwwuW0my8u0GZ7
	Pp0Lwnl+AmnyGt03SIoSsOeOTSjFvyFNTD2lxcH46CkhUKSnwG6Pi3pe360kLq2/cC4g1g+YKQ4
	W3oy2FKUZhr6SnG0zwILWicsSlt/3Kps0jueJGM3nymWIEHDuxBhbRNkBcg8IAIFZkH607vlztV
	Wu0HU5VCnG8fA740ENuv36d0/V9ESCkGAVZU8P/IqegLLjuG5+75JQHahk8S4HOoXpXfdY3c+5i
	ks6Uq/8MaimfFQ1dfzPNtY1mBfu2zG60O8GiL1jnymhXWiyRFldDsP+KBdULnR+dw8D+wAkVg8E
	V53mf1TQs9RfDY8RPW48kQhIRXl7HqY63ApobJRPgJmYCA
X-Google-Smtp-Source: AGHT+IF4FIF4AXqOpmhsabGe02+8vfJF5OMMRMawtSVwJVY40Y2Ec3KnR/1nPf5j50ocsAT1zWg3RA==
X-Received: by 2002:a17:907:3e16:b0:b6d:8557:19a with SMTP id a640c23a62f3a-b70704c3e8amr1873656066b.30.1762257799462;
        Tue, 04 Nov 2025 04:03:19 -0800 (PST)
Received: from debil.nvidia.com (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d3a3082sm195032166b.11.2025.11.04.04.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:03:18 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com,
	idosch@nvidia.com,
	kuba@kernel.org,
	davem@davemloft.net,
	bridge@lists.linux.dev,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
Subject: [PATCH net 1/2] net: bridge: fix use-after-free due to MST port state bypass
Date: Tue,  4 Nov 2025 14:03:12 +0200
Message-ID: <20251104120313.1306566-2-razor@blackwall.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104120313.1306566-1-razor@blackwall.org>
References: <20251104120313.1306566-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported[1] a use-after-free when deleting an expired fdb. It is
due to a race condition between learning still happening and a port being
deleted, after all its fdbs have been flushed. The port's state has been
toggled to disabled so no learning should happen at that time, but if we
have MST enabled, it will bypass the port's state, that together with VLAN
filtering disabled can lead to fdb learning at a time when it shouldn't
happen while the port is being deleted. VLAN filtering must be disabled
because we flush the port VLANs when it's being deleted which will stop
learning. This fix avoids adding more checks in the fast-path and instead
toggles the MST static branch when changing VLAN filtering which
effectively disables MST when VLAN filtering gets disabled, and re-enables
it when VLAN filtering is enabled && MST is enabled as well.

[1] https://syzkaller.appspot.com/bug?extid=dd280197f0f7ab3917be

Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
Reported-by: syzbot+dd280197f0f7ab3917be@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69088ffa.050a0220.29fc44.003d.GAE@google.com/
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
Initially I did look into moving the rx handler
registration/unregistration but that is much more difficult and
error-prone. This solution seems like the cleanest approach that doesn't
affect the fast-path.

 net/bridge/br_mst.c     | 18 +++++++++++++-----
 net/bridge/br_private.h |  5 +++++
 net/bridge/br_vlan.c    |  1 +
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 3f24b4ee49c2..4abf8551290f 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -194,6 +194,18 @@ void br_mst_vlan_init_state(struct net_bridge_vlan *v)
 		v->state = v->port->state;
 }
 
+void br_mst_static_branch_toggle(struct net_bridge *br)
+{
+	/* enable the branch only if both VLAN filtering and MST are enabled
+	 * otherwise port state bypass can lead to learning race conditions
+	 */
+	if (br_opt_get(br, BROPT_VLAN_ENABLED) &&
+	    br_opt_get(br, BROPT_MST_ENABLED))
+		static_branch_enable(&br_mst_used);
+	else
+		static_branch_disable(&br_mst_used);
+}
+
 int br_mst_set_enabled(struct net_bridge *br, bool on,
 		       struct netlink_ext_ack *extack)
 {
@@ -224,11 +236,7 @@ int br_mst_set_enabled(struct net_bridge *br, bool on,
 	if (err && err != -EOPNOTSUPP)
 		return err;
 
-	if (on)
-		static_branch_enable(&br_mst_used);
-	else
-		static_branch_disable(&br_mst_used);
-
+	br_mst_static_branch_toggle(br);
 	br_opt_toggle(br, BROPT_MST_ENABLED, on);
 	return 0;
 }
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 16be5d250402..052bea4b3c06 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1952,6 +1952,7 @@ int br_mst_fill_info(struct sk_buff *skb,
 		     const struct net_bridge_vlan_group *vg);
 int br_mst_process(struct net_bridge_port *p, const struct nlattr *mst_attr,
 		   struct netlink_ext_ack *extack);
+void br_mst_static_branch_toggle(struct net_bridge *br);
 #else
 static inline bool br_mst_is_enabled(struct net_bridge *br)
 {
@@ -1987,6 +1988,10 @@ static inline int br_mst_process(struct net_bridge_port *p,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void br_mst_static_branch_toggle(struct net_bridge *br)
+{
+}
 #endif
 
 struct nf_br_ops {
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index ce72b837ff8e..636d11f932eb 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -911,6 +911,7 @@ int br_vlan_filter_toggle(struct net_bridge *br, unsigned long val,
 	br_manage_promisc(br);
 	recalculate_group_addr(br);
 	br_recalculate_fwd_mask(br);
+	br_mst_static_branch_toggle(br);
 	if (!val && br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
 		br_info(br, "vlan filtering disabled, automatically disabling multicast vlan snooping\n");
 		br_multicast_toggle_vlan_snooping(br, false, NULL);
-- 
2.51.0


