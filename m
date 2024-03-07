Return-Path: <netdev+bounces-78451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4888752FD
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6169C1F23CB5
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 15:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27F812F365;
	Thu,  7 Mar 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRu90bBu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CE212EBEE
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824741; cv=none; b=Wxg4AHTn/2CJrT5ZKyBVvs7XjDOPQKR1SzzaXewV1GujPbyrnmxUy03d0k06Ajokf8EhJJsFvCndXbzWf65SrE/SOVcqUlL5RVcQWrE63QNK52EeNFsdkms+BrhY4we6Hn7NonrawEQBFh5YD6TnGX7YhZt2ny+/6X0uMfsp2U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824741; c=relaxed/simple;
	bh=eYbBcgQQpHaHj17bq7luIYk3vIVeQHh8Pm7j5u26JuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmKWYyv94ZbwrkB/ZDraKAAs6vkvBO3Sfcnbhb+E5xgiImzeAYPwmK0qSwBQcBbd2E6g5mkDmwf94b5XxPvtlPndX7bPiw/+985BRO9jfdYRTXmb7JRwm0qfqlgEAUR7UUZhwLlYNVGfuIjYuwxrwVYsGO50d/s1dhhAXh5Gc38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YRu90bBu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709824738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3QHk3gZDzu+lQdUT48rZodxOgOgf1lVBanw+R4FyF4=;
	b=YRu90bBuGpiXf33ppRpCf+P67I+W+x0LfciZkYOWCM16zZHeIndIAYvVEgaLsGyTxR56BF
	SwmXjCVYHwhIqc5fo5opr7vFRq2DzBojozEFeUdyAJoiS4a8NfRzHqfCFaKvZzt99Ffrlx
	oUQZ1ajyY6Wehdgwkn+FLEbX5BdLKO8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-qx3w7DA5NSiU9Qemm0VdHQ-1; Thu,
 07 Mar 2024 10:18:55 -0500
X-MC-Unique: qx3w7DA5NSiU9Qemm0VdHQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1BF93830092;
	Thu,  7 Mar 2024 15:18:54 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.194.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3A4172166B33;
	Thu,  7 Mar 2024 15:18:53 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org,
	dev@openvswitch.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	cmi@nvidia.com,
	yotam.gi@gmail.com,
	i.maximets@ovn.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org
Subject: [RFC PATCH 1/4] net:openvswitch: Support multicasting userspace ...
Date: Thu,  7 Mar 2024 16:18:45 +0100
Message-ID: <20240307151849.394962-2-amorenoz@redhat.com>
In-Reply-To: <20240307151849.394962-1-amorenoz@redhat.com>
References: <20240307151849.394962-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

actions.

Some userspace actions, such as the ones derived from OFP_CONTROLLER
action or slow path, have to be handled by ovs-vswitchd, so they are
unicasted through the netlink socket that corresponds.

However, some other userspace actions require little processing by
ovs-vswitchd and their end consumer is typically some external entity.
This is the case for IPFIX sampling which can provide very useful
observability on the OVS datapath.

Having these samples share the netlink socket and the userspace
cpu time with flow misses can easily lead to higher latency and packet
drops. This is clearly a price too high to pay for observability.

In order to allow observability applications safely consume data that
include OVN metadata, this patch makes the existing "ovs_packet"
netlink family also contain a multicast group and adds a new attribute
to the userspace action so that ovs-vswitchd can indicate that an
action must be multicasted.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 include/uapi/linux/openvswitch.h |  6 +++++-
 net/openvswitch/actions.c        |  5 +++++
 net/openvswitch/datapath.c       | 14 +++++++++++++-
 net/openvswitch/datapath.h       |  1 +
 net/openvswitch/flow_netlink.c   |  6 ++++--
 5 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
