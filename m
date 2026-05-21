Return-Path: <netdev+bounces-290508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNdKOAEqD2paHQYAu9opvQ
	(envelope-from <netdev+bounces-290508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:51:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 681FC5A8A86
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 054C031B7B4D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DFC371CFF;
	Thu, 21 May 2026 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSh9zcW8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F5370D7B;
	Thu, 21 May 2026 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374844; cv=none; b=ai2+fDTN5Lg2oX/eDw433VwCzcrfCoefGgHhcRr0xxdFqH/wW0uzUKNCOiS5pvIblPQOoFGgWV606lS/RheqAulRB668MvPKc1FgivHjxOspcxJb8Z1tnlNWfl1WPgXb95q9Q30osnBOXt46dWh33mz4MqNOA77BR3Ri5tfqmV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374844; c=relaxed/simple;
	bh=Ff0e/z0qKKOTRiq6UxwiAlSeRmma9nWpEVF4Jg6byZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfkCANWdLwrARfCCHTn8QpDaXcAU3X0fqOmMbGKZLG5+iX3hi8gwGtqfol2unEI6Fyh1r4jY+cze1P8kCLV/uM0t5qYgoKD3fnfil58buFfST01IXrsgVaoAtxz8rH4FHrhA7NuJW55aDaeIzjd8Q0MhPbB1Kid4bsLEJNnt5nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSh9zcW8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656DA1F00A3C;
	Thu, 21 May 2026 14:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374843;
	bh=jcBSvMmhKqByd6rTFVbp4/utBAQpEX6HqXoqYICylh0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gSh9zcW8UGwQMveO3icAHjKwXSagr+BDJnmYzpfV1y/Zswq73CicRXMEklnxcLo1i
	 1YXp8MvL2AvNM8UhhNermb6U4HO+Xl23Vko6IuiBXm1YeQllLFUmpPtQn0KAsiYBtx
	 llaO3LrWxBUIHGwLEfKAvUP992T0bezTesad0UeUZTsgdnS/KvSUXIR0jk1M5V8RII
	 3hqlyu/qlPuwt5qVqOjTPh4kkdp6sl+17v1Jcr6pbzFeMEwkiKUdOGfW9LIgCRhyP/
	 vUxvl8rwJECHmntuOcfKj+ackSKih6fWgk0utMWo+TY3SVgROBr85h2koG0bfZfhrk
	 AfDDf9C7pINzg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 21 May 2026 10:47:08 -0400
Subject: [PATCH net v2 2/7] nvme-tcp: store negative errno in
 queue->tls_err
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-handshake-file-pin-v2-2-b9dadc472840@oracle.com>
References: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
In-Reply-To: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
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
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqDxr360IXtq7cac2x/J3JoHCrUKmoh3409kCvC
 tFwgrfzX4GJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCag8a9wAKCRAzarMzb2Z/
 l3KRD/sHIs5nYdl9+HMxJ6EX98DJuFt5lj4BwZEunvJeR7vo5faZue6oCHMLwHZqbbrhwBqWQjg
 54GrUkgPs1n/TGNnX4a6VgPus+vOYYiW2tzy9cM1u39N3K5MrNbqwTuMFNYg8NNjhNeTOBUxSTd
 FmTC1m6eoou/12dBMseJJd4k84BF70Wp7Wuj3IDotMExbRG2c40STqoaok51mcZhOxIcc/iDS6P
 Ye7re7jOidPkyyw130DalpSN7qIXXhA1uo3hAdTeIDtUxnFzdJejCuLt3qzJVVOW1vAETDTlljx
 nnDeLOokWI9pq96WurukS7h+pLMyqPAC1XC6Prbixdqr3LPVD4IHxJVP0BQ/h0H25tGrq96KR0V
 pCkN/R+whpgT9wsphhxohtr9hzhOKQpjEsQOxhC4aXkogFJg0fFri146EU0lMOpBuwkr3wilAZE
 ZCBZSefLlPMSEg/O25ckIstnSiqY6Vhd7RQ7now0cEcaoM1iRNr+heABbBnxduGtghDmWGa9gVG
 IFvASG+x/EMqunDr0xH9Mo12OgC9A4jUmLSRhr6vfwgxM5Fm6Oxzl/UrvbEuM16Fpwh9sz3ptdf
 dybHoOvD4CfaGa4gbthtm9UEbbrDQYCZgIoGupep6wXVBIOUwfnWm3QIUm4E6CqaExJ3Km62yk2
 ///UGrnkuNxHWbw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290508-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 681FC5A8A86
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


