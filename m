Return-Path: <netdev+bounces-142331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6F49BE4AB
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FC31C235C8
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382D01DE4F9;
	Wed,  6 Nov 2024 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="XfMthEGW"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063101DF248;
	Wed,  6 Nov 2024 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890074; cv=none; b=CY+jl1abTjrFs6jXUAchzb0tJuY4WnrgX48oCjeRSNn2wGdd9HaRnG9sardB3z1QOR5cm1NZfhbPquTbyQ3IdC2Nn+J/buCPr79PhTVAvF+lbi7cJEuVApj5dteBGLJS0eETgI0LAujYJJSvcojbWrKjshCj0uNmDulUStTFJvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890074; c=relaxed/simple;
	bh=NNbsvPnE+AlIc4GVWs6zHtak2Vihyn56/gz48YQUoWo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zg31nudPpUbw7w21AheV2yAvPoQUCORsVPGqXYRimgbi6PTQO/n7pEXFi5vfx4JQqe7BZEu5m5+WJ4gH1J1YLNj64GDHDCWDqpI+hkJr0HttkVpBYmuZdTLNjokLwv0PqLK6qS1rCXJzMK3gpsIzTZFC97klAS26XbmZBAo7jSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=XfMthEGW; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730890069;
	bh=b8vIgaII3bhiClo4kBJSxp0N5aPBhPERAUgQvLm1waw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XfMthEGW47SsFcn6LBbF9D0wlypfVKz5IIKVJWWjlVmd2ZkKdaWcnp9VsqxIpgJ2n
	 QPcxpWVAGEjb6Ip6jb3SJHF41SA99az7LTAGR32m7uKcCf61t8iAA9vQsoR5KYMHPT
	 oozURhr7PBcIojXF9odPhB1lAvqL7dTVJ+k1Wc9KkoMqclZCljjipN53iaKXRqBXHz
	 M+R37MKfeo4EGXahwMeC0bTvGOoSvs/kmYF3/TOkmEXnpsrSy+9ATgCG1HW5m1LdLC
	 3CLxNmp+uObkOwnSr4XVOtW3vBOc9lhoxDisvqtwJYkzV4q/jeEDsYfJRjXgAMyNFk
	 ClOJj/Ip8lG8A==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 850F56B2BF;
	Wed,  6 Nov 2024 18:47:47 +0800 (AWST)
Message-ID: <f8454df795572983fb83c4ea78b64006a05ef79b.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 2/2] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>, 
 admiyo@os.amperecomputing.com, Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Date: Wed, 06 Nov 2024 18:47:47 +0800
In-Reply-To: <693f39f9-9505-4135-91db-a7280570fbc3@amperemail.onmicrosoft.com>
References: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
	 <20241029165414.58746-3-admiyo@os.amperecomputing.com>
	 <b614c56f007b2669f1a23bfe8a8bc6c273f81bba.camel@codeconstruct.com.au>
	 <3e68ad61-8b21-4d15-bc4c-412dd2c7b53d@amperemail.onmicrosoft.com>
	 <675c2760e1ed64ee8e8bcd82c74af764d48fea6c.camel@codeconstruct.com.au>
	 <693f39f9-9505-4135-91db-a7280570fbc3@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Adam,

> Adding the inbox id ( to the HW address does not harm anything, and
> it makes things much more explicit.

My issue is that these inbox/outbox/subspace IDs do not align with what
the device lladdr represents.

From what you have said so far, and from what I can glean from the
spec, what you have here is device *instance* information, not device
*address* information.

For an address, I would expect that to represent the address of the
interface on whatever downstream bus protocol is being used. Because
the packet formats do not define any addressing mechanism (ie, packets
are point-to-point), there is no link-layer addressing performed by the
device.

You mentioned that there may, in future, be shared resources between
multiple PCC interfaces (eg, a shared interrupt), but that doesn't
change the point-to-point nature of the packet format, and hence the
lack of bus/device addresses.

This is under my assumption that a PCC interface will always represent
a pair of in/out channels, to a single remote endpoint. If that won't
be the case in future, then two things will need to happen:

 - we will need a change in the packet format to specify the
   source/destination addresses for a tx/rx-ed packet; and

 - we will *then* need to store a local address on the lladdr of the
   device, and implement neighbour-table lookups to query remote
   lladdrs.

is that what the upcoming changes are intended to do? A change to the
packet format seems like a fundamental rework to the design here.

> It seems like removing either the inbox or the outbox id from the HW=20
> address is hiding information that should be exposed.

We can definitely expose all of the necessary instance data, but it
sounds like the lladdr is not the correct facility for this.

We already have examples of this instance information, like the
persistent onboard-naming scheme of ethernet devices. These are
separate from lladdr of those devices.

Cheers,


Jeremy

