Return-Path: <netdev+bounces-271570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHhtOzXsw2kAvAQAu9opvQ
	(envelope-from <netdev+bounces-271570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:07:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE9432670B
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9DAE3032988
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684C63AF64B;
	Wed, 25 Mar 2026 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/spztVF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43648242D67;
	Wed, 25 Mar 2026 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446364; cv=none; b=jAelHbtIWSiowmZnyBDuxX7i0tAp811khCr5Mfyq9a2Mq4bbr7PpKXEO6xowVBNfrqAR3tkOzt3m0fWXHaUpJElXSGJtPM4XOWc2+dlqRoo0MCx76btx7B9tjajPdrw5fpLIs4mUCYCMD6EnJ4hEr4122BFIFEeVTZwvybpLatA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446364; c=relaxed/simple;
	bh=TSXGQzfP711qrPB0j3RMTHQ/TMRpAy/A6hAklaBDA4k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mx4G4I4CGbhenMlmmyAcSGipU9pa3PoOKnoqtq3amS9hZ0YXw1aU3onzBpaPOZ64mb5tKGlYVh9N58oALncAsKyUKhNyJby0UHGTIhBi4Lrvycpre+DVjo3MzabDVqS+x+j7BfymGeBD1iqiDF3ZSHHfXs1OAPsr3AEb7l6P/ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/spztVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EB4C4CEF7;
	Wed, 25 Mar 2026 13:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774446364;
	bh=TSXGQzfP711qrPB0j3RMTHQ/TMRpAy/A6hAklaBDA4k=;
	h=From:To:Cc:Subject:Date:From;
	b=J/spztVFpXILaV+6ISmNoFIGf1Mui271QWTcRyRoDb3SPrr3NxvDFhuPASQEbQhf8
	 3K4ugQYSfJfFA5Z1JDdkJr05RYbVEcwVqb5JAJY7jRlH5QjoP47pxerzooHtYPyG9r
	 nROPr3OA04hZpxq9YihKZWYR04DshQIa9eBCzPPFObwxQeqyf94IfX/p3TvvXgBTQg
	 Cq6r0O7ufY2SjiUkL32ItHj7p8t02CQABqsFD8uZ20es3Chk61kKFvbSqsLjAJel/V
	 R+C5N+C1OHEInDbsFsjKAwe+pOqGmHnhKQIr9F8tvcM9SSblh85T15PZ8XDDzGm2+b
	 1rhwJWh62NviQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Ben Hutchings <bhutchings@solarflare.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Breno Leitao <leitao@debian.org>,
	Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] [v2] net: sfc: avoid format string warning
Date: Wed, 25 Mar 2026 14:45:44 +0100
Message-Id: <20260325134557.3406655-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271570-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,solarflare.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,gmail.com,google.com,amd.com,debian.org,kernel.org,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,lkml];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CE9432670B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de>

Three sfc drivers contain the same *_fill_test() function that takes
a format string argument that gets passed down to snprintf(), producing
a warning with clang-22:

drivers/net/ethernet/sfc/falcon/ethtool.c:227:60: error: diagnostic behavior may be improved by adding
      the 'format(printf, 7, 8)' attribute to the declaration of 'ef4_fill_test' [-Werror,-Wmissing-format-attribute]
  210 |                 snprintf(test_str, sizeof(test_str), test_format, test_id);
      |                                                                          ^
drivers/net/ethernet/sfc/falcon/ethtool.c:210:13: note: 'ef4_fill_test' declared here

Rework these to take a varargs based test_format that allows better
type checking and a non-varargs unit name that gets pre-filled by
the caller, so that the compiler can validate all format strings.

