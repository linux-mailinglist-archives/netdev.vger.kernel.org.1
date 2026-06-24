Return-Path: <netdev+bounces-301568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b6zrIW2YO2qXaAgAu9opvQ
	(envelope-from <netdev+bounces-301568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:42:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C526BCA1E
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:42:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Xu8BNEiE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301568-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301568-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE783301D972
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 08:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0599739B4A1;
	Wed, 24 Jun 2026 08:42:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A71392C2E
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 08:42:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290533; cv=none; b=QHdF50itfU3AG8W0vc9wtz8vgWIs6Q3/iwwRDtKuSq7gP/9Zz9B2itQjQLwueZf96UeXKi9DUJ/jThqc2oqJddouzyoyxsQOaeG0rzSdp+kx5yN39OKKl8MkxPgC7yNwBvrlq4u/eoa36Ki8vvYlTFA28TQVMHr5k6Ll823t9eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290533; c=relaxed/simple;
	bh=HNZpg/xHJqTSWZQlg89/3FcDfzRQN09lT4Z4fHDr8Fw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WqE4G1smCuVbuBesRBPyjXWhbAYPnkWYKTm4xbuHV5PWFe5e3qNux+COJJpKdR16kJuMc1YHxVeQK2EIlXXPT1gMuePd+LhE+4u3dWoG4wBWnoC5uErDTdmq2BfSz9MZSWF2J0BfEoQUw2Ko9nxQXhnMF6eZDKoQFxjqN1Pils4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--clecigne.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xu8BNEiE; arc=none smtp.client-ip=209.85.208.74
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-69557a7f1a5so579123a12.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 01:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782290527; x=1782895327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9DLExDC59vueux7nw5wKkiU+KpHE7tOm4pNwHPghH8=;
        b=Xu8BNEiEFbaqf+rzbTRpeBdQ6YYtGS7j+tZHQrUjUDYIMmRZ1CYt540O1qdfsCsfF3
         uz6OwPhg6rvDkVF4u0tIwg3I4xrFxUS8v1uzIx/9DDFDpvIU8WZcQ2fzCPgTiAZzMgN8
         Ck/GBZQ0DoS/q6hFCMcVdylIxmcbXOAYSbKWqm4QRwkHnqgesaOuc8yyp6GIPMc7EY2b
         sEJ1yxSbddRiqGWA7A1omPjmy1lMV+JAg8gNOjnBKhgxWGZLC9cmI20HhXhMRcyIGoVi
         T4LHPgT+QoaNNo3YQ093MyaPkEXbQP3GI8lwGllRjbcuqKjNqEGP12FqASh3EG/PNCKm
         0pmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782290527; x=1782895327;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9DLExDC59vueux7nw5wKkiU+KpHE7tOm4pNwHPghH8=;
        b=o6r7SD9lhR+5HT+3bgc27oAT1v/HEzrgrxnkl6lIhmzz5vJKO6qe4gydRUzWRvXhJK
         iszcQMWepmDckJfuGv+qi+tKlyVGT4YmvQSl0tyxCTFYcWxZ5z/avocuiMH13xxKpZ46
         Uv8kZP/uJic/SduQx6CBUWS+WpJehwxi0FAu0ClKxugqbKxkd5gY5JI46/Bkup/2UM7/
         +OJkwbULsrfICx2XRh59RQCrdD9Fm7VZN2j7DNFufijyYMopVOmXEA4hh9RtxHLR3gee
         8hwc6fQvcIhr50sskJ8nh+SeysN3+IUKEJvGe8GQGa7BDUdZIEKYm1nDRW+iF3X5Xa9l
         aLtw==
X-Forwarded-Encrypted: i=1; AHgh+Rqbb+xAGjpAjU7bkPP9F/FPLBcgam32h3zO6bLYV2YWUy2Va0q54gCe6sVgD79MWurvSAVNA/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuncNqlOVZ6OqSQPbJGUWBxUahrPmFu91W0c142JGEqH8gvkAN
	52zLAYHM/VjR8HIqUdHK8sV8xg3se7PU3TJhfw+ZvuF30n1R+eB8q98/JEm81nocqGJd93R5Bqr
	uqbUmXv7Jhvp/bg==
X-Received: from edxu18.prod.google.com ([2002:a05:6402:652:b0:697:7bf0:5a7d])
 (user=clecigne job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2714:b0:697:d34f:2667 with SMTP id 4fb4d7f45d1cf-697f3aa4acamr1109823a12.13.1782290527068;
 Wed, 24 Jun 2026 01:42:07 -0700 (PDT)
Date: Wed, 24 Jun 2026 08:41:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624084130.2382335-1-clecigne@google.com>
Subject: [PATCH] xsk: fix memory corruptions in net/core/xdp.c
From: Clement Lecigne <clecigne@google.com>
To: aleksander.lobakin@intel.com, edumazet@google.com, netdev@vger.kernel.org
Cc: clecigne@google.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kuba@kernel.org, sdf@fomichev.me, horms@kernel.org, john.fastabend@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301568-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aleksander.lobakin@intel.com,m:edumazet@google.com,m:netdev@vger.kernel.org,m:clecigne@google.com,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kuba@kernel.org,m:sdf@fomichev.me,m:horms@kernel.org,m:john.fastabend@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[clecigne@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,kernel.org,fomichev.me,gmail.com,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clecigne@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00C526BCA1E

From: Cl=C3=A9ment Lecigne <clecigne@google.com>

Commit 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
introduced a vulnerability in the handling of XDP_PASS for AF_XDP zero-copy
frames.

Note: Currently, this specific AF_XDP zero-copy conversion path is only
reachable from the drivers/net/ethernet/intel/ice driver.

When building an skb, xdp_build_skb_from_zc() uses the chunk size
(xdp->frame_sz) for the allocation. However, napi_build_skb() automatically
reserves space at the end of the allocation for the skb_shared_info
structure.=20

Most high performance UMEM applications use 4K chunks, where the
corruption cannot happen. However, if the UMEM is configured with 2KB
chunks (a very common configuration to maximize packet density in memory),
a standard 1500 MTU packet will trigger the corruption because the required
space exceeds the 2048 byte chunk size:

Headroom (256) + Packet (1514) + skb_shared_info (320) =3D 2090 bytes

Because 2090 bytes > 2048 bytes and __skb_put() does not perform bounds
checking, the memcpy() writes past the available linear data area and
corrupts the skb_shared_info structure. This can lead to arbitrary code
execution if pointers like destructor_arg are overwritten.

Additionally, in xdp_copy_frags_from_zc(), the allocation size is set
strictly to the fragment size (len), but the subsequent memcpy() uses
LARGEST_ALIGN(len). This mismatch results in an out-of-bounds write of
up to 7 bytes, which triggers KASAN warnings and is unsafe despite typical
page pool allocator padding.

Fix the skb allocation in xdp_build_skb_from_zc() by dynamically
calculating the exact truesize required: the sum of the headroom, the
packet length, and the skb_shared_info overhead, properly aligned via
SKB_DATA_ALIGN.

Fix the out-of-bounds write in xdp_copy_frags_from_zc() by rounding up
the allocation request using LARGEST_ALIGN(len) to match the copy
operation.

Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Eric Dumazet <edumazet@google.com>
Signed-off-by: Cl=C3=A9ment Lecigne <clecigne@google.com>
---
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba..f36d1fb875ab 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -699,7 +699,7 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_b=
uff *skb,
 	for (u32 i =3D 0; i < nr_frags; i++) {
 		const skb_frag_t *frag =3D &xinfo->frags[i];
 		u32 len =3D skb_frag_size(frag);
-		u32 offset, truesize =3D len;
+		u32 offset, truesize =3D LARGEST_ALIGN(len);
 		struct page *page;
=20
 		page =3D page_pool_dev_alloc(pp, &offset, &truesize);
@@ -740,7 +740,9 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *=
xdp)
 {
 	const struct xdp_rxq_info *rxq =3D xdp->rxq;
 	u32 len =3D xdp->data_end - xdp->data_meta;
-	u32 truesize =3D xdp->frame_sz;
+	u32 headroom =3D xdp->data_meta - xdp->data_hard_start;
+	u32 truesize =3D SKB_DATA_ALIGN(headroom + len) +
+		       SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	struct sk_buff *skb =3D NULL;
 	struct page_pool *pp;
 	int metalen;
@@ -762,7 +764,7 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *=
xdp)
 	}
=20
 	skb_mark_for_recycle(skb);
-	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
+	skb_reserve(skb, headroom);
=20
 	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));
=20

