Return-Path: <netdev+bounces-83217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D1E891642
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7097B22735
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 09:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B555E3D0D2;
	Fri, 29 Mar 2024 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1irTrnt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2361CFAD
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705677; cv=none; b=LTpWR59No6tpfr4N8rxYZY2DyJAnaBVTW6InHWftHe8J2mn3RCpM2769G9ZWITqvCvgkoPI54l+byu/eGrKgZjwzHTXWX+W/2AE0cDrjQwAHwzY9lohXu7ZzJPbVLWS5mVPTbaIvlyRwpIY3gpPimBfHRQRRoT3TbU4hm1fGXOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705677; c=relaxed/simple;
	bh=6rjbCuC7qsmhm4hBqyyu5MPXXFSsvp7a5n34xjKaAqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5tU216W5dg86mcrRwh5JYWZfNVLEh9oQnGnBu725Lb/SNQCKSj++2SaRj6OAZU1OvEttinvXVXYY1L7+Uy84n/rPHZ+zqzC2FgKkdd+7epgftS//c1HxnWERCbMQ8sTh4Z+Zzcz3A+NsG9QBCk2agQ4YCotDc+9Vh4BfkRdNzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1irTrnt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dde26f7e1dso16009685ad.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 02:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711705675; x=1712310475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oh0leBodThLl+/WwZkKWIFfNI0+ZRn+gaWdkMtSiKdY=;
        b=R1irTrntPO44rdNGmH+2Ex/+C76LReKldETHsShi9QeHAh+f8Rxz3P/RMFu4RsXaFo
         f9EsCyvxGC8x3Vwkdclzy0SfqSeVT31h5SGboo2c2R21AhrrZlQ0SnuUUTLLAU8DZ59v
         wqX+w6JOI77EA5vM3VSLttkq9Jm+mOFtyQGBqpO6NULd0mPsdjKxgQxid4K5wNXBBLS1
         n1/v7iU8vg6l1pGjTZuZ1l2o8e/G/+gz/AYbTa/i8MAkFAII97wdasBdeaS+wt8WXxmj
         YCvhoh2UW0HTv2RZw+myH0ONrBjCeafOimj726Dfom37o1w93QZNGvP++PRu7kROZTmo
         Lppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711705675; x=1712310475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oh0leBodThLl+/WwZkKWIFfNI0+ZRn+gaWdkMtSiKdY=;
        b=katchyrCe11iiFl/QKFgateqrVErIVD+HHhPZc7otoMHtXFuBxckm0gjn+tkfFK0sv
         /2caOitQfDrNt9BctnI7How66FYWEXg93GCn7aNMm0+D1Y7C6oGrOWRxiYOU1c61here
         p9xcUwJLqwIbzuTeRuVdzUHdSNmgnTKXSaP56LNQ9fuarvRnVdrV2uNfcAzQwSMi1VrL
         otsHdn1x/Avc3SZvcvlF11QLgZhUIKOopsNpJ54Zl0Hh0jOagEl+FA6Snbz6VD+Ky0qX
         9VTnuYeqCgxlJRfU8qAATWCjRKjrCd+oqbnEfGp2o2yIU10XEBAX3ZqIiQkhopE48wed
         6d7w==
X-Gm-Message-State: AOJu0Yw1uldX+/rlcyMEemILquAh2wTB72GRHGYoe+8UTVWCgghcEneC
	YaU58XdcFWfFHrFaTKLqiEpq9qBcmJIEuUPVFle7dDxCNFqOAIgiyAuacHirMAolCgn4ZVGLl3O
	KWtUsegdRltm6PZuF0z54eiMqbaU=
X-Google-Smtp-Source: AGHT+IHvdVFM6Yhn09w77HGK7jsfikHdUEX+kciFWiqwEiPVYac73i21jJYp0yxoHddRUojLc67TTiKVW5Q2aJI0SQo=
X-Received: by 2002:a17:90a:f3c6:b0:29f:f6c7:1ace with SMTP id
 ha6-20020a17090af3c600b0029ff6c71acemr1697823pjb.32.1711705675399; Fri, 29
 Mar 2024 02:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171154167446.2671062.9127105384591237363.stgit@firesoul>
In-Reply-To: <171154167446.2671062.9127105384591237363.stgit@firesoul>
From: Arthur Borsboom <arthurborsboom@gmail.com>
Date: Fri, 29 Mar 2024 10:47:39 +0100
Message-ID: <CALUcmU=xOR1j9Asdv0Ny7x=o4Ckz80mDjbuEnJC0Z_Aepu0Zzw@mail.gmail.com>
Subject: Re: [PATCH net] xen-netfront: Add missing skb_mark_for_recycle
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, wei.liu@kernel.org, 
	paul@xen.org, Jakub Kicinski <kuba@kernel.org>, kirjanov@gmail.com, dkirjanov@suse.de, 
	kernel-team@cloudflare.com, security@xenproject.org, 
	andrew.cooper3@citrix.com, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 13:15, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>
> Notice that skb_mark_for_recycle() is introduced later than fixes tag in
> 6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB recycling").
>
> It is believed that fixes tag were missing a call to page_pool_release_page()
> between v5.9 to v5.14, after which is should have used skb_mark_for_recycle().
> Since v6.6 the call page_pool_release_page() were removed (in 535b9c61bdef
> ("net: page_pool: hide page_pool_release_page()") and remaining callers
> converted (in commit 6bfef2ec0172 ("Merge branch
> 'net-page_pool-remove-page_pool_release_page'")).
>
> This leak became visible in v6.8 via commit dba1b8a7ab68 ("mm/page_pool: catch
> page_pool memory leaks").
>
> Fixes: 6c5aa6fc4def ("xen networking: add basic XDP support for xen-netfront")
> Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
> Compile tested only, can someone please test this

I have tested this patch on Xen 4.18.1 with VM (Arch Linux) kernel 6.9.0-rc1.

Without the patch there are many trace traces and cloning the Linux
mainline git repository resulted in failures (same with kernel 6.8.1).
The patched kernel 6.9.0-rc1 performs as expected; cloning the git
repository was successful and no kernel traces observed.
Hereby my tested by:

Tested-by: Arthur Borsboom <arthurborsboom@gmail.com>



>  drivers/net/xen-netfront.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
> index ad29f370034e..8d2aee88526c 100644
> --- a/drivers/net/xen-netfront.c
> +++ b/drivers/net/xen-netfront.c
> @@ -285,6 +285,7 @@ static struct sk_buff *xennet_alloc_one_rx_buffer(struct netfront_queue *queue)
>                 return NULL;
>         }
>         skb_add_rx_frag(skb, 0, page, 0, 0, PAGE_SIZE);
> +       skb_mark_for_recycle(skb);
>
>         /* Align ip header to a 16 bytes boundary */
>         skb_reserve(skb, NET_IP_ALIGN);
>
>

