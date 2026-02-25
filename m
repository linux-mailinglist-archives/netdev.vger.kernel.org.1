Return-Path: <netdev+bounces-260987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GYVJ7YIn2neYgQAu9opvQ
	(envelope-from <netdev+bounces-260987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:35:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1932A198CD5
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E75230936C4
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE662741B6;
	Wed, 25 Feb 2026 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GH2KVbIq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FB61C860A;
	Wed, 25 Feb 2026 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029840; cv=none; b=m98mXI9nq/ggn+2/8uSFtpGPPlPPz+DkGoe6GqGx4mZGRr3YaYEFAOdxA5DZ2SXV5XTaB4y4+MbatcepcrL4ytgiL66Pb21qOYT1wKXWbWwn7QzIKVolG/rGSOxfsMITgiTOwi6PNkNe21qpMCr00xBjm1Mj5uVdV6EvCWzWWOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029840; c=relaxed/simple;
	bh=pA/E/vPs/T2BryuzieFLM7zZnyGAP5Zwk7q9hNX/irE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLyG29xTNfSzxgcyF6hJYPYHcwex61ejYEugxjIXLjQxdt5sRjfbMobLA6ZMRmNWV2HbnzBT5kGXppW5gCaM+U7c7oaRIVf3B4PI11T6P8NmCfxiqNwISu55C0NVbdYbg4rT1bQmg3E8ID6TFKKuuST7eGt2TDnyYGhoQz+zQjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GH2KVbIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D727C116D0;
	Wed, 25 Feb 2026 14:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772029839;
	bh=pA/E/vPs/T2BryuzieFLM7zZnyGAP5Zwk7q9hNX/irE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GH2KVbIqKshStxcNl8eqVjh3p7WFAflnClnqOsN9ZmB7QN4g+Xat9jlKWtckhA1BL
	 bsFOujpRG1wLRWD5pbbrOtvJYN7EwEkcILKgT7nn4WwWuWv/WnUtSq13zlt8fTO/Ay
	 PtGmPbE7KCcmTQOJdwm3eX8jYj/M+xAmd9Eeb1Jo=
Date: Wed, 25 Feb 2026 06:30:31 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] nfc: pn533: properly drop the usb interface
 reference on disconnect
Message-ID: <2026022550-routing-grain-6886@gregkh>
References: <2026022329-flashing-ought-7573@gregkh>
 <20260224174203.405d0a93@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224174203.405d0a93@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260987-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1932A198CD5
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 05:42:03PM -0800, Jakub Kicinski wrote:
> On Mon, 23 Feb 2026 12:28:30 +0100 Greg Kroah-Hartman wrote:
> > Assisted-by: gkh_clanker_2000
> 
> I feel like this tag completely validates my position that the whole
> Assisted-by tag is nonsense. Random "Person X's bot" tags cannot help
> any cross-kernel research into problems with AI coding tools. And all
> of us, employees of AI-pilled companies, are routinely using a whole
> slew of AI-backed tools on our kernel submissions. Which cannot be
> practically captured by such tags, since they are evolving rapidly.
> 
> Are you okay with me stripping these when I apply your patches?
> Or do you strongly prefer to keep them?

No objection from stripping it at all.  My tooling has no feelings
whatsoever and are not trying to justify an inflated market validation
with advertising their use and so will not even notice. :)

I added it to show that I did have "help" in finding the location for
where to do this type of fix, I didn't just pull it out of thin air on
my own.

thanks,

greg k-h

