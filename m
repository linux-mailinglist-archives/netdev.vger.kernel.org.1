Return-Path: <netdev+bounces-243960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA74DCAB914
	for <lists+netdev@lfdr.de>; Sun, 07 Dec 2025 19:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5558C3016CC1
	for <lists+netdev@lfdr.de>; Sun,  7 Dec 2025 18:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBDA2E2DD2;
	Sun,  7 Dec 2025 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3KyFMIc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4074DDC5
	for <netdev@vger.kernel.org>; Sun,  7 Dec 2025 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765133118; cv=none; b=Q1Lh951Z5JEqErayR2fdkmnqmz1WbNMgpmy63621cZZZ6l6mwgRSlWLbWaAoHS9DI+7kw+1CrVE/N7KnotKUDyCJh4W9uKlMaVfNin9qY830vehOISJ7LxB44WVHYrh+MEnxrcz4gkexjeOFMUKdxhi/gABoT13Y/qyVCpxs/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765133118; c=relaxed/simple;
	bh=SWl0V8wMnXxXv7B1B2HhV73vfn53lSerLw28+OYLpyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqQkes0uwOEVDf2G1T/33ELfirhLKngcG/nhEPnJKPXo1Kk5hKxqfGMXKX2962Jf/DX99aARKA5VbinFSv3Lo3ljwrzYF/pJplowHo5ZvCHD/sgtGQ5BH3j/oB/s9F7cSHijcN6E8aAHe+J7xAeQ78ZIze+he4beYghA6NifYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3KyFMIc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7ba49f92362so2035497b3a.1
        for <netdev@vger.kernel.org>; Sun, 07 Dec 2025 10:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765133112; x=1765737912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5vS0nr9v5t/NqCmiJv0FkfwWe7PSkx5/NuTU3TFXCg=;
        b=X3KyFMIcLD1V8UyMVHqLdvhlxRZBIefTIRPSpHVALIWlL/7IOiLsKXROQwPpfn6y0z
         r9SfR37dPIpjl8enT5MUPZhE+/3/WcDxdwxZpp3KzX/joyEgjVAxGHlCi7Cv43YSdh+T
         xC9EH1II1aAHBmUNXPivFvQmb/eUx9iAPc9zdlQWgdFFvPN1DULYpQxNuNKb+suu8vBu
         fVSqLmktKJEATMlhJ3lnnzpsq114qbVeOKUL0nL9UUTEgJND541RWmA1n+QO2SfIfdeQ
         YekFXNx2sWmlEK91V/vfRcC5lJAkjr+l4n+dLLw+awRus114RTvySq4aZb7nNYTPFRCu
         FAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765133112; x=1765737912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5vS0nr9v5t/NqCmiJv0FkfwWe7PSkx5/NuTU3TFXCg=;
        b=OOiUGLgKeP9n0FdWlFp04kC5985eRo/tnI3s8Y9bz6ik4DUDUNZzQ6oY7mbH1IfpFH
         3ROzwhP9DBF3//QTATRq0XshwBJaeQk9jWUy2k1IBRWVHrLoTVE6jOQwVXiFtSnxGSvO
         +fsa3EJ8bo+g7LXShT+p78kNdV+LGiatSukjTJnfKtEuMbrb//vCrGinMBxR6zjhGnaN
         wfkMfJnf2j4yD6+iPJLx8o7BGVuI7yV80YcWgQxedkiwcc7FNqg6o7VDdwndwjnfayKp
         zd8nmtTc4BemPBJWyIB8sA9Nr8z2yy1fVcY3vBnuiYwuYf43RwuLsDa7CAG8mSCYnLpo
         mkLA==
X-Forwarded-Encrypted: i=1; AJvYcCVK/X+wdsglfose7Y4+52l4v2qL4UILGgx3GwegHYNfJVj8Ba0zmGI0jhMN3ndnCyY601E5CDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYU99/GMws3z0xWrXLpc5R+lMPxMqzY+frNW940CVA3iso/+AR
	JQrQzkYnhZ4IsX76CczZGCiFOYeniv2SvUcvOtS0iXnIXqxjJgp2ijER
