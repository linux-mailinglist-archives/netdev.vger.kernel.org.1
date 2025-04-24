Return-Path: <netdev+bounces-185637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3FFA9B2F3
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF1B1BA0FB5
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753CD27F757;
	Thu, 24 Apr 2025 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ijf9mIFv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421AD1A9B23;
	Thu, 24 Apr 2025 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509751; cv=none; b=Z/0IhGHq8jr7yBgU0XICEp2UnZCBvBlq/HFCrnt7SeiuyasH2Qn+8WTzkHD99EycYmu9HQr+rTnwMZep3Tixvg0szifYbbExlgYJzo/pczf/4bOcc++svq/+bt2H8diNRic3amIN9ZBPxyX2x86whp3E9eavYZGlr3jOYDMbgDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509751; c=relaxed/simple;
	bh=9J4ljg0PoyINPlG0nykYrLKd6YvJ9x8LBdfeedJ/dU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcpNeTZAI9Azx+QxKXGVRTYaqAQx42NSBBiRXMY8GOt6HhM9DAWQgNlBNZgRwT7LhsJBW8O5AxfpbhTSmJhVd8bgrJ8MtHh6Tf4FCPrfq2sYDhgXxEdmv7Q3qPWrwkCfFJMh20pgdkmSsG7nTn3QXkZHcR/LSNMXLxvpLO1pFdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ijf9mIFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62681C4CEE3;
	Thu, 24 Apr 2025 15:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745509750;
	bh=9J4ljg0PoyINPlG0nykYrLKd6YvJ9x8LBdfeedJ/dU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ijf9mIFvQ/uDHnWR4+Bh6m3nyW9cUIhi7sfqRUWooHzhdaUwos+2jgFvQdn9OR5Ky
	 tHdIVCLG0lUjfUaUijUM31mDN/uBUX2GQkI1oabpaycjXN6YQG7EzR8vNnJVdaiJmH
	 f9GqM9EvzphT5qCzEHQGiJvOImJPktHsbebE6Yq8lZST19b/48WR1d6Uzw0qX04zxZ
	 36JAoTyTj7kr8XBnauAFz4vtGqM91GG+oUTCEvkkZ76ahsmkcGPLSIk/ly3keA2AQq
	 WY1J33ERcnmorrgQdgny1ibutsql6Xligzaq5fUheM3H24kPOSzO7WcgvsYboTCjyC
	 LOT0YoaFYWKfA==
Date: Thu, 24 Apr 2025 16:49:04 +0100
From: Lee Jones <lee@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 net-next 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
Message-ID: <20250424154904.GH8734@google.com>
References: <20250416162144.670760-1-ivecera@redhat.com>
 <20250416162144.670760-6-ivecera@redhat.com>
 <d286dec9-a544-409d-bf62-d2b84ef6ecd4@lunn.ch>
 <CAAVpwAvVO7RGLGMXCBxCD35kKCLmZEkeXuERG0C2GHP54kCGJw@mail.gmail.com>
 <e22193d6-8d00-4dbc-99be-55a9d6429730@redhat.com>
 <09c3730a-f6f1-4226-ae29-fe02b1663fe7@lunn.ch>
 <f9149df7-262e-4420-87b4-79c8a176c203@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9149df7-262e-4420-87b4-79c8a176c203@redhat.com>

On Thu, 17 Apr 2025, Ivan Vecera wrote:

> 
> 
> On 17. 04. 25 3:27 odp., Andrew Lunn wrote:
> > > Anyway, I have a different idea... completely abstract mailboxes from the
> > > caller. The mailbox content can be large and the caller is barely interested
> > > in all registers from the mailbox but this could be resolved this way:
> > > 
> > > The proposed API e.g for Ref mailbox:
> > > 
> > > int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index,
> > >                          struct zl3073x_mb_ref *mb);
> > > int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index,
> > >                           struct zl3073x_mb_ref *mb);
> > > 
> > > struct zl3073x_mb_ref {
> > > 	u32	flags;
> > > 	u16	freq_base;
> > > 	u16	freq_mult;
> > > 	u16	ratio_m;
> > > 	u16	ratio_n;
> > > 	u8	config;
> > > 	u64	phase_offset_compensation;
> > > 	u8	sync_ctrl;
> > > 	u32	esync_div;
> > > }
> > > 
> > > #define ZL3073X_MB_REF_FREQ_BASE			BIT(0)
> > > #define ZL3073X_MB_REF_FREQ_MULT			BIT(1)
> > > #define ZL3073X_MB_REF_RATIO_M				BIT(2)
> > > #define ZL3073X_MB_REF_RATIO_N			 	BIT(3)
> > > #define ZL3073X_MB_REF_CONFIG			 	BIT(4)
> > > #define ZL3073X_MB_REF_PHASE_OFFSET_COMPENSATION 	BIT(5)
> > > #define ZL3073X_MB_REF_SYNC_CTRL			BIT(6)
> > > #define ZL3073X_MB_REF_ESYNC_DIV			BIT(7)
> > > 
> > > Then a reader can read this way (read freq and ratio of 3rd ref):
> > > {
> > > 	struct zl3073x_mb_ref mb;
> > > 	...
> > > 	mb.flags = ZL3073X_MB_REF_FREQ_BASE |
> > > 		   ZL3073X_MB_REF_FREQ_MULT |
> > > 		   ZL3073X_MB_REF_RATIO_M |
> > > 		   ZL3073X_MB_REF_RATIO_N;
> > > 	rc = zl3073x_mb_ref_read(zldev, 3, &mb);
> > > 	if (rc)
> > > 		return rc;
> > > 	/* at this point mb fields requested via flags are filled */
> > > }
> > > A writer similarly (write config of 5th ref):
> > > {
> > > 	struct zl3073x_mb_ref mb;
> > > 	...
> > > 	mb.flags = ZL3073X_MB_REF_CONFIG;
> > > 	mb.config = FIELD_PREP(SOME_MASK, SOME_VALUE);
> > > 	rc = zl3073x_mb_ref_write(zldev, 5, &mb);
> > > 	...
> > > 	/* config of 5th ref was commited */
> > > }
> > > 
> > > The advantages:
> > > * no explicit locking required from the callers
> > > * locking is done inside mailbox API
> > > * each mailbox type can have different mutex so multiple calls for
> > >    different mailbox types (e.g ref & output) can be done in parallel
> > > 
> > > WDYT about this approach?
> > 
> > I would say this is actually your next layer on top of the basic
> > mailbox API. This makes it more friendly to your sub driver and puts
> > all the locking in one place where it can easily be reviewed.
> > 
> > One question would be, where does this code belong. Is it in the MFD,
> > or in the subdrivers? I guess it is in the subdrivers.
> 
> No, it should be part of MFD because it does not make sense to implement API
> above in each sub-driver separately.
> 
> Sub-driver would use this MB ABI for MB access and
> zl3073x_{read,write}_u{8,16,32,48} for non-MB registers.

Regardless of whether you decide to place the API in the sub-drivers or
not, it doesn't belong in MFD.  600 lines of any API is too heavyweight
to live here.  If you can't justify placing it in Mailbox, my next
suggestion would be drivers/platform.

-- 
Lee Jones [李琼斯]