Fixes: 3273c2e8c66a ("[netdrvr] sfc: sfc: Add self-test support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: open-code the unit name format as well
    reformat the function prototype
---
 drivers/net/ethernet/sfc/ethtool_common.c     | 67 +++++++++---------
 drivers/net/ethernet/sfc/falcon/ethtool.c     | 68 +++++++++---------
 .../net/ethernet/sfc/siena/ethtool_common.c   | 69 +++++++++----------
 3 files changed, 99 insertions(+), 105 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/ethernet/sfc/ethtool_common.c
index 54f8e4626568..62a94c995241 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/ethtool_common.c
@@ -247,18 +247,17 @@ int efx_ethtool_set_pauseparam(struct net_device *net_dev,
  * @strings:		Ethtool strings, or %NULL
  * @data:		Ethtool test results, or %NULL
  * @test:		Pointer to test result (used only if data != %NULL)
- * @unit_format:	Unit name format (e.g. "chan\%d")
- * @unit_id:		Unit id (e.g. 0 for "chan0")
+ * @unit_name:		Unit name
  * @test_format:	Test name format (e.g. "loopback.\%s.tx.sent")
- * @test_id:		Test id (e.g. "PHYXS" for "loopback.PHYXS.tx_sent")
  *
  * Fill in an individual self-test entry.
  */
-static void efx_fill_test(unsigned int test_index, u8 *strings, u64 *data,
-			  int *test, const char *unit_format, int unit_id,
-			  const char *test_format, const char *test_id)
+static void __printf(6, 7) efx_fill_test(unsigned int test_index, u8 *strings,
+					 u64 *data, int *test,
+					 const char *unit_name,
+					 const char *test_format, ...)
 {
-	char unit_str[ETH_GSTRING_LEN], test_str[ETH_GSTRING_LEN];
+	char test_str[ETH_GSTRING_LEN];
 
 	/* Fill data value, if applicable */
 	if (data)
@@ -266,20 +265,16 @@ static void efx_fill_test(unsigned int test_index, u8 *strings, u64 *data,
 
 	/* Fill string, if applicable */
 	if (strings) {
-		if (strchr(unit_format, '%'))
-			snprintf(unit_str, sizeof(unit_str),
-				 unit_format, unit_id);
-		else
-			strcpy(unit_str, unit_format);
-		snprintf(test_str, sizeof(test_str), test_format, test_id);
+		va_list args;
+
+		va_start(args, test_format);
+		vsnprintf(test_str, sizeof(test_str), test_format, args);
+		va_end(args);
 		snprintf(strings + test_index * ETH_GSTRING_LEN,
-			 ETH_GSTRING_LEN,
-			 "%-6s %-24s", unit_str, test_str);
+			 ETH_GSTRING_LEN, "%-6s %-24s", unit_name, test_str);
 	}
 }
 
-#define EFX_CHANNEL_NAME(_channel) "chan%d", _channel->channel
-#define EFX_TX_QUEUE_NAME(_tx_queue) "txq%d", _tx_queue->label
 #define EFX_LOOPBACK_NAME(_mode, _counter)			\
 	"loopback.%s." _counter, STRING_TABLE_LOOKUP(_mode, efx_loopback_mode)
 
@@ -306,23 +301,23 @@ static int efx_fill_loopback_test(struct efx_nic *efx,
 	struct efx_tx_queue *tx_queue;
 
 	efx_for_each_channel_tx_queue(tx_queue, channel) {
+		char unit_str[ETH_GSTRING_LEN];
+
+		snprintf(unit_str, sizeof(unit_str), "txq%d", tx_queue->label);
+
 		efx_fill_test(test_index++, strings, data,
 			      &lb_tests->tx_sent[tx_queue->label],
-			      EFX_TX_QUEUE_NAME(tx_queue),
-			      EFX_LOOPBACK_NAME(mode, "tx_sent"));
+			      unit_str, EFX_LOOPBACK_NAME(mode, "tx_sent"));
 		efx_fill_test(test_index++, strings, data,
 			      &lb_tests->tx_done[tx_queue->label],
-			      EFX_TX_QUEUE_NAME(tx_queue),
-			      EFX_LOOPBACK_NAME(mode, "tx_done"));
+			      unit_str, EFX_LOOPBACK_NAME(mode, "tx_done"));
 	}
 	efx_fill_test(test_index++, strings, data,
 		      &lb_tests->rx_good,
-		      "rx", 0,
-		      EFX_LOOPBACK_NAME(mode, "rx_good"));
+		      "rx", EFX_LOOPBACK_NAME(mode, "rx_good"));
 	efx_fill_test(test_index++, strings, data,
 		      &lb_tests->rx_bad,
-		      "rx", 0,
-		      EFX_LOOPBACK_NAME(mode, "rx_bad"));
+		      "rx", EFX_LOOPBACK_NAME(mode, "rx_bad"));
 
 	return test_index;
 }
