Return-Path: <netdev+bounces-152770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5E19F5BC8
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 01:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87E316C180
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 00:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161C8149E16;
	Wed, 18 Dec 2024 00:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="sxsESeaC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C991148855
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482300; cv=none; b=S8uCxCYayt2IGgyiJcRVal/QVcTlhnDx8AP/Gv1Z1oTSlFXtyO/omNx+L3lWzxvSkUKH0AkZWbUf/Rv4VIBPuUC60sjluAJ3peVvl9cqXUxXWN9TgbpIVPREEAsLSfcaJ/pOKtfpHeXLILCIRFqRTNtnyFNX9RE815FAf5J90pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482300; c=relaxed/simple;
	bh=JKJzvHyt5sznHV1sOjLpEDcqYe2RMVMKXPgYpcTrlOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cam4SJEc0zQnMISQ/PpeF2VD4zuf4IIY3dCPkRC/9aZC+sqgOFWQk3Wrf1F3LCORP7wOW5XBQrSUHelfvE2ANcTSUPaSWczMGFsaIt6yuSCDmaWCWgr42QKqtqBgFuHIjqtQq4kDucYVtnm6acaBZTN6ruO7z1RbqMR18KuloHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=sxsESeaC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21636268e43so71973215ad.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 16:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1734482298; x=1735087098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhSWTqbUE9kI0iLFqMR6WJU8T9mdHQ80JyDSL7z9+fU=;
        b=sxsESeaCtk1BxmPNQVI2iZdz3i6B1mNy1NDWWhbJPybuZdoSQz9SmnRFGyeLZOJQo3
         HBrwO0neNELrip7Rc3+sEydqxUXFvzRrob7H5h+o9i/7JknmCydGKz5wyLc0ACVAl1dd
         53aTHbvALxOPrBJrvXqsvriUAbUJwGBYsDDDEimqyHDWL3trP5434/8YjgqyultchfDA
         6yaHyX68Hvo2ESo2q86+QnylAXUZQsRYzm7gRsgRi1yfFBBq8I56xkh0b3PLkyn6wCW3
         4ingwzHd9Nec/M4prDTwZcu2YFvqgXusnIN3aE6FVDPRs6hB6OnQBUde8Dq2/w7ZiDrF
         L39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734482298; x=1735087098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhSWTqbUE9kI0iLFqMR6WJU8T9mdHQ80JyDSL7z9+fU=;
        b=ur3Fwyuq0/pi6aM90TQWh//VlGqcqhyGxBJAL9I7CrA9bIJ3XtsB5/wi+qvNMd6976
         jMk2ByxjnSfIObvM2GMuDs7Z9886gvXRJWjMStCsuahM6WP2FRk2SGn1G/rE5zNGHZVx
         amROAmdGmaYmpXWkXX3FALVJezUgPtJpwXfkC6t+vwZOW1NCPbU++cv06EcEfwwFE0CB
         Mi96sKCvimnIA4acihVCqgVEomWSYtaWO5USjpzlWbocvt2QeigsaIpilixxNXClu1H8
         beQOn5NfPZh864hLWO2kNJgSoznv9lxAlU+RpxNWFUCvzKikV6VdAfgmMMeVfxuTnqc/
         2bSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj5Q9pPPcHJug3Pqga1tCIu9ZWfHSI+n1svh15ID3l8Y5Z8DKCx5oE5z598pAf/CGPosi9Jj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjGM+eEYVYqQmqiZuJxYmG/b/D12gFrVdGgkNz/Ww0D9q0VCRj
	AluKJHqE1JDcoitRkJvWc5dRrr/liItiNDEWW8zczVfXQBOhsBuVDowAKI73FgI=
