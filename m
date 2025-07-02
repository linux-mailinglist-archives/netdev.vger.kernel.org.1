Return-Path: <netdev+bounces-203416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5B0AF5D9C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA39168C2B
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4422DCF4B;
	Wed,  2 Jul 2025 15:50:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356003196D7;
	Wed,  2 Jul 2025 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751471455; cv=none; b=ETipOo0H6EKDeNcgVe48+0h7arh6dLqPKqG/kXB6cfnsNH2xffDYtgAj6oAKyruhvxitAnTf3HgN7//M5oQVBUsTZw6brblHnLe3f/AusypSoIjs2qTfWm694em2UGDHCDPuFUnzLmc6wHLT+yqHOG7Uzp2ZX8ab0Xkoy2dloRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751471455; c=relaxed/simple;
	bh=rXl9fjEfpwaZdraoWtgZzi+cRlIET+T6L90WNnNp16c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PA6RZ3qenNklX98BMwfRHB3wxz7PLp6hnET6eAU9Ccnqjr7t2aC9w160VZVmuMIGdjzhBgtbwcera9/aQlKBp72lVQaAtc3H4Es6xDAkRpqsFa841gzvaNp696VLtt7mKNcYi+xF2oQ/V6hckGUtcQ9YM0nmJbL0Fpp0ampW0L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so99311a12.1;
        Wed, 02 Jul 2025 08:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751471451; x=1752076251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxOb+PbOFEgMmYtt0JJY38dQ1TlX0dPC8xti6YRO3hs=;
        b=aaDHZZk7R7LtPjq0SAf99tYL1Kn6DjnTIq66YUDHdJ1IAMiCx7+ulR8ZOr1QEer8Hf
         p0WFnul8tI00fRqjs4qPLlLQGW0zDASddGFjVAjlZo4NXQTkgjBCz4OZdLyRFJMgmkf4
         5bG1H3UJGu11t0bQXA3nREN2CTNGfXfVpepIl3h8Tm0BEd0sgoLpooenTtbfpuyxT+0Y
         w5TKXNEKZBuQEqs+b2/md/IU747QBvbZA838NOj4LUuzNPG/AYuggAV5YsHiVhu6XKri
         D4bQ72ApcpWnbK7UsBVSxO5djDkFn6SDLc8K7+0xuy62sA6lx1E51ENKfdPiS8tOwmlw
         +2Iw==
X-Forwarded-Encrypted: i=1; AJvYcCV4Ihsoyxgx5zcIKDn87v+oAVEyddoFcHHstPToi49tSAlUtz1ALHMKKDdCXdzpU8pcQuU5m8QVh76ZvSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysA8ZU9HH2LF4bSf/+0AqHowUK4sPMbceFLXfUcN/za/WCMSdB
	7f5qxZdzG3ycG9JbcRnmTTMKgZmPyIojrzP0UMftMap0YyiIQA3HibV0I8u4c2zq
X-Gm-Gg: ASbGnctKDEgn4RF4iHscxA5ATS3bkC0p7DIqWHZ+7Tzp7YJ0cLzBHvnKHmIfN+cKEzW
	KeCVUxFPcRlnweWJYxlJen/uOckGQkdnBF4K1fHE4NkXVCScgY+GbdmwnQ1wa5rCaJSsda9Wevb
	KNnp1+J8lxxSuEHxuG6i49YiJ//Q3mwvXijhLcX5sV/79+IPizdzbYCl1UdSkZpdqzUdDXX16UF
	d+dAJ+z2mbaEowCiOACPa93Si6Y1fHosqPWiuXFgIEtG0ZQ5QGy8Pr3TNzrwvzv8hIqqeKs8YtQ
	i5NscMmPDEkaMHZegKA9DNmJWD5xvHru4hKFGzSxxjuSfcjgQijEgJDzXUYuA+uraAJIEOv/xZk
	ZdziB6JafgRkf4ssv9YMqoIF3Qt6dpa9BB4Y=
X-Google-Smtp-Source: AGHT+IGIFWClN7FG2LxJf6JIgwXPAcWnX8Q05AG8SBIEgRfX2l1NGIaPtQMkSYnKCphHAfJZRZ7pzQ==
X-Received: by 2002:a05:6402:26c1:b0:601:a16e:4827 with SMTP id 4fb4d7f45d1cf-60e6ddf2d9fmr54507a12.3.1751471450987;
        Wed, 02 Jul 2025 08:50:50 -0700 (PDT)
