Return-Path: <netdev+bounces-256375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H6bNa4wgml5QQMAu9opvQ
	(envelope-from <netdev+bounces-256375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:30:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A3ADCCCD
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12849308C87D
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A346D2D2493;
	Tue,  3 Feb 2026 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Cl66yKVg"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7A52F39A1;
	Tue,  3 Feb 2026 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139484; cv=none; b=AHlYBQLNn80Z/80Wg2Cy8HaPV/fpdiiP+ISE4iRT3jVWKrQ/S33eMv5YaaaJ7QIng/jvL1G4n8N18w5H06Moy+0/uu9tCzNRm2qLlj+eZbW+Ca31J+Q9eux4y7oZCmlpshdKrrh/NP5RigUwp5IuUVcYf0nfrYgaaVAx8jA6BlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139484; c=relaxed/simple;
	bh=LqN9na1qd1i+ro0yk4N3s39b6Cz9o+HafVLFwLUiQMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u6cDHMBj2Ygqk8tMkWr+dq3yf29gN6qUB2Ja2oApo6MVdJVSMjYoy/LvtZLErGVXW91znnMlGFb4dTI006v1xqa0GlrJ79RLatCuWsDCoM87QDTlvxwLUabedIy9DXSJMdxUdjHgyGRtqo9oaHs2hGGKHKj5kT6lyDwvOdGc9uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Cl66yKVg; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=YB9D715bAwbjNab2XlaCMy48nfwohP5BzppeRgyMIQw=; b=Cl66yKVg2T17+k2gaiXGX9CEUD
	83Oq+2NpYV86PK6qh3LDSAG9jaUOQb/mpdRczCesd422tNcQa+iJ33Ah3njZ9ouCnCK6F7HDuGLLz
	8vy78Y9M0YAIbSpTS3J5h4GK9nXBgLKQWZPYWnhQ72pJ8n9fIn0RKNenmhuEALkyCcGFGVlP6GmLO
	Xm00BwMSFCTzs8ivVYv0ZWN6YxvflWjGQUN5mXbFedezvVw7w0Br435FrBexjW9I2VZskvxw1mrBK
	WTRM5ht5RIwTo3EFVY7ASS+3cgtQ2nXmn1Ra3g5xzI1ZrI2ZQTnMMPjbpL1XWeGVflnA9rLnYHR8g
	LuRH20yA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vnK8m-004z5k-8c; Tue, 03 Feb 2026 17:24:40 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 03 Feb 2026 09:23:54 -0800
Subject: [PATCH net-next v6 3/4] netconsole: convert to NBCON console
 infrastructure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-nbcon-v6-3-985f3bdb3267@debian.org>
References: <20260203-nbcon-v6-0-985f3bdb3267@debian.org>
In-Reply-To: <20260203-nbcon-v6-0-985f3bdb3267@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpgi9CWIQwlkkTeQIiCRFb8cKHMtsx33vDeeq14
 oGcyDTmstaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYIvQgAKCRA1o5Of/Hh3
 bUKvD/45YvMgBb5Q/qVfGyU1eFqpGt7wAbaBiUGMQkTSlIw9/N2H51SQzIpZzKTihT8tPMrD4Z2
 gKidS66Q6qqUyxIWoLuEKnSJpkyhmp4lyPfHQLqecd13duFWww5Iie7aWM1KJ9sPEyGXOHKQFm2
 GI2z77lEANMSHNqsAZpz4RJcyE4+AFoQ9YbEqWNOUTMwL2BOVvxrgXWVezCM7T1RwCS5X6jy4XM
 o2J8W26POtEPtgPg/+PhAPsRLldq+rOAypboHBw4i/xxVy2bsYRfBrvuI8paqbep05oYiQaFo7n
 6JFVubrE8e+QLu61NMlAOVMxrPINUtR/IGQ6OXO/l1oqhuG4irStHWUmvqo1DGFB/Rbl04q7+Dc
 XrhCj8iep0JqR31o/CwXTueyMmW2t0dOTnImSfLnQJaawfLYmU7K9ZRCLAp8Ck1o7kfcnZcv/zm
 5N08TMnbB+1fDcfDe3fAExOruS2UfNRnYTKQfxALyMajELwf4ql42btWekJMkQo1ZhmxEfABmTT
 a3YEbKLz0z5CzhbnD1Ad7v3q+xIBc0dbEyL+gUIfi2V7ul5jK4yAkD1bP3YnLZi9nDdjd6vnpuu
 4lwU+TD4rUTWZb7Juk3tQoUuK3lG6F6qBOWjMHHaXwjazuvUH8X68jlAzSxpY0z3+kf+5bfhzQV
 rPMhgqs7jvHlyKA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256375-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 55A3ADCCCD
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