X-Gm-Gg: ASbGnct11pFRVnY5PNLxTHbDxg2ytE0ALb1V5IjktTsO5nvmKvUsbPB99k+wJSGlCuR
	XMXm9G+aI5cP6fmxjFQmqrmth97qIrLG6Uk/w00/Gqgt1jYjyAzDNMP9lap8dcnBX2jrggtuXPn
	NMigxV6M17Vr+37symaCWzE3/QaANg+rbE+wdLP65sedOtSGHN/0s8zLuzNBNIsWFqEaZzyZS9K
	lK5sdaES0VraZe1/8b51QDeHqsXgBl4oB6VmmLJ
X-Google-Smtp-Source: AGHT+IGue6sNC7s3+IMK5xCRtkElyUkrFt1nXyfkNZq489VEfSmxfnyMXPvKqFVicKTKOfcl3zjMmw==
X-Received: by 2002:a17:902:db0f:b0:216:3083:d03d with SMTP id d9443c01a7336-218d7247a16mr12881395ad.44.1734482297508;
        Tue, 17 Dec 2024 16:38:17 -0800 (PST)
Received: from localhost ([2a03:2880:ff:b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e728c1sm65113635ad.278.2024.12.17.16.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:38:17 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: io-uring@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v9 18/20] io_uring/zcrx: add copy fallback
Date: Tue, 17 Dec 2024 16:37:44 -0800
Message-ID: <20241218003748.796939-19-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218003748.796939-1-dw@davidwei.uk>
References: <20241218003748.796939-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pavel Begunkov <asml.silence@gmail.com>

There are scenarios in which the zerocopy path can get a kernel buffer
instead of a net_iov and needs to copy it to the user, whether it is
because of mis-steering or simply getting an skb with the linear part.
In this case, grab a net_iov, copy into it and return it to the user as
normally.

At the moment the user doesn't get any indication whether there was a
copy or not, which is left for follow up work.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 io_uring/zcrx.c | 123 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 117 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index ffa388fbb1e4..92b4d91f97f7 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -7,6 +7,7 @@
 #include <linux/io_uring.h>
 #include <linux/netdevice.h>
 #include <linux/rtnetlink.h>
+#include <linux/skbuff_ref.h>
 
 #include <net/page_pool/helpers.h>
 #include <net/netlink.h>
@@ -123,6 +124,13 @@ static void io_zcrx_get_niov_uref(struct net_iov *niov)
 	atomic_inc(io_get_user_counter(niov));
 }
 
