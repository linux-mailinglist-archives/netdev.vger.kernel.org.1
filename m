Return-Path: <netdev+bounces-92096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0638B56A7
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 13:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBBD1C235EB
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 11:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ED34086F;
	Mon, 29 Apr 2024 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gDgKTqEF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592C040841
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390191; cv=none; b=krBU1XorcK4UDrwhr7HkGp7aW4UYe/9gsiukvYnHzlry7qvY2D8uRHYioFiHoNRymiS4FK50iu4yl69bEQ87/n9c0NiivdukalJTFcrDXJPrwQbz547M4znGHA9ajjhzRYQvvPrAQvFEBn7drpQ3w4lQ5fGYhkh55Ume5iCMX2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390191; c=relaxed/simple;
	bh=Hb0R/EQqSNe61K9vmvQv0QXIYw5nCNBeakez3N5T+5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuLX2DA+i4mNqtEFkrB8L44YSKMDo8ROZX2nNcMDB+GfKeBi3OhdWZn3GZ05ICslF6/KmrxnI05cNAitUcWipPZ65ryelnx+WKcBUJe3mZuaqKzUWuGspzZRzGVC7CLSRxR4upi6STGX1aznPBvzKX5xIPLtpWXqdBb2uVA2bLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=gDgKTqEF; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so9002389a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 04:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714390184; x=1714994984; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YJRklbH9VzwmhmcMDBKGesQcH5/q1GYF1/o58kAQxWg=;
        b=gDgKTqEF8utBcTKy3bUsNbkAI2XYwjdHjv4Z5flPadn7EI5AKWc8qNbNFI+8IdFwNC
         P1z7EGU4MRo35ebtNeuHCUWsY3M0ZoVvLzaz4yJYV8FoPryWbcNDOwRNf6sc8tTTFgsQ
         y/o352uq0ftI+pmc+nIAyBUdOSU7ldrUzYshtPnIf8YQQEePnlakzDFoH/t73/Gsbblc
         q2XX8B38JnQpxnDJBC4cJ6zCyPXU3TcyBwVkfxOS8F8mQbSZzNCFfS456BpCSBaMboNS
         ZGMuDGb8YMg/G78gIUP5uQCsGgH+wIS3k4wA37msNIOvuvtKaPE0ywCVyb6MbCscLiVK
         5p0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714390184; x=1714994984;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJRklbH9VzwmhmcMDBKGesQcH5/q1GYF1/o58kAQxWg=;
        b=urgZ9uuZgsP02y5hdhb94+rKibgRZOTUeca6owYh6g2MTogVPbUBfUJtXSavCcD3Tt
         DRtxzl1+AaUgE45Q7D0mHV5P86JL2B8yaef/Noe34bn+lL2HpH4hi9kucKBJ+pZbjLB8
         IUjjepe3kTXbsf5Yh0cJ1awmREHQlDPYC8R6yfpXctwde+l4RcvB2scjMc7WCT/jntJ6
         dSsemMWw4OD09lJnUCsgV+j0CoUMFLb+e+slXHis63t7kxCW/6uKVhmlxfJLr6LcIRw4
         9VYsLPo11BySSNaPM1JTV+8Ips2znBkH7lY7abUfBlP7JVbS8OyoD5a1osdOWV6l+osE
         HeTQ==
X-Gm-Message-State: AOJu0Yw7/xeOngO48/mAUGbUPrLlUpIkpVzAkw3gvXo89YM2IV5LnMSv
	lvZ6+VwFLyYg2pdVto6VZCesqMXp3jeJJ2b2NrVKAtmLjLj2WMyEDh4e3DtcraEzeNbC+2VIb8m
	s
X-Google-Smtp-Source: AGHT+IECQYNxZ7+UobPDiUAeVvOY3ISwV2P++DVSk1KxCZDAuERWprb16fkbGENYuEyScx1Wz+tN2w==
X-Received: by 2002:a50:d5d3:0:b0:570:17a:b1f6 with SMTP id g19-20020a50d5d3000000b00570017ab1f6mr7196551edj.6.1714390184172;
        Mon, 29 Apr 2024 04:29:44 -0700 (PDT)
Received: from localhost ([89.24.35.126])
        by smtp.gmail.com with ESMTPSA id g17-20020a056402091100b005727e9f94a6sm1318954edz.5.2024.04.29.04.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:29:43 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:29:42 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Shane Miller <gshanemiller6@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: SR-IOV + switchdev + vlan + Mellanox: Cannot ping
Message-ID: <Zi-Epjj3eiznjEyQ@nanopsycho>
References: <CAFtQo5D8D861XjUuznfdBAJxYP1wCaf_L482OuyN4BnNazM1eg@mail.gmail.com>
 <ZizS4MlZcIE0KoHq@nanopsycho>
 <CAFtQo5BxQR56e5PNFQoRXNHOfssPZNdTDMEFpHFVS07FPpKCKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFtQo5BxQR56e5PNFQoRXNHOfssPZNdTDMEFpHFVS07FPpKCKg@mail.gmail.com>

