Return-Path: <netdev+bounces-185206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3B9A994C8
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 18:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1309A45B4
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E620828CF43;
	Wed, 23 Apr 2025 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QtGyDd7L"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55A528935F
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423500; cv=none; b=oB+i3gid2JMzkW10O35/ExfnsOUmtQhYQ2Dlu5Y2q/PH3W9lI2Lni9UYcZASZ/HkqZC6QFHzH/M73WCvl2tSN+xM3g/F8bn2YfaTmWRgULknOk1IeGiQwvWo4pho/ss+td3eA06ZsFpY7kcDdbuMHWdXf8LKRgeBRfrkk4RXGAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423500; c=relaxed/simple;
	bh=LmGNjL79ycB3Z0X51PcQ3PdY52xzY2zPzNSIVi+0xOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDpgZs1cLpdnR+FetTiPMdYwIqHxXaw+glA1uDhSrJ7oWfgDCODZRsoQHvHShMomLnPkbW3arrZoH5uWl+y/VhSCef5E7s+P0mpNOcuGIxJ3wuzpERwK40gxr2jX9f3yLCjuT34v1JvkyNGn0VZbQZOudSZxQeUSoDPD47x89gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QtGyDd7L; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D444C1140061;
	Wed, 23 Apr 2025 11:51:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 23 Apr 2025 11:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745423497; x=1745509897; bh=dJwXLllvGclfC4U6L7/Xi9A7JqzIdWAnZqt
	u44QdLQw=; b=QtGyDd7LRjo2kH/EdvrCqpJ0qefJr24MjQsNl2tzz5teaSDqrDy
	0V17HQtlKd0XoB0vzqf3xdk9yJS/0fdt7sFO0qr+CnZ1IrVV+kQxJu3wCWE19iIf
	fsa1XXZNsBOqdvk6tepNsUXTVKn+V6oPs2dxsA8tqDUelYEcOsos6UBdQcx5PJSb
	x9X1ryS0g+z8iI3YnsMBFc7mPcCxeI4k2dVPJR/DZjyyu6cp/OEOztzbomLsi5Xy
	qt97k/UIaNcB12lXwC3G4wlXrJybPqc7GNCC7TWNF38A8wNc3tCDUhE4ZAAoZCv8
	Trx0qlpV2xlfv4/aZ/ceQ8WLwie/iogb/vQ==
X-ME-Sender: <xms:iQwJaGwJjI435ONzt7W6sfgpRgyFHx6wkH-jphMqI9iPO4cQSHiI_g>
    <xme:iQwJaCQnnSF6ciEFa2JiJ6RHfuUZ1ZGEcgEtN-McWSZpur96dRwCX_6zB9jNa9kN-
    _Nbrze8UxI96gM>
X-ME-Received: <xmr:iQwJaIVapMW8flajzpP4RM6wxt8J4K7_1XVzKtMT5WDvLs3SEVOefIs3-QbM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeejtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifedu
    ieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhimhhonhhksggrsg
    ihsehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:iQwJaMh0zd2MR9_eLSaDpmixQjPc4MciX-KHH9Pm1k-cDCTAgFmzQA>
    <xmx:iQwJaIAtClwE9xAC8Gz_jg4kTNkllozyM8oANfALigsITa3G9QcvAw>
    <xmx:iQwJaNL7HMgXW493n4TN1hVznk3JoJMxM7CXojUyhhYen7nPMyz7Gw>
    <xmx:iQwJaPB1y_K9yX23RHQEStgO0tRFJjvmBLmuoh6xwX2yPCuGqG53-g>
    <xmx:iQwJaPw6ulDIJZl5siDW5SRZ6zE_dynlQ0O2eZsRll1r5k-kKoiut2q->
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 11:51:36 -0400 (EDT)
Date: Wed, 23 Apr 2025 18:51:34 +0300
From: Ido Schimmel <idosch@idosch.org>
To: SIMON BABY <simonkbaby@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: query on EAPOL multicast packet with linux bridge interface
Message-ID: <aAkMhl3klxYx-n2Q@shredder>
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

(Please avoid top posting)

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

Do you see the EAPOL packets when running tcpdump on 'lan1' and 'br0'?
Does the result change if you pass '-p' to tcpdump?

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

I have zero experience with hostapd, but I assume it opens a packet
socket on the specified interface to receive the EAPOL packets. When
listening on 'br0' you should see the EAPOL packets with a VLAN tag
which could be a problem for hostapd. When you told it to listen on
'lan1' it received the EAPOL packets without a VLAN. I would try to
specify 'br0.10' and see if it helps. hostapd should observe the packets
without a VLAN tag in this case.

> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>passing br0 as interface to
> hostapd.
> driver=wired
> 
> 
> 
> Regards
> Simon

