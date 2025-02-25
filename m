Return-Path: <netdev+bounces-169476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1069CA44233
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF303A294C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2222690D4;
	Tue, 25 Feb 2025 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAnmQJ3p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F1257420;
	Tue, 25 Feb 2025 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492730; cv=none; b=Syl+gBoHYtqQqp43bx4z8cruVvKyaoILIzV2vxBPtIg/EfV6ZohnQRUwVTsMv5zjX8pJ5h5sLvejakGZNfrsuPnlHhTRK4NefJj0yi2+9SkR7gaxtVKcuJ5St4P+/toKcCacDo6RZzjWlj8y2ZyBeVFYd/ZI5U8Z/b7hIbxefgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492730; c=relaxed/simple;
	bh=TiDKBEVw2IJOrp6cyIhigiqqGL6hR20AGWd5Dbp8KYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNdEn0JBwvOrceZwe2DGnh0prw2XR7EJGAjM9V3oQYqDffCQ40tNl718et6tzoXUySDutLP4mTsQOU2kjo20yjsAYBK11w1eifcYOwFEYTjZn2G61pvxwz+nLh//i7zFOkOUM09depu2VCdPlykLMlbBN7T/UU8z7TdQMvJR5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAnmQJ3p; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so37486125e9.0;
        Tue, 25 Feb 2025 06:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740492727; x=1741097527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gwnQSqj41owZpi1oD9MKzf/fLpRh6alNAjkpN49LQt0=;
        b=bAnmQJ3px7R4IjHXD5uz0WH1cAuyFpq7vNff2hRlUfiyYLL8EsvjvnNFa8WCEne9Ch
         wxiCwtKfVzz0kQPZMI5HK94P2Z2sdDe4X3K6386ZxW04uvFM+88LhDJM9Y0q0x7M07/S
         2AoAcr5qq7NoF4xlvQFfpaO2W3Heg3yF8jSI8pQo7s92L7nnKee2N98A7fScwsHcO0VC
         oYkuZF79TznhzVrkMjqI0cG9QZKjqnRJKSJPsiIedznzLzOdUgLuzHRbTLg/dmyKd4Rv
         3iujmIfQdK01LxACQttb/3NWOH+wZxWWdhCEAo/WdGwG348vMCztM7PIZpY3rxtuagBG
         L6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740492727; x=1741097527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwnQSqj41owZpi1oD9MKzf/fLpRh6alNAjkpN49LQt0=;
        b=K7ntAhELre1A6TV1Wxyo5Tw37zr0sAQSV/gRjJUipkZ6UEEMKyNzzhdWKoVuDlzd4+
         8LJNpHgoZ/EI88ekZ2n4LuuYKH4yzpimfIqGeZG63mU8laa5S8wHZg71BITG+BrmSIyT
         RQq7gwomLKSrmJFhmrUC5Fbbe+2yszQXqjEyqdkSh/ccnJKL+LtLFdbr4IBUQPi4qRs9
         61WFiOCpbgFHTNHm3bdwEzd+L3StxNNm9NrzHAjlVnJI9Eg7xauKRqLeA7M1wGYTd31T
         CVR3XId5AsEMlhSVRVN5lNf6Xbb4VmQi3u4SSqN2LSgtiXToaAXLZ0awEpls3sJcXULi
         gbCA==
X-Forwarded-Encrypted: i=1; AJvYcCUz6q6r6thtnEyW3avCLvNV6NL8dSaKUM/wQzrLNoenvz+CIbpuaaIgvrYkYxX2+0yyspzWTuXfWeE84Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzXf/QHbKlcR7Eq2OM5V97DdX2o9jWi+KJ7CO31OuYyG1RXFkN
	2+p4r1c7q4DMpBpNs0cciTnw7qbrccX8lofrkijrBKapkiu6z2QgQHmV51Pg
X-Gm-Gg: ASbGncto2hBv1cd8rEySkv3qoRk/JXg5ov2bnLzJ2KnLwMPvrCOV7xPb+Uc+vv/2AFu
	o929fCcUd8NaW5w+5M1nS2P1e1CrZdTWeCiPJAbNheBq70QYDQyCi+YQi/RxyEo5KeXea66F1Y8
	bQIIYh0lWmTF1iYueJ5xruM71aqN04oNyVeLsl1ZbuwN+1SohTqurHCRmC2CstU6Ntp8sQwyiVR
	0kc0k+hPEB4g6RQPZAWO5yUxNFj/ojqyQ3VKh5nhE+7HstCYUgxclihu9TN8r+2wP9/wojUlEDp
	7zI5lOJpzVsfjEbUzgH+2YGnUb+nPcNPDF68Pto=
X-Google-Smtp-Source: AGHT+IGWIWAm6eIsYAepddN6YCrMJibV1h5n2h/KIgvf16JG61QXLKORsTtujaCKpi3VwvRrZTWpKw==
X-Received: by 2002:a05:600c:4fcf:b0:439:5a37:8157 with SMTP id 5b1f17b1804b1-439aebf3613mr175716175e9.30.1740492727166;
        Tue, 25 Feb 2025 06:12:07 -0800 (PST)
