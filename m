Return-Path: <netdev+bounces-92015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 427188B4DC4
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 22:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B7D1F211F7
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 20:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA49745E4;
	Sun, 28 Apr 2024 20:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4+ies2e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D411DFC7
	for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714335893; cv=none; b=bQCsE2gbbYkM/MVTU3pDjX7SITrVy6SFZLjJGVOPECKGmq4yCzm0wISvGeoryHU8//tJ5b1UbAph56p+1WA5qI0g9OG5p9aUlEoCImQV0kyB0iqTUdHTJNuuK+Ned+WSzLNDa+z8relnXdUZcV71jzTtgRujIK/DSdji+qLN+Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714335893; c=relaxed/simple;
	bh=HZ/VbIcfp42kRQhKCngCeH5xAdWugVnfkszWeWCFHlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hn+rbzd6Ng0/T09Of6fjO3Ric6FV+uQtYlEEj3/mCSeBKcHjmNsgf9xwHXZWIoXPeS9qICiIJEP23S5ETVRRcuVfGhBpox0tFpXPz3/HLEEAn6Hv9IPcfMEMr7144+lz8tLz92ABo3VVSgfIl8mQ0JntyaSqlxbT40sgnEGGcKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4+ies2e; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5f807d941c4so2977646a12.0
        for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 13:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714335891; x=1714940691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTO8/1A0D9RHJxYA0NRusWTWcxWswrx3COiS2B9wpUo=;
        b=C4+ies2e/VdHR2Qt94WWILkumpqJQ/tX7Fa+9FuYT37aKnWy/AX0NpSb11G7VVwHYc
         BtV5SsCom/b7CXJlzfEIBFFOJSrc49WJa1nKC3uRcU8eIPAAWs4zTiAQwpD6DMWtF9/L
         onn5ZKnL9MVngXBdlaeFHziemIZfmblfZgh+Gq4e9JX7Vb6dmnKW27jnDS9l3jXdqslt
         kEsympbODHjahHbQM5vRmgmuhfGv/BrcvNVjmX61YQnZtuCCM4PYLYED2isAitxCWDk8
         ZO61f+Hvcd1Rd/WVc8xIxVM1uS4jAdIpR52B9/+emAdd0+iLz5CxxNA6ucqe7ITWXIBL
         RLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714335891; x=1714940691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTO8/1A0D9RHJxYA0NRusWTWcxWswrx3COiS2B9wpUo=;
        b=bww71HPwjkC++YG0bz5vPCU41pUfiK6zFbr7g/UPj5Tk1jheHdT6Te0kH1dj/QuWrL
         Fs0f2CBh2m4eEI4MDG75jbNySWQGcX8XbVfcR4Rjxl9pSAmboNduI51h/b8JfGXt102b
         Ng4KCqDaK1xP+3XrnVKx4eDzOe1LHIIzZ2L3oxREuHS4599wjfhyeqjyHtcCnGt4wXgp
         sXqH7LWv0tSsHPNOGptA4pIFv8W9Ko5OfZ+ClTmb68FWiIRchNbVkS9rPiEbBaC9b2eX
         eym0TNFt5B5JEZgkfwVL/HM/B7A3Kc2xuqtmmrzkGjYKyzEM2IO9G28CAtXLIIxYVwvk
         6+Mg==
X-Gm-Message-State: AOJu0YwCKwe7AQqLbGZ8RXo1ZIKKbQeNsy66bxsuC1MkM65+uvlrXNX1
	0iHQ8nvPaH8HFYEPxtIetk8OI+BlU/ztqqwwhRgNFtzkXL2EpsoJ5NxKPzZ/cfcYsq4K53Rs9ke
	KUXk1qVdjVEBffcWY2GCpGmE0BycaIJOw
X-Google-Smtp-Source: AGHT+IEiwfJwQ2dDYA/OVHZMa2BT4EbrLOmVb9YtQMlVztqmLImp1acdq7l8u4fGZ/Yxkzsaz2HQAF3GLuAD6sIMDjs=
X-Received: by 2002:a17:90b:1006:b0:2b1:50:cad4 with SMTP id
 gm6-20020a17090b100600b002b10050cad4mr3699352pjb.1.1714335891387; Sun, 28 Apr
 2024 13:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFtQo5D8D861XjUuznfdBAJxYP1wCaf_L482OuyN4BnNazM1eg@mail.gmail.com>
 <ZizS4MlZcIE0KoHq@nanopsycho>
In-Reply-To: <ZizS4MlZcIE0KoHq@nanopsycho>
From: Shane Miller <gshanemiller6@gmail.com>
Date: Sun, 28 Apr 2024 16:24:14 -0400
Message-ID: <CAFtQo5BxQR56e5PNFQoRXNHOfssPZNdTDMEFpHFVS07FPpKCKg@mail.gmail.com>
Subject: Re: SR-IOV + switchdev + vlan + Mellanox: Cannot ping
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

