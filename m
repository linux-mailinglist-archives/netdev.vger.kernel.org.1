Return-Path: <netdev+bounces-256376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCg4MdUwgml5QQMAu9opvQ
	(envelope-from <netdev+bounces-256376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:31:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33045DCCDC
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8902730F8074
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E046431D759;
	Tue,  3 Feb 2026 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="gvRI65f2"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4739431D37B;
	Tue,  3 Feb 2026 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139489; cv=none; b=Gus5VHRSBLki2YCu5DYtGLR4XBAmzPOdFDwNZazadvBJ0YJ/NM9q3heGVCgZPspAzhGjlWsZuzWnZ0w9Hm427jv37TFQW6EcIT2hdekHkwk9jpo2BJ/1cTxdSIgNT2UlU6H7WZRk/p2dF5MCWWrpGnLTU971LPGX5tJp19Y7PMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139489; c=relaxed/simple;
	bh=OmeG44rKgyBKxyORuh8V0/p6i8lhDoFG7ZQ9oEafjoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nmrpn6QWyVJqHLrXL/T0pSp7BZpf/vYbEaFfykDxyt5rl1juKl5HR/rvnFw0W0yEi0J/+hxJBbDARTP2AG3lSBhOZ/gtVKYhcZFVSdwJgg8SUMaCahNuOTdLMwdkGHM2KPyzKbgZraruiJwnJtgNTjSf2OI6vjTjngz08GMAlS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=gvRI65f2; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=NOP0zvwBDzRaeuaCcbKzyT5NMRYIeO5b3qJSQLlYOAE=; b=gvRI65f21quzrM1XtkczJoXNFD
	kKLF/R6fT+4+ru5BxXevAVjvJsYSUD1roGzX1xjiotrI97O9f21Nf4gZUJm621SEJcs0UNp8uyK72
	44210lv6dMUPNC4AvEN/0epN+ExI4vyVZmmsb8se0VbowkYWx7BJCuq2BoMXcS5UgwfQwwP6hO+tl
	YYZ27Z+MEE24ZnbUBiboYUIDcT7CeWt0lww2uCi4C6eW2IATYzBGGacRbfWSLm3ahXwBSUdDQLaNk
	mawdnfyZxfsA7TbTNKELdDWTGfABs2kdzl0UUdcxWwtayRRZDN6tU3v0gfBshVrROZO9RfmEqRLW+
	BWu593iw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vnK8r-004z6I-IX; Tue, 03 Feb 2026 17:24:45 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 03 Feb 2026 09:23:55 -0800
Subject: [PATCH net-next v6 4/4] netconsole: Use printk context for CPU and
 task information
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-nbcon-v6-4-985f3bdb3267@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4958; i=leitao@debian.org;
 h=from:subject:message-id; bh=OmeG44rKgyBKxyORuh8V0/p6i8lhDoFG7ZQ9oEafjoE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpgi9C9TjbwH9w/25/iMSIrFYq4SO4EmttgncGk
 4bfTIuHln6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYIvQgAKCRA1o5Of/Hh3
 bSSlEACAjJLScr4+jdfDmtjpshnG3+sTBIWuysPaQO4/SXqA09C6q5lMANG15yzDl1TkbSkORM7
 YO45ntFkkIJKYv7QhFazeVorNx36CKxhY/Q4lV22kU2tXwC8+ep+WNOpwNF1FNDw7xxrYmu4Y9/
 A78plDqn3/qeh7aqYSv05SW1V1uo9sR8WhBLne91uOB5JS1WjXcrWVoPUDxa795Avpv57fHNxkc
 FE7L+HD8tUUdVmYWyvJlp6aqUj+iWqM+ZCjoItYMMVGBOKIsbpXlijSjtlpmwA10pB3olNP72AU
 rehoCmtWbCvfRYuvnJZI1qxpKCi6REwGfREifpqzYqisGHHLVu/r61owqpSB7bhYCh9CgdPFrJ2
 HysbaR1GyzhPNSbfh+jOu1e5LKhmljBep5soBtwM969j3gWx3YPj1ixwNCI+xNxu6mY/t3kmMiq
 6KwAKkOtc6fWAHaQaZ9TbNIweKs4f6hLf3S/ResGWIHh0EkkCH227WkknEf/UuJWAdgLUVz80XN
 3TPHRJP3vDw8qIe4mNDKcOY3HelZgdG8PdmQ8OY1HhyU8atpSDKtp5JrrdAI7py7+ByirscORIq
 aixxPH9m1W8kWq0xmYogMRy8GXhjCmAQLW4xx+PP4sxlm++RT0+0BE5l7taKmnB/o9UjvOd0tB6
 VTyygQ6FnQY/6JQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256376-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 33045DCCDC
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


