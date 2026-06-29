Return-Path: <netdev+bounces-302488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3NN4O3cdQmrt0QkAu9opvQ
	(envelope-from <netdev+bounces-302488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:23:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EF26D6F48
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 09:23:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=KFoMNT+Z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302488-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302488-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95DEC3006178
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 07:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9643CF1E7;
	Mon, 29 Jun 2026 07:23:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6753CF043
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 07:23:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717805; cv=none; b=VkiZmM0nurauJIJhTZ7Yp+P+HBq10zBHBBS3bQl5hpd/M0ybCtZmY6KiDmwyMeql/C8xy6w7DnxzlpwFiUzjS7Rai/U82hM3bemMNRCDpnlnHMT7EDkW/Xen5FWx6Ldc06+eT1gEVb6UYo8YCaWxUzTU+aGgw+dcEKKlzIB2BU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717805; c=relaxed/simple;
	bh=F4mUr5fBW1c1Axigt0EZGxBodn37EyWGG5Bvapzj6BA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LOHw9L2g6FfQIEUBQv1pTTSTV38uLrq+VeJXzMGCO46hz4N9DPLMS6VGsMVokxIHijvBT/2FxJR524u1QYh6ozGGWhELWret+1T7RX4ia2nCCsrDUNQIEU2Emb5lokFLIkbcyMVWH68icyqz0HR9TeAvSeVtVfQcYxnNs/RMyp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--clecigne.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KFoMNT+Z; arc=none smtp.client-ip=209.85.208.73
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-69681505eabso3188569a12.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 00:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782717801; x=1783322601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=esIyG5vSRRrObBzd9FBYvLdlPmWTHEKEhlqipjb5aLM=;
        b=KFoMNT+Z3IUv44V2WDO4nmwk0jVWhc2avf3twLkEiT0zC+bo+OV5BorxbIRkAtr4Se
         wJMhGJM4b7eDiIvkabthe7LoUzlt/UuiFddM+e0tI5O5eKxMffGjqxQ4Ukf4lVaXIWzQ
         myNLd55O2h5efC5BE4jh4pp06AtSTl0+4oiemVCIgEi9E1+UzitUohSj1QqWWLLqS8vV
         QCk1DLwtaDzCB15iIn4PEUgtKinmBz1/03vLlQ1ahFukJYepsjfuja2q1r7grmCfmh6T
         VnXNiH5qYiUg2ibLbFEUKX6ruy9Dv3vGTU99cavVObLewmbm0fzStxbY93vHFc7kzHoF
         Y4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782717801; x=1783322601;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esIyG5vSRRrObBzd9FBYvLdlPmWTHEKEhlqipjb5aLM=;
        b=Yt5Ctm2L/JhqAvpVS8vD5vM0dbmQArR8furchWDVmj5OiBGvbZOkfrk244xULInuUo
         09zTNDE7hAc6fgr6ZCi3k+729ehKdJApdQtE0J162PT+j4luTG4O6n/9GP2X1GCzHrxD
         mJMieR8ZFHgN2vzDILxLgY1LlUkuEpKu7A7/ZaHABMvdCD74M8lJKD6NhPWCxiM8azks
         EExp0G1HeWm1u3fIe0Q8fZVOSSjoJYaUAhZaVIxh90lU08UbwpqTDxl4MUmR7n4n7e4O
         JGgEInXhtMKkIFzZTGphNT2VoGBDFNTtYvajkn+ab+MVSvYh0E8j6aWjtzkD4q5Zik30
         oslw==
X-Forwarded-Encrypted: i=1; AHgh+Rp29ey7si2q5ns5VJDOwpasF6rbGIGnwgm8CuzrBMyJX/xZbcMGi2/7CqcDHMMVV425BVVKLsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXQKGaQZouWxMK5/NfVuNCg7EMt49rx9mvM2poKKyfq+CmZVx
	Vx+VIcZ6NTD3YiXi0b5S3Udw6XPgIF9V1EyH4U1q420D/hIUMun0D6MdIignxJoS4gKZvSs5uwY
	2/dZ5Ev8swREW9g==
X-Received: from edyd4.prod.google.com ([2002:a05:6402:784:b0:698:3f24:d08a])
 (user=clecigne job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:190b:b0:697:c0f6:394c with SMTP id 4fb4d7f45d1cf-69810a44a6dmr5463438a12.9.1782717800656;
 Mon, 29 Jun 2026 00:23:20 -0700 (PDT)
Date: Mon, 29 Jun 2026 07:22:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629072300.1664622-1-clecigne@google.com>
Subject: [PATCH v3] xsk: fix memory corruptions in net/core/xdp.c
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302488-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87EF26D6F48

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
properly account for the headroom, the LARGEST_ALIGN(len), and the
skb_shared_info overhead.

Fix the out-of-bounds write in xdp_copy_frags_from_zc() by rounding up
the allocation request using LARGEST_ALIGN(len) to match the copy
operation.

Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Eric Dumazet <edumazet@google.com>
Signed-off-by: Cl=C3=A9ment Lecigne <clecigne@google.com>
---
Changes since v2:
 - Used LARGEST_ALIGN to calculate the len to account for the aligned memcp=
y.
 - Fixed the commit message to include the idpf driver.

Changes since v1:
 - Used SKB_HEAD_ALIGN to properly calculate the required allocation size
   including the skb_shared_info overhead.
 - Re-ordered variable declarations.

---
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba..7e39f17ad407 100644
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
-	u32 len =3D xdp->data_end - xdp->data_meta;
-	u32 truesize =3D xdp->frame_sz;
+	u32 len =3D LARGEST_ALIGN(xdp->data_end - xdp->data_meta);
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

