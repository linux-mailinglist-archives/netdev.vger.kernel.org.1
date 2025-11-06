Return-Path: <netdev+bounces-236151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE16C38E17
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 03:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32983A5EBB
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 02:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EC51F1513;
	Thu,  6 Nov 2025 02:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AR2441du"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8726ACB
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 02:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396471; cv=none; b=tVEGe0Gn8Cc26vWoQt4yYD6HliRwoItn6gmRUNu9aKlqt3Lg6iRDreqBZcyxO3AWscOXUZ8eF6Dv7VaEoMuET7JOZ6WMFcWBbNvAPgCwkffzIeK5PJ6A1QtGsz8soYrh/ds2TLW9fAbqy3dOc+ejepwrsJXKS6Q95wiwsIXqQ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396471; c=relaxed/simple;
	bh=/0HeCEvC5ywVc1TxZhy5m0xXX0gMHssWLciURgR/kg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZwOHfMVtgcE3V80uwOqTpFe2tmnNzvckvaKSn0wAdUSAnySe+kY+MGiwks3TbMiyDW+fIV57Yeon6adF6MHiDbkoZTO35yBtfrCN4RiTLK2owdrK0jfIPcRqwdk7niS4JjnKapjEB6q7+J/Un6x+ufxQNwE1bh2p9Ep21BDgi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AR2441du; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so499529b3a.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 18:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762396469; x=1763001269; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=txcWfZhuPwzhOSfp8WaRWU09u1I97f97wCumcVKVe7w=;
        b=AR2441duQcB7gTciGeufYF4RPAFLFKLu8vWiB9Vytg4r/lKZgW3FEK+IOETvNnOgsA
         ChAal5k+5sP3A2LczQ37t4Kmsvv44KAbmidVm7fOtOzTj/H3d/UNVLlFTRvUsx7Lidtd
         xEp8jmGp6OHA0lHagLnl8L6oDUHwL2BqpRGODdY+r3WB2xXWRotQXaWF0v1Rd3pIrjQH
         0058jGft2kyCKeeQeZgeM0697aRujehKBP117PeC1cOqIkyJ5cMgp3BbT3db+BvycXzc
         V8qft8aYraBNjHl7lo2Vrdli7VS2SaWENdKRz3NwTfcddvlgAypDHRaScEdC8yyBOXqx
         p2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762396469; x=1763001269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txcWfZhuPwzhOSfp8WaRWU09u1I97f97wCumcVKVe7w=;
        b=otfYLbVt94I6Xse4UQBeObCD7KW78TpW6bcN/+G2hD5sPsusArRxp7Qw4cnU+/gfbX
         w3/gsazt20Emk4jUZXGFUaELJiSCzYX0CKemQlW2dtVzvG9wDi0Gsz+86qxN5rsky6tt
         SSOezKCdc4DVyxsxdpsYoyRCgjRIBigH9AMpOMf+2x1jibUMYVhwC3dVd1YKQRGuyhTX
         wFckDj90tn+foHAbJ+sVM8Dp0HM0KXI7ID/m6Q0VEJIspB4UGXgAHcgvG7DXS9sh9Kzu
         TBvA4XUFcRKtn7oSOwUX+uIYuIvNCkbesGMHWMxtv2D9/HyER/FeAvq6SJ0VNsjCBYNZ
         zKWA==
X-Gm-Message-State: AOJu0YwKyqXtlUJX1wLnzC0EJYsLToip3xNmbfr63514VjCc3oAygIib
	sHBD4w9XSW+DeMpJOEPQCE1XucGdv2GOLFjSc6zc59n2o3w63S6qnk+w
X-Gm-Gg: ASbGncsaKcmHzDPwy/YFZTbM+v7yQMwyrj4l90Sq+kITA9k88ZMQ8IXngMKH09hOe0S
	KPAnlq2UGrXNq86xeuZ3pVvwk2CRslVfKlJrWy5AaKWpIxuy9DgMSFa1vIohpigDaSe/GsjhlX8
	NrHC38nYeqicSzcoN98c3Xp4RUCeFNPaZPigdA39XyiuX2/DPuJDStVtd4I2SGSOaxZrBhzAMrs
	70Pf10La4hHO4IepKiWGWbaXZAtp0jtYQdjukwhH0Z0VtXKXg7asGbkJeep8fZb4l38VOtY9pEq
	r5LORlc+u9plLvPjlwPR5E9GhBKw0U/rQ66jN4g+CKPQ3UB7hCrc+PIa0/WDQ+UC5qyGUahukpr
	zQF9XDioVKv7jXEIIZsImbMaPewQnxsHcia1qibYcA44GWNmueO3hVdy+m0Hbcd/OnTc04+6wrR
	Q6If5D
X-Google-Smtp-Source: AGHT+IEfL26ZpZwL+4ELjq2rRZeUe/MDbipLVfw3WCSyW00F6fVlo0CjA3/x1cnexjpQmNFiTwxw3A==
X-Received: by 2002:a05:6a00:929b:b0:7ac:3529:afbb with SMTP id d2e1a72fcca58-7ae1f293af6mr5589400b3a.20.1762396469248;
        Wed, 05 Nov 2025 18:34:29 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af826f9520sm824784b3a.56.2025.11.05.18.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 18:34:28 -0800 (PST)
Date: Thu, 6 Nov 2025 02:34:20 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] netlink: specs: update rt-rule src/dst
 attribute types to support IPv4 addresses
Message-ID: <aQwJLKka-_pBGq_g@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
 <20251029082245.128675-3-liuhangbin@gmail.com>
 <20251029163742.3d96c18d@kernel.org>
 <aQnG8IYsY3oyYekf@fedora>
 <20251104164804.540a9b8d@kernel.org>
 <aQsDA7ufLlIwSf1h@fedora>
 <20251105161319.0591f96e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105161319.0591f96e@kernel.org>

On Wed, Nov 05, 2025 at 04:13:19PM -0800, Jakub Kicinski wrote:
> On Wed, 5 Nov 2025 07:55:47 +0000 Hangbin Liu wrote:
> > > > I just realize that most of the address/src/dst in rt-addr/route are
> > > > dual stack. The same with FRA_DST. We can't simply change binary to u32.
> > > > So can we keep this u32 -> binary change?  
> > > 
> > > Ah, should have looked at more context..
> > > Yes, and in that case without the display-hint?  
> > 
> > The display-hint is required; otherwise, the displayed src and dst fields
> > appear as binary data, and setting the rule’s src/dst values also fails. I
> > haven’t checked the code yet, but with
> >   - display-hint: ipv4
> > the IPv6 addresses are also displayed correctly :)
> 
> Heh, we should have called the hint "ip" in that case :)

I saw the display hit supports "ipv4-or-v6", but genetlink-c.yaml doesn't
have "ipv4-or-v6". Do you know why?

# grep -rn fddi Documentation/netlink
Documentation/netlink/genetlink.yaml:188:                enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
Documentation/netlink/genetlink-legacy.yaml:157:                enum: [ hex, mac, fddi, ipv4, ipv6, ipv4-or-v6, uuid ]
Documentation/netlink/netlink-raw.yaml:160:                enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
Documentation/netlink/genetlink-c.yaml:230:                enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]

Thanks
Hangbin

