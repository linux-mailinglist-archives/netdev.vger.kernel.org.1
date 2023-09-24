Return-Path: <netdev+bounces-36014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C187AC71D
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 10:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 8C53D1C20832
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 08:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1B0A4F;
	Sun, 24 Sep 2023 08:03:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C002065B
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 08:03:14 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CDC10B
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 01:03:11 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id kK56qpUBLqQHikK57qsa0Q; Sun, 24 Sep 2023 10:03:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1695542590;
	bh=u45atJv1BtkgA8BuqIIa8D3M4GDg5T72SV54ytqq6ds=;
	h=From:To:Cc:Subject:Date;
	b=dQ3XcACW9ta7AnZyfPgpVGsN/g48nPB37c5JGi9GvpVYsFrpFjdO3OTZN4CzJ1nzA
	 1WMkzjKVtrJvAGKEDVaq1JhOpmVdcfnBvbFkjNAJfftslP/W2DaK5q1inEuYNQC6J7
	 EcMvq5v392XkUSM5/xqcpcDoeZeoY7YKsuk3sv/+VRG89QXWLYJKBC5QRGPJXS302P
	 8nNQP4YCqnkVrPsLeeKPmJf190vFld8wMUYk1uIppsZZkW9+wg2aRD9JcUxuQwR8in
	 X62S8P5I9mcWHDADcalieY0iQwPweHBJmoplO47U3BZMJYZV7ldR+wUKNxZ3lAwu4q
	 8kqZYZHGGqi7A==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 24 Sep 2023 10:03:10 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] udp_tunnel: Use flex array to simplify code
Date: Sun, 24 Sep 2023 10:03:07 +0200
Message-Id: <4a096ba9cf981a588aa87235bb91e933ee162b3d.1695542544.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

'n_tables' is small, UDP_TUNNEL_NIC_MAX_TABLES	= 4 as a maximum. So there
is no real point to allocate the 'entries' pointers array with a dedicate
memory allocation.

Using a flexible array for struct udp_tunnel_nic->entries avoids the
overhead of an additional memory allocation.

This also saves an indirection when the array is accessed.

Finally, __counted_by() can be used for run-time bounds checking if
configured and supported by the compiler.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 net/ipv4/udp_tunnel_nic.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
index 029219749785..b6d2d16189c0 100644
--- a/net/ipv4/udp_tunnel_nic.c
+++ b/net/ipv4/udp_tunnel_nic.c
@@ -47,7 +47,7 @@ struct udp_tunnel_nic {
 
 	unsigned int n_tables;
 	unsigned long missed;
-	struct udp_tunnel_nic_table_entry **entries;
+	struct udp_tunnel_nic_table_entry *entries[] __counted_by(n_tables);
 };
 
 /* We ensure all work structs are done using driver state, but not the code.
@@ -725,16 +725,12 @@ udp_tunnel_nic_alloc(const struct udp_tunnel_nic_info *info,
 	struct udp_tunnel_nic *utn;
 	unsigned int i;
 
-	utn = kzalloc(sizeof(*utn), GFP_KERNEL);
+	utn = kzalloc(struct_size(utn, entries, n_tables), GFP_KERNEL);
 	if (!utn)
 		return NULL;
 	utn->n_tables = n_tables;
 	INIT_WORK(&utn->work, udp_tunnel_nic_device_sync_work);
 
-	utn->entries = kmalloc_array(n_tables, sizeof(void *), GFP_KERNEL);
-	if (!utn->entries)
-		goto err_free_utn;
-
 	for (i = 0; i < n_tables; i++) {
 		utn->entries[i] = kcalloc(info->tables[i].n_entries,
 					  sizeof(*utn->entries[i]), GFP_KERNEL);
@@ -747,8 +743,6 @@ udp_tunnel_nic_alloc(const struct udp_tunnel_nic_info *info,
 err_free_prev_entries:
 	while (i--)
 		kfree(utn->entries[i]);
-	kfree(utn->entries);
-err_free_utn:
 	kfree(utn);
 	return NULL;
 }
@@ -759,7 +753,6 @@ static void udp_tunnel_nic_free(struct udp_tunnel_nic *utn)
 
 	for (i = 0; i < utn->n_tables; i++)
 		kfree(utn->entries[i]);
-	kfree(utn->entries);
 	kfree(utn);
 }
 
-- 
2.34.1


