Return-Path: <netdev+bounces-297846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mLkyNYrjKWo6fAMAu9opvQ
	(envelope-from <netdev+bounces-297846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 00:22:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD7166D2F1
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 00:22:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=BizEUZZW;
	dkim=pass header.d=redhat.com header.s=google header.b=rbvTSUjv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297846-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297846-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FE49302DFB8
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA29B33507C;
	Wed, 10 Jun 2026 22:21:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908829C328
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 22:21:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130118; cv=none; b=SBre86YciwAtQXb52EGwtBQeieOkMx8VeI/XRdNCVjMIciuZXJnGuB601utapxEcyJ6nKXraLoH6jfTz/H5E9ZC2eW7lSCQ/5enyKKn7KufPW/Ew6JUw2RmK/8MlQw60kMXj/lE+D1sznNCZeK0K1zHMtJ2U5IN4f1PbxZM8770=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130118; c=relaxed/simple;
	bh=8u+7DTzELirNm6wHvKOIo1/nebvVCwekSoFgUO2K8oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awgBaa+OxdE+UHXFLxUVN5+KajG7UiHKTd4czntdxxaR8imRxBt2uAksQ8DSIRAglTgWLFNEUpXN0wgsNzMgYBrHqqrCQnYplumr6goT3Uc1iuXYIAAQXVwSXNh/JGqkbiONiRUcSO5dW1eGkV/5kHZPtmQ3xBX25nShGSA0Kx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BizEUZZW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rbvTSUjv; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781130116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3XNDDsRWPntbc74MBmHORM39yXNnRzhKg57vrlJiACo=;
	b=BizEUZZW/Rcskxt6Wjuchpilmg87ygJOlp313AnpYpuhCswnLPbIG5eGH/8Ke5HDZZtVot
	YD+u5t7IlqcTfmlQKECtAL9eFuW9JUTVdtVHrPDI0HJOlN1iZcwZpuArP0tTwUWCdAGUUd
	GoVAKDhnZRGU+WjrREMORLu0fQdAdZo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-wrydmmV5OiyjknSrPYWIQA-1; Wed, 10 Jun 2026 18:21:55 -0400
X-MC-Unique: wrydmmV5OiyjknSrPYWIQA-1
X-Mimecast-MFC-AGG-ID: wrydmmV5OiyjknSrPYWIQA_1781130114
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b37e1f47so62681425e9.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 15:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781130114; x=1781734914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XNDDsRWPntbc74MBmHORM39yXNnRzhKg57vrlJiACo=;
        b=rbvTSUjvYnOAR0mFeUoMPoI7GXInjhe1Zim9VhHOarHcqOKSrEpVsfv18zjJ00kCY8
         nVzBYXeGqIr8na29+bVOTQ403aeW0wVaDWK9KkiNaSwbzJi3mJi6aBMcOA+X4vyptvG1
         fOnxnxVVHxQazD060MxGo/tmZ+Y88zdfmtqGgZHF4kYT2jImTLDETn+DczmHJgQ+4ija
         dU+rqv7h9y0J10ygg5W51lVCU9JYaOwmG193ptAvMwg973K4BWZzPzui2FKM1TmaiEjs
         VRuB74skxYJsNHJiE/zRKqbhNXoT2psH0eidm5NjRrZ6DpV/PBJJvSw44oV9rknzhtBR
         Hb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781130114; x=1781734914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XNDDsRWPntbc74MBmHORM39yXNnRzhKg57vrlJiACo=;
        b=mHbnqMqQ7r2uNyFsTESDKVd/5AJggDD4VYDX33b/Kg1r7TVYTrfCmm2Qba5caHGYsx
         pM2GNnTJTRKhyMSiNMmKwOJQQRIEek6TZRZ3LpoFYXMK14DXltZRxLyc+IEJNCX7TUB6
         t7DFF/IyCc7UufswzgRWexc4jjk+ZIkUdZ/zvpzzstdZPHECaEwlxxOgnSW+q37n7o/q
         47dV+j58R5H/1vtK/wUDGM6xu7qP3P9cZLLJf1fVuxIQiIj87t9laRrlxmMyL1q4M4WO
         3UXOZYicHvIpOCn3HFaZ3BrXJFIQ8il7FhgjMJLxogFA6BWfGxXvgtPEIFfNHTdfrors
         PkZA==
X-Forwarded-Encrypted: i=1; AFNElJ9ShFuVheJ+oNVeZbYpbp/gcXgHoCDJrVKBIQTaoHqr1Up5SeFlAcRbDHSxgV10m8W9S54HQw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKFc5AgCSBMbqI446lqWkxOhOnrrobJqG6Rrvhs28+YARqoKRU
	u7GeMJwtGhEf1a37y3gKyj0USz+f9RKKuTOWtblCsmnkvNjOi+e5FTwiTunRWHHC36ZDZ9FJ/Hu
	pYtjaWNkXvrfjjei/lmlu7VQY2LtttxRojqtBO0AlwlV1QZsukQO/lgEoUw==
X-Gm-Gg: Acq92OHGPxZOU/3YQ1WL0GP5E4W905lpC9MOA+5rttNJmeUQHG1U4TbpPpmVKnpWwSW
	8He2HcVHeP+oqHcYXCWMLKaeVYwJCGFUh9c2f6uCgYzF4DYy2s1b9P5F8Zgazt1piLFNa7XRARQ
	cUqKIax27abkhs2TNqnrJehtaafpEBIVVJTrO2+tAK+Ep7ViMHejPt6oqBdEF+Xna7UNDQaA8Z/
	TNWlHbFHdbPxpkxZNpwg8t0E0MVwR6jDYQMRNAhKIg1Bw0CLwDN2G94pD922fP2B89zs+2YCKjI
	8ZZFEB6m62lQ8/3BoMZiWEJykighcOGTMy9JK92QC38vfI5Dbu6NuFVPUHGX+X/ykItiN1aayhU
	i0ZU0ZO+lhZkJwyjQdsYnVzKWsmoIG4kMY3nVCTJMKbpAQhV5KsikPQ==
X-Received: by 2002:a05:600c:6087:b0:48a:8b02:ae91 with SMTP id 5b1f17b1804b1-490c25b0231mr459511025e9.11.1781130114013;
        Wed, 10 Jun 2026 15:21:54 -0700 (PDT)
X-Received: by 2002:a05:600c:6087:b0:48a:8b02:ae91 with SMTP id 5b1f17b1804b1-490c25b0231mr459510675e9.11.1781130113557;
        Wed, 10 Jun 2026 15:21:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm74431249f8f.0.2026.06.10.15.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:21:53 -0700 (PDT)
Date: Wed, 10 Jun 2026 18:21:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	minhquangbui99@gmail.com, bestswngs@gmail.com
Subject: Re: [PATCH net] virtio-net: fix len check in receive_big()
Message-ID: <20260610181911-mutt-send-email-mst@kernel.org>
References: <20260610221606.1091465-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610221606.1091465-1-xmei5@asu.edu>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297846-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:minhquangbui99@gmail.com,m:bestswngs@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org,lists.linux.dev,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FD7166D2F1

On Wed, Jun 10, 2026 at 03:16:06PM -0700, Xiang Mei wrote:
> receive_big() bounds the device-announced length by
> (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> add_recvbuf_big() sets sg[1] to start at offset
> sizeof(struct padded_vnet_hdr) into the first page, so the chain
> actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> check allows for the common hdr_len == 12 case.
> 
> A malicious virtio backend can announce a len in that gap.  page_to_skb()
> then walks one frag past the page chain, storing a NULL page->private
> into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> write past the static frag array and a NULL frag handed up the rx path.
> Bound len by the size add_recvbuf_big() actually advertised.
> 
> Fixes: 0c716703965f ("virtio-net: fix received length check in big packets")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Let's instead (or additionally?), bound the frags array index.

Seems more robust.

> ---
>  drivers/net/virtio_net.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..afe73eda1491 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_device *dev,
>  				   struct virtnet_rq_stats *stats)
>  {
>  	struct page *page = buf;
> +	unsigned long max_len;
>  	struct sk_buff *skb;
>  
>  	/* Make sure that len does not exceed the size allocated in
>  	 * add_recvbuf_big.
>  	 */
> -	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
> +	max_len = vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_hdr)) +
> +		  vi->big_packets_num_skbfrags * PAGE_SIZE;
> +	if (unlikely(len > max_len)) {
>  		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
> -			 dev->name, len,
> -			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> +			 dev->name, len, max_len);
>  		goto err;
>  	}
>  
> -- 
> 2.43.0


