Return-Path: <netdev+bounces-181431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA71A84F8A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 00:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B20C4C79AD
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 22:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC31E20C47B;
	Thu, 10 Apr 2025 22:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkYh24IS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1111BAD5E;
	Thu, 10 Apr 2025 22:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744323335; cv=none; b=euuxiwl9POjdmnaoz3o9L/UkLkGQqB4vvMpQ3YgpBsxsuZokY1v+QA7p1jfeidVIcwfjdM9qffMY6WpHLPfiTOP7Nslltk/GZZewcRzpVBqltTQEzmQq+Cv2E6GhXcsSHOmawLg4uAuPdyWeVWuajpXKcM7StMjXBA07UkQZD/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744323335; c=relaxed/simple;
	bh=eD7OpbrV355NOsVgIK+u+xFAJHuoZLTjFTxvYn3y7kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkSqFtDIGMu5XIiten+Db2t+BCWaPuPU0LFnPhaJLfOqbA2L0rN/La+AO9eXqyQ5Q2fCgfCczeiHQwtCWEtPkw3pdBu4ToG/tLFxQJGFoLBzcnUSsEtq9BB6CPEN13fxMkLXePFVOfwYK1KC2Xs2pEChZ5w1zxyESy3GgxHpQrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkYh24IS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso14645555e9.1;
        Thu, 10 Apr 2025 15:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744323332; x=1744928132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2D0fm6noiDhUqbW229izXLjEq5gR5IU1/g8b5nJLWms=;
        b=RkYh24ISbo9RkfQU0dZlXu3EXNQo7RUSnionBaRfRBBcp2inqlZF36mCVjQ46sjDhc
         QChEqEriNep5CmLl5Jz3jOuUIVjNcbqFuc2d6i3/xfLqsCnkJkMtRLJoUNBsO/VIyUYs
         ZnrbEzPFrH7VbSx0UpMOWlNPmQPuV7fl3/H2+/+6LUOLf3Yn+YNj8Mm3D7E3aa7CGPU5
         Z0ZFi+z2/wdb4Jp2M0h2c0+/eWUJOYywlgEKi2J0D7D1isJ1Q2y7mNRdI7/rA4MzDY8s
         crhjf/8OuntNy3xGS7KOjGBciFlSWbwWqwYhOSBx6euTMHrxHrjdxbOi45R9z9FA8B0H
         Cj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744323332; x=1744928132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2D0fm6noiDhUqbW229izXLjEq5gR5IU1/g8b5nJLWms=;
        b=eh3fCqnlLH4iXvTCPwac21L965Q8IkKTqOSxFmppylwg2JbMjpLJA1V9WXCQ5+fEyK
         gv48oSwj26tkn7Gjm8ExwvnEJZiVzdjQnFxtIN45bgKNNHgTIpCIvPy7I96AeaCfmiW6
         5mVOX+4MkAPv09J9aWbs7KZ2WiWNWiLFwRgNpcDWmxBC34m95NxqT9PYlETBW+0oCJPB
         SHvpSZiEH5f7tp1mAzQVu9AJjY9VwvjuuFwFghpgnYKMrwaoqxWza2FvTyyMyZ6bKLiA
         YnEUvbrnYWTYm+Bjx/AU+h84XtzS7d9m56CQqPcYwQPQtQ9L2Su09LAIcSotR1eQsf17
         GqLg==
X-Forwarded-Encrypted: i=1; AJvYcCUU/VKL3+KGMKVwANWLbClXk/RrM9p+3ZrO59EcCeuyGwIlluXoVwWiME76TpKJHWsVTT0UBOfYAEaKXUo=@vger.kernel.org, AJvYcCUnOZuqDiW809C2kTpn7tXwJ4e78AAkNYYg8xF11egYnUOOuHJgT3zFb3Qa23tOQRxcRLW6ihYI20dg@vger.kernel.org, AJvYcCXuorECJr9W7K//DFdkZtrGyKmUtqUJRYuY97sjc+dt+eKftExj8MIPBbEwwBL6ETBIXlASQ3Ld@vger.kernel.org
X-Gm-Message-State: AOJu0YzgXISl6pvdpttlDj5E4ukBvu3uSVEIQ0iMpK+KkOKxgNHt/jX1
	LPN0h6Y9//ACWvnMQ9Ay2aOeT4sJ4Lp0lRX1oV9EnbiqdXOYTlZH
