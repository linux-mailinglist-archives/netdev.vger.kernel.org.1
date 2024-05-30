Return-Path: <netdev+bounces-99489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185078D50A8
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C682E283B3A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E594C601;
	Thu, 30 May 2024 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3IdGaVK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22499487B0
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717089086; cv=none; b=gtMyztRr9/XdykuWK2rotiwnOtrSBhkGBuT22A8DJ/FzNy16byiC2kESiA7oP+X0jKW8m/26K1y820uvq3MpGNy2b2j/QwgWi8o95cTBLgzcQhM93E7c3w4zuGeZ3pLK1njOLmAJnfR9nQesCNGbzAMHdZMsQNGCJpeUKxSO0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717089086; c=relaxed/simple;
	bh=PaiRxSVg+xvNUZvdy6hiEi480i/LSBZWShh5AzLhM8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBnJnMZfRRpQaEtcmDfieqvJ8wmc8pjqMwmp7gFFgz1A4C/rmpmOogt2yDjZlDKfA06GLGJklvbCi3C8yokK05JjrQtqCcCznUCSXrzbKD4ghzj4gaqrJd8Wp74V9sgOymNctf+DFoP4CK+XXiKNIb2/Yze/xFbq/iwbJvLJI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3IdGaVK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717089084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mR2wiewChIRvoQZBg0DrNOl7HSSeGxoz/pPpdsnNEoc=;
	b=d3IdGaVKfFwA72ei7fwvcbSoOHgRjNJDoDoUYed6K65kv+3PhIu4iZNo9sYYP2Av59XamJ
	SFhh4/cwgyUULk416QgSR6iCa5NRkGtLwdDfLlcmxilRj8rmXBBd0Md0lOlJ/hlY0d7cpC
	03eDccfmWgM25JqdKXpfCt7XKbGT9lo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-QEB3DiP1OsinRgcsppp3Ow-1; Thu, 30 May 2024 13:11:20 -0400
X-MC-Unique: QEB3DiP1OsinRgcsppp3Ow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B53C61839B77;
	Thu, 30 May 2024 17:11:19 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.224.83])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E98C8202696B;
	Thu, 30 May 2024 17:11:16 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: dcaratti@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	i.maximets@ovn.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com,
	echaudro@redhat.com
Subject: [PATCH net-next v4 1/2] flow_dissector: add support for tunnel control flags
Date: Thu, 30 May 2024 19:08:34 +0200
Message-ID: <f89d9bffac091e52a30c819211358eb8d066f156.1717088241.git.dcaratti@redhat.com>
In-Reply-To: <cover.1717088241.git.dcaratti@redhat.com>
References: <cover.1717088241.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Dissect [no]csum, [no]dontfrag, [no]oam, [no]crit flags from skb metadata.
This is a prerequisite for matching these control flags using TC flower.

Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 include/net/flow_dissector.h |  9 +++++++++
 include/net/ip_tunnels.h     | 12 ++++++++++++
 net/core/flow_dissector.c    | 16 +++++++++++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 9ab376d1a677..99626475c3f4 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -329,6 +329,14 @@ struct flow_dissector_key_cfm {
 #define FLOW_DIS_CFM_MDL_MASK GENMASK(7, 5)
 #define FLOW_DIS_CFM_MDL_MAX 7
 
+/**
+ * struct flow_dissector_key_enc_flags: tunnel metadata control flags
+ * @flags: tunnel control flags
+ */
+struct flow_dissector_key_enc_flags {
+	u32 flags;
+};
+
 enum flow_dissector_key_id {
 	FLOW_DISSECTOR_KEY_CONTROL, /* struct flow_dissector_key_control */
 	FLOW_DISSECTOR_KEY_BASIC, /* struct flow_dissector_key_basic */
@@ -363,6 +371,7 @@ enum flow_dissector_key_id {
 	FLOW_DISSECTOR_KEY_L2TPV3, /* struct flow_dissector_key_l2tpv3 */
 	FLOW_DISSECTOR_KEY_CFM, /* struct flow_dissector_key_cfm */
 	FLOW_DISSECTOR_KEY_IPSEC, /* struct flow_dissector_key_ipsec */
+	FLOW_DISSECTOR_KEY_ENC_FLAGS, /* struct flow_dissector_key_enc_flags */
 
 	FLOW_DISSECTOR_KEY_MAX,
 };
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 9a6a08ec7713..5a530d4fb02c 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -247,6 +247,18 @@ static inline bool ip_tunnel_is_options_present(const unsigned long *flags)
 	return ip_tunnel_flags_intersect(flags, present);
 }
 
+static inline void ip_tunnel_set_encflags_present(unsigned long *flags)
+{
+	IP_TUNNEL_DECLARE_FLAGS(present) = { };
+
+	__set_bit(IP_TUNNEL_CSUM_BIT, present);
+	__set_bit(IP_TUNNEL_DONT_FRAGMENT_BIT, present);
+	__set_bit(IP_TUNNEL_OAM_BIT, present);
+	__set_bit(IP_TUNNEL_CRIT_OPT_BIT, present);
+
+	ip_tunnel_flags_or(flags, flags, present);
+}
+
 static inline bool ip_tunnel_flags_is_be16_compat(const unsigned long *flags)
 {
 	IP_TUNNEL_DECLARE_FLAGS(supp) = { };
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index f82e9a7d3b37..59fe46077b3c 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -382,7 +382,9 @@ skb_flow_dissect_tunnel_info(const struct sk_buff *skb,
 	    !dissector_uses_key(flow_dissector,
 				FLOW_DISSECTOR_KEY_ENC_IP) &&
 	    !dissector_uses_key(flow_dissector,
-				FLOW_DISSECTOR_KEY_ENC_OPTS))
+				FLOW_DISSECTOR_KEY_ENC_OPTS) &&
+	    !dissector_uses_key(flow_dissector,
+				FLOW_DISSECTOR_KEY_ENC_FLAGS))
 		return;
 
 	info = skb_tunnel_info(skb);
@@ -475,6 +477,18 @@ skb_flow_dissect_tunnel_info(const struct sk_buff *skb,
 				    IP_TUNNEL_GENEVE_OPT_BIT);
 		enc_opt->dst_opt_type = val < __IP_TUNNEL_FLAG_NUM ? val : 0;
 	}
+
+	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_ENC_FLAGS)) {
+		struct flow_dissector_key_enc_flags *enc_flags;
+		IP_TUNNEL_DECLARE_FLAGS(flags) = {};
+
+		enc_flags = skb_flow_dissector_target(flow_dissector,
+						      FLOW_DISSECTOR_KEY_ENC_FLAGS,
+						      target_container);
+		ip_tunnel_set_encflags_present(flags);
+		ip_tunnel_flags_and(flags, flags, info->key.tun_flags);
+		enc_flags->flags = bitmap_read(flags, IP_TUNNEL_CSUM_BIT, 32);
+	}
 }
 EXPORT_SYMBOL(skb_flow_dissect_tunnel_info);
 
-- 
2.44.0


