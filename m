Return-Path: <netdev+bounces-269961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P0CCTxmvWlF9gIAu9opvQ
	(envelope-from <netdev+bounces-269961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:22:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7462DC942
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 16:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC957301E5CA
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1704C3C942F;
	Fri, 20 Mar 2026 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwTa+tSg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65AA3C9420;
	Fri, 20 Mar 2026 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019972; cv=none; b=pukNo1sz2jmjt77PNs/t/ISeLUBruVufXkFmgIARbRwtnWk/klVp0wmax5tpuJfk1xgP1K55HBy3u3+/PmO8BXYSgRqHqkWl/voMcgj1fAIAjAmGXzrknz6NI3vLK2dfEvDKVFNS7FelVMQ7u7RWt6vdUcsVdk0r0fDobM9DIOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019972; c=relaxed/simple;
	bh=fyuhCJJPgeb6CHmwWja8Nn05xaTwR576oJsamjQY8No=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QPd1CdohgsZh0yY8+aOs3yC20BPld7nkOWmgzaYrtgoDmiblA6ghpB17dNVOsvQDBmVoM8vYWcSy/nLIocaxtg5IaGmtwhsV7kHoOlJPiv4tgmeMqvsCYpYvqbZZuZAupr3uZMd7Mw5kP2dv8YpUfQ4emjpIt5Ra4DtFgobOUA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwTa+tSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737A1C19425;
	Fri, 20 Mar 2026 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774019971;
	bh=fyuhCJJPgeb6CHmwWja8Nn05xaTwR576oJsamjQY8No=;
	h=From:To:Cc:Subject:Date:From;
	b=cwTa+tSgMimQq6HMXMam0ZUF3aIC3Lrfl1NbqShr1IrQg29Mgcn3kUbsBY35VBZHS
	 XaVfR+ua8X3hSa8cWuMxgmSAbi/BCYcJ74veJ452vsA/4xTFnkN1ZtBg7CGwLhjyiy
	 I8rbo1fpAnbBLy6vpoPqEkQf4khHVquzlopTGWGozGKua0sCHgCgywtBF8sRaKjtbd
	 Sfd6NU4ZtBAcId5Omz68Iwtt8uOJxqGIKbRKuloQ5DaD4yO7SzrxUc6CDhJsz91tFS
	 iBmSRaMXjD0dRQf7aOlAm79eIqi713WwF/br3Dc7MVm0SeiVznjx8to723nj5LaRrm
	 Q9fQpvZ1HBXOw==
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
Subject: [PATCH] net: sfc: avoid format string warning
Date: Fri, 20 Mar 2026 16:19:16 +0100
Message-Id: <20260320151924.3474821-1-arnd@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269961-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.964];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,lkml];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arndb.de:email]
X-Rspamd-Queue-Id: AE7462DC942
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
type checking and avoids this warning.

