Return-Path: <netdev+bounces-278070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLTnBYbl3GkZYAkAu9opvQ
	(envelope-from <netdev+bounces-278070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:45:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 687893EC2AF
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7706301AA65
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83693C4566;
	Mon, 13 Apr 2026 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qiIsM++W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C592F3A9D9E;
	Mon, 13 Apr 2026 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776084144; cv=none; b=qpgkK0IkNIZNrGc8WvcP/Tf3VRu4HqGJBJAwzv9Ptr4iiP+ZX2WE5etdjdiP8QqHXqnNpaOQTp1003QcUeEzDbdSob5BzrtH/dqsnzShvb6HAFiwpzQTfX93gci6xzbezkuaZOAsZK2Q3dyLqyYXiw4x944J4b7I+3gHcxacvN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776084144; c=relaxed/simple;
	bh=jE0Qgm0u+16Hck7IZ25n1n4PjSLQV9UclFHDQiaGkF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uB6wjzYf01fx84dql1iwdUkBR3A84jWu5rWlY8t//6wb1eKJWerDvPbgzS/bIjwCxiQ2Ap0fJC1Q74dErXv8J7zHkI4DWYriu2N7iokqQq0W1EJc2mN9vhhwi81vgnPWnzJZAVAUKXa1RHlH/Oqvf5qtyw3kiqDQTJDmdHkp1og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qiIsM++W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2539BC2BCAF;
	Mon, 13 Apr 2026 12:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776084144;
	bh=jE0Qgm0u+16Hck7IZ25n1n4PjSLQV9UclFHDQiaGkF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qiIsM++WiMmo4wsKMS+ZSAS4JWnefmbuXMmkByfsSxlqZlawzFeO9GGGy5Da3/dBs
	 9oGYmFK8/I9jyiwAUzXgmUY7zOOjou+RmFOq3GcGpkNdAQYSNL8bbPlM0w4U1pN23E
	 KKj0VDM/kzt0p6w8lMX/6wB8GLb30XXggbMNRmaE=
Date: Mon, 13 Apr 2026 14:24:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] net: usb: cdc_ncm: reject negative chained NDP
 offsets
Message-ID: <2026041355-designate-spiritual-e785@gregkh>
References: <2026041137-comfy-eaten-a1ed@gregkh>
 <2a6963c8-4a87-4fed-b875-d46f3ce53e42@suse.com>
 <2026041325-giggly-wrecking-e6ef@gregkh>
 <198c1240-80a6-456c-8b12-25158c90c965@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <198c1240-80a6-456c-8b12-25158c90c965@suse.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278070-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 687893EC2AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 02:11:50PM +0200, Oliver Neukum wrote:
> On 13.04.26 12:43, Greg Kroah-Hartman wrote:
> > On Mon, Apr 13, 2026 at 10:36:19AM +0200, Oliver Neukum wrote:
> > > 
> > > 
> > > On 11.04.26 12:53, Greg Kroah-Hartman wrote:
> > > > cdc_ncm_rx_fixup() reads dwNextNdpIndex from each NDP32 to chain to the
> > > > next one.  The 32-bit value from the device is stored into the signed
> > > > int ndpoffset so that means values with the high bit set become
> > > 
> > > Well, then isn't the problem rather that you should not store an
> > > unsigned value in a signed variable?
> > 
> > No.  well, yes.  but no.
> > 
> > cdc_ncm_rx_verify_nth16() returns an int, and is negative if something
> > went wrong, so we need it that way, and then we need to check it, like
> > we properly do at the top of the loop, it's just that at the bottom of
> > the loop we also need to do the same exact thing.
> 
> Doesn't that suggest that cdc_ncm_rx_verify_nth16() is the problem?
> To be precise, the way it indicates errors?
> As this is an offset into a buffer and the header must be at the start
> of the buffer, isn't 0 the natural indication of an error?

Maybe?  I really don't know, sorry, parsing the cdc_ncm buffer is not
something I looked too deeply into :)

greg k-h

