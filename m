Return-Path: <netdev+bounces-282064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJRZOdQY8Wm6dAEAu9opvQ
	(envelope-from <netdev+bounces-282064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:30:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5935748BC46
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B6FD3055E1C
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAAE39768A;
	Tue, 28 Apr 2026 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="O86fvf0n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080262DFA3A
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 20:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408206; cv=none; b=U7XxC8Yjjw6T/unaI38NN54fW7CSbKd9bUkcrLDN9j7GJgsjlQX9wELU4AjeFH6BU6cOIdehgAaFo7hdx8h2UQ+jvaE96sxFThstEoDOmowWtMjtayUN01Zf1qAUGzCZO9toO6Dwd+7xwAhj87F3F0mkdICJyMinL08J14xdkls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408206; c=relaxed/simple;
	bh=YehqAfqF13ddP+X2+d1JomqRj+37J2/q9EvejNym0Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MM0z83GY7SdfvVNRo1PUi1pVeRx+tT6C0DG5nA0rAZ1UmUSCaQFu2yRXaHpF+fYxF5FHWIT9zItQ54xVfReC1y1rH40/2njBVkhlncdXl0VuGGY2WITgYOqWtiYYT84jMcsfmFhcdoQtcs0oFvW8/e/wgKbsrs+h4GPl3gb+OKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=O86fvf0n; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50e614fdb42so94417931cf.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 13:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1777408202; x=1778013002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/MkENzSVBbBTjs3fyFaBN9uibCTbN0NN0fiY/kA8lms=;
        b=O86fvf0nYILzN0+XGCxvgZ0k128liB+EFDtn31k2luD8to9BYsAnogPo+gJVmGaVnw
         lXVWFTjXid/vXh3CMjkOHk4nFGypMua2MF9Fek4kPTzSlCFj6DDu6Eno4r+S8SBIl4kV
         /sla+gRFtMaVoJKgMBWgAp0ZxyTuotzLHg4d5PfpooI87f2qy/BdNn4jUrFmyD3RNST6
         8ExR+2LSYhORrSeS5Ud+BMNitk17ZuhFnFC4kXMr/3AL8KUS867fSKxqFg0+CnsRyV/u
         zEvQaSUBsaM8uYEdlG6qKzEgn5EyqN5tdouuHAbMBQgvNGjL+zJOSy3oyyAlFZ6yaMEW
         T05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777408202; x=1778013002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MkENzSVBbBTjs3fyFaBN9uibCTbN0NN0fiY/kA8lms=;
        b=AUYGCNyBTbJ3TpTF7rKOvNpBjVDqFCp7b1S0JSAM9SiqV3hLFbb0QCcutZLE7SHi1z
         gApd92xJ+/t14U2iFHdE2CnHqAjounl3TkaBshiO8oCwVsW1lcG+HAs5qkp8ayr3AERK
         1raaH86FwYzlD5kP8e3a9fxI4xMc3QhxQpw+3nvhl57KbLzW9wnjLl3mdM0dtYljN6DS
         +h7a7tAZWwIkW1gqNOIYazvcuvsm/8seEZyxF4oM0LjYwp6I+pWSA5+8njqagZmxhw9T
         3CSo0c7Vs8KR+AUA9PKiIx5bPOrqknjJ67axsyyx3xM5ZWxqiXOfFK0EaopfYXDlVwTn
         TC4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+FUVoal0AmhKr5diimZeOypTdoaRqEG7BrSM8C6073+7HoDSLZomv0a/I9y10H6yGPjdN5cUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Mg2HQ343kWV2mB60pA/FXNvY2V2XoAmg3v/oEsYsjwP1Gs9I
	QQPIDvpguH2Es0eEFezsk2m2eEBHe5LrGPDDe/drIG95CnmE3wezLdtjY9soHa2GNQ==
X-Gm-Gg: AeBDiesVGb517v9m9+YRy7OFYNKFeIE0eHDre8IsXEEHnEzw2kOrsHO2zicnqtvaKsz
	+iaeTKcM2tyHxqU9j7yI8fwBhqwaqFLPbs4uCuQTKx7cCD2e7wDqkVm1pNv2rU0maQcNp3L4/TM
	ghp6qX5wWzEVL95ensCLb+8D5BzgYnyUu+YyWmrJtGWdRuJYNhOU4s9GYMArMVd1CJDoTS7knvO
	eKlAAo83mrc0kLOUt1LePZ5g1wZ5TgkqS/yfJ62z+c2e2ltrcqIdvA6+7Ss1YtpFRkBVf1UdT7W
	/zagmJ1TcegypfJHkqXdHqyGoaATuaMrG6+yiC20T46TdDCUItZCEAjRdiLS7lQc+CECJKi7bbv
	6t8T7lIEsSkhs6OUbhi1YJdRk1R09+joQF75WZYF1fuO7QZsT6m1CFahFy53iJhVb9YfJkR/5No
	NKr27Vlfbv0o0oiLx3O8tsolFzfalAgm+qHB8=
X-Received: by 2002:a05:622a:507:b0:50d:82db:773e with SMTP id d75a77b69052e-5100e1e0c5amr65265071cf.47.1777408202030;
        Tue, 28 Apr 2026 13:30:02 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::a0bd])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51014182afesm14843261cf.28.2026.04.28.13.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 13:30:01 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:29:59 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg KH <greg@kroah.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-usb@vger.kernel.org,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 5/9] thunderbolt / net: Let the service drivers configure
 interrupt throttling
