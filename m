Return-Path: <netdev+bounces-285932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC6fCbcT/mnZmgAAu9opvQ
	(envelope-from <netdev+bounces-285932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 18:47:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 959004F991A
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 18:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6237F300F95C
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 16:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAFE3FBEAA;
	Fri,  8 May 2026 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OR4brhwQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3UmYKcU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A177E3F20F3
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258847; cv=none; b=eWVL8wMkSM8lSky6y4lT7tzzY6m/8wdJmYUODjsivp4QpGdxnlLRwqOYiaGR905VOXK010IUppN35YpEOkrXguZ9UFOW3BB8BlPDOszbm/sZrl1ThQtfHv3dsYWc7Kpr12CD0wFOi696Y2gl6xobMYRdOFed2npkPqGejuXsojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258847; c=relaxed/simple;
	bh=+GlTIpRQZ5vV/lIQfJdZ/NWxJDB5jBGX6KC+RdsOsLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YO8MF0WhP93U8bQ9C5Tj0HZmmlw1X959f/c6axgmI19KczSSmRpa1RCuzLgC9KRJLyn97xMORWeQAQGqkTDnWFt0BHTPRjcSjulMVLYRY6HAUjgj7/X7MVwz4BTdst0MrY40+yq7i5/AUGWuJSH+hOJppPR8Yvkshzu318NLBy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OR4brhwQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3UmYKcU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778258845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MA8iF/H4+Ea4mWZn+FttEJhotoY2jxN8mx6SClzyAQk=;
	b=OR4brhwQ3xzVejNYqK3q9qV3JXzFXsHFSb2qURJ2iJ6SpgWVSGfVw7DKg9TyXGa3+v9AJL
	9ekN+Rdp82JN/SBLfJ3FVs81RKZ1o6Oe17x/nLNplTHtCWJFA0Eb5TZBbL7kSlK7W0b+yq
	v1EOoiZGIs6D6FrO5nJAJKzez3PQtgw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-HSrAePdWOx607_5TJk_L6A-1; Fri, 08 May 2026 12:47:23 -0400
X-MC-Unique: HSrAePdWOx607_5TJk_L6A-1
X-Mimecast-MFC-AGG-ID: HSrAePdWOx607_5TJk_L6A_1778258842
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488c2cc0cbaso15990135e9.3
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 09:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778258842; x=1778863642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MA8iF/H4+Ea4mWZn+FttEJhotoY2jxN8mx6SClzyAQk=;
        b=L3UmYKcU8HuqVyTxVg012aNEenn+4LD8ZuawR0RNOZow+ZdHh3rtA0wvz09TLyHyZ0
         P1S9rBUc8WdhtVukkRlwZ5Sf5WzRbSoix5sELNOPiVAhTUvnTPz9ulkvYZzvwTHBoUJu
         NZVEqu4CbHfNH9fP/dHnUtzzpRzzLalH8ofmUt1TUebc340kikwBeb4Vh3EU2xjrCO8C
         KU3NiJedZo9TMH5NRbYyPAyC0tWGpk+rQEgxar02wqdbrJ3Rc9nmaQmpwvksw21pZbX4
         fpCO9L5b9hCJHFKS2EC+YwkT2Dn7iMqG4SqZicUFdeaFn2Apk93kqgt1xa0w186Rm+Vc
         z+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778258842; x=1778863642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA8iF/H4+Ea4mWZn+FttEJhotoY2jxN8mx6SClzyAQk=;
        b=GSCYruVG5vxktVhQofWKCNXDXMibBImUFPrgpSqdukIgYCDKiKf7GjCSkfs1emHStC
         /xjfUfdQeyjqDQfmAYYURwO4j8iNGCEpR3XGdITlF/MHepnJ9zcDSZyfQIbqmk5283s9
         R0qn7h8kwV7ozLPiBeBH/W29BuRrA6aru6zW8gx9/f2OPQVERCponhu/HGf9BCKDxgP2
         Ys68aQIGGyeaFWxfqOzOK0havwDffDcQ7x2FhX3rnXUntcfNSyMMR2lbmqyZhFlTmKhX
         kCw7scse/TLFq8xGB6fPqQanwWV8080f1IvokGlxlrMDQ/ZEZQd2l3kjdhfFbvzOjyY6
         /i2g==
X-Forwarded-Encrypted: i=1; AFNElJ9uRr6mVM+TnSp8JQ+GXa7sTGD5O2LOJtAguPaWEo0qJSjNnmUmWrx+w4Qzu2RlWfU9oSzZG6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu2tJFAX/lUPHmS/llOdJIyVug8DJAFK8yf2eQbedJCr1W/peE
	49IUizXNjB96X8ll3r08SSI1eSn5M4wZo5mPm7QvWgfdvULmlbdd6o2ACjUF/+8YgdTqp+CQCFc
	9ezirAJ2vvMCl3BL5ft/gl6n+3BqJPStQk54lUSIX5twYApXlDs3efV4eyA==
X-Gm-Gg: AeBDievlSiIeX42Jb7v0Nhz9+zF9ZJa2c0HyaKYHU3LM+C1DVmCxNmPOtHpwWPlpf9O
	jf5+6W62UBlZ08z2TB8K1UxloCVPtLwQ/neQr1ScjcvMnUCWHMDrR7iGq5PiM1QrCB4KU1LFYKv
	Yv40Cp0R7Q7cHYFT7x6LsFw6DBDmwpLjdDZvTontoGCMzPeY/LaFZGPsvknOUmdlhaHB0CR03DF
	nHhYHQr4JF+DpHOVh9DwLYL9AAllQMxka9DcUrPkKixDiBxQ9GubngM90iRpvIwaIizsnHaCGHu
	V0C7Wpcd7LUh2h55dy6vx07UkxJgdqFgl3Qu2+mG1EQthdfTweIu9AzazEDMDqBHpTHt35pauK4
	fKJmbK1PepKyTyi+Dmx7kj3lDGvOMpYNcLuUJaP+x2aad9ZgcMmWfZ7F0ytbO1cnHaoPseOO2qQ
	==
X-Received: by 2002:a05:600c:45c5:b0:48e:526e:1040 with SMTP id 5b1f17b1804b1-48e676b45eamr54988525e9.23.1778258842213;
        Fri, 08 May 2026 09:47:22 -0700 (PDT)
X-Received: by 2002:a05:600c:45c5:b0:48e:526e:1040 with SMTP id 5b1f17b1804b1-48e676b45eamr54987955e9.23.1778258841600;
        Fri, 08 May 2026 09:47:21 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dd2c59esm6805945e9.1.2026.05.08.09.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:47:20 -0700 (PDT)
Date: Fri, 8 May 2026 18:47:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Yiqi Sun <sunyiqixm@gmail.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stefanha@redhat.com, 
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap
 copy
Message-ID: <af4TLgAsn8zS7cGs@sgarzare-redhat>
References: <20260430071110.380509-1-sunyiqixm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260430071110.380509-1-sunyiqixm@gmail.com>
X-Rspamd-Queue-Id: 959004F991A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285932-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, Apr 30, 2026 at 03:11:10PM +0800, Yiqi Sun wrote:
>vsockmon mirrors packets through virtio_transport_build_skb(), which
>builds a new skb and copies the payload into it. For non-linear skbs,
>this goes through virtio_transport_copy_nonlinear_skb().
>
>Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
>As a result, skb_copy_datagram_iter() sees zero writable bytes
>in the destination iterator and copies no payload data.
>
>This becomes an info leak because virtio_transport_build_skb() has
>already reserved payload_len bytes in the new skb with skb_put(). The
>skb is then returned to the tap path with that payload area still
>uninitialized, so userspace reading from a vsockmon device can observe
>heap contents and potentially kernel address.
>
>Fix it by initializing iov_iter.count to the number of bytes to copy.
>
>Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
>Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Hi Yiqi Sun, thanks for this patch, but as I mentioned in the sub-thread 
I found another issue and also another way to fix this, please can you 
test the series I just sent: https://lore.kernel.org/netdev/20260508164411.261440-1-sgarzare@redhat.com/

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 416d533f493d..6b26ee57ccab 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
> 	iov_iter.nr_segs = 1;
>
> 	to_copy = min_t(size_t, len, skb->len);
>-
>+	iov_iter.count = to_copy;
> 	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
> 			       &iov_iter, to_copy);
> }
>-- 
>2.34.1
>


