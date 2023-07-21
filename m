Return-Path: <netdev+bounces-19868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DF675CA0E
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F17B2822DF
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A0A1ED2A;
	Fri, 21 Jul 2023 14:31:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4444A200C1
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:31:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2FF2D4E
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689949877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EO1EjUeEM2FdtGmMhGZcpdnFWMRNEynSBoYOGK+Uh4c=;
	b=XO28wN2wpafAL6kz+cn9fUO+x5lO9QdPEWJ3B14fLGA7SO/dkUOljAqgf3D+IKkXq31TDH
	NGk3NsjZQJQRU5FbmyKxLzfkAkJTO1U8Vb33nKy+yyA01SkZCdz8aPG42srfkTvuoQwj01
	6uc2KXmhlJ0ed7axGvevVkiP+kdEKVo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-DVxifOCfOMCUoXrBxLUDrQ-1; Fri, 21 Jul 2023 10:31:14 -0400
X-MC-Unique: DVxifOCfOMCUoXrBxLUDrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFB68856F66;
	Fri, 21 Jul 2023 14:31:13 +0000 (UTC)
Received: from griffin.upir.cz (unknown [10.45.225.158])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C38954094DC0;
	Fri, 21 Jul 2023 14:31:12 +0000 (UTC)
From: Jiri Benc <jbenc@redhat.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net 2/2] vxlan: fix GRO with VXLAN-GPE
Date: Fri, 21 Jul 2023 16:30:47 +0200
Message-Id: <a083fa73b53375d3d1d115753937b93944d37d62.1689949686.git.jbenc@redhat.com>
In-Reply-To: <cover.1689949686.git.jbenc@redhat.com>
References: <cover.1689949686.git.jbenc@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In VXLAN-GPE, there may not be an Ethernet header following the VXLAN
header. But in GRO, the vxlan driver calls eth_gro_receive
unconditionally, which means the following header is incorrectly parsed
as Ethernet.

Introduce GPE specific GRO handling.

For better performance, do not check for GPE during GRO but rather
install a different set of functions at setup time.

Fixes: e1e5314de08ba ("vxlan: implement GPE")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jiri Benc <jbenc@redhat.com>
---
 drivers/net/vxlan/vxlan_core.c | 84 ++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 15 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 6d82adf1f8b3..c9a9373733c0 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -675,26 +675,24 @@ static struct vxlanhdr *vxlan_gro_remcsum(struct sk_buff *skb,
 	return vh;
 }
 
-static struct sk_buff *vxlan_gro_receive(struct sock *sk,
-					 struct list_head *head,
-					 struct sk_buff *skb)
+static struct vxlanhdr *vxlan_gro_prepare_receive(struct sock *sk,
+						  struct list_head *head,
+						  struct sk_buff *skb,
+						  struct gro_remcsum *grc)
 {
-	struct sk_buff *pp = NULL;
 	struct sk_buff *p;
 	struct vxlanhdr *vh, *vh2;
 	unsigned int hlen, off_vx;
-	int flush = 1;
 	struct vxlan_sock *vs = rcu_dereference_sk_user_data(sk);
 	__be32 flags;
-	struct gro_remcsum grc;
 
-	skb_gro_remcsum_init(&grc);
+	skb_gro_remcsum_init(grc);
 
 	off_vx = skb_gro_offset(skb);
 	hlen = off_vx + sizeof(*vh);
 	vh = skb_gro_header(skb, hlen, off_vx);
 	if (unlikely(!vh))
-		goto out;
+		return NULL;
 
 	skb_gro_postpull_rcsum(skb, vh, sizeof(struct vxlanhdr));
 
@@ -702,12 +700,12 @@ static struct sk_buff *vxlan_gro_receive(struct sock *sk,
 
 	if ((flags & VXLAN_HF_RCO) && (vs->flags & VXLAN_F_REMCSUM_RX)) {
 		vh = vxlan_gro_remcsum(skb, off_vx, vh, sizeof(struct vxlanhdr),
-				       vh->vx_vni, &grc,
+				       vh->vx_vni, grc,
 				       !!(vs->flags &
 					  VXLAN_F_REMCSUM_NOPARTIAL));
 
 		if (!vh)
-			goto out;
+			return NULL;
 	}
 
 	skb_gro_pull(skb, sizeof(struct vxlanhdr)); /* pull vxlan header */
@@ -724,12 +722,48 @@ static struct sk_buff *vxlan_gro_receive(struct sock *sk,
 		}
 	}
 
-	pp = call_gro_receive(eth_gro_receive, head, skb);
-	flush = 0;
+	return vh;
+}
+
+static struct sk_buff *vxlan_gro_receive(struct sock *sk,
+					 struct list_head *head,
+					 struct sk_buff *skb)
+{
+	struct sk_buff *pp = NULL;
+	struct gro_remcsum grc;
+	int flush = 1;
 
-out:
+	if (vxlan_gro_prepare_receive(sk, head, skb, &grc)) {
+		pp = call_gro_receive(eth_gro_receive, head, skb);
+		flush = 0;
+	}
 	skb_gro_flush_final_remcsum(skb, pp, flush, &grc);
+	return pp;
+}
 