Message-ID: <4f71abbd-0faf-4aaa-9aa3-8816251b84a4@rowland.harvard.edu>
References: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
 <20260428072209.3084930-6-mika.westerberg@linux.intel.com>
 <a0d3eec7-4c11-404f-804c-fa46515d25fe@lunn.ch>
 <20260428172629.GW557136@black.igk.intel.com>
 <2026042827-pep-deeply-edc9@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026042827-pep-deeply-edc9@gregkh>
X-Rspamd-Queue-Id: 5935748BC46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rowland.harvard.edu,none];
	R_DKIM_ALLOW(-0.20)[rowland.harvard.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,lunn.ch,vger.kernel.org,gmail.com,wunner.de,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-282064-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rowland.harvard.edu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stern@rowland.harvard.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]

On Tue, Apr 28, 2026 at 12:10:49PM -0600, Greg KH wrote:
> On Tue, Apr 28, 2026 at 07:26:29PM +0200, Mika Westerberg wrote:
> > On Tue, Apr 28, 2026 at 04:59:58PM +0200, Andrew Lunn wrote:
> > > On Tue, Apr 28, 2026 at 09:22:05AM +0200, Mika Westerberg wrote:
> > > > Instead of the core driver programming fixed value for throttling let
> > > > the service drivers to specify the interval if they need this. We also
> > > > allow user to tune this through a module parameter if the default is not
> > > > good fit.
> > > > 
> > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > ---
> > > >  drivers/net/thunderbolt/main.c |  7 ++++
> > > >  drivers/thunderbolt/dma_test.c |  5 +++
> > > >  drivers/thunderbolt/nhi.c      | 58 ++++++++++++++++++----------------
> > > >  drivers/thunderbolt/nhi_regs.h |  3 +-
> > > >  include/linux/thunderbolt.h    |  5 +++
> > > >  5 files changed, 50 insertions(+), 28 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> > > > index 49673f7e0055..8771ca807933 100644
> > > > --- a/drivers/net/thunderbolt/main.c
> > > > +++ b/drivers/net/thunderbolt/main.c
> > > > @@ -218,6 +218,10 @@ static bool tbnet_e2e = true;
> > > >  module_param_named(e2e, tbnet_e2e, bool, 0444);
> > > >  MODULE_PARM_DESC(e2e, "USB4NET full end-to-end flow control (default: true)");
> > > >  
> > > > +static unsigned int tbnet_throttling = 128000;
> > > > +module_param_named(throttling, tbnet_throttling, uint, 0444);
> > > > +MODULE_PARM_DESC(throttling, "Interrupt throttling rate in ns (default: 128000)");
> > > 
> > > As i mentioned elsewhere, netdev does not allow module
> > > parameters. They are hard to use, especially when you have lots of
> > > instances of a device, or you need to set it on the kernel command
> > > line because by the time the kernel has booted, it is too late, etc.
> > > And they are undocumented, and every driver does it differently.
> > 
> > Right. This was meant to be a "chicken bit" or "escape hatch" not something
> > used in daily basis.
> 
> Put it in configfs if you really want it.

Or even debugfs, if that's appropriate for the use case.

Alan Stern

> You shouldn't need any new module parameters.
> 
> thanks,
> 
> greg k-h
> 

