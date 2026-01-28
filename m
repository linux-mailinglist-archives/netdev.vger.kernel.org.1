Return-Path: <netdev+bounces-254283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEx0Ae0aemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:19:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9916BA2A3A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 887DA301241E
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05595279794;
	Wed, 28 Jan 2026 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ugwOpqv4"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C406279DC3;
	Wed, 28 Jan 2026 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609921; cv=none; b=XZC9EWCtPiAkSCB0aR3vBd3yOTNTSeCaiLAt86WWGemoEug13AGMN/z/s21jAbLNCzbBOymjUAgnEseWWoO2WiX/6d6fmKKoHLlLL+hZAwhnXDLzX9msIrlWG0cbkE5xbQchO3HHZRjVgYDih9o8C6gf1HbVKWW2AaY4/75l+Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609921; c=relaxed/simple;
	bh=836B/rxD2lUW0GeGAux4FVApdOXS1I6GKcBB00j3jSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VI78b/oHPssUsjhAmoMwAEDITGpoKa5w2SIN85nL3W+2xw0pY20MoqMc754wQlvfX+6tD+S0DmcVOREj3kIaoO+7TS6kodgSNr6ZP1KUo+61DY2jzLPgixGIub6Or+r/sAC3vMVopPEhfOicPK01eSqKLtcaTtbnO67Bb0Ae1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ugwOpqv4; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=SVQdYhNhZkjnMcKdvs7TsBVf0DPXFlB8N7xeGZuEaBw=; b=ugwOpqv4GR89BgOmeg0NkhHQS4
	0ck3Bo8IUo6UipYq4coTln0AO4oYX1Ge/Cwjq6lWWsMbg/pY8db1OZPErqXIfygTYuyOEAsb7OmSh
	vhK/twalx9kES16lIRr6GuyIAfCfOnXKI6xLqh0LmsTwbjaqhatzPvf6TusR08iVf31rjoEYghwMa
	bZQ2WdD7ECoEoN/XZ04BRy5O4oOrVNBD6NPmIdXhYsKv1Pau6LV/4kIjt+nfTCQ/ptbXn9V+bMrNE
	bQfGSekFqCcvmgrzXIs3yHaMj6RvigdPY3rnTiMGzi3yq1jl3MLV/ShJhEjzNknlAwfkjdZd06B8p
	fkr8St4w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vl6NQ-000DuM-9x; Wed, 28 Jan 2026 14:18:36 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 28 Jan 2026 06:17:40 -0800
Subject: [PATCH net-next v5 4/4] netconsole: Use printk context for CPU and
 task information
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-nbcon-v5-4-93b4ddbc181a@debian.org>
References: <20260128-nbcon-v5-0-93b4ddbc181a@debian.org>
In-Reply-To: <20260128-nbcon-v5-0-93b4ddbc181a@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4859; i=leitao@debian.org;
 h=from:subject:message-id; bh=836B/rxD2lUW0GeGAux4FVApdOXS1I6GKcBB00j3jSU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpehqeiV3lDU9f8hOTn1ryjodJGHd7p813fBro6
 F8NAwus8MiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXoangAKCRA1o5Of/Hh3
 bR4BD/4/53eRvLZ3+MRD+7DXe13PtVsGCmK2cqOspfsSqxst/FePSMgyeMsfB2GX09nnTybTD/0
 qbWdrsYpNj61XWEGpYn8+kY6LOPQ5dNFPOgjCKulNAmXfKeSqw7mVlh8Et6XtcN78z4uTtSLVD1
 M7b/USnP1V7RtjNuUrnvjoWcs1YBBL60kkJ3yf0xpW0SaIYd+cskRmidKr7bC0SxX8nlM5dkUmJ
 X4gVjpQtpSbX7AqfxcvCsEp/DsSLjTSI5dzNdoCaDCxZX7l83eHTY/sEgObWdto/Bm6nDCXSjXR
 qQtrN9YxiGSJPPmD9D7+s9cY7SZ6b5Qq0Fo9AtsDlOevV5GcSzbmkj8MnV3uJ4DBr2ikEANb+ZD
 uHPpwGsNMVmyJWliEf7PGenVXYQn2pX4dOnwOOI1TiGfZH8vdHW6y1OjSCsSIE116V2THooPl7A
 PSBd4AxCfncpwyuv+TeQI9HNQ19fmAS2Kn5NTPeuldVOjqCgIvk+VuQsY5SIWNkyYd1BwkZQsJZ
 nteadWJY0fitE+Ai0kvWIfInSkHjQcbolpywpLv14t/i4DLdLREwo2OX/PObbc7nF7OyVifewrz
 rhRSIKjO6k6I/fqFL/shlDba/2Pv7tlQxguX1O3WD1b580am7DJjQQEV0C2G3/qmKuIaPVWIGBO
 anhC/u754K/Hdwg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254283-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9916BA2A3A
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


