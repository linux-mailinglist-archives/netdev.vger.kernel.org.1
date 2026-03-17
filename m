Return-Path: <netdev+bounces-268642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJhVIm1vuWm8EgIAu9opvQ
	(envelope-from <netdev+bounces-268642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:12:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 856EF2ACBE4
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F30A93036394
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E453EBF18;
	Tue, 17 Mar 2026 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMAH4Qwv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B423EB7F8;
	Tue, 17 Mar 2026 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759885; cv=none; b=IpSQOIGRsPTP3Qunzr7Br4IlSBcAG4dF1fHtJYZuwLXn3/QxoUS8158c0GmLKc9QqKTz2bfKfyRlu/SVrN09IWHdQ9rzFAnrNFHaWApZqweU+PTb7RnKCDwJdPVvalpeiYe12ZUfulrCHrBnWCHqFoiNA7QoT2MeoYfKUv4Xzok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759885; c=relaxed/simple;
	bh=PmE7X7ZMvhNcOUK1ClqabxBIoW+VUra9idJ8rNF/8m0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nCib/03qa2emaDbfo2omG7cpa40vw7woA2LS2Xv1sso3OGpzGal0Wk8FedOmE23qDuRNPwSCFz6QSRZ/MNuLLwnezXbNxDcc97cqv31UXy6Vf8VC0GOj5FX4FZyZj2xymO9268bMuhqtx3YTknbT3vYJyP9Dhv+kjwcvpuC4fWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMAH4Qwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A9FC4CEF7;
	Tue, 17 Mar 2026 15:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773759885;
	bh=PmE7X7ZMvhNcOUK1ClqabxBIoW+VUra9idJ8rNF/8m0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kMAH4QwvIRANn5L5XnbwVW59MHew8jHlN2VOSkni52A+pFxO07G8uE/o/yGHzN33T
	 e2nxTWyafc6oVlP7SAzbhW05+qUdXyuZxG39KQdNaW+D1oJExjpVSFVEmhThgIEVTJ
	 niMB+jcx5bVHNEil0p4aX0K04TmtQZO2PGPMu9UV33iGJFJzGcThtBwiRm0QV3oQYw
	 f250753iL4pKu+z2Y+tingLhefwWE2dCY2ham43idNBs84BFkOrb6JeYaUHR/xgKi8
	 us1TBlFNiiq9pPE3MU29B3O7+SL2Oo16GSz2D5ZzOV0NBpkJqMg6XsvpX1jIS7zE99
	 uXRh0Z+R5KRqQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 17 Mar 2026 11:04:15 -0400
Subject: [PATCH PATCH net-next v4 2/8] tls: Abort the connection on decrypt
 failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-tls-read-sock-v4-2-ab1086ec600f@oracle.com>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
In-Reply-To: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2020;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=fVlRMAKPLczbtWXEdsiJpWFFePbzGKy5morzl6szdug=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpuW2KIDidnYsnCjRH/QxavJ4NhxGgL+d35oDdP
 YYkRNU3fk2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCabltigAKCRAzarMzb2Z/
 l+Z5D/95sY4xAXRa1NeW42sTBzWNXT4Ko4TkaoUMmpMKsKJV0vBeDzuGRBa6hyZllzTFMGcc8L9
 GI0cikSeB6WmrlWXaxvqgKjJ9LPNruQ+hzcKV2IFjWPg2clotu6MAXHllxbxNpqBcpzyjKnxNxX
 kU4Ba5T8kM/p22QoaxfiH1kXH4iUYBZ9LmMdJQFB42wx5Qo1mVBLGj9vLiNiRGg4kleos9RJ4vu
 JQ4nBigpe47TgwpDkQO0q1OMCUSSPK3E7knbyNuUgHE/UYFzPj/JKb8vHL+KVt+zHoTx8TRhb7f
 +GRitKo++5EHc0U+oVrKYJjR/ZayKL18U5+fM9D5fzVoAWNoJlQn4tO1XS3TgmlYbM9m8uXY4Xo
 NKR53XGKUqdEt6uskf4zVAPNkLdwjLP6/rY71eqMhQll0alMo9QSdlOtYE9oB0Q8Ow0EQzCtHGf
 DKDuUG/4p5sIP0cCHRbCKI4wsAcNk1POa3gjTWFXt5briB+dPKyyiSWyMMWlfPbc3BYgODVlkdA
 xofZTCrJykyk93AzEaPSwVueIAQa2W7I+8HXvXq7ZLuuCkqbh8nGQriFRzJjTU3hod8Ho39mTys
 nVu/d2Ua4G3ed3TaSpqjXrFkqkw0hh2A4s/aOCkwea9Nm77VMSZgP4qvtdc74l4zbjpIGF1hHjy
 KM7w2JvXla/JIxw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268642-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid,suse.de:email,queasysnail.net:email]
X-Rspamd-Queue-Id: 856EF2ACBE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

recvmsg, read_sock, and splice_read each open-code a
tls_err_abort() call after tls_rx_one_record() fails.
Move the abort into tls_rx_one_record() so each receive
path shares a single decrypt-and-abort sequence.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 09ccfe82af1a6c38978327e941de34818b5da7a8..bdbdaf40b3384298c80082c3acabcdb9a2becfc8 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1821,8 +1821,10 @@ static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 	err = tls_decrypt_device(sk, msg, tls_ctx, darg);
 	if (!err)
 		err = tls_decrypt_sw(sk, tls_ctx, msg, darg);
-	if (err < 0)
+	if (err < 0) {
+		tls_err_abort(sk, -EBADMSG);
 		return err;
+	}
 
 	rxm = strp_msg(darg->skb);
 	rxm->offset += prot->prepend_size;
@@ -2133,10 +2135,8 @@ int tls_sw_recvmsg(struct sock *sk,
 			darg.async = false;
 
 		err = tls_rx_one_record(sk, msg, &darg);
-		if (err < 0) {
-			tls_err_abort(sk, -EBADMSG);
+		if (err < 0)
 			goto recv_end;
-		}
 
 		async |= darg.async;
 
@@ -2295,10 +2295,8 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 		memset(&darg.inargs, 0, sizeof(darg.inargs));
 
 		err = tls_rx_one_record(sk, NULL, &darg);
-		if (err < 0) {
-			tls_err_abort(sk, -EBADMSG);
+		if (err < 0)
 			goto splice_read_end;
-		}
 
 		tls_rx_rec_done(ctx);
 		skb = darg.skb;
@@ -2381,10 +2379,8 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 			memset(&darg.inargs, 0, sizeof(darg.inargs));
 
 			err = tls_rx_one_record(sk, NULL, &darg);
-			if (err < 0) {
-				tls_err_abort(sk, -EBADMSG);
+			if (err < 0)
 				goto read_sock_end;
-			}
 
 			released = tls_read_flush_backlog(sk, prot, INT_MAX,
 							  0, decrypted,

-- 
2.53.0


