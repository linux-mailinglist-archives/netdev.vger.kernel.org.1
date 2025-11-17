Return-Path: <netdev+bounces-239056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E67C63235
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE2DE365767
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 09:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464C4324B31;
	Mon, 17 Nov 2025 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTvBQK6D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530131E107
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370978; cv=none; b=t5UCtwtxmGq1ENWpUBz56BOngCUC6p6vJel5AJwyVV5ZTZMGZjB69WWexXqLfaShlN1vHvwXqsvr+S86CQu7kJby/De3jg+icw/mCrtXbINJF7V5kixbWUvG7ngqHt0Ryc4ZUTzjOrCRMpITja+CD3XEIsTz3YU8vCQS90Yn3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370978; c=relaxed/simple;
	bh=5MFng18vOcqANoAFQkR1r8zkL4CbAXVQoCMVANVbrzs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ixkObSlbxxdrWbYuMj+ngzo2XWBZsOksdF2Ym9pBfZyxtfKIxLEd4HLM9X1Kv/0KYZ8toxlPi7yr6wqntFn3PJghEPr0wDDrjcdNAHW3eWkyjjMo/JlRpft+CHgC3zTnIdAQX8an83NkMSaj1rdm+wIVzwgjrsn3RgqFbuPrJCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTvBQK6D; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-640d790d444so3463602d50.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 01:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763370975; x=1763975775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g96HcGbNRGbYzJFo72qg9V3gq9qDoK8b63Kpk0gWdjE=;
        b=eTvBQK6DirpO4xanKt8aqrYs8ciGpnjUqVlKy+ATPUlcBW2GZXbaHPSDRvuX7Q5Pp3
         5N0ZkKDS+oWGs7sHBFD462+lkd0C+9v0/ffH6U0Jg1Dth2hBPi64X87WzeJaeQeaycKx
         059DR268wine7vrvpg4yDGVrLawOeiFLD1pedYtb6ivffrxyf1D0rMgHmQPI1tUeCWqW
         b8VonLMRsAh7dAmonGPLwI1vN0Kd35j6Zw1yf1LXzzWG1YXQu0lzNWT5yC0ZILV/KjXo
         D/C/gN5sTpV0vvO5pTr0dT9FL5kb5XPOaz5LziDsTszfSAQJ4GMWiQsoI0rrBiEZFCG9
         paIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763370975; x=1763975775;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g96HcGbNRGbYzJFo72qg9V3gq9qDoK8b63Kpk0gWdjE=;
        b=Yp3hrsqW04hfMO8VGJR8h2yAZ7MTPRi4dqr3526fJdMv+AUtTVzdh/BJUMIZkucNFk
         a2XJZsPbzXzk8mJOFhSypJvyZrPRORp8wQfshr8sQBr2WvS3s6kD0Oc6MdRbTX2yJ+8L
         YV0hVud9P56OlcPCgsyb/Oyw+MF/yoCtldd/1qts1j2+bPg6ds+OO96CPkMSMdoVuPzs
         AUaYGtQ8e0d8pXIUt5HNbORY9ZveNVUQLWDQwJLYmZ0QOuKtcwYDyKkLmErDTJ3vRvf8
         +nA8K6PSi8pzquBWkZtqZ2t3ehNY5GVkNUgq5jVmlHL1lwzUkLIrpdQDyE7MCOCO6WMw
         shxg==
X-Gm-Message-State: AOJu0Yx36fAx5pyUgao56XOI4pTtgvNgZzsN/4s8nj/cCPeRNIJJ4TSc
	Tbqvkx3lXvM4WAgxcms66OTvNhNoQxMH/oBV/t4QH9JXMUBQxl/GMtEbH92p4Qh4CNmAX1ati9r
	lBZOPm21wqdd9CQfam4dyArLMfBmoIpA=
X-Gm-Gg: ASbGncvMg9f2JZiUGdLwSVG73cdKc++X8LXJKdymwG+EqOTukt5x4EY1tQ/P/EbOC4P
	AS/wQnYM2YPRfOEd6yz1vmsODU5y3+5xRgVTgBr+qr46i7ilO2kTfFFMSuU7OmKI+wf6cTh+pOU
	8xzwNktEMgEeV0t+8uKzYDfMWJ4I2VdPf6AC00rilT5XdgDb7bmW+1fbVLEx1Uy1mtuFuF71XPH
	65gthQMIpAO5XVdRjidr0OCbHPw47cBsQTZpY9S+IkrcD+m+UlSH0L7Nv6BQBHxBEyYmdZnXj1c
	2TDn4Eg=
X-Google-Smtp-Source: AGHT+IFFAlF4RCFfUjsd4DmDBBQogTcxh5jNqRI3S314lJm0TIqbMA3mxfj3C+NRPQw1DK95EH9ZqSz4/HeSfTTu9VM=
X-Received: by 2002:a05:690e:1519:b0:63f:556b:5b7 with SMTP id
 956f58d0204a3-641e75974d8mr10832505d50.15.1763370975601; Mon, 17 Nov 2025
 01:16:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jiefeng <jiefeng.z.zhang@gmail.com>
Date: Mon, 17 Nov 2025 17:16:04 +0800
X-Gm-Features: AWmQ_bk9YWmMEQLFsH1VDRHw-ATqZ-Skc5eqWOUiPwK2AC4_m4qnimQ9Aabt-uc
Message-ID: <CADEc0q4c_dG6UhfdSge21rSeJ9Q2pghWSCLGNauOAa_dr7NjeA@mail.gmail.com>
Subject: [PATCH] net: atlantic: fix fragment overflow handling in RX path
To: irusskikh@marvell.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jiefeng Zhang <jiefeng.z.zhang@gmail.com>
Date: Mon, 17 Nov 2025 16:17:37 +0800
Subject: [PATCH]  net: atlantic: fix fragment overflow handling in RX path

The atlantic driver can receive packets with more than
MAX_SKB_FRAGS (17) fragments when handling large multi-descriptor packets.
This causes an out-of-bounds write in skb_add_rx_frag_netmem() leading to
kernel panic.

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

