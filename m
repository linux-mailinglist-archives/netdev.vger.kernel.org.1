Return-Path: <netdev+bounces-271061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNZtLTKMwml9ewQAu9opvQ
	(envelope-from <netdev+bounces-271061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:05:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A0E308E48
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2890D305509C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D7B3FA5ED;
	Tue, 24 Mar 2026 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlj9+vxT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C913FA5DF;
	Tue, 24 Mar 2026 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356845; cv=none; b=jhgmLrDiDNhGrIkTTLe+esAIlr8CZVt6zkUkiiguRWeeqjoJYtNHsDx1yuqZfpcYV7lVLM95f+UoujJJlRgs6TUCVDgOv+ErmPTP6mf6aJvNEhOwAgs+kyKggwandsodOGQ1A6KGT6UhHGLfJLAuM8cIWbA3xuFCneJOpZmEsBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356845; c=relaxed/simple;
	bh=1VJEnpw2CrDV2ySqSsp5pd8INZnr9epy9e6tlLxTpM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GEOlyEW45+kh8CHyJ0l1vHpbKmf27IDposWxkvqmgmGRG8qCOl3dv2zHlG7Zh+ibsox4FlWa3W2gTuZInuT5qlAO/THtqkQUAjAS/6B42J4e+OYgrY/eRdb4umG4aVHrChZ2N8Lf825wYzn6nwy4VSPOasoLg04I3LFDgtEMD8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlj9+vxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74231C19424;
	Tue, 24 Mar 2026 12:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774356845;
	bh=1VJEnpw2CrDV2ySqSsp5pd8INZnr9epy9e6tlLxTpM4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tlj9+vxThPyvTzUEjL1L6UEDSlCrK+ewqvhGzfm20vkS5/ROTJUwNzpv0M3xhoaRI
	 8zbHXoyCBN1+Ypoqx0DG+ZOXlx8mOE+gOOi71Mua3mHV0rk+9YH2voM9Tpa0yAWLjI
	 wqcQ7N8807qpjEnsyXJlnJ9pcFWK4kdW7G0dVNMPub9/+UMOtZ6K/ypbzMIG6aZ019
	 Y9xY3qjdhsa3ceWmYS45aL8hoaJL6NbBjTv9Algj4n2hU1w1FPBWs1BvrJ6uc3W7TP
	 hmAu3rcea8/s5OLyKVRutdiLQQze37xQC3J0F06X8+aUZO7Csm2rJjuuRppNqd4Eeg
	 dj0/EUagA6DCA==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 24 Mar 2026 08:53:28 -0400
Subject: [PATCH net-next v5 6/6] tls: Flush backlog before waiting for a
 new record
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-tls-read-sock-v5-6-5408befe5774@oracle.com>
References: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
In-Reply-To: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1271;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Q9HeG6URrjYSsIA7gBIoeZ9jxTU+oAcN7zrguFtCKMY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpwolncd9Ql45GkPVNCsC1WdiPes1WgnQpkQlAG
 sJc9TZTcp2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacKJZwAKCRAzarMzb2Z/
 lxtQEACdEyduQFbBz3pbOSbYTM6tZ2oXJZzbgjnTGEblywOulIt7Ha+sKxNOmeeWSyuVZrRwNd9
 i4W/XiUBugLSjuFBfXG7LV5dgTf2Eo5g2J4prUvAueF5j7GJ5Noee4fc1+s+o4SSLySMg2YGwhi
 eTxuNqFzAzcUqW8CnAz2ablzQp/9E3QqFmOkgdZ/2Y40UcgWrOoQv0m4lN3ZuqlD8nlSrHHMzc5
 APM2Blq/gkp311bJJIrWT9F/W84wus+ZfNYAIa9Q/FeWYGOtZL5+rR2zvnKSp8JK7OC4Rv9AO+3
 DZ1f761W2htzgBuuvn3WEyj3o96vdKwvc7p5FFS7KPZrTMlPkQS1Kq3gbt/IS2txNFREqS5UkR0
 mH7oW/NpcQUQauzzISzEed8l0aV3Z8CjzFf2yaeZN5WxpYyIXSM/rKtTpWiScGjaVqv2PlGcmZl
 WRFqG8F0+fcX/fo0y0DDmd3QcyzGoNr1EpMXkV67ZqxT2s2hqG3y9wOC285yEQBuZpDEPSrVyML
 oMGgwWdyy+XzvyXv3zqaO6LkUoujHAd3MqPw2Gl9dJmHuUvIjxqH1+SzJcVYY1D4netXT8KC6R8
 YSzTDdzNY/tKVmUSwBgCy5/w3+1Vfn30fiFjg7QlhIU313VzHiowJDNgy5kWFuJPUZE5ZFh6Vg4
 /VPA1PGfOwdWvTQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271061-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid,queasysnail.net:email]
X-Rspamd-Queue-Id: 58A0E308E48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

While lock_sock is held, incoming TCP segments land on
sk->sk_backlog rather than sk->sk_receive_queue.
tls_rx_rec_wait() inspects only sk_receive_queue, so
backlog data remains invisible. For non-blocking callers
(read_sock, and recvmsg or splice_read with MSG_DONTWAIT)
this causes a spurious -EAGAIN. For blocking callers it
forces an unnecessary sleep/wakeup cycle.

Flush the backlog inside tls_rx_rec_wait() before checking
sk_receive_queue so the strparser can parse newly-arrived
segments immediately.

Fixes: 20ffc7adf53a ("net/tls: missing received data after fast remote close")
Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 8fb2f2a93846..84c4ae0330d1 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1372,6 +1372,7 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 		if (ret < 0)
 			return ret;
 
+		sk_flush_backlog(sk);
 		if (!skb_queue_empty(&sk->sk_receive_queue)) {
 			/* Defer notification to the exit point;
 			 * this thread will consume the record

-- 
2.53.0


