Return-Path: <netdev+bounces-263854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DglMaBPqGmvsgAAu9opvQ
	(envelope-from <netdev+bounces-263854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:28:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 756FE202AAD
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CCD5302FB07
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126AF24676D;
	Wed,  4 Mar 2026 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EGGvURqh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B091F3FED;
	Wed,  4 Mar 2026 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637307; cv=none; b=cX7vDN+Eav/jyTUK5HVk5GW9kciULGLid1YII59HwyjQhROQEpzjlECuIX2qIbfj4uitrlopAxyEsxW5e1RCH7tdMnDq+4R1k5sjG/Y5OnrYo9BaCO33ky6XWQ1ppyAt+DKT8v9lpMDJHR/yfyUXfO6t1rpEDDlu+rFe5vV0X0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637307; c=relaxed/simple;
	bh=x4R8A2RNTfUwzOXr3eMyGbEAnd2tLvcvAMGI+tjAWi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFWMTELcbR66nMFTvH5QuDWHNmrx0+L87SsTBClYjhjKLbec6ooYLJhU0UhJoojsVN3yFCiuLvonAVAmauDx2189cafdYeujDntLDf3bxScDIVouAVUFRqOsGW+nrACdTmCyON5SL+pakH0QaodGOAfCtP/y3dnQbDqX2DNMMjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EGGvURqh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/F/6qnqfXtJ15sBnSuLKV29FiLetLwxJj98fT8vIhN4=; b=EGGvURqhv+xBc/Oiqth4S3Uq/g
	tfch3dfxw4MVoNSLfdrO/vjyOBNg3VDYRzZGlCNwtRe9n9+bjBzN2CNmGpwHPc7VE+6bJthhJRYQ+
	7r567lrAq0nrS7AFv4r7k18Kl+e5hb0WPT2aDG1yl8R0i35qVdJfLogPFM/v6xhlM8zU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxnw6-00A7lc-TR; Wed, 04 Mar 2026 16:14:54 +0100
Date: Wed, 4 Mar 2026 16:14:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/8] net: dsa: add tag driver for LAN9645X
Message-ID: <8ce78efd-2304-43d2-a755-4189fcbffb25@lunn.ch>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-1-bff8ca1396f5@microchip.com>
 <c0213890-ef36-435c-aa73-869ee5e849d5@lunn.ch>
 <1ceeb7fb0abc89f4b384c9d73b7d29c73bb8d53b.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ceeb7fb0abc89f4b384c9d73b7d29c73bb8d53b.camel@microchip.com>
X-Rspamd-Queue-Id: 756FE202AAD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263854-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Action: no action

> > These functions are big enough i would place them into the .c file.
> > Then, normally, i would say, please don't use inline in a C file. But
> > here we are in the fast path. Have you tried this with and without the
> > inline? How does it change the object size and performance?
> > 
> 
> I did test performance back when I first implemented this. I had some issues
> getting gcc to inline the functions, and that hurt performance quite a bit.
> But I did not look at object size though. I moved them to the header so I could
> add the inline. I can move them to the .c file in the next version.

Developers often get inline wrong:

It is used on the slow path, so all it achieves is bloating the object
size.

It is used on tiny functions, which the compiler is likely to inline
anyway.

Your use case is different. This is fast path, and it is not a small
function. You also have a good justification, you know not using
inline really does hurt performance.

So, please move this into the .c file, and use inline. And add a
comment to the commit message adding your justification for inline.
If something is justified, we will accept it.

	Andrew

