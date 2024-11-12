Return-Path: <netdev+bounces-143906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F819C4B71
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B477280FFC
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 01:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01319205AD6;
	Tue, 12 Nov 2024 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="M2b0XVXh"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87272205AB5;
	Tue, 12 Nov 2024 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731373240; cv=none; b=oH+7YPjPvSHwe5WbUD0SDmAllu18bWaVyygpCbci6JV3ZQXpEDvbbEBvpjGEOZC3Nl+WVVsQgFl4JGxChUVi3XiyHf9X46gRS1qZGsBDy8Muw4SrA8+eW362Ak/WIjGLNKf0n3YX9ftXuHHVU7Nml5HBEy1dT9rVtgFZByWlv2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731373240; c=relaxed/simple;
	bh=VBwjjvHl4gL/xi7YFTZbHwXN9EZ3tvcwZOXeuOiCZ7M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M4nxwKRo3nyuwqVE1hF9fykBkQv2KgzFyrgwvEB4FRNow6wEzf9pYbFXyC5AgZLXy+VTZm6Y3CXjFBfwSyOehr3o7ABEoe+RAV6HGIbQu3dqWMxkxtsxklHWUFbFllLmehJMNlZz5xkNEF+WGUUyVdWjZPN9Qj+KEDLZQ1C/NP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=M2b0XVXh; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731373235;
	bh=nF3vIcIsXP326Sv0CJmeBquaQ/4fj1huU+ts55mxoBA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M2b0XVXhUFsEdauRBajwKBRS6cqxRyvFIGHl4Fmrg55GiwTmCTIbt5AjVBlFPVQ5Q
	 ul3t0BDlCrX8oWiDqWsT5C5rTOr6WzBXz1d84NnXh6rXbLFAwhwnMoCtozOWDLkMJQ
	 FJxaJI9M9IQshjEIVY8bZYv5tfPiIL22SoZwvNeNCgAuER4haeQbmBVnpYmnVyCFca
	 ESa3QnC8IXEwVslmi35q9Rsveyl2+8f4O/pGMM9A0gVx4/2C7X9qpHeLXOQ9iJGqsx
	 F2WwdpPMsyk+cex3hzXIrKvw2oWU77EYd6sRYnOg6L46ecHPYsTJpDjTUJDlh3rO2Q
	 IigTQJ6jHr4Zw==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A8E1765FAE;
	Tue, 12 Nov 2024 09:00:34 +0800 (AWST)
Message-ID: <a4cf6516df6a7db734898a45907ff6f545acfd17.camel@codeconstruct.com.au>
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
Date: Tue, 12 Nov 2024 09:00:34 +0800
In-Reply-To: <3224c94c-e4c0-43f0-9d1f-c68d98594932@amperemail.onmicrosoft.com>
References: <20241029165414.58746-1-admiyo@os.amperecomputing.com>
	 <20241029165414.58746-3-admiyo@os.amperecomputing.com>
	 <b614c56f007b2669f1a23bfe8a8bc6c273f81bba.camel@codeconstruct.com.au>
	 <3e68ad61-8b21-4d15-bc4c-412dd2c7b53d@amperemail.onmicrosoft.com>
	 <675c2760e1ed64ee8e8bcd82c74af764d48fea6c.camel@codeconstruct.com.au>
	 <c69f83fa-a4e2-48fc-8c1a-553724828d70@amperemail.onmicrosoft.com>
	 <f4e3ff994fe28bb2645b5fddf1850f8fcc5d1f89.camel@codeconstruct.com.au>
	 <3224c94c-e4c0-43f0-9d1f-c68d98594932@amperemail.onmicrosoft.com>
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
>=20
> "The PCC signature. The signature of a subspace is computed by a=20
> bitwise-or of the value 0x50434300 with the subspace ID. For example,
> subspace 3 has the signature 0x50434303."
>=20
> This could be used, but the inclusion of the "PCC" is unnecessary, as
> it is on every packet.=C2=A0 Thus only the subspace ID is relevant. This
> is the  index of the=C2=A0 entry in the PCCT, and is what I have been
> calling the  outbox ID. Thus it is half of the address that I am
> proposing.

But the signature value isn't implementing any MCTP-bus addressing
functionality, right? It's a fixed value that has to be set the same
way on all transactions using that PCC channel.

Just to walk it back a bit, we have two possible interpretations here:

 1) that the channel indexes *do* form something like a physical=C2=A0
    addressing mechanism; when packets are sent over a channel to a
    remote endpoint, we need to add a specific channel identifier.

 2) that the channel indices are more of an internal detail of the
    transport mechanism: they're identifying channels, not MCTP
    endpoints (kinda like setting the PCIe target address when
    transmitting a network packet, perhaps?)

If we adopt the (1) approach, we'd want a hardware address to represent
the mechanism for addressing an MCTP endpoint, not an interface
instance. That would end up with something along the lines of:

 - MCTP-over-PCC hardware addresses would be a single byte (to contain a
   channel ID)

 - the interface would have a hardware address of just the inbox ID:
   incoming packets are received via the inbox to the local interface,
   and so are "addressed" to that inbox ID

 - remote endpoints would be represented by a hardware address of just
   the outbox ID: outgoing packets are sent via the outbox to the remote
   endpoint, so are "addressed" to that outbox ID

... but that doesn't seem to be the approach you want to take here, as
it doesn't match your requirements for an interface lladdr (also,
implementing the neighbour-handling infrastructure for that would seem
to be overkill for a strictly peer-to-peer link type).

So a couple of queries to get us to a decision:

Your goal with exposing the channel numbers is more to choose the
correct *local* interface to use on a system, right? Can you elaborate
on your objections for using something like sysfs attributes for that?

Can you outline the intended usage of the spec updates that would add
the address format you mentioned? Is there a use-case we need to
consider for those?

Cheers,


Jeremy