J Pirko wrote,

"You have to configure forwarding between appropriate representors. Use
ovs (probably easiest) or tc."

Thank you for taking time to reply. But I need additional information/guida=
nce
 on how to bridge and what to bridge.

TC can be used to mirror packets for example and in fact, I have set that u=
p,
which is why I need the NIC in switchdev mode. However, this is orthogonal.
As I say in the original post, leaving the NIC in "legacy" mode has no ping
issues. As far as I understand it TC is not part of the solution space here=
.

My vague understanding is putting a NIC into switchdev mode means packets
flow into HW only not passing through the kernel, and this is what screws A=
RP
up since the kernel is needed at bit. A bridge is supposed to fix that. I t=
ried,

brctl addbr sriovbr
brctl addif sriovbr <DEV>
ip link set dev sriovbr up
ip addr ... sriov ...

where <DEV> was the link name of the physical device, or the virtual link, =
or
the port representor, or combo to no effect.

So, restating the issue: A NIC is SR-IOV virtualized into 4 virt NICs each =
with
a vlan, IP address. The NIC is placed into switchdev mode. The virtual NICs
are not pingable from other boxes. The other boxes see the NIC's MAC
addresses as incomplete (arp -n or arp -e).

What and how do I bridge/link to fix this problem?

On Sat, Apr 27, 2024 at 6:26=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Fri, Apr 26, 2024 at 10:35:28PM CEST, gshanemiller6@gmail.com wrote:
> >Problem:
> >-----------------------------------------------------------------
> >root@machA $ ping 10.xx.xx.194
> >PING 10.xx.xx.194 (10.xx.xx.194) 56(84) bytes of data
> >From 10.xx.xx.191 icmp seq=3D10 Destination Host Unreachable
> >Proximate Cause:
> >-----------------------------------------------------------------
> >This seems to be a side effect of "switchdev" mode. When the identical
> >configuration is set up EXCEPT that the SR-IOV virtualized NIC is left
> >"legacy", ping (and ncat) works just fine.
> >
> >As far as I can tell I need a bridge or bridge commands, but I have no
> >idea where to start. This environment will not allow me to add modify
> >commands when enabling switchdev mode. devlink seems to accept
> >"switchdev" alone without modifiers.
>
> You have to configure forwarding between appropriate representors. Use
> ovs (probably easiest) or tc.
>
> >
> >Note: putting a NIC into switchdev mode makes the virtual functions
> >show as "link-state disable" which is confusing. (See below.) Contrary
> >to what it seems to suggest, the virtual NICs are up and running
> >
> >Running "arp -e" on machine A shows machine B's ieth3v0 MAC address as
> >incomplete suggesting switchdev+ARP is broken.
> >
> >Problem Environment:
> >-----------------------------------------------------------------
> >OS: RHEL 8.6 4.18.0-372.46.1.el8 x64
> >NICs: Mellanox ConnectX-6
> >
> >Machine A Links:
> >70 tst@ieth3: <...LOWER_UP...> mtu 1500
> >   link/ether xx.xx.xx.xx.xx.xx
> >   vlan protocol 802.1Q id 133 <REORDER_HDR>
> >   Inet 10.xx.xx.191
> >
> >Machine B Links With ieth3 in SR-IOV mode in switchdev mode:
> ># Physical Function and its virtual functions:
> >                                                 2: ieth3:
> ><...PROMISC,UP,LOWER_UP> mtu 1500
> >    link/ether xx.xx.xx.xx.xx.f6 portname p0 switchid xxxxe988
> >    vf 0 link/ether xx.xx.xx.xx.xx.00 vlan 133 spoof off, link-state
> >disable, trust off
> >    . . .
> ># Port representers
> >893: ieth3r0: <...UP,LOWER_UP> mtu 1500
> >link/ether xx.xx.xx.xx.xx.e1 portname pf0vf0 switchid xxxxe988
> >. . .
> ># Virtual Links
> >897: ieth3v0: <...UP,LOWER_UP> mtu 1500
> >  link/ether xx.xx.xx.xx.xx.00 promiscuity 0
> >  inet 10.xx.xx.194/24 scope global ieth3v0
> >  . . .
> >
> >SR-IOV Setup Summary
> >-----------------------------------------------------------------
> >This is done right since, in legacy mode, ping/ncat works fine:
> >
> >1. Enable IOMMU, Vtx in BIOS
> >2. Boot Linux with iommu=3Don on command line
> >3. Install Mellanox OFED
> >4. Enable SR-IOV for max 8 devices in Mellanox firmware
> >(reboot)
> >5. Create 4 virtual NICs w/ SR-IOV
> >6. Configure 4 virtual NICs mac, trust off, spoofchk off, state auto
> >7. Unbind virtual NICs
> >8. Put ieth3 into switchdev mode
> >9. Rebind virtual NICs
> >10. Bring all links up
> >11. Assign IPV4 addresses to virtual links
> >

