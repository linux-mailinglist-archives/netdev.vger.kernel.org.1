Return-Path: <netdev+bounces-78452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386528752FE
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED2E1C240A2
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 15:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037AE12F37C;
	Thu,  7 Mar 2024 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gH2GygwX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE3B12F372
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824743; cv=none; b=ZP4Cn/rQ33w569it0BIeB9l3Ch4xFFfBUifhHQaerlrzw7zmAjf6Jx74usRnZTFpY8ZCzQOEbIAooLWzPUDImU6YTJfV3YdYbcSA0HlK8DZMUzbw6D1eGyd04vqqU86J+cwm+w6WZw/t4YDEIQHH83+eNaIBsf9KOxM28S4O++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824743; c=relaxed/simple;
	bh=sFGcwT4zSlXTAgrD64IPFUcwbdDcIM4g2pBbRPOSOvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kN4uNxAOy8deYMkZjCETJMEO0AOda8Aq82VUKAiefskw2IxuLUxDyVaVWl9xy30vauVqptskmCciJ9U3rlOBokUBJ3Ei7uiI/nyMuanOTXPlfY6GLZuJcgzSG5ZteP2cVJLWHsR9Pgw/e8P2FKpbgJYyXpBBdoQhsOclS0Bhk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gH2GygwX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709824741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgWIo+01yUmFTfU9I51yM2BY83EjFcVmrwEVieX5L6k=;
	b=gH2GygwXnTuyqFETcNPw8J7kY//YPj4FoppZuYJUTmrtXrpMshxCM2Qdxbj3v7QhP0gFe7
	m3kmg8gGd6OnjJ/t+7wTD2kqMKwXHNnCzdVcGPGL0vmwKeT62rf2sGG34qg7bKOffwHxlA
	WmDhBFsC8ZGrEkGYeY/iFdZSsHPZe8c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-sam_km4wNbaX2iHTQBUDhg-1; Thu,
 07 Mar 2024 10:18:56 -0500
X-MC-Unique: sam_km4wNbaX2iHTQBUDhg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 710EF29AB42E;
	Thu,  7 Mar 2024 15:18:56 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.194.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EF6A12166B33;
	Thu,  7 Mar 2024 15:18:54 +0000 (UTC)
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
Subject: [RFC PATCH 2/4] openvswitch:trace: Add ovs_dp_monitor tracepoint.
Date: Thu,  7 Mar 2024 16:18:46 +0100
Message-ID: <20240307151849.394962-3-amorenoz@redhat.com>
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

The existing dp_upcall tracepoint was intented to provide visibility on
flow-misses (what we typically refer as upcalls). It's used to measure
things like upcall latency.

However, if a monitoring userspace action (such as IPFIX) is
multicasted, using the same tracepoint will only add confusion as
ovs-vswithcd will not receive this upcall.

