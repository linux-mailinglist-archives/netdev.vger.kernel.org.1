Return-Path: <netdev+bounces-181378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43467A84B7B
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 19:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 944A17A7EC7
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B79128F929;
	Thu, 10 Apr 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OpRJkdRN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C39227EC7C;
	Thu, 10 Apr 2025 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306929; cv=none; b=s5Du6n4oFo8R1WKegXmPjRU3zCXoNZP9L5NxGkO2PTLlfc3aY6UZwsxEatIljfzgaMpcPyOHcOvI9bLYEpKvQVldHwZ5zJ0GvDxfMyM/uPqwnIPbovtPAvyr530tMmBexPm9Taog7wm80HisRXrW7YGv1Do8bBmeVKwC4XSN1zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306929; c=relaxed/simple;
	bh=2RLVkVUeFF8Ao2VGO0ER5HZdSwa0yauYdADIw4+5Ryc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wuu2GSuhslX0l4HadRL1z4y+jS9Im0+4l+yKg0Br5/f1LD30Zc/b1rJW4xX+WEOLAEWczT4kZPeUXpwENMFyHyKlrh918jNI1DnsBEdgwclr99rziJ30fK+HmANALL+31brdzLzRHQ+3rNEWsTURt+ZxEihWZZyTb58a0gv5tWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OpRJkdRN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IGZuO8BAsH1wnRC2jPH+hJbuFz/bawz7RM1aKR6HWWU=; b=OpRJkdRNbCqpQjrRTrDo+bJ3X/
	N8M6AISNi6aRFkRhC4XB7kOj43puKgFr4JpycRT5fomSqdIRdUNS4AAw8OCM3oq14Drk1Dv24AR3q
	0Ek+owl/XLtOy6WheFcGDSIn567iXf13QzoKlNcP2OWxl6KjGt+7MgZpPh6fgukZ+tgw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2vuY-008iIY-No; Thu, 10 Apr 2025 19:41:58 +0200
Date: Thu, 10 Apr 2025 19:41:58 +0200
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
Message-ID: <098b0477-3367-4f96-906b-520fcd95befb@lunn.ch>
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-8-ivecera@redhat.com>
 <df6a57df-8916-4af2-9eee-10921f90ff93@kernel.org>
 <c0ef6dad-ce7e-401c-9ae1-42105fcbf9c4@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0ef6dad-ce7e-401c-9ae1-42105fcbf9c4@redhat.com>

> > > +	/* Take device lock */
> > 
> > What is a device lock? Why do you need to comment standard guards/mutexes?
> 
> Just to inform code reader, this is a section that accesses device registers
> that are protected by this zl3073x device lock.

I didn't see a reply to my question about the big picture. Why is the
regmap lock not sufficient. Why do you need a device lock.

> 
> > > +	scoped_guard(zl3073x, zldev) {
> > > +		rc = zl3073x_read_id(zldev, &id);
> > > +		if (rc)
> > > +			return rc;
> > > +		rc = zl3073x_read_revision(zldev, &revision);
> > > +		if (rc)
> > > +			return rc;
> > > +		rc = zl3073x_read_fw_ver(zldev, &fw_ver);
> > > +		if (rc)
> > > +			return rc;
> > > +		rc = zl3073x_read_custom_config_ver(zldev, &cfg_ver);
> > > +		if (rc)
> > > +			return rc;
> > > +	}
> > 
> > Nothing improved here. Andrew comments are still valid and do not send
> > v3 before the discussion is resolved.
> 
> I'm accessing device registers here and they are protected by the device
> lock. I have to take the lock, register access functions expect this by
> lockdep_assert.

Because lockdep asserts is not a useful answer. Locks are there to
protect you from something. What are you protecting yourself from? If
you cannot answer that question, your locking scheme is built on sand
and very probably broken.

    Andrew

