Return-Path: <netdev+bounces-176791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8780A6C2B2
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 19:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500733AC982
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E5C22E3E9;
	Fri, 21 Mar 2025 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq24M0oc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C009A1EB9E1;
	Fri, 21 Mar 2025 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742582573; cv=none; b=Mc5UatcKKPijPio1mdbclbNiyivYIUF9Jbnf2yxE2dZDwYV53e3K8bU0U2cPlhZcwEGGb8WZD6b3CiYuTpd+fWPGj1a7HyhEq1fskVTxR8WfMN5siBh6tqe25KORCphjXPQjIivB3hv+YvOCUymoYqnm16mjg6RyvO6IZ611HOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742582573; c=relaxed/simple;
	bh=AvEOBE0yE4qY/KJuGrAgKI7WyCIkAClu4X50DJgTsGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqbthlB7DeIyeC9d4q76nKcTPCzO5q+4iDyTRND0iiid2CUFsz70cE0w56xY1rEyNwpSccHjUiZCZfmBAwfHL5AoCHh5lFyhqslAzxBK9soSbTXTXq/xtQUfnPk3QIAzaoRWkFU2FnpaCGQ4uz4LGodaQz4moak8ArK4+ssygls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nq24M0oc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso17301005e9.2;
        Fri, 21 Mar 2025 11:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742582570; x=1743187370; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xkhJhb5KibJG7wvOxcyqZnnmJEX4g1WLn+kx+Q0rQIc=;
        b=nq24M0ocWqoTMEXWBryGosTY0Xs3SksHcWyElQAb0S1EY/qnYkC2L/lQyeBRc9PEdY
         N4+dMAu73k5EhZWIqawbK4MJHurI19uaQR6uk3Nl2vYQoGLpd98kTcNYYAHfUSdrujfC
         aN17brEbVwOf50flAqu0Ef8Y//7DxrnEWRzoHBo1HlR0xKXFjfwS8rLInVYOdDHGah5H
         htzTgZv9mniHJnS0/sPx9mx+YmFmcFH5kRTcGJRFvrRhL9E9bAHySz8z6Ffn2EDrkRYv
         YlzC4mln+CY80NupaL318fwewkpn3piRB756Fve/OqI6uMcrIrrrAzgw5Bm0CSAgGGXo
         DSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742582570; x=1743187370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkhJhb5KibJG7wvOxcyqZnnmJEX4g1WLn+kx+Q0rQIc=;
        b=Fbu67JN3b6b3/5w/0mv71pS5/6QIl9FO69HqGOH8zpxEf0vR1Kwisua7xDiox5mmaC
         eY3RYXdUkUK0qRtD8WqRCjKYq77on3MtFVyQ8LjGKkouNOhrrtbfChybMsMRVfALPPo0
         88SptTtBglKkRtoTAOZrVTKAi+coKKkLE2aqRSmvpnF7CTOxBdbpsKTrxWhFTSYHYs9t
         HjoHtwT9/kVqXdsUgJBn8YETfQJH40LvcnhvJhkPl1UKC3Z/EZfA4ZOIVMtDs4CS+Mx8
         M2EgyCYBV+6Tcmta5k1VkXfmHsPedmJpaXPLUG6NgayG1OvEkghEVdovrkhw7gd1fXAE
         wccw==
X-Forwarded-Encrypted: i=1; AJvYcCUwLaZ4JybShP8g5mQkmygwvMJ5vj3xB2HOoVXWfy3zOmop6+guehEjLgkKmPJGam3xhbuGfw5X@vger.kernel.org, AJvYcCVNOPbq9GxNH2B7X4JrjDGvViXJB8T2uxAa0CO7Yj8q7OsLsNQRGsJdefACe1C+14ghQzp/FXolAGUZ2rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfrMiOET9b9kp9s3X4wv01zDvgZiJkETdJDfn3r+ESaO4YAxBY
	vdHoHXrS3gYMDYXzIbviKe3tiBEUqYnUqvVPYKYdXTNyHGy0mL4m