+static inline struct page *io_zcrx_iov_page(const struct net_iov *niov)
+{
+	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
+
+	return area->pages[net_iov_idx(niov)];
+}
+
 static int io_open_zc_rxq(struct io_zcrx_ifq *ifq, unsigned ifq_idx)
 {
 	struct netdev_rx_queue *rxq;
@@ -145,6 +153,7 @@ static int io_open_zc_rxq(struct io_zcrx_ifq *ifq, unsigned ifq_idx)
 	ret = netdev_rx_queue_restart(ifq->dev, ifq->if_rxq);
 	if (ret)
 		goto fail;
+
 	return 0;
 fail:
 	rxq->mp_params.mp_ops = NULL;
@@ -453,6 +462,11 @@ static void io_zcrx_return_niov(struct net_iov *niov)
 {
 	netmem_ref netmem = net_iov_to_netmem(niov);
 
+	if (!niov->pp) {
+		/* copy fallback allocated niovs */
+		io_zcrx_return_niov_freelist(niov);
+		return;
+	}
 	page_pool_put_unrefed_netmem(niov->pp, netmem, -1, false);
 }
 
@@ -668,13 +682,95 @@ static bool io_zcrx_queue_cqe(struct io_kiocb *req, struct net_iov *niov,
 	return true;
 }
 
+static struct net_iov *io_zcrx_alloc_fallback(struct io_zcrx_area *area)
+{
+	struct net_iov *niov = NULL;
+
+	spin_lock_bh(&area->freelist_lock);
+	if (area->free_count)
+		niov = __io_zcrx_get_free_niov(area);
+	spin_unlock_bh(&area->freelist_lock);
+
+	if (niov) {
+		page_pool_fragment_netmem(net_iov_to_netmem(niov), 1);
+		page_pool_clear_pp_info(net_iov_to_netmem(niov));
+	}
+	return niov;
+}
+
+static ssize_t io_zcrx_copy_chunk(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
+				  void *src_base, struct page *src_page,
+				  unsigned int src_offset, size_t len)
+{
+	struct io_zcrx_area *area = ifq->area;
+	size_t copied = 0;
+	int ret = 0;
+
+	while (len) {
+		size_t copy_size = min_t(size_t, PAGE_SIZE, len);
+		const int dst_off = 0;
+		struct net_iov *niov;
+		struct page *dst_page;
+		void *dst_addr;
+
+		niov = io_zcrx_alloc_fallback(area);
+		if (!niov) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		dst_page = io_zcrx_iov_page(niov);
+		dst_addr = kmap_local_page(dst_page);
+		if (src_page)
+			src_base = kmap_local_page(src_page);
+
+		memcpy(dst_addr, src_base + src_offset, copy_size);
+
+		if (src_page)
+			kunmap_local(src_base);
+		kunmap_local(dst_addr);
+
+		if (!io_zcrx_queue_cqe(req, niov, ifq, dst_off, copy_size)) {
+			io_zcrx_return_niov(niov);
+			ret = -ENOSPC;
+			break;
+		}
+
+		io_zcrx_get_niov_uref(niov);
+		src_offset += copy_size;
+		len -= copy_size;
+		copied += copy_size;
+	}
+
+	return copied ? copied : ret;
+}
+
+static int io_zcrx_copy_frag(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
+			     const skb_frag_t *frag, int off, int len)
+{
+	struct page *page = skb_frag_page(frag);
+	u32 p_off, p_len, t, copied = 0;
+	int ret = 0;
+
+	off += skb_frag_off(frag);
+
+	skb_frag_foreach_page(frag, off, len,
+			      page, p_off, p_len, t) {
+		ret = io_zcrx_copy_chunk(req, ifq, NULL, page, p_off, p_len);
+		if (ret < 0)
+			return copied ? copied : ret;
+		copied += ret;
+	}
+	return copied;
+}
+
 static int io_zcrx_recv_frag(struct io_kiocb *req, struct io_zcrx_ifq *ifq,
 			     const skb_frag_t *frag, int off, int len)
 {
 	struct net_iov *niov;
 
 	if (unlikely(!skb_frag_is_net_iov(frag)))
-		return -EOPNOTSUPP;
+		return io_zcrx_copy_frag(req, ifq, frag, off, len);
 
 	niov = netmem_to_net_iov(frag->netmem);
 	if (niov->pp->mp_ops != &io_uring_pp_zc_ops ||
@@ -701,18 +797,33 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 	struct io_zcrx_ifq *ifq = args->ifq;
 	struct io_kiocb *req = args->req;
 	struct sk_buff *frag_iter;
-	unsigned start, start_off;
+	unsigned start, start_off = offset;
 	int i, copy, end, off;
 	int ret = 0;
 
 	if (unlikely(args->nr_skbs++ > IO_SKBS_PER_CALL_LIMIT))
 		return -EAGAIN;
 
-	start = skb_headlen(skb);
-	start_off = offset;
+	if (unlikely(offset < skb_headlen(skb))) {
+		ssize_t copied;
+		size_t to_copy;
 
-	if (offset < start)
-		return -EOPNOTSUPP;
+		to_copy = min_t(size_t, skb_headlen(skb) - offset, len);
+		copied = io_zcrx_copy_chunk(req, ifq, skb->data, NULL,
+					    offset, to_copy);
+		if (copied < 0) {
+			ret = copied;
+			goto out;
+		}
+		offset += copied;
+		len -= copied;
+		if (!len)
+			goto out;
+		if (offset != skb_headlen(skb))
+			goto out;
+	}
+
+	start = skb_headlen(skb);
 
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		const skb_frag_t *frag;
-- 
2.43.5


