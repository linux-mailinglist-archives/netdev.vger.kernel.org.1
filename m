Return-Path: <netdev+bounces-152894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068FD9F63D8
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55297160EB9
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26B819D071;
	Wed, 18 Dec 2024 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHo2RhSG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E6C19C554
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734519180; cv=none; b=kyeqFAyFFL5POrei3YJMv4zdaRwToYUn+HvdMPJgNmA4sIPJBRYjKfKTc4mrkby8ypCVcg1rg1QPd4ICvezrJ+Cv+Ev6igXdFSupCOyIL7TkuMfJSdKgfivpu4yLzW8tcJBfD4kNQ2geGOovn/cGOZ+H53whbc3RWB5IkY6+kGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734519180; c=relaxed/simple;
	bh=bnHC+b+eixsr+IiWuP1hE3bhw/UGYQ3zrR8tg25xajs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ta6dQhdSTHe+pyTnnvk/lTMClt1725Ovs+RYLQmj7Pe1q0zb1SaZ2VvN68yL/du9jBteNdU0IchXfSTTNjP7f/qNmgG/Yt2udb7JLLyoJrsZxMwdmChSSCAjvWCLoCSN7eEN5AzDq91U4N/lwK7nUmOLmIl2nEOtX2+ke/lx/3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHo2RhSG; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d34030ebb2so10072525a12.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 02:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734519177; x=1735123977; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iXHm+n92xoYhLAZwEX29GnFu6vmESPiIZ0xSf8j1Eg8=;
        b=CHo2RhSG4rPjB1ODzWkjAw2vGJYSGT9Ua1GaBn4xC1VWI/E/cb9Xd2dMOYSImTy/Fo
         pdJ7j5/+0byS34DIYYX4u5l4fKtZdFEN+kANIFikSSCDNAx2Rbv4rpw7yx+TDDb/BFaS
         WFTEWUhYtbe4nn1wsdPaQOIpzdFbWgQ+Ln22W8+ZQmnd5PCQ2voe9UKOgTfK2vbeR2Ng
         xTiChY4o5YVMVUEkJu9Bj5/v3D3eZ3BSxFVzeaNXmOUoS1cL3lVUb5eNNL27fQ2gC2iW
         rUcv/n8OiWYLfLFWbuuAvDfv+TOIhnhv78qrxFzkp/VwTtE1SKI58mSLuXWF0/uJNgmx
         LlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734519177; x=1735123977;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXHm+n92xoYhLAZwEX29GnFu6vmESPiIZ0xSf8j1Eg8=;
        b=lsTKmlal6nDsPyuSoALrujUYLtRvvsC31cLBDfLuo7VE/xMN35AqDy9dASQDM35s5m
         usRpwU2soN8RRUjvqkGv+9p/Zthhf0ux+baOwMyl4KIP46qTaCPx4Qm86v4YSPhAl30x
         i2g1Dj4xDjwHya0yxE74Wsc1OFlnVNUs4r43UzCT029aeKQoidF5nRZVgxXvxMFqDpA4
         HYu6I2XOrtHEUsltjGwNg7/ZCB4gAzQN3Yyluf0EYxA+6o2jcKYC7b0ROZXQH6sdOYI4
         pLhOiy0CBazHILQTxY/uCY9GS02tUXOKDGU1ZabyJvl5Sx71mEXZ5tVwt1IZCGbdRGAO
         H7tg==
X-Gm-Message-State: AOJu0Yw2u7pljUhisgU3mlvkNZi8/aDqu6zFrXiL58gEBIf5YwXjymhy
	jZc3oSWXh+Whdff26icLCZswU6KhxVxW7/0C6uGZrI9pBQEK3Tqvsj6nzfP1
X-Gm-Gg: ASbGncvVG10hCPJPCSgPtdi64aNA36tD7/UplVS6mS4hq/ZMtgkk/LCg4zmNyjKNNUR
	XHGNnF4lG0yI5zplFsEYcOL2pt1vU6P7QxQZV6B6WwF3hqNYonmiKhsb17ihcmjfY81UIg++GWZ
	acZ5k9hlSJKrojaNcuRSTGS9y64FKhDAHQI6mzxG1IjQqakwG7BBLZJU9XbckEm+0J30DrGAuFG
	X/UR0iDIQF/H8QBvzhWtTUyXrAgPKiNijpcvjLeTyRHYIuRrfCEwYUEi+RKa83NNS3wyKAtZ6JE
	N2uP4lARdFjh0x4LpT1V9QLWZI1zUEj799C+Neg1OJU=
