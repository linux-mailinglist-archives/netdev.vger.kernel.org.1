Return-Path: <netdev+bounces-281885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOqPAoK58GkyXwEAu9opvQ
	(envelope-from <netdev+bounces-281885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:43:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EA4486234
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3906A323204E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1B546AF2A;
	Tue, 28 Apr 2026 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6R1lEcL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693946AEFC;
	Tue, 28 Apr 2026 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383072; cv=none; b=c7BWxP/E8sgY1CplV2tGpuCFMJvll57dyBvEP9rjNxK9HczS9J1gBwJieFokOj1TcQmvAg+yM+qrXq21WNbWhKfS3kxFvXwvo9zMDtNMhLdVxGgFe8AuSRQltgOGmE2hfM8BcA989sxvtODdu6BJhYgOXbF78SNzFWUT1hk7ZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383072; c=relaxed/simple;
	bh=kexGPkwBq/MmeW6brrHJUOJsHICwBMZXSkjERL4IfyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nkm7BURHKfpAc6ao7cRmV/G5wRfWR6xky/m4epx+TyycnixShWWBe4naHAT44ZmAA2ss+bEBsR8N+u4PBmi/KMJOkR0FFtp2eiKegbsyS6Of2Amkthp4l/zb0jFBM4/mFRJHM6JIby5YsHcNr7XcwuTWHsa1P09zE3HPY9HHCTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6R1lEcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F7AC2BCB5;
	Tue, 28 Apr 2026 13:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777383072;
	bh=kexGPkwBq/MmeW6brrHJUOJsHICwBMZXSkjERL4IfyQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a6R1lEcL2LFNbQWoLyScajxzl1WPRJ7GmfJGc+6UKL3l8mChnzYpFfBWjDnZRNeyo
	 ZE4uUaRabGLSSzSTf2ih2r16CEKfcr7Vl4vgpqqR7JbzYE8zofO//7QFAztp2GqRmM
	 hktbWkhS/b/hlmcENBA5IDf1AJq61Z30SeqD/BO3tZ37qZp/b2IJQSVzwvF6BIXADP
	 pZ3iUpzFGssoWqij8i0yx80LUIvsGTurelweUW3qEGC2BZuQ94UIUidxB9UwdSOSzI
	 zC6H2d4iO2oGfv+Mz81wbugUHc5EuGg+6rW/Sni9BLVINlO9aHMbSeGXkDW8nTQslg
	 bjK77KhzWI/0Q==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 28 Apr 2026 09:30:50 -0400
Subject: [PATCH net-next v8 5/5] tls: Flush backlog before waiting for a
 new record
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tls-read-sock-v8-5-85f96c7df24c@oracle.com>
References: <20260428-tls-read-sock-v8-0-85f96c7df24c@oracle.com>
In-Reply-To: <20260428-tls-read-sock-v8-0-85f96c7df24c@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1346;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=ezWifH+oKfKGExNghNzuceCnWpXRHJGt1UG1MBt2Ci0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8LabH51pK8HEawoqzDOV6L8Zl9xk/XFsDBOax
 doRrW/WF16JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafC2mwAKCRAzarMzb2Z/
 l1B5D/0eLqXUtI00vyk4Z7V5SzDN7iX89FGBtiEujDOzdz4PnkvEd1H9GyGIilmEDQnnqM/8L24
 /7U5b6z8AqvhDZunqmXndw6GO64mih7nlBFYWammTdQ3aKBy2zHfUNuT1gf6FkpjKN6kVZ0n2sk
 A0ttw3mS9+wWNtOzee0f6bnDQSQMuIHUQ7yUNAWaRKxnxVqJ28kFX3DgeVIko7h+nqdTJz1mqmy
 E4e0LE5K1t5JGFcpjGrnaRqf3cc73eCsV/dW2NERivsexyOOElelgBK5H3IfJFQ8/twjcDgjuZF
 Iq7yzDGFd+EO6F00rZgc9GHee3PHSzfDXzKZaZyFJMFMSj8BHROE5CpqRuhzJkQxjtf2cJLK1JF
 0DW730xt/DgrSuWvdWXtmCkEbpj7sgday+cxMX1cgsF8R1Fs/4Rty/UvsjTAqmS+D9cEdSzaeQp
 MpZMQZTa8Ti3qw60I/ORqv54+ZhTGflorWAgd5b2OzfQqUoa6Y5T3Sjtr5gfqQgzEecPVg1eZN5
 tMQAJBn3V3xZ00icLFx+FYAdco71IRIxrfduqikALM01YtSKD+mgjeZhnNr4rj5lM7j49c6jcZ+
 ccqvKW9qhVm/vDfMz6QbO78upSzwA4IfiAZ3/tL+szTSfWqn0nOo8n7l1Qg7/PIAKIaYnxQ5yCg
 K2Yr0GdaZabi+oA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 54EA4486234
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281885-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email,suse.de:email]

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
segments immediately. On the next loop iteration
tls_read_flush_backlog() may redundantly flush, but this
path is cold and the cost is negligible.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index a16f2954d393..0f365cc944a7 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1382,6 +1382,8 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 		if (ret < 0)
 			return ret;
 
+		if (sk_flush_backlog(sk))
+			released = true;
 		if (!skb_queue_empty(&sk->sk_receive_queue)) {
 			/* Defer notification to the exit point;
 			 * this thread will consume the record

-- 
2.53.0


