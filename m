Return-Path: <netdev+bounces-276227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAhKCnGr1Wm28gcAu9opvQ
	(envelope-from <netdev+bounces-276227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 03:12:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA083B5E01
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 03:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26A3A301A73B
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 01:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8373033F8C6;
	Wed,  8 Apr 2026 01:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ5mZqZR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6083E2459D4;
	Wed,  8 Apr 2026 01:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610733; cv=none; b=ACz+21githh5w7TGWPuUuoXmm0ZFP/e31sj3s5I6Qe1w9tx5kTUylhj9BhQZ4gM6ZHLpdHmqCMA5DjMBU3YKQRu9Xf5mBGAUryE07BtLg740MUXMtLfzm1P1+yvSKvbO//UayeZcnqn2kkdzwWV+w6c4fne/74IFNbZkMhfNepk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610733; c=relaxed/simple;
	bh=YPo4hFpWzFlbFJ523vVcKIU6z0/wC6Z7CXuSsBT2ZmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvMIg6eXkiWE/sIQg4KpCP5mveua9pWqGVGZY3QspkTvD7mdPiq4XpcHe9m861mHE+LP54tYMOpSXj0aFvtslPFirAOyKyC9PSVI90jhdJZlpRHke3tVkUqwLJ8LdU10MoXw8qXFiQvpUyDj4iVQFcuupIW05/ZiOLiLIlPFUtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ5mZqZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A69C116C6;
	Wed,  8 Apr 2026 01:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775610733;
	bh=YPo4hFpWzFlbFJ523vVcKIU6z0/wC6Z7CXuSsBT2ZmM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XJ5mZqZRN3Hdos8jIDa3T8gUPTl+H5motGktan4qPJqsgaxNDM7lsVDuoaFwiIUHH
	 RkjrM8ovpBMZp89qRYl8tCDtfnS2vno8eiH0azojUAXurE4bqdXnzf+ojRJXG3tvzM
	 FhBHcd0vt6b3NtZUG3eMjhQO8/zOGmbxXjR3Yia7ND2dGG3hoH7cdb2PtcgjiPlEBg
	 Y3JNizMEGF8/T94QadlN9Rh1EvGFOmoPa18VA1aAYS5m9KgR8NQXPYUXFdtWsPDODC
	 gybOM9kfYcUJpU6p3BPC954fTG9/TsyMvZRTqPRQVFn2XELHaDVQY3ylWcmBErfz49
	 3XGGZQHxQrh1w==
Date: Tue, 7 Apr 2026 18:12:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steffen Klassert
 <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>
Subject: Re: [PATCH net] xfrm_user: fix info leak in build_mapping()
Message-ID: <20260407181211.5419f2cc@kernel.org>
In-Reply-To: <2026040745-crafter-awkward-8901@gregkh>
References: <2026040602-shack-tamale-d8c3@gregkh>
	<20260406085449.266466ae@kernel.org>
	<20260406085859.2e9843ea@kernel.org>
	<2026040634-deodorant-shakiness-a64e@gregkh>
	<20260406103851.59a200fc@kernel.org>
	<2026040745-crafter-awkward-8901@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-276227-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DA083B5E01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 7 Apr 2026 07:51:15 +0200 Greg Kroah-Hartman wrote:
> > > I guess nlmsg_append() would work?  It tries to do some zeroing out for
> > > alignment for some reason...
> > > 
> > > Want me to do that?  I don't have a way to test any of this, I just
> > > found it using some static code analysis tools that looked at holes in
> > > structures.  
> > 
> > Do you have any more Netlink leaks in the queue? If you do let's do it,
> > if you don't we can wait until the next victi^w patch to arrive.  
> 
> I do not have any more, sorry.  So is it worth it for just these 2?
> Your call :)

These are fine. I would have applied but I think Steffen will take them
via the ipsec tree first (LMK if that's not the plan, Steffen)

