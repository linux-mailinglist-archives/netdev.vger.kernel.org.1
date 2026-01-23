Return-Path: <netdev+bounces-252834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGXPKuJnc2mivQAAu9opvQ
	(envelope-from <netdev+bounces-252834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:21:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E68875B07
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D3BF307C52C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9482729D281;
	Fri, 23 Jan 2026 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="sB+rrEOp"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAD5262808;
	Fri, 23 Jan 2026 12:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170697; cv=none; b=Go8Sb0l18dL2sNkfpw2PZdvxw8PsfwHh3FSBNhu+4+iDE9nGIXUN+KAWIho4kY8uojdB+qmUPwbKXiTfYX9nF6YJ66I9fgelmDydJXi8RyXKykNf1/1FLr2/MsjQj8nvsth8ALS5kZK2PkwqtbvivVADu8AsZjw4ocuybgLYJwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170697; c=relaxed/simple;
	bh=JFP0hdML0vErS40bsyhMRJZeTqHHd/Fr+2NgT22nVIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R8GNXYywZO+gPmdMTtiCrAicQD153WI8P7xAHsabhr4mq7g8dmAkU4OILrhhZkZqe3r1YJrg39APpRsp4ImOkWlEFq4JS8PmKl3Gu0dEG1tYNb7pmHnSengIXgDOCbwXMF0Dceci1h9Vda23B5fjKkRVqTE7japRkngT7sBqJNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=sB+rrEOp; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=KqTfxsd77ZKen+IFl12f2Tf+pPtsAXfqOix6fnP6cK4=; b=sB+rrEOpL54WdampW44yyDUHZy
	/9mdASCDCpHjJ2tgPujO8s1B2U4zWHZ6Mgd7H6+ciVR1ejQ5rdHico3GyKDzxI5XGVAStKOTQ+7Rv
	xZKUgWSYvfOTFOlGLmuXQykur2k9V9sdT4/G4lfoY/GqPKj7zVeWL5wBLf6iYLX+CStLCo+bpd6E/
	D49ZYEeF6IiXw4VwR6snsY9u9+6SlUddyltN9jAXTOei5kEcH0zbdmmffShrVhHdqetoqDNqcEqmz
	nyrluvj6S8yl8bFFLNbY/4MWQUkBr/nz4BN18oLLmf7CZ+yIAaBGtlBPoEa8eM1cx+0i8fjzNWac7
	btZ6VDxA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vjG76-00Dpeg-3f; Fri, 23 Jan 2026 12:18:08 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 23 Jan 2026 04:17:26 -0800
Subject: [PATCH net-next v4 3/5] netconsole: convert to NBCON console
 infrastructure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-nbcon-v4-3-46a5cf567926@debian.org>
References: <20260123-nbcon-v4-0-46a5cf567926@debian.org>
In-Reply-To: <20260123-nbcon-v4-0-46a5cf567926@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 pmladek@suse.com, john.ogness@linutronix.de
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, 
 mpdesouza@suse.com, kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=5583; i=leitao@debian.org;
 h=from:subject:message-id; bh=JFP0hdML0vErS40bsyhMRJZeTqHHd/Fr+2NgT22nVIk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpc2bqYiPFELtDGo1RKYA6A+Tn2X1aasZoRar1h
 48E0kNM68uJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXNm6gAKCRA1o5Of/Hh3
 bZnZD/92FSao0LZuRgXVwtd46R6DSEYocAUz8anZs+RNwmTyXYsRZmr1oN0NXp9XVS/r/Y4dZjH
 CW2Fz7QfMyibiSEQYLC1Jdlex8wQNAa8COArztuid4g3yqozWf7Y8uJ3EhDPmp6xsodPJIvsmwG
 sjn6bwKD8BQDIPdaA88mGUI9BL2AfyUoxfvsQ33mA1Rst42ZnVb0ilhG92eQdEaFW5q/TQgouJb
 zF+z5GMAcgzgGAA7jX0a64mtK1VI5+cgYQ1R6hGAaOYhpSJuaAF1HxUeh+/b4ckt/2iCSkVICYq
 /iTyrQTvZzD/JlcKcltwJ1L5ErwjE/hHGAkmu6NppsGfdPdaBTmdbhFSDzshNrxYelZdfbpjJbz
 mho2n3G2ceAIvfbzdgDUTy2GOIYsv7wb9T2fFriL+6fS+bse5mCicgT3l1MbxxNjpxlb4U5JHnR
 Ef+ZpX8GjYrPEyJ39u05yv0T4NmrS7ox6tpPDxoI8y4bU02b4oBqUZhjpDWMx67wBOQzK95MPLV
 w56mgE4sNltff+ZFJ34fbO46xampjEl7kIeCaLbPiNuNYWY2WZCkzkOvS9AgZwKjfEDN/bCn8AE
 eYlHTVQ0ZCYiTG5gSZ8mOQ0dMUNsI9IjED4qRjxY5BcDY+OrdmgV48A2LyXHur75lOAraAF+pOE
 0mycIDVvQDNV0aw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252834-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E68875B07
X-Rspamd-Action: no action

Convert netconsole from the legacy console API to the NBCON framework.
NBCON provides threaded printing which unblocks printk()s and flushes in
a thread, decoupling network TX from printk() when netconsole is
in use.

Since netconsole relies on the network stack which cannot safely operate
from all atomic contexts, mark both consoles with
CON_NBCON_ATOMIC_UNSAFE. (See discussion in [1])

CON_NBCON_ATOMIC_UNSAFE restricts write_atomic() usage to emergency
scenarios (panic) where regular messages are sent in threaded mode.

Implementation changes:
- Unify write_ext_msg() and write_msg() into netconsole_write()
- Add device_lock/device_unlock callbacks to manage target_list_lock
- Use nbcon_enter_unsafe()/nbcon_exit_unsafe() around network
  operations.
  - If nbcon_enter_unsafe() fails, just return given netconsole lost
    the ownership of the console.
- Set write_thread and write_atomic callbacks (both use same function)

Link: https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/ [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 101 +++++++++++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 39 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index e37250bf495fa..ec000f477c2a8 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1859,23 +1859,6 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 				   sysdata_len);
 }
 
