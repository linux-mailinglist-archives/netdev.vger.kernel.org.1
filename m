Return-Path: <netdev+bounces-265316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOAFKSiirWkh5QEAu9opvQ
	(envelope-from <netdev+bounces-265316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 17:22:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 044A02310F7
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 17:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B89A0302797A
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3BE3242D7;
	Sun,  8 Mar 2026 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb/7WReb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4579631D362
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772986897; cv=none; b=jsPdDUgbwau3hm93kU5pcDzRd7Wy0gyc3ZltwghdOXk5qEgMh7limQHf+4L2SuXBSwml6dQGAbB5BVGuzKgNRpMTgjPwA7oEUbQcl6rVFVCV/p8I0jY5aaeeGp2DrCtwzHbDkys1IPBil7v0S8TxDPWUIze6/Xh4D/n8WabferQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772986897; c=relaxed/simple;
	bh=beGas7hW8y3WDrZBntQyyMf3vhncu1Sznj+b3AWqNKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ek9XH9/qMDo0wM131z+hI5wRAKWC2yFUQwEk64S2M5cJmtWu8YG+/t6roxIb53/Nv1dRMuCLAWf0Cp5S+aJ4htP/2UVejZl3aKiW8YEWUiWTBXRgtv8ZAdkTu6woGE+Q89qbCaNELYbwJHb9RD0t6Wtc6KSRihB4ONrlWDJhgy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb/7WReb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4357C116C6;
	Sun,  8 Mar 2026 16:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772986897;
	bh=beGas7hW8y3WDrZBntQyyMf3vhncu1Sznj+b3AWqNKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bb/7WRebZut+zNt3ZkG2X5wqcKPZ1EN3FBsCsQs/t1njLUYG/iLZx9OEGD5xUCLwJ
	 XFm6nTTp06SngoZxk4ox3MJlNXng0qdMJZ8kZIsrLM99xeCaSZutbdaaUATqYRgE4h
	 RoEkEjoVahCm/3T1fuI/aH6SKisA5Y7MsbZ6enRs7N0aVujIXnUoJOqt2AsWT+IdPv
	 lAMW+33uRqWt1nnVtcACRWhUfnMfTppre5QhK4+iOu83CLvfQ5k4vY1vXDoPL47unV
	 6yOfzmZ8e9OqQu9/YlwzSRLA1+Mz0sFhmpBvcRdqxTDkiiUUfXRbh9FaMlNLj8S+5u
	 wgisB9bac0YhA==
Date: Sun, 8 Mar 2026 09:21:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH net] page_pool: store detach_time as ktime_t to avoid
 false-negatives
Message-ID: <20260308092135.021c2bf0@kernel.org>
In-Reply-To: <CANn89iKaWRQfSPXc+nqAhz8Zj-Yh+kohPdOvFw-fzNkWTW1TXg@mail.gmail.com>
References: <20260307204022.1897614-1-kuba@kernel.org>
	<CANn89iKaWRQfSPXc+nqAhz8Zj-Yh+kohPdOvFw-fzNkWTW1TXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 044A02310F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265316-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.978];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Sun, 8 Mar 2026 01:10:55 +0100 Eric Dumazet wrote:
> > --- a/net/core/page_pool_user.c
> > +++ b/net/core/page_pool_user.c
> > @@ -245,7 +245,7 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
> >                 goto err_cancel;  
> 
> It is a bit unclear if we always hold page_pools_lock at this point.
> 
> If not, a READ_ONCE(pool->user.detach_time) here would be needed,
> and a corresponding WRITE_ONCE() in  page_pool_detached()

There's a bit of convoluted wrapping to share the code between page
pool access and access to stats, but AFAICT page_pools_lock should 
be consistently held by readers and writers.