X-Gm-Gg: ASbGncvgUJz+GEpBN6dhFDmvTyIuCNE201qcJqUALaH9z7JNI6QIoo++LOVRfI2CvwD
	V2ImK3Iy7pi1gbpdLw6J6YCHgixxrWY6iPJsqxUu8dxhkNQy9MsekydE/MRU9u1yTUc4QcblxEw
	D0IEflFxteiWLaGJmkGAqNYgfCYaDibUOJUWq5MN2OsBzhn1EZwe38T2cFq9fsUc7RymZpRI8+8
	jmX9HOCSfHPrVUnjxwzfeEwpLe9cAgSVT+T/ylRxksqZtGA2yTEVK53pBO80r14JXANg3xVQnPh
	Yux95zc4JDDwiHD4LBjGgbavoA2i3eG6Y9ia2ynqMJ7tL+dn
X-Google-Smtp-Source: AGHT+IGHShP8TZ93bUmoxG59VBXZdzCleXOrrS+vMNkLwHzO8GRb2ahF5afjhB9vdhw2gYbmgvOcbg==
X-Received: by 2002:a05:6000:42c4:b0:390:de66:cc0c with SMTP id ffacd0b85a97d-3997f93c452mr2860509f8f.46.1742582569592;
        Fri, 21 Mar 2025 11:42:49 -0700 (PDT)
Received: from qasdev.system ([2a02:c7c:6696:8300:de5d:afa9:bb95:3f19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b25c9sm3022597f8f.42.2025.03.21.11.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:42:48 -0700 (PDT)
Date: Fri, 21 Mar 2025 18:42:32 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, yyyynoom@gmail.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dl2k: fix potential null deref in receive_packet()
Message-ID: <Z92zGMsCPHCIbx62@qasdev.system>
References: <20250321121352.29750-1-qasdev00@gmail.com>
 <CANn89iJ+VtuyB1tRLeNqVzx3ZpxEiusyfAJv855B90P2XcpDag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJ+VtuyB1tRLeNqVzx3ZpxEiusyfAJv855B90P2XcpDag@mail.gmail.com>

On Fri, Mar 21, 2025 at 04:13:04PM +0100, Eric Dumazet wrote:
> On Fri, Mar 21, 2025 at 1:15 PM Qasim Ijaz <qasdev00@gmail.com> wrote:
> >
> > If the pkt_len is less than the copy_thresh the netdev_alloc_skb_ip_align()
> > is called to allocate an skbuff, on failure it can return NULL. Since
> > there is no NULL check a NULL deref can occur when setting
> > skb->protocol.
> >
> > Fix this by introducing a NULL check to handle allocation failure.
> >
> > Fixes: 89d71a66c40d ("net: Use netdev_alloc_skb_ip_align()")
> 
> This commit has not changed the behavior in case of memory alloc error.
> 

Hi Eric,

Thanks for pointing this out, I referenced this commit because it 
added the netdev_alloc_skb_ip_align() call without ensuring the 
result of it succeeds or not. Before this change the code used 
netdev_alloc_skb(), so I now see that there is no functional
difference since an allocation occurs in both versions.

> > Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> > ---
> >  drivers/net/ethernet/dlink/dl2k.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
> > index d0ea92607870..22e9432adea0 100644
> > --- a/drivers/net/ethernet/dlink/dl2k.c
> > +++ b/drivers/net/ethernet/dlink/dl2k.c
> > @@ -968,6 +968,11 @@ receive_packet (struct net_device *dev)
> >                                                            np->rx_buf_sz,
> >                                                            DMA_FROM_DEVICE);
> >                         }
> > +
> > +                       if (unlikely(!skb)) {
> > +                               np->rx_ring[entry].fraginfo = 0;
> 
> Not sure how this was tested...
> 
> I think this would leak memory.

Could you please elaborate on where you think this may arise so I can
investigate further and try to amend it?

Thanks
Qasim
> 
> > +                               break;
> > +                       }
> >                         skb->protocol = eth_type_trans (skb, dev);
> >  #if 0
> >                         /* Checksum done by hw, but csum value unavailable. */
> > --
> > 2.39.5