@@ -349,28 +344,30 @@ int efx_ethtool_fill_self_tests(struct efx_nic *efx,
 	enum efx_loopback_mode mode;
 
 	efx_fill_test(n++, strings, data, &tests->phy_alive,
-		      "phy", 0, "alive", NULL);
+		      "phy", "alive");
 	efx_fill_test(n++, strings, data, &tests->nvram,
-		      "core", 0, "nvram", NULL);
+		      "core", "nvram");
 	efx_fill_test(n++, strings, data, &tests->interrupt,
-		      "core", 0, "interrupt", NULL);
+		      "core", "interrupt");
 
 	/* Event queues */
 	efx_for_each_channel(channel, efx) {
+		char unit_str[ETH_GSTRING_LEN];
+
+		snprintf(unit_str, sizeof(unit_str), "txq%d", channel->channel);
+
 		efx_fill_test(n++, strings, data,
 			      &tests->eventq_dma[channel->channel],
-			      EFX_CHANNEL_NAME(channel),
-			      "eventq.dma", NULL);
+			      unit_str, "eventq.dma");
 		efx_fill_test(n++, strings, data,
 			      &tests->eventq_int[channel->channel],
-			      EFX_CHANNEL_NAME(channel),
-			      "eventq.int", NULL);
+			      unit_str, "eventq.int");
 	}
 
 	efx_fill_test(n++, strings, data, &tests->memory,
-		      "core", 0, "memory", NULL);
+		      "core", "memory");
 	efx_fill_test(n++, strings, data, &tests->registers,
-		      "core", 0, "registers", NULL);
+		      "core", "registers");
 
 	for (i = 0; true; ++i) {
 		const char *name;
@@ -380,7 +377,7 @@ int efx_ethtool_fill_self_tests(struct efx_nic *efx,
 		if (name == NULL)
 			break;
 
-		efx_fill_test(n++, strings, data, &tests->phy_ext[i], "phy", 0, name, NULL);
+		efx_fill_test(n++, strings, data, &tests->phy_ext[i], "phy", "%s", name);
 	}
 
 	/* Loopback tests */
diff --git a/drivers/net/ethernet/sfc/falcon/ethtool.c b/drivers/net/ethernet/sfc/falcon/ethtool.c
index 807c587eba3b..260340b291d3 100644
--- a/drivers/net/ethernet/sfc/falcon/ethtool.c
+++ b/drivers/net/ethernet/sfc/falcon/ethtool.c
@@ -200,18 +200,17 @@ static void ef4_ethtool_set_msglevel(struct net_device *net_dev, u32 msg_enable)
  * @strings:		Ethtool strings, or %NULL
  * @data:		Ethtool test results, or %NULL
  * @test:		Pointer to test result (used only if data != %NULL)
- * @unit_format:	Unit name format (e.g. "chan\%d")
- * @unit_id:		Unit id (e.g. 0 for "chan0")
+ * @unit_name:		Unit name
  * @test_format:	Test name format (e.g. "loopback.\%s.tx.sent")
- * @test_id:		Test id (e.g. "PHYXS" for "loopback.PHYXS.tx_sent")
  *
  * Fill in an individual self-test entry.
  */
-static void ef4_fill_test(unsigned int test_index, u8 *strings, u64 *data,
-			  int *test, const char *unit_format, int unit_id,
-			  const char *test_format, const char *test_id)
+static void __printf(6, 7) ef4_fill_test(unsigned int test_index, u8 *strings,
+					 u64 *data, int *test,
+					 const char *unit_name,
+					 const char *test_format, ...)
 {
-	char unit_str[ETH_GSTRING_LEN], test_str[ETH_GSTRING_LEN];
+	char test_str[ETH_GSTRING_LEN];
 
 	/* Fill data value, if applicable */
 	if (data)
@@ -219,21 +218,17 @@ static void ef4_fill_test(unsigned int test_index, u8 *strings, u64 *data,
 
 	/* Fill string, if applicable */
 	if (strings) {
-		if (strchr(unit_format, '%'))
-			snprintf(unit_str, sizeof(unit_str),
-				 unit_format, unit_id);
-		else
-			strcpy(unit_str, unit_format);
-		snprintf(test_str, sizeof(test_str), test_format, test_id);
+		va_list arg;
+
+		va_start(arg, test_format);
+		vsnprintf(test_str, sizeof(test_str), test_format, arg);
+		va_end(arg);
 		snprintf(strings + test_index * ETH_GSTRING_LEN,
 			 ETH_GSTRING_LEN,
-			 "%-6s %-24s", unit_str, test_str);
+			 "%-6s %-24s", unit_name, test_str);
 	}
 }
 
-#define EF4_CHANNEL_NAME(_channel) "chan%d", _channel->channel
-#define EF4_TX_QUEUE_NAME(_tx_queue) "txq%d", _tx_queue->queue
-#define EF4_RX_QUEUE_NAME(_rx_queue) "rxq%d", _rx_queue->queue
 #define EF4_LOOPBACK_NAME(_mode, _counter)			\
 	"loopback.%s." _counter, STRING_TABLE_LOOKUP(_mode, ef4_loopback_mode)
 
@@ -260,23 +255,23 @@ static int ef4_fill_loopback_test(struct ef4_nic *efx,
 	struct ef4_tx_queue *tx_queue;
 
 	ef4_for_each_channel_tx_queue(tx_queue, channel) {
+		char unit_str[ETH_GSTRING_LEN];
+
+		snprintf(unit_str, sizeof(unit_str), "txq%d", tx_queue->queue);
+
 		ef4_fill_test(test_index++, strings, data,
 			      &lb_tests->tx_sent[tx_queue->queue],
-			      EF4_TX_QUEUE_NAME(tx_queue),
-			      EF4_LOOPBACK_NAME(mode, "tx_sent"));
+			      unit_str, EF4_LOOPBACK_NAME(mode, "tx_sent"));
 		ef4_fill_test(test_index++, strings, data,
 			      &lb_tests->tx_done[tx_queue->queue],
-			      EF4_TX_QUEUE_NAME(tx_queue),
-			      EF4_LOOPBACK_NAME(mode, "tx_done"));
+			      unit_str, EF4_LOOPBACK_NAME(mode, "tx_done"));
 	}
 	ef4_fill_test(test_index++, strings, data,
 		      &lb_tests->rx_good,
-		      "rx", 0,
-		      EF4_LOOPBACK_NAME(mode, "rx_good"));
+		      "rx", EF4_LOOPBACK_NAME(mode, "rx_good"));
 	ef4_fill_test(test_index++, strings, data,
 		      &lb_tests->rx_bad,
-		      "rx", 0,
-		      EF4_LOOPBACK_NAME(mode, "rx_bad"));
+		      "rx", EF4_LOOPBACK_NAME(mode, "rx_bad"));
 
 	return test_index;
 }
