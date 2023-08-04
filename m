Return-Path: <netdev+bounces-24490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFF3770550
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A0B1C21342
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932881805F;
	Fri,  4 Aug 2023 15:54:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876F219882
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 15:54:13 +0000 (UTC)
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5BAB2;
	Fri,  4 Aug 2023 08:54:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [46.242.14.200])
	by mail.ispras.ru (Postfix) with ESMTPSA id 599B740737A6;
	Fri,  4 Aug 2023 15:54:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 599B740737A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1691164449;
	bh=YvUW9Cp+Mgnt3NWK0TLcArIpRQkO34R2ZFK4uY/nVAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3fmj5v0XOM8fy738lUg5Z/9hLHpFdfPe6MKTPXqwVa9at2oGAbq7NWeNnCddU+qn
	 6tyEnnuur68eUKg99cSn5nsEiIIk4/59BJI4LXT6wZWxSRKzbNZV7PREX4D0y8ECS5
	 7Fx6ICbUXuKFNA1bB4mShBLs4XXLy7BZwLHPQkq8=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ido Schimmel <idosch@idosch.org>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH net v2] drivers: vxlan: vnifilter: free percpu vni stats on error path
Date: Fri,  4 Aug 2023 18:53:36 +0300
Message-ID: <20230804155337.18135-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ZMz7+Mk+OYj4q8xe@shredder>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In case rhashtable_lookup_insert_fast() fails inside vxlan_vni_add(), the
allocated percpu vni stats are not freed on the error path.

Introduce vxlan_vni_free() which would work as a nice wrapper to free
vxlan_vni_node resources properly.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 4095e0e1328a ("drivers: vxlan: vnifilter: per vni stats")
Suggested-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
v1->v2: per Ido Schimmel's suggestion, extract freeing vninode resources
into a separate function vxlan_vni_free() and tag the patch as for 'net'

 drivers/net/vxlan/vxlan_vnifilter.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index a3de081cda5e..c3ff30ab782e 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -713,6 +713,12 @@ static struct vxlan_vni_node *vxlan_vni_alloc(struct vxlan_dev *vxlan,
 	return vninode;
 }
 
+static void vxlan_vni_free(struct vxlan_vni_node *vninode)
+{
+	free_percpu(vninode->stats);
+	kfree(vninode);
+}
+
 static int vxlan_vni_add(struct vxlan_dev *vxlan,
 			 struct vxlan_vni_group *vg,
 			 u32 vni, union vxlan_addr *group,
@@ -740,7 +746,7 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 					    &vninode->vnode,
 					    vxlan_vni_rht_params);
 	if (err) {
-		kfree(vninode);
+		vxlan_vni_free(vninode);
 		return err;
 	}
 
@@ -763,8 +769,7 @@ static void vxlan_vni_node_rcu_free(struct rcu_head *rcu)
 	struct vxlan_vni_node *v;
 
 	v = container_of(rcu, struct vxlan_vni_node, rcu);
-	free_percpu(v->stats);
-	kfree(v);
+	vxlan_vni_free(v);
 }
 
 static int vxlan_vni_del(struct vxlan_dev *vxlan,
-- 
2.41.0


