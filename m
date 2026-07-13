Return-Path: <netdev+bounces-307085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DO+3DsCgVGq9oQMAu9opvQ
	(envelope-from <netdev+bounces-307085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:24:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 949A7748A31
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:24:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="H/D8SZDh";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307085-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307085-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3968C301877E
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C234D3ACA7E;
	Mon, 13 Jul 2026 08:24:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770AD3A9616
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:24:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931066; cv=none; b=uttB4gp98+RcIPGjfLvpnKMH9/uIKe2t08uxq/UoRqQ+UzCgHKHl+1UbJiSnWV77U+6bQLGuUEPVfT3km1VlBJ4pD+D4NNCpuYBOdg0aLlm7LVpyqXBywNeg4lWuShVVy2yA4l+kwHJYHPlYVQfXBtv9gF1v95w39xWPXA29TiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931066; c=relaxed/simple;
	bh=3jbxzDGctzlytA1CUiLHP6fC2hom4m+HeaRRm6vj2/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c1/S12Zgjko6q8zDkyeOM0ePZ+/YrCWPLr0inuaymv9SAF58IEqlU2C5mzIWjL3qHzgqWNbTCbQA+xx2GaxCyVm34Fx9RFGb0CEccARK7ZEzoc9CgK/nx/vnehM7CXttHmFhqe0pKvg43RZQuPN6DYh80WEn7zuREvp+0q1jlNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/D8SZDh; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cace91f112so23983205ad.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 01:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783931065; x=1784535865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f1cbrAJhEgylfzJ7kP8FxcJO9K7Iz36CMw32c3E+ghs=;
        b=H/D8SZDhqt0SXldw8Z3Fk4JR0x5sBb1wo3JSirgNhEJq5A0RcKq5iR5fX/H7KxfKtW
         CIxxpCahlqrq7a6OchG2/sUoG71HzHDnAOWiTGhtBa3Cp5M5Jf6Kc4uKtnVVcNmIYCCz
         ykAnhHKCMEpq6zkDV44JjxfuiffoRLv+HD8uza2DxNDkV4gWOb0YTCw+hgd/Md5LxmE6
         ZO1Rv2xloKlMp7uy+plkernrIc7L7J/crL4e43oNpHUHXxbt3YiZKxDokaDPmfGukkRY
         TEY1QmSYW/yTB/aW2o2yNEGYK8jZC1je8/6g/Nuoiqs6KLEg3z4z5kEEj21cPAp4xGjQ
         ljkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783931065; x=1784535865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f1cbrAJhEgylfzJ7kP8FxcJO9K7Iz36CMw32c3E+ghs=;
        b=aGHld6c7/MWXb5FAssERtT/Ml/yHfowlKDLKQBXrXSCWa/2jDp+ENRb9eyGu7nP1fZ
         /ezBwmIO9FW5abkaoY+rilx3FrJsO9IzPSNQtQxltGHD4yiPynVCHvBU8ZI2WMlOJ2Rh
         +ni8MeQR0qjNpdue+mo96gdwjT5yYIjHt+ZrHdwufb3iqtCDTDigfYnbtIkqP7dldWsm
         QHHx+8ScRbJxQhPdg69vfDo2NJudjL7VxzYgiYMBwqLs7d8eim6LwPMwcNyBeObYX/rn
         kOiHK2HPFUZqTQJ00pQOxtDRgpAuh0fioPj4f6PVx9CLHTVP9dXJKe9N83isk8PocS7I
         4GNA==
X-Gm-Message-State: AOJu0YxBfR+nuw1yR2yDggGsMo4jM/HoE2hj/QZTbDq6w3D23vYJ2cLp
	Krpg4RppwF44XygEGAb4x3fyOp2v3aQdKyJTPKNt4HrRtdlGL+uB/cbXfqBfc/qv
X-Gm-Gg: AfdE7cnzxZGfO86gDhU8C7fBhAuPnO0THmbVN+Fx3Dc0erHXIFNHKSgBwkeWz1zkS4d
	WF+gwH0eRI5MFCmKt5wAnq9iyvxeIvFzC/PfYdLFIHTnI95bRvtzRrCZIDU+PoGFqH85jMzQ0xy
	LCFx5r9jhaQRRtNiqfcsXWOsMyDkQzgg3akfIbZ8n8KNqmewyA3cNdSokKbLtGsKEBtXB2dUXbA
	CUjo0IQ8ZJ12hbLpJh2oRv5/o8uz2Z5dY4OkCxxSBuFCs65nw0D29s97kHamoA07Gg98XmCFU8j
	2d0NMCNrUFuNcIQgCBOGKd+VcqOLWXQGrqNGX6Nva0TDxpVYUlCSoP/Tasa5E288r8lZO5hdiQh
	fEx/0MvicUfNTJDa0md20T6n0PLR/wID2VHUJuDVNWVtDqCNsOtHJwHcC/H0qu9roEXI2/e1r1w
	yzuKOPx9/pXctpHeLBaD9bPEdEixUJaDZUubM=
X-Received: by 2002:a17:903:2309:b0:2ca:329:3da1 with SMTP id d9443c01a7336-2ce9eac0620mr79571995ad.16.1783931064756;
        Mon, 13 Jul 2026 01:24:24 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d451sm95139075ad.65.2026.07.13.01.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:24:23 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] tipc: clear sock->sk on the failed-insert path in tipc_sk_create()
