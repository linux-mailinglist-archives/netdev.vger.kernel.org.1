Return-Path: <netdev+bounces-271123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Bh5JNGuwmmRkwQAu9opvQ
	(envelope-from <netdev+bounces-271123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:33:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A273331819B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3096F3030BB8
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F352C405ACF;
	Tue, 24 Mar 2026 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPvt3Jgd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTiqyWVX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC6C3D5246
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365363; cv=none; b=m9jQe/jboPWlqdxAStO34GhoEytteVVZLSMQXJpyBvpKENjx4+ISqjoH9Ld3kfpEyGVRGGcYJA02AWNEy1V2bXhAWSaH7ZR3jIF6qYBx/Jon4d4/imK75uZuov5C9wJsCn6ekX0Yl3XldlJ739yEJtO75k74QYcZmaUSkjWiq0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365363; c=relaxed/simple;
	bh=0DAQT5hcnfFP7UoqaO6an4vhVS498McC5K6b/zfmBDc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FTJ05KJYg1IpCheZyPowz2FY1+yUpqiD7kYoon5w1l+SF6hFgjT713LK5GCw/P1FtpGDJwnRSxn3pNS7oxcJCndkKyIKB7xDeV5TGSJBJPlB94on2kFpAuXy3/cWhFsU+R9Ipbz29SylmanM0gmj52Vjx+SlOTMM0kW8sF4IsOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YPvt3Jgd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTiqyWVX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774365361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=zZaZ+weNFt/DeQ+y853Qd9D2vVvyy8X2coFZA5Jbyn4=;
	b=YPvt3JgdxNP0aJ9mB3lNrPhe3LBAwhkxcsdfSmD5LbScEwcBv+gmeeXYNo6TRkHRW72uww
	ea+79So5XUR92xLsgx6V5bG0UvK2TqqQNJT6st0Al2YxcdX5mFSXeYkrc0JbhIHfZ3+72M
	kRErp8r0D58Tp4ddhWDYxv/5p4V+6PE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-lwNTobj5OwisQaz82rRZCg-1; Tue, 24 Mar 2026 11:15:59 -0400
X-MC-Unique: lwNTobj5OwisQaz82rRZCg-1
X-Mimecast-MFC-AGG-ID: lwNTobj5OwisQaz82rRZCg_1774365358
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48531e6012bso74270735e9.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774365358; x=1774970158; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZaZ+weNFt/DeQ+y853Qd9D2vVvyy8X2coFZA5Jbyn4=;
        b=cTiqyWVXW6ThVGdsO/WivvYGEgD6vRr7fw2tex9trBb2cD0cjZKTxMvfrGnfsgqqTK
         /VKFxciS1+PIN2pALJ/ziWHPHTRdfnZpBzArKkQ9NTNNCx2rQV/YSBWux1XMKJscM1Ic
         1YOh1lo3hiRKu107RYjOKZ+upuhu9sRLuh6K5EYCkVbxA+PSutogn/8UFnpN9vPm3g5z
         JpOI3uTeBvxy6aQg6DPyBrBJUSzkCTiIkoTFQvwknPUPJM8rUrwsh3n2vCEz0aXUkTvT
         LyHiWBdqED0nxjCgfZvE5wyAeRBxq0BhZ5YXK1bt60GQVk+dZDr9CcCSljExBUWlzNzM
         610g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774365358; x=1774970158;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZaZ+weNFt/DeQ+y853Qd9D2vVvyy8X2coFZA5Jbyn4=;
        b=U07QYC6D9RQhII05ySM5W3EeBoY6Vcq5koqt9DAWskg6azAAJTDzHoFID6XnSfwNxW
         Fq/y00BMoBDzSYqnZwb1OKvhphYu6LZwiUAD/vd+UfSM4SRmP8VWCHAeVeBn6bZmfyXV
         QHDNgWNntsLUOVhTiyTeEV6fzTLaZzwUvLXUXn2S0Jzm5h3sHKYrbCpNWWV87H9r08Us
         1pFYqaUlRAiMk2YXwglKwBZ6TN9rD8z3tEehynnpnulz6N/zYhbI7lJuCq+oR/7JFlBC
         6YeZ8r1rm2UzSn9nisNh0dWPf2//zoqmHfTbqjADcXligiHROSmAWQQ+tBZM8ur172rh
         xd3w==
X-Forwarded-Encrypted: i=1; AJvYcCXTIq+sXG7BTIvf3bwCDtLqkyOHAEnUZL9w7mc0VGpMH3XxtOomwTgEy446MpMSkd8P+AYbaW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF85/FAtXT4crct1YvE3SbOw6K+DhlVzuIHYZRnMtPgM9oAxu6
	baKqf3eiW9aJ51nAgl5hWt/N2VNEbjQabwlCRto8O2V4/8aRQbulJFhbSgw4byrUTM+F92aM4sN
	5SMRXealQDm83pzGhIDrmNvJ03nor5CMuCw4GCurh0Nedd0lWA49HMIoyuw==
X-Gm-Gg: ATEYQzyluUqwxCqc3hPT6wmTQAA/DiWtSaKfcU2eBqyvfQA5iRLLIm6Xl3HhI9dU0tX
	JBKOTEDRxcYku7S9k1IWse60pV6C4ZJ6L6BQlr61TCJV+dzqM7QwaoO6KMxEUy784PLZE5cFsKg
	0tHTc91GWqb3MWF8by/zR6GmKvopjigMbKlQnoDBOs1xUgR5lcBL6XZkx4rF1IyPJNdVZSlAHi+
	nMDmJliq8Ove2BYJQLF5OLNBE1KWRlZc1OCISFMbCrWj8GD50cYC6i2QxnTh1Rlaqi240//uulC
	m6fqLTi2n0/s6x01ZyB8IxSEzNdnY9DfQ6UmRbwLtam+rdyrSDlcxDZ/HgyQ0Vwzn9YvD3po+95
	OktDEVfRBxsC4OIQ/
X-Received: by 2002:a05:600c:5296:b0:486:ffa3:593 with SMTP id 5b1f17b1804b1-4871606730amr1910525e9.28.1774365358074;
        Tue, 24 Mar 2026 08:15:58 -0700 (PDT)
X-Received: by 2002:a05:600c:5296:b0:486:ffa3:593 with SMTP id 5b1f17b1804b1-4871606730amr1909895e9.28.1774365357596;
        Tue, 24 Mar 2026 08:15:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116d82f1sm55500765e9.11.2026.03.24.08.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:15:57 -0700 (PDT)
Date: Tue, 24 Mar 2026 11:15:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Omar Elghoul <oelghoul@linux.ibm.com>,
	Srikanth Aithal <sraithal@amd.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Vishwanath Seshagiri <vishs@meta.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: [PATCH net-next] virtio_net: sync RX buffer before reading the header
Message-ID: <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[linux.ibm.com,amd.com,redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,meta.com,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271123-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A273331819B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

receive_buf() reads the virtio header through buf before
page_pool_dma_sync_for_cpu() runs in receive_small() or
receive_mergeable(). The header buffer is thus unsynchronized at the
point where flags and, for mergeable buffers, num_buffers are consumed.

Omar Elghoul reported that on s390x Secure Execution this showed up as
greatly reduced virtio-net performance together with "bad gso" and
"bad csum" messages in dmesg. This is because with SE sync actually
copies data, so the header is uninitialized.

Move the sync into receive_buf() so the
header is synchronized before any access through buf.

Tool use: Cursor with GPT-5.4 drafted the initial code move from prompt:
"in drivers/net/virtio_net.c, move page_pool_dma_sync_for_cpu on receive
path to before memory is accessed through buf".
The result and the commit log were reviewed and edited manually.

Fixes: 168b61da6871 ("virtio_net: add page_pool support for buffer allocation")
Reported-by: Omar Elghoul <oelghoul@linux.ibm.com>
Tested-by: Srikanth Aithal <sraithal@amd.com>
Tested-by: Omar Elghoul <oelghoul@linux.ibm.com>
Link: https://lore.kernel.org/r/20260323150136.14452-1-oelghoul@linux.ibm.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 97035b49bae7..2f57245c682d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1956,13 +1956,6 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	 */
 	buf -= VIRTNET_RX_PAD + xdp_headroom;
 
-	if (rq->use_page_pool_dma) {
-		int offset = buf - page_address(page) +
-			     VIRTNET_RX_PAD + xdp_headroom;
-
-		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
-	}
-
 	len -= vi->hdr_len;
 	u64_stats_add(&stats->bytes, len);
 
@@ -2398,9 +2391,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 
 	head_skb = NULL;
 
-	if (rq->use_page_pool_dma)
-		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
-
 	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 
 	if (check_mergeable_len(dev, ctx, len))
@@ -2563,6 +2553,16 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 		return;
 	}
 
+	/* Sync the memory before touching anything through buf,
+	 * unless virtio core did it already.
+	 */
+	if (rq->use_page_pool_dma) {
+		struct page *page = virt_to_head_page(buf);
+		int offset = buf - page_address(page);
+
+		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
+	}
+
 	/* About the flags below:
 	 * 1. Save the flags early, as the XDP program might overwrite them.
 	 * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
-- 
MST


