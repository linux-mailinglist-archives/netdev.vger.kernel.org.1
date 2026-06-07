Return-Path: <netdev+bounces-296249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hOtyFoyAJWo0IwIAu9opvQ
	(envelope-from <netdev+bounces-296249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 16:30:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ADB650C25
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 16:30:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rikHmvum;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296249-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296249-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89C13300D9D3
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 14:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7B23A3E87;
	Sun,  7 Jun 2026 14:30:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729C425D215
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 14:30:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780842633; cv=none; b=rV3x4hqjzGVLLvt1daACc6qx1q+5Z39qBCt6Xf1jSVqSKlhPJE29A9IDqXIoqtgEqtnjIN6HcWkZ/zmtAPl+Ycnzpm8rRsaSyZ3guP+rg8cejlwSdWryMWEOlp7LXYSjKil00visJpsp73YQxd7s6UvNrQrS1n9ySMm+dK1Fy7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780842633; c=relaxed/simple;
	bh=jhKvuf87blY8UcM6bWSk2/kwYyj366hQ+mQPv4mEaIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N792GxbTG9dZe1dWPR2z7r1pgwfEgC8Kusw5DH9/SXdRXtqzaMaDdaefZ1OWWWhNwG5DvTUa/IYG0PoKt/xPIsjNChVAfJhkr4qatAr6n7EAKa1eBptbZ4REC7Bu8OUzXP3CjPHVSGD2WU4CKt4+URrcSsIhIi73u60BGDICku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rikHmvum; arc=none smtp.client-ip=74.125.82.176
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304cf518c9dso4246008eec.1
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 07:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780842632; x=1781447432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xC257ewUKfDYJVMQsrZJfk16s5TkiUCPUiK/6hLTZKs=;
        b=rikHmvum5Y+4ZSgjcfLqzcYCovQIqvd9WyjbGJmPB40N3AT6JJDKl+siTZP7nIoXGQ
         5bzE2rAxZV6XPbprYhyO4p5xxNdkoCx1uQrjnepDyHCcWDRt+g6H+b7H67ibcNkBKA5f
         /VNxICbf5ZvEzNEmxM47xBMNEzI3wvGKAPt8mYSA8t1DhsHStwEIa3Pi+WjFzUxRI7CK
         jOSBCuFjJf2CY9BgjSx+EHWPB6PioBt/0EYU77HiaPGvH3qlGlZ2FV4RPg9+L8C5DEXM
         fuWGsOZDrul1ipSGY77M0Yj729JbkW4i1z+Ier12OsnvsfBgMtw49xW/J10boe1Dz5xA
         C2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780842632; x=1781447432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xC257ewUKfDYJVMQsrZJfk16s5TkiUCPUiK/6hLTZKs=;
        b=qo0R2qTxeAbfEJQAFhozvtgmVrIMsNT0hyzbBNjY2gn25GFn9ePpFqig9YvpWE/HZ9
         jK22IGdX1lZpf4hxbtd8zILIGz1fu7e9iQZDIkIEeDZMixAXlN99vvbX8K+dD1eXuGBi
         v7hJjnWKKR6sFEAt4wXhT7l0Vgea7ipgGRCZBDTCrCAtKuIWs71GQQ7gtJK1MSxsznWT
         mZXKBhCVbP7QgR7cWRKFJYwdxH+tjHjoaOPZ2JJVtOY+wk/kyWZyrdksNhEF+DoelTx0
         OlKIJ5XGqooEvgWGlFLh4foMNMp2r2gDtXP+4hTLXhtcQ15xEa2Xz9GWLfiSygn+QgRT
         RvKA==
X-Forwarded-Encrypted: i=1; AFNElJ+NI7V3pTIHWtCucrAqNlh96/WMNR9SDvs/xR70jOsDr2Lj3bD73/qwqSctnitplS1qvveavEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJUIjB+DzR022tt6pEGTZP5bcJbtRTb108hW48Wy5DmYBb5p9p
	num0DL7meVugKLmtAyKsCYNOV8UdZaY6pQgH/qgMXZdp63PNtOFhdQui
X-Gm-Gg: Acq92OFKZlAy7ORjsTgO9olOUuXNFqQvNb3iCZ9OofJ7iA0Bd1fIQ3Uk9ozFfENXNyG
	6EFK4lwHejrqbfpT/NKoy40Gc+wyWH4OI8qVvH+N2F5rzWv1zE3DRmb5hBECW/QC4Lbmsxp414/
	+mIxh6Un5JaleHR/CakWYWnVMEDMsY0w+0smvMtaiclwd4WaK6RKMo8UG20wR0r0siRrf/w+KR9
	lh7WkgX+k5ZfEgsammT4c8lGsQ4bxAGilVBJ1IURwT0Z1uYt4V72FcFKlXjlsHfjkQY+EB6ItBX
	sQFD1/yYnCnp15simBFfwj4xOEP2fT4TNgMOEoTd0eQQE+rTulC1erCaZ0tq+p2ba3QiQGHOh0x
	Q1IJbFGzUxJtRInA72tWKds5BNe7BoGHc3m5nOH6lY/uEgjtTFTAMjEMG6e6OoCF8mxVZutvIN3
	IdGj1OFDpx3t6/9APC1bURFIt6vqpDkx/rzSaLf8fD74AE9RC7Xwy4NmeDyQIM0qqILE1lL3buJ
	vYyCds=
X-Received: by 2002:a05:7300:7313:b0:2be:7fc2:fc38 with SMTP id 5a478bee46e88-3077ae89f68mr6415323eec.5.1780842631458;
        Sun, 07 Jun 2026 07:30:31 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db5610esm13877187eec.4.2026.06.07.07.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 07:30:30 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: linux-nfs@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH] SUNRPC: check rpc_sockaddr2uaddr() return value in rpcb_register_inet4/6
