Return-Path: <netdev+bounces-236481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5F3C3CDD1
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 18:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 879B74ED92F
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 17:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAF634F475;
	Thu,  6 Nov 2025 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dy6PoF/i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992834EF04
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450207; cv=none; b=Ee9VtFiLRsKz/4NYyB3L8h3vDAxpMyywvXkMLjHcf1gMX8JbfaaJbfPthfypIihboH3yu7l+WJjbDI3oHB07OulotwnpwjH5BzwOJoKDI628zKNC06NyGVhCOuggQFWn0u/bP4ViVnWsKAVG399Js6RLSc68cLvXpmzjHAwHYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450207; c=relaxed/simple;
	bh=9l8jdWc2+di8QEeCjZcgrr1IaXx3eZ53YD00Bv2N2fU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NR4zwQAG+XvQpI5Ow3U3y7LqfaWlf3vWdRd0UPDWVQqUyRvSzeP7+1gj4iMrrfELlYpEI8ZkBwYirRELs9PukHq1me77+ntEVle8aqXARNBEcj4dJJwC6Eaf3yb5ivDjpPPLUXw46Ydfjjtg3lort4NZqfor+HFyeXtcBlD5R2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dy6PoF/i; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4770e0b0b7dso1342265e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 09:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762450203; x=1763055003; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TBCdySExHz0+QGg0B4QbJxDsZ2aRqVUsTNaaLsUeDoE=;
        b=Dy6PoF/i2Js0mk9DqnBJ+gK1xY5LhJ/7BgIGPPU1nSjmHdpqmLy6rnhoDOtliwwcjv
         qPJEbVB7R7cMB0i6RXDAHeZHVKw7sr/h3agwD8SrthWmA7HkPU96FETscdHWcXVLOOQy
         3GgeRTQq+B40yV6+K6zL3G6SaVnTYgUcKseSsRNUMAOdgf722N8btFkj3g7vK9UrYjO0
         XU6TC53IEygQrcYpkhXsxd79jq13BPnHa4jobBm6I1y1cKXVqiwEGaWe4cExOfoi0MGp
         o6RKc8hUlAgrN530nAWZL0ViwNRaFa5QtyWxM1PB3Z3cF+Y+SAaHKrOv7x8P6TEjiTNt
         yx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762450203; x=1763055003;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBCdySExHz0+QGg0B4QbJxDsZ2aRqVUsTNaaLsUeDoE=;
        b=A+Idl46YY3gdOg6/ZR0AFiw4UcUF1Y1bhtpDemZQ8fOLiDH/TMGpc3tKxMb2ou6BG7
         Qhhd/5P9yTpTuQ42TzUZhkHJMKB+zcgvw0O2gSl6y2ATTVpT2WhV1yGhffL18Okvlj/c
         1RadPyyYbC3DxDkNMA9YlG8rrFwD9dMrcrle3qJpoA18Qes0na6xSoVRpePdDgo6uDle
         S9L3mz87kY8wJlrKbEScyEDljTxUvh1YcRP65RRUuXpaZ5BZGdWKnIXnrj7IIcAtzuJi
         rAQMcHDY25j5qOoOYREzVCjNlmYJFATqLidQxiiHk1XJqm5FiBgJdNmG8xL9Di9ZJbMt
         mRdw==
X-Forwarded-Encrypted: i=1; AJvYcCUcvp9CXSenemcJdwOexrh0cH+Ibw/hSMUQY/DxZ6WALVqWvkXocNUdyVayUKYQBCvp9rfVDZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5URl39MqIh9dQ4pL3eTUsol9QKYVWS2j/xoTjncy0xN6taRnF
	6byhhkt8VmZFgOSZJapBzpypR/jqa64kQCPY6NUUKrLrl9jVp5Drx1Dn
X-Gm-Gg: ASbGnctvP7VZySU3D7PYzyxbNuq4FN121ProsYeeZOmZLgGHCvUcaBBSZdX0Bi9lS9A
	3QpmSU3FzXz07sq9+nVdvXmrE5VBACaMTCIn7iL9TfbB+h6tobCkhn0kLRCOf2MCUwi/BNcZFYZ
	bsPTr+sVogzFtFG46VHJmPBJ+v8AU82L8smBHyp6LZEACRk7E1HnYluIugXI+eocjfkCpTnmByK
	/Qvyro9w+IhV8TD5E3TsaMlcHLpkNBaUMKnixUCwrNm8cIcEuPLNI9nPSvAG8cPu5WhbwbvVk9c
	8sUCPxdRpTH9e7PEev32fOalM0cRkGUJKjHoYuRZVmzWxHQ0cr5cUbPJjJUPDOXu4xnwYoHYzDc
	KBnLa0ig9mLyBo+6pS9zbX1XYCp+tyvYzevArZDbk8LBCwap8hm5swKpa3o+FZmTNRfLsKw==