Received: from localhost.localdomain ([45.128.133.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e78e8sm2398565f8f.79.2025.02.25.06.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:12:06 -0800 (PST)
Date: Tue, 25 Feb 2025 15:11:57 +0100
From: Oscar Maes <oscmaes92@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	viro@zeniv.linux.org.uk, jiri@resnulli.us,
	linux-kernel@vger.kernel.org, security@kernel.org,
	syzbot <syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] net: 802: enforce underlying device type for GARP
 and MRP
Message-ID: <20250225141157-oscmaes92@gmail.com>
References: <20250212113218.9859-1-oscmaes92@gmail.com>
 <Z6ywV4OkFu52AB8P@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6ywV4OkFu52AB8P@shredder>

On Wed, Feb 12, 2025 at 04:29:43PM +0200, Ido Schimmel wrote:
> On Wed, Feb 12, 2025 at 12:32:18PM +0100, Oscar Maes wrote:
> > When creating a VLAN device, we initialize GARP (garp_init_applicant)
> > and MRP (mrp_init_applicant) for the underlying device.
> > 
> > As part of the initialization process, we add the multicast address of
> > each applicant to the underlying device, by calling dev_mc_add.
> > 
> > __dev_mc_add uses dev->addr_len to determine the length of the new
> > multicast address.
> > 
> > This causes an out-of-bounds read if dev->addr_len is greater than 6,
> > since the multicast addresses provided by GARP and MRP are only 6 bytes
> > long.
> > 
> > This behaviour can be reproduced using the following commands:
> > 
> > ip tunnel add gretest mode ip6gre local ::1 remote ::2 dev lo
> > ip l set up dev gretest
> > ip link add link gretest name vlantest type vlan id 100
> > 
> > Then, the following command will display the address of garp_pdu_rcv:
> > 
> > ip maddr show | grep 01:80:c2:00:00:21
> > 
> > Fix this by enforcing the type and address length of
> > the underlying device during GARP and MRP initialization.
> > 
> > Fixes: 22bedad3ce11 ("net: convert multicast list to list_head")
> > Reported-by: syzbot <syzbot+91161fe81857b396c8a0@syzkaller.appspotmail.com>
> > Closes: https://lore.kernel.org/netdev/000000000000ca9a81061a01ec20@google.com/
> > Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> > ---
> >  net/802/garp.c | 5 +++++
> >  net/802/mrp.c  | 5 +++++
> >  2 files changed, 10 insertions(+)
> > 
> > diff --git a/net/802/garp.c b/net/802/garp.c
> > index 27f0ab146..2f383ee73 100644
> > --- a/net/802/garp.c
> > +++ b/net/802/garp.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/skbuff.h>
> >  #include <linux/netdevice.h>
> >  #include <linux/etherdevice.h>
> > +#include <linux/if_arp.h>
> >  #include <linux/rtnetlink.h>
> >  #include <linux/llc.h>
> >  #include <linux/slab.h>
> > @@ -574,6 +575,10 @@ int garp_init_applicant(struct net_device *dev, struct garp_application *appl)
> >  
> >  	ASSERT_RTNL();
> >  
> > +	err = -EINVAL;
> > +	if (dev->type != ARPHRD_ETHER || dev->addr_len != ETH_ALEN)
> 
> Checking for 'ARPHRD_ETHER' is not enough? Other virtual devices such as
> macsec, macvlan and ipvlan only look at 'dev->type' AFAICT.

Agreed, I will change this.

> 
> Also, how about moving this to vlan_check_real_dev()? It's common to
> both the IOCTL and netlink paths.

{garp,mrp}_init_applicant assume that the address length is 6-bytes, when they call dev_mc_add
with a 6-byte buffer.
I think that the ARPHRD check should be right before calling dev_mc_add.

Currently, GARP is only used by VLAN, which means your suggestion would technically work,
but this assumption might be violated by future protocol implementations like GMRP, which
could potentially resurface this bug.

> 
> > +		goto err1;
> > +
> >  	if (!rtnl_dereference(dev->garp_port)) {
> >  		err = garp_init_port(dev);
> >  		if (err < 0)
> > diff --git a/net/802/mrp.c b/net/802/mrp.c
> > index e0c96d0da..1efee0b39 100644
> > --- a/net/802/mrp.c
> > +++ b/net/802/mrp.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/skbuff.h>
> >  #include <linux/netdevice.h>
> >  #include <linux/etherdevice.h>
> > +#include <linux/if_arp.h>
> >  #include <linux/rtnetlink.h>
> >  #include <linux/slab.h>
> >  #include <linux/module.h>
> > @@ -859,6 +860,10 @@ int mrp_init_applicant(struct net_device *dev, struct mrp_application *appl)
> >  
> >  	ASSERT_RTNL();
> >  
> > +	err = -EINVAL;
> > +	if (dev->type != ARPHRD_ETHER || dev->addr_len != ETH_ALEN)
> > +		goto err1;
> > +
> >  	if (!rtnl_dereference(dev->mrp_port)) {
> >  		err = mrp_init_port(dev);
> >  		if (err < 0)
> > -- 
> > 2.39.5
> > 
> > 

