Return-Path: <netdev+bounces-256374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANfkFogwgml5QQMAu9opvQ
	(envelope-from <netdev+bounces-256374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:29:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E64DCCBC
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47D9A30F390B
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E70A35EDB2;
	Tue,  3 Feb 2026 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="bsqN4RRc"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BED35FF68;
	Tue,  3 Feb 2026 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139479; cv=none; b=dl52HOEI5CYUKeR1UyHKCzIvIjrd/xofkwQ5HL790hkCQ3U+koi6Hh3jmVUOifeh39GG3RfiLlwr1mjOjRH3iI0r/KdvNP0m+ouWp8WBp/OZzTrRgsSUUZiqjHw5SJ22R+9KxIK2XXPn+SU3XDI1189ykTroRzfnTixorcC8ZXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139479; c=relaxed/simple;
	bh=fIda/bwvjdKiEcurZB7NMHmZxg40yG9eI3grk0yk8oU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X8dgxwQ7TjeLS35IuGhLZr9JMSRnWzVVZriNaJefyHS6xicmRhDRHyxntBIkD43x367YNOuP8kWucunKR9HpluekiU85ivRi505zI+LXStNxQgsNlDcrCI8hOW4PRa7VQFL+mZJ0c03ANcbS3IovojTLtK3QCmiykDNMYedYzts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=bsqN4RRc; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=MENmtyopKyio3Fbzyv4qcPtKKWl29QukHQsDDkeHm08=; b=bsqN4RRcxRcLEcFV63RAjG7Hqe
	az+gV+o2PTxGu48EdCpP6A+NfkKqvzqdS9K3x7JKa696cPcKt8WkMc1Wa26mnvh7BXI5H3+ZN5L3U
	VNxgItw26JGdCsj/kj7ge29+BmRpFYWAkfNrlGVNz/9p7msvBbLuuJiWCYl85kFoMEvcL7Uh8MkT5
	WauRlpIaA9NDqJpSLgWwRMB0NWvjdS19Y5IEQKiE00XIz/PD2U5luwDTh7RjYA79kBQqSlK1W738E
	bu9ofXFg1my7W3Majdo404MFaAbDDfI9IEdgfWinnXf6S9bPnlYawiKFaPjHBAChej3nHj/DLRhSS
	f+tT4+Xw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vnK8h-004z5P-5h; Tue, 03 Feb 2026 17:24:35 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 03 Feb 2026 09:23:53 -0800
Subject: [PATCH net-next v6 2/4] netconsole: extract message fragmentation
 into send_msg_udp()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-nbcon-v6-2-985f3bdb3267@debian.org>
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
 mpdesouza@suse.com, kernel-team@meta.com, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=2151; i=leitao@debian.org;
 h=from:subject:message-id; bh=fIda/bwvjdKiEcurZB7NMHmZxg40yG9eI3grk0yk8oU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpgi9COE3x6BRCzJ03ljpFPNNvtZQc1igJd25Bq
 6ouKiv4hhCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYIvQgAKCRA1o5Of/Hh3
 bfe5D/9lah+lwTsp3aCl6nlkEOOOHmVuQvkVqGyiMnT2pXOd36x6bw+r+/qXGqzvsx6DIwSPwhC
 jjcNKnOfkeE2zRj+qC0w6hn38pfIAGiGbgyWrVQY7zDkBCQAH4DotD97fHRl4D9IP5Ec3/Lln7t
 tydHWlZ3/T3+UyvoNEBePKG6bPZJzMmxKcLXkWjHqw78qKW/JfYjyFc9Qb5jxYQoUiB27qC95jZ
 YYRUdpdMc6YR2smdLZuxR3aDmYQSbkZ6vTVWKy2V40Gmyo0W7JPTAwpbzGPG1g+890uMMLQ44L+
 IL6ZyuE1no6Te0BHaGVvAvUsjcew1aGDTkJCQvy9p0RShjr8M/oE7ICDflNQs7QKNz1gjzZ9xhP
 S9o+qKMZQ0wr5p4J8MEeq1dnLecvZPA+2/VMFxTOS7ZV/0MKRSVYqU2NNoVjcif77OMdU5RjwYH
 Zbc8yIDjLrZTF7+9050C/cQEMYgoEhAZxL5grZkdkRg1TTcXD5sbYWvBMSuxuzlc3a7eRATt9lE
 UsF5F8Iux8XmZJf84GxYSjoX6pjXSb+DONjg80cQhDhNv7IV7KAHhkwXRMBXInL7NgRiCfUVqzS
 34Z+b1lFkWCZemFzGME2bziQr5pY2D5jKZgl0+9JK/UcDvNSU4Q2twfV8mmSS7zfqYPOIKYUKKJ
 KtVwINfK2WKNgwA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256374-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 07E64DCCBC
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


