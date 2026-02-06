Return-Path: <netdev+bounces-257543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOLdLDPkhWnCHwQAu9opvQ
	(envelope-from <netdev+bounces-257543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 13:53:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC95FDBC8
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 13:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 383C03009E11
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C173B8BC0;
	Fri,  6 Feb 2026 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Pd2l5PQP"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E670C35BDDE;
	Fri,  6 Feb 2026 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770382241; cv=none; b=isgat5yY1X5UrRFQqZzexc0AZuzQYaj/sWNuUaDqoBUzWcwm2fF/VvWdCiCJFZmSw9ir1P9qvpXu8oEWw55ZbyVz5o+GKNoOljiByVOaZVUA0z8enKoHl8UBrsgjRhZg42MeBGi+EM2sYCN2ZjxtG5L/O4CNlRVkFRINtPzrMDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770382241; c=relaxed/simple;
	bh=OmeG44rKgyBKxyORuh8V0/p6i8lhDoFG7ZQ9oEafjoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uezVSAW6M1v8+pQPCtHX4ychhL1dCRUKE9RAyALxDwHFL/cw9VFmN2PDqyeuuGC1kUQXCVbkXHL7m4MmQ4wVJovY8MTdiLmjR4QV9stZJnf7XgQnir/TIvvojOQUR0KiZJ+Bm/yD7OyWT0w+MFACtkjlm2/Nt6Ndo7Lm/xmG8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Pd2l5PQP; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=NOP0zvwBDzRaeuaCcbKzyT5NMRYIeO5b3qJSQLlYOAE=; b=Pd2l5PQPr+DLIvf9CySP88MprJ
	0ZpFLpeIUaqEYb8YxdFG6fXL2B9A0mLv1LoFXFu+G/8NEtdeyW2jemiZO0TvrAkJ4l7QCxi50YLQB
	0C52SDIHhxbtpshWtoWYubegB7lLs17V1/AeigA5Mp+7PXks0aD+sNyvSeKZ1SnPFeTfqHwT9DNdB
	zCmbMuhp2YEhsBB00YWjN1R4en1pyeCJrokG4VOf37nWnQoYL0hKGFXbjiCW8tX+tuD8Lpl5+IkBa
	GsaXxG9L3+gnps92zIC/4j8B4qoAof3DcdjfcypOqAZNdv75FfHl2zB7avyv+7eaGAZtv6/UiPJRW
	h2jTZmHg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1voLI8-007AdB-IP; Fri, 06 Feb 2026 12:50:32 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 06 Feb 2026 04:45:32 -0800
Subject: [PATCH net-next v7 4/4] netconsole: Use printk context for CPU and
 task information
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-nbcon-v7-4-62bda69b1b41@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4958; i=leitao@debian.org;
 h=from:subject:message-id; bh=OmeG44rKgyBKxyORuh8V0/p6i8lhDoFG7ZQ9oEafjoE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpheN8tzCk6dq7Hu4fNvIPZJtSDTh6GpqzNwf0b
 qrg91yvR9+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYXjfAAKCRA1o5Of/Hh3
 bRHQEACjfdZ7jsWY4c5w5ouj0bILGcOc734My4XF1hLXkx1DRlkbj7lhfCvtwvGuvzOk8jGRBSe
 2ggOs8pIKe+kWtTrJBh6sW344kEBAG2BO1IiT66v0MM8VKRtOcIWHU6NJNibLs+YDun4w1HQz7V
 v4TqHNRUDslcUTfYKdyOx0qe8TC5A6FSqNuPw//+PZmiSmsBEJGWMumM9Jc++iGe2e9gymbIahj
 eCRZoS+zog+fvMI3+hyK5tL5KG95SeRAF14VvHj5WWiwoLhXf4trpbHjdOFJz2RQE6nJeJ3Kaw3
 81Z4JHsRohwMjtMtEyW0ZTe5ct8QzWjAvSDTJ3B9unpdtNhEVZNvI6QlT2FHKJpf5mhxP/1UUaV
 flfTAUxXdSkCV1uH2bjxyGjsR4F51TOPNVS7l/JhbrMpsLO4XkeJFObMPE3Xp4zibmVbSaOeP3x
 YWL4j/7EOGNVHqvMR34ka9PH6GzWm8h2QLQqIwTx1C0mjl0J2g98OWN6KIab7rF491/X6jACGCr
 j+06KuuEqc+YAWQZJyADHRte9poBfP8y1FMPdXoJrqgs3Qwo8LfzQyvRwVro836kw2gCeUVtH60
 0MnTv6juXTpstZG4D/KuR8yOtdi9WqfuSCUFuXjs9Zp1bVoWBzgCuTHytkm8E6LMZWuldMUEWl6
 JkpoHGQrU9HyT+w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257543-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:email,suse.com:email]
X-Rspamd-Queue-Id: DBC95FDBC8
X-Rspamd-Action: no action

Use the CPU and task name captured at printk() time from
nbcon_write_context instead of querying the current execution context.
This provides accurate information about where the message originated,
rather than where netconsole happens to be running.

