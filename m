Return-Path: <netdev+bounces-239104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09567C63DBF
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 12:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 1B09323FF4
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AAD32AAD8;
	Mon, 17 Nov 2025 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipU6YLm4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A06F30AABE
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763379549; cv=none; b=YmrvQtymWIupFvDPdHVaLa1MJlQV7sOF2fUXAXB2CUptpjRNVNQitvx2yJZYNgX3ulsASNm/PhlFFSFYcIrKckW9K63xQTtMwamwC2kBWJ9MS8px8YTgIvhmyjRo04cHMZVx4h0IDL4BXER4+X59CQSQphr+lcSs18+x0UyK+5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763379549; c=relaxed/simple;
	bh=BqPXftu45/N72NdClAK9kFAAxhVv3wr+wvRKt2bbCdc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tzIjR+Pj53pv9tzHW2dJO31aPEN/N+nsF9NpTjdxEEyMNdc1g6xWABkmEHYqcVyNJdo1UPlMcFGBEVIRiQ12uAk09P+8k1pSTIK6Eiv0/RWF96pTLdUiOtlrpBNZxtp/J6+3pmVcszrxd0ppKiu+6mHZkproaONyOA+8y2Dk0/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipU6YLm4; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6420c08f886so444343d50.3
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 03:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763379546; x=1763984346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K4alAgSMj7VxOYpc7O1/ojdzfyambI5bVDMuV2I01ak=;
        b=ipU6YLm4DqrI5i4iRgFH24nIbh3kZHzFF04iApDF2BCneMEAqQiNNTDo68xn2Kdgum
         9CA7qbGjrlqiZYQnSLhQ1jLb07+QOFUPkDRVn1l3y0TMn3KHS2eG1bClcOdn1+GkRxcI
         05tZLC4Jsnts/aZ/TqiBtXaXwV0NArdTdlqXkKV6qn9TcdCR3/4qAFgKekUEkwPl2410
         qsTpJCX1g/9CQQtXD6vw+4+9fFQwD2I8GVA9CSskPR+/0XpNdOfGyrVQuifqZjR4pLIv
         +leQUNxgZxvq/kNslmWm7gJdTLv03TSH2rVMY3QLLjvCLbT4gmklCo9C5h+4USxyHDUw
         dGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763379546; x=1763984346;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4alAgSMj7VxOYpc7O1/ojdzfyambI5bVDMuV2I01ak=;
        b=FWzSXaN/ApKOIn28Jxm6lk6uf8pRA6to9/rTtt4qyFP+Z3/BKCCSVovRPYnnt6MCp3
         hbBPMh7G1qsuHegZUNebDJ6c4fwCv1O8LXKYG8nu+mmKEYjaosgX3Qybtc+Vk16cmFiN
         rkHTY4+VZNAv9+oBcYdpVla+OnXowqh91rJyLuiHJ5z4ntdPzmIZmCoxnJjvneol1Ics
         gV7EJaXEVyURiugAgSve1edxuHfgmy9pCpSgSTJbwLIpYLQgMsJ+HskqSS/mgCbbeFx1
         VU4FVyecAJaYjEg/n4PyuE3Y1ovVg+wA/DrCZ5JP6OUMt+O/ObmYHQLI/kCW+cS0qkQN
         N2xA==
X-Gm-Message-State: AOJu0Yyc2mM+dOhYFFObCLau0RCsCQ+K+6pCD02PHuJe2lnXWidvuBKI
	ytEnGDKdi/XnRfDeLkMWAVeGy88/pbkgJxOLzXaf0iTjMJMBi75YuXU8IjgsQUf74cD+jc6joqe
	CWy2JzFVxqEkf5R+cwIN1FbIAhHdnK1IucRrlmWhP7Q==
X-Gm-Gg: ASbGncshSMxDTicb599LzKdLHTus3RDvLgj9+orrCi+7VbZ12L4JSKYL33i8JBYVqYW
	fYOlevZ3pQ+NGTqOA6m2+sYHFvdIzxWT148Uit0pjCmojp6zcFqXas7PqMWUmVZG364+zJkU7SG
	MzBGuqkRI4Lq+YrMLHXwdJ++28jFB2Rvi0d8fCTJpUX8o2cJtazcUtgjOnBWP9t9cw56DPpENER
	0Tvb+L6VvSouEl/+6i1o0/ffpHq1ke0ppG7XODRUIbayNmPVdyulraBWPUZ2PXHN1LrGhdmc9C9
	oU/vaiA=
X-Google-Smtp-Source: AGHT+IFjYUW+w3DLrjJ6IG0KotEXcSx8W2SZVTbQycNC16H61uFpNAb+cJBAePCi+16dfdCOXbzJfWNmdAxEgEGifPM=
X-Received: by 2002:a05:690e:15c6:b0:63e:4264:878b with SMTP id
 956f58d0204a3-641e76f6a8cmr7538309d50.58.1763379546149; Mon, 17 Nov 2025
 03:39:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jiefeng <jiefeng.z.zhang@gmail.com>
Date: Mon, 17 Nov 2025 19:38:54 +0800
X-Gm-Features: AWmQ_bnhRaIJwc9zoMLKimak126PaDcAcpn56-aQ73KCoDM16t1mi1CY9lNri9I
Message-ID: <CADEc0q5uRhf164cur2SL3YG+fqzbiderZrSqnH2nY0CkhGHKTw@mail.gmail.com>
Subject: [PATCH] net: atlantic: fix fragment overflow handling in RX path
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, edumazet@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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
  bool is_ptp_ring = aq_ptp_ring(self->aq_nic, self);
  struct aq_ring_buff_s *buff_ = NULL;
  struct sk_buff *skb = NULL;
+ unsigned int frag_cnt = 0U;
  unsigned int next_ = 0U;
  unsigned int i = 0U;
  u16 hdr_len;
@@ -546,7 +547,6 @@ static int __aq_ring_rx_clean(struct aq_ring_s
*self, struct napi_struct *napi,
  continue;

  if (!buff->is_eop) {
- unsigned int frag_cnt = 0U;
  buff_ = buff;
  do {
  bool is_rsc_completed = true;
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
+ buff_ = buff;
+ do {
+ next_ = buff_->next;
+ buff_ = &self->buff_ring[next_];
+ buff_->is_cleaned = 1;
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

