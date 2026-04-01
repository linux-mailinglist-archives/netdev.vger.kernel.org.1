Return-Path: <netdev+bounces-273988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM1HMCbbzGlzXAYAu9opvQ
	(envelope-from <netdev+bounces-273988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:45:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 617A03770AE
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 10:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BFD903000B2E
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 08:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63543C141A;
	Wed,  1 Apr 2026 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EIqIZSRj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E193C140D
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775033124; cv=none; b=dOhyWaGyLVjO8DZJu+LE0e5hA4HZ27EIieWB8nJjHehY5hUQlQ47RUjfg+XmJSNNgVB+AOEYHbrd5N0KWaZeHGysojr0h4cbuIPuEg5KgT+G2J9q4CvTHIU8zwYIIvQvm5EkurIQJgH7sTsflCTy8nwYWBHE4VFXNhXpyOM3w7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775033124; c=relaxed/simple;
	bh=hbyn0Bo17gpipGqOvifiU3aLZ45yFWA3q1vXwTBRM3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mopWuKRyeQ0zM0yNYYglrZ1mvTyw5a7fpHLSx3xXyYb3OcoF43RmaGR4o6K5kMMsQof2jKboRUnEwYyjYc5PlV9OmWcMkHT19DRndS+zf1BK2u6Lmhx4N+5FnszzHO+JhAFiazSQfy5Qot1MGctnkL0xxF9LtctETmbsDPhyYVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EIqIZSRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC16AC4CEF7;
	Wed,  1 Apr 2026 08:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775033124;
	bh=hbyn0Bo17gpipGqOvifiU3aLZ45yFWA3q1vXwTBRM3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EIqIZSRj4QxX5s6G+b666Hd12f4n/vZY8f7cV9S7kLKGctNsw10lcZ12WIj0EYDBL
	 m4WGjHYrHN1x8Z0go9/YfO4UnV8N/D7vc9tl8EkpQFBONQt6SVxOHQaVbx7VFdnJsE
	 rAdaz4BUITaIACqUdogFGam9MhlcqiHpbsCWAmBc=
Date: Wed, 1 Apr 2026 10:45:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yuan Tan <yuantan098@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, kuniyu@google.com,
	Ren Wei <n05ec@lzu.edu.cn>, security@kernel.org,
	netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	afaerber@suse.de, mani@kernel.org, yoshfuji@linux-ipv6.org,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
	enjou1224z@gmail.com, zcliangcn@gmail.com
Subject: Re: [PATCH 1/1] net: ipv6: flowlabel: defer exclusive option free
 until RCU teardown
Message-ID: <2026040156-stimulant-curled-20a4@gregkh>
References: <cover.1774855883.git.zcliangcn@gmail.com>
 <07351f0ec47bcee289576f39f9354f4a64add6e4.1774855883.git.zcliangcn@gmail.com>
 <CANn89iJ+pDwKy0kKKG8PrSWMXEStgsMP9YGLxwvjcmMJP1PwrA@mail.gmail.com>
 <4631f54a-bcc8-454b-9355-15a21f9e1e21@gmail.com>
 <CANn89i+XGF+GheZDO+aWaw5V18mGu2H4OWsCpfs7HriGvCsCRA@mail.gmail.com>
 <7c26a74d-90c5-4520-a10a-22f06e098b86@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c26a74d-90c5-4520-a10a-22f06e098b86@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273988-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lzu.edu.cn,kernel.org,vger.kernel.org,davemloft.net,redhat.com,suse.de,linux-ipv6.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 617A03770AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 12:05:31AM -0700, Yuan Tan wrote:
> On 3/31/2026 6:05 PM, Eric Dumazet wrote:
> > On Tue, Mar 31, 2026 at 5:41 PM Yuan Tan <yuantan098@gmail.com> wrote:
> >> On 3/31/2026 1:52 AM, Eric Dumazet wrote:
> >> Finally, regarding our tags, our team has a clear division of
> >> labor—some focus on finding vulnerabilities, others on fixing them,
> >> followed by an internal review and testing before a dedicated
> >> member handles community outreach.
> >>
> > You included 8 tags, this seems a bit too much for such a small patch.
> CC Greg here, as he knows a bit about our team's background.

Yeah, 8 tags "seems" like a lot, but for a team that is working on
these things, I think that is good, a bunch of people are wanting to be
on the "path of blame if something went wrong" which is nice to see,
they aren't just dumping the responsibility onto one person :)

So I don't have any objection to this at all, and in fact, welcome it.

> Our team has developed a tool that found hundreds of non-root bugs with
> PoCs. We want to ensure these are fixed properly and quickly rather than
> dumping reports onto the mailing list and hoping for others to find the
> time to fix. So we have organized a group of promising students. As some of
> them are new to kernel development, we have been providing hands-on
> mentorship to guide them through the process.

This is a good thing, thanks for doing this, it is helping both the
kernel out in getting these things fixed, and these students to get them
great experience in working upstream in a proper way.

This is great stuff, I wish more professors and schools would do this.

thanks,

greg k-h

