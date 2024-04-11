Return-Path: <netdev+bounces-86870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9514A8A089C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 08:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23489B20E99
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 06:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E07013D60A;
	Thu, 11 Apr 2024 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DA7PbQm0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E10213CA9C
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 06:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712817581; cv=none; b=ebspb0LXFU5kIzpWdSct+JYVHEGShCO0SO6VPjiIYJuX760MpFaRyA6/NBEzLRk7xPlD7fScSPOgtTR/SUE9DjeGQoZl2D3lJgbzWyBForolR5qujtmcLwirNRHAwK+S9GB2bdiSaBE3mII40EYXyXeq0UDun2ZkOeML0gPZ3m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712817581; c=relaxed/simple;
	bh=npWe+bs1tluTxELJVg4uRxupj2EbfLou25t2yt6eHGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKg1fZzBrZWzDm9xfMzFyMPRvC2s1MDxk3vLPS2ocSzgcvxaVfiC0/4NX1usNnkSZ8OnX6KD9S95htK0bc60o7RqfclQuGRdurCTSSnI7DkiVuihB7aD1XacjKI5lq/ZAL/mwSac+vCXH3WQb2sWfIMBFqmhX6prQiOr2JQof0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=DA7PbQm0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a52140ea1b5so154825666b.1
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 23:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712817577; x=1713422377; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CLEhKjTBYYSzqpvs3oidNdffm+PATdvhj+mdGT9W/00=;
        b=DA7PbQm0eEgFZlLH0ZorgTwv5OTidbP1NoHCou2FLmtzSjo565BsewakMGLKszNFwE
         amQSgUVDS7HGUuEfwhpXbfktNkb7xH7jth5dN3mQYv1LtufSjeIPHqFXinp4x45BU25S
         7FhpOU3pZYCNAkHPtWDWWWxTRegslke7h5pqqwXxG+855P3jiROCkPVqZNmzBau3GnHP
         rLjwQ9K4QFAPufWIevfA/M7ISWbE7GsUfQ+WJQs6z/31vKpNnCXCstH8WDZyIejaiX9Y
         uvcE67YaiWLM79lHMP5Qn4IqV6+WLBPU9gPSqQJOFKXpvranOibPvxzDRnAnKI6V4bz4
         AMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712817577; x=1713422377;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLEhKjTBYYSzqpvs3oidNdffm+PATdvhj+mdGT9W/00=;
        b=xLKvTAb+0QJE0Xw2oIhBM9krSDZok4cGvXpd7Gmhz/L5z9gfIDS4DJP0Edrzx58qOd
         oubaHw4u+TVufmUW9BzVipZrQo3oRNlKeCd1YYX6uQW+UsGjUDbkxpw4I4HvbJ3NEAok
         cEjFI4vp5r8HEu8+uxb6FLtIvoAVZcqEkIO0UnLU0AYLpGhcpsKiOqLMw+adFO6AW+R/
         MdhAra292few1mDGg2HQ4DunhivJK/su1n118zS87VnbgGxtHVTydsGyF5YO1IZd46TI
         VcvD0wVMA4xV/One/uvtxXtU5kfR/57tOh2yBIPwXr1O+t1E8kZwzCUV5QlKxTMpCmOU
         9/VA==
X-Forwarded-Encrypted: i=1; AJvYcCXNgqA70avc9uflgYmCBeFDIQm1eQr0vh2pnEgp3zLh7KIBJy5oOI9baJ4SIkV/wSlVK/eGGAn3rJ0eK3TCnTRDG0NpRKJi
X-Gm-Message-State: AOJu0YwxGmXpA+aMVcIwoDQHTbH1KnZoK6bqYPlc88AbVk+0wkR0/n9c
	KmfhL0MPzS6OAd7wZXnKB4xnIcMRhWnP7A/aJVnGHAJsXB6C1AMp6IoQ0Lp5kSo=