Date: Mon, 13 Jul 2026 17:23:42 +0900
Message-ID: <20260713082342.3803379-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,est.tech,lists.sourceforge.net,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-307085-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:tung.quang.nguyen@est.tech,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:4ncienth@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[4ncienth@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[4ncienth@gmail.com,netdev@vger.kernel.org];
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
X-Rspamd-Queue-Id: 949A7748A31

When tipc_sk_create() fails to insert the new socket (tipc_sk_insert()
returns non-zero), its error path frees the sk with sk_free() but leaves
sock->sk pointing at the freed object:

	if (tipc_sk_insert(tsk)) {
		sk_free(sk);
		pr_warn("Socket create failed; port number exhausted\n");
		return -EINVAL;
	}

This is harmless for plain socket(): the syscall layer clears sock->ops
before releasing, so tipc_release() is never called. It is not harmless
on the accept() path. tipc_accept() creates the pre-allocated child
socket with tipc_sk_create(net, new_sock, 0, kern); on failure it leaves
new_sock->sk dangling and new_sock->ops non-NULL, and do_accept() then
fput()s the new file, so __sock_release() -> tipc_release() runs
lock_sock(new_sock->sk) on the freed sk -- a use-after-free write of the
sk_lock spinlock.

tipc_release() already guards this exact "failed accept() releases a
pre-allocated child" case with "if (sk == NULL) return 0;", but the
guard is bypassed because tipc_sk_create() left sock->sk non-NULL
(dangling) rather than NULL.

Clear sock->sk on the failed-insert path so the existing tipc_release()
NULL check fires and the use-after-free is avoided.

The tipc_sk_insert() failure is reached when the per-netns socket
rhashtable hits its max_size (tsk_rht_params.max_size = 1048576, ~2M
elements) -- i.e. once a netns holds ~2M TIPC sockets every insert
returns -E2BIG.

  BUG: KASAN: slab-use-after-free in lock_sock_nested (net/core/sock.c:3839)
  Write of size 8 at addr ffff8880047cdc38 by task init/1
   lock_sock_nested (net/core/sock.c:3839)
   tipc_release (net/tipc/socket.c:638)
   __sock_release (net/socket.c:710)
   sock_close (net/socket.c:1501)
   __fput (fs/file_table.c:512)
  Allocated by task 1:
   sk_alloc (net/core/sock.c:2308)
   tipc_sk_create (net/tipc/socket.c:487)
   tipc_accept (net/tipc/socket.c:2744)
   do_accept (net/socket.c:2034)
  Freed by task 1:
   __sk_destruct (net/core/sock.c:2391)
   tipc_sk_create (net/tipc/socket.c:504)
   tipc_accept (net/tipc/socket.c:2744)
   do_accept (net/socket.c:2034)

Fixes: 07f6c4bc048a ("tipc: convert tipc reference table to use generic rhashtable")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
v2: replace the raw KASAN backtrace in the commit message with the
    decoded (scripts/decode_stacktrace.sh) file:line form, as requested
    by Tung Quang Nguyen. No code change.

Link to v1: https://lore.kernel.org/netdev/20260710014440.2055584-1-4ncienth@gmail.com/

 net/tipc/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index e564341e0216..55e695748332 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -502,6 +502,7 @@ static int tipc_sk_create(struct net *net, struct socket *sock,
 	tipc_set_sk_state(sk, TIPC_OPEN);
 	if (tipc_sk_insert(tsk)) {
 		sk_free(sk);
+		sock->sk = NULL;
 		pr_warn("Socket create failed; port number exhausted\n");
 		return -EINVAL;
 	}
-- 
2.54.0


