Return-Path: <netdev+bounces-299729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qZYTHALRMGqMXgUAu9opvQ
	(envelope-from <netdev+bounces-299729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:28:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D30B868BE62
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:28:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=EIFJnLpT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299729-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299729-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC6BD301A428
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8161A3C5538;
	Tue, 16 Jun 2026 04:28:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1FD3C81B4
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 04:28:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781584128; cv=none; b=d0ftGg23gEYMD1AtmvSTYtiBSTwheMP3sxWAnavpzWzIlWrqPAdkXEuUl4fZR2Kq5vvFMEBNoii6cymICqra2H5Hdx1J8Rv6RGsJS76yZt9IazLIixBFZHmZrNfR1a3TAGH/Kry9WK16Nul3wS9ACV0fY/oJqm40PvmQzYb9WGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781584128; c=relaxed/simple;
	bh=iSnCoy0wOHnjTetJKmG/nh8R5MUt1SEexf5yDRqPPro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ax9MpSQzoLBzO4LCvmUZB9ATckkz2sYhW2DsVI/BoanuIQ8DFX2aaPlvmB6cmti1DpE38qZUeg04vq5gLbCclv0p6s4NwyJgsPpVxA8IGrj4q/v2mU7oks2ySkGHgzs1464lW5npQA4Ynhp3PddaFgD/DOWGAZzYrIyV8dsOGDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=EIFJnLpT; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36ba3ea5c46so2352053a91.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 21:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781584126; x=1782188926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+s4R842SAMDVeGmCPYwOESmnuBNOdgsUtTVh5NI/emg=;
        b=EIFJnLpTZBCcq5alsJF8JAYyScIc9SkIQbZk9cXvZWk/SCcoO9iTmvQ/UOLGbnozW7
         d/HXS9CSqJSUjddGGC/mpvzYZPG6qWWsY7Jn72piEEmGoEkNVE3p8RUf9578wIWl1yc6
         737nsA36nMm4NaoqmEES5EJF9H5/IaDCXWCxlWIOiqeYhrJlzuPp2PAjJGGGRXTJTrSq
         9bUi6slKn5yNo7fmnHyBBN8L9zBM2OTMRXCfVhkSlZ9eNQv56ibc1HerLc/SZKFNfJNA
         aU8gcEepmH8/1REt3qBdBVGLZZR+FUHMq415ed6KhlDzCyjudCQxGsao95Hd/MztMWtV
         Upww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781584126; x=1782188926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+s4R842SAMDVeGmCPYwOESmnuBNOdgsUtTVh5NI/emg=;
        b=jU+9xasu59sskyruRW/2po3ddqGKkAHsQ0iM/Fmz8Hbq2kHpwUC8xUeyvuavnfTyxs
         cs1xPNhDpDRrG442/A1dg1bA39d8p1Lz1oMOgLnJvadE7J4Z2tcTnUMLScNw9d2s5f+b
         4kz9uNs7B3AH4RQocFUjOCsFZH1/HPx1r/EnMvhDJWLk83fqnMb6SWszqWz6wRMHXov3
         i5kOGeTSueDMXe728eWpT+ZHrDL+7ZOJpELh3sO9FmX0n+enRUSV/sk9eM/Fqfj2kFpb
         WQWicGon0O7hd6QazGtFshoftAiSIR0A8WzcNxCHVVv2SkPf0QWWZSWz4+7VJqn4+Lxo
         +Nxg==
X-Forwarded-Encrypted: i=1; AFNElJ/ip0XZKa2pL28zI2tYVBtLW5tpBBj/XZuve0Glswn9CogeIOlQH12u5cZn2NehZWrzzIpUMLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5jgywfoK8O/vFWkyUAD+tqYPOdh5l2IC2oPxEjGJOtFgD05xv
	ea/50h+uKfkh/5yH93oiONmz2vMdmej/uFd1+ObdDlRvrjpdioDdaCjwmAZLkfdL1efJez3bvXf
	ld/+c4++H
X-Gm-Gg: Acq92OHOnAxOK8Z9LRxjeWBBbfzOuIfABG+4wXl9qU59m6BZ4dIrDLUf45zbzn9DEsv
	3PtNFgp7YgNS7BmUYq1MDMtkGD5gPTbeJl2cCqSclOtDOT4J3mVoDt2XpW1czy4MLtJbsDA7hLq
	SYaGqdPKhMiMBfsAZ8fZQVjYxvXtb6zR8cAVmw7bR3lnvWATEJW/CcPNAQfNEfiF0eXIGtgp2Qk
	L4yF62FVGOy8M1SAu8kfqxr8nZaud8DWZNIZLQAgRURS45LvrCfXD89o1fuwt4RHmxzoqzHblgK
	RBoHrKsA7xvRWbWGq4cWPR8+d5t0E5n2pgE7n+Mjj2MKj79QJ+fdOBMva0C8bYNF+gq+mpaxYhm
	5gRtu5DeFBTsbVcMMBJGeIYI2fqadi5ZXAZC4YM7ia6JcKpJUOPNq2QWUVIVjbpcCtwE2FqvpZH
	/zenkG
X-Received: by 2002:a17:90b:58c4:b0:35b:9894:f6f9 with SMTP id 98e67ed59e1d1-37a040adfbbmr17185832a91.18.1781584125653;
        Mon, 15 Jun 2026 21:28:45 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c5208fd0fsm1244221a91.0.2026.06.15.21.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 21:28:45 -0700 (PDT)
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
Subject: [PATCH net v4] virtio-net: fix len check in receive_big()
Date: Mon, 15 Jun 2026 21:28:37 -0700
Message-ID: <20260616042837.2249468-1-xmei5@asu.edu>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,gmail.com,asu.edu];
	TAGGED_FROM(0.00)[bounces-299729-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:minhquangbui99@gmail.com,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,alibaba.com:email,asu.edu:dkim,asu.edu:email,asu.edu:mid,asu.edu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D30B868BE62

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
v4: use easy to understand math to compute the max_len
v3: revoke 2/2 and add Xuan Zhuo's Reviewed-by tag
v2: add additiona check as 2/2

 drivers/net/virtio_net.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..8f4562316aaa 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1999,15 +1999,16 @@ static struct sk_buff *receive_big(struct net_device *dev,
 				   struct virtnet_rq_stats *stats)
 {
 	struct page *page = buf;
+	unsigned long max_len = (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE -
+				sizeof(struct padded_vnet_hdr) + vi->hdr_len;
 	struct sk_buff *skb;
 
 	/* Make sure that len does not exceed the size allocated in
 	 * add_recvbuf_big.
 	 */
-	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
+	if (unlikely(len > max_len)) {
 		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
-			 dev->name, len,
-			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
+			 dev->name, len, max_len);
 		goto err;
 	}
 
-- 
2.43.0