X-Google-Smtp-Source: AGHT+IFpYvKPdJnGf0YpmT4OSVh4n8gdmu1Sex6/8w5++RlibDPjjob7o/e9BQmj6XILXtNewiFV0g==
X-Received: by 2002:a17:906:509:b0:a4e:679b:8437 with SMTP id j9-20020a170906050900b00a4e679b8437mr2213954eja.59.1712817577532;
        Wed, 10 Apr 2024 23:39:37 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id jy3-20020a170907762300b00a521603e14csm441715ejc.138.2024.04.10.23.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 23:39:37 -0700 (PDT)
Date: Thu, 11 Apr 2024 08:39:35 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	pabeni@redhat.com, John Fastabend <john.fastabend@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <ZheFp_Sf66DpaFFm@nanopsycho>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org>
 <44093329-f90e-41a6-a610-0f9dd88254eb@lunn.ch>
 <CAKgT0UcVnhgmXNU2FGcy6hbzUQZwNBZw0EKbFF3DsKDc8r452A@mail.gmail.com>
 <c820695d-bda7-4452-a563-170700baf958@lunn.ch>
 <CAKgT0Uf4i_MN-Wkvpk29YevwsgFrQ3TeQ5-ogLrF-QyMSjtiug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0Uf4i_MN-Wkvpk29YevwsgFrQ3TeQ5-ogLrF-QyMSjtiug@mail.gmail.com>

Wed, Apr 10, 2024 at 11:07:02PM CEST, alexander.duyck@gmail.com wrote:
>On Wed, Apr 10, 2024 at 1:01 PM Andrew Lunn <andrew@lunn.ch> wrote:
>>
>> On Wed, Apr 10, 2024 at 08:56:31AM -0700, Alexander Duyck wrote:
>> > On Tue, Apr 9, 2024 at 4:42 PM Andrew Lunn <andrew@lunn.ch> wrote:
>> > >
>> > > > What is less clear to me is what do we do about uAPI / core changes.
>> > >
>> > > I would differentiate between core change and core additions. If there
>> > > is very limited firmware on this device, i assume Linux is managing
>> > > the SFP cage, and to some extend the PCS. Extending the core to handle
>> > > these at higher speeds than currently supported would be one such core
>> > > addition. I've no problem with this. And i doubt it will be a single
>> > > NIC using such additions for too long. It looks like ClearFog CX LX2
>> > > could make use of such extensions as well, and there are probably
>> > > other boards and devices, maybe the Zynq 7000?
>> >
>> > The driver on this device doesn't have full access over the PHY.
>> > Basically we control everything from the PCS north, and the firmware
>> > controls everything from the PMA south as the physical connection is
>> > MUXed between 4 slices. So this means the firmware also controls all
>> > the I2C and the QSFP and EEPROM. The main reason for this is that
>> > those blocks are shared resources between the slices, as such the
>> > firmware acts as the arbitrator for 4 slices and the BMC.
>>
>> Ah, shame. You took what is probably the least valuable intellectual
>> property, and most shareable with the community and locked it up in
>> firmware where nobody can use it.
>>
>> You should probably stop saying there is not much firmware with this
>> device, and that Linux controls it. It clearly does not...
>>
>>         Andrew
>
>Well I was referring more to the data path level more than the phy
>configuration. I suspect different people have different levels of
>expectations on what minimal firmware is. With this hardware we at
>least don't need to use firmware commands to enable or disable queues,
>get the device stats, or update a MAC address.
>
>When it comes to multi-host NICs I am not sure there are going to be
>any solutions that don't have some level of firmware due to the fact

A small linux host on the nic that controls the eswitch perhaps? I mean,
the multi pf nic without a host in charge of the physical port and
swithing between it and pf is simply broken design. And yeah you would
probably now want to argue others are doing it already in the same way :)
True that.


>that the cable is physically shared with multiple slots.
>
>I am assuming we still want to do the PCS driver. So I will still see
>what I can do to get that setup.
>
>Thanks,
>
>- Alex
>

