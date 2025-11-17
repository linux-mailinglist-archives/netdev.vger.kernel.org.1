Return-Path: <netdev+bounces-239086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8122C63979
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573DC3B44A2
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7D4328B4F;
	Mon, 17 Nov 2025 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btgqsLHJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C81328619
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763376000; cv=none; b=ZuATo73bOA+SvxykIKxEWZDz+fccOi7S3jO3US0+U5W7X7d1b+rc1CGcueyaY+qEsQB7tUTE5lPitXjSDQlEFsEvnyWmJZkIGEqr5iuXHwX6219Be6Wof8nzSyGiwl0UypeUbYJzJZvNrBZ250E95C2l8VGBEXPqBJ1/6DXLgI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763376000; c=relaxed/simple;
	bh=49et63gWGNEtF8n2Sq0hcX3A8NynZN7gH2lJIZRFx84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cO/ETZYdk4J3nLBNktganwxIYw8lnde4crjk2yRky53GkDpJcPnZBNlDRzQqo2pI/ck5dMNb+aeuD1mfQ2YV6kbC5B5YH354+JRFSn+SFPj23h0wNj28okXktjEYRWJVU4s7SrECF7jj4CpKQN2OHaS5RjaY4t00WeTGZJ/rQVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btgqsLHJ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-787ff3f462bso48134727b3.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 02:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763375997; x=1763980797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ImwKCBbiSMnFISG8uQtxNkUEoQQrv4Dfx/BLqxTXXM=;
        b=btgqsLHJv21z5CG1+7k7lG1SkI3PkxKMX4lIT64zYLf6cpqY2Cg9uBiPbqGhgCtoGf
         d8PloIyaj6U6bIitmK424f/KtHGTxAgaQ7klK2gHHoHIFg664k059D72KJIDz5DPgeu4
         ApiHEEF78l2yS0mWdjZWHWKZyn0BnIXrQPygBKD3r3q2aSToUEk6LtYcDtlhiMmWB9xp
         0aw1t7eDE2r4ONtRCrW3JJWzS0aeQrFLaGmtPakmx/3djyEUBuOk1XTcQvVM0h3E88p3
         YeA/ze2T/9xVTKuvoHAqIGBsdn+2IGiwx4EQAcOgEq0Hs4tWIrN1c7akw9lVFNdzzCAJ
         Q11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763375997; x=1763980797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ImwKCBbiSMnFISG8uQtxNkUEoQQrv4Dfx/BLqxTXXM=;
        b=t8cZwM2g2RGXJjqrKnfdXttHVDl009SFJcl9VVo8127pyzHh4be6Qhs4EQthYCaHu/
         J3SYO++TGBQ0/DymQHLQ+UTcPr3J78mAVO9rjOjo5/TJFtaaIVPpDZYnLZlGWntUdUmH
         EUHsMx2M1wJtX8IrX1/Ghg7cjojRHC7OHrPa8AIkafeothVv9H2VFK4tXVYiZE3bHcQR
         lbplYW3Z6DT6Y7Gx9NRT7Vp04oWPbSQ7mtTAM8R5lGJPem+rxUg3j1yoh4G7rEn1XAXj
         cayLgl+SKfdQSrTUpHyiV8RsWjzQzdvu+nc33Ej+0qeiQf68q1nodCBX7eeEloBv+Dic
         zqQg==
X-Gm-Message-State: AOJu0YwSdZ2v+CoQ7+AabGOZY9QeI0Tyx7iSXFHNgWUZmMfZqFyN6r0F
	nLWmhON+YwfHetwWVtrX8WEF8AHahOToqX70jzs8l244JAk2lCT6W47xzUbKQVnjxstd11P9U21
	/DVLQJL7yZe0aeI6JeUBGq2kxqDTtAqQdXcslhNDb8A==
X-Gm-Gg: ASbGncvjaAGIzTQKp/fRFfLXCLiFuKHO7BxX773I+BQ+LzZ+MjDfnZtcWFiyc4sFD6b
	VuHtEk8t/Xt5gYb+0tWgl5FjmuQ/Y0/TAaJ7/DiBjXXlM3kH/BOAwOXQhLBi+DGKlfNZegY3rvO
	96EwmzmZBI+j5754ifc96ceZXzKld2e3deyoFsxvx79HTntS6spfRGVSMYJTzslatnWsTSs73ow
	kwF+/bKdcUxQvpiMfEGMF30gF+MytCfU5ELm6Pci9bGEEBd3mm+T+qeGLshB23DkWaNJBSq+FWe
	X1oe6h8=
