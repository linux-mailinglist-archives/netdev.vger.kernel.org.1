Return-Path: <netdev+bounces-297859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OBe3EGnzKWoSgAMAu9opvQ
	(envelope-from <netdev+bounces-297859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:29:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C78C66D610
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:29:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=FgOLSLxO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297859-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297859-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39D7530C61D9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 23:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E945937AA8C;
	Wed, 10 Jun 2026 23:29:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BCA2E62B4
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:29:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781134181; cv=none; b=KU8gssNoN3D++F0TivAaPjGUF0qIn2ZwTUkAakS95vjntuW0wYkUXWbn10BYsAlMsl2PL0hied5ekLRDTvlmQ+Im43TR2iST4XjNfSzG2P0Id314ELIcqxSao6AcWv6N03m73lnMrdHwAGDtlG5aLZ2z9lOCxu1rFzFj+EtedAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781134181; c=relaxed/simple;
	bh=Carb3XjtLMPHcKqqNNU+dx1HRxViKGZwKDmTu+m4y6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WJILEQlpRvLVZYpuBKGnwQIc/cta/JAT5A6/4G/h1EY1EEqYTpRwedtft3I3Eq9YVJ7I2yEQJhSTsj0BJCoWDRDzeej08qjIz1ke4Wt//b/V4iENhYyvmCXc56nsAAadRt6kUi6+fOZ9ZEIc7OQ41A66bDDZIz1ad1qstbgwT58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=FgOLSLxO; arc=none smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf114b0cf9so68300235ad.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781134180; x=1781738980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p3EZxNZCKPnvfyZdjPI6P5IIxCOG1yzfw6sAqZhgFRQ=;
        b=FgOLSLxOPhkVv/vcGF1QxlRJfj+1TPSOviA8ckqwSje0sbkoDPcFe5oPNO7rwxu1/8
         kqk8KacA9BlSn26soSZdgz+4aUhIJcu/UHbvdq7KO76G606WxlNvM2L3afhC4gHE1GDq
         nxLbeFT2BbViT+BpEqv+uut8H2a7iAiJVte+O25vHZxw+RpCOXo8tmvxZYO687H34ecs
         faWdTAjFV5pMj/eZ9MkVj+REeiqsnPgS/g/cxLs0mkKdOqCP2sir+g0aeCvqsIJLW5X2
         aBVXFCA0O3e4iDiIGzQfHVJPK3emyxA2P0bUf2vIwj8u3GveBd0MSsVT51nUYyo/zGNC
         KIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781134180; x=1781738980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3EZxNZCKPnvfyZdjPI6P5IIxCOG1yzfw6sAqZhgFRQ=;
        b=IWCLIDgt7BgXpovVXiOqmGpfiDXL/IB1Pre7HJdWbnOW8HnnvQIGClotRWTZXZt2KW
         ouQFLV8orvspObbKxmMEF9U3kQnIwY2lfnwHyWF4WHq15Bf8Qeegq4tfe7p6q76Pttyz
         M//WLySNYEBBzf/cQvENAw1UF+6A8SbjutD65FcK/lwF2NvSg3qiosHBkufUltIYzBJG
         34k7rXO1M0c/0a0hO9zYJNHnkjfXY+Wow+vUsLKpCPl8MloNGyc2d1EGC2rEkES+hgrk
         G8ej47c//H2BHzGB+2sGf1DjTrR6EvgdD8gF2CZh29oFOENTkMjXlm9bo+pYdFjFLqqR
         S1NQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gkcLoSiPB66xu40FI4I/7KU5DFlKq7tdE1Z70cBnV7YX53n/SW6VnirLSPZIoq2J/2worGHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrnOdLGiWcJfbtD8/kFBH4QNkMMz1IE9Gy2sqKWihK7rUey/Yw
	nBgcsuP7jsYN0Sfp5m2E6Z5OV+QXjdFuhEoce9fTOSBw4kLnRwSkDhvYgzNl6DsMJg==
X-Gm-Gg: Acq92OHQdVi/M+oBBU6O+GHoxd71dX7L+72Fzg+Vr0orfJUYaJpp2+diF+dqklDvRNg
	0DIayHnGbZdbzmxEJ/fEEMjmm0solzvwIgiy91LQtPQzD3L/Ylyze8fKXfrP5Wk0CL5VzgmzRnA
	JCI3Zm8EDwgu6XEzB3HBnfqhN8ZYkiYJciWSqB0tOFnbLEnZ7N8UnNYMhxolpkqySVTTkq9ICrf
	9vzDLkELcvkBIRtsPRHMYKlgtASxa9vUsuiqbpeaN2Q3Pxy9RBwHW6Z1p+0rAM5K6tvLXY1Ok9r
	uxfjyVgnY6N6uwAHqsRx35iOxTJ8xV09rn0/qx6BCVwIyDxki8Bh7WTN/fZt/mSAoct62cUQzJ/
	omBx9puM8yIroezd+fhtNSM0QzpuIMw+2B0AI+Hl5S+103KcQQd0PBw3sTdeWGs+6rXVij482OK
	vpAzMGksF6xOQSwfxLQiE=
X-Received: by 2002:a17:902:c94c:b0:2bf:1e59:d99 with SMTP id d9443c01a7336-2c2f04403a7mr1546005ad.8.1781134179621;
        Wed, 10 Jun 2026 16:29:39 -0700 (PDT)
Received: from p1.. ([2607:fb91:1582:d2f1:7bbf:a7c4:749b:120a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d090sm242781845ad.55.2026.06.10.16.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:29:39 -0700 (PDT)
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
Subject: [PATCH net v2 1/2] virtio-net: fix len check in receive_big()
Date: Wed, 10 Jun 2026 16:29:35 -0700
Message-ID: <20260610232936.1176094-1-xmei5@asu.edu>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,gmail.com,asu.edu];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297859-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C78C66D610

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
---
v2: add 2/2 for robustness

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


