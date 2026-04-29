Return-Path: <netdev+bounces-282399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGV7OCwL8mlXnAEAu9opvQ
	(envelope-from <netdev+bounces-282399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:44:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B101C4950C8
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D182D3013845
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 13:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D31401A38;
	Wed, 29 Apr 2026 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRE8ZmMe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7703FF896;
	Wed, 29 Apr 2026 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470095; cv=none; b=tNbwLFs5VmA2JoITArhTkGbEMZidYKsu9DbpfreOfLuSWdahm06NYhvdSRZ0rUMvRxACJGCux4G9B5vXST8d5xSoNiQTtFwgDtEYNQb/8pcQM0Ktf/H8wiAfCFVHwEUpLK9yq6Mskqb4G1S3KZMvAKoqbR6HOsjLe5aTOEwrAkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470095; c=relaxed/simple;
	bh=qUGMCU+AoOPlc+ipDJpkT5WgldIctFfJXWrZQIkNDM0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nr5nP/quon8imd2Er2F9lMOnZUhQNu3C/ekw2KSsnd7+lH7r/Oi56ViBnyABA7vWoVxTT4tM2mmljqsHBV4Wxta7DX31hKOvYye5k2dwckPlIzBJsEmWOrrBXGvZRJAnXixU4OrxhpnS/fB050r2eCgvD6YU+7UcW07tUHN5zkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRE8ZmMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DA8C19425;
	Wed, 29 Apr 2026 13:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777470094;
	bh=qUGMCU+AoOPlc+ipDJpkT5WgldIctFfJXWrZQIkNDM0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fRE8ZmMes01cL0ceE/JEi0hMb6xV7lYmQAqxBWWleF/vKtCMRX6rV94tbMIDadNAf
	 ecNeMOmXgYJBxN/w+iUvvjn+RiCT3yfg87FIFH4ZOWFJBxj0o5DHQpGbF6FubpCApP
	 LJg4M0Gnmv5A1Zz8zXqxnNpAzU1FB1EtBC4BaUAuBoCwJ6bGz1v/CMpKxhpjKx/Upo
	 7KZ4J3CeEMvQ5MNBGmP+NkGYmzD6XG/Vj9ioKuCvS8w/IwyZ0O1slt2DMgQ9LqJ8e1
	 b2IVuapCjFz4uJerwX/HFpTfwB6cyEnUoFOwIiWYkDCF1l1tVTjL6hD61WFlEEVmp2
	 oF3ptZ6NANosw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Junxi Qian <qjx1298677004@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nfc: llcp: Fix use-after-free race in nfc_llcp_recv_cc()
Date: Wed, 29 Apr 2026 13:40:42 +0000
Message-ID: <20260429134115.3558604-2-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260429134115.3558604-1-lee@kernel.org>
References: <20260429134115.3558604-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B101C4950C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282399-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,linux.intel.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

A race condition exists in the NFC LLCP connection state machine where
the connection acceptance packet (CC) can be processed concurrently with
socket release.  This can lead to a use-after-free of the socket object.

When nfc_llcp_recv_cc() moves the socket from the connecting_sockets
list to the sockets list, it does so without holding the socket lock.
If llcp_sock_release() is executing concurrently, it might have already
unlinked the socket and dropped its references, which can result in
nfc_llcp_recv_cc() linking a freed socket into the live list.

Fix this by holding lock_sock() during the state transition and list
movement in nfc_llcp_recv_cc().  After acquiring the lock, check if
the socket is still hashed to ensure it hasn't already been unlinked
and marked for destruction by the release path.  This aligns the locking
pattern with recv_hdlc() and recv_disc().

Fixes: a69f32af86e3 ("NFC: Socket linked list")
Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/nfc/llcp_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index db5bc6a878ddb..dc65c719f35f2 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1218,6 +1218,15 @@ static void nfc_llcp_recv_cc(struct nfc_llcp_local *local,
 
 	sk = &llcp_sock->sk;
 
+	lock_sock(sk);
+
+	/* Check if socket was destroyed whilst waiting for the lock */
+	if (!sk_hashed(sk)) {
+		release_sock(sk);
+		nfc_llcp_sock_put(llcp_sock);
+		return;
+	}
+
 	/* Unlink from connecting and link to the client array */
 	nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
 	nfc_llcp_sock_link(&local->sockets, sk);
@@ -1229,6 +1238,8 @@ static void nfc_llcp_recv_cc(struct nfc_llcp_local *local,
 	sk->sk_state = LLCP_CONNECTED;
 	sk->sk_state_change(sk);
 
+	release_sock(sk);
+
 	nfc_llcp_sock_put(llcp_sock);
 }
 
-- 
2.54.0.545.g6539524ca2-goog


