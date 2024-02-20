Return-Path: <netdev+bounces-73380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A669C85C350
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 19:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE13AB23522
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 18:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF143779F0;
	Tue, 20 Feb 2024 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8csPElg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB8E76C70
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452356; cv=none; b=jjQgBEpQpuZE5dGjYjq7VLPdpqMIY9dUBLd/O5EEYmIHV8wo4ByQMp98iSPtKtO/2G7yaCUJfHL4vn0J2ky1ijGbGLxkKPx3PqLavWBXWhBRnQK3mjoHYlDlxTPgPSl1pr/naSO62+otK9dg62+bxCvfmfs5WaYm409nbP31Q4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452356; c=relaxed/simple;
	bh=7WDWZ3xVOCtPvxw5YvZObLikDkLEhC5zrw4/cCPbSac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok0ADVgW/vs6LCpzKdvYMW02pmBI/2I67luw/V7uDMIHADzMTMaqIdEJe7C1ARJiyoVYBdforpkkSX55exIEFiR/JzYhO59uVEzhWcmiyxeiKFvyNHLwnqwOHwuNknhHdUvCF5cZT+EoZmVlHS8wttRueAubete7KMlQBqWsZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d8csPElg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708452354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uoQ7ZD634mLeO2a5g5a9LcBPxa8AGvETdNLdFSlbHHU=;
	b=d8csPElg3TgzqS2qNe6+iSSQ1dy6pvCAcDS9/uCsvom6J+gnyGtNKoXLNCrSKqD2sTok6F
	NUkChDg7Q1NFAND4++gVPnfGbjMAJBDZIChN0b3A5ZEGyv01tKMjgSBpyxu7yVN0VmH+zO
	41FUZElWhDR5z+3gD1QTHumb5UHf4C4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-ivhuJRXtMJGkPe_1sEBh5A-1; Tue, 20 Feb 2024 13:05:52 -0500
X-MC-Unique: ivhuJRXtMJGkPe_1sEBh5A-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d5074a05eso1030668f8f.3
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 10:05:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708452351; x=1709057151;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uoQ7ZD634mLeO2a5g5a9LcBPxa8AGvETdNLdFSlbHHU=;
        b=INFj1vm2LrlJiVkHMD4klTpzkAaeRgy7PnE+wXrvfpCooCeuUNtmCcdsm/35w0j42R
         sGLmQXhL4Kr/Qmxfw+5JBaWwmqLQjaj035KsAQzi9mry1KK6W8o3qZKFKXE3XXfUp89/
         6qghfNkyQtuxpra0wQEcZbtJlMG8ZTAhGNqv13KdO4M+ELQJEpwtB3L/0MJEskOzLgUu
         wIohbtlTp9WJyhaFAc6/IsnJemQEtcLh78JYR4INH7KoPq0MnrjkPw+LuzbN87llCXWk
         E3yTWyzGPRH1s5TsvZRtB/BkPCfSo/azDLWkpHWGdvPai2f0A5bfjX2lyYZhb2v0yEah
         KfMw==
X-Forwarded-Encrypted: i=1; AJvYcCVMwRVtzWF+gXMdNAhZ4UrMcj+2vvemGdhG0VSwnZrugix5tqtJ7ckbiJXDUbIgYxoMYOjPlL1o/af7JEaaWn4mNGVuGXiy
X-Gm-Message-State: AOJu0YwE95jsc2oqDWHLukaoy50uT9ZV0w3hnE3BC4f151JWt247SAcH
	cT8uciZ9CiZ/T3YogitzDRikMcOqSKCwBhnhKV1GnPNOr3nLya3i4VzDOS05BWzNPNDkFrVwCBk
	YYOSJ8fNMTRWfG+EdNeEa8GKbFcNb9lciI95IVJ7/zfF5DZMzpKrVfA==
X-Received: by 2002:a5d:5645:0:b0:33d:3b82:ab2a with SMTP id j5-20020a5d5645000000b0033d3b82ab2amr5763421wrw.19.1708452351351;
        Tue, 20 Feb 2024 10:05:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT8HPGXtmeAx5ZvlUTUILh5dkmcmg9dNbay1klbPUGWBUdh8jxIshmoH9DaAjlfADf1MgEpA==
X-Received: by 2002:a5d:5645:0:b0:33d:3b82:ab2a with SMTP id j5-20020a5d5645000000b0033d3b82ab2amr5763406wrw.19.1708452350956;
        Tue, 20 Feb 2024 10:05:50 -0800 (PST)
Received: from redhat.com ([2.52.10.44])
        by smtp.gmail.com with ESMTPSA id q4-20020adfab04000000b0033cf637eea2sm14341300wrc.29.2024.02.20.10.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:05:50 -0800 (PST)
Date: Tue, 20 Feb 2024 13:05:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"abeni@redhat.com" <abeni@redhat.com>,
	Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
Message-ID: <20240220130528-mutt-send-email-mst@kernel.org>
References: <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
 <20240201202106.25d6dc93@kernel.org>
 <CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
 <20240202080126.72598eef@kernel.org>
 <CACGkMEu0x9zr09DChJtnTP4R-Tot=5gAYb3Tx2V1EMbEk3oEGw@mail.gmail.com>
 <20240204070920-mutt-send-email-mst@kernel.org>
 <CH0PR12MB8580F1E450D06925BEB45D72C9452@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240207151748-mutt-send-email-mst@kernel.org>
 <CH0PR12MB8580846303702F68388E9713C9452@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CH0PR12MB85807A30B1F42A4E354516A1C9502@CH0PR12MB8580.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH0PR12MB85807A30B1F42A4E354516A1C9502@CH0PR12MB8580.namprd12.prod.outlook.com>

