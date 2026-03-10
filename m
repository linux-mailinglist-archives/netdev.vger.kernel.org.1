Return-Path: <netdev+bounces-266031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AsaDnMEsGlAegIAu9opvQ
	(envelope-from <netdev+bounces-266031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:45:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4531424B814
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DE1630F5CC4
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9E8389462;
	Tue, 10 Mar 2026 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZB9QGIMd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEE5356A3C;
	Tue, 10 Mar 2026 11:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142433; cv=none; b=SOb4B2VlYvifFU5KRtolcwuIsjYdnSTXTKMGjq0dh8D08elRQ4v/e3VN4I+bo0eNhuuYc7AaRs+b76rd+u1lhaJC0khcvsWtrIojRJ70FmK+VaHYHWZDvkYRwDr8widC33qdhZdZpG9VOZV2O9UpX8L9uBC6hourzS9SX7pW5+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142433; c=relaxed/simple;
	bh=FlBTxbiu04ltMi3nGtIIDADiWqMqPm+Sj6kpNYVnfAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r36eZeMon1TfH+4py3bKcbfr7lQp0guEZXyX6e4lnX1HfckqrMtjtB+5zvWG5zuoxtlcZFwNdaEihBL8kD+4+/doLQ7PveDp/kxMGahqLkvmlhJ1pUpdHxoC9cCzys48FznuBghc5b+w6oIK9+GHdICvVek2+L5DsvaYAjr4stM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZB9QGIMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0BAC2BC9E;
	Tue, 10 Mar 2026 11:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142433;
	bh=FlBTxbiu04ltMi3nGtIIDADiWqMqPm+Sj6kpNYVnfAM=;
	h=From:To:Cc:Subject:Date:From;
	b=ZB9QGIMdTteo2tdqjF1veBsCAWLSCBX9HonfyJqN5hfIg+M38EpQb3SmGNO84lMbd
	 7tmuAaPeaY59DTVfy7yHc/awwfAlZRwYulpFHSFlY8JzdSUEK583e6/fGIRQeuE4YJ
	 UELx8cgDi2Qv0YWy3+64tQ+9obfnCYjsQ1zS+pDe7bb3VD92DGD5zfOPWG5MvvHhUG
	 l5OZBhSXhJqrEIw8z5ifCPr9vi57vPnBljwTPieJ5EFXLKLyXGJrQGx+lP1/VdprhC
	 56uyrTakANp8MsJcnAsm13B2mPqEbMFPfxlBsLEhjuVZF+M5NH0cEMJ5qA+d7Wr7ak
	 Ct5Px17cnaE+w==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: Convert move_addr_to_user() to scoped user access
Date: Tue, 10 Mar 2026 12:33:36 +0100
Message-ID: <36d7f2e7f504d620c1b88526b25ebc89e3cb61d9.1773142315.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1681; i=chleroy@kernel.org; h=from:subject:message-id; bh=FlBTxbiu04ltMi3nGtIIDADiWqMqPm+Sj6kpNYVnfAM=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRuYJxyrS1WYcvDyoh/fZ/iJZUajc6lHzvlsCu0uaQkU uSX6eptHaUsDGJcDLJiiizH/3PvmtH1JTV/6i59mDmsTCBDGLg4BWAis3MYGS4ZXJybrH9wXirf kRenixq/nQkrfMnVu/hMzo2iiJsKXToM/9MCDe4x9H3fISXptHeO57K1ot/OVNt9S1hQa/+497i NAR8A
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4531424B814
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266031-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

move_addr_to_user() is a critical functions that was converted to
masked user access by commit 1fb0e471611d ("net: remove one stac/clac
pair from move_addr_to_user()")

Convert it to scoped user access to simplify the code.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
---
 net/socket.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 05952188127f..66eaf6d59941 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -280,23 +280,18 @@ static int move_addr_to_user(struct sockaddr_storage *kaddr, int klen,
 
 	BUG_ON(klen > sizeof(struct sockaddr_storage));
 
-	if (can_do_masked_user_access())
-		ulen = masked_user_access_begin(ulen);
-	else if (!user_access_begin(ulen, 4))
-		return -EFAULT;
-
-	unsafe_get_user(len, ulen, efault_end);
-
-	if (len > klen)
-		len = klen;
-	/*
-	 *      "fromlen shall refer to the value before truncation.."
-	 *                      1003.1g
-	 */
-	if (len >= 0)
-		unsafe_put_user(klen, ulen, efault_end);
+	scoped_user_rw_access_size(ulen, 4, efault_end) {
+		unsafe_get_user(len, ulen, efault_end);
 
-	user_access_end();
+		if (len > klen)
+			len = klen;
+		/*
+		 *      "fromlen shall refer to the value before truncation.."
+		 *                      1003.1g
+		 */
+		if (len >= 0)
+			unsafe_put_user(klen, ulen, efault_end);
+	}
 
 	if (len) {
 		if (len < 0)
@@ -309,7 +304,6 @@ static int move_addr_to_user(struct sockaddr_storage *kaddr, int klen,
 	return 0;
 
 efault_end:
-	user_access_end();
 	return -EFAULT;
 }
 
-- 
2.49.0