In order to make things clearer, create a new tracepoint called
"ovs_dp_monitor" and use it instead of the existing one for multicasted
packets.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/openvswitch/datapath.c          |  6 ++-
 net/openvswitch/openvswitch_trace.h | 71 +++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 15bad6f4b645..5a2c0b3b4112 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -316,12 +316,16 @@ int ovs_dp_upcall(struct datapath *dp, struct sk_buff *skb,
 		  const struct dp_upcall_info *upcall_info,
 		  uint32_t cutlen)
 {
+	const bool mcast = upcall_info->portid == MCAST_PID;
 	struct dp_stats_percpu *stats;
 	int err;
 
-	if (trace_ovs_dp_upcall_enabled())
+	if (!mcast && trace_ovs_dp_upcall_enabled())
 		trace_ovs_dp_upcall(dp, skb, key, upcall_info);
 
+	if (mcast && trace_ovs_dp_monitor_enabled())
+		trace_ovs_dp_monitor(dp, skb, key, upcall_info);
+
 	if (upcall_info->portid == 0) {
 		err = -ENOTCONN;
 		goto err;
diff --git a/net/openvswitch/openvswitch_trace.h b/net/openvswitch/openvswitch_trace.h
index 3eb35d9eb700..76e9612e3555 100644
--- a/net/openvswitch/openvswitch_trace.h
+++ b/net/openvswitch/openvswitch_trace.h
@@ -148,6 +148,77 @@ TRACE_EVENT(ovs_dp_upcall,
 		  __entry->upcall_mru)
 );
 
+TRACE_EVENT(ovs_dp_monitor,
+
+	TP_PROTO(struct datapath *dp, struct sk_buff *skb,
+		 const struct sw_flow_key *key,
+		 const struct dp_upcall_info *upcall_info),
+
+	TP_ARGS(dp, skb, key, upcall_info),
+
+	TP_STRUCT__entry(
+		__field(	void *,		dpaddr			)
+		__string(	dp_name,	ovs_dp_name(dp)		)
+		__string(	dev_name,	skb->dev->name		)
+		__field(	void *,		skbaddr			)
+		__field(	unsigned int,	len			)
+		__field(	unsigned int,	data_len		)
+		__field(	unsigned int,	truesize		)
+		__field(	u8,		nr_frags		)
+		__field(	u16,		gso_size		)
+		__field(	u16,		gso_type		)
+		__field(	u32,		ovs_flow_hash		)
+		__field(	u32,		recirc_id		)
+		__field(	const void *,	keyaddr			)
+		__field(	u16,		key_eth_type		)
+		__field(	u8,		key_ct_state		)
+		__field(	u8,		key_ct_orig_proto	)
+		__field(	u16,		key_ct_zone		)
+		__field(	unsigned int,	flow_key_valid		)
+		__field(	u32,		upcall_port		)
+		__field(	void *,		upcall_udata		)
+		__field(	u16,		upcall_ulen		)
+	),
+
+	TP_fast_assign(
+		__entry->dpaddr = dp;
+		__assign_str(dp_name, ovs_dp_name(dp));
+		__assign_str(dev_name, skb->dev->name);
+		__entry->skbaddr = skb;
+		__entry->len = skb->len;
+		__entry->data_len = skb->data_len;
+		__entry->truesize = skb->truesize;
+		__entry->nr_frags = skb_shinfo(skb)->nr_frags;
+		__entry->gso_size = skb_shinfo(skb)->gso_size;
+		__entry->gso_type = skb_shinfo(skb)->gso_type;
+		__entry->ovs_flow_hash = key->ovs_flow_hash;
+		__entry->recirc_id = key->recirc_id;
+		__entry->keyaddr = key;
+		__entry->key_eth_type = key->eth.type;
+		__entry->key_ct_state = key->ct_state;
+		__entry->key_ct_orig_proto = key->ct_orig_proto;
+		__entry->key_ct_zone = key->ct_zone;
+		__entry->flow_key_valid =  !(key->mac_proto & SW_FLOW_KEY_INVALID);
+		__entry->upcall_port = upcall_info->portid;
+		__entry->upcall_udata = upcall_info->userdata ?
+			nla_data(upcall_info->userdata): NULL;
+		__entry->upcall_ulen = upcall_info->userdata ?
+			nla_len(upcall_info->userdata): 0;
+	),
+
+	TP_printk("dpaddr=%p dp_name=%s dev=%s skbaddr=%p len=%u data_len=%u truesize=%u nr_frags=%d gso_size=%d gso_type=%#x ovs_flow_hash=0x%08x recirc_id=0x%08x keyaddr=%p eth_type=0x%04x ct_state=%02x ct_orig_proto=%02x ct_zone=%04x flow_key_valid=%d upcall_port=%u upcall_udata=%p upcall_ulen=%d",
+		  __entry->dpaddr, __get_str(dp_name), __get_str(dev_name),
+		  __entry->skbaddr, __entry->len, __entry->data_len,
+		  __entry->truesize, __entry->nr_frags, __entry->gso_size,
+		  __entry->gso_type, __entry->ovs_flow_hash,
+		  __entry->recirc_id, __entry->keyaddr, __entry->key_eth_type,
+		  __entry->key_ct_state, __entry->key_ct_orig_proto,
+		  __entry->key_ct_zone,
+		  __entry->flow_key_valid,
+		  __entry->upcall_port,
+		  __entry->upcall_udata, __entry->upcall_ulen)
+);
+
 #endif /* _TRACE_OPENVSWITCH_H */
 
 /* This part must be outside protection */
-- 
2.44.0


