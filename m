Return-Path: <netdev+bounces-86690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CE189FF1B
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 19:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A51B1F221F0
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 17:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4AB181D02;
	Wed, 10 Apr 2024 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="VM+++CDi"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B6181CF6
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771340; cv=none; b=jAB/X1dg4TiNfP3toBbHa+rz3eqapN34VoiQNZNmdl1I2oirItXaDEUXLnxfFqV7jDYkHXOzsy9a1ctibpiKd8SSAAv243KHNM/ND7ATOtiW8ISCPZzZyd15OhyzqvL8hqc1d+jOLblwv2kupjo/OhFMHq1DfA35YCW+z1ZprsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771340; c=relaxed/simple;
	bh=tHOEm00DlSd/MFmKkS5EgFiNbc9dQXQpqBh40ibN7ek=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saqYUauF/VXOpPzhSNpdwRFWn/2jgJ2a8DRbC8aHd+IEJWp6FGPknDTy1+1tcwMeCvkmpjIhhladloQP515u4T7hVPuQaZ0AxlfwGgnWC59oA7XiJiXPNymWwNtqB/smgnnmW5xXN57MmAd19N6Kl0u4jmGHL4EsDm6T7iEtjAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=VM+++CDi; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B78A020844;
	Wed, 10 Apr 2024 19:48:55 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kVibZApk4YP9; Wed, 10 Apr 2024 19:48:55 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 05BB4207BB;
	Wed, 10 Apr 2024 19:48:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 05BB4207BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712771335;
	bh=bqeTXoO7yvAiTYQWShP9qODxQVufknE2CKmEaud0CVs=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=VM+++CDiuwpEk+7x/nfjuvgKEX10K+QbSarOGI2a5Y3jqw6YgAV7y0tYznN4xvJw3
	 /vgTSGyuzGMGHZ0cvrEn/lyFk/BBdJa2A+Q3NOrF1FyBeImuFgJYhYzfQUBnLbCsYW
	 vQXoctIWud41plfn7xueDozEJEfX3Ln3yBjaCtq43QAcEg2DTV8RaDf1qBXSd63uo9
	 OX1qKfFgAs3/pxKAyOTaL6JE3PstVDM2v7AB4uIHEJOD88PF8xFg7keg4SKaWDCR4t
	 1KfPmSzpEEmaSRsYvsnnYYs070NjHaxyvoCEBwgB3mgTHrWMvecsGtXujXtAgeQHSG
	 P8Mx/heGTqK4Q==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id EB2C680004A;
	Wed, 10 Apr 2024 19:48:54 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 19:48:54 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 10 Apr
 2024 19:48:54 +0200
Date: Wed, 10 Apr 2024 19:48:46 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, <devel@linux-ipsec.org>, Tobias Brunner
	<tobias@strongswan.org>
Subject: 14141
Message-ID: <ZhbQ/qteBv7Up1lE@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <cover.1712226175.git.antony.antony@secunet.com>
 <20ea2ab0472ecf2d1625dadb7ca0df39cf4fe0f5.1712226175.git.antony.antony@secunet.com>
 <20240408191534.2dd7892d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240408191534.2dd7892d@kernel.org>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