index efc82c318fa2..77525a1c648a 100644
--- a/include/uapi/linux/openvswitch.h
+++ b/include/uapi/linux/openvswitch.h
@@ -144,6 +144,7 @@ struct ovs_vport_stats {
 /* Packet transfer. */
 
 #define OVS_PACKET_FAMILY "ovs_packet"
+#define OVS_PACKET_MCGROUP "ovs_packet"
 #define OVS_PACKET_VERSION 0x1
 
 enum ovs_packet_cmd {
@@ -678,7 +679,8 @@ struct sample_arg {
 /**
  * enum ovs_userspace_attr - Attributes for %OVS_ACTION_ATTR_USERSPACE action.
  * @OVS_USERSPACE_ATTR_PID: u32 Netlink PID to which the %OVS_PACKET_CMD_ACTION
- * message should be sent.  Required.
+ * message should be sent. If the PID is 0, the message will be sent to the
+ * "ovs_packet" netlink multicast group. Required.
  * @OVS_USERSPACE_ATTR_USERDATA: If present, its variable-length argument is
  * copied to the %OVS_PACKET_CMD_ACTION message as %OVS_PACKET_ATTR_USERDATA.
  * @OVS_USERSPACE_ATTR_EGRESS_TUN_PORT: If present, u32 output port to get
@@ -692,6 +694,8 @@ enum ovs_userspace_attr {
 	OVS_USERSPACE_ATTR_EGRESS_TUN_PORT,  /* Optional, u32 output port
 					      * to get tunnel info. */
 	OVS_USERSPACE_ATTR_ACTIONS,   /* Optional flag to get actions. */
+	OVS_USERSPACE_ATTR_MCAST,     /* Optional flag to send the packet to
+					 the "ovs_packet" multicast group. */
 	__OVS_USERSPACE_ATTR_MAX
 };
 
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 6fcd7e2ca81f..c5774613faeb 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1004,6 +1004,11 @@ static int output_userspace(struct datapath *dp, struct sk_buff *skb,
 			break;
 		}
 
+		case OVS_USERSPACE_ATTR_MCAST: {
+			upcall.portid = MCAST_PID;
+			break;
+		}
+
 		} /* End of switch. */
 	}
 
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 11c69415c605..15bad6f4b645 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -70,6 +70,10 @@ static const struct genl_multicast_group ovs_dp_vport_multicast_group = {
 	.name = OVS_VPORT_MCGROUP,
 };
 
+static const struct genl_multicast_group ovs_dp_packet_multicast_group = {
+	.name = OVS_PACKET_MCGROUP,
+};
+
 /* Check if need to build a reply message.
  * OVS userspace sets the NLM_F_ECHO flag if it needs the reply. */
 static bool ovs_must_notify(struct genl_family *family, struct genl_info *info,
@@ -577,7 +581,13 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
 
 	((struct nlmsghdr *) user_skb->data)->nlmsg_len = user_skb->len;
 
-	err = genlmsg_unicast(ovs_dp_get_net(dp), user_skb, upcall_info->portid);
+	if (upcall_info->portid == MCAST_PID)
+		err = genlmsg_multicast_netns(&dp_packet_genl_family,
+			ovs_dp_get_net(dp), user_skb, 0, 0, GFP_KERNEL);
+	else
+		err = genlmsg_unicast(ovs_dp_get_net(dp),
+				      user_skb, upcall_info->portid);
+
 	user_skb = NULL;
 out:
 	if (err)
@@ -717,6 +727,8 @@ static struct genl_family dp_packet_genl_family __ro_after_init = {
 	.small_ops = dp_packet_genl_ops,
 	.n_small_ops = ARRAY_SIZE(dp_packet_genl_ops),
 	.resv_start_op = OVS_PACKET_CMD_EXECUTE + 1,
+	.mcgrps = &ovs_dp_packet_multicast_group,
+	.n_mcgrps = 1,
 	.module = THIS_MODULE,
 };
 
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 0cd29971a907..d0b1b8afafbb 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -124,6 +124,7 @@ struct ovs_skb_cb {
 };
 #define OVS_CB(skb) ((struct ovs_skb_cb *)(skb)->cb)
 
+#define MCAST_PID 0xFFFFFFFF
 /**
  * struct dp_upcall - metadata to include with a packet to send to userspace
  * @cmd: One of %OVS_PACKET_CMD_*.
diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index ebc5728aab4e..4c95fa1aa15d 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -3043,6 +3043,8 @@ static int validate_userspace(const struct nlattr *attr)
 		[OVS_USERSPACE_ATTR_PID] = {.type = NLA_U32 },
 		[OVS_USERSPACE_ATTR_USERDATA] = {.type = NLA_UNSPEC },
 		[OVS_USERSPACE_ATTR_EGRESS_TUN_PORT] = {.type = NLA_U32 },
+		[OVS_USERSPACE_ATTR_ACTIONS] = {.type = NLA_FLAG },
+		[OVS_USERSPACE_ATTR_MCAST] = {.type = NLA_FLAG },
 	};
 	struct nlattr *a[OVS_USERSPACE_ATTR_MAX + 1];
 	int error;
@@ -3052,8 +3054,8 @@ static int validate_userspace(const struct nlattr *attr)
 	if (error)
 		return error;
 
-	if (!a[OVS_USERSPACE_ATTR_PID] ||
-	    !nla_get_u32(a[OVS_USERSPACE_ATTR_PID]))
+	if (!a[OVS_USERSPACE_ATTR_MCAST] && (!a[OVS_USERSPACE_ATTR_PID] ||
+	    !nla_get_u32(a[OVS_USERSPACE_ATTR_PID])))
 		return -EINVAL;
 
 	return 0;
-- 
2.44.0