-static void write_ext_msg(struct console *con, const char *msg,
-			  unsigned int len)
-{
-	struct netconsole_target *nt;
-	unsigned long flags;
-
-	if ((oops_only && !oops_in_progress) || list_empty(&target_list))
-		return;
-
-	spin_lock_irqsave(&target_list_lock, flags);
-	list_for_each_entry(nt, &target_list, list)
-		if (nt->extended && nt->state == STATE_ENABLED &&
-		    netif_running(nt->np.dev))
-			send_ext_msg_udp(nt, msg, len);
-	spin_unlock_irqrestore(&target_list_lock, flags);
-}
-
 static void send_msg_udp(struct netconsole_target *nt, const char *msg,
 			 unsigned int len)
 {
@@ -1890,30 +1873,64 @@ static void send_msg_udp(struct netconsole_target *nt, const char *msg,
 	}
 }
 
-static void write_msg(struct console *con, const char *msg, unsigned int len)
+/**
+ * netconsole_write - Generic function to send a msg to all targets
+ * @wctxt: nbcon write context
+ * @extended: "true" for extended console mode
+ *
+ * Given an nbcon write context, send the message to the netconsole targets
+ */
+static void netconsole_write(struct nbcon_write_context *wctxt, bool extended)
 {
-	unsigned long flags;
 	struct netconsole_target *nt;
 
 	if (oops_only && !oops_in_progress)
 		return;
-	/* Avoid taking lock and disabling interrupts unnecessarily */
-	if (list_empty(&target_list))
-		return;
 
-	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list) {
-		if (!nt->extended && nt->state == STATE_ENABLED &&
-		    netif_running(nt->np.dev)) {
-			/*
-			 * We nest this inside the for-each-target loop above
-			 * so that we're able to get as much logging out to
-			 * at least one target if we die inside here, instead
-			 * of unnecessarily keeping all targets in lock-step.
-			 */
-			send_msg_udp(nt, msg, len);
-		}
+		if (nt->extended != extended || nt->state != STATE_ENABLED ||
+		    !netif_running(nt->np.dev))
+			continue;
+
+		/* If nbcon_enter_unsafe() fails, just return given netconsole
+		 * lost the ownership, and iterating over the targets will not
+		 * be able to re-acquire.
+		 */
+		if (!nbcon_enter_unsafe(wctxt))
+			return;
+
+		if (extended)
+			send_ext_msg_udp(nt, wctxt->outbuf, wctxt->len);
+		else
+			send_msg_udp(nt, wctxt->outbuf, wctxt->len);
+
+		nbcon_exit_unsafe(wctxt);
 	}
+}
+
+static void netconsole_write_ext(struct console *con __always_unused,
+				 struct nbcon_write_context *wctxt)
+{
+	netconsole_write(wctxt, true);
+}
+
+static void netconsole_write_basic(struct console *con __always_unused,
+				   struct nbcon_write_context *wctxt)
+{
+	netconsole_write(wctxt, false);
+}
+
+static void netconsole_device_lock(struct console *con __always_unused,
+				   unsigned long *flags)
+__acquires(&target_list_lock)
+{
+	spin_lock_irqsave(&target_list_lock, *flags);
+}
+
+static void netconsole_device_unlock(struct console *con __always_unused,
+				     unsigned long flags)
+__releases(&target_list_lock)
+{
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
@@ -2077,15 +2094,21 @@ static void free_param_target(struct netconsole_target *nt)
 }
 
 static struct console netconsole_ext = {
-	.name	= "netcon_ext",
-	.flags	= CON_ENABLED | CON_EXTENDED,
-	.write	= write_ext_msg,
+	.name = "netcon_ext",
+	.flags = CON_ENABLED | CON_EXTENDED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE,
+	.write_thread = netconsole_write_ext,
+	.write_atomic = netconsole_write_ext,
+	.device_lock = netconsole_device_lock,
+	.device_unlock = netconsole_device_unlock,
 };
 
 static struct console netconsole = {
-	.name	= "netcon",
-	.flags	= CON_ENABLED,
-	.write	= write_msg,
+	.name = "netcon",
+	.flags = CON_ENABLED | CON_NBCON | CON_NBCON_ATOMIC_UNSAFE,
+	.write_thread = netconsole_write_basic,
+	.write_atomic = netconsole_write_basic,
+	.device_lock = netconsole_device_lock,
+	.device_unlock = netconsole_device_unlock,
 };
 
 static int __init init_netconsole(void)

-- 
2.47.3


