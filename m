Return-Path: <netdev+bounces-273333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPatOM3xymkkBQYAu9opvQ
	(envelope-from <netdev+bounces-273333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:57:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DC6361A8D
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 924BB300E1A6
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76D93A75AE;
	Mon, 30 Mar 2026 21:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXT5AaNP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99C13A7F6F
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 21:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907836; cv=none; b=D8sNgWFd/dmWwWC+1Mi3DAFn315/sFRcUf1qwmuB3/YuA+KOz6/izlCg8yxKA666g4RSQJYAuyAzvWgB2DNsfoj/Ctc10VPFSK3z//KDUBydAPyByUOv6ZtYv6WV/k4GnE/53FsxUY3cmhFFuYEU4JRWlrd/+srhg2Vxyydcgn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907836; c=relaxed/simple;
	bh=cj3zNWgdYDcRxz1oligwgpnRSh482psQj978G9+dUyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e14KWIEbIx9NMcYkwiWttnToZxslsroypeyrVsqiuxTp8h5CWP0lIpEhsZmHCC1nkCF3YbGH9160+wX55DxS0gE8bput8ikFGI0Cke5KPgxaw688rUTFNT7LK58OneAaRBQn8ok9t+0ZAmPVkVyExsYK/d5s2uozcu9SyPTN33k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aXT5AaNP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2523e0299so48816755ad.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774907833; x=1775512633; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gl/sKXd+rVvwtX4lspRuwpIWSFPNegapjZdLWrBkKwk=;
        b=aXT5AaNP7PWnwgOWanQq5fX25aALBAXrc7l/nTTIyvat4BxYxREaDt0IHtR9SH4hS4
         HnJStd7g6h6o5nHjMG4bVF77MzRvAlTkaE0d0X94oinzmdhp5OW8tWBxb9wwDnLUymgt
         KTxJmAOVsEjmNUJ6BFN5bRx9gXMq/Jl+Qe6c/R/dM6sbGWzPTIg0voyOOv6gjD5XzmFQ
         sEE+gddS7v4cxXzczl6zDeaIejdviFljFz4EXhm6Fn6NuvQaj9ayinc0PBHbWJeXY70E
         s3nZrkSO+MhkKm/Cb5t+khZ+SaYLIRNh4DWMWTK8d0Pp7EvMBxiEe1urapwdx+pH4Dz0
         EpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907833; x=1775512633;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gl/sKXd+rVvwtX4lspRuwpIWSFPNegapjZdLWrBkKwk=;
        b=b6dgcqip1A56Upc4uFOAnjik61ivnN+y7y8D3b967Zai4KBiHuhkN0vKUiwy0GwIAk
         Jq80DOeSDaI5CcvRhoKxYMKjXsBmhbqYzb124yOxjXs5wMZgsUNPSdpdjjuKTDAn7f0r
         RNTMC+Jh4SZ40H8VU5ajw/VjHEOaMgCdiVtajjxxJjvvf9eVxoov/kZXDXy/gTFcf2sK
         /hFqieZ8kh0d1ScgBM2Cvyh7gGdbaW2dKT/G4NO3Jlq1oogvys4YiFOxt5wGszxfdvdQ
         EEPWyUVLqS/oKsMQxvgsRL9uUk5ilGoljIIA3oZVl7/QTLlMwCpE85Uwr3RcjB/jdavf
         U8Xw==
X-Gm-Message-State: AOJu0YxvEWUfCs8KnYuzsZAjxHcFMNOqRkSd+mFNeVewR8mKmTVaNFDb
	YKSUcqCSdy53Q1RW9PwObsVynsVAXWP6kSbHUXGBUAwkKzL1wWTXllLtXdazTgAUAlEh6xsgGrv
	sSg6qxWbEsmyZWmRffuM81ibrvVDibaVTKa6g3dRNvS09+gU6/ymEvTMzV/FMyiICtShUwzukNg
	wj05hrjs9NDs+y3JzLchvXuTtSyub0mk0=
X-Received: from plbbi11.prod.google.com ([2002:a17:902:bf0b:b0:2b0:663c:53a9])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46c7:b0:2b2:5503:1b8d
 with SMTP id d9443c01a7336-2b255032776mr45644885ad.6.1774907832572; Mon, 30
 Mar 2026 14:57:12 -0700 (PDT)
Date: Mon, 30 Mar 2026 21:57:02 +0000
In-Reply-To: <20260330215707.2374657-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260330215707.2374657-1-jrife@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260330215707.2374657-3-jrife@google.com>
Subject: [PATCH net-next v3 2/4] udp: Remove disconnected sockets from the
 4-tuple hash
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, bpf@vger.kernel.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Yusuke Suzuki <yusuke.suzuki@isovalent.com>, Jakub Kicinski <kuba@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273333-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jrife@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me,kernel.org,isovalent.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2DC6361A8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, previously connected sockets stay in the 4-tuple hash after
__udp_disconnect if the socket was bound to a specific port or port:addr
pair. This is benign if inet_daddr/inet_dport are cleared as well, since
lookups matching the old 4-tuple will not find this socket in the hash.
To maintain the same behavior as before if inet_daddr/inet_dport are not
cleared in __udp_disconnect, always remove a socket from the hash on
disconnect or abort to prevent a lookup for the original 4-tuple from
finding the socket.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 net/ipv4/udp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index d91c587c3657..6e5ba2ce9314 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2235,10 +2235,20 @@ int __udp_disconnect(struct sock *sk, int flags)
 }
 EXPORT_SYMBOL(__udp_disconnect);
 
+static int udp_disconnect_unhash4(struct sock *sk, int flags)
+{
+	struct udp_table *udptable = udp_get_table_prot(sk);
+
+	udp_unhash4(udptable, sk);
+	__udp_disconnect(sk, flags);
+
+	return 0;
+}
+
 int udp_disconnect(struct sock *sk, int flags)
 {
 	lock_sock(sk);
-	__udp_disconnect(sk, flags);
+	udp_disconnect_unhash4(sk, flags);
 	release_sock(sk);
 	return 0;
 }
@@ -3254,7 +3264,7 @@ int udp_abort(struct sock *sk, int err)
 
 	sk->sk_err = err;
 	sk_error_report(sk);
-	__udp_disconnect(sk, 0);
+	udp_disconnect_unhash4(sk, 0);
 
 out:
 	if (!has_current_bpf_ctx())
-- 
2.53.0.1118.gaef5881109-goog