Received: from im-t490s.redhat.com (78-80-97-102.customers.tmcz.cz. [78.80.97.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828b75a8sm9348218a12.10.2025.07.02.08.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 08:50:50 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next v2] net: openvswitch: allow providing upcall pid for the 'execute' command
Date: Wed,  2 Jul 2025 17:50:34 +0200
Message-ID: <20250702155043.2331772-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a packet enters OVS datapath and there is no flow to handle it,
packet goes to userspace through a MISS upcall.  With per-CPU upcall
dispatch mechanism, we're using the current CPU id to select the
Netlink PID on which to send this packet.  This allows us to send
packets from the same traffic flow through the same handler.

The handler will process the packet, install required flow into the
kernel and re-inject the original packet via OVS_PACKET_CMD_EXECUTE.

While handling OVS_PACKET_CMD_EXECUTE, however, we may hit a
recirculation action that will pass the (likely modified) packet
through the flow lookup again.  And if the flow is not found, the
packet will be sent to userspace again through another MISS upcall.

However, the handler thread in userspace is likely running on a
different CPU core, and the OVS_PACKET_CMD_EXECUTE request is handled
in the syscall context of that thread.  So, when the time comes to
send the packet through another upcall, the per-CPU dispatch will
choose a different Netlink PID, and this packet will end up processed
by a different handler thread on a different CPU.

The process continues as long as there are new recirculations, each
time the packet goes to a different handler thread before it is sent
out of the OVS datapath to the destination port.  In real setups the
number of recirculations can go up to 4 or 5, sometimes more.

There is always a chance to re-order packets while processing upcalls,
because userspace will first install the flow and then re-inject the
original packet.  So, there is a race window when the flow is already
installed and the second packet can match it and be forwarded to the
destination before the first packet is re-injected.  But the fact that
packets are going through multiple upcalls handled by different
userspace threads makes the reordering noticeably more likely, because
we not only have a race between the kernel and a userspace handler
(which is hard to avoid), but also between multiple userspace handlers.

For example, let's assume that 10 packets got enqueued through a MISS
upcall for handler-1, it will start processing them, will install the
flow into the kernel and start re-injecting packets back, from where
they will go through another MISS to handler-2.  Handler-2 will install
the flow into the kernel and start re-injecting the packets, while
handler-1 continues to re-inject the last of the 10 packets, they will
hit the flow installed by handler-2 and be forwarded without going to
the handler-2, while handler-2 still re-injects the first of these 10
packets.  Given multiple recirculations and misses, these 10 packets
may end up completely mixed up on the output from the datapath.

Let's allow userspace to specify on which Netlink PID the packets
should be upcalled while processing OVS_PACKET_CMD_EXECUTE.
This makes it possible to ensure that all the packets are processed
by the same handler thread in the userspace even with them being
upcalled multiple times in the process.  Packets will remain in order
since they will be enqueued to the same socket and re-injected in the
same order.  This doesn't eliminate re-ordering as stated above, since
we still have a race between kernel and the userspace thread, but it
allows to eliminate races between multiple userspace threads.

Userspace knows the PID of the socket on which the original upcall is
received, so there is no need to send it up from the kernel.

Solution requires storing the value somewhere for the duration of the
packet processing.  There are two potential places for this: our skb
extension or the per-CPU storage.  It's not clear which is better,
so just following currently used scheme of storing this kind of things
along the skb.  We still have a decent amount of space in the cb.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---

Version 2:
  * Converted to use nla_get_u32_default() instead of plain-coding it.

Version 1:
  * https://lore.kernel.org/netdev/20250627220219.1504221-1-i.maximets@ovn.org/

 include/uapi/linux/openvswitch.h | 6 ++++++
 net/openvswitch/actions.c        | 6 ++++--
 net/openvswitch/datapath.c       | 8 +++++++-
 net/openvswitch/datapath.h       | 3 +++
 net/openvswitch/vport.c          | 1 +
 5 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
index 3a701bd1f31b..3092c2c6f1d2 100644
--- a/include/uapi/linux/openvswitch.h
+++ b/include/uapi/linux/openvswitch.h
@@ -186,6 +186,11 @@ enum ovs_packet_cmd {
  * %OVS_PACKET_ATTR_USERSPACE action specify the Maximum received fragment
  * size.
  * @OVS_PACKET_ATTR_HASH: Packet hash info (e.g. hash, sw_hash and l4_hash in skb).
+ * @OVS_PACKET_ATTR_UPCALL_PID: Netlink PID to use for upcalls while
+ * processing %OVS_PACKET_CMD_EXECUTE.  Takes precedence over all other ways
+ * to determine the Netlink PID including %OVS_USERSPACE_ATTR_PID,
+ * %OVS_DP_ATTR_UPCALL_PID, %OVS_DP_ATTR_PER_CPU_PIDS and the
+ * %OVS_VPORT_ATTR_UPCALL_PID.
  *
  * These attributes follow the &struct ovs_header within the Generic Netlink
  * payload for %OVS_PACKET_* commands.
@@ -205,6 +210,7 @@ enum ovs_packet_attr {
 	OVS_PACKET_ATTR_MRU,	    /* Maximum received IP fragment size. */
 	OVS_PACKET_ATTR_LEN,	    /* Packet size before truncation. */
 	OVS_PACKET_ATTR_HASH,	    /* Packet hash. */
+	OVS_PACKET_ATTR_UPCALL_PID, /* u32 Netlink PID. */
 	__OVS_PACKET_ATTR_MAX
 };
 
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 3add108340bf..2832e0794197 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -941,8 +941,10 @@ static int output_userspace(struct datapath *dp, struct sk_buff *skb,
 			break;
 
 		case OVS_USERSPACE_ATTR_PID:
-			if (dp->user_features &
-			    OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
+			if (OVS_CB(skb)->upcall_pid)
+				upcall.portid = OVS_CB(skb)->upcall_pid;
+			else if (dp->user_features &
+				 OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
 				upcall.portid =
 				  ovs_dp_get_upcall_portid(dp,
 							   smp_processor_id());
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index b990dc83504f..d5b6e2002bc1 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -267,7 +267,9 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 		memset(&upcall, 0, sizeof(upcall));
 		upcall.cmd = OVS_PACKET_CMD_MISS;
 
-		if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
+		if (OVS_CB(skb)->upcall_pid)
+			upcall.portid = OVS_CB(skb)->upcall_pid;
+		else if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU)
 			upcall.portid =
 			    ovs_dp_get_upcall_portid(dp, smp_processor_id());
 		else
@@ -651,6 +653,9 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
 			       !!(hash & OVS_PACKET_HASH_L4_BIT));
 	}
 
+	OVS_CB(packet)->upcall_pid =
+		nla_get_u32_default(a[OVS_PACKET_ATTR_UPCALL_PID], 0);
+
 	/* Build an sw_flow for sending this packet. */
 	flow = ovs_flow_alloc();
 	err = PTR_ERR(flow);
@@ -719,6 +724,7 @@ static const struct nla_policy packet_policy[OVS_PACKET_ATTR_MAX + 1] = {
 	[OVS_PACKET_ATTR_PROBE] = { .type = NLA_FLAG },
 	[OVS_PACKET_ATTR_MRU] = { .type = NLA_U16 },
 	[OVS_PACKET_ATTR_HASH] = { .type = NLA_U64 },
+	[OVS_PACKET_ATTR_UPCALL_PID] = { .type = NLA_U32 },
 };
 
 static const struct genl_small_ops dp_packet_genl_ops[] = {
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index cfeb817a1889..db0c3e69d66c 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -121,6 +121,8 @@ struct datapath {
  * @cutlen: The number of bytes from the packet end to be removed.
  * @probability: The sampling probability that was applied to this skb; 0 means
  * no sampling has occurred; U32_MAX means 100% probability.
+ * @upcall_pid: Netlink socket PID to use for sending this packet to userspace;
+ * 0 means "not set" and default per-CPU or per-vport dispatch should be used.
  */
 struct ovs_skb_cb {
 	struct vport		*input_vport;
@@ -128,6 +130,7 @@ struct ovs_skb_cb {
 	u16			acts_origlen;
 	u32			cutlen;
 	u32			probability;
+	u32			upcall_pid;
 };
 #define OVS_CB(skb) ((struct ovs_skb_cb *)(skb)->cb)
 
diff --git a/net/openvswitch/vport.c b/net/openvswitch/vport.c
index 8732f6e51ae5..6bbbc16ab778 100644
--- a/net/openvswitch/vport.c
+++ b/net/openvswitch/vport.c
@@ -501,6 +501,7 @@ int ovs_vport_receive(struct vport *vport, struct sk_buff *skb,
 	OVS_CB(skb)->mru = 0;
 	OVS_CB(skb)->cutlen = 0;
 	OVS_CB(skb)->probability = 0;
+	OVS_CB(skb)->upcall_pid = 0;
 	if (unlikely(dev_net(skb->dev) != ovs_dp_get_net(vport->dp))) {
 		u32 mark;
 
-- 
2.49.0


