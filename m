Return-Path: <netdev+bounces-151582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B98C29F01BA
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 02:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C6E286ECF
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 01:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2676E8472;
	Fri, 13 Dec 2024 01:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTs0V/i5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBCF249E5;
	Fri, 13 Dec 2024 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734052454; cv=none; b=Voig2Q19TT7+CuRVm6p0WZdayeWl2OIwD9ZKvcYa6R+5mOOTS89Gs/9Wg1VmzEYSCQeEHmkdRv7iZPdxL+/tqeE40wXnUG3laocJigd90vojXXmal/M3s87YdQHfh5MWtKczg7mZiW4/zC1pFJ702yiDLRZqENkVRZODe8DFclc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734052454; c=relaxed/simple;
	bh=rJspH013U22683GEjWtelKB37u8YLwlLWq0GPVy5ArY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/sQ/GaDFGtQXdtusOBaITVLtis9vCgTbEz+FUWtnq6fg7rK7UfRKAL/X51SrCsIknw5ozO//pGS6nlkHLkLPiiMOfkeloljzZWXegUMmY7IWlWIJVZRb0k33YtAVK6VF17CJunDwpZXRT3Ex4dwCK0o8K74cKNL7jxhK7ZOF4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTs0V/i5; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d0bf4ec53fso229004a12.0;
        Thu, 12 Dec 2024 17:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734052450; x=1734657250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jlR7YjzWOcyJAWoeh6nLPh4Md77VUhAPBYzRJQYlorc=;
        b=QTs0V/i52gzmc7TmBZcer1OUyNd1XJdM771MTru/Mu08zRkfm/hzgSX+nmapX4SyXp
         05zJdrq7nazOcuaNw6RsZGSqglBXTkmOEddUWu3WRyEiCoGSLITcBdYJneTs+mYDk/lD
         kKHaAbdH94/rw3xDjXklmqh4kUHGX2O/Hc7PWRPdHZYGFua77NbcABb8CTwy5gGE+08t
         zVeQRCWhHOJs09+c6zOPT8RjEmQyKoiJs2C+GznyL06MJuaCekgeHG2CvBvfEDQ+zJ5g
         55gnAsZ2ht928IYWS658o3FmFfL1hsQh/6u/wz8mBHdbVwV9BW+1NeEAhUJL9E+MlAxx
         lGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734052450; x=1734657250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlR7YjzWOcyJAWoeh6nLPh4Md77VUhAPBYzRJQYlorc=;
        b=GnDYDoIekO507aVCX3VXYkfKLHF0Mu2fj302pntvM45a452L/iExUogIG5wWYS4rNL
         SWgeACPb1rXrgPkVu/e9z7cDlqenV/YqVwYOWR5M/3Axoz07qdqyTW1kEaQVewt0ZccM
         Jh5WmuS2W1Cauw5lK2OEo/P4p+WKDe+eKszpEhoSYAQLbTjy09qny0WA98YFdCfDKH/W
         2L34AlZnc3RakB9XIy3zozRoUa+M1IEgQfd9Xs9FnnTjB4VwpLayx3NFBrpHEJfPqnM1
         ZZ5jLMoiK1R/vDsqgeiEjI0BOp2fLQAIimrwbYmoV7dBItPPurmOTgWGhPtD4xkHQSKm
         m+fw==
X-Forwarded-Encrypted: i=1; AJvYcCW3Y9hOlWZNLPg3oflbgdtnWTn4mXFvU7oCZF8XCbrLWzDFthOeAzV36vbhI3663b964mhmek5hjPoDFAo=@vger.kernel.org, AJvYcCW8H8jnaWhkEdTp5ulWJr/wsGd5qlEMapkBCl8Rv/VzT/UkGg4PU/YFJgUu2QOEXVPU1vupQ/54@vger.kernel.org
X-Gm-Message-State: AOJu0YzIUE0N8U2dogOTQpxyiiM3ia1M0AFaJITwh7kf7mYeUIuPYNrY
	ipjQht9W4uvcb4NDWi4uMykddRkwQaVmPMWvuUbbij/tkrLwAPH3
