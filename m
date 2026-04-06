Return-Path: <netdev+bounces-275642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YILJEtja02nVnQcAu9opvQ
	(envelope-from <netdev+bounces-275642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 18:10:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DE23A51BF
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 18:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA3273012C62
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2703D34D4CB;
	Mon,  6 Apr 2026 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tt58F5K+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04845333725;
	Mon,  6 Apr 2026 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491711; cv=none; b=qRYF9ddwle5fg+oESqOUusR6WoLU1bIuZMj1ZtdhH+pd2TXugPzXkM7DiTKd4DhPHvyf3laGZkpwnsheANmz6EVlX5KPDub9EYtgZJQc3uCSkZnU62S0DNdmJ2f0Pc3LDvywho7H10wbARbbipCOiZZFaw2RVhsKxZdPHnt2uFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491711; c=relaxed/simple;
	bh=VVxFoFjG/viRylOKdJE72jCsFfLi8SfWOjDNLB6ndq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+v+/cFC8zitFsA97auYUgXja0GCQhmGZeeTERafecvr+maHwzbJ75mKY+uxaRC8fo+r9MkWHVVRSQnRRG31sco+xZdfpT5SIDbKp4b7slPTRMMzmXVv6jdBDZ5aPKx6nUedojO437ylPNz/HfWAUU+H0FqEuzyuZKTxfiys0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tt58F5K+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B538C4CEF7;
	Mon,  6 Apr 2026 16:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775491710;
	bh=VVxFoFjG/viRylOKdJE72jCsFfLi8SfWOjDNLB6ndq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tt58F5K+XO8W5bz/+zz9ZiD0d2HDiXubM0HxePDecMmVR0N7BtK9Qi1gq3/dwCXe/
	 l2HCBhXbag3dlcxqLtMazj8unsIKEJliGvvriHE5LM4y0W1C8nkIPl+GMYCJy1layO
	 tNPowgE6Vg98BxfvV6SDo3t4iuTNY7lGscvYWyYI=
Date: Mon, 6 Apr 2026 18:08:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] xfrm_user: fix info leak in build_mapping()
Message-ID: <2026040634-deodorant-shakiness-a64e@gregkh>
References: <2026040602-shack-tamale-d8c3@gregkh>
 <20260406085449.266466ae@kernel.org>
 <20260406085859.2e9843ea@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406085859.2e9843ea@kernel.org>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275642-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A2DE23A51BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 08:58:59AM -0700, Jakub Kicinski wrote:
> On Mon, 6 Apr 2026 08:54:49 -0700 Jakub Kicinski wrote:
> > > Note, I think this is correct, as I don't think a new skb has it's
> > > fields pre-zeroed out, or am I totally wrong here?  
> > 
> > You're right, skb owner is responsible for clearing after put.
> > Tho, Netlink is not as perf critical as real networking, I wish
> > we at least had a helper which reserves the space and clears it :/
> > This is not the first or the second time we hit this sort of a bug.
> 
> We could make nlmsg_append() do that. Mostly because I don't have 
> a better idea for a name and nlmsg_append is only used once ;)

As shown in my other patch:
	https://lore.kernel.org/r/2026040621-poison-gristle-aaa3@gregkh
we need this in at least 2 places, don't know if it's worth doing it for
all messages?

I guess nlmsg_append() would work?  It tries to do some zeroing out for
alignment for some reason...

Want me to do that?  I don't have a way to test any of this, I just
found it using some static code analysis tools that looked at holes in
structures.

thanks,

greg k-h

