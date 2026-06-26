Return-Path: <netdev+bounces-302127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yAwaGAs+PmrvBwkAu9opvQ
	(envelope-from <netdev+bounces-302127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 10:53:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB726CB7E8
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 10:53:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="toOW+/kz";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302127-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302127-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81A7B3009163
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 08:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F963E63BB;
	Fri, 26 Jun 2026 08:52:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959C12EB859
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 08:52:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463956; cv=none; b=npMi33KidAikBQTJmMfIzM1yl30W8WOcwC2U+nLijq2lxHp4/UIlYIxueSaTHKP/hBhn00UKlWWa617YzmA+u5rXlpcxSBxd1aPcaCZmwmbH7DqZ1YBuxNSnibIPGnOwnTQFKc+JoNBGG2iLtodCQk2wH8qLPJPyhBQukuT4fYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463956; c=relaxed/simple;
	bh=4Q4kwEItPghZptzI7w7yAwAaOy5jEDXFyh70cxxpS7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kEl5zCTNS06o7ZmUwza1hp5Hu0rPQ8vOOQM4Ll6tHp1FRNBayCDakJ7E+sYgHPsO83bmYJ/gbFY+LkD308da7Xtnwp/40uOB0y26JBi/WbnMq+XfWxc3CgY/gEfLFIljByONVg7FHHPlUrrsl09mSSwE2f/Y4kHbriO0KT9bvtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--clecigne.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=toOW+/kz; arc=none smtp.client-ip=209.85.208.73
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-695bbac451bso855784a12.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 01:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782463953; x=1783068753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMQwGfZ+4fg0c6+aiBQoHL3kx0Z8EfvRBL6AIlt5U1s=;
        b=toOW+/kz+DBojB5RjZ2MgxrATvqJDfThot/OuWoeHvoFYeFqK/lWMgxXSuuw6+P2yf
         aqGLZCuEpCLNJXZ12rELl935upCpYQxGidZQokYuzHQMDC1V68U58Wyk9RBn7mRq/OPs
         /KC9S8b+cPrnHdlNKmI6VSOcbwyAAUbxmeGUciUueIfhJTb4D8/BfJ8G7RchAQU+Oy8v
         TFF9msCFWnTcpuIOMHEEukNUagWTZWj2kDLqEakxI572s3p2UqCX6dKAFgYbXoP5abee
         Ka5766O7Os/c9ttVnvnKiJBobS/iRB/yldtEwBy21DtWgbmG6kOaPcknUYPRsDgmBpMf
         +pDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782463953; x=1783068753;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CMQwGfZ+4fg0c6+aiBQoHL3kx0Z8EfvRBL6AIlt5U1s=;
        b=PXkziZo/mo+q4A1sXjNIyM+YNbwpREOLSbTne4PYd7ItmaxbOa9apRO8i+foa3ib4K
         gRXdO9RG4jUeRBGZmOQDlOt02oISEk0AbJPtvW9c/kIRjAyGjokODI68UtbZT76gyENZ
         YUjEzTOpfK9dAbscqEkYkJl2tAKsX4Vof/9T98WDrvaAOJBl4xiQT2N0M06+P03KdWe9
         HG8OAncMDhclJrKBr9wXnC8nZops2KNjA8BMpuQ8uC92Sje5fbrPc4keEYu7bqiPwTCd
         znm/a1Egq2OFFGkK/1B/Y9jSEcPbKfoVU8JnzKEkZFKX7I3cY8ZBf9RTHAWPy0RndNE8
         yTZg==
X-Forwarded-Encrypted: i=1; AHgh+RoScpxFXgIroRwg9H7JXVLjRGlinOpohEBQ+mN4EuGdOWDy9//ZFulQ/sCvcL6kwcpeflYKGtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzALtkptt0/6A+NKnCdSm7pTaWuJFLUqBdBZMpzP2sEQxsQreiC
	w2faikrgUKCK+FyKCSa0rUvVa02SzDnyGg648SY2FH4vYq4dcWG8Jgz+npHFjCmKxkViTCUIhE5
	SXJAiMi7yYDkTqg==
X-Received: from edsx13.prod.google.com ([2002:aa7:dacd:0:b0:696:5e7:d0af])
 (user=clecigne job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:51d2:b0:697:750e:e9f5 with SMTP id 4fb4d7f45d1cf-69810ae06c1mr1512484a12.23.1782463952731;
 Fri, 26 Jun 2026 01:52:32 -0700 (PDT)
Date: Fri, 26 Jun 2026 08:52:25 +0000
In-Reply-To: <0922ce5d-48d8-44e7-983c-e547f3126ef4@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0922ce5d-48d8-44e7-983c-e547f3126ef4@intel.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626085226.1765180-1-clecigne@google.com>
Subject: [PATCH v2] xsk: fix memory corruptions in net/core/xdp.c
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302127-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:aleksander.lobakin@intel.com,m:edumazet@google.com,m:netdev@vger.kernel.org,m:clecigne@google.com,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kuba@kernel.org,m:sdf@fomichev.me,m:horms@kernel.org,m:john.fastabend@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:johnfastabend@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACB726CB7E8

From: Cl=C3=A9ment Lecigne <clecigne@google.com>

Commit 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
introduced a vulnerability in the handling of XDP_PASS for AF_XDP zero-copy
frames.

Note: Currently, this specific AF_XDP zero-copy conversion path is only
reachable from the drivers/net/ethernet/intel/ice and
drivers/net/ethernet/intel/idpf drivers.

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
calculating the exact truesize required using SKB_HEAD_ALIGN() to
properly account for the headroom, the packet length, and the
skb_shared_info overhead.

Fix the out-of-bounds write in xdp_copy_frags_from_zc() by rounding up
the allocation request using LARGEST_ALIGN(len) to match the copy
operation.

Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Eric Dumazet <edumazet@google.com>
Signed-off-by: Cl=C3=A9ment Lecigne <clecigne@google.com>
---
Changes since v1:
 - Used SKB_HEAD_ALIGN to properly calculate the required allocation size
   including the skb_shared_info overhead.
 - Re-ordered variable declarations.

---
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba..52546746378a 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -698,8 +698,8 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_b=
uff *skb,
=20
 	for (u32 i =3D 0; i < nr_frags; i++) {
 		const skb_frag_t *frag =3D &xinfo->frags[i];
-		u32 len =3D skb_frag_size(frag);
-		u32 offset, truesize =3D len;
+		u32 offset, len =3D skb_frag_size(frag);
+		u32 truesize =3D LARGEST_ALIGN(len);
 		struct page *page;
=20
 		page =3D page_pool_dev_alloc(pp, &offset, &truesize);
@@ -738,9 +738,10 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_=
buff *skb,
  */
 struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 {
+	u32 headroom =3D xdp->data_meta - xdp->data_hard_start;
 	const struct xdp_rxq_info *rxq =3D xdp->rxq;
 	u32 len =3D xdp->data_end - xdp->data_meta;
-	u32 truesize =3D xdp->frame_sz;
+	u32 truesize =3D SKB_HEAD_ALIGN(headroom + len);
 	struct sk_buff *skb =3D NULL;
 	struct page_pool *pp;
 	int metalen;
@@ -762,7 +763,7 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *=
xdp)
 	}
=20
 	skb_mark_for_recycle(skb);
-	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
+	skb_reserve(skb, headroom);
=20
 	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));
=20

