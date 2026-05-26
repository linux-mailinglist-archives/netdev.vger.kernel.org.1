Return-Path: <netdev+bounces-291719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGnyGRuuFWpkXwcAu9opvQ
	(envelope-from <netdev+bounces-291719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:28:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 042145D77B7
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1F1B304CFF5
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E53C3FF1D8;
	Tue, 26 May 2026 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVhUR77z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332003FBEC2;
	Tue, 26 May 2026 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805311; cv=none; b=PUM0/ZOSVDw+MWaWeaprEzwRwrCwjkzlbBsZ5Ur4/VBeVPH2lfBa1tqFerryb8XXgibk/jl5rz5Snh9CdbkQu8sa88+K0i/OCfGJpPVRoWMcmqhVY6Wypy/o5yu+9Ps2O2vRlxK96vxOWOpyABLUgTcdhKMv6ixe6a0Pc02DD6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805311; c=relaxed/simple;
	bh=Kg+xEcA0TGYQcIeGAllHaehuy4Yq5hHBJdhNOtSKH44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cVaW7Klx+WjAT69gPFzIUpdAFmvRcERgDHoqwTdnFpJx6gQIq6UJrlt2GMjSjNxJ07F444+hUWM9Ue2HjAGl5qEF2vRQYcKrk0oKNISvmg5Fwylou9veeptMfBDkuQe7M9aWAqorYvRrjYSyEy6EE5XOXtr8z87f7EkdAVkp3ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVhUR77z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515EF1F00A3A;
	Tue, 26 May 2026 14:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779805310;
	bh=kbqQqH3jgt08e4fDpvPIbosZv3ZKqKJ3DvEKJ5VtQ5E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SVhUR77zomu3YeH5JHxGzSXl9SlI7LdCGr+sFa+4xMIb0WpMfldftvHTQNKZdGhkJ
	 gEYyY09GMiCIqtrg6BOTNKNEZMAzE7sWvao64WZnGF7BNbZj41TBPd7rFvpLmf6K4j
	 +wqm1OwR+6sLweJ2GCuDu+ioEYbVHSbJ8i0BSWW5GRyGQAW6sdvnene/y2RzEsQDoC
	 QHOhYIJvAkZf8e1J/P72tbZFDVvRdWwxZNnAFQEoF4E7K7xsCE0W3jZB9p9JY6DbLu
	 NGc79uori+aliggq/lFYVZWLV8VkJGMgpfgsrmgrSijSAh9Zq2c0J7Ac+HI8LWAdCW
	 dp5EZ722j1OBg==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 26 May 2026 10:21:34 -0400
Subject: [PATCH net-next v11 4/6] tls: Factor tls_strp_msg_consume() from
 tls_strp_msg_done()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-tls-read-sock-v11-4-244fe1dc4abd@oracle.com>
References: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
In-Reply-To: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@suse.de>, Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2083;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=UYhHqnWH9kQZYtWnKB2aE3v0ZLqy4/Gg4/JzoO3PYbI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFax5b/6u8tdZlkQFBwb82YSr2h20UnBTF1uNC
 wa7gXm/OhqJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahWseQAKCRAzarMzb2Z/
 lwAOD/986VK7usNUaGwdsNtojDiKuJE7FBarwGKyl5XllbtNASzuY18K4/Z4WlttNZmtI95WVQZ
 XfoRHKaIMUNyL5Q5bzijWo8rV4eMwvSIY0wJP8qkIs/1Hcbxea95x70wTNpvxnO7cWLRe2fPXa7
 8mivAWNncRdkG+b/MmniinOrHzLVA+YE3WseIIZTezk4jPYWdFg64Q4UbSgPL4NzJ4mxTYlLevN
 VEg4MXlDRx/OF0ptb0X0qe3QDDLHQtyBJhk2BWXDNX18dPz9k0tp8WmKU0gOh1eSPTpzd1lfak+
 U7TWH003U8ZDi9wo9kvLiruN9z88h2/cE8vF3eZzCn3vq/S48iAnpSygy+9pAeTcP5+1hUYqnHz
 2O79n32vJiCxCh4AP06dJLCuIszbe2+vGICaTlXBj3ym4PBQHD1AI57u3vsI/7SaFsROtJWOrUX
 PcKE8pDAObMhIyubqET4x+c+0Ybk6A4x/BWck4kkmkyT4pR1rX4V5fnnR2QXXdmqwD9goKWhOxU
 HmqK0uP0W81XU/c9lZolTOQvEI858mKTSNSc2Cv9hNKSRkWiJisTMpwUs/okPMVw/mrQgxYbFO0
 TIqvhPuONPuSbicCfTSoWaWv6WlcNuEbJtaPg/H2mGBnuy04XfnTmqWDYOjOFpSbAjGNlOpQo1a
 y6YEY50y5lZwiJw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291719-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Queue-Id: 042145D77B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

tls_strp_msg_done() conflates releasing the current record with
checking for the next one via tls_strp_check_rcv(). A subsequent
patch needs to release a record without immediately triggering
that check, so the release step is separated into
tls_strp_msg_consume(). tls_strp_msg_done() is preserved as a
wrapper for existing callers.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls.h      |  1 +
 net/tls/tls_strp.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 12f44cb649c9..cb0091e03f41 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -194,6 +194,7 @@ int tls_strp_init(struct tls_strparser *strp, struct sock *sk);
 void tls_strp_data_ready(struct tls_strparser *strp);
 
 void tls_strp_check_rcv(struct tls_strparser *strp);
+void tls_strp_msg_consume(struct tls_strparser *strp);
 void tls_strp_msg_done(struct tls_strparser *strp);
 
 int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb);
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index c72e88317627..e7aaee6efe6e 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -581,7 +581,12 @@ static void tls_strp_work(struct work_struct *w)
 	release_sock(strp->sk);
 }
 
-void tls_strp_msg_done(struct tls_strparser *strp)
+/* Release the current record without triggering a check for the
+ * next record. Callers must invoke tls_strp_check_rcv() before
+ * releasing the socket lock, or queued data will stall until the
+ * next tls_strp_data_ready() event.
+ */
+void tls_strp_msg_consume(struct tls_strparser *strp)
 {
 	WARN_ON(!strp->stm.full_len);
 
@@ -592,7 +597,11 @@ void tls_strp_msg_done(struct tls_strparser *strp)
 
 	WRITE_ONCE(strp->msg_ready, 0);
 	memset(&strp->stm, 0, sizeof(strp->stm));
+}
 
+void tls_strp_msg_done(struct tls_strparser *strp)
+{
+	tls_strp_msg_consume(strp);
 	tls_strp_check_rcv(strp);
 }
 

-- 
2.54.0


