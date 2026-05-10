Return-Path: <netdev+bounces-286326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMnQCTSwAGqlLgEAu9opvQ
	(envelope-from <netdev+bounces-286326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:20:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 922D6505136
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A81B3002E69
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F374539BFFA;
	Sun, 10 May 2026 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga/OrgRc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE9C3A5443
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778429407; cv=none; b=BxA9tTvXdS1BplJXX4+yR2yAt5QzhoaQdqUjZ6qJ+MdWZeC+dC8NLsZV6jrK9lQbCTupG8RATQsLX4qfJ1KmWjxzRnQfg/9/fZLTisI8EOLWH2Lc7Zje0QZyY37poFxwo1TchTDU66a2wKlS4uxfpYTDR32bK2Ky7JF7y53GFcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778429407; c=relaxed/simple;
	bh=/C1AtR0JW/h2hzENvbf4DR/8IVXItFwwjH98d8odfYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z+dlmpWbUA0B9yDecPxCbH4K6iSMVZ4W3qAkA83gUyiVp5Ro7CIqCj64WQpczykP9awHtonMVkR+7AfMYi91qYDLuffXnwnRXZdSlZdtoazBc8o4uJPlr1dJdJrf/hcN1U2qOan2gOvAuR8S3b0ML8KtrvM3CxZW12+dmcOdBaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ga/OrgRc; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so9473952eec.1
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778429405; x=1779034205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=geaDvAmasVlMMh0eQAus1fbqXttFnWLmVPGio/oP6Jw=;
        b=ga/OrgRcHmVyC6hQGZuKBtuJ/hLqo/mEX5LvpA6aaA2pK1+MDUdzRgApg5B4rddi5e
         Om77wAaWr5zUgapJAmEzSRINGEZjjoaCg80iVswm80wq4Qr3dOf6Gc8Gh0vA5EjNWWU1
         cNzW2Iae91+33IVLZpd7Cwh5MJHjLAXl2iok6Fb3tbYPOISB+WyBdrtIGfBx049f2G1d
         +n2K7cKFKXimbW1KioR81pFad1qJCfc1BhQ+Kw2tGUAYuKmXTWnYF65N/UHrapK1OqLg
         NyDeEPWW/jh9IQtxrg0IE6kWRv9eCDbKSm29OvbXVwggm7tccd7vUVxRqdBpYhCr5KmM
         zRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778429405; x=1779034205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geaDvAmasVlMMh0eQAus1fbqXttFnWLmVPGio/oP6Jw=;
        b=QiWnzb834QT54e33R2h3ria/tzrB8X4Mt9RI7yiwgzNcn4L15C+/nfKuxEuNPFRe88
         73NFAax94M0spq6uhc693VC6tzNE0thkVzr69vQR+CQU4DgQr6+HO8d9fYLuLFaUjxt8
         pEoLVye3EM1UqIlZCiCBYCF9DInNG1om6uTQwnrzhhVqfTmD2YgujYaegi9nrohterCN
         3qpwydK3udPXaGFqKcd4ayBOAZLqeMwWwqEsc1zOqg1kuBoBXnZHbl30VuGBaeBBTZOT
         Ions75sMxT+fdnPlEDWR31F1HHIC0ZN50E+6f4d3in02Z1V7R2wrBf6eo363TjaRuivz
         oznQ==
X-Gm-Message-State: AOJu0Yz/f3Z8b0zqr5Uq+OPyrhAD/UsbhVekwWGSgL/WdYL5Cv+liD4v
	VKusyAPh1ia0EM0vWBrHPpML4f44Y+o6+vsWCCqEm7C1nLMUi1SHiQ0Z
X-Gm-Gg: Acq92OEnjYp0R9oRR4Y3muexdSBOSSI2a16fJPe1npOjk/dgTftaV/GOC71mFdC3btr
	QC/oE4luZzITIVrlxPYb3RFAqxD/6t8UlKLPErrLOzxOF6N5KKspirD4/Dg5g28YiJwxhv4X/JI
	JEue448wT0YBKirZ5CrYZUOjOj3f2s51WTUZZKIz+d1UvOpPCYYgRxk/izySbND2c0nhHNOXSRv
	bg9G3dxhyCEX1ldypqW3H8+uWwBSiyhIsKcDhz5+8Lt84jdAY6cwVXeNAaEwhaeJt9CDI6QcnrV
	r14omOhKJTMlIBuaDDB5N/1+76LCkSdYY5e5bEN7ZJ2Y6yUPB4wFtsWWqN0aqLMNRVAmsZRrFPb
	JTdccovNGPo6W1Cev4k6XYAg5LkSpChmXTyqfNDdv174wvH5E/3lTjCywYflYsjgp0LjxDIkPDJ
	kMbGGyi+QhrO7XXXmiRj7M5BGGHn9NMMe9gWboECM0fgaABFobrmYqHtr19iKoVgnz8V3g3d8AW
	eWIx4/+SA==
X-Received: by 2002:a05:7300:a987:b0:2dd:c066:bf7 with SMTP id 5a478bee46e88-2f54b360d4emr9554769eec.11.1778429405552;
        Sun, 10 May 2026 09:10:05 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8893441absm13313070eec.31.2026.05.10.09.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 09:10:04 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v3] net: team: fix NULL pointer dereference in team_xmit during mode change
Date: Sun, 10 May 2026 09:09:53 -0700
Message-ID: <20260510160953.2077863-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 922D6505136
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286326-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,asu.edu,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_SPAM(0.00)[0.643];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: add header
X-Spam: Yes

__team_change_mode() clears team->ops with memset() before restoring
safe dummy handlers via team_adjust_ops(). A concurrent team_xmit()
running under RCU on another CPU can read team->ops.transmit during
this window and call a NULL function pointer, crashing the kernel.

