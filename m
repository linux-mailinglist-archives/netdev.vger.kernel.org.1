Return-Path: <netdev+bounces-216250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F481B32C0A
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 22:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 981D87ABB13
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 20:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E8722D7B6;
	Sat, 23 Aug 2025 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R7TFMhS6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B46213E90;
	Sat, 23 Aug 2025 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755982496; cv=none; b=P6H3rj5iO7MA4SMII3ncsZitHbNbbTyhK5CcCiHfouk4nZaLCnWthGozk/fIp58icfl+c+i+AyAIDKG9VGaClpu4Kno2EUD5uqEeUjH/pqpXkuJ9Un9yz7s1jFforl15zcNVpwB3suoHG/36q4Vf937O2Vrz0BsqHFbfzrWbEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755982496; c=relaxed/simple;
	bh=cDnslnfSXUm9JhtnaqVysvm10aThDmnIwSrrtWOi9ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAlp73oB1DRQMx3QZvAzrIfQQs5by+W+hzK1gD4z2XMQLEDjC6OBWoaJr4VUGrH7Jjt99T0vnC1uy5bAfs6GXuKY+MKkcJhZaZ8tATZOxtyyDiuAZ0DopVlAkYiyU0Fk4ogDWuKoymLSI+zsujPhAyWfU1FHae7AxXTTeLhSGVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R7TFMhS6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h47+xFVHXbIgALIjR/zBQJ6iHlr5VVdQjZd4WztFu3U=; b=R7TFMhS6VrySrdB7TFaG27rRiF
	ASjT3dL9q1alq+EAmGsZcUmqW1kBotFQKd+QOHthl7gNYrK/+0+NtY3boQd1FOxBSKsy9+ua5rTuq
	BFOO1V6lNjhCI2IpwRk+KZIBZtYBbdcra1Ur194fZaBTd95gnQL0HBBgMDRAofQbu+Iw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upvG8-005mQI-Di; Sat, 23 Aug 2025 22:54:44 +0200
Date: Sat, 23 Aug 2025 22:54:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v3 net-next 3/5] net: fec: add rx_frame_size to support
 configurable RX length
Message-ID: <6b1f5bcd-e4d7-4309-becc-de4a12bdf363@lunn.ch>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
 <20250823190110.1186960-4-shenwei.wang@nxp.com>
 <0abb2c91-3786-4926-b0e3-30b9e222424d@lunn.ch>
 <PAXPR04MB918577F27FD6521B23601219893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB918577F27FD6521B23601219893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>

> > > Add a new rx_frame_size member in the fec_enet_private structure to
> > > decouple frame size configuration from max_buf_size. This allows more
> > > precise control over RX frame length settings. It is particularly
> > > useful for Jumbo frame support because the RX frame size may possible
> > > larger than the allocated RX buffer.
> > 
> > Please could you extend that a little. What happens if the received frame is bigger
> > than the buffer? Does the hardware fragment it over two buffers?
> > 
> 
> The hardware doesn't have the capability to fragment received frames that exceed the MAX_FL 
> value. Instead, it flags an overrun error in the status register when such frames are encountered.

And how is this useful for jumbo? Why would i want the RX frame size
bigger than the RX buffer size?

> > >
> > > Configure TRUNC_FL (Frame Truncation Length) based on the RX buffer size.
> > > Frames exceeding this limit will be treated as error packets and dropped.
> > 
> > This bit confuses me. You want to allow rx_frame_size to be bigger than the
> > buffer size, but you also want to discard frames bigger than the buffer size?
> > 
> 
> MAX_FL defines the maximum allowable frame length, while TRUNC_FL specifies the 
> threshold beyond which frames are truncated.  
> 
> Here, TRUNC_FL is configured based on the RX buffer size, allowing the hardware to 
> handle oversized frame errors automatically without requiring software intervention.

Please could you expand the commit message.

I still don't quite get it. Why not set MAX_FL = TRUNC_FL = RX buffer
size?

	Andrew

