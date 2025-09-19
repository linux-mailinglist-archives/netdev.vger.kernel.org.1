Return-Path: <netdev+bounces-224684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C9BB88539
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EFDE7A5E1C
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 08:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AA030496B;
	Fri, 19 Sep 2025 08:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLh/Vt9C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8C32D77E2
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269242; cv=none; b=Y6keOI5SrynEUR4Hwdp7jcUUeCFIntobv5zjmu1UB8lqR+WOs+LRqa7RKeo3Xp+PzrMNBUDUC2t6GvIzM5UjZfTfPwcOjc21XC6DB7Cj240AZ9ZixpXxbeiy/KWXCs9a/5TAVFC2ZszJ3UvXmgJz2ndt9gw2Zg8iB2RV/bpaZlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269242; c=relaxed/simple;
	bh=tBNH676IQPThHfYpAKjw3vV8GDNLK4A21I6JHi5JUXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FugcDX6nm70CPpCjAksNqpEPKa8QZKaiKf9zDb1n9vRONVENkhx89KIGuiN3U1DjsLTfbQUgsp46JyecSOaZ7vLv3IcTTv3BhB4yZTy4+PI47JaAPWwRmUyQUoIUixSfb6Dl/HHykBKRHkTQqmJVTEFGTNU6RRdaYBAbnFVBaD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLh/Vt9C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758269239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sJ4QvBsVVW78p3Cfy0leIhRLNF4HKJO/3heDThFL56U=;
	b=hLh/Vt9CPMGjZGa6WJb+dEVQfZsF9+aigjAFCMj8fb2A7WuMaBFQAe3ISi9ai3LBMmdZ9b
	wXdlvxMIzMW3wv8egdKEinMDg5ohQ07uEOXoMH8m3PtAOmvMhkvVSs28PNhJsVKNAzk4+6
	NPXFqKGSzz69vWehS1x+LoS8ICYln00=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-L7ymK5SsNbmf0WnMBwEisA-1; Fri, 19 Sep 2025 04:07:18 -0400
X-MC-Unique: L7ymK5SsNbmf0WnMBwEisA-1
X-Mimecast-MFC-AGG-ID: L7ymK5SsNbmf0WnMBwEisA_1758269237
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45cb612d362so9631055e9.3
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 01:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758269237; x=1758874037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJ4QvBsVVW78p3Cfy0leIhRLNF4HKJO/3heDThFL56U=;
        b=lq0M5ycS4SrVxprZhdzQ8HMuQWFF5ooYO3zZFmj6GHdpci0moB1S3WmqYlqebd1h+O
         Nk+NrKSmxjg9ISNtV/y9BAtYSf1ey1EWmKRGkhgnBKXPo8gCpFcaiJO5h+6uXMIBa3TI
         odSWemYD/uNKpPY9vnEsAo5bXd/nhJnvlFwg5oXlLzoaZDZraO0OziJC8KVFDQJrq3az
         XcWdFoeqwNChWiKqRFAKkBCYvXre4UbPlwCdzy9DiyxQw5D9bhu8yENxbXHrO+908a2t
         mzcwQjP4KLZvacVuS0qi6s9EiCybQj/tk26z44I9ZROysSSU2WuxXnCXpoFlAQ1sb1hC
         qAdw==
X-Gm-Message-State: AOJu0YyrIj4EWW08B1X//WUSJGwftHoF9SVnr+Qrbwsp7r/i4t3rcLCq
	QBJN4aT8ZqY3aO93iU3m4+wOqIfSFYGCx7H31VISzPcJnsmFaIcdWlTnfHUnaupi8Qf2DQ0lFa1
	+8cS3v1MtiAFU2j5E3+rV/ihYcGufL+rezFoR2vgmkShk3VG9Km3EeBSvAw==
X-Gm-Gg: ASbGncsgWKQdsPoyc5GJf25VrO5TokIdYKIQCg0x+eiQqc94A9SpzpNhz/Q7+xT8uwX
	L21oI6rZM0IDTvDxFHili3aKAKr66T68Z6ax3fW/5O6tIUiTU8+6fVF7sYQevmHfauWIiUBGgz8
	q9SnXFjBM9ja7hcgLSJ6Hpad3z/W8kMgUdECTkZP5VCYkAS6+Y8H3d5UvBOQ1usOuHcyWgYOZeo
	b067OtiQaWpTXcMjH2Jvfn0PvgTKYGjiN19WNYiI6zxA4H7TFkdg2DP5gy+IR9ZfMLBQtOSeHK7
	8ghE8z2x120aqTSs7lBKp+RR00gR+is=
X-Received: by 2002:a05:600c:4511:b0:45d:d515:cf42 with SMTP id 5b1f17b1804b1-467f0498c81mr17348295e9.37.1758269237165;
        Fri, 19 Sep 2025 01:07:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFinVaPgj48GzlMH0uGul7V9Taa9ADowVJqnSzC3mwQ51zuNJ0wdmkOpIJySWkfMdEYVB/FiA==
X-Received: by 2002:a05:600c:4511:b0:45d:d515:cf42 with SMTP id 5b1f17b1804b1-467f0498c81mr17347925e9.37.1758269236709;
        Fri, 19 Sep 2025 01:07:16 -0700 (PDT)
Received: from redhat.com ([147.235.214.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc72e6sm6472416f8f.29.2025.09.19.01.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:07:16 -0700 (PDT)
Date: Fri, 19 Sep 2025 04:07:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heng Qi <hengqi@linux.alibaba.com>, virtualization@lists.linux.dev
Subject: Re: [PATCH net] virtio-net: fix incorrect flags recording in big mode
Message-ID: <20250919040401-mutt-send-email-mst@kernel.org>
References: <20250919013450.111424-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919013450.111424-1-xuanzhuo@linux.alibaba.com>

On Fri, Sep 19, 2025 at 09:34:50AM +0800, Xuan Zhuo wrote:
> The purpose of commit 703eec1b2422 ("virtio_net: fixing XDP for fully
> checksummed packets handling") is to record the flags in advance, as
> their value may be overwritten in the XDP case. However, the flags
> recorded under big mode are incorrect, because in big mode, the passed
> buf does not point to the rx buffer, but rather to the page of the
> submitted buffer. This commit fixes this issue.
> 
> For the small mode, the commit c11a49d58ad2 ("virtio_net: Fix mismatched
> buf address when unmapping for small packets") fixed it.
> 
> Fixes: 703eec1b2422 ("virtio_net: fixing XDP for fully checksummed packets handling")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Thanks for the patch! Yet something to improve:

> ---
>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 975bdc5dab84..6e6e74390955 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2630,13 +2630,19 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  	 */
>  	flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>  
> -	if (vi->mergeable_rx_bufs)
> +	if (vi->mergeable_rx_bufs) {
>  		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
>  					stats);
> -	else if (vi->big_packets)
> +	} else if (vi->big_packets) {
> +		void *p;
> +
> +		p = page_address((struct page *)buf);

I'd move this assignment to where p is declared:
		void *p = page_address((struct page *)buf);


> +		flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
> +
>  		skb = receive_big(dev, vi, rq, buf, len, stats);
> -	else
> +	} else {
>  		skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
> +	}
>  
>  	if (unlikely(!skb))
>  		return;


Indeed but let's please not do the initial 
       flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
for the big mode at all, it's confusing, and only works because struct
page is bigger than struct virtio_net_common_hdr.

pls move it into the clauses for mergeable and small.


> -- 
> 2.32.0.3.g01195cf9f


