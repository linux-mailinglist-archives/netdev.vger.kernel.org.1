Return-Path: <netdev+bounces-181427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391AEA84F4C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 23:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CD41BA23CC
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 21:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C27D20DD5B;
	Thu, 10 Apr 2025 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Hnujsjol"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C66A20C473;
	Thu, 10 Apr 2025 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744322075; cv=none; b=XN6L5lY5jcLXnYWw5dgZycce6xaSaLEb4jHH6ExGuSa1bZhlBqXZGb4S/8spkWGcwkbiiH8diVl0C/schK6XDII2ZrB/+VSdGDQnQCmBAHn+cWYXbM+jEPT0hWEtAvPdBCOPR0juMEVw19nC8y7j5wdAmAzbtwk1490fk/Zf4MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744322075; c=relaxed/simple;
	bh=eaQNmB6AuNlU+KBlHA0uSaualDavgEDCP9pPFGhTook=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGC+uNQz/7FUxRU84SHKcUwPMgczlxTqL3JxyzkL2fqFWQnCeX9mNa2UPQ08jhTNWqaXNcodWArM2cQlv/e2qEB0RxyRJn/JQKXxBQ+zE9krd75G1P5rtSVsWKLqOJahBpNc7Ln2s3W+VVszfqwskqd/JalfWj0c0xcA+wrcsP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Hnujsjol; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+Tm4+Z7Aj1JN3MuOyJBY1dm5PY2Ga9gM+2/LN/4Z2DI=; b=HnujsjolCAGt25aSwbyuEhUDMi
	HFYojurzRvmaVDoc1QRWtwX30V/hr9FE7NSwgt2NEdw/o/4fpwwcE/oLKSKEmWvpUFe0GFoq1wLqq
	Zknr1M9G199OMM0et14gAHCzJJWvmWzM9PlxqOI3GzjCKfFIFYZbid3Tp6OX7GH7x2xc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2zqi-008jRI-SZ; Thu, 10 Apr 2025 23:54:16 +0200
Date: Thu, 10 Apr 2025 23:54:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 07/14] mfd: zl3073x: Add components versions register
 defs
Message-ID: <8c5fb149-af25-4713-a9c8-f49b516edbff@lunn.ch>
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-8-ivecera@redhat.com>
 <df6a57df-8916-4af2-9eee-10921f90ff93@kernel.org>
 <c0ef6dad-ce7e-401c-9ae1-42105fcbf9c4@redhat.com>
 <098b0477-3367-4f96-906b-520fcd95befb@lunn.ch>
 <003bfece-7487-4c65-b4f1-2de59207bd5d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003bfece-7487-4c65-b4f1-2de59207bd5d@redhat.com>

On Thu, Apr 10, 2025 at 08:44:43PM +0200, Ivan Vecera wrote:
> 
> 
> On 10. 04. 25 7:41 odp., Andrew Lunn wrote:
> > > > > +	/* Take device lock */
> > > > 
> > > > What is a device lock? Why do you need to comment standard guards/mutexes?
> > > 
> > > Just to inform code reader, this is a section that accesses device registers
> > > that are protected by this zl3073x device lock.
> > 
> > I didn't see a reply to my question about the big picture. Why is the
> > regmap lock not sufficient. Why do you need a device lock.
> > 
> > > 
> > > > > +	scoped_guard(zl3073x, zldev) {
> > > > > +		rc = zl3073x_read_id(zldev, &id);
> > > > > +		if (rc)
> > > > > +			return rc;
> > > > > +		rc = zl3073x_read_revision(zldev, &revision);
> > > > > +		if (rc)
> > > > > +			return rc;
> > > > > +		rc = zl3073x_read_fw_ver(zldev, &fw_ver);
> > > > > +		if (rc)
> > > > > +			return rc;
> > > > > +		rc = zl3073x_read_custom_config_ver(zldev, &cfg_ver);
> > > > > +		if (rc)
> > > > > +			return rc;
> > > > > +	}
> > > > 
> > > > Nothing improved here. Andrew comments are still valid and do not send
> > > > v3 before the discussion is resolved.
> > > 
> > > I'm accessing device registers here and they are protected by the device
> > > lock. I have to take the lock, register access functions expect this by
> > > lockdep_assert.
> > 
> > Because lockdep asserts is not a useful answer. Locks are there to
> > protect you from something. What are you protecting yourself from? If
> > you cannot answer that question, your locking scheme is built on sand
> > and very probably broken.
> > 
> >      Andrew
> 
> Hi Andrew,
> I have described the locking requirements under different message [v1
> 05/28]. Could you please take a look?

So a small number of registers in the regmap need special locking. It
was not clear to me what exactly those locking requirements are,
because they don't appear to be described.

But when i look at the code above, the scoped guard gives the
impression that i have to read id, revision, fw_vr and cfg_ver all in
one go without any other reads/writes happening. I strongly suspect
that impression is wrong. The question then becomes, how can i tell
apart reads/writes which do need to be made as one group, form others
which can be arbitrarily ordered with other read/writes.

What i suggest you do is try to work out how to push the locking down
as low as possible. Make the lock cover only what it needs to cover.

Probably for 95% of the registers, the regmap lock is sufficient.

Just throwing out ideas, i've no idea if they are good or not. Create
two regmaps onto your i2c device, covering different register
ranges. The 'normal' one uses standard regmap locking, the second
'special' one has locking disabled. You additionally provide your own
lock functions to the 'normal' one, so you have access to the
lock. When you need to access the mailboxes, take the lock, so you
know the 'normal' regmap cannot access anything, and then use the
'special' regmap to do what you need to do. A structure like this
should help explain what the special steps are for those special
registers, while not scattering wrong ideas about what the locking
scheme actually is all over the code.

	Andrew