X-Gm-Gg: ASbGncv+GP0+V+XavxzJyO6YML8eECd+927f3L+6ldsZNsHFbjVJWSuQbx1hS9gP44X
	MgQe2QeEymNo9gsfDyoAhfnf2I1Vhrtpd50f+YJG2EcCJ4TTEdQxPGA/d6y/jiFxOSUsnuPBLxt
	5gi9d6YLHhE3Nokf6k3b2gis/pTPkZEsTMhck1P+hJBPDUy/4AcAC3j68LGoqbmLNtxY5Dnb+29
	BPepIEgoQBDEBpKS2skQnuajQcwjZIc/ytU+glmAyVw7aXF2PwiobfVeHilkuhU5JHHjatKkMpb
	+RlRfmt4gUcMmN/vkpxsO4pW94qwbeDJ2eUSDjG9EMNY
X-Google-Smtp-Source: AGHT+IGFZ4o1lTVxW+yAhuxVsX9mcVfiNdXCNZsSNdzp8rAl0RUCEbUwySvdn6Xq8tbTeM0CQsze8A==
X-Received: by 2002:a5d:59a3:0:b0:390:e1e0:1300 with SMTP id ffacd0b85a97d-39eaaea4548mr215313f8f.33.1744323332170;
        Thu, 10 Apr 2025 15:15:32 -0700 (PDT)
Received: from qasdev.system ([2a02:c7c:6696:8300:a7c3:c7a5:ff1b:f4fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf445270sm151066f8f.81.2025.04.10.15.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 15:15:31 -0700 (PDT)
Date: Thu, 10 Apr 2025 23:15:23 +0100
From: Qasim Ijaz <qasdev00@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
Subject: Re: [PATCH 1/4] net: fix uninitialised access in mii_nway_restart()
Message-ID: <Z_hC-9C7Bc2lPrig@qasdev.system>
References: <20250319112156.48312-1-qasdev00@gmail.com>
 <20250319112156.48312-2-qasdev00@gmail.com>
 <20250325063307.15336182@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325063307.15336182@kernel.org>

On Tue, Mar 25, 2025 at 06:33:07AM -0700, Jakub Kicinski wrote:
> On Wed, 19 Mar 2025 11:21:53 +0000 Qasim Ijaz wrote:
> > --- a/drivers/net/mii.c
> > +++ b/drivers/net/mii.c
> > @@ -464,6 +464,8 @@ int mii_nway_restart (struct mii_if_info *mii)
> >  
> >  	/* if autoneg is off, it's an error */
> >  	bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);
> > +	if (bmcr < 0)
> > +		return bmcr;
> >  
> >  	if (bmcr & BMCR_ANENABLE) {
> >  		bmcr |= BMCR_ANRESTART;
> 
> We error check just one mdio_read() but there's a whole bunch of them
> in this file. What's the expected behavior then? Are all of them buggy?
>
 
Hi Jakub
    
Apologies for my delayed response, I had another look at this and I
think my patch may be off a bit. You are correct that there are multiple
mdio_read() calls and looking at the mii.c file we can see that calls to
functions like mdio_read (and a lot of others) dont check return values.
  
So in light of this I think a better patch would be to not edit the 
mii.c file at all and just make ch9200_mdio_read return 0 on     
error. This way if mdio_read fails and 0 is returned, the         
check for "bmcr & BMCR_ANENABLE" won't be triggered and mii_nway_restart
will just return 0 and end. If we return a negative on error it may
contain the exact bit the function checks.

Similiar to this patch:
<https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=c68b2c9eba38>

If this sounds good, should i send another patch series with all the
changes? 

> This patch should be split into core and driver parts.
> -- 
> pw-bot: cr