+static struct sk_buff *vxlan_gpe_gro_receive(struct sock *sk,
+					     struct list_head *head,
+					     struct sk_buff *skb)
+{
+	const struct packet_offload *ptype;
+	struct sk_buff *pp = NULL;
+	struct gro_remcsum grc;
+	struct vxlanhdr *vh;
+	__be16 protocol;
+	int flush = 1;
+
+	vh = vxlan_gro_prepare_receive(sk, head, skb, &grc);
+	if (vh) {
+		if (!vxlan_parse_gpe_proto(vh, &protocol))
+			goto out;
+		ptype = gro_find_receive_by_type(protocol);
+		if (!ptype)
+			goto out;
+		pp = call_gro_receive(ptype->callbacks.gro_receive, head, skb);
+		flush = 0;
+	}
+out:
+	skb_gro_flush_final_remcsum(skb, pp, flush, &grc);
 	return pp;
 }
 
@@ -741,6 +775,21 @@ static int vxlan_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
 	return eth_gro_complete(skb, nhoff + sizeof(struct vxlanhdr));
 }
 
+static int vxlan_gpe_gro_complete(struct sock *sk, struct sk_buff *skb, int nhoff)
+{
+	struct vxlanhdr *vh = (struct vxlanhdr *)(skb->data + nhoff);
+	const struct packet_offload *ptype;
+	int err = -ENOSYS;
+	__be16 protocol;
+
+	if (!vxlan_parse_gpe_proto(vh, &protocol))
+		return err;
+	ptype = gro_find_complete_by_type(protocol);
+	if (ptype)
+		err = ptype->callbacks.gro_complete(skb, nhoff + sizeof(struct vxlanhdr));
+	return err;
+}
+
 static struct vxlan_fdb *vxlan_fdb_alloc(struct vxlan_dev *vxlan, const u8 *mac,
 					 __u16 state, __be32 src_vni,
 					 __u16 ndm_flags)
@@ -3376,8 +3425,13 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 	tunnel_cfg.encap_rcv = vxlan_rcv;
 	tunnel_cfg.encap_err_lookup = vxlan_err_lookup;
 	tunnel_cfg.encap_destroy = NULL;
-	tunnel_cfg.gro_receive = vxlan_gro_receive;
-	tunnel_cfg.gro_complete = vxlan_gro_complete;
+	if (vs->flags & VXLAN_F_GPE) {
+		tunnel_cfg.gro_receive = vxlan_gpe_gro_receive;
+		tunnel_cfg.gro_complete = vxlan_gpe_gro_complete;
+	} else {
+		tunnel_cfg.gro_receive = vxlan_gro_receive;
+		tunnel_cfg.gro_complete = vxlan_gro_complete;
+	}
 
 	setup_udp_tunnel_sock(net, sock, &tunnel_cfg);
 
-- 
2.39.2


