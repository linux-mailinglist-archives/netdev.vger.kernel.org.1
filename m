Return-Path: <netdev+bounces-106996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6869186FF
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 18:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B665C1F2253E
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0654E18E777;
	Wed, 26 Jun 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="COXWvncz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B0018EFCC
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418232; cv=none; b=cTj8C2UKt6F376nnV//WBPBl8KCqD/BSFEPqNhME3fPzRCZvbUtHaCB4nBER+KVFk5mD/rIXW+uZzIw4zumm7RSu4yZ5lnMz009XRYAK9l1f/wrJnhAq6RFSFrZwIK7Y02Xd3meS+RDj9VzdhmQLAqvgbM9pym8Qu2lk+7+I9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418232; c=relaxed/simple;
	bh=akRn6d8jvAi6S+sjA2AvP4fyQ1pOHaRbAQHrzLBOGwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=naFC4lYzSQ1kYbSN3dt95OmlFP5KE6ipBNRU54oQNbKY4uYD/6rHB0snisejix3LwBnzQ6vFfH0taw/9Z65feVPfclpoybeky4XF2a/qytIPGXUtPU1bwfOfvktTqWTQV1puDtke+ztgcQ6w6oKlhe9zenY3quH7uHQW7/wLsnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=COXWvncz; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fa07e4f44eso39462365ad.2
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1719418230; x=1720023030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+yHv7NBW7oyR5/Pl36V4fmIwxGxwzyDxHzUanHXUwQ=;
        b=COXWvnczCfOUhj2ajJlVjHaunfsodPK7G4gALXXCFqZGJZ3JzjYGA6iEt3qdr8T7L9
         p0lb3qG3XC1z7STYGkjjgYlFuzlDvZnlQEKeL0hbf+5+Dlbv64a/Z6KegqWGOblEo4sc
         eAFzyrvoMS60g6Yj7QsANtUrIoI3vQD4wuaQbfmnTDUKEzWob6ic/3gVRoQPnCv3ihfT
         N4Z1v+g3hrNaCKPcL6+KuwDnT9v53BekYUQcjkBcr1TFoZ9QKYsz/9A60Xu0VgGsXDoD
         Q0CfIauRDVNbDIMqx/YZR4VtLhDP30LNzUbvuQw8uqNAcq9CX7Aa0rFuaO7ipw0ROxiQ
         uVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719418230; x=1720023030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+yHv7NBW7oyR5/Pl36V4fmIwxGxwzyDxHzUanHXUwQ=;
        b=EJEn1l9ce3jTtX5SEdqg91byh3aVpTz/J+BkvkRpgA3eGF3vZafar0Vd0EmBAPnNWd
         wrDVdOxOn20jsUB8+POTwW7EmwaFzrxV4F6lLhZbI9YkTGVOsVwIr7HD0rKPijeEHQX0
         wJLI8yCiJpLzRbfsBJX5nq0ZL8hl2AqYO1aqcWb71dKR1ZQDBBfJFpxL5tvEaLYpbRfr
         qASVqU3eHtQU7DY3rb7auQ4M215fSf4yrNSjKnzHkq2tpp+llLuMcLdxzDCobaXYhrJc
         2z8VyHUfEIcjnE43mjZRTiV7JgpZLltHc1ko3g1F/rI2NKPmoVd7+aco4gjqtJ4gIoDW
         1Lsw==
X-Forwarded-Encrypted: i=1; AJvYcCUM2lts8RQAWsJT0v9iK3xgdpcJOIzqHekfDa4LvsQIgv8PI+j48VZD1uDH7dfI/Anp8brdsAeC3lIedZb6OU/Xj9GNSjRo
X-Gm-Message-State: AOJu0YyW3IjXJnqY3YjHzm4FmbsEtCni1SgkUlgrqqWVIIbROeQAvbi1
	FKwtHZZpwwNQ9Gd07MNd1VZUWLTAX3Y8layCUC15K0L4Y2EV7nHOji001YNSkxI=
X-Google-Smtp-Source: AGHT+IFfsbEVdvCNCbcIimbmFIq3pNiZ+Go682fp12VuGvUAJvJpsYTOKQn51BeXcBgplalkpsaOEQ==
X-Received: by 2002:a17:902:ccce:b0:1f7:19b4:c7f5 with SMTP id d9443c01a7336-1fa238e44f8mr134434345ad.12.1719418230452;
        Wed, 26 Jun 2024 09:10:30 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d43f6sm101285735ad.182.2024.06.26.09.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 09:10:30 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:10:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Konstantin Taranov <kotaranov@microsoft.com>, Konstantin Taranov
 <kotaranov@linux.microsoft.com>, Wei Hu <weh@microsoft.com>,
 "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, Long Li
 <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, linux-netdev
 <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Message-ID: <20240626091028.1948b223@hermes.local>
In-Reply-To: <20240626153354.GQ29266@unreal>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
	<20240626054748.GN29266@unreal>
	<PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
	<20240626121118.GP29266@unreal>
	<20240626082731.70d064bb@hermes.local>
	<20240626153354.GQ29266@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 18:33:54 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> On Wed, Jun 26, 2024 at 08:27:31AM -0700, Stephen Hemminger wrote:
> > On Wed, 26 Jun 2024 15:11:18 +0300
> > Leon Romanovsky <leon@kernel.org> wrote:
> >   
> > > On Wed, Jun 26, 2024 at 09:05:05AM +0000, Konstantin Taranov wrote:  
> > > > > > When mc->ports[0] is not slave, use it in the set_netdev.
> > > > > > When mana is used in netvsc, the stored net devices in mana are slaves
> > > > > > and GIDs should be taken from their master devices.
> > > > > > In the baremetal case, the mc->ports devices will not be slaves.    
> > > > > 
> > > > > I wonder, why do you have "... | IFF_SLAVE" in __netvsc_vf_setup() in a first
> > > > > place? Isn't IFF_SLAVE is supposed to be set by bond driver?
> > > > >     
> > > > 
> > > > I guess it is just a valid use of the IFF_SLAVE bit. In the bond case it is also set
> > > > as a BOND netdev. The IFF_SLAVE helps to show users that another master
> > > > netdev should be used for networking. But I am not an expert in netvsc.    
> > > 
> > > The thing is that netvsc is virtual device like many others, but it is
> > > the only one who uses IFF_SLAVE bit. The comment around that bit says
> > > "slave of a load balancer.", which is not the case according to the
> > > Hyper-V documentation.
> > > https://learn.microsoft.com/en-us/windows-hardware/drivers/network/overview-of-hyper-v
> > > 
> > > You will need to get Ack from netdev maintainers to rely on IFF_SLAVE
> > > bit in the way you are relying on it now.  
> > 
> > This is used to tell userspace tools to not interact directly with the device.
> > For example, it is used when VF is connected to netvsc device.
> > It prevents things like IPv6 local address, and Network Manager won't modify device.  
> 
> You described how hyper-v uses it, but I'm interested to get acknowledgment
> that it is a valid use case for IFF_SLAVE, despite sentence written in the comment.

There is no documented semantics around any of the IF flags, only historical precedent used by
bond, team and bridge drivers. Initially Hyper-V VF used bonding but it was impossibly
difficult to make this work across all versions of Linux, so transparent VF support
was added instead. Ideally, the VF device could be hidden from userspace but that
required more kernel modifications than would be accepted.