X-Gm-Gg: ASbGncvxFW7EnmXW3UrZBHg3p/gLAXp4ddPOHAOorcokF6FCXwCnSVc0lclvfhMVvD5
	iQXHGgrVw8ehVfnpiBCO/LLVwWQDnOH81+P3rM/DjW7o6JwuP297n/qQ0wc/btSkE9g02gc4f3t
	yS/a8llI6d5h2iKCsJGBAeSro8GpmPsNMpftH+EQlARx9XY1C2J4PG4NirPRRIdWmJI84sKtzQu
	+JJhahsa92tDiGIAfzUIA3UlyuvRDl5VH5VkU6bARTd
X-Google-Smtp-Source: AGHT+IEPZCGIzxf8E+fyXrKGKu1OQUyVSK031o087hyOh80Spj2tLlKPg9ejvsvuJrEG9KomTN+CNg==
X-Received: by 2002:a17:907:c28:b0:aa6:9407:34e3 with SMTP id a640c23a62f3a-aab77e89c1emr24063066b.9.1734052450191;
        Thu, 12 Dec 2024 17:14:10 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6701b08c2sm790332566b.124.2024.12.12.17.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 17:14:08 -0800 (PST)
Date: Fri, 13 Dec 2024 03:14:05 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Arun Ramadoss <arun.ramadoss@microchip.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: ksz9477: fix multicast filtering
Message-ID: <20241213011405.ogogu5rvbjimuqji@skbuf>
References: <20241212215132.3111392-1-tharvey@gateworks.com>
 <20241213000023.jkrxbogcws4azh4w@skbuf>
 <CAJ+vNU2WQ2n588vOcofJ5Ga76hsyff51EW-e6T8PbYFY_4xu0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU2WQ2n588vOcofJ5Ga76hsyff51EW-e6T8PbYFY_4xu0A@mail.gmail.com>

On Thu, Dec 12, 2024 at 04:32:28PM -0800, Tim Harvey wrote:
> > >  - forward to all but cpu port:
> >
> > Why would you not forward packets to the CPU port as a hardcoded configuration?
> > What if the KSZ ports are bridged together with a foreign interface
> > (different NIC, WLAN, tunnel etc), how should the packets reach that?
> 
> If that is the correct thing to do I can certainly do that. I was
> assuming that the default policy above must be somewhat standard. This
> patch leaves the policy that was created by the default table
> configuration and just updates the port configuration based on the dt
> definition of the user vs host ports.

I think you misunderstood my comment which you've quoted here, it was:
"why would you hardcode a configuration which can't be changed and which
doesn't include _at least_ the CPU port in the list of destination
ports?! isn't that needed for so many reasons?"

This particular paragraph did not contain any suggestion of the form
"the correct thing to do is ...", just an observation that the choice
you've made is most likely wrong.

