Return-Path: <netdev+bounces-111338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBFB9309F5
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 14:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597092818C1
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 12:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6F3481A5;
	Sun, 14 Jul 2024 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gKy/dtZw"
X-Original-To: netdev@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDDFDF58
	for <netdev@vger.kernel.org>; Sun, 14 Jul 2024 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720961140; cv=none; b=bJUDDDEf6+q1EPBZAdsTLX8zRcPN26y2WuDRo4fUeKh3NkQ2YpR84KBPVlticlzoyz5TDdniBxd9zDJx6v4piGyjBMXK+HZkKEOr3pLnxJ6R100vwJ28ood2Bn9QFkkUfCd+EQ9N3syfDq7+ykTD2HqbLlTWmk3AEw1+xc0AdB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720961140; c=relaxed/simple;
	bh=HCZkIz7CSltzYiwuqY+J+eLPh+CiTmibWkgpyj6Qa/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fls8R54NvMsP+nHS45XMcXDIoe5LhNx3HdJ8ftMYnbfmsEvYy0st24yr5z87T5f+X23pV5ed+1NWsGbXIyYVRB+Hz1tj9ZRN3VrnO4Cfrg86/JUZvWf3dJqPgTNQ6JLT3iVXuJIGMKfik9xMgL2+a+SYQLdwv55tXUIF/6d1xzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gKy/dtZw; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4F354138852B;
	Sun, 14 Jul 2024 08:45:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 14 Jul 2024 08:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720961137; x=1721047537; bh=9k5z8IWLdRp571pECz0VYUjMg4+k
	h+CXEI1hxfTyFHM=; b=gKy/dtZwVVKg/yDqS1yTF/6rf+EQOGWK0eb40jBECQpd
	UDr7mZwZX9ljRyxZ1g5wpllQugEzOq7zMZz5GoAG0WoKCuAQDv9Zq7PLYCo0f5Wm
	uuXvrSK2L4wtGpwoBnL3qcX7SakwiOK1LaztDK9hPk6XjzINcPx/rtwr7TQiNHC1
	/PkXzLrSoG/gkDw5/Q4N+wCOMXg03zo/viNiCN6A1vTnrq9qX6suY4PDloWwx3W2
	mt8c4x/3HQo2rKOg3vxdi6NVV82aj1yvr/xV3wXsmfnkfZ+fneoMTpltdRemc/hJ
	r77xh2FjOmZ0Iik5rQLkZTsVK/kRSqvs2iVPvzY6iA==
X-ME-Sender: <xms:cMiTZpxvHYsEd_0s7MsYWfyduOTcg4IOpr4R85h5HmGGQJ7Dhe7x8Q>
    <xme:cMiTZpTJlCHPW2a53HyFIv90Br1UWnyt0nZcq-Q8rbLJ94RXKHOv2foUsN7fbrn3K
    OeDiInP8GSy_-g>
X-ME-Received: <xmr:cMiTZjUkRR1g676m2BaiEd4svxu7nYWOMWAp2FBhHqj81syEoeTJkZ-YleTF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgedtgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:cMiTZrh0tzAAQvGApBtXS3HEBHerxEfG7WNSNDjgNhpjDWcES01WCw>
    <xmx:cMiTZrDG3fYSuG4QsdJhdJRNSA1V0hWO0mDiPlnBWS27vpfG0ErXgQ>
    <xmx:cMiTZkJVFqjTz0pmTu6tW8Fn78Eah6KLf-Ez4HGFBlqXj3zxkHYEnA>
    <xmx:cMiTZqAqkemQWS_sZ1dXZq642NllefJ9jB_cDySlQ1oFqTEjh34jhg>
    <xmx:cciTZiNhB8Dj_EAAb8t0-TFp-7IZ1j5SKwQVsV8786uGN3i0pUGum4NE>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Jul 2024 08:45:35 -0400 (EDT)
Date: Sun, 14 Jul 2024 15:45:28 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Jason Zhou <jasonzhou@x.com>
Cc: netdev@vger.kernel.org, Benjamin Mahler <bmahler@x.com>,
	Jun Wang <junwang@x.com>
Subject: Re: PROBLEM: Issue with setting veth MAC address being unreliable.
Message-ID: <ZpPIaNsT3lzEPi4r@shredder.mtl.com>
References: <CAHXsExy+zm+twpC9Qrs9myBre+5s_ApGzOYU45Pt=sw-FyOn1w@mail.gmail.com>
 <Zo_bsLPrRHHiVMPd@shredder.mtl.com>
 <CAHXsExy8LKzocBdBzss_vjOpc_TQmyzM87KC192HpmuhMcqasg@mail.gmail.com>
 <CAHXsExwuSyn7eVMqiOcatU5C3WHsdHEnLJcVh-jf2LjmzW2Edg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHXsExwuSyn7eVMqiOcatU5C3WHsdHEnLJcVh-jf2LjmzW2Edg@mail.gmail.com>

On Fri, Jul 12, 2024 at 05:02:13PM -0400, Jason Zhou wrote:
> Hi all,
> 
> We have performed our own testing with the MacAddressPolicy set to
> none rather than persistent on CentOS 9, and it fixed the problem we
> were seeing with the MAC address mismatches before and after us trying
> to manually set it.
> So we're pretty confident that the cause is what Ido stated, and that
> we were racing against udev as we did not set a MAC address when
> creating our veth device pair, making udev think it should give out a
> new MAC address.
> We will release a patch on Apache Mesos to mitigate this potential
> race condition on systems with systemd version > 242.
> Thank you so much for the help!
> 
> For documenting this issue, I believe that this race condition would
> also be present for the peer veth interface?

Yes, but when creating the veth pair you can set the addresses of both
devices:

# ip link add name bla1 address 00:11:22:33:44:55 type veth peer name bla2 address 00:aa:bb:cc:dd:ee
# ip link show dev bla1
11: bla1@bla2: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:11:22:33:44:55 brd ff:ff:ff:ff:ff:ff
# ip link show dev bla2
10: bla2@bla1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:aa:bb:cc:dd:ee brd ff:ff:ff:ff:ff:ff

> We create the peer along with veth and move the peer to another
> namespace, but udev would be notified of its creation, so it will try
> to also overwrite the peer's MAC address.

The peer can be created in the desired namespace with the desired
address:

# ip netns add ns1
# ip link add name bla1 address 00:11:22:33:44:55 type veth peer name bla2 address 00:aa:bb:cc:dd:ee netns ns1
# ip link show dev bla1
10: bla1@if8: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:11:22:33:44:55 brd ff:ff:ff:ff:ff:ff link-netns ns1
bash-5.2# ip -n ns1 link show dev bla2
8: bla2@if10: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:aa:bb:cc:dd:ee brd ff:ff:ff:ff:ff:ff link-netnsid 0

> However this is not an issue for the loopback interface that comes
> with every namespace creation, as they will not be affected by
> NetworkManager and hence udev will not try to modify them.
> Please correct me if I'm wrong!

AFAICT udev ignores the loopback devices because they have a type of
ARPHRD_LOOPBACK, unlike the veth devices that have a type of
ARPHRD_ETHER.