X-Google-Smtp-Source: AGHT+IHMq8QnI7txFwTqO9uw84DsDX2miznvLOmA6bQNn411dR5KoisTfhmrbUTn0w0rUiBTPWTWCK4sq+A/Py2d6WE=
X-Received: by 2002:a05:690e:130e:b0:63f:acc8:f163 with SMTP id
 956f58d0204a3-6410d10fad9mr11407563d50.21.1763375997286; Mon, 17 Nov 2025
 02:39:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1763375698-8716-mlmmj-51ac7a34@vger.kernel.org> <CADEc0q5n5L9uKUHoaJrAruABU7Kh4gn9_v3YJWqHxNjxqX5omg@mail.gmail.com>
In-Reply-To: <CADEc0q5n5L9uKUHoaJrAruABU7Kh4gn9_v3YJWqHxNjxqX5omg@mail.gmail.com>
From: Jiefeng <jiefeng.z.zhang@gmail.com>
Date: Mon, 17 Nov 2025 18:39:45 +0800
X-Gm-Features: AWmQ_blVfb4aMPSURq5oxTloOLxdYMHaP10D6qzIlmllQqIUXOoHTqTnIHCKNsY
Message-ID: <CADEc0q5nmAqt-g6mpGu+e7DVbJzZLoOMzEH7S7=zG_bp_AwP4w@mail.gmail.com>
Subject: Re: HTML message rejected: Fwd: [PATCH] net: atlantic: fix fragment
 overflow handling in RX path
To: netdev@vger.kernel.org, irusskikh@marvell.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, edumazet@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From f78a25e62b4a0155beee0449536ba419feeddb75 Mon Sep 17 00:00:00 2001
From: Jiefeng Zhang <jiefeng.z.zhang@gmail.com>
Date: Mon, 17 Nov 2025 16:17:37 +0800
Subject: [PATCH] net: atlantic: fix fragment overflow handling in RX path

The atlantic driver can receive packets with more than MAX_SKB_FRAGS (17)
fragments when handling large multi-descriptor packets. This causes an
out-of-bounds write in skb_add_rx_frag_netmem() leading to kernel panic.

The issue occurs because the driver doesn't check the total number of
fragments before calling skb_add_rx_frag(). When a packet requires more
than MAX_SKB_FRAGS fragments, the fragment index exceeds the array bounds.

Add a check in __aq_ring_rx_clean() to ensure the total number of fragments
(including the initial header fragment and subsequent descriptor fragments)
does not exceed MAX_SKB_FRAGS. If it does, drop the packet gracefully
and increment the error counter.

Signed-off-by: Jiefeng Zhang <jiefeng.z.zhang@gmail.com>
---
 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index f21de0c21e52..51e0c6cc71d7 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -538,6 +538,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s
*self, struct napi_struct *napi,
  bool is_ptp_ring =3D aq_ptp_ring(self->aq_nic, self);
  struct aq_ring_buff_s *buff_ =3D NULL;
  struct sk_buff *skb =3D NULL;
+ unsigned int frag_cnt =3D 0U;
  unsigned int next_ =3D 0U;
  unsigned int i =3D 0U;
  u16 hdr_len;
@@ -546,7 +547,6 @@ static int __aq_ring_rx_clean(struct aq_ring_s
*self, struct napi_struct *napi,
  continue;

  if (!buff->is_eop) {
- unsigned int frag_cnt =3D 0U;
  buff_ =3D buff;
  do {
  bool is_rsc_completed =3D true;
@@ -628,6 +628,30 @@ static int __aq_ring_rx_clean(struct aq_ring_s
*self, struct napi_struct *napi,
    aq_buf_vaddr(&buff->rxdata),
    AQ_CFG_RX_HDR_SIZE);

+ /* Check if total fragments exceed MAX_SKB_FRAGS limit.
+ * The total fragment count consists of:
+ * - One fragment from the first buffer if (buff->len > hdr_len)
+ * - frag_cnt fragments from subsequent descriptors
+ * If the total exceeds MAX_SKB_FRAGS (17), we must drop the
+ * packet to prevent an out-of-bounds write in skb_add_rx_frag().
+ */
+ if (unlikely(((buff->len - hdr_len) > 0 ? 1 : 0) + frag_cnt >
MAX_SKB_FRAGS)) {
+ /* Drop packet: fragment count exceeds kernel limit */
+ if (!buff->is_eop) {
+ buff_ =3D buff;
+ do {
+ next_ =3D buff_->next;
+ buff_ =3D &self->buff_ring[next_];
+ buff_->is_cleaned =3D 1;
+ } while (!buff_->is_eop);
+ }
+ u64_stats_update_begin(&self->stats.rx.syncp);
+ ++self->stats.rx.errors;
+ u64_stats_update_end(&self->stats.rx.syncp);
+ dev_kfree_skb_any(skb);
+ continue;
+ }
+
  memcpy(__skb_put(skb, hdr_len), aq_buf_vaddr(&buff->rxdata),
         ALIGN(hdr_len, sizeof(long)));

--
2.39.5


On Mon, Nov 17, 2025 at 6:35=E2=80=AFPM Jiefeng <jiefeng.z.zhang@gmail.com>=
 wrote:
>
>

