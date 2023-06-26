Return-Path: <netdev+bounces-13866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6684A73D7F4
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 08:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC65280A22
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 06:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6023187A;
	Mon, 26 Jun 2023 06:47:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A131872
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 06:47:59 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CB271AA;
	Sun, 25 Jun 2023 23:47:55 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net-next 1/8] ipvs: increase ip_vs_conn_tab_bits range for 64BIT
Date: Mon, 26 Jun 2023 08:47:42 +0200
Message-Id: <20230626064749.75525-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230626064749.75525-1-pablo@netfilter.org>
References: <20230626064749.75525-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Abhijeet Rastogi <abhijeet.1989@gmail.com>

Current range [8, 20] is set purely due to historical reasons
because at the time, ~1M (2^20) was considered sufficient.
With this change, 27 is the upper limit for 64-bit, 20 otherwise.

Previous change regarding this limit is here.

Link: https://lore.kernel.org/all/86eabeb9dd62aebf1e2533926fdd13fed48bab1f.1631289960.git.aclaudi@redhat.com/T/#u

Signed-off-by: Abhijeet Rastogi <abhijeet.1989@gmail.com>
Acked-by: Julian Anastasov <ja@ssi.bg>
Acked-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/ipvs/Kconfig      | 27 ++++++++++++++-------------
 net/netfilter/ipvs/ip_vs_conn.c |  4 ++--
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
index 271da8447b29..2a3017b9c001 100644
--- a/net/netfilter/ipvs/Kconfig
+++ b/net/netfilter/ipvs/Kconfig
@@ -44,7 +44,8 @@ config	IP_VS_DEBUG
 
 config	IP_VS_TAB_BITS
 	int "IPVS connection table size (the Nth power of 2)"
-	range 8 20
+	range 8 20 if !64BIT
+	range 8 27 if 64BIT
 	default 12
 	help
 	  The IPVS connection hash table uses the chaining scheme to handle
@@ -54,24 +55,24 @@ config	IP_VS_TAB_BITS
 
 	  Note the table size must be power of 2. The table size will be the
 	  value of 2 to the your input number power. The number to choose is
-	  from 8 to 20, the default number is 12, which means the table size
-	  is 4096. Don't input the number too small, otherwise you will lose
-	  performance on it. You can adapt the table size yourself, according
-	  to your virtual server application. It is good to set the table size
-	  not far less than the number of connections per second multiplying
-	  average lasting time of connection in the table.  For example, your
-	  virtual server gets 200 connections per second, the connection lasts
-	  for 200 seconds in average in the connection table, the table size
-	  should be not far less than 200x200, it is good to set the table
-	  size 32768 (2**15).
+	  from 8 to 27 for 64BIT(20 otherwise), the default number is 12,
+	  which means the table size is 4096. Don't input the number too
+	  small, otherwise you will lose performance on it. You can adapt the
+	  table size yourself, according to your virtual server application.
+	  It is good to set the table size not far less than the number of
+	  connections per second multiplying average lasting time of
+	  connection in the table.  For example, your virtual server gets 200
+	  connections per second, the connection lasts for 200 seconds in
+	  average in the connection table, the table size should be not far
+	  less than 200x200, it is good to set the table size 32768 (2**15).
 
 	  Another note that each connection occupies 128 bytes effectively and
 	  each hash entry uses 8 bytes, so you can estimate how much memory is
 	  needed for your box.
 
 	  You can overwrite this number setting conn_tab_bits module parameter
-	  or by appending ip_vs.conn_tab_bits=? to the kernel command line
-	  if IP VS was compiled built-in.
+	  or by appending ip_vs.conn_tab_bits=? to the kernel command line if
+	  IP VS was compiled built-in.
 
 comment "IPVS transport protocol load balancing support"
 
diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index 928e64653837..f4c55e65abd1 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -1485,8 +1485,8 @@ int __init ip_vs_conn_init(void)
 	int idx;
 
 	/* Compute size and mask */
-	if (ip_vs_conn_tab_bits < 8 || ip_vs_conn_tab_bits > 20) {
-		pr_info("conn_tab_bits not in [8, 20]. Using default value\n");
+	if (ip_vs_conn_tab_bits < 8 || ip_vs_conn_tab_bits > 27) {
+		pr_info("conn_tab_bits not in [8, 27]. Using default value\n");
 		ip_vs_conn_tab_bits = CONFIG_IP_VS_TAB_BITS;
 	}
 	ip_vs_conn_tab_size = 1 << ip_vs_conn_tab_bits;
-- 
2.30.2