On Mon, Apr 08, 2024 at 19:15:34 -0700, Jakub Kicinski wrote:
> On Thu, 4 Apr 2024 12:31:56 +0200 Antony Antony wrote:
> > export AB="10.1"
> > for i in 1 2 3 4 5; do
> >         h="host${i}"
> >         ip netns add ${h}
> >         ip -netns ${h} link set lo up
> >         ip netns exec ${h} sysctl -wq net.ipv4.ip_forward=1
> >         if [ $i -lt 5 ]; then
> >                 ip -netns ${h} link add eth0 type veth peer name eth10${i}
> >                 ip -netns ${h} addr add "${AB}.${i}.1/24" dev eth0
> >                 ip -netns ${h} link set up dev eth0
> >         fi
> > done
> > 
> > for i in 1 2 3 4 5; do
> >         h="host${i}"
> >         p=$((i - 1))
> >         ph="host${p}"
> >         # connect to previous host
> >         if [ $i -gt 1 ]; then
> >                 ip -netns ${ph} link set eth10${p} netns ${h}
> >                 ip -netns ${h} link set eth10${p} name eth1
> >                 ip -netns ${h} link set up dev eth1
> >                 ip -netns ${h} addr add "${AB}.${p}.2/24" dev eth1
> >         fi
> >         # add forward routes
> >         for k in $(seq ${i} $((5 - 1))); do
> >                 ip -netns ${h} route 2>/dev/null | (grep "${AB}.${k}.0" 2>/dev/null) || \
> >                 ip -netns ${h} route add "${AB}.${k}.0/24" via "${AB}.${i}.2" 2>/dev/nul
> >         done
> > 
> >         # add reverse routes
> >         for k in $(seq 1 $((i - 2))); do
> >                 ip -netns ${h} route 2>/dev/null | grep "${AB}.${k}.0" 2>/dev/null || \
> >                 ip -netns ${h} route add "${AB}.${k}.0/24" via "${AB}.${p}.1" 2>/dev/nul
> >         done
> > done
> > 
> > ip netns exec host1 ping -q -W 2 -w 1 -c 1 10.1.4.2 2>&1>/dev/null && echo "success 10.1.4.2 reachable" || echo "ERROR"
> > ip netns exec host1 ping -W 9 -w 5 -c 1 10.1.4.3 || echo  "note the source address of unreachble of gateway"
> > ip -netns host1 route flush cache
> > 
> > ip netns exec host3 nft add table inet filter
> > ip netns exec host3 nft add chain inet filter FORWARD { type filter hook forward priority filter\; policy drop \; }
> > ip netns exec host3 nft add rule inet filter FORWARD counter ip protocol icmp drop
> > ip netns exec host3 nft add rule inet filter FORWARD counter ip protocol esp accept
> > ip netns exec host3 nft add rule inet filter FORWARD counter drop
> > 
> > ip -netns host2 xfrm policy add src 10.1.1.0/24 dst 10.1.4.0/24 dir out \
> >         flag icmp tmpl src 10.1.2.1 dst 10.1.3.2 proto esp reqid 1 mode tunnel
> > 
> > ip -netns host2 xfrm policy add src 10.1.4.0/24 dst 10.1.1.0/24 dir in \
> >         tmpl src 10.1.3.2 dst 10.1.2.1 proto esp reqid 2 mode tunnel
> > 
> > ip -netns host2 xfrm policy add src 10.1.4.0/24 dst 10.1.1.0/24 dir fwd \
> >         flag icmp tmpl src 10.1.3.2 dst 10.1.2.1 proto esp reqid 2 mode tunnel
> > 
> > ip -netns host2 xfrm state add src 10.1.2.1 dst 10.1.3.2 proto esp spi 1 \
> >         reqid 1 replay-window 1  mode tunnel aead 'rfc4106(gcm(aes))' \
> >         0x1111111111111111111111111111111111111111 96 \
> >         sel src 10.1.1.0/24 dst 10.1.4.0/24
> > 
> > ip -netns host2 xfrm state add src 10.1.3.2 dst 10.1.2.1 proto esp spi 2 \
> >         flag icmp reqid 2 replay-window 10 mode tunnel aead 'rfc4106(gcm(aes))' \
> >         0x2222222222222222222222222222222222222222 96
> > 
> > ip -netns host4 xfrm policy add src 10.1.4.0/24 dst 10.1.1.0/24 dir out \
> >         flag icmp tmpl src 10.1.3.2 dst 10.1.2.1 proto esp reqid 1 mode tunnel
> > 
> > ip -netns host4 xfrm policy add src 10.1.1.0/24 dst 10.1.4.0/24 dir in \
> >         tmpl src 10.1.2.1 dst 10.1.3.2 proto esp reqid 2  mode tunnel
> > 
> > ip -netns host4 xfrm policy add src 10.1.1.0/24 dst 10.1.4.0/24 dir fwd \
> >                 flag icmp tmpl src 10.1.2.1 dst 10.1.3.2 proto esp reqid 2 mode tunnel
> > 
> > ip -netns host4 xfrm state add src 10.1.3.2 dst 10.1.2.1 proto esp spi 2 \
> >         reqid 1 replay-window 1 mode tunnel aead 'rfc4106(gcm(aes))' \
> >         0x2222222222222222222222222222222222222222 96
> > 
> > ip -netns host4 xfrm state add src 10.1.2.1 dst 10.1.3.2 proto esp spi 1 \
> >         reqid 2 replay-window 20 flag icmp  mode tunnel aead 'rfc4106(gcm(aes))' \
> >         0x1111111111111111111111111111111111111111 96 \
> >         sel src 10.1.1.0/24 dst 10.1.4.0/24
> > 
> > ip netns exec host1 ping -W 5 -c 1 10.1.4.2 2>&1 > /dev/null && echo ""
> > ip netns exec host1 ping -W 5 -c 1 10.1.4.3 || echo "note source address of gateway 10.1.3.2"
> 
> Could you turn this into a selftest?

I thought about it, and I didn't find any selftest file that match this
test. This test need a topology with 4, ideally 5, namespaces connected in a line, and ip xfrm.

git/linux/tools/testing/selftests/net/pmtu.sh  is probably the easiest I
can think off.

git/linux/tools/testing/selftests/net/xfrm_policy.sh seems to be a bit
more complex to a extra tests to.

Do you have any preference? which file to add?

-antonz

