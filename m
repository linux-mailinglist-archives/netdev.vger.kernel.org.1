Return-Path: <netdev+bounces-270599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBoEL5x3wWkQTQQAu9opvQ
	(envelope-from <netdev+bounces-270599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:25:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 439DF2F9E30
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 163D6333F612
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B973659F7;
	Mon, 23 Mar 2026 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHYA9YIn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mWGWWEnT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C627A25392A
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281160; cv=none; b=TzUKwwA6/qnt4UePEseIRYzDWBmW0rVpYDUiLXFuinbqCXsSKH9Hc+buflzbP9+Z/BsAbbokxXLUvHzRmAp5rWitMUFFPSaCAfDw57ddqTSZzux3LaViYlaQ7WYbW3Z7OH/l8D8xzNqdvgIPrikfqR3kjmJP5Yl6XaVrfM2xHL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281160; c=relaxed/simple;
	bh=Wwsnsa8I13/EF4kOLN75rRcu9F+2YoHsOAAnaEjJ+F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeNicAwdzxzNqwyZt6tCRlWfXFoGoPUf9G/u9qL961HvMj10CF5DVbVuwEJuumOZk/pwmFWuA0tvNwo4ccQzai3ikbCtEUQZUxvlWERhggSoh1nqyF3dy0NKVsvDbk9ZRLBkJbYmkxvHxLoc/JZcE1qhn1PcWhH+BNDS9d6IGgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JHYA9YIn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mWGWWEnT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774281157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SRzimLRML1I9K6FsP40IwKIHIhW+1XMgF4uRnLLyEos=;
	b=JHYA9YInZy0Gloxg6hyVkq8eUFMN++l8cdC5nOJhxjzsEayzZB6RvtMdI3iBPR7JwqA0vJ
	4m5MloB/h8iZfkyftg6IttDbs7yldAigUTgsC2505vf/nLn4gPZAlRuqNDi2OH+xiDGbJq
	oyPfl0euM1Ejj7byzlsmEvtL/WljvSA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-jYWE-FIhMVC3VMUIWCD9Lw-1; Mon, 23 Mar 2026 11:52:36 -0400
X-MC-Unique: jYWE-FIhMVC3VMUIWCD9Lw-1
X-Mimecast-MFC-AGG-ID: jYWE-FIhMVC3VMUIWCD9Lw_1774281155
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso16331805e9.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774281155; x=1774885955; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SRzimLRML1I9K6FsP40IwKIHIhW+1XMgF4uRnLLyEos=;
        b=mWGWWEnTkNt44dS5MGYMVIM7mYUE176EwGRiirdeLO13cyVhNEi55hQSYfYbv5uVt/
         F1ZKxeoBRQsVZLx8HXLMwBeitBmrkvencA0Nhf5PTX2/LFKDVuNQgoKcZEfFvHqSSEv2
         QhpRey56ZVvaDoUcgqTn07KFnv2hLXCM000Z+r79K+tUvOcGGxp+nVP9/2tNi52fkzLr
         STjXH7IIO+GRp37Jn12AaOpAzbR50wJmcM+orsUJYs1PML/PtLnhRwaYyeBMkLEWHRE0
         NwozIoLarkl7ZwrJuzLgrzQ/hDu4DwchI/A4hWB3s9CrgBINcWAiE/S4SkQHVgKi9TsO
         zUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281155; x=1774885955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRzimLRML1I9K6FsP40IwKIHIhW+1XMgF4uRnLLyEos=;
        b=rUOPIB8+nLrVSnu9OiQxKladXfEIpWkZTo/q/anCyeNZWAb67kdWPc6daHu6aAAMYm
         FW1x1nQ9pfPfbpfC2OpbhAeYwDCWa60PwgtfOjjtqqXOySFK3+lrhVcU/HrJHKa/glnS
         f8GwGXdkOWS3ZyPJJKsJzcizmyQG/XVIIx0h6m74jGFpM/j/4OHWx4CAcoG/ED5GO4ry
         GAgYHkxDjBlhwjSA9lur2uOSL+2skZamAN258WXOO5DLTwuIv332NC9kfV0a5Y58fmt4
         umoAuu+z8RwabbEBKFcmBeoCcdG8mtvWGpkuGCyTcT+QUl4NlcTE+twIWFgBR0kxLBcB
         4wBA==
X-Forwarded-Encrypted: i=1; AJvYcCUIjvNVrtA7wiNHozx3Z8SFOHHmKGl8ufB38ThnQQ0yKxysQoCC5CMN0K51p5y2U9Mxy0SrTDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXJEtawTmQIKH3LeSAbS2glb9aWVN/5rxCzzzTnCTtOHGJTxxd
	18+C7nwTZCS58SRIzF04qru7dSY02bz5OZla3sqp4/C5+YJqWHdqZ3xtLo6syM9IbLqxcLM3xxB
	bDPqVjVFOcLUp2VUhgVCKMgB5PeBHcOu18rf/5hjsqSGo2enTinDJanYgzg==
X-Gm-Gg: ATEYQzwK5QPNQfIZwxSyhys2rojBkcaMFiWT06172tvTdPeTSzB7egSdQpumWIwgzWK
	e/QTMIfn6C1+kiGY2AbrTb4WL+DOlu5gkx8t3ZBiIfmBnO7xUgSh1ph3S5uiUCED38H/PJCfNs1
	WL4n4EfDQyAqHp5NfFpa8mfiQGCGEK1pNrlmTsKNWG4SqJrnBSrkccJ34RacRIrgWgqby8MenHm
	3lRVYmFVSB1EjGotl3noQbYyl6tI+MiZMl735ihowGGsfZJHq70SjWJeojYA3f1rqhS1ZlF7PT/
	6FbmlhqcemYRQzWULDe8xt38SCoKo2+xbxpzFHrOjhL3XTPy+8gWjr4XQweFXHkSXnHcoJ2T16K
	eO6SBoNQbcf8rCkYd
X-Received: by 2002:a05:600c:4705:b0:485:3a86:6392 with SMTP id 5b1f17b1804b1-486fee0d816mr174481425e9.20.1774281154660;
        Mon, 23 Mar 2026 08:52:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4705:b0:485:3a86:6392 with SMTP id 5b1f17b1804b1-486fee0d816mr174480905e9.20.1774281154074;
        Mon, 23 Mar 2026 08:52:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487017210dcsm238594505e9.10.2026.03.23.08.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:52:33 -0700 (PDT)
Date: Mon, 23 Mar 2026 11:52:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>
Cc: vishs@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	dw@davidwei.uk, edumazet@google.com, eperezma@redhat.com,
	ilias.apalodimas@linaro.org, jasowang@redhat.com,
	kernel-team@meta.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, technoboy85@gmail.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for
 buffer allocation
Message-ID: <20260323114313-mutt-send-email-mst@kernel.org>
References: <20260310183107.2822016-1-vishs@meta.com>
 <20260323150136.14452-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323150136.14452-1-oelghoul@linux.ibm.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270599-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[meta.com,lunn.ch,davemloft.net,davidwei.uk,google.com,redhat.com,linaro.org,kernel.org,vger.kernel.org,gmail.com,lists.linux.dev,linux.alibaba.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 439DF2F9E30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:01:31AM -0400, Omar Elghoul wrote:
> Hi,
> 
> I've been testing linux-next (tags later than 03/17) and hit new issues in
> virtio-net on s390x. I bisected the issue, and I found this patch to be the
> first buggy commit.
> 
> The issue seems to only be reproducible when running in Secure Execution.
> Tested in a KVM guest, the virtio-net performance appears greatly reduced,
> and the dmesg output shows many instances of the following error messages.
> 
> Partial relevant logs
> =====================
> [   49.332028] macvtap0: bad gso: type: 0, size: 0, flags 1 tunnel 0 tnl csum 0
> [   74.365668] macvtap0: bad gso: type: 2e, size: 27948, flags 0 tunnel 0 tnl csum 0
> [  403.302168] macvtap0: bad csum: flags: 2, gso_type: 23 rx_tnl_csum 0
> [  403.302271] macvtap0: bad csum: flags: 2, gso_type: e0 rx_tnl_csum 0
> [  403.302279] macvtap0: bad csum: flags: 2, gso_type: e1 rx_tnl_csum 0
> [  403.309492] macvtap0: bad csum: flags: 2, gso_type: 4c rx_tnl_csum 0
> [  403.317029] macvtap0: bad csum: flags: 2, gso_type: e0 rx_tnl_csum 0
> 
> Steps to reproduce
> ==================
> 1. Boot a Linux guest implementing this patch under QEMU/KVM (*) with SE
>    enabled and a virtio-net-ccw device attached.
> 2. Run dmesg. The error message is usually already present at boot time,
>    but if not, it can be reproduced by creating any network traffic.
> 
> (*) This patch was not tested in a non-KVM hypervisor environment.
> 
> I've further confirmed that reverting this patch onto its parent commit
> resolves the issue. Please let me know if you'd like me to test a fix or if
> you would need more information.
> 
> Thanks in advance.
> 
> Best,
> Omar

Well... I am not sure how I missed it. Obvious in hindsight:

static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
                        void *buf, unsigned int len, void **ctx,
                        unsigned int *xdp_xmit,
                        struct virtnet_rq_stats *stats)
{
        struct net_device *dev = vi->dev;
        struct sk_buff *skb;
        u8 flags;
                
        if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
                pr_debug("%s: short packet %i\n", dev->name, len);
                DEV_STATS_INC(dev, rx_length_errors);
                virtnet_rq_free_buf(vi, rq, buf);
                return;
        }
        
        /* About the flags below:
         * 1. Save the flags early, as the XDP program might overwrite them.
         * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
         * stay valid after XDP processing.
         * 2. XDP doesn't work with partially checksummed packets (refer to
         * virtnet_xdp_set()), so packets marked as
         * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
         */
                
        if (vi->mergeable_rx_bufs) {
                flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
                skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
                                        stats);
        } else if (vi->big_packets) {
                void *p = page_address((struct page *)buf);
                
                flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
                skb = receive_big(dev, vi, rq, buf, len, stats);
        } else {
                flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
                skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
        }       


