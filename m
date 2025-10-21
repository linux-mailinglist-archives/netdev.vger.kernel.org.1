Return-Path: <netdev+bounces-231329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0635DBF7759
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 17:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA81A19A235A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF7E3446D8;
	Tue, 21 Oct 2025 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SULnu3vE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451233446AE
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061547; cv=none; b=Sr14q2aBw2OKJIzzvXfrXj9tnpabv/YZ6AAppWhVnnrWoYnsGnbQJeQ/es11RWTaSKzS1SwpJeLF718PKoqBUhVL6jARNvESaML2Dgriaom7Istnu6vEmC+D2f/1bVCKwdYq/nl1xkUFzFqndlsdlKoC+2sAgisz63uNuW+oTe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061547; c=relaxed/simple;
	bh=NFWo4ioEJIhQFUj4F2K8PNPc2iMgiaom38xGap6Tnro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YePk8Lnhe0q55yFtUy2tvyL1SQB0+6bssdPeuDHApJ3OU/hiF/sjIy0+2sSYbStWeRxJjxBs5ZvElTo2AujZkS/ZGYRact7Us+wE9mgQRNz/oQOm33vEOCYJ0JfRll2OMAA4+UGNZMqC1zQGb62m00aMA7fsLhaLnAM5OhmY2e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SULnu3vE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78118e163e5so20153b3a.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761061545; x=1761666345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kbUGtNpnVaPGTyOD2V45HVuJEH267XSQtThwcECfQ7k=;
        b=SULnu3vEvW0heJ1ymE+FNa7iT4dc1rylBTsKPPAwDZk9RXwULRBEi5AMGl5/jkUMcJ
         zKJOJxB7b0DfVWTPIsTA3Ui0M8HuBpZKXbABDImJpOq2saZwVLELUFKGNbn0cpKlvcCn
         qJkh/IArLUsvUGmhnUflTkYeMAVRxcg6iDIR7jRIxTWPAJJ8Ih+2GlrxCX3tyIytzkbF
         BGjKVro09lDX3c3/0pryW+5IuBHZ1e1J3GazwCNnM3cmEdlFlMUBOohoHHK7xkTBlKTh
         luWEqbJwifRm9d8ENA6/JViOfFwP+bh258PhJKeLxZhdamQsTEmqoBpi+wUJyIBtUoGZ
         N3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061545; x=1761666345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbUGtNpnVaPGTyOD2V45HVuJEH267XSQtThwcECfQ7k=;
        b=AfeERCgHb81hxU+B7tp1yvJqn+z16D09lFPMfk39mUHhyY1ZizjkctarA0NoHRNIlV
         27pJgNdgFzvvA7nwdsCZllTSA/9yE+RcQUcKyBfxyitPvK+nideU7SBoNO8Nh5139VZz
         x7IKNRdxjvmve/VEFcbzEKG9UVkR8YgLUJLTWpo6LcjiazgfqQrcyt01Oe0taPcJjNR6
         1ZOGsIftz7RqeVbM0Tdn/DsS9k8tyB5OtW+sPWUAB77YZy65ezkO/zJB7DMOBT6Bnr+W
         FM79YqB2oZVaeLj45wbTIeX5XzCCH4A0iJ9HUw61Vermrx3HJWqODWqs5tckjwSv3o4r
         bF0g==
X-Gm-Message-State: AOJu0Yw+O8UuJum+c8LrzWIzk7LfT4VJjhL6YD7TUkKuk+aqy0WQ0keu
	NGARFCQenEYljbhHxxna1Ibm1S+4wry8bP9XS5CeBVQWs9y6nQxWCvLW0ESsiQ==
X-Gm-Gg: ASbGncuhGMfKHuV6SvsOtJVNr72AI5FfWOrkh/HI7915i9w3j8GHoWwA58B1v/UZUVh
	a230nPgPdMi4pAojkbqcc4w9spMj+KTe79JTH8PyJAvs61yr+NtqLFI4cnUU7NbGhTPRY4mUQ2Y
	UTe8dgEI8uF5cVRpJfjiVbj4qXgfh/UsPo6P7yA84EtkFs/ApmoVNnwcDjB4opZHHpfSZFO9KRb
	11pGGzkS+umgx7PcIHSo1fuS/+BdyeGQ29LNS4ryzOrkIZ2DUaZnZAWktltCk+lX5fu4USpt+ia
	2CtILTkID6SA2j3IzmtdKZLwSHHJIqbnFsn4hD5UghY1HbIteTAf6B6DtCZLGlKAwK2UeGMMm9Z
	f0BrPGhiaKjnz7FOIf1VVwBq+NKp/EYO4IfbmjpC10QN6anNLrzx2RQzKQ5+DJ7viex5hsOxbPf
	oebwsBRgKLXTwiyDgcSEllRChD
X-Google-Smtp-Source: AGHT+IF3AjXGyHtxPeuaeB1B33R8h4DcIFMmv/CIu77BJd2s9WOMRipvHjQ1kYHQ7V9Zi5jD2ZfB7w==
X-Received: by 2002:a17:902:fc4b:b0:269:7840:de24 with SMTP id d9443c01a7336-292ff8e10damr1991205ad.21.1761061544808;
        Tue, 21 Oct 2025 08:45:44 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:87f4:6771:a0ef:9e8e])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-292471d5938sm112628365ad.58.2025.10.21.08.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:45:44 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gavin Li <gavinl@nvidia.com>,
	Gavi Teitz <gavi@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net v3] virtio-net: fix received length check in big packets
Date: Tue, 21 Oct 2025 22:45:34 +0700
Message-ID: <20251021154534.53045-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
for big packets"), the allocated size for big packets is not
MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
number of allocated frags for big packets is stored in
vi->big_packets_num_skbfrags. This commit fixes the received length
check corresponding to that change. The current incorrect check can lead
to NULL page pointer dereference in the below while loop when erroneous
length is received.

Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v3:
- Convert BUG_ON to WARN_ON_ONCE
Changes in v2:
- Remove incorrect give_pages call
---
 drivers/net/virtio_net.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a757cbcab87f..e7b33e40ea99 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -852,7 +852,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 {
 	struct sk_buff *skb;
 	struct virtio_net_common_hdr *hdr;
-	unsigned int copy, hdr_len, hdr_padded_len;
+	unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
 	struct page *page_to_free = NULL;
 	int tailroom, shinfo_size;
 	char *p, *hdr_p, *buf;
@@ -916,12 +916,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	 * tries to receive more than is possible. This is usually
 	 * the case of a broken device.
 	 */
-	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
+	if (WARN_ON_ONCE(offset >= PAGE_SIZE))
+		goto err;
+
+	max_remaining_len = (unsigned int)PAGE_SIZE - offset;
+	max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
+	if (unlikely(len > max_remaining_len)) {
 		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
-		dev_kfree_skb(skb);
-		return NULL;
+		goto err;
 	}
-	BUG_ON(offset >= PAGE_SIZE);
+
 	while (len) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
@@ -941,6 +945,10 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		put_page(page_to_free);
 
 	return skb;
+
+err:
+	dev_kfree_skb(skb);
+	return NULL;
 }
 
 static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
-- 
2.43.0


