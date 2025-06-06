Return-Path: <netdev+bounces-195442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 035ABAD02F0
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558973B1500
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8822289350;
	Fri,  6 Jun 2025 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQe3K4zj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A0288CBC;
	Fri,  6 Jun 2025 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749215682; cv=none; b=S6IVlC87pA6cOGuHmAP5Djx0gI0v/h0Sq+N6yRRJJ9pxbrycNlz7MC2tni88yMGPmUbJXp8XqhZ5iD5c4xJtIUUjV+MufGPgkIBw8EyNcjI0V+qqlhtdqb/UYo3/5/n94Hh5bOkJQ6m9UU+TlL0XuXjL2cecASCQDnlpFaZjNfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749215682; c=relaxed/simple;
	bh=7pw97sieU7T1F+62xaELTwjjTTSUaRf6+M7upMa96BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVWIsguDN8wfMbwGf0+UnGyOVfDsl38zibydsiWDVcGAQgl8swNw0Wcel1PBB0V1f2AwxumyTAmP88EVhOo0iaZ2ykpk/YEwAxpagzgrqFA2jz7j7uEY8Dg6jUqGf1ZGB3qnVBdaHNpxkzwUNNMwbBKR0qm3CXKH+YRhb9ircOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQe3K4zj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC6BC4CEF0;
	Fri,  6 Jun 2025 13:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749215681;
	bh=7pw97sieU7T1F+62xaELTwjjTTSUaRf6+M7upMa96BU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQe3K4zj6LZA7NsgmitBbENfWid4o30TZbo8pGZZhp25y5aySPEXWZ1srOQJxeg21
	 kqS40kYX/drmI6hxHfj+fPzPX9Iyl6X+ESHpOn/PDHVY+0C/ubY6uBPK/SjHA27gna
	 pRsnehK7XueAZ60OhEIdO0HbNb+RsTYY4WxSRh2IvOtnYb7XRLGGRX+KvYhTlfYZj0
	 tLbz+iSPciAN6cumlXrlhSVXD0fWAEYsXk+qb2eGQ8BFGVdUEcvgMDvUIYMCR1OXbd
	 VbJcvCkzyyU0xdRiERPn8dRYkH1Oy7GzGul8rp7YUblr1F7PtdK+Ml0xvrhbzXuZjS
	 IGUn/W1Ksz0GQ==
Date: Fri, 6 Jun 2025 14:14:37 +0100
From: Simon Horman <horms@kernel.org>
To: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
Cc: sbhatta@marvell.com, Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] macsec: MACsec SCI assignment for ES = 0
Message-ID: <20250606131437.GH120308@horms.kernel.org>
References: <20250604123407.2795263-1-carlos.fernandez@technica-engineering.de>
 <20250605132110.3922404-1-carlos.fernandez@technica-engineering.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605132110.3922404-1-carlos.fernandez@technica-engineering.de>

On Thu, Jun 05, 2025 at 03:21:04PM +0200, Carlos Fernandez wrote:
> Hi Sundeep, 
> 
> In order to test this scenario, ES and SC flags must be 0 and 
> port identifier should be different than 1.
> 
> In order to test it, I runned the following commands that configure
> two network interfaces on qemu over different namespaces.
> 
> After applying this configuration, MACsec ping works in the patched version 
> but fails with the original code.
> 
> I'll paste the script commands here. Hope it helps your testing.
> 
> PORT=11
> SEND_SCI="off"
> ETH1_MAC="52:54:00:12:34:57"
> ETH0_MAC="52:54:00:12:34:56"
> ENCRYPT="on"
> 
> ip netns add macsec1
> ip netns add macsec0
> ip link set eth0 netns macsec0
> ip link set eth1 netns macsec1
>   
> ip netns exec macsec0 ip link add link eth0 macsec0 type macsec port $PORT send_sci $SEND_SCI end_station off encrypt $ENCRYPT
> ip netns exec macsec0 ip macsec add macsec0 tx sa 0 pn 2 on key 01 12345678901234567890123456789012
> ip netns exec macsec0 ip macsec add macsec0 rx port $PORT address $ETH1_MAC 
> ip netns exec macsec0 ip macsec add macsec0 rx port $PORT address $ETH1_MAC sa 0 pn 2 on key 02 09876543210987654321098765432109
> ip netns exec macsec0 ip link set dev macsec0 up
> ip netns exec macsec0 ip addr add 10.10.12.1/24 dev macsec0
> 
> ip netns exec macsec1 ip link add link eth1 macsec1 type macsec port $PORT send_sci $SEND_SCI end_station off encrypt $ENCRYPT
> ip netns exec macsec1 ip macsec add macsec1 tx sa 0 pn 2 on key 02 09876543210987654321098765432109
> ip netns exec macsec1 ip macsec add macsec1 rx port $PORT address $ETH0_MAC 
> ip netns exec macsec1 ip macsec add macsec1 rx port $PORT address $ETH0_MAC sa 0 pn 2 on key 01 12345678901234567890123456789012
> ip netns exec macsec1 ip link set dev macsec1 up
> ip netns exec macsec1 ip addr add 10.10.12.2/24 dev macsec1
> 
> ip netns exec macsec1 ping 10.10.12.1 #Ping works on patched version.

It seems to me that it would be useful to include these instructions in
the commit message. Or better still, add a selftests.

