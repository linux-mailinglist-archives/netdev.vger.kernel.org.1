Return-Path: <netdev+bounces-67606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B9F8443F4
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 17:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2674D1C264AD
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 16:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C484F12BF0A;
	Wed, 31 Jan 2024 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/Vh+lZD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8DF12BF29
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717819; cv=none; b=k+as+1gMwJ0pj6ZzydUOsU/8f+o4DdYdLsZh76mhk1J6Zk3Uti8zE64MhKXBfM4DKEyfGE+t+TyrlgLEHXi47TMtQ0axKjUKJpm+yWuqobaTJeP2acz886IWZ27vfLINRk/zkfsim1VCPr3FvkMcPh6VsLRpJpeDQJBsAhPkexY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717819; c=relaxed/simple;
	bh=S+LAOBzBbsGLce3YEcEbKpLkY+B1uuYInBC/zcdcJCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwkneuUMUJpYMBlbquzRBNX9vCTDT14t2Q0h0w0zElkQTfuXcsav1O9HBXCQKGgZ9+2nzs4U8GKdsybie1bIxq06W3Ea4zVhzD+sogWkSd5miklxKAl8gDvKxRiCvA/OftDvvDz2QwRqQxB93zcstn1MHnJsMTfeiVMq2+ntX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/Vh+lZD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706717817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eaoaPqae0QGkUTYmUGfhPd0Bl0iReDOAQW04C8x8OtM=;
	b=I/Vh+lZD1KVIyRWmDsLVQT8Ull45SDxxNoH6TVE6DZE31q4tX9bau0YZfRA1985Z339R4r
	uQVHYjnYjv2HpVyungWZd1rNBNH/rkSeQ0Dxu5JjgJZBC17+uijKHIEf7x7Uv7dnyYLj2c
	Fb1Z5jTVL3PV9p73o7QEI4xgfXSRMtk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-e1niTZsgPgWk2kqCqLvPew-1; Wed, 31 Jan 2024 11:16:51 -0500
X-MC-Unique: e1niTZsgPgWk2kqCqLvPew-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA4758493EA;
	Wed, 31 Jan 2024 16:16:50 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.226.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CBC3A492BC6;
	Wed, 31 Jan 2024 16:16:48 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next 1/2] flow_dissector: add support for tunnel control flags
Date: Wed, 31 Jan 2024 17:13:24 +0100
Message-ID: <1e7f0f6ddf38d85d3b0eecdb0dc3389c27ea7d2a.1706714667.git.dcaratti@redhat.com>
In-Reply-To: <cover.1706714667.git.dcaratti@redhat.com>
References: <cover.1706714667.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

dissect [no]csum, [no]dontfrag, [no]oam flags on 'external' tunnels. This
is a prerequisite for matching these control flags using TC flower.

Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 include/net/flow_dissector.h | 11 +++++++++++
 net/core/flow_dissector.c    | 13 ++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 1a7131d6cb0e..98a0050d5cc3 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -329,6 +329,16 @@ struct flow_dissector_key_cfm {
 #define FLOW_DIS_CFM_MDL_MASK GENMASK(7, 5)
 #define FLOW_DIS_CFM_MDL_MAX 7
 
+/**
+ * struct flow_dissector_key_enc_flags
+ * @flags: tunnel control flags
+ */
+struct flow_dissector_key_enc_flags {
+	__be16 flags;
+};
+
+#define TUNNEL_FLAGS_PRESENT (TUNNEL_CSUM | TUNNEL_DONT_FRAGMENT | TUNNEL_OAM)
+
 enum flow_dissector_key_id {
 	FLOW_DISSECTOR_KEY_CONTROL, /* struct flow_dissector_key_control */
 	FLOW_DISSECTOR_KEY_BASIC, /* struct flow_dissector_key_basic */
@@ -363,6 +373,7 @@ enum flow_dissector_key_id {
 	FLOW_DISSECTOR_KEY_L2TPV3, /* struct flow_dissector_key_l2tpv3 */
 	FLOW_DISSECTOR_KEY_CFM, /* struct flow_dissector_key_cfm */
 	FLOW_DISSECTOR_KEY_IPSEC, /* struct flow_dissector_key_ipsec */
+	FLOW_DISSECTOR_KEY_ENC_FLAGS, /* struct flow_dissector_key_enc_flags */
 
 	FLOW_DISSECTOR_KEY_MAX,
 };
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 272f09251343..9099a5524d7c 100644
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
@@ -467,6 +469,15 @@ skb_flow_dissect_tunnel_info(const struct sk_buff *skb,
 						TUNNEL_OPTIONS_PRESENT;
 		}
 	}
+
+	if (dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_ENC_FLAGS)) {
+		struct flow_dissector_key_enc_flags *enc_flags;
+
+		enc_flags = skb_flow_dissector_target(flow_dissector,
+						      FLOW_DISSECTOR_KEY_ENC_FLAGS,
+						      target_container);
+		enc_flags->flags = info->key.tun_flags & TUNNEL_FLAGS_PRESENT;
+	}
 }
 EXPORT_SYMBOL(skb_flow_dissect_tunnel_info);
 
-- 
2.43.0