@@ -303,28 +298,31 @@ static int ef4_ethtool_fill_self_tests(struct ef4_nic *efx,
 	enum ef4_loopback_mode mode;
 
 	ef4_fill_test(n++, strings, data, &tests->phy_alive,
-		      "phy", 0, "alive", NULL);
+		      "phy", "alive");
 	ef4_fill_test(n++, strings, data, &tests->nvram,
-		      "core", 0, "nvram", NULL);
+		      "core", "nvram");
 	ef4_fill_test(n++, strings, data, &tests->interrupt,
-		      "core", 0, "interrupt", NULL);
+		      "core", "interrupt");
 
 	/* Event queues */
 	ef4_for_each_channel(channel, efx) {
+		char unit_str[ETH_GSTRING_LEN];
+
+		snprintf(unit_str, sizeof(unit_str), "chan%d",
+			 channel->channel);
+
 		ef4_fill_test(n++, strings, data,
 			      &tests->eventq_dma[channel->channel],
-			      EF4_CHANNEL_NAME(channel),
-			      "eventq.dma", NULL);
+			      unit_str, "eventq.dma");
 		ef4_fill_test(n++, strings, data,
 			      &tests->eventq_int[channel->channel],
-			      EF4_CHANNEL_NAME(channel),
-			      "eventq.int", NULL);
+			      unit_str, "eventq.int");
 	}
 
 	ef4_fill_test(n++, strings, data, &tests->memory,
-		      "core", 0, "memory", NULL);
+		      "core", "memory");
 	ef4_fill_test(n++, strings, data, &tests->registers,
-		      "core", 0, "registers", NULL);
+		      "core", "registers");
 
 	if (efx->phy_op->run_tests != NULL) {
 		EF4_BUG_ON_PARANOID(efx->phy_op->test_name == NULL);
@@ -338,7 +336,7 @@ static int ef4_ethtool_fill_self_tests(struct ef4_nic *efx,
 				break;
 
 			ef4_fill_test(n++, strings, data, &tests->phy_ext[i],
-				      "phy", 0, name, NULL);
+				      "phy", "%s", name);
 		}
 	}
 
