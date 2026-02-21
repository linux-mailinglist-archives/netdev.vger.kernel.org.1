Return-Path: <netdev+bounces-259805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBhxGNQGmWmiPAMAu9opvQ
	(envelope-from <netdev+bounces-259805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 02:13:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B714B16BA88
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 02:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65BBD303464F
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD94E30FC3C;
	Sat, 21 Feb 2026 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/HipnfL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF483595D;
	Sat, 21 Feb 2026 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771636433; cv=none; b=eiqWuYM6zoqOqBHohaQEfvx+yVM0piQkl5LFWZJcDX8UIktRHgiOy2lxQe51R5k+pV9OaM9YDktIqBLedVo56j44q2yk1+fhW9N4N7bhUT/+S3vnzWmrDg86nta+LId9ne6zC5iVQ8TyPt230BY404WNzfSRYmrSn23PM8VPk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771636433; c=relaxed/simple;
	bh=MqSHxwvgM4zu0rmAxoI2NqE0/imfVFQoVugVgD9NoPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSHSGi0eyjbrWm2siDEUL+pBKUIV6erWY5aGxXAupq0csAuEXhgwZRwjuVcFIn/MSXj/jciCjyyZNCsBWo+w4N7QZChOAMuBWDVLet3qLjwBZyJWZF94bbr4Jnahvbie4Bzi+UVJCdfA1jQdg+QwRU7MqRNjrS3M9iBGrWP7ois=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/HipnfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3AAC116C6;
	Sat, 21 Feb 2026 01:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771636433;
	bh=MqSHxwvgM4zu0rmAxoI2NqE0/imfVFQoVugVgD9NoPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F/HipnfLKNkXYVfUKkgH0swrc11uBVeJZFuY7VkfCUvTEsq+mX5hAkQXJKCpmsC9d
	 WCbWsbcHS1iHzJ22R9PTm7FSQRb/0kKgDIYkU2etWh5WDjOgYzsoLiBz0jDadLEPBR
	 JqNqp8JvcsQEuYWwdeS7lEdEhBzRQ/sugwBIrQWRPtbDRZFyrMRYg0yTPFPevL+O3v
	 dz2WV4UFFv9nAlXv9KYGYf5vs9T7rWhbTqF9hXp1ibmg3LZcHFc9sTmdjqVZC38fO+
	 Fiq5cvpDp+Mocuu3TXwgYLQguCf2Y+oLymFPLYX3OQ03orYigK0hbGFSEelD795uaE
	 G1iaJ3y9dchMg==
Date: Fri, 20 Feb 2026 17:13:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Simon Horman <horms@kernel.org>, Zijun Hu <zijun.hu@oss.qualcomm.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Herve Codina
 <herve.codina@bootlin.com>
Subject: Re: [PATCH net] net: wan: framer: fix potential UAF in
 framer_provider_simple_of_xlate()
Message-ID: <20260220171351.32fdf97c@kernel.org>
In-Reply-To: <aZkAaoBxb8j3FqGr@google.com>
References: <aZefB5f3EAkQQM1m@google.com>
	<20260220162553.3beafdcc@kernel.org>
	<aZkAaoBxb8j3FqGr@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259805-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B714B16BA88
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 16:56:12 -0800 Dmitry Torokhov wrote:
> On Fri, Feb 20, 2026 at 04:25:53PM -0800, Jakub Kicinski wrote:
> > I have failed to understand what you are talking about after looking 
> > at this for 15min :S Please write better commit messages?  
> 
> Yeah, I should probably rephrase it, container_of() is not that
> important.
> 
> The core of the issue that once you do put_device() it may disappear,
> so when you do 
> 
> 	return dev_to_framer(target_dev);
> 
> the returned pointer may no longer point to the valid framer device. The
> memory may get used for something else entirely.
> 
> You have to hold on to the reference until you are completely done with
> the device.

I meant you should explain the code paths that are involved.

> > AFAICT this get_device() does not pair with the put_device() 
> > you are removing  
> 
> It does not "pair", but it tries to bump up a reference to the device we
> just did "put" on in framer_provider_simple_of_xlate(). If we remove put
> there as I propose then we do not need to do it here, or we'll end up
> with an extra reference.

Yes but there seem to be other callers to framer_get() which 
pair with framer_put() and no involvement of
framer_provider_simple_of_xlate(). framer_codec_probe() for example?

> > >  	if (!try_module_get(framer->ops->owner)) {
> > >  		ret = -EPROBE_DEFER;
> > >  		goto err_put_device;
> > > @@ -749,7 +747,6 @@ struct framer *framer_provider_simple_of_xlate(struct device *dev,
> > >  	if (!target_dev)
> > >  		return ERR_PTR(-ENODEV);
> > >  
> > > -	put_device(target_dev);
> > >  	return dev_to_framer(target_dev);  
> > 
> > The only caller of this function does not dereference the pointer
> > (no idea why it even calls it, for some setup validation?)  
> 
> The returned pointer ends up in framer_get() through a few layers.

Ack, I think I see it now, thru the ->of_xlate() saved in the provider.
This is the kind of basic detail that should be in the commit msg..

> > >  EXPORT_SYMBOL_GPL(framer_provider_simple_of_xlate);  
> > 
> > I'm kinda curious about the backstory for this patch..
> > What made you look at this code?  
> 
> I want to remove class_find_device_by_of_node() in favor of
> class_find_device_by_fwnode() so I happened to look at the code.

Good luck :)

BTW when you repost please make sure you CC Herve, looks like the
MAINTAINERS entry for framer only covers one driver :/