So we are reading the header, before dma sync, which is within
receive_mergeable and friends:

static struct sk_buff *receive_mergeable(struct net_device *dev,
                                         struct virtnet_info *vi,
                                         struct receive_queue *rq,
                                         void *buf,
                                         void *ctx,
                                         unsigned int len,
                                         unsigned int *xdp_xmit,
                                         struct virtnet_rq_stats *stats)
{               
        struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
        int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
        struct page *page = virt_to_head_page(buf);
        int offset = buf - page_address(page);
        struct sk_buff *head_skb, *curr_skb;     
        unsigned int truesize = mergeable_ctx_to_truesize(ctx);
        unsigned int headroom = mergeable_ctx_to_headroom(ctx);
                
        head_skb = NULL;
                
        if (rq->use_page_pool_dma)
                page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
                


Just as a test, the below should fix it (compiled only), but the real
fix is more complex since we need to be careful to avoid expensive syncing
twice.


diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 97035b49bae7..57b4f5954bed 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -931,9 +931,19 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 
 static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 {
+	void *buf;
+
 	BUG_ON(!rq->page_pool);
 
-	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
+	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
+	if (buf && rq->use_page_pool_dma && *len) {
+		struct page *page = virt_to_head_page(buf);
+		int offset = buf - page_address(page);
+
+		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, *len);
+	}
+
+	return buf;
 }
 
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)




-- 
MST