The race requires a mode change (CAP_NET_ADMIN) concurrent with
transmit on the team device.

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 Oops: 0010 [#1] SMP KASAN NOPTI
 RIP: 0010:0x0
 Call Trace:
  team_xmit (drivers/net/team/team_core.c:1853)
  dev_hard_start_xmit (net/core/dev.c:3904)
  __dev_queue_xmit (net/core/dev.c:4871)
  packet_sendmsg (net/packet/af_packet.c:3109)
  __sys_sendto (net/socket.c:2265)

Fix this on the writer side by replacing the memset()/memcpy() with
per-field updates that keep transmit and receive always valid.  On
setup, smp_store_release() publishes the handler pointer after
init() writes mode_priv; smp_load_acquire() on the reader side
ensures the handler sees that state.  On teardown,
smp_store_release() installs the dummy, then synchronize_net()
drains in-flight readers before exit_op() tears down mode state.

Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v3:
 - Clarify barrier ordering in commit message (what release/acquire
   synchronize).
 - Drop AF_PACKET mention from commit message and code comment.

v2:
 - Move fix from data path (reader-side NULL fallback) to
   configuration path (writer-side per-field updates), as suggested
   by the reviewer.
 - Use smp_store_release()/smp_load_acquire() instead of plain
   stores/loads for proper ordering on weakly-ordered architectures.
 - Add synchronize_net() before exit_op() to drain in-flight readers
   and prevent use-after-free of mode private state.

 drivers/net/team/team_core.c | 46 ++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 0c87f9972..559afd36a 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -534,21 +534,22 @@ static void team_adjust_ops(struct team *team)
 
 	if (!team->tx_en_port_count || !team_is_mode_set(team) ||
 	    !team->mode->ops->transmit)
-		team->ops.transmit = team_dummy_transmit;
+		smp_store_release(&team->ops.transmit, team_dummy_transmit);
 	else
-		team->ops.transmit = team->mode->ops->transmit;
+		smp_store_release(&team->ops.transmit, team->mode->ops->transmit);
 
 	if (!team->rx_en_port_count || !team_is_mode_set(team) ||
 	    !team->mode->ops->receive)
-		team->ops.receive = team_dummy_receive;
+		smp_store_release(&team->ops.receive, team_dummy_receive);
 	else
-		team->ops.receive = team->mode->ops->receive;
+		smp_store_release(&team->ops.receive, team->mode->ops->receive);
 }
 
 /*
- * We can benefit from the fact that it's ensured no port is present
- * at the time of mode change. Therefore no packets are in fly so there's no
- * need to set mode operations in any special way.
+ * team_change_mode() ensures no ports are present during mode change,
+ * but lockless readers can still reach team_xmit().  Use
+ * smp_store_release() to publish safe dummy handlers before teardown,
+ * and synchronize_net() to drain in-flight readers.
  */
 static int __team_change_mode(struct team *team,
 			      const struct team_mode *new_mode)
@@ -557,9 +558,23 @@ static int __team_change_mode(struct team *team,
 	if (team_is_mode_set(team)) {
 		void (*exit_op)(struct team *team) = team->ops.exit;
 
-		/* Clear ops area so no callback is called any longer */
-		memset(&team->ops, 0, sizeof(struct team_mode_ops));
-		team_adjust_ops(team);
+		/* Install dummy handlers for locklessly-read hot-path ops
+		 * first, then clear cold-path ops that are only used under
+		 * RTNL.
+		 */
+		smp_store_release(&team->ops.transmit, team_dummy_transmit);
+		smp_store_release(&team->ops.receive, team_dummy_receive);
+		team->ops.init = NULL;
+		team->ops.exit = NULL;
+		team->ops.port_enter = NULL;
+		team->ops.port_leave = NULL;
+		team->ops.port_change_dev_addr = NULL;
+		team->ops.port_tx_disabled = NULL;
+
+		/* Ensure in-flight readers using old handlers have finished
+		 * before tearing down mode state they may depend on.
+		 */
+		synchronize_net();
 
 		if (exit_op)
 			exit_op(team);
@@ -582,7 +597,12 @@ static int __team_change_mode(struct team *team,
 	}
 
 	team->mode = new_mode;
-	memcpy(&team->ops, new_mode->ops, sizeof(struct team_mode_ops));
+	team->ops.init = new_mode->ops->init;
+	team->ops.exit = new_mode->ops->exit;
+	team->ops.port_enter = new_mode->ops->port_enter;
+	team->ops.port_leave = new_mode->ops->port_leave;
+	team->ops.port_change_dev_addr = new_mode->ops->port_change_dev_addr;
+	team->ops.port_tx_disabled = new_mode->ops->port_tx_disabled;
 	team_adjust_ops(team);
 
 	return 0;
@@ -743,7 +763,7 @@ static rx_handler_result_t team_handle_frame(struct sk_buff **pskb)
 		/* allow exact match delivery for disabled ports */
 		res = RX_HANDLER_EXACT;
 	} else {
-		res = team->ops.receive(team, port, skb);
+		res = smp_load_acquire(&team->ops.receive)(team, port, skb);
 	}
 	if (res == RX_HANDLER_ANOTHER) {
 		struct team_pcpu_stats *pcpu_stats;
@@ -1845,7 +1865,7 @@ static netdev_tx_t team_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	tx_success = team_queue_override_transmit(team, skb);
 	if (!tx_success)
-		tx_success = team->ops.transmit(team, skb);
+		tx_success = smp_load_acquire(&team->ops.transmit)(team, skb);
 	if (tx_success) {
 		struct team_pcpu_stats *pcpu_stats;
 
-- 
2.43.0