diff --git a/drivers/net/ethernet/sfc/siena/ethtool_common.c b/drivers/net/ethernet/sfc/siena/ethtool_common.c
index 76cbce2b9592..e49cc604b43a 100644
--- a/drivers/net/ethernet/sfc/siena/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/siena/ethtool_common.c
@@ -199,18 +199,17 @@ int efx_siena_ethtool_set_pauseparam(struct net_device *net_dev,
  * @strings:		Ethtool strings, or %NULL
  * @data:		Ethtool test results, or %NULL
  * @test:		Pointer to test result (used only if data != %NULL)
- * @unit_format:	Unit name format (e.g. "chan\%d")
- * @unit_id:		Unit id (e.g. 0 for "chan0")
+ * @unit_name:		Unit name
  * @test_format:	Test name format (e.g. "loopback.\%s.tx.sent")
- * @test_id:		Test id (e.g. "PHYXS" for "loopback.PHYXS.tx_sent")
  *
  * Fill in an individual self-test entry.
  */
-static void efx_fill_test(unsigned int test_index, u8 *strings, u64 *data,
-			  int *test, const char *unit_format, int unit_id,
-			  const char *test_format, const char *test_id)
+static void __printf(6, 7) efx_fill_test(unsigned int test_index, u8 *strings,
+					 u64 *data, int *test,
+					 const char *unit_name,
+					 char *test_format, ...)
 {
-	char unit_str[ETH_GSTRING_LEN], test_str[ETH_GSTRING_LEN];
+	char test_str[ETH_GSTRING_LEN];
 
 	/* Fill data value, if applicable */
 	if (data)
@@ -218,20 +217,16 @@ static void efx_fill_test(unsigned int test_index, u8 *strings, u64 *data,
 
 	/* Fill string, if applicable */
 	if (strings) {
-		if (strchr(unit_format, '%'))
-			snprintf(unit_str, sizeof(unit_str),
-				 unit_format, unit_id);
-		else
-			strcpy(unit_str, unit_format);
-		snprintf(test_str, sizeof(test_str), test_format, test_id);
+		va_list args;
+
+		va_start(args, test_format);
+		vsnprintf(test_str, sizeof(test_str), test_format, args);
+		va_end(args);
 		snprintf(strings + test_index * ETH_GSTRING_LEN,
-			 ETH_GSTRING_LEN,
-			 "%-6s %-24s", unit_str, test_str);
+			 ETH_GSTRING_LEN, "%-6s %-24s", unit_name, test_str);
 	}
 }
 
-#define EFX_CHANNEL_NAME(_channel) "chan%d", _channel->channel
-#define EFX_TX_QUEUE_NAME(_tx_queue) "txq%d", _tx_queue->label
 #define EFX_LOOPBACK_NAME(_mode, _counter)			\
 	"loopback.%s." _counter, STRING_TABLE_LOOKUP(_mode, efx_siena_loopback_mode)
 
@@ -258,23 +253,23 @@ static int efx_fill_loopback_test(struct efx_nic *efx,
 	struct efx_tx_queue *tx_queue;
 
 	efx_for_each_channel_tx_queue(tx_queue, channel) {
+		char unit_str[ETH_GSTRING_LEN];
+
+		snprintf(unit_str, sizeof(unit_str), "txq%d",tx_queue->label);
+
 		efx_fill_test(test_index++, strings, data,
 			      &lb_tests->tx_sent[tx_queue->label],
-			      EFX_TX_QUEUE_NAME(tx_queue),
-			      EFX_LOOPBACK_NAME(mode, "tx_sent"));
+			      unit_str, EFX_LOOPBACK_NAME(mode, "tx_sent"));
 		efx_fill_test(test_index++, strings, data,
 			      &lb_tests->tx_done[tx_queue->label],
-			      EFX_TX_QUEUE_NAME(tx_queue),
-			      EFX_LOOPBACK_NAME(mode, "tx_done"));
+			      unit_str, EFX_LOOPBACK_NAME(mode, "tx_done"));
 	}
 	efx_fill_test(test_index++, strings, data,
 		      &lb_tests->rx_good,
-		      "rx", 0,
-		      EFX_LOOPBACK_NAME(mode, "rx_good"));
+		      "rx", EFX_LOOPBACK_NAME(mode, "rx_good"));
 	efx_fill_test(test_index++, strings, data,
 		      &lb_tests->rx_bad,
-		      "rx", 0,
-		      EFX_LOOPBACK_NAME(mode, "rx_bad"));
+		      "rx", EFX_LOOPBACK_NAME(mode, "rx_bad"));
 
 	return test_index;
 }
