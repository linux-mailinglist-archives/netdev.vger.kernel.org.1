Return-Path: <netdev+bounces-185486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B47A9AA03
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA90A92123E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36D722333B;
	Thu, 24 Apr 2025 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mej4yx46"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01584221713
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490172; cv=none; b=WHwTPHbblQo0vBY42K/ZaE4bAncpvrWu31gCVqR5xsz9YSjsyLTOhaM87+MhvN3QOEIhM072hvrg4h5Lc8ZWBOpPbjbjdtBwy6k9l61QgP/uV8TMYGk1L4wcIh15Zt2NMsUYfKM0rwyT8aW2jtT9ZSLyvfmDH3UJi4eUmA5elB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490172; c=relaxed/simple;
	bh=ZZscz1TzzK6pwyRSI4DUP6zhRhLE5DuXiEnG47nYXDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XprxbHa0E8wCU34thW7H/hZ9FtAaIEsmSq6SJdcjjwz/1h+3OHniL6QdrIaP2PkvmozLUCiTsW14iHfN5iaqx7gGrbCB1w4uIhD2FcnecBG4wuQgY/Th94oz5yrEmg1LfFhRWewsgQRBdH9kQdf7jS78oy7tA4tP3SJKZ//t+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mej4yx46; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac3123c0ef9so9016266b.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 03:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745490169; x=1746094969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bvq7TJMLPZK6wd7Kn74QI2hB0rQ01AGm9wyonxsUoJI=;
        b=mej4yx46sY/++QFzRuMSt4rxO91JDyYYKmqBuv63JDD5e0gNHlgKGds+q/oVrdJpZ2
         5kxiyAC00WElvvlQqKmV6CGfwox6erIpVEJwpjPlzTnV1hVX09GMoNLCHf0L8nELtg1q
         u+PNa+CGlJoZH2A1lfdns7x9yh3c2E/eU8ovxc8oNVY9+qFAAx+RlVKX9rVU6nq3xoYI
         v5N6hy0s4CrcCWBi36O0XM5x1OD9x2s0YctQl3VENxzpI0DH1yBDDWX9NfAlbPvuxKgO
         UfS3znzFuvEG2L20XCdlwIMt4ySU0Vg35cZ1L4TOaIa/dBs30YiEvjmd8J4B8LHWvG2v
         wyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745490169; x=1746094969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvq7TJMLPZK6wd7Kn74QI2hB0rQ01AGm9wyonxsUoJI=;
        b=FNAZJp4XWY8agvJa1k/E8T94YAQvDHvOCfeuebIQmFOw5Au4rwzpJcg1ol0zXXUjir
         gqS9JIcDOugwIx6id5JXM1cpi1PIEr+TwydBI+f6LoX2kkZU3hzvTWB6WRkzSEvM2Krf
         ANiaDiVNmKcLbkKRr6gs1MwqItTKnoHXcK5VpEOpJW6Mc6kImawM2l/+tdcmuMv+l4z0
         CGJmsuor0TEs1sZk4uqvJ/Nh4Gv7cca3Cxko96khKy3N238plERe3KT7Pp5H2+iokgWq
         WbuHU9hPYXwrNVV6fWEUfkwKWvAEgn1Fm+BkX8CamP1CqlAqakygTyC4+PUvKkOFlsKB
         Ks7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaspFxj6mGwuUnjWZ9Bbe3D1aFw9XTcfE+k6PKrzlFFAu4hR2oaBx0GlMiN4KTwj3Oz+GveCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtK/sd9n9VH/Ms9I55Gz7y+y73ey8T1vNxxnm6fYr7MlVqfq+Q
	kJv7m2Fa+582b6kVYY7lshkJPxCyok7ydCSpuXDSptaL3337dJYH
X-Gm-Gg: ASbGncvzsSdNe8l0kBrdm8rqoWJmfniCrBQcPwm38REpeDd8IUeHx+P5A7vzV1L0e/t
	FekOlzVdoRn/smEhhfpF+oYaCU6f+6QxGynHrNhA+oOo37knmhqtI+np1rSguKvP73Rc1FfNo/u
	uJLigKBd4UcbNVZqF/v0uxF524ZpyIExCWbdHKGzZ7zv+t2m0Royn616jHEleb+GzjArE6OY8A/
	K77cKWx2+4B8PGfxsdep/Ntz4q2s89Py+95btOmWqp6QLZLgWvLKL+PCWjco+52vcNn+AxPl1Uc
	zdfXLgCO6FntiyqguWzLr6AMhz9f
