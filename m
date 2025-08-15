Return-Path: <netdev+bounces-214061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8044CB2808C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 15:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE945C34E1
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 13:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21CD30148D;
	Fri, 15 Aug 2025 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aJfIyd7+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D606C31987C;
	Fri, 15 Aug 2025 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755264144; cv=none; b=uJODTlWFXJV6KMTY/ei+uWR/skMB9KvRvzk4IMW1NQsVW7gwzPUYZKU16zV6me9CmR9N6EZxxCh9v+ae6Is5s2aXwQBegflxsRYdJNhriARgAcXoUXwg2S3a/XmrvdDeKetKqetSyhJsxwx3feR/nYbX//nRF5gol7OvkyWpGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755264144; c=relaxed/simple;
	bh=TfRo+RKmzkvcaGeTXFWsE1hFRrENeo7bSrrFiJCg38g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVZCPOmHzdbKyLm49IlkfHjtBGQFoP+Ev+/ZnoOfqFduhnmFAmj9Bs8b69Iioppr23TLBHBZE1pc6r5qbWoQQqFtkC7uri5WFUtMh+inMBEfXcV6TAT21dGblAPK+9XsI07W/4vJS6vkZNuqmAqGcLdsBFjC23aJMrDn/yeLMSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aJfIyd7+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=W/QI2uZJ6US+l70enzqsMEc0EYrK9urXPYV9W0/9cHY=; b=aJfIyd7+1CN9QkCn1dhPYfREe9
	nkvZpCbWmigTLWXncFxslUXDrmZORQEMNAMiLpnqievxuwCDAP5lRtagYFVeMJZ8w6El1ex17te/b
	UhxMUmz6db7E9XCPvFaZvvswiathvXndx8hzmheSEO36iuXdi89GQAVfDBi2+iENv6eo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umuNB-004p31-MM; Fri, 15 Aug 2025 15:21:33 +0200
Date: Fri, 15 Aug 2025 15:21:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <0890f9e0-1115-4fa3-8c1c-0f2e8e5625de@lunn.ch>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-5-dong100@mucse.com>
 <eebc7ed8-f6c5-4095-b33e-251411f26f0a@lunn.ch>
 <3A381A779EB97B74+20250815063656.GA1148411@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A381A779EB97B74+20250815063656.GA1148411@nic-Precision-5820-Tower>

> > Using struct_size() makes me think this is supposed to be a flexible
> > array? I've never used them myself, but shouldn't be some markup so
> > the compiler knows priv_len is the len of priv?
> > 
> 
> Maybe link this?
> struct mbx_req_cookie {
> ....
> 	int priv_len;
> 	char priv[] __counted_by(priv_len);
> }

Yes, that looks correct.

> > > +		return err;
> > > +	}
> > > +	do {
> > > +		err = wait_event_interruptible_timeout(cookie->wait,
> > > +						       cookie->done == 1,
> > > +						       cookie->timeout_jiffes);
> > > +	} while (err == -ERESTARTSYS);
> > 
> > This needs a comment, because i don't understand it.
> > 
> > 
> 
> wait_event_interruptible_timeout return -ERESTARTSYS if it was interrupted
> by a signal, which will cause misjudgement about cookie->done is timeout. 
> In this case, just wait for timeout.
> Maybe comment link this?
> /* If it was interrupted by a signal (-ERESTARTSYS), it is not true timeout,
>  * just wait again.
>  */

But why use wait_event_interruptible_timout() if you are going to
ignore all interrupts, a.k.a. signals? Why not use
wait_event_timeout()?

> > > +	if ((1 << lane) & le32_to_cpu(reply.mac_addr.lanes))
> > 
> > BIT(). And normally the & would be the other way around.
> > 
> 
> Maybe changed link this?
> ...
> if (le32_to_cpu(reply.mac_addr.ports) & BIT(lane))

Yes, that is better.

> > What exactly is a lane here? Normally we would think of a lane is
> > -KR4, 4 SERDES lanes making one port. But the MAC address is a
> > property of the port, not the lane within a port.
> > 
> 
> lane is the valid bit in 'reply.mac_addr.ports'.
> Maybe change it to 'port', that is more appropriate.

You need to be careful with your terms. I read in another patch, that
there is a dual version and a quad version. I've not yet seen how you
handle this, but i assume they are identical, and appear on the PCI
bus X number of times, and this driver will probe X times, once per
instance. We would normally refer to each instance as an
interface. But this driver also mentions PF, so i assume you also have
VFs? And if you have VF, i assume you have an embedded switch which
each of the VFs are connected to. Each VF would normally be connected
to a port of the switch.

So even though you don't have VF support yet, you should be thinking
forward. In the big picture architecture, what does this lane/port
represent? What do other drivers call it?

> > Another example of a bad structure layout. It would of been much
> > better to put the two u8 after speed.
> > 
> > > +} __packed;
> > 
> > And because this is packed, and badly aligned, you are forcing the
> > compiler to do a lot more work accessing these members.
> > 
> 
> Yes, It is bad. But FW use this define, I can only follow the define...
> Maybe I can add comment here?
> /* Must follow FW define here */ 

No need. When somebody sees __packed, it becomes obvious this is ABI
and cannot be changed. Just think about it for any future extensions
to the firmware ABI.

> 
> > > +
> > > +static inline void ability_update_host_endian(struct hw_abilities *abi)
> > > +{
> > > +	u32 host_val = le32_to_cpu(abi->ext_ability);
> > > +
> > > +	abi->e_host = *(typeof(abi->e_host) *)&host_val;
> > > +}
> > 
> > Please add a comment what this is doing, it is not obvious.
> > 
> > 
> 
> Maybe link this?
> /* Converts the little-endian ext_ability field to host byte order,
>  * then copies the value into the e_host field by reinterpreting the
>  * memory as the type of e_host (likely a bitfield or structure that
>  * represents the extended abilities in a host-friendly format).
>  */

This explains what you are doing, but why? Why do you do this only to
this field? What about all the others?

     Andrew