On Tue, Feb 20, 2024 at 06:02:46PM +0000, Dan Jurgens wrote:
> > From: Daniel Jurgens <danielj@nvidia.com>
> > Sent: Wednesday, February 7, 2024 2:59 PM
> > To: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>; Jakub Kicinski
> > <kuba@kernel.org>; Jason Xing <kerneljasonxing@gmail.com>;
> > netdev@vger.kernel.org; xuanzhuo@linux.alibaba.com;
> > virtualization@lists.linux.dev; davem@davemloft.net;
> > edumazet@google.com; abeni@redhat.com; Parav Pandit
> > <parav@nvidia.com>
> > Subject: RE: [PATCH net-next] virtio_net: Add TX stop and wake counters
> > 
> > 
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, February 7, 2024 2:19 PM
> > > To: Daniel Jurgens <danielj@nvidia.com>
> > > Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake
> > > counters
> > >
> > > On Wed, Feb 07, 2024 at 07:38:16PM +0000, Daniel Jurgens wrote:
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Sunday, February 4, 2024 6:40 AM
> > > > > To: Jason Wang <jasowang@redhat.com>
> > > > > Cc: Jakub Kicinski <kuba@kernel.org>; Jason Xing
> > > > > <kerneljasonxing@gmail.com>; Daniel Jurgens <danielj@nvidia.com>;
> > > > > netdev@vger.kernel.org; xuanzhuo@linux.alibaba.com;
> > > > > virtualization@lists.linux.dev; davem@davemloft.net;
> > > > > edumazet@google.com; abeni@redhat.com; Parav Pandit
> > > > > <parav@nvidia.com>
> > > > > Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake
> > > > > counters
> > > > >
> > > > > On Sun, Feb 04, 2024 at 09:20:18AM +0800, Jason Wang wrote:
> > > > > > On Sat, Feb 3, 2024 at 12:01 AM Jakub Kicinski <kuba@kernel.org>
> > > wrote:
> > > > > > >
> > > > > > > On Fri, 2 Feb 2024 14:52:59 +0800 Jason Xing wrote:
> > > > > > > > > Can you say more? I'm curious what's your use case.
> > > > > > > >
> > > > > > > > I'm not working at Nvidia, so my point of view may differ
> > > > > > > > from
> > > theirs.
> > > > > > > > From what I can tell is that those two counters help me
> > > > > > > > narrow down the range if I have to diagnose/debug some issues.
> > > > > > >
> > > > > > > right, i'm asking to collect useful debugging tricks, nothing
> > > > > > > against the patch itself :)
> > > > > > >
> > > > > > > > 1) I sometimes notice that if some irq is held too long
> > > > > > > > (say, one simple case: output of printk printed to the
> > > > > > > > console), those two counters can reflect the issue.
> > > > > > > > 2) Similarly in virtio net, recently I traced such counters
> > > > > > > > the current kernel does not have and it turned out that one
> > > > > > > > of the output queues in the backend behaves badly.
> > > > > > > > ...
> > > > > > > >
> > > > > > > > Stop/wake queue counters may not show directly the root
> > > > > > > > cause of the issue, but help us 'guess' to some extent.
> > > > > > >
> > > > > > > I'm surprised you say you can detect stall-related issues with this.
> > > > > > > I guess virtio doesn't have BQL support, which makes it special.
> > > > > >
> > > > > > Yes, virtio-net has a legacy orphan mode, this is something that
> > > > > > needs to be dropped in the future. This would make BQL much more
> > > > > > easier to be implemented.
> > > > >
> > > > >
> > > > > It's not that we can't implement BQL, it's that it does not seem
> > > > > to be benefitial - has been discussed many times.
> > > > >
> > > > > > > Normal HW drivers with BQL almost never stop the queue by
> > > themselves.
> > > > > > > I mean - if they do, and BQL is active, then the system is
> > > > > > > probably misconfigured (queue is too short). This is what we
> > > > > > > use at Meta to detect stalls in drivers with BQL:
> > > > > > >
> > > > > > > https://lore.kernel.org/all/20240131102150.728960-3-leitao@deb
> > > > > > > ia
> > > > > > > n.or
> > > > > > > g/
> > > > > > >
> > > > > > > Daniel, I think this may be a good enough excuse to add
> > > > > > > per-queue stats to the netdev genl family, if you're up for
> > > > > > > that. LMK if you want more info, otherwise I guess ethtool -S
> > > > > > > is fine
> > > for now.
> > > > > > >
> > > > > >
> > > > > > Thanks
> > > >
> > > > Michael,
> > > > 	Are you OK with this patch? Unless I missed it I didn't see a
> > > > response
> > > from you in our conversation the day I sent it.
> > > >
> > >
> > > I thought what is proposed is adding some support for these stats to core?
> > > Did I misunderstood?
> > >
> > 
> > That's a much bigger change and going that route I think still need to count
> > them at the driver level. I said I could potentially take that on as a background
> > project. But would prefer to go with ethtool -S for now.
> 
> Michael, are you a NACK on this? Jakub seemed OK with it, Jason also thinks it's useful, and it's low risk. 


Not too bad ... Jakub can you confirm though?

> > 
> > > --
> > > MST
> 


