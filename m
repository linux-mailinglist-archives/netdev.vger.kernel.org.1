Return-Path: <netdev+bounces-264550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG6KH0/yqWnhIQEAu9opvQ
	(envelope-from <netdev+bounces-264550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:14:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E4921871E
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1F083056642
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 21:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3C935836A;
	Thu,  5 Mar 2026 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKYdhkyj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BCB358362;
	Thu,  5 Mar 2026 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772745249; cv=none; b=MPLMpImzLX4IyxQ4RTBXQ9i3qN2jeGcEl5sQZ0x86lPPqR7uDxpmpJn5W1/U3ihraHrAPUcmH6iJWDQEt2RxPPp6/2PYqN/+spDboMfyNudn1X+oFIXLtkD5FAq0dpuLv18vfjLtrIIYmh2KAgpHp+SmrOJVtdCV0frnQ7VjxXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772745249; c=relaxed/simple;
	bh=AEqZRWUEMiRAVhvf5ZldobDkrEWBN2tQKdf5Mha0Cjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwS0TnHk9GJFxAEsT7N6DsBb8hb4n9tTZdvpfY0xiIpze7wL7tSN5PJ+xas/ezULSrjjaMLqY0olKcP/7ok8Ntc1rIaihNA/vcH6OGPfR05rIXWHhReaob9V9luXi/9gZgjp+mMN1oRvsoJBEZsBuwmuiMDdqOM3D0iUl7dHAR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKYdhkyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD2AC19422;
	Thu,  5 Mar 2026 21:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772745249;
	bh=AEqZRWUEMiRAVhvf5ZldobDkrEWBN2tQKdf5Mha0Cjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bKYdhkyjZe5XASUmgPt9hvhyaO9g8D/FT4QczICsV0jh+zu9ZymLoF/roK5OqC0au
	 BYmauzd9xJ+FSx5g04hv2fQfxqB/CyOyKzYg3zxCZ6hwafQ+hVWRR0If6isOP0bRJF
	 j5wvkzPV3VEmg6QlvByjfdpDte51tXgP03CooqBnNdG2uc6p4zwYaC7UYcNCWxigH4
	 ScOXd81u/vwLTcyO62L6NgNZmeBvsJEsc/xJ7/dnMmMTy8LQxgwpR75fQ8VKtK4NsP
	 kbpcl0Dzu6darbAFWe6MCmgkM1/d+4lTdFJxchkAii89B3pvnql2cQRXaMZSzYwAv1
	 z+oehn5kXmcdQ==
From: Chuck Lever <cel@kernel.org>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net
Cc: <netdev@vger.kernel.org>,
	<kernel-tls-handshake@lists.linux.dev>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v1 4/6] tls: Flush backlog before tls_rx_rec_wait in read_sock
Date: Thu,  5 Mar 2026 16:14:00 -0500
Message-ID: <20260305211402.39408-5-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305211402.39408-1-cel@kernel.org>
References: <20260305211402.39408-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E9E4921871E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264550-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

While lock_sock is held during read_sock, incoming TCP segments
land on sk->sk_backlog rather than sk->sk_receive_queue.
tls_rx_rec_wait() inspects only sk_receive_queue, so backlog
data remains invisible until release_sock() drains it, forcing
an extra workqueue cycle for records that arrive during
decryption.

Calling sk_flush_backlog() before tls_rx_rec_wait() moves
backlog data into sk_receive_queue, where tls_strp_check_rcv()
can parse it immediately. The existing tls_read_flush_backlog
call after decryption is retained for TCP window management.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index a5905f4c1ae2..70a9c2402ea1 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2371,6 +2371,11 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		} else {
 			struct tls_decrypt_arg darg;
 
+			/* Drain backlog so segments that arrived while the
+			 * lock was held appear on sk_receive_queue before
+			 * tls_rx_rec_wait waits for a new record.
+			 */
+			sk_flush_backlog(sk);
 			err = tls_rx_rec_wait(sk, NULL, true, released);
 			if (err <= 0)
 				goto read_sock_end;
-- 
2.53.0


