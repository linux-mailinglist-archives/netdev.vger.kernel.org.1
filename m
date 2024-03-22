Return-Path: <netdev+bounces-81323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94927887391
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 20:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508D9284F36
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 19:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EFB77624;
	Fri, 22 Mar 2024 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WF0MXAbc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F09876EE1
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711134379; cv=none; b=qtpiAIkaWeL37sL9V/xygrnFCVtQbXkk68ym+iXiNQ0PRdqQ35EK8y0P0bCLbJg4o+nExmHKX8tlAK6JvB7td1EHNVqHGOSasTXHexi+z7zaGNQICazQ9QqFgBbb4bhF2RQq74sIYAY1cAXWRPPehva9HU9TIKIN1tw3ZdnkrL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711134379; c=relaxed/simple;
	bh=G8IGxwSbCA7VtBX8XkVa1ambOdnemi9fnCfUORqa5dI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k29me4fAlJUOuHrfMfgrC0YsnLCO8EYrKH6cFEkL7wSUvy0Mr4esXJSV+LUUNHxbHwrhvxMFBlS7vyOB06+/F0N2LwvXlag2Gls4RfqIWnsPbGz3HE//Zw2fZ7BgDVCnkqftQuybuDXa0kGvUyEg1I/1UCSgmUliT8DssrBw044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WF0MXAbc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711134376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bYv+g1I7ptnV6etPECbKRE2B/hEhZ4xk0E1ZHt/7Sok=;
	b=WF0MXAbc32d+0yKHCTUhrXPQuCU1Fg+cMiNHW9X4Ucv7EAUp8zskxytTq+9rV75aMESy2m
	78iy772wNHqBcCash4ntHCQ4an1m1MRiObbkTfGDEhP7pSZeoJj3ZuRaDpRhXl+8hk0ToU
	Sz2bf859u6GmgxPxaUMAykYvs4JdIk4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-gBjFs-OwO1uIF-FNgKwg-Q-1; Fri,
 22 Mar 2024 15:06:12 -0400
X-MC-Unique: gBjFs-OwO1uIF-FNgKwg-Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 214A7280480F;
	Fri, 22 Mar 2024 19:06:12 +0000 (UTC)
Received: from RHTPC1VM0NT.redhat.com (unknown [10.22.33.162])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 55FDA492BC6;
	Fri, 22 Mar 2024 19:06:11 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Numan Siddique <nusiddiq@redhat.com>
Subject: [PATCH net] openvswitch: Set the skbuff pkt_type for proper pmtud support.
Date: Fri, 22 Mar 2024 15:06:03 -0400
Message-ID: <20240322190603.251831-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

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

This issue is periodically encountered in complex setups, such as large
openshift deployments, where multiple sets of tunnel traversal occurs.
A way to recreate this is with the ovn-heater project that can setup
a networking environment which mimics such large deployments.  In that
environment, without this patch, we can see:

  ./ovn_cluster.sh start
  podman exec ovn-chassis-1 ip r a 170.168.0.5/32 dev eth1 mtu 1200
  podman exec ovn-chassis-1 ip netns exec sw01p1  ip r flush cache
  podman exec ovn-chassis-1 ip netns exec sw01p1 ping 21.0.0.3 -M do -s 1300 -c2
  PING 21.0.0.3 (21.0.0.3) 1300(1328) bytes of data.
  From 21.0.0.3 icmp_seq=2 Frag needed and DF set (mtu = 1142)

  --- 21.0.0.3 ping statistics ---
  2 packets transmitted, 0 received, +1 errors, 100% packet loss, time 1017ms

Using tcpdump, we can also see the expected ICMP FRAG_NEEDED message is not
sent into the server.

With this patch, setting the pkt_type, we see the following:

  podman exec ovn-chassis-1 ip netns exec sw01p1 ping 21.0.0.3 -M do -s 1300 -c2
  PING 21.0.0.3 (21.0.0.3) 1300(1328) bytes of data.
  From 21.0.0.3 icmp_seq=1 Frag needed and DF set (mtu = 1222)
  ping: local error: message too long, mtu=1222

  --- 21.0.0.3 ping statistics ---
  2 packets transmitted, 0 received, +2 errors, 100% packet loss, time 1061ms

In this case, the first ping request receives the FRAG_NEEDED message and
a local routing exception is created.

Reported-at: https://issues.redhat.com/browse/FDP-164
Fixes: 58264848a5a7 ("openvswitch: Add vxlan tunneling support.")
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
NOTE: An alternate approach would be to add a netlink attribute to preserve
      pkt_type across the kernel->user boundary, but that does require some
      userspace cooperation.

 net/openvswitch/actions.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 6fcd7e2ca81fe..952c6292100d0 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -936,6 +936,8 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 				pskb_trim(skb, ovs_mac_header_len(key));
 		}
 
+		skb->pkt_type = PACKET_OUTGOING;
+
 		if (likely(!mru ||
 		           (skb->len <= mru + vport->dev->hard_header_len))) {
 			ovs_vport_send(vport, skb, ovs_key_mac_proto(key));
-- 
2.41.0


