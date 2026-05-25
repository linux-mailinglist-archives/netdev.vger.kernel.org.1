Return-Path: <netdev+bounces-291378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKgUHV1+FGowNwcAu9opvQ
	(envelope-from <netdev+bounces-291378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:52:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C97DB5CD11C
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 727553022954
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027153F6C27;
	Mon, 25 May 2026 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvbozGS8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03BD357A40;
	Mon, 25 May 2026 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727894; cv=none; b=Z8kCm7/i4cw9TYMI+2anX8QPeF7oRhyb0xi0NLhG+KKbgvS+5n6HPzm6OzlVv7dYG+85yIII86cwPnX6CNpcnQLTnuLOQjRz+f/hPwWBECRzyrd1G3t3G1KsBXliagsGmrV7S6bILK/2G55gkVx6N4iLLKahRwYLtmdq57Zx+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727894; c=relaxed/simple;
	bh=Ff0e/z0qKKOTRiq6UxwiAlSeRmma9nWpEVF4Jg6byZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u0p+MJJmb2tACA/V+K6IoiFeK8F3bJkoIiOUvkyP/88S2Eod19RQx87b7oXne5FIP/qurhdd31SNr/r8yYuYmOHQhtHghX0v8pZgP8tXEdyDuJjlGKxshx24QON/IQvSNICndqv0QADWqQMzZ1qT0hLlVIKtCeyJK7rGawoj/eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvbozGS8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDC41F00A3F;
	Mon, 25 May 2026 16:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779727893;
	bh=jcBSvMmhKqByd6rTFVbp4/utBAQpEX6HqXoqYICylh0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jvbozGS8zgDBIg7osI8+lmNpuX+nbgvwY1oAWcAfZWRsh8SVrkJV7TeXi2orGctt/
	 RsN2jx/9bqbShakdnTq6xGjn7swGHF9zR178W62bBYCXVI/+lyESGUSTsmoqoEakqW
	 Z+aa07ybhVILjdR/CH5plL2csgZAPtCo4B5NJv6VmmQNRHuhCfAbVA9CbSJStJ0+kR
	 xuUG5UFShOVu8hnLOZWjMdpMKdMecvCvVLZbj5e2lkABQwvMkjFVYgBY01HUjuv3qr
	 S7cCc+cYW+k+URQmbIpts0xcFMxe5ga4N417eTCuRhiNZ0u8DDXmES5ljBZQTlEzyO
	 E3dMkQYVq5FxA==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 25 May 2026 12:51:16 -0400
Subject: [PATCH net v3 2/8] nvme-tcp: store negative errno in
 queue->tls_err
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-handshake-file-pin-v3-2-66c616906ead@oracle.com>
References: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
In-Reply-To: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@kernel.org>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=JOW7aetVzePh6U/0P0auy5nRsOk/ShMS6Cie+5IgQes=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFH4R31Zg1ZZiLqNT/ykU5FL8tjtqZlsM4VzVu
 SsrO5fSBsmJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahR+EQAKCRAzarMzb2Z/
 lw4dD/9Bob7tKowIuYlyBVNUc6l/eLzx/tR+hC40bzWolgYfVBO4MEXMJP+/s8YdGV8w1bEseCy
 x3FtiHKo3vJEhKXI47UGW0VhTIbaY5FuPsrpNC2OMYtlrRKQM5S4hM7IK0sdlXM620mTUQJ5f4b
 fe5t4TCieypkudUQOqTrewueAoZf/8Od1g4e+WRQFMeJciaz7fgJTCLEhmnSQz0SSj+3PlmDzvw
 cmMracaH8Ks0jtpaUx1yjBWdUgwOyE0VJM/SzVo5ACRkcTFSC3Iqzj4h4/svFeX3UMYoCIJQ5JZ
 U8juJTAJ3hJQ+uBGt2gHLR0Rf91dPJAhXtOQYVoSR20yKBtMLY4UHek3x3oVV9XNMiReaqbNkdQ
 jqE7SSEoO/1tuk5AZelcRzd3fWPZGfsEXmVtI3JKquO9I51FWscANBK2a41EMzc+Kzn//vd4ptb
 Ck+9in5V+BAvF9M6/rXQISJAx0PYjAv7smNlAOxGQJaLpnDq3FE69SQHCcESfC4nQPhgcj0EMtR
 7y/0mJgqsAw3Ss98av9eNWLQOYNciwHpnNoGmeULrI+/SuWTWAgiY8c8pvt0CeRyXSk7tjReBF+
 csqyyrABTJEXvD+zuSx1jWZ/JLZIs/z75kI4L/NZEPOK4FLvNgadreN0muPETzpNG8amw7oMF6e
 vxYUDWUNsjCh7ww==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291378-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: C97DB5CD11C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

nvme_tcp_tls_done() assigns queue->tls_err in three branches.  The
ENOKEY lookup failure and the EOPNOTSUPP initializer both store
negative errnos.  The third branch, reached when the handshake
layer reports a non-zero status, stores -status.

The handshake layer delivers status to the consumer callback as a
negative errno; the other in-tree consumers --
xs_tls_handshake_done() and the nvmet target callback -- treat
their status argument that way.  The extra negation in
nvme_tcp_tls_done() flips the sign, leaving tls_err as a positive
value (for instance, +EIO), which nvme_tcp_start_tls() then
returns to its caller.

Drop the extra negation so queue->tls_err uniformly carries a
negative errno on failure.

Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 15d36d6a728e..68a1d7640494 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1702,7 +1702,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
 		qid, pskid, status);
 
 	if (status) {
-		queue->tls_err = -status;
+		queue->tls_err = status;
 		goto out_complete;
 	}
 

-- 
2.54.0