> > >    group 4 (01-80-C2-00)-00-20 (GMRP)
> > >    group 5 (01-80-C2-00)-00-21 (GVRP)
> > >    group 7 (01-80-C2-00)-00-11 - (01-80-C2-00)-00-1F,
> > >            (01-80-C2-00)-00-22 - (01-80-C2-00)-00-2F
> >
> > Don't you want to forgo the (odd) hardware defaults for the Reserved Multicast
> > table, and instead follow what the Linux bridge does in br_handle_frame()?
> > Which is to trap all is_link_local_ether_addr() addresses to the CPU, do
> > _not_ call dsa_default_offload_fwd_mark() for those packets (aka let the
> > bridge know that they haven't been forwarded in hardware, and if they
> > should reach other bridge ports, this must be done in software), and let the
> > user choose, via the bridge group_fwd_mask, if they should be forwarded
> > to other bridge ports or not?
> 
> Again, I really don't know what the 'right' thing to do is for
> multicast packets but the enabling of the reserved multicast table
> done in commit 331d64f752bb ("net: dsa: microchip: add the
> enable_stp_addr pointer in ksz_dev_ops") breaks forwarding of all
> multicast packets that are not sent to 01-80-C2-00-00-00

Yes, because prior to that commit, this table wasn't consulted by the
data path of the switch.

> > > Datasheets:
> > > [1] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9897S-Data-Sheet-DS00002394C.pdf
> > > [2] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9896C-Data-Sheet-DS00002390C.pdf
> > > [3] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9893R-Data-Sheet-DS00002420D.pdf
> > > [4] https://ww1.microchip.com/downloads/en/DeviceDoc/00002330B.pdf
> > > [5] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9563R-Data-Sheet-DS00002419D.pdf
> > > [6] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/KSZ9567R-Data-Sheet-DS00002329.pdf
> > > [7] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/KSZ9567R-Data-Sheet-DS00002329.pdf
> >
> > [6] and [7] are the same.
> >
> > Also, you'd better specify in the commit message what's with these datasheet
> > links, which to me and I suppose all other non-expert readers, are pasted here
> > out of the blue, with no context.
> >
> > Like for example: "KSZ9897, ..., have arbitrary CPU port assignments, as
> > can be seen in the driver's ksz_chip_data :: cpu_ports entries for these
> > families, and the CPU port selection on a certain board rarely coincides
> > with the default host port selection in the Reserved Multicast address
> > table".
> 
> I was just trying to be thorough. I took the time to look up the
> datasheets for all the switches that the ksz9447 driver supports to
> ensure they all had the same default configuration policy and same
> configuration method/registers so I thought I would include them in
> the message. I can drop the datasheet links if they add no value. I
> was also expecting perhaps the commit message was confusing so I
> wanted to show where the information came from.

They do add value, just guide the reader towards what they should be
looking at, rather than throwing 6 books at them. I gave my own
interpretation above of what I think should be the takeaway, after
spending more than 1 hour studying, and I still might have not seen the
same things as you. Just don't expect everybody to spend the same amount
of time.

> What you're suggesting above regarding trapping all
> is_link_local_ether_addr() addresses to the CPU and not calling
> dsa_default_offload_fwd_mark() is beyond my understanding.
> If the behavior of the reserved multicast address table is non-standard

The behavior of that table is customizable, in fact, and can be brought
into compliance with the Linux network stack's expectations.

Other network stacks might be different, but in Linux, the easiest way
to achieve configurability of the group forwarding would be to let
software do it. The bridge group_fwd_mask is a bit mask of reserved
multicast groups (group X in 01-80-C2-00-00-0X). For example, setting
bit 14 (0xe) (aka set group_fwd_mask to 0x4000) would mean "let group
01-80-C2-00-00-0E be forwarded on all bridge ports, and all other groups
be just trapped".

Conceivably, even in Linux there might be other ways to do it, like
reprogram the hardware tables according to the group_fwd_mask value
communicated through switchdev. But that infrastructure doesn't exist.

> then it should be disabled and the content of ksz9477_enable_stp_addr()
> removed.

I wouldn't jump the gun so soon.

> However based on Arun's commit message it seems that prior to
> that patch STP BPDU packets were not being forwarded to the CPU so
> it's unclear to me what the default behavior was for multicast without
> the reserved muticast address table being enabled. I know that if the
> table is disabled by removing the call to ksz9477_enable_stp_addr then
> LLDP packets are forwarded to the cpu port like they were before that
> patch.

Reading the commit message: "In order to transmit the STP BPDU packet to
the CPU port, the STP address (...) has to be added to static alu table",
I think the correct key in which it should be interpreted is:

"In order to transmit the STP BPDU packets [just] to the CPU port
[rather than flood them towards all ports], the STP address has to ...".

I will give it to you that it is quite a stretch to interpret it in this
way, and it is also frustrating to me to have to extract technically
valid information from loose formulations like these. Plus, unlike both
you and Arun, no access to this hardware. But at least, this is the only
interpretation with which I see no contradictions.

I will let Arun confirm that the commit message should be interpreted in
this way and not in another. But at the same time, you could also
confirm that when the Reserved Multicast address table lookup is disabled,
they are treated just like any other multicast traffic with no hit in
the address table: aka broadcast.

