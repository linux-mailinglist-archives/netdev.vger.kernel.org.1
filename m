Return-Path: <netdev+bounces-96793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECF58C7D9A
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 22:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22E21C20F6F
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 20:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FF8157E61;
	Thu, 16 May 2024 20:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiG+NjFe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0D4157480
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715890191; cv=none; b=YGlO29mLwbFPXX4r4XRmwUFhn2GVBjuJ38vOYfIcXLE2FDBqSawtc6Liq2Gt59h8gpM16wdzuqfhZwR3yTJLviGxp5Let165q/qFFQnZzNCfZl0TDT0BrYmVL5bLHJpV/RDAVAvK2eppizs/4i6+zvdCDWDeUaZyFJf7r/qKAAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715890191; c=relaxed/simple;
	bh=EUpklSxQlvL3tJx+fqvIYMYmd+ITdKsrjLKSxUT+MoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDrCxEXt6TmN9J5QiJIwKkeXocvm2aH0hYirgSAmZvaD4lerWjqCVLxkGIev0Vw19HNSlOgpoXyXQl18fsVs8nejHMaPexmhrgwPilyLS3SHXxeeS7FQiXHxaTuKgP/5rUp7mMPD2wOv04nU/doX+dytafBILCQt+b0bnhSJCa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PiG+NjFe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715890189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=enjpFwxkMXeucLrOY4GgEKclmokFGniBJ7j/L6UJXVo=;
	b=PiG+NjFeJJ4r+pxhBKEInjaWbVKzSZiwoGho2egMHs2B7E7Trk/WHZUkLyTUL/FY7GSJ3r
	j2bmQ/BY5qqcjRSiwdt1B4gshzW8G087fAuu+qjKDYG8ixGiLhfA7/IuUy7EkxhHhzkYZT
	PKZi7XX/YH8dUT07YJKbBRFE2B+avrI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-tBxs6JIdNQqniI-x0ABOzg-1; Thu,
 16 May 2024 16:09:43 -0400
X-MC-Unique: tBxs6JIdNQqniI-x0ABOzg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C670D3806711;
	Thu, 16 May 2024 20:09:42 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.17.148])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D1BF9C15BB1;
	Thu, 16 May 2024 20:09:41 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesse Gross <jesse@nicira.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Simon Horman <horms@ovn.org>,
	Jaime Caamano <jcaamano@redhat.com>
Subject: [PATCH v2 net] openvswitch: Set the skbuff pkt_type for proper pmtud support.
Date: Thu, 16 May 2024 16:09:41 -0400
Message-ID: <20240516200941.16152-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Open vSwitch is originally intended to switch at layer 2, only dealing with
Ethernet frames.  With the introduction of l3 tunnels support, it crossed
into the realm of needing to care a bit about some routing details when
making forwarding decisions.  If an oversized packet would need to be
fragmented during this forwarding decision, there is a chance for pmtu
to get involved and generate a routing exception.  This is gated by the
skbuff->pkt_type field.

When a flow is already loaded into the openvswitch module this field is
set up and transitioned properly as a packet moves from one port to
another.  In the case that a packet execute is invoked after a flow is
newly installed this field is not properly initialized.  This causes the
pmtud mechanism to omit sending the required exception messages across
the tunnel boundary and a second attempt needs to be made to make sure
that the routing exception is properly setup.  To fix this, we set the
outgoing packet's pkt_type to PACKET_OUTGOING, since it can only get
to the openvswitch module via a port device or packet command.

Even for bridge ports as users, the pkt_type needs to be reset when
doing the transmit as the packet is truly outgoing and routing needs
to get involved post packet transformations, in the case of
VXLAN/GENEVE/udp-tunnel packets.  In general, the pkt_type on output
gets ignored, since we go straight to the driver, but in the case of
tunnel ports they go through IP routing layer.

This issue is periodically encountered in complex setups, such as large
openshift deployments, where multiple sets of tunnel traversal occurs.
A way to recreate this is with the ovn-heater project that can setup
a networking environment which mimics such large deployments.  We need
larger environments for this because we need to ensure that flow
misses occur.  In these environment, without this patch, we can see:

  ./ovn_cluster.sh start
  podman exec ovn-chassis-1 ip r a 170.168.0.5/32 dev eth1 mtu 1200
  podman exec ovn-chassis-1 ip netns exec sw01p1 ip r flush cache
  podman exec ovn-chassis-1 ip netns exec sw01p1 \
         ping 21.0.0.3 -M do -s 1300 -c2
  PING 21.0.0.3 (21.0.0.3) 1300(1328) bytes of data.
  From 21.0.0.3 icmp_seq=2 Frag needed and DF set (mtu = 1142)

  --- 21.0.0.3 ping statistics ---
  ...

Using tcpdump, we can also see the expected ICMP FRAG_NEEDED message is not
sent into the server.

With this patch, setting the pkt_type, we see the following:

  podman exec ovn-chassis-1 ip netns exec sw01p1 \
         ping 21.0.0.3 -M do -s 1300 -c2
  PING 21.0.0.3 (21.0.0.3) 1300(1328) bytes of data.
  From 21.0.0.3 icmp_seq=1 Frag needed and DF set (mtu = 1222)
  ping: local error: message too long, mtu=1222

  --- 21.0.0.3 ping statistics ---
  ...

In this case, the first ping request receives the FRAG_NEEDED message and
a local routing exception is created.

Tested-by: Jaime Caamano <jcaamano@redhat.com>
Reported-at: https://issues.redhat.com/browse/FDP-164
Fixes: 58264848a5a7 ("openvswitch: Add vxlan tunneling support.")
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
v1->v2: Include a comment as requested by Eelco, and add some details about
        bridge port packets.

 net/openvswitch/actions.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 6fcd7e2ca81fe..9642255808247 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -936,6 +936,12 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 				pskb_trim(skb, ovs_mac_header_len(key));
 		}
 
+		/* Need to set the pkt_type to involve the routing layer.  The
+		 * packet movement through the OVS datapath doesn't generally
+		 * use routing, but this is needed for tunnel cases.
+		 */
+		skb->pkt_type = PACKET_OUTGOING;
+
 		if (likely(!mru ||
 		           (skb->len <= mru + vport->dev->hard_header_len))) {
 			ovs_vport_send(vport, skb, ovs_key_mac_proto(key));
-- 
2.45.0


