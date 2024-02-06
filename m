Return-Path: <netdev+bounces-69469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A9884B606
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488091C234FC
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 13:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC3F130E2B;
	Tue,  6 Feb 2024 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuLF4pfJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D9E130E2C
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225116; cv=none; b=BIMp85Exd/PIl5EAhfJ4wZtvTExdT3+r2QQj1U97ZT06OOpFwc94DKn4S79yhFKpdsGCFjAxRtEQBvJrFXaeOdWsgybfTbd9oNqFGmNfOpV3c6iZGmsqE7iYJ4K87mTYWq05Qgfs0GEZA+DZUapfJxdKxw1lq9dYGiOdwYVE+ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225116; c=relaxed/simple;
	bh=R7Cokhvgy/RQS/XK2apws5BPwMw74SZCqCHT79SPBos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWlZlSIF9lFJGUGRNqYafS0flos7DqE9tpOWh7uDxrLsoV3fkjocw4vsRBfqle+wXdHXbbSMbDlDs7O06U8Sjo7CDxKQ7oPg6EyYI/gkxtu5nW/SLkfwKYXdI62nhhdmeOvSuMNghHMWj6wNyJnbC4GQhnTXTmT5Y5u6xmVdMMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EuLF4pfJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707225112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amgb4Ydy8dxoLqJDv8UgR/Q/x3DQi0pF+4tJDUHewaU=;
	b=EuLF4pfJa3W/XWeHKkgH1Mk7Xq4eDKs/0mvgA+xj1Am868Dlf5pix9tgB3o5CiQYbtjVV2
	at6IEJDWqoqFuMWjQHLXzoPHXsJm+0JPawTasQgM8qnSaUbgtXtihItwaVAnBtaUtxz9Qd
	9MxdxHq6MRuJEEAAYV3i+rKQwNNVi/g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-Hz1neYocOmWr7yQyzk4_yw-1; Tue, 06 Feb 2024 08:11:49 -0500
X-MC-Unique: Hz1neYocOmWr7yQyzk4_yw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A905983FC25;
	Tue,  6 Feb 2024 13:11:48 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.8.151])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3F5B72026D06;
	Tue,  6 Feb 2024 13:11:48 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	dev@openvswitch.org,
	Ilya Maximets <i.maximets@ovn.org>,
	Simon Horman <horms@ovn.org>,
	Eelco Chaudron <echaudro@redhat.com>
Subject: [PATCH net 1/2] net: openvswitch: limit the number of recursions from action sets
Date: Tue,  6 Feb 2024 08:11:46 -0500
Message-ID: <20240206131147.1286530-2-aconole@redhat.com>
In-Reply-To: <20240206131147.1286530-1-aconole@redhat.com>
References: <20240206131147.1286530-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

The ovs module allows for some actions to recursively contain an action
list for complex scenarios, such as sampling, checking lengths, etc.
When these actions are copied into the internal flow table, they are
evaluated to validate that such actions make sense, and these calls
happen recursively.

The ovs-vswitchd userspace won't emit more than 16 recursion levels
deep.  However, the module has no such limit and will happily accept
limits larger than 16 levels nested.  Prevent this by tracking the
number of recursions happening and manually limiting it to 16 levels
nested.

The initial implementation of the sample action would track this depth
and prevent more than 3 levels of recursion, but this was removed to
support the clone use case, rather than limited at the current userspace
limit.

Fixes: 798c166173ff ("openvswitch: Optimize sample action for the clone use cases")
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 net/openvswitch/flow_netlink.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 88965e2068ac..ba5cfa67a720 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -48,6 +48,9 @@ struct ovs_len_tbl {
 
 #define OVS_ATTR_NESTED -1
 #define OVS_ATTR_VARIABLE -2
+#define OVS_COPY_ACTIONS_MAX_DEPTH 16
+
+static DEFINE_PER_CPU(int, copy_actions_depth);
 
 static bool actions_may_change_flow(const struct nlattr *actions)
 {
@@ -3148,11 +3151,11 @@ static int copy_action(const struct nlattr *from,
 	return 0;
 }
 
-static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
-				  const struct sw_flow_key *key,
-				  struct sw_flow_actions **sfa,
-				  __be16 eth_type, __be16 vlan_tci,
-				  u32 mpls_label_count, bool log)
+static int ___ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
+				   const struct sw_flow_key *key,
+				   struct sw_flow_actions **sfa,
+				   __be16 eth_type, __be16 vlan_tci,
+				   u32 mpls_label_count, bool log)
 {
 	u8 mac_proto = ovs_key_mac_proto(key);
 	const struct nlattr *a;
@@ -3478,6 +3481,26 @@ static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 	return 0;
 }
 
+static int __ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
+				  const struct sw_flow_key *key,
+				  struct sw_flow_actions **sfa,
+				  __be16 eth_type, __be16 vlan_tci,
+				  u32 mpls_label_count, bool log)
+{
+	int level = this_cpu_read(copy_actions_depth);
+	int ret;
+
+	if (level > OVS_COPY_ACTIONS_MAX_DEPTH)
+		return -EOVERFLOW;
+
+	__this_cpu_inc(copy_actions_depth);
+	ret = ___ovs_nla_copy_actions(net, attr, key, sfa, eth_type,
+				      vlan_tci, mpls_label_count, log);
+	__this_cpu_dec(copy_actions_depth);
+
+	return ret;
+}
+
 /* 'key' must be the masked key. */
 int ovs_nla_copy_actions(struct net *net, const struct nlattr *attr,
 			 const struct sw_flow_key *key,
-- 
2.41.0


