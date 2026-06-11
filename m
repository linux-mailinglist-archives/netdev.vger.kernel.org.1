Return-Path: <netdev+bounces-297901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HUd4FIIhKmpgjAMAu9opvQ
	(envelope-from <netdev+bounces-297901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:46:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E31C666DDEB
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:46:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=iF7bK+Vs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297901-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297901-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CF52300DEDA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC56621A95D;
	Thu, 11 Jun 2026 02:46:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E5F190473
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:46:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781145982; cv=none; b=pKJh385rm08Ls5KtbGcFbwR8g9AmvwZuD986tahaWCS394w9v95k5z8alpgUGESWSD/lhWa5vQBHcu13xW6YvXRvG1MNyUADLgcibfq5r9DZjoC7JKDMMTq91t79+e6N7OQGRJEoZa3SEiJe0jKJJPxPzTEl9/xN8vHGLI/4gyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781145982; c=relaxed/simple;
	bh=28gwmmJZbHwifeKhKcKs3jlabK9yxZRYJLy/CpxcWhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gTFm/2K9KW9C/1A0lS9sSQM4DmYFVqFdd2omFS1HialgPcXaT2cdbtDUh9wo93C1oUC9KkrBqPL6dhdBwV+oF6hf6rjGbSxoCC1BTUpXKrCQPIyXb7amaQrbRe0t1oezTvLr9c71vS+92hL8PCKiyhUL4cgsEBodJXHWqSzCfwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=iF7bK+Vs; arc=none smtp.client-ip=209.85.215.177
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c857fba35cfso3691269a12.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781145981; x=1781750781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rcjpE1eP9eIVKtszIoqhDW3RTPv4xN3zwDCvIagcOCY=;
        b=iF7bK+Vsi11Xek5txtj/eHH1NNjrsdQ/IRW6Dxfiq1r9n11bZUo9LL7cPYkEMnLviw
         4SION7bND936/Ghxo334sY9aKVFWETR3zSqLQtnKNmOal5KNZdbeRIP/3PeQxNvHmYGb
         CIgEYX7bv5cnCQfLhydFVu4b2JVtyP+66KF1qk/zFn6ioeADje7ZepUXQtLYbS1EVbgP
         I/skiuRrs/tvjO4Oy/hH3MxhHkZq28xODCvue/Pyp2IQeJ1C5lshW5mUHrPcpeGYuz9C
         Jxf0ctwP17A9iNxujoHQeCHSK8DKZG45cmgu9xpuzKHgVfUsKgwfRz40T+wm16lICsdL
         O6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781145981; x=1781750781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcjpE1eP9eIVKtszIoqhDW3RTPv4xN3zwDCvIagcOCY=;
        b=MHRtkLipridKlF10Ezgxo6EM3N7Sr30oHqTXXHBy+35nrFvSwfO5nbGIDxtzO1xgsy
         XX9pnk+DdwicN4LlOtB5qSbG+kJwOmjrY7Lr2uKI4vqyJyQrZ2q6ta1BmshJ+1+dV8Lz
         eLLktneBl3YmQWBqAkZ/qcLlwB/LU4tAdoMNszkxGzYd9eV3ayUlwtYK2apBAHStspS9
         X8WKo7/5Z8m5uSBvnMwGa9XWVB9vXbeHFF4Y9WrGg2LbVk6aTG0rnxbipimvzZ8vg6VA
         ZsbDhZUuAUAtuD3q4ZCGItl1D90rB6H3uExWvsX80iJvQ7jVjnKbXBj0mTBQ2uv/E/Fm
         vHQw==
X-Forwarded-Encrypted: i=1; AFNElJ+BNQy/WrC8gvHVKGxXLP3+Bt/B0YkFdj14tc9tA+S6kOh/LC2xqzZ9qUFDxgoUHjJq6kKNgTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTUiP0FuYF25pZ0CVFwD6CtBryJvn51UTJC5x/SYxBX+N5j9ue
	yVsxOJw/Z82B96evqwX5G6RkSu4F+/a6w0d4x2V2nLYRLWkABT/oVXMv3QJV22jE8Q==
X-Gm-Gg: Acq92OFFgsyRYZnhiJWhkvBoR/hpHJT3sbsc5MOW8nlRb5hQ+juZ5rAuahSEgg/Pf78
	02BiDdbyEImZTTC3Np2r1Wh8DTQP5XdGGmRRCOUgBkNgMyAFdRxeQcozGVpeanko5k/h4LLAGbB
	Km8RZvqXBwHEGM8p7/a9oihLjfp3ZN6VhqruiJC6MSYPtaLGrhWHclzzGBbhiGhkuXaEHXMi56w
	swGYcZPIXpesOzSx5fOqFnW+N/jU8PloinMPFy74Q1Q+jj+qbBTcQp3EZVD6A5LniZggvG2DxMH
	5poDSWmnBGOJnkgvLfhI8GwYIZf5f92HpFppztCDyfAdlRcj/WYEFYLFCMpxKuNuUWeJFPssPVV
	tyM/xfy/kKWujYFNF1omdbA7+Q5H5tzU+DxTp6SvgNxqP4thIDoJRJxR/Nrgs/mgCoZLwzXSMl2
	EsFhVe12egpbKWBxs=
X-Received: by 2002:a05:6a20:c887:b0:3b4:9124:ae14 with SMTP id adf61e73a8af0-3b5e31e23c8mr751745637.11.1781145980854;
        Wed, 10 Jun 2026 19:46:20 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86585b1f35sm72377a12.8.2026.06.10.19.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 19:46:20 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	minhquangbui99@gmail.com,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v3] virtio-net: fix len check in receive_big()
Date: Wed, 10 Jun 2026 19:46:16 -0700
Message-ID: <20260611024616.1408317-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,gmail.com,asu.edu];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297901-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:minhquangbui99@gmail.com,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E31C666DDEB

receive_big() bounds the device-announced length by
(big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
add_recvbuf_big() sets sg[1] to start at offset
sizeof(struct padded_vnet_hdr) into the first page, so the chain
actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
check allows for the common hdr_len == 12 case.

A malicious virtio backend can announce a len in that gap.  page_to_skb()
then walks one frag past the page chain, storing a NULL page->private
into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
write past the static frag array and a NULL frag handed up the rx path.

Bound len by the size add_recvbuf_big() actually advertised.

Fixes: 0c716703965f ("virtio-net: fix received length check in big packets")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v3: revoke 2/2 and add Xuan Zhuo's Reviewed-by tag

 drivers/net/virtio_net.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..afe73eda1491 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_device *dev,
 				   struct virtnet_rq_stats *stats)
 {
 	struct page *page = buf;
+	unsigned long max_len;
 	struct sk_buff *skb;
 
 	/* Make sure that len does not exceed the size allocated in
 	 * add_recvbuf_big.
 	 */
-	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
+	max_len = vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_hdr)) +
+		  vi->big_packets_num_skbfrags * PAGE_SIZE;
+	if (unlikely(len > max_len)) {
 		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
-			 dev->name, len,
-			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
+			 dev->name, len, max_len);
 		goto err;
 	}
 
-- 
2.43.0


