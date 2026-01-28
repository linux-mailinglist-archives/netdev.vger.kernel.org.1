Return-Path: <netdev+bounces-254281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK4zMyIcemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:24:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35235A2B7C
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CE02308CDCA
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B33C2737F4;
	Wed, 28 Jan 2026 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ZlL60zL5"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC01027AC28;
	Wed, 28 Jan 2026 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609912; cv=none; b=PatNachbz1o/YKnLhxw+6+/v1vCiu3Ml7Nn3nFdNkCayFWMqICE2X+9JqAVyqMY1/GsKthR9Vgf55tlj7i1HFZIxr8LQUrjUzjlM6MYv2/FMh78JWud4E11dD37r9GypLraoASzQjt5LEdDWZgRXAkr47I7gvGeXuU+LX/qJtYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609912; c=relaxed/simple;
	bh=sM4MmBb2STkbv+3RBVIqkeR0mqGw9WVKg1AHc37unH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jcN0p7yzzdgAtYEmTtcB4VrY4NHKbJYsu5MCXOW7Wo/mQKAkSJSnfZ9IH+EEh7mnuW2XIMtCOa9vydv8iiGnOsCwjQ7nt1arQZ0lbD7nFcDo7G8lkReELR79QxeTzMUwIuRsSE9Bj2k40zEClbKmpdXzhHDWKCuApo3F562M3hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ZlL60zL5; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=46Q3/PMzTu+WOHkGQb8g4PO/Yj+7Lf8peeoI+CL66Uo=; b=ZlL60zL5U3zUpeQev0hKmOzhXn
	M4otWdck83lEYSfNzswzDgo5rGcTZKHlBl3vqujd7oepVayR+9tb5W6N/y597tvc5BAF6+0BkEwQE
	n7NHU1spo1AQ5oOjECtnHx64oMt1Lei7j8uhgLdfGyE+xj3VSKXd3Q9NBPzRquVSsUpRb8HtCXVab
	Q1QkdP77lmeonUB2guGX6KAdXC4svpBVe2xORv7Gxm5d6trazR8V5GSfJW2XAyRpqBsj4wXL3sibW
	rE3rbFamfrUEoPPRdd2SABjoXQlUBTIYUj9ND8rTG+cRE4XTvbeqMBYMXvDvjivGokTkkmwBbshxZ
	mFOIDc7Q==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vl6NF-000Dt6-Lb; Wed, 28 Jan 2026 14:18:25 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 28 Jan 2026 06:17:38 -0800
Subject: [PATCH net-next v5 2/4] netconsole: extract message fragmentation
 into send_msg_udp()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-nbcon-v5-2-93b4ddbc181a@debian.org>
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
 mpdesouza@suse.com, kernel-team@meta.com, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=2097; i=leitao@debian.org;
 h=from:subject:message-id; bh=sM4MmBb2STkbv+3RBVIqkeR0mqGw9WVKg1AHc37unH8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpehqe/qc/esljZnVRyApFSwh0tA2WhmmltFI7K
 J9WjKLLE6OJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXoangAKCRA1o5Of/Hh3
 bRtkEACYaLBPtotngJ3/dE9p8HTSSSQZnUa0ex7WqLteFUbb1DZ44j3QTek5nrFk6sS3vodSGEs
 0Jue2acjwZ04VKDsEHumvaCrXFCNH6E66hbZWjY3Z5Fx+jU39rdX8HgiRl8JhEG7LoX7WnECgc8
 njVCIDACpLCq7NZ3v3M8C+TW3pz75ZZ0FV8UH5VLVnhK4oMPlSlZVH/YCC65PlMaRjZObrFEQFT
 p1YbxDZIZCM+fCbJ9A26tMV5wBRIUlJNVfXLRwtKLXihpHKfp4SoG6r7lQweSMpqt1XP299LA9Y
 qnoJwrI6jgpO7wMr2X2oB16Dwg3c8xb87KOhr1sfEZ+BJiX+g48fZf8wE4nUYAZxmB9I8lXPZf+
 psaDusbG3n5dPx6+E6WBo8pii37z9T97oDcTgz6FR1rpnETtZS8VF+XgjDH63/zJ7tIEI/JJjsd
 tII9RWoL4Ir3l8cJoky3eGV92ldv/L9xU/42n9u1Rq7J0Km3IFPEk6nGc3XE7nv67ap4WE4v147
 DOuUnq+9abzXMTX4vYanZLDPJV6DO5R29MgztY9YUwPwOrUTirOTMm6MBxpYh1utNfjl4Wrem2L
 T9cXUThJJ30fTEwBXz7VC/YBYER8jB72PzMDsX+l7eIHX0mbb7hUFeKELjMT21XKYgUIoPTzSxE
 V5UsWVZE5D2jG4g==
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
	TAGGED_FROM(0.00)[bounces-254281-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com,kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35235A2B7C
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