X-Google-Smtp-Source: AGHT+IEO0ewxmZ5oxySa/oECLbNlV2Vwpsku7ukBM4WY2jwm6kiXQVzXaWt7Yh/KQvV8pWSFLB9LXA==
X-Received: by 2002:a17:907:3f87:b0:ac2:6d40:1307 with SMTP id a640c23a62f3a-ace57429fe2mr70714366b.13.1745490168907;
        Thu, 24 Apr 2025 03:22:48 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace598999f0sm86783866b.65.2025.04.24.03.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:22:47 -0700 (PDT)
Date: Thu, 24 Apr 2025 13:22:40 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: SIMON BABY <simonkbaby@gmail.com>
Cc: Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org
Subject: Re: query on EAPOL multicast packet with linux bridge interface
Message-ID: <20250424102240.dxyk5uf6t6xfnd2k@skbuf>
References: <CAEFUPH1Erfh9YUctVDHxL8TWsiVfs+Fr8aJLtrjiKECbiGTxHQ@mail.gmail.com>
 <aAjSCwwuRpI8GdB7@shredder>
 <CAEFUPH0cU-5ZJ_qAevp1DENYrUkSO4zipUTg0vzLmgz16nPbbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEFUPH0cU-5ZJ_qAevp1DENYrUkSO4zipUTg0vzLmgz16nPbbw@mail.gmail.com>

Hello Simon,

On Wed, Apr 23, 2025 at 06:26:40AM -0700, SIMON BABY wrote:
> Thank you Ido.
> 
> Here is the details of my setup:
> 
> I have a microchip CPU connected to an 11 port marvell 88E6390 switch.
> I am using the marvel  linux DSA driver  so that all the switch ports
> (lan1, lan2, lan3 etc) are part of the linux kernel.
> 
> I am using hostapd as an authenticator.
> 
> An 802.1x client device is connected to port lan1 and binds this port
> (lan1) to hostapd daemon, I can see EAPOL packets are being forwarded
> to a radius server.
> 
> I have created a bridge with vlan filtering with below commands and
> bind the bridge (br0) with hostapd daemon. Now EAPOL packets are not
> forwarded.
> 
> ip link add name br0 type bridge vlan_filtering 1
> ip link set dev lan1 master br0
> ip link set dev lan2 master br0
> bridge vlan add dev lan1 vid 10 pvid untagged
> bridge vlan add dev lan2 vid 10 pvid untagged
> ip link set dev br0 up
> ip link set dev lan1 up
> ip link set dev lan2 up
> ip link add link br0 name br0.10 type vlan id 10
> ip link set dev br0.10 up
> ip addr add 192.168.2.1/24 dev br0.10
> bridge vlan add vid 10 dev br0 self
> 
> bridge vlan show
> port              vlan-id
> lan1              10 PVID Egress Untagged
> lan2              10 PVID Egress Untagged
> br0                10
> 
> echo 8 > /sys/class/net/br0/bridge/group_fwd_mask
> cat /sys/class/net/br0/bridge/group_fwd_mask
> 0x8
> 
> root@sama7g5ek-tdy-sd:~# cat /etc/hostapd.conf
> ##### hostapd configuration file ##############################################
> # Empty lines and lines starting with # are ignored
> 
> # Example configuration file for wired authenticator. See hostapd.conf for
> # more details.
> interface=br0
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>passing br0 as interface to
> hostapd.
> driver=wired

Could you please clarify what is the expected data path of EAPOL packets?
(I also have no experience with hostapd)
Is the forwarding to the RADIUS server something that is handled by
hostapd, through an IP socket, or is the kernel responsible for doing
that automatically somehow? Is the RADIUS server IP accessible? Does
hostapd log the reception of EAPOL packets? I'm trying to understand
whether the problem is that hostapd is not receiving or not sending
packets.

I think the hostapd.conf "interface" option can be overridden by '-i'
command line options. I'm wondering if there's any chance that is going
on, and hostapd is not listening on br0.

I don't understand the need for group_fwd_mask. In my image, you don't
need software forwarding of EAPOL packets among bridge ports (which that
option provides). You only need EAPOL frames to be received by a packet
socket, and routed using IP to the RADIUS server, correct? Can't you
just specify multiple '-i' options to hostapd, for the individual bridge
ports like lan1, lan2, and skip the bridge data path processing for
these packets, as happens by default when no group_fwd_mask is specified?

Are you also using some other bridge port options, like 'locked', which
you are not showing in the steps above?