X-Google-Smtp-Source: AGHT+IFQyPW3JBmw1Yb1YcqZu0uBjVjM7mMGFdYzwH0tonkhSSUCE7wfW/E3kdVIzDpcEeismJ2q4w==
X-Received: by 2002:a05:600c:450d:b0:477:c77:5168 with SMTP id 5b1f17b1804b1-4776bcc9730mr631335e9.4.1762450202819;
        Thu, 06 Nov 2025 09:30:02 -0800 (PST)
Received: from skbuf ([2a02:2f04:d406:ee00:dfee:13dd:e044:2156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcdd833sm932285e9.9.2025.11.06.09.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:30:01 -0800 (PST)
Date: Thu, 6 Nov 2025 19:29:58 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "robh@kernel.org" <robh@kernel.org>,
	"lxu@maxlinear.com" <lxu@maxlinear.com>,
	"john@phrozen.org" <john@phrozen.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"yweng@maxlinear.com" <yweng@maxlinear.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"bxu@maxlinear.com" <bxu@maxlinear.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"ajayaraman@maxlinear.com" <ajayaraman@maxlinear.com>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"jpovazanec@maxlinear.com" <jpovazanec@maxlinear.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v7 12/12] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Message-ID: <20251106172958.jjfr3jbzlyexmidg@skbuf>
References: <cover.1762170107.git.daniel@makrotopia.org>
 <b567ec1b4beb08fd37abf18b280c56d5d8253c26.1762170107.git.daniel@makrotopia.org>
 <8f36e6218221bb9dad6aabe4989ee4fc279581ce.camel@siemens.com>
 <20251106152738.gynuzxztm7by5krl@skbuf>
 <471b75b6971dc5fa19984b43042199dec41ca9f3.camel@siemens.com>
 <6c4144088bbf367f6b166b4f3eceef16afdc19c1.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c4144088bbf367f6b166b4f3eceef16afdc19c1.camel@siemens.com>

On Thu, Nov 06, 2025 at 04:36:55PM +0000, Sverdlin, Alexander wrote:
> Hi Vladimir,
> 
> On Thu, 2025-11-06 at 17:26 +0100, Alexander Sverdlin wrote:
> > > > The remaining failing test cases are:
> > > > TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address   [FAIL]
> > > >          reception succeeded, but should have failed
> > > > TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address, allmulti   [FAIL]
> > > >          reception succeeded, but should have failed
> > > > 
> > > > So far I didn't notice any problems with untagged read-word IP traffic over
> > > > GSW145 ports.
> > > > 
> > > > Do you have a suggestion what could I check further regarding the failing
> > > > test cases? As I understood, all of them pass on your side?
> > > 
> > > These failures mean that the test thinks the port implements IFF_UNICAST_FLT,
> > > yet it doesn't drop unregistered traffic.
> > > 
> > >  	[ $no_unicast_flt = true ] && should_receive=true || should_receive=false
> > >  	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
> > >  		"$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
> > >  		$should_receive "$test_name"
> > > 
> > > But DSA doesn't report IFF_UNICAST_FLT for this switch, because it doesn't fulfill
> > > the dsa_switch_supports_uc_filtering() requirements. So should_receive should have
> > > been true, and the question becomes why does this code snippet set no_unicast_flt=false:
> > > 
> > > vlan_over_bridged_port()
> > > {
> > >  	local no_unicast_flt=true
> > >  	local vlan_filtering=$1
> > >  	local skip_ptp=false
> > > 
> > >  	# br_manage_promisc() will not force a single vlan_filtering port to
> > >  	# promiscuous mode, so we should still expect unicast filtering to take
> > >  	# place if the device can do it.
> > >  	if [ $(has_unicast_flt $h2) = yes ] && [ $vlan_filtering = 1 ]; then
> > >  		no_unicast_flt=false
> > >  	fi
> > > 
> > > Because IFF_UNICAST_FLT is not a UAPI-visible property, has_unicast_flt() does
> > > an indirect check: it creates a macvlan upper with a different MAC address than
> > > the physical interface's, and this results in a dev_uc_add() in the kernel.
> > > If the unicast address is non-empty but the device doesn't have IFF_UNICAST_FLT,
> > > __dev_set_rx_mode() makes the interface promiscuous, which has_unicast_flt()
> > > then tests.
> > 
> > here is the corresponding kernel log preceding the failing test cases, maybe it
> > might help?
> > 
> > [  539.836062] mxl-gsw1xx 8000f00.mdio:00 lan1: left allmulticast mode
> > [  539.845053] am65-cpsw-nuss 8000000.ethernet eth0: left allmulticast mode
> > [  539.853401] br0: port 1(lan1) entered disabled state
> > [  545.641001] am65-cpsw-nuss 8000000.ethernet: Removing vlan 1 from vlan filter
> > [  546.075411] mxl-gsw1xx 8000f00.mdio:00 lan1: Link is Down
> > [  546.666944] mxl-gsw1xx 8000f00.mdio:00 lan0: Link is Down
> > [  547.779308] mxl-gsw1xx 8000f00.mdio:00 lan1: configuring for phy/internal link mode
> > [  548.803903] mxl-gsw1xx 8000f00.mdio:00 lan0: configuring for phy/internal link mode
> > [  549.561829] mxl-gsw1xx 8000f00.mdio:00 lan1: configuring for phy/internal link mode
> > [  550.366300] mxl-gsw1xx 8000f00.mdio:00 lan1: configuring for phy/internal link mode
> > [  550.395032] br0: port 1(lan1) entered blocking state
> > [  550.401063] br0: port 1(lan1) entered disabled state
> > [  550.406470] mxl-gsw1xx 8000f00.mdio:00 lan1: entered allmulticast mode
> > [  550.413868] am65-cpsw-nuss 8000000.ethernet eth0: entered allmulticast mode
> > [  550.440111] am65-cpsw-nuss 8000000.ethernet: Adding vlan 1 to vlan filter
> > [  550.465479] am65-cpsw-nuss 8000000.ethernet: Adding vlan 100 to vlan filter
> > [  552.519232] mxl-gsw1xx 8000f00.mdio:00 lan1: Link is Up - 100Mbps/Full - flow control rx/tx
> > [  552.530513] br0: port 1(lan1) entered blocking state
> > [  552.536463] br0: port 1(lan1) entered forwarding state
> > [  552.999330] mxl-gsw1xx 8000f00.mdio:00 lan0: Link is Up - 100Mbps/Full - flow control rx/tx
> > [  581.899262] lan1.100: entered promiscuous mode
> > [  592.995574] lan1.100: left promiscuous mode
> > [  596.665022] lan1.100: entered allmulticast mode
> > [  607.789778] lan1.100: left allmulticast mode
> > --
> > TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to macvlan MAC address   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address   [FAIL]
> >         reception succeeded, but should have failed
> > TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
> > TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address, allmulti   [FAIL]
> >         reception succeeded, but should have failed
> 
> does the following help?
> 
> # dev=lan1
> # ip link set $dev up
> [ 2005.688205] mxl-gsw1xx 8000f00.mdio:00 lan1: configuring for phy/internal link mode
> [ 2005.714288] 8021q: adding VLAN 0 to HW filter on device lan1
> # ip link add link $dev name macvlan-tmp type macvlan mode private
> # ip l show lan1
> 4: lan1@eth0: <NO-CARRIER,BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:a0:03:ea:fe:b7 brd ff:ff:ff:ff:ff:ff
> # ip l 
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1508 qdisc mq state UP mode DEFAULT group default qlen 1000
>     link/ether c0:d6:0a:e6:89:9e brd ff:ff:ff:ff:ff:ff
> 3: lan0@eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:a0:03:ea:fe:b6 brd ff:ff:ff:ff:ff:ff
> 4: lan1@eth0: <NO-CARRIER,BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:a0:03:ea:fe:b7 brd ff:ff:ff:ff:ff:ff
> 5: lan2@eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:a0:03:ea:fe:b8 brd ff:ff:ff:ff:ff:ff
> 6: lan3@eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:a0:03:ea:fe:b9 brd ff:ff:ff:ff:ff:ff
> 7: wlan0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:a0:03:ea:fe:ba brd ff:ff:ff:ff:ff:ff
> 8: usb0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 96:f1:ca:89:bc:b0 brd ff:ff:ff:ff:ff:ff
> 60: macvlan-tmp@lan1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 9e:07:e8:7c:9d:99 brd ff:ff:ff:ff:ff:ff
> # ip link set macvlan-tmp address 00:a0:03:ea:fe:b8
> # ip link set macvlan-tmp up
> [ 2109.392322] 8021q: adding VLAN 0 to HW filter on device macvlan-tmp
> # ip -j -d link show dev $dev | jq -r '.[].promiscuity'
> 2
> # ip -j -d link show dev $dev
> [{"ifindex":4,"link":"eth0","ifname":"lan1","flags":["NO-CARRIER","BROADCAST","MULTICAST","PROMISC","UP"],"mtu":1500,"qdisc":"noqueue","operstate":"DOWN","linkmode":"DEFAULT","group":"defau]
> # ip -d link show dev $dev
> 4: lan1@eth0: <NO-CARRIER,BROADCAST,MULTICAST,PROMISC,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:a0:03:ea:fe:b7 brd ff:ff:ff:ff:ff:ff promiscuity 2 allmulti 0 minmtu 68 maxmtu 2378 
>     dsa conduit eth0 addrgenmode eui64 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro 

It partially does, yes. The promiscuity is 2, which suggests it was
already 1 when has_unicast_flt() started to run. The function is not
written to expect that to happen. Although I don't yet understand why
lan1 originally entered promiscuous mode - that is not in your logs.

This is a separate environment from the selftest with the commands ran
manually, no? Because you can just run the selftest with "bash -x".

