Return-Path: <netdev+bounces-282531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN/3NZGG8mkcsQEAu9opvQ
	(envelope-from <netdev+bounces-282531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:30:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CDF49B0CF
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FAC830185CE
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F0D44CACA;
	Wed, 29 Apr 2026 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcAnItEy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D54344BCB0;
	Wed, 29 Apr 2026 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777501807; cv=none; b=LvFQn8TYlYSZah0caETltJLbSSQXWO87uI3ZO5eiRmoeaLiIz93z/FxMPQdWQaiH/QtWzK7zP/yZcaNbo3/US4u5PJwmsW/VN9tWt4inmw04ATyuL542cB32rwFn0o/0kxIMiLDfKEw4K436hhaP3G2yoiSXOxt/Xt2lO0NCtuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777501807; c=relaxed/simple;
	bh=iVcfrFHyVFACKF5GUNHFqaW6IcL9IiKuD0iIuXq+xLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8aBPR0FYpx5C1G+OzeKFBE9+MLElPmvOtG/1ZAjwksbuEgaVRtjEKWZToD23pc8WKRSAmxvT7WGSpDM0MegATPj50+Qi/LAV+0+aCvAEo+IKmMZMtXxbUsRxqAXLqxOVRI2tlfd0K1GZLqcih+qM7WHDITgEvhDj91ldcs7CXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcAnItEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E948C2BCB4;
	Wed, 29 Apr 2026 22:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777501806;
	bh=iVcfrFHyVFACKF5GUNHFqaW6IcL9IiKuD0iIuXq+xLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FcAnItEyn/KmqHPYRrEZL22rO1Lrv3CvmMve22n3LdZ3vF6nLxCmCSAmFr74JB42v
	 aLNAXaYNrqg8/zhYnwpzQGgYyB8UmzyCS8qhV5CjVWq3Xz10CTM8WptW0OVGMCZSDC
	 7hWS4TE5XbKZjda5wbCe74mpku7u3DURaFv3dj5L7SnjJX2au9BCus0mSTtCG8OpB3
	 rEb3Je76U+4vRekU3x3CurDVmDsdYyFQMlqqRiWffmsEcd/GPdE8qpEIay4NKWOxFh
	 zuB3deizKCzGtZU/rc0MIu3zZkToNW6i6KczqZMqmq22BACsvcF1JX9RJKeRldLOn2
	 BBYCbG0EaV52A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Alessandro G <ale.grpp@gmail.com>,
	jiayuan.chen@linux.dev,
	ast@kernel.org
Subject: [PATCH net 6/7] net: tls: fix use-after-free in tls_sw_sendmsg_locked after bpf verdict
Date: Wed, 29 Apr 2026 15:29:43 -0700
Message-ID: <20260429222944.2139041-7-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429222944.2139041-1-kuba@kernel.org>
References: <20260429222944.2139041-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C6CDF49B0CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,queasysnail.net,linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-282531-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]

After bpf_exec_tx_verdict() returns in the zerocopy path, the local
msg_pl/msg_en pointers may be stale. If a BPF program set apply_bytes
such that tls_push_record() splits the open record via
tls_split_open_record(), ctx->open_rec is replaced with the split
remainder while the original record is pushed to the tx_list and may
be freed by tls_tx_records(). The caller's cached msg_pl/msg_en still
reference the old (now-freed) record.

This is triggered when bpf_exec_tx_verdict() returns -ENOSPC (BPF set
cork_bytes > remaining data) after an internal record split: the code
dereferences msg_pl->cork_bytes on the freed record, causing a UAF.

Reported-by: Alessandro G <ale.grpp@gmail.com>
Fixes: 54a3ecaeeeae ("bpf: fix ktls panic with sockmap")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: john.fastabend@gmail.com
CC: sd@queasysnail.net
CC: jiayuan.chen@linux.dev
CC: ast@kernel.org
CC: bpf@vger.kernel.org
---
 net/tls/tls_sw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 600e13effaab..d086b43fc675 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1157,6 +1157,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 				else if (ret == -ENOMEM)
 					goto wait_for_memory;
 				else if (ctx->open_rec && ret == -ENOSPC) {
+					/* bpf_exec_tx_verdict() may have
+					 * called tls_split_open_record(),
+					 * freeing the old record. Re-fetch.
+					 */
+					rec = ctx->open_rec;
+					msg_pl = &rec->msg_plaintext;
+					msg_en = &rec->msg_encrypted;
 					if (msg_pl->cork_bytes) {
 						ret = 0;
 						goto send_end;
-- 
2.54.0