X-Google-Smtp-Source: AGHT+IHCX5udpGC9zplLvMdTo35+HJ18kjJNNLEmk18mBs7/A/7Uo8AZP89/uSLmlY60xMtygY2RSg==
X-Received: by 2002:a05:6402:2398:b0:5d3:d9f5:bf08 with SMTP id 4fb4d7f45d1cf-5d7ee376603mr1836007a12.7.1734519176818;
        Wed, 18 Dec 2024 02:52:56 -0800 (PST)
Received: from emanuele-archlinux (mob-109-113-163-118.net.vodafone.it. [109.113.163.118])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652f3534esm5279572a12.83.2024.12.18.02.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 02:52:56 -0800 (PST)
Date: Wed, 18 Dec 2024 11:52:53 +0100
From: Emanuele Santini <emanuele.santini.88@gmail.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: netdev@vger.kernel.org, yoshfuji@linux-ipv6.org, friedrich@oslage.de,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	dsahern@kernel.org
Subject: Re: [PATCH] net: ipv6: fix the address length for net_device on a
 GRE tunnel
Message-ID: <Z2KphccLReKzJxwZ@emanuele-archlinux>
References: <20241108092555.5714-1-emanuele.santini.88@gmail.com>
 <Zy3/TmyK7imjT348@debian>
 <Zy4fA07kgV3o4Xmn@emanuele-al>
 <Zy45iLv7cL8OcYze@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zy45iLv7cL8OcYze@debian>

On Fri, Nov 08, 2024 at 05:17:12PM +0100, Guillaume Nault wrote:
> On Fri, Nov 08, 2024 at 03:24:03PM +0100, Emanuele Santini wrote:
> > I'm talking about the ip6gre. I agree that setting the hardware address to 0 is appropriate.
> > However, in the ip6gre_tunnel_setup function, the perm_addr field of net_device is 
> > currently assigned a random Ethernet address:
> > 
> >         dev->flags |= IFF_NOARP;
> >        - dev->addr_len = sizeof(struct in6_addr);
> >        + dev->addr_len = ETH_ALEN;
> >         netif_keep_dst(dev);
> >         /* This perm addr will be used as interface identifier by IPv6 */
> >         dev->addr_assign_type = NET_ADDR_RANDOM;
> >         eth_random_addr(dev->perm_addr);
> > 
> > maybe this is not a valid justification to set addr_len to ETH_ALEN.
> 
> I think that having a fake permanent address for the purpose of IPv6
> interface Id. generation isn't a correct justification for setting
> dev->addr_len.
> 
> If setting ->perm_addr and ->addr_assign_type have side effects on the
> acceptable values of ->addr_len, then the commit description should
> explain that in more details.
> 
> > I will make a review setting addr_len to 0, and will resubmit the patch after successful testing.
> 
> Thanks.
>

The addr_len field in the net_device structure of the IP6GRE tunnel is set to the IPv6 address length
because the 'ip6gre_tunnel_init' function in 'net/ip6_gre.c' initializes the hardware address using the
tunnel’s local and remote network addresses:


>	__dev_addr_set(dev, &tunnel->parms.laddr, sizeof(struct in6_addr));
>	memcpy(dev->broadcast, &tunnel->parms.raddr, sizeof(struct in6_addr));


Additionally, I found the following comment in the 'add_v4_addrs' function in 'net/addrconf.c':

>   /* in case of IP6GRE the dev_addr is an IPv6 and therefore we use only the last 4 bytes */
>   if (idev->dev->addr_len == sizeof(struct in6_addr))

This indicates that the 'addr_len' field in 'net_device' is intentionally set to an IPv6 length, even
though it may not be appropriate.

However, this behavior triggers an unusual bug with packet sockets: when attempting to use sendto on an
IPv6 GRE tunnel, the call fails with an "Invalid Argument" error.

However, modifying the addr_len field might not be the best approach to resolve this bug. So, consider
this patch closed.

Thanks.