Sun, Apr 28, 2024 at 10:24:14PM CEST, gshanemiller6@gmail.com wrote:
>J Pirko wrote,
>
>"You have to configure forwarding between appropriate representors. Use
>ovs (probably easiest) or tc."
>
>Thank you for taking time to reply. But I need additional information/guidance
> on how to bridge and what to bridge.
>
>TC can be used to mirror packets for example and in fact, I have set that up,
>which is why I need the NIC in switchdev mode. However, this is orthogonal.
>As I say in the original post, leaving the NIC in "legacy" mode has no ping
>issues. As far as I understand it TC is not part of the solution space here.
>
>My vague understanding is putting a NIC into switchdev mode means packets
>flow into HW only not passing through the kernel, and this is what screws ARP

Nope. Think of it as another switch inside the NIC that connects VFs and
uplink port. You have representors that represent the switch port. Each
representor has counter part VF. You have to configure the forwarding
between the representor, similar to switch ports. In switch, there is
also no default forwarding.


>up since the kernel is needed at bit. A bridge is supposed to fix that. I tried,
>
>brctl addbr sriovbr
>brctl addif sriovbr <DEV>
>ip link set dev sriovbr up
>ip addr ... sriov ...

I don't think that bridge offload is supported, I may be wrong.

>
>where <DEV> was the link name of the physical device, or the virtual link, or
>the port representor, or combo to no effect.
>
>So, restating the issue: A NIC is SR-IOV virtualized into 4 virt NICs each with
>a vlan, IP address. The NIC is placed into switchdev mode. The virtual NICs
>are not pingable from other boxes. The other boxes see the NIC's MAC
>addresses as incomplete (arp -n or arp -e).
>
>What and how do I bridge/link to fix this problem?
>
>On Sat, Apr 27, 2024 at 6:26 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Fri, Apr 26, 2024 at 10:35:28PM CEST, gshanemiller6@gmail.com wrote:
>> >Problem:
>> >-----------------------------------------------------------------
>> >root@machA $ ping 10.xx.xx.194
>> >PING 10.xx.xx.194 (10.xx.xx.194) 56(84) bytes of data
>> >From 10.xx.xx.191 icmp seq=10 Destination Host Unreachable
>> >Proximate Cause:
>> >-----------------------------------------------------------------
>> >This seems to be a side effect of "switchdev" mode. When the identical
>> >configuration is set up EXCEPT that the SR-IOV virtualized NIC is left
>> >"legacy", ping (and ncat) works just fine.
>> >
>> >As far as I can tell I need a bridge or bridge commands, but I have no
>> >idea where to start. This environment will not allow me to add modify
>> >commands when enabling switchdev mode. devlink seems to accept
>> >"switchdev" alone without modifiers.
>>
>> You have to configure forwarding between appropriate representors. Use
>> ovs (probably easiest) or tc.
>>
>> >
>> >Note: putting a NIC into switchdev mode makes the virtual functions
>> >show as "link-state disable" which is confusing. (See below.) Contrary
>> >to what it seems to suggest, the virtual NICs are up and running
>> >
>> >Running "arp -e" on machine A shows machine B's ieth3v0 MAC address as
>> >incomplete suggesting switchdev+ARP is broken.
>> >
>> >Problem Environment:
>> >-----------------------------------------------------------------
>> >OS: RHEL 8.6 4.18.0-372.46.1.el8 x64
>> >NICs: Mellanox ConnectX-6
>> >
>> >Machine A Links:
>> >70 tst@ieth3: <...LOWER_UP...> mtu 1500
>> >   link/ether xx.xx.xx.xx.xx.xx
>> >   vlan protocol 802.1Q id 133 <REORDER_HDR>
>> >   Inet 10.xx.xx.191
>> >
>> >Machine B Links With ieth3 in SR-IOV mode in switchdev mode:
>> ># Physical Function and its virtual functions:
>> >                                                 2: ieth3:
>> ><...PROMISC,UP,LOWER_UP> mtu 1500
>> >    link/ether xx.xx.xx.xx.xx.f6 portname p0 switchid xxxxe988
>> >    vf 0 link/ether xx.xx.xx.xx.xx.00 vlan 133 spoof off, link-state
>> >disable, trust off
>> >    . . .
>> ># Port representers
>> >893: ieth3r0: <...UP,LOWER_UP> mtu 1500
>> >link/ether xx.xx.xx.xx.xx.e1 portname pf0vf0 switchid xxxxe988
>> >. . .
>> ># Virtual Links
>> >897: ieth3v0: <...UP,LOWER_UP> mtu 1500
>> >  link/ether xx.xx.xx.xx.xx.00 promiscuity 0
>> >  inet 10.xx.xx.194/24 scope global ieth3v0
>> >  . . .
>> >
>> >SR-IOV Setup Summary
>> >-----------------------------------------------------------------
>> >This is done right since, in legacy mode, ping/ncat works fine:
>> >
>> >1. Enable IOMMU, Vtx in BIOS
>> >2. Boot Linux with iommu=on on command line
>> >3. Install Mellanox OFED
>> >4. Enable SR-IOV for max 8 devices in Mellanox firmware
>> >(reboot)
>> >5. Create 4 virtual NICs w/ SR-IOV
>> >6. Configure 4 virtual NICs mac, trust off, spoofchk off, state auto
>> >7. Unbind virtual NICs
>> >8. Put ieth3 into switchdev mode
>> >9. Rebind virtual NICs
>> >10. Bring all links up
>> >11. Assign IPV4 addresses to virtual links
>> >