Fixes: 3273c2e8c66a ("[netdrvr] sfc: sfc: Add self-test support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/sfc/ethtool_common.c     | 28 ++++++++++--------
 drivers/net/ethernet/sfc/falcon/ethtool.c     | 27 ++++++++++-------
 .../net/ethernet/sfc/siena/ethtool_common.c   | 29 +++++++++++--------
 3 files changed, 49 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/ethernet/sfc/ethtool_common.c
index 54f8e4626568..162be23edbe5 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/ethtool_common.c
@@ -254,9 +254,10 @@ int efx_ethtool_set_pauseparam(struct net_device *net_dev,
  *
  * Fill in an individual self-test entry.
  */
-static void efx_fill_test(unsigned int test_index, u8 *strings, u64 *data,
-			  int *test, const char *unit_format, int unit_id,
-			  const char *test_format, const char *test_id)
+static void __printf(7, 8)
+efx_fill_test(unsigned int test_index, u8 *strings, u64 *data,
+	      int *test, const char *unit_format, int unit_id,
+	      const char *test_format, ...)
 {
 	char unit_str[ETH_GSTRING_LEN], test_str[ETH_GSTRING_LEN];
 
@@ -266,12 +267,15 @@ static void efx_fill_test(unsigned int test_index, u8 *strings, u64 *data,
 
 	/* Fill string, if applicable */
 	if (strings) {
+		va_list args;
 		if (strchr(unit_format, '%'))
 			snprintf(unit_str, sizeof(unit_str),
 				 unit_format, unit_id);
 		else
 			strcpy(unit_str, unit_format);
-		snprintf(test_str, sizeof(test_str), test_format, test_id);
+		va_start(args, test_format);
+		vsnprintf(test_str, sizeof(test_str), test_format, args);
+		va_end(args);
 		snprintf(strings + test_index * ETH_GSTRING_LEN,
 			 ETH_GSTRING_LEN,
 			 "%-6s %-24s", unit_str, test_str);
@@ -349,28 +353,28 @@ int efx_ethtool_fill_self_tests(struct efx_nic *efx,
 	enum efx_loopback_mode mode;
 
 	efx_fill_test(n++, strings, data, &tests->phy_alive,
-		      "phy", 0, "alive", NULL);
+		      "phy", 0, "alive");
 	efx_fill_test(n++, strings, data, &tests->nvram,
-		      "core", 0, "nvram", NULL);
+		      "core", 0, "nvram");
 	efx_fill_test(n++, strings, data, &tests->interrupt,
-		      "core", 0, "interrupt", NULL);
+		      "core", 0, "interrupt");
 
 	/* Event queues */
 	efx_for_each_channel(channel, efx) {
 		efx_fill_test(n++, strings, data,
 			      &tests->eventq_dma[channel->channel],
 			      EFX_CHANNEL_NAME(channel),
-			      "eventq.dma", NULL);
+			      "eventq.dma");
 		efx_fill_test(n++, strings, data,
 			      &tests->eventq_int[channel->channel],
 			      EFX_CHANNEL_NAME(channel),
-			      "eventq.int", NULL);
+			      "eventq.int");
 	}
 
 	efx_fill_test(n++, strings, data, &tests->memory,
-		      "core", 0, "memory", NULL);
+		      "core", 0, "memory");
 	efx_fill_test(n++, strings, data, &tests->registers,
-		      "core", 0, "registers", NULL);
+		      "core", 0, "registers");
 
 	for (i = 0; true; ++i) {
 		const char *name;
@@ -380,7 +384,7 @@ int efx_ethtool_fill_self_tests(struct efx_nic *efx,
 		if (name == NULL)
 			break;
 
-		efx_fill_test(n++, strings, data, &tests->phy_ext[i], "phy", 0, name, NULL);
+		efx_fill_test(n++, strings, data, &tests->phy_ext[i], "phy", 0, "%s", name);
 	}
 
 	/* Loopback tests */
diff --git a/drivers/net/ethernet/sfc/falcon/ethtool.c b/drivers/net/ethernet/sfc/falcon/ethtool.c
index 807c587eba3b..1ae8acb8fdc8 100644
--- a/drivers/net/ethernet/sfc/falcon/ethtool.c
+++ b/drivers/net/ethernet/sfc/falcon/ethtool.c
@@ -207,9 +207,10 @@ static void ef4_ethtool_set_msglevel(struct net_device *net_dev, u32 msg_enable)
  *
  * Fill in an individual self-test entry.
  */
-static void ef4_fill_test(unsigned int test_index, u8 *strings, u64 *data,
+static void __printf(7, 8)
+ ef4_fill_test(unsigned int test_index, u8 *strings, u64 *data,
 			  int *test, const char *unit_format, int unit_id,
-			  const char *test_format, const char *test_id)
+			  const char *test_format, ...)
 {
 	char unit_str[ETH_GSTRING_LEN], test_str[ETH_GSTRING_LEN];
 
@@ -219,12 +220,16 @@ static void ef4_fill_test(unsigned int test_index, u8 *strings, u64 *data,
 
 	/* Fill string, if applicable */
 	if (strings) {
+		va_list arg;
+
 		if (strchr(unit_format, '%'))
 			snprintf(unit_str, sizeof(unit_str),
 				 unit_format, unit_id);
 		else
 			strcpy(unit_str, unit_format);
-		snprintf(test_str, sizeof(test_str), test_format, test_id);
+		va_start(arg, test_format);
+		vsnprintf(test_str, sizeof(test_str), test_format, arg);
+		va_end(arg);
 		snprintf(strings + test_index * ETH_GSTRING_LEN,
 			 ETH_GSTRING_LEN,
 			 "%-6s %-24s", unit_str, test_str);
@@ -303,28 +308,28 @@ static int ef4_ethtool_fill_self_tests(struct ef4_nic *efx,
 	enum ef4_loopback_mode mode;
 
 	ef4_fill_test(n++, strings, data, &tests->phy_alive,
-		      "phy", 0, "alive", NULL);
+		      "phy", 0, "alive");
 	ef4_fill_test(n++, strings, data, &tests->nvram,
-		      "core", 0, "nvram", NULL);
+		      "core", 0, "nvram");
 	ef4_fill_test(n++, strings, data, &tests->interrupt,
-		      "core", 0, "interrupt", NULL);
+		      "core", 0, "interrupt");
 
 	/* Event queues */
 	ef4_for_each_channel(channel, efx) {
 		ef4_fill_test(n++, strings, data,
 			      &tests->eventq_dma[channel->channel],
 			      EF4_CHANNEL_NAME(channel),
-			      "eventq.dma", NULL);
+			      "eventq.dma");
 		ef4_fill_test(n++, strings, data,
 			      &tests->eventq_int[channel->channel],
 			      EF4_CHANNEL_NAME(channel),
-			      "eventq.int", NULL);
+			      "eventq.int");
 	}
 
 	ef4_fill_test(n++, strings, data, &tests->memory,
-		      "core", 0, "memory", NULL);
+		      "core", 0, "memory");
 	ef4_fill_test(n++, strings, data, &tests->registers,
-		      "core", 0, "registers", NULL);
+		      "core", 0, "registers");
 
 	if (efx->phy_op->run_tests != NULL) {
 		EF4_BUG_ON_PARANOID(efx->phy_op->test_name == NULL);
@@ -338,7 +343,7 @@ static int ef4_ethtool_fill_self_tests(struct ef4_nic *efx,
 				break;
 
 			ef4_fill_test(n++, strings, data, &tests->phy_ext[i],
-				      "phy", 0, name, NULL);
+				      "phy", 0, "%s", name);
 		}
 	}
 
