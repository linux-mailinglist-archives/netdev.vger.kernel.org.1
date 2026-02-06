Return-Path: <netdev+bounces-257541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIDxJd7jhWnCHwQAu9opvQ
	(envelope-from <netdev+bounces-257541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 13:51:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1435CFDB82
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 13:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D05C304C04D
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 12:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3833AEF47;
	Fri,  6 Feb 2026 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="nXM7to+z"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675CA125A0;
	Fri,  6 Feb 2026 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770382231; cv=none; b=qyEIU4RfYH6SMvJP5yqBuMg5/g1vA6l74Zb6vdGYzjVoYiS1c5rOoUJoUBcHm7DG+X/Fztasrle5gIMvBS86Z55E6MdCtENK0a3h5VVN5uJ9PKZt6oeGqQqNyiJpNFdYgZHuECvFDVYTgUd8PeXtmM23rYtHEnYnIOK3iNI62rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770382231; c=relaxed/simple;
	bh=fIda/bwvjdKiEcurZB7NMHmZxg40yG9eI3grk0yk8oU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KuzDg9rf/CJfVkJQrEtFz8e4qOtOEbRdTvvrZkIcM44h947/HPVap+86W+xtk6Gk6SmNm0qKLhlnqTn8vgF415Gb4fo/Vjqy/W6xAEKHGT92iNXSxbjD3vfStVq0Tmp6fhARHXzr1iSrivTv2CPpKDsCa0chdGQAoQD7bzVWVKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nXM7to+z; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=MENmtyopKyio3Fbzyv4qcPtKKWl29QukHQsDDkeHm08=; b=nXM7to+znHGvt38RyZVNbt+LjG
	0tatvIVaT0v1wiR3ZPQXrIUE9xbN6ZV4UCnGSkzBnrDMLnsv5BbUmdEWQ+S3w8nkRr9BKNSo5ZyHw
	xOW1K9NPCywZyQBEIL+WrLslq9vwx40NTobn/yaxk3qeg0FSgH13HFy9mXsDk/hAbsOey2hS7moRH
	J3y9cPVuokVw2LPA6+F8Juq3I+qFdKAGA8Dw/fAQMy/K9LC19bASpvOhulR4ereBkXXxdK6dBsA/j
	8xqijMnZBpqMMl2hiI6glsXKEUlhlx0kEHB7cwAK8m6lQM2qIqPYxAGk1+r7df3JCR0UyavOF+51U
	WrxA9mLQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1voLHy-007AcQ-31; Fri, 06 Feb 2026 12:50:22 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 06 Feb 2026 04:45:30 -0800
Subject: [PATCH net-next v7 2/4] netconsole: extract message fragmentation
 into send_msg_udp()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-nbcon-v7-2-62bda69b1b41@debian.org>
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
 mpdesouza@suse.com, kernel-team@meta.com, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=2151; i=leitao@debian.org;
 h=from:subject:message-id; bh=fIda/bwvjdKiEcurZB7NMHmZxg40yG9eI3grk0yk8oU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpheN8y1yFgWEaQH8zjPuFi3FUuGzg8RxgeHLXb
 mw0Bu/k6SGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYXjfAAKCRA1o5Of/Hh3
 bZt4D/0aZu78pmJ/d09TnR+2Gnj3xX85wO3dwCq///U7PkmyAPapuGZH4+CzYXZO808xtwHO4Uj
 RMu+THsG51hZeQAdFgw5oqPBXMy3iTI0IBg4Hsj1ei2O6AtxFI/TC3pS4XWPh5I0LtqgP4J/tIl
 ZWbein3maYj4LsdBUQ82OKPq6cj3NknAdmUUQSm+k9rl75vrKmn/TiFWi/jYz2EHQvHAiPzqdx7
 ybtmLW5ATOlckr6E50G8n/RK7LKd/7bdgpjzwx93QIZ/nVCjr2lzJBU7Ei/j5EukrQVcKfCR1jF
 ETzwfqWl2Ze+wEOAS92n7zT8mHnuIItzxslPRxXuh3j3ZXehItM+Ece3KmYEyOR8IPK6q6GoniS
 SQkI/DfIGLLOwn3ccORjP+a8n9mgypxvEl30QyFCJczdMCiI6yo0F78vqUxEQ8we40+vj5C8881
 tXRI0+an3+dUIe/1ne82Nwov0+SubMsdRsdhkGawEbiBqtZY0oN4EGXVFfc4ao6VTw+Co/BKbGh
 rvNIPK8dHt6keCWsad8695Ve6jNS8BscoKhHsxwEfCxwM2ceTsh3y5mi3Ll+ZH/InZMPjVsXITc
 W2V2UYM3kEhaeHou9+RrlzTaTRvKZZ2b0OsmBQZSLlATnlnJfRgZXWUQeozIXciNHLjsTicN39G
 kF5vL5netSpm2+w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257541-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com,kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,linutronix.de:email]
X-Rspamd-Queue-Id: 1435CFDB82
X-Rspamd-Action: no action

Extract the message fragmentation logic from write_msg() into a
dedicated send_msg_udp() function. This improves code readability
and prepares for future enhancements.

The new send_msg_udp() function handles splitting messages that
exceed MAX_PRINT_CHUNK into smaller fragments and sending them
sequentially. This function is placed before send_ext_msg_udp()
to maintain a logical ordering of related functions.

No functional changes - this is purely a refactoring commit.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 82c232f9ede24..e37250bf495fa 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1876,12 +1876,24 @@ static void write_ext_msg(struct console *con, const char *msg,
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
+static void send_msg_udp(struct netconsole_target *nt, const char *msg,
+			 unsigned int len)
+{
+	const char *tmp = msg;
+	int frag, left = len;
+
+	while (left > 0) {
+		frag = min(left, MAX_PRINT_CHUNK);
+		send_udp(nt, tmp, frag);
+		tmp += frag;
+		left -= frag;
+	}
+}
+
 static void write_msg(struct console *con, const char *msg, unsigned int len)
 {
-	int frag, left;
 	unsigned long flags;
 	struct netconsole_target *nt;
-	const char *tmp;
 
 	if (oops_only && !oops_in_progress)
 		return;
@@ -1899,13 +1911,7 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 			 * at least one target if we die inside here, instead
 			 * of unnecessarily keeping all targets in lock-step.
 			 */
-			tmp = msg;
-			for (left = len; left;) {
-				frag = min(left, MAX_PRINT_CHUNK);
-				send_udp(nt, tmp, frag);
-				tmp += frag;
-				left -= frag;
-			}
+			send_msg_udp(nt, msg, len);
 		}
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);

-- 
2.47.3