X-Gm-Gg: ASbGnct6XJ65TLQ+gT6ZHqi0rqKW/7SpUW+VYtZLD/VICg+PqKOLHxHw1pL+lOOHtdx
	l22GZkYiYln6rtfU0P1qrsnryRMDR8/22bkx7mwrmWSnu/K68OWUbboQRhIdQ82P3n4Ykh3lBOI
	BEgNQqydPhD0cerBe4NkM8kfaxljlo8fEk2cbqpIeI3JEbbknBJstX2nod4moJKb3uZCo/TKHbP
	rNd9Y2NxuErj5MF6uB1bpYFrOFcGbXnioxvwBYbUoWEpVcOGt/ctkNDhbyGq7Lppqzxj/tO6L+C
	ghu4fYyzsL89gbEnqVupPgfuIs/yOInGDxyOkAPEkOY3Iu+Vohn1v9EzfmKlpfqbWFFNU0G674j
	61qY67r+yVQT3w+Gkk6gyeqGJaUOo0cQ3U4QIS3XP8kcyaGfj5+3xr42n1XvvIjROk4XM7cmTP/
	l7XUu4cAwd
X-Google-Smtp-Source: AGHT+IHDqusMO3PxyaAROaJW//vv5Ag3hkMAh+wOqmjhW0ALX4yToHHXqPFA017yoRhqJgvpm+w/qg==
X-Received: by 2002:a05:6a00:148e:b0:7e8:3fcb:bc4a with SMTP id d2e1a72fcca58-7e8bc1da1a5mr4684174b3a.31.1765133111805;
        Sun, 07 Dec 2025 10:45:11 -0800 (PST)