Date: Sun,  7 Jun 2026 07:06:46 -0700
Message-ID: <20260607140645.2198574-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,brown.name,redhat.com,talpey.com,vger.kernel.org,gmail.com,asu.edu];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-296249-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9ADB650C25

rpcb_register_inet4() and rpcb_register_inet6() store the result of
rpc_sockaddr2uaddr() into map->r_addr without checking it for NULL.
rpc_sockaddr2uaddr() returns NULL when its final kstrdup() fails, and
the unchecked NULL is then carried into the synchronous RPCBPROC_SET
encode path: rpcb_register_call() -> rpc_call_sync() ->
rpcb_enc_getaddr() -> encode_rpcb_string(), whose first statement is
strlen(string), dereferencing NULL and oopsing the kernel.

The crash reproduces under failslab on v6.12; with KASAN the NULL
dereference surfaces as a fault on the shadow of address zero:

 Oops: general protection fault, probably for non-canonical address
       0xdffffc0000000000 [#1] PREEMPT SMP KASAN
 RIP: 0010:strlen (lib/string.c:409)
 Call Trace:
  encode_rpcb_string (net/sunrpc/rpcb_clnt.c:890)
  rpcb_enc_getaddr (net/sunrpc/rpcb_clnt.c:910)
  rpcauth_wrap_req_encode (net/sunrpc/auth.c:745)
  call_encode (net/sunrpc/clnt.c:1966)
  __rpc_execute (net/sunrpc/sched.c:952)
  rpc_run_task (net/sunrpc/clnt.c:1243)
  rpc_call_sync (net/sunrpc/clnt.c:1272)
  rpcb_v4_register (net/sunrpc/rpcb_clnt.c:500)
  svc_generic_rpcbind_set
  nfsd_rpcbind_set
  svc_register
  svc_setup_socket
  svc_addsock
  write_ports
  nfsctl_transaction_write
  vfs_write

The crash is reachable when an in-kernel RPC service (nfsd, lockd,
nfs-callback) registers with the local rpcbind under enough memory
pressure for the small GFP_KERNEL kstrdup() in rpc_sockaddr2uaddr() to
fail. The asynchronous getport path already handles this exact failure
mode by returning -ENOMEM; only the two register helpers omit the check.

Mirror that handling: bail out with -ENOMEM when rpc_sockaddr2uaddr()
returns NULL, before the address is fed into the encoder.

Fixes: d77385f23830 ("SUNRPC: Fix rpc_sockaddr2uaddr")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/sunrpc/rpcb_clnt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index 6aa372188c86..4c0b7fefee4e 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -490,6 +490,8 @@ static int rpcb_register_inet4(struct sunrpc_net *sn,
 	int result;
 
 	map->r_addr = rpc_sockaddr2uaddr(sap, GFP_KERNEL);
+	if (!map->r_addr)
+		return -ENOMEM;
 
 	msg->rpc_proc = &rpcb_procedures4[RPCBPROC_UNSET];
 	if (port != 0) {
@@ -516,6 +518,8 @@ static int rpcb_register_inet6(struct sunrpc_net *sn,
 	int result;
 
 	map->r_addr = rpc_sockaddr2uaddr(sap, GFP_KERNEL);
+	if (!map->r_addr)
+		return -ENOMEM;
 
 	msg->rpc_proc = &rpcb_procedures4[RPCBPROC_UNSET];
 	if (port != 0) {
-- 
2.43.0