@@ -301,28 +296,31 @@ static int efx_ethtool_fill_self_tests(struct efx_nic *efx,
 	enum efx_loopback_mode mode;
 
 	efx_fill_test(n++, strings, data, &tests->phy_alive,
-		      "phy", 0, "alive", NULL);
+		      "phy", "alive");
 	efx_fill_test(n++, strings, data, &tests->nvram,
-		      "core", 0, "nvram", NULL);
+		      "core", "nvram");
 	efx_fill_test(n++, strings, data, &tests->interrupt,
-		      "core", 0, "interrupt", NULL);
+		      "core", "interrupt");
 
 	/* Event queues */
 	efx_for_each_channel(channel, efx) {
+		char unit_str[ETH_GSTRING_LEN];
+
+		snprintf(unit_str, sizeof(unit_str), "chan%d",
+			 channel->channel);
+
 		efx_fill_test(n++, strings, data,
 			      &tests->eventq_dma[channel->channel],
-			      EFX_CHANNEL_NAME(channel),
-			      "eventq.dma", NULL);
+			      unit_str, "eventq.dma");
 		efx_fill_test(n++, strings, data,
 			      &tests->eventq_int[channel->channel],
-			      EFX_CHANNEL_NAME(channel),
-			      "eventq.int", NULL);
+			      unit_str, "eventq.int");
 	}
 
 	efx_fill_test(n++, strings, data, &tests->memory,
-		      "core", 0, "memory", NULL);
+		      "core", "memory");
 	efx_fill_test(n++, strings, data, &tests->registers,
-		      "core", 0, "registers", NULL);
+		      "core", "registers");
 
 	for (i = 0; true; ++i) {
 		const char *name;
@@ -332,7 +330,8 @@ static int efx_ethtool_fill_self_tests(struct efx_nic *efx,
 		if (name == NULL)
 			break;
 
-		efx_fill_test(n++, strings, data, &tests->phy_ext[i], "phy", 0, name, NULL);
+		efx_fill_test(n++, strings, data, &tests->phy_ext[i], "phy",
+			      "%s", name);
 	}
 
 	/* Loopback tests */
-- 
2.39.5