Received: from inspiron ([114.79.178.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2afa3275esm10841034b3a.69.2025.12.07.10.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 10:45:11 -0800 (PST)
Date: Mon, 8 Dec 2025 00:15:04 +0530
From: Prithvi <activprithvi@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	netdev@vger.kernel.org
Subject: Re: Question about to KMSAN: uninit-value in can_receive
Message-ID: <20251207184504.x7ocfqqmbqnhwp6n@inspiron>
References: <20251117173012.230731-1-activprithvi@gmail.com>
 <0c98b1c4-3975-4bf5-9049-9d7f10d22a6d@hartkopp.net>
 <c2cead0a-06ed-4da4-a4e4-8498908aae3e@hartkopp.net>
 <aSx++4VrGOm8zHDb@inspiron>
 <d6077d36-93ed-4a6d-9eed-42b1b22cdffb@hartkopp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6077d36-93ed-4a6d-9eed-42b1b22cdffb@hartkopp.net>

On Sun, Nov 30, 2025 at 08:09:48PM +0100, Oliver Hartkopp wrote:
> Hi Prithvi,
> 
> On 30.11.25 18:29, Prithvi Tambewagh wrote:
> > On Sun, Nov 30, 2025 at 01:44:32PM +0100, Oliver Hartkopp wrote:
> 
> > > > shall I send this patch upstream and mention your name in
> > > Suggested-by tag?
> > > 
> > > No. Neither of that - as it will not fix the root cause.
> > > 
> > > IMO we need to check who is using the headroom in CAN skbs and for
> > > what reason first. And when we are not able to safely control the
> > > headroom for our struct can_skb_priv content we might need to find
> > > another way to store that content.
> > > E.g. by creating this space behind skb->data or add new attributes
> > > to struct sk_buff.
> > 
> > I will work in this direction. Just to confirm, what you mean is
> > that first it should be checked where the headroom is used while also
> > checking whether the data from region covered by struct can_skb_priv is
> > intact, and if not then we need to ensure that it is intact by other
> > measures, right?
> 
> I have added skb_dump(KERN_WARNING, skb, true) in my local dummy_can.c
> an sent some CAN frames with cansend.
> 
> CAN CC:
> 
> [ 3351.708018] skb len=16 headroom=16 headlen=16 tailroom=288
>                mac=(16,0) mac_len=0 net=(16,0) trans=16
>                shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
>                csum(0x0 start=0 offset=0 ip_summed=1 complete_sw=0 valid=0
> level=0)
>                hash(0x0 sw=0 l4=0) proto=0x000c pkttype=5 iif=0
>                priority=0x0 mark=0x0 alloc_cpu=5 vlan_all=0x0
>                encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
> [ 3351.708151] dev name=can0 feat=0x0000000000004008
> [ 3351.708159] sk family=29 type=3 proto=0
> [ 3351.708166] skb headroom: 00000000: 07 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00
> [ 3351.708173] skb linear:   00000000: 23 01 00 00 04 00 00 00 11 22 33 44
> 00 00 00 00
> 
> (..)
> 
> CAN FD:
> 
> [ 3557.069471] skb len=72 headroom=16 headlen=72 tailroom=232
>                mac=(16,0) mac_len=0 net=(16,0) trans=16
>                shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
>                csum(0x0 start=0 offset=0 ip_summed=1 complete_sw=0 valid=0
> level=0)
>                hash(0x0 sw=0 l4=0) proto=0x000d pkttype=5 iif=0
>                priority=0x0 mark=0x0 alloc_cpu=6 vlan_all=0x0
>                encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
> [ 3557.069499] dev name=can0 feat=0x0000000000004008
> [ 3557.069507] sk family=29 type=3 proto=0
> [ 3557.069513] skb headroom: 00000000: 07 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00
> [ 3557.069520] skb linear:   00000000: 33 03 00 00 10 05 00 00 00 11 22 33
> 44 55 66 77
> [ 3557.069526] skb linear:   00000010: 88 aa bb cc dd ee ff 00 00 00 00 00
> 00 00 00 00
> 
> (..)
> 
> CAN XL:
> 
> [ 5477.498205] skb len=908 headroom=16 headlen=908 tailroom=804
>                mac=(16,0) mac_len=0 net=(16,0) trans=16
>                shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
>                csum(0x0 start=0 offset=0 ip_summed=1 complete_sw=0 valid=0
> level=0)
>                hash(0x0 sw=0 l4=0) proto=0x000e pkttype=5 iif=0
>                priority=0x0 mark=0x0 alloc_cpu=6 vlan_all=0x0
>                encapsulation=0 inner(proto=0x0000, mac=0, net=0, trans=0)
> [ 5477.498236] dev name=can0 feat=0x0000000000004008
> [ 5477.498244] sk family=29 type=3 proto=0
> [ 5477.498251] skb headroom: 00000000: 07 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00
> [ 5477.498258] skb linear:   00000000: b0 05 92 00 81 cd 80 03 cd b4 92 58
> 4c a1 f6 0c
> [ 5477.498264] skb linear:   00000010: 1a c9 6d 0a 4c a1 f6 0c 1a c9 6d 0a
> 4c a1 f6 0c
> [ 5477.498269] skb linear:   00000020: 1a c9 6d 0a 4c a1 f6 0c 1a c9 6d 0a
> 4c a1 f6 0c
> [ 5477.498275] skb linear:   00000030: 1a c9 6d 0a 4c a1 f6 0c 1a c9 6d 0a
> 4c a1 f6 0c
> 
> 
> I will also add skb_dump(KERN_WARNING, skb, true) in the CAN receive path to
> see what's going on there.
> 
> My main problem with the KMSAN message
> https://lore.kernel.org/linux-can/68bae75b.050a0220.192772.0190.GAE@google.com/
> is that it uses
> 
> NAPI, XDP and therefore pskb_expand_head():
> 
>  kmalloc_reserve+0x23e/0x4a0 net/core/skbuff.c:609
>  pskb_expand_head+0x226/0x1a60 net/core/skbuff.c:2275
>  netif_skb_check_for_xdp net/core/dev.c:5081 [inline]
>  netif_receive_generic_xdp net/core/dev.c:5112 [inline]
>  do_xdp_generic+0x9e3/0x15a0 net/core/dev.c:5180
>  __netif_receive_skb_core+0x25c3/0x6f10 net/core/dev.c:5524
>  __netif_receive_skb_one_core net/core/dev.c:5702 [inline]
>  __netif_receive_skb+0xca/0xa00 net/core/dev.c:5817
>  process_backlog+0x4ad/0xa50 net/core/dev.c:6149
>  __napi_poll+0xe7/0x980 net/core/dev.c:6902
>  napi_poll net/core/dev.c:6971 [inline]
> 
> As you can see in
> https://syzkaller.appspot.com/x/log.txt?x=144ece64580000
> 
> [pid  5804] socket(AF_CAN, SOCK_DGRAM, CAN_ISOTP) = 5
> [pid  5804] ioctl(5, SIOCGIFINDEX, {ifr_name="vxcan0", ifr_ifindex=20}) = 0
> 
> they are using the vxcan driver which is mainly derived from vcan.c and
> veth.c (~2017). The veth.c driver supports all those GRO, NAPI and XDP
> features today which vxcan.c still does NOT support.
> 
> Therefore I wonder how the NAPI and XDP code can be used together with
> vxcan. And if this is still the case today, as the syzcaller kernel
> 6.13.0-rc7-syzkaller-00039-gc3812b15000c is already one year old.
> 
> Many questions ...
> 
> Best regards,
> Oliver
Hello Oliver,

Firstly I apologize for I have not been able to get back to the coversation.
I have my exams going on right now and unfortunately my PC got some hardware 
issue, due to which I am using another old PC, which d0oesn't work much well. 
Hence I am not able to work on this right now

However I look forward to continue testing this bug ASAP. There are sevral 
things to analyse here.

Best regards,
Prithvi