diff --git a/drivers/net/ethernet/sfc/siena/ethtool_common.c b/drivers/net/ethernet/sfc/siena/ethtool_common.c
index 76cbce2b9592..9a8e39c5a113 100644
--- a/drivers/net/ethernet/sfc/siena/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/siena/ethtool_common.c
@@ -206,9 +206,9 @@ int efx_siena_ethtool_set_pauseparam(struct net_device *net_dev,
  *
  * Fill in an individual self-test entry.
  */
-static void efx_fill_test(unsigned int test_index, u8 *strings, u64 *data,
-			  int *test, const char *unit_format, int unit_id,
-			  const char *test_format, const char *test_id)
+static void __printf(7, 8)
+efx_fill_test(unsigned int test_index, u8 *strings, u64 *data, int *test,
+	      const char *unit_format, int unit_id, const char *test_format, ...)
 {
 	char unit_str[ETH_GSTRING_LEN], test_str[ETH_GSTRING_LEN];
 
@@ -218,12 +218,16 @@ static void efx_fill_test(unsigned int test_index, u8 *strings, u64 *data,
 
 	/* Fill string, if applicable */
 	if (strings) {
+		va_list args;
+
 		if (strchr(unit_format, '%'))
 			snprintf(unit_str, sizeof(unit_str),
 				 unit_format, unit_id);
 		else
 			strcpy(unit_str, unit_format);
-		snprintf(test_str, sizeof(test_str), test_format, test_id);
+		va_start(args, test_format);
+		vsnprintf(test_str, sizeof(test_str), test_format, args);
+		va_end(args);
 		snprintf(strings + test_index * ETH_GSTRING_LEN,
 			 ETH_GSTRING_LEN,
 			 "%-6s %-24s", unit_str, test_str);
@@ -301,28 +305,28 @@ static int efx_ethtool_fill_self_tests(struct efx_nic *efx,
 	enum efx_loopback_mode mode;
 
 	efx_fill_test(n++, strings, data, &tests->phy_alive,
-		      "phy", 0, "alive", NULL);
+		      "phy", 0, "alive");
 	efx_fill_test(n++, strings, data, &tests->nvram,
-		      "core", 0, "nvram", NULL);
+		      "core", 0, "nvram");
 	efx_fill_test(n++, strings, data, &tests->interrupt,
-		      "core", 0, "interrupt", NULL);
+		      "core", 0, "interrupt");
 
 	/* Event queues */
 	efx_for_each_channel(channel, efx) {
 		efx_fill_test(n++, strings, data,
 			      &tests->eventq_dma[channel->channel],
 			      EFX_CHANNEL_NAME(channel),
-			      "eventq.dma", NULL);
+			      "eventq.dma");
 		efx_fill_test(n++, strings, data,
 			      &tests->eventq_int[channel->channel],
 			      EFX_CHANNEL_NAME(channel),
-			      "eventq.int", NULL);
+			      "eventq.int");
 	}
 
 	efx_fill_test(n++, strings, data, &tests->memory,
-		      "core", 0, "memory", NULL);
+		      "core", 0, "memory");
 	efx_fill_test(n++, strings, data, &tests->registers,
-		      "core", 0, "registers", NULL);
+		      "core", 0, "registers");
 
 	for (i = 0; true; ++i) {
 		const char *name;
@@ -332,7 +336,8 @@ static int efx_ethtool_fill_self_tests(struct efx_nic *efx,
 		if (name == NULL)
 			break;
 
-		efx_fill_test(n++, strings, data, &tests->phy_ext[i], "phy", 0, name, NULL);
+		efx_fill_test(n++, strings, data, &tests->phy_ext[i], "phy",
+			      0, "%s", name);
 	}
 
 	/* Loopback tests */
-- 
2.39.5


