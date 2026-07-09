Return-Path: <netdev+bounces-306279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id glROBVe7T2q7nQIAu9opvQ
	(envelope-from <netdev+bounces-306279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:16:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4C9732B62
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:16:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=QpxRgfb6;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306279-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306279-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 333E930034B2
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 14:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB3370AF6;
	Thu,  9 Jul 2026 14:37:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28E23603DA
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 14:37:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607857; cv=none; b=t59VBohRu+uG2wagpjFYvfsZLf3usEmZfZQ6mmJhDNW75670V4UHMR5tV/5CXKYPUlAAKqMhDnyHHOzGKYl3FpuNCMZaEQEA1VaJJlRwPaJNvv0Yyc2RQpT53po0vHybneUTzwvOQ9MPyQuEKHtnwJtUGeNc5lNDw8aI5rMFBK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607857; c=relaxed/simple;
	bh=oFdux9olTbDu52t6QGsMu1O2QLGU8CBbh14drLn0XEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEhNm1D9hVw9qLSXw/sNTVfD0o8sOXhVXb4VIancpm6nslo+EqsfItErZjfMILK0w7eOK+U5tkUBs+W+aH8Rnm9GqocWrqn1R1V5MP1lOjjDowDQD2oZ3v25NDvjzq9+JFFz57UEpOPWlHsc1rC8KnB5a0XZgnUIbCbS1ACg0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QpxRgfb6; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xabDU/adk37A6YmmRSuBPYUcK4Xa2ZqHdjt8F7wVQA4=; b=QpxRgfb611u1vS0qwWjcB1BXyd
	h+fl60knU8uQxLyCLtaCj7WwChyJdhd8gGi3n/z7GqKNHTEGZ6ZCMXTrUx3fhnK8AgEMKoW528m9n
	DkmxvzD5Jj5jS3svANZf9e+Drg4tQ12bx5JRiX/7HhGZ+YcZgYkS6GjXeEOkl/3URhfk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whpsT-00BVi8-Sl; Thu, 09 Jul 2026 16:37:25 +0200
Date: Thu, 9 Jul 2026 16:37:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lee Trager <lee@trager.us>
Cc: "Das, Shubham" <shubham.das@intel.com>,
	"Srinivasan, Vijay" <vijay.srinivasan@intel.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>,
	"D H, Siddaraju" <siddaraju.dh@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
	"Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
	"niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>,
	"Wirandi, Jonas" <jonas.wirandi@ericsson.com>
Subject: Re: Ethtool : PRBS feature
Message-ID: <4ccc869f-a724-41fc-9bfc-da5332f54790@lunn.ch>
References: <6e905826-779a-456d-a37d-7602a37ab6d7@lunn.ch>
 <SN7PR11MB81098D82A7B377E0AC439979FFF62@SN7PR11MB8109.namprd11.prod.outlook.com>
 <cb7921f5-cc9a-49fe-9561-cac903cf611e@lunn.ch>
 <BL3PR11MB63854B0A4AA33A718D474C6588F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <BL3PR11MB6385517EECD04C783E9DC42488F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <26d44b09-d72c-4e23-84a6-3d0ea4a521ef@lunn.ch>
 <705f6fcb-e0e2-4898-bf83-78c38f32f505@trager.us>
 <BL3PR11MB6385468A86BACA1D8EFEF2BE88F62@BL3PR11MB6385.namprd11.prod.outlook.com>
 <SN7PR11MB8109F7A3F491E20701BDC0DFFFF02@SN7PR11MB8109.namprd11.prod.outlook.com>
 <46f714b7-ec6e-4b26-9ff8-b7f27f11fe33@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46f714b7-ec6e-4b26-9ff8-b7f27f11fe33@trager.us>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306279-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lee@trager.us,m:shubham.das@intel.com,m:vijay.srinivasan@intel.com,m:alexander.duyck@gmail.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:jonas.wirandi@ericsson.com,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,bootlin.com,vger.kernel.org,suse.cz,ericsson.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC4C9732B62

On Wed, Jul 08, 2026 at 05:58:52PM -0700, Lee Trager wrote:
> On 7/7/26 2:06 AM, Das, Shubham wrote:
> 
> > Thanks Andrew, Lee for the feedback.
> > 
> > Lee,
> > I don't see prbs11.0, prbs11.1, prbs11.2, prbs11.3, prbs13.0, prbs13.1, prbs13.2, prbs13.3, prbs16 and prbs32 in IEEE 802.3 2022 standard.
> > Is this specific to fnic based on base PRBS pattern or it is mentioned in some other standard ?
> Those were from the fbnic spec, I'm not sure where they originate from. I
> suppose we can drop those for now but its good to keep in mind more tests
> may be added in the future.

Can you find out what they actually do. It might be something as silly
as, the .1 indicate it only runs on lane 1? So these are in fact
standard prbs11 and being able to specify the lane via another
attribute is sufficient?

	  Andrew