For CPU, use wctxt->cpu instead of raw_smp_processor_id().

For taskname, use wctxt->comm directly which contains the task
name captured at printk time.

This change ensures netconsole outputs reflect the actual context that
generated the log message, which is especially important when the
console driver runs asynchronously in a dedicated thread.

Reviewed-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index ec000f477c2a8..0f44ce5ccc0ab 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1490,18 +1490,20 @@ static void populate_configfs_item(struct netconsole_target *nt,
 	init_target_config_group(nt, target_name);
 }
 
-static int sysdata_append_cpu_nr(struct netconsole_target *nt, int offset)
+static int sysdata_append_cpu_nr(struct netconsole_target *nt, int offset,
+				 struct nbcon_write_context *wctxt)
 {
 	return scnprintf(&nt->sysdata[offset],
 			 MAX_EXTRADATA_ENTRY_LEN, " cpu=%u\n",
-			 raw_smp_processor_id());
+			 wctxt->cpu);
 }
 
-static int sysdata_append_taskname(struct netconsole_target *nt, int offset)
+static int sysdata_append_taskname(struct netconsole_target *nt, int offset,
+				   struct nbcon_write_context *wctxt)
 {
 	return scnprintf(&nt->sysdata[offset],
 			 MAX_EXTRADATA_ENTRY_LEN, " taskname=%s\n",
-			 current->comm);
+			 wctxt->comm);
 }
 
 static int sysdata_append_release(struct netconsole_target *nt, int offset)
@@ -1522,8 +1524,10 @@ static int sysdata_append_msgid(struct netconsole_target *nt, int offset)
 /*
  * prepare_sysdata - append sysdata in runtime
  * @nt: target to send message to
+ * @wctxt: nbcon write context containing message metadata
  */
-static int prepare_sysdata(struct netconsole_target *nt)
+static int prepare_sysdata(struct netconsole_target *nt,
+			   struct nbcon_write_context *wctxt)
 {
 	int sysdata_len = 0;
 
@@ -1531,9 +1535,9 @@ static int prepare_sysdata(struct netconsole_target *nt)
 		goto out;
 
 	if (nt->sysdata_fields & SYSDATA_CPU_NR)
-		sysdata_len += sysdata_append_cpu_nr(nt, sysdata_len);
+		sysdata_len += sysdata_append_cpu_nr(nt, sysdata_len, wctxt);
 	if (nt->sysdata_fields & SYSDATA_TASKNAME)
-		sysdata_len += sysdata_append_taskname(nt, sysdata_len);
+		sysdata_len += sysdata_append_taskname(nt, sysdata_len, wctxt);
 	if (nt->sysdata_fields & SYSDATA_RELEASE)
 		sysdata_len += sysdata_append_release(nt, sysdata_len);
 	if (nt->sysdata_fields & SYSDATA_MSGID)
@@ -1831,31 +1835,33 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 /**
  * send_ext_msg_udp - send extended log message to target
  * @nt: target to send message to
- * @msg: extended log message to send
- * @msg_len: length of message
+ * @wctxt: nbcon write context containing message and metadata
  *
- * Transfer extended log @msg to @nt.  If @msg is longer than
+ * Transfer extended log message to @nt.  If message is longer than
  * MAX_PRINT_CHUNK, it'll be split and transmitted in multiple chunks with
  * ncfrag header field added to identify them.
  */
-static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
-			     int msg_len)
+static void send_ext_msg_udp(struct netconsole_target *nt,
+			     struct nbcon_write_context *wctxt)
 {
 	int userdata_len = 0;
 	int release_len = 0;
 	int sysdata_len = 0;
+	int len;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	sysdata_len = prepare_sysdata(nt);
+	sysdata_len = prepare_sysdata(nt, wctxt);
 	userdata_len = nt->userdata_length;
 #endif
 	if (nt->release)
 		release_len = strlen(init_utsname()->release) + 1;
 
-	if (msg_len + release_len + sysdata_len + userdata_len <= MAX_PRINT_CHUNK)
-		return send_msg_no_fragmentation(nt, msg, msg_len, release_len);
+	len = wctxt->len + release_len + sysdata_len + userdata_len;
+	if (len <= MAX_PRINT_CHUNK)
+		return send_msg_no_fragmentation(nt, wctxt->outbuf,
+						 wctxt->len, release_len);
 
-	return send_msg_fragmented(nt, msg, msg_len, release_len,
+	return send_msg_fragmented(nt, wctxt->outbuf, wctxt->len, release_len,
 				   sysdata_len);
 }
 
@@ -1900,7 +1906,7 @@ static void netconsole_write(struct nbcon_write_context *wctxt, bool extended)
 			return;
 
 		if (extended)
-			send_ext_msg_udp(nt, wctxt->outbuf, wctxt->len);
+			send_ext_msg_udp(nt, wctxt);
 		else
 			send_msg_udp(nt, wctxt->outbuf, wctxt->len);
 

-- 
2.47.3


