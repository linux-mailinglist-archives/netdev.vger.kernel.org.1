Return-Path: <netdev+bounces-257542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEgmBdHjhWnCHwQAu9opvQ
	(envelope-from <netdev+bounces-257542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 13:51:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B0028FDB7B
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 13:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 718A73018705
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 12:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0EC3D6488;
	Fri,  6 Feb 2026 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="On5zbwfN"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A303D646B;
	Fri,  6 Feb 2026 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770382235; cv=none; b=LfTo+44q26vFKb/hCxQvGcCiZr5piNelwrsBX6d4ImkFTXIkfhxB1yBXMS1EMnnVbT/eJun27OoAc+Sj/mUqzNEBFCJxUQi9dWr6oqpsDWlbhMMs0ln1hKmhuhTQvqtQewatVXUrPizn7uKJ8uKFw7rz4pIhEG8z6oJO2Mt5wTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770382235; c=relaxed/simple;
	bh=LqN9na1qd1i+ro0yk4N3s39b6Cz9o+HafVLFwLUiQMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fl4seVTJxDdBSFH9k9/4nwniewAoWmg0q6gAeUaVEsJTM5oyJPBkWnYiYmHE10Sr8swMTFCOHg8ToNFMRifp2qGQGgvnDtacn4Lxu31+8oNWORarb9FKyovHGO8hNV4+YAvvHUSJZ3RwMqeNv2ZnWzA1BX4j//X6WZKnPTqWns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=On5zbwfN; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=YB9D715bAwbjNab2XlaCMy48nfwohP5BzppeRgyMIQw=; b=On5zbwfNC4wumEsQBTkRyQf+el
	1lxUZ7WGr5rmr6tgQkmNAx7atRDGhDOj2KiSJcvw+m/HPezXWiClPAnZZf6BsxrRSA1dwFZC1d6qo
	eMYwrwpXl5l9wS4d2+kEjO95NGPHnPf+IroT/o1lodUYItCCTWlXlKf8Ln9ZEUqmO+xEEdZpMQyb9
	wpsKLYDVZR+95BJRzpCzwp/wwoJH+lCb9kbZp7yEoEbWL+G31xplwfy1+rxnibgXEasm8f+DNhixw
	hZYgF/O3Kf0GVLUojX3MdWEVh/Kil87dYgGIL6E5mk8EkU7lV6BUJNTwrGc3BSk+XqM+kPkOpP5yB
	BtKDSKLA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1voLI3-007Acp-92; Fri, 06 Feb 2026 12:50:27 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 06 Feb 2026 04:45:31 -0800
Subject: [PATCH net-next v7 3/4] netconsole: convert to NBCON console
 infrastructure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-nbcon-v7-3-62bda69b1b41@debian.org>
References: <20260206-nbcon-v7-0-62bda69b1b41@debian.org>
In-Reply-To: <20260206-nbcon-v7-0-62bda69b1b41@debian.org>
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
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=5682; i=leitao@debian.org;
 h=from:subject:message-id; bh=LqN9na1qd1i+ro0yk4N3s39b6Cz9o+HafVLFwLUiQMc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpheN8RcRstgAjFITUfmQtS6Rfn25M49gcvgC1o
 EmlD+BaNDCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYXjfAAKCRA1o5Of/Hh3
 bbN8D/4l2k+XpXaVclZzF1pDyFG+cDQWqpZHlcIB1eqfIIjNArME1b0jix5Mio3RpNRaWol/EuG
 NDMdyuG9Xg4xDVJIAp1QVFUCtyP6H71HvsfkN7KhjG1L1RKLtRFYpfstMjhf5UGexBrD6LvNp0I
 Vg/8pdqqUdbPx3cQhEE7tdAgYvbbMvaS97gxGTzV/42YH1NBOXNFeU8BN5glBvMSot2seKzmJo9
 +F+LvqS2VMgnlM6lt7SyPG/d40uD/nVlb6+2EOvRYpoWhUwo9ytWLgGtpNhmLGa93BmtQMzqamw
 PsrYDnTkiMQDC+t2xt31kdgFMLH53a5k03qlKJSdbyUP5jiNunWi1h9zLtlPOwLno45Z3MUNHUS
 +pI+MTDLYLIel+gZ0AyeK9W1+BuCjXu2Z+dLFOZo50xXs1btE6fm36wzs7DRJJST7WUPSEpHvyK
 NooCPkBSJVi5WMiLmEKY5hB6klTBOJEVifdPy4ejkKf+zmPRfBQi2ZGkPC81aNPtWyNYlO0jrO+
 2rycH0LRApMdAg1LMzbOEklKSgVrvB6F96lXOmW+zBd5CVoQ2UqPxNtOZL6MlrjZbkLc2CYPsGV
 rPqpaRpA5zOllJPEmcTS7pbiwfpAuEXohJ5giFedqo++KzedfNdcbMRxpEbYcvFEeX/xq4AxUBk
 jzpIHSRz9Uge6ag==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257542-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,linutronix.de:email]
X-Rspamd-Queue-Id: B0028FDB7B
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
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
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


