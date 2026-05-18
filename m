Return-Path: <netdev+bounces-289177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA98KCiDC2oZIwUAu9opvQ
	(envelope-from <netdev+bounces-289177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:22:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 114B0573C52
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B2C03022A83
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 21:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC2A396567;
	Mon, 18 May 2026 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsajbWRn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB788328610
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 21:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139351; cv=none; b=cNEZsOsY2GcfNvBhRze9TKRXw7VivjDeIidaasSBA1IZDmiVAG9MQ8jgzJfJnMZVh2A/bCC22cd9F029dZu10xEWpNfAOGWRO9mHdQNjb9wrg4EG2oR8bz0gJH770e2YWeOrV/R/IzIBz40vAcLPjOdZlppIeO//CqA7UKS/SR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139351; c=relaxed/simple;
	bh=lBZQeMPr/rfGBQAiz8tolegT5xEZMrDYPzRwOe5vZOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hI0XUJqcBedRSKNl0us0f4xYBAV3inm5t5+H1o+TqsNnJEorZQwYe8DO+TYXD0Thn5kKXYOksVURKoD5ZkA0VpYcGezw+cPhgcXl/7PU0OOPoHhDj8D92G10QBo5btn0nm6ztZhRwLnD01hoU4OHgnczQ0sXRORaFULl7d4TL/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsajbWRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4767CC2BCB7;
	Mon, 18 May 2026 21:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779139351;
	bh=lBZQeMPr/rfGBQAiz8tolegT5xEZMrDYPzRwOe5vZOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jsajbWRnVxeEey2mcodUUvapkaX94AK+Z42kIwteIUMXQmEF1I5HEFU7MLUMp/9I7
	 ewVKIEfvzvIbYj6gJulUhBAJkizUrz7DBTLvStePiEHQBV0NNfHaoGYi4+VBgj/nVg
	 D6dakkJY+dgLp0qTiHTQbk7XJ3D4P8so+L1Z8hwdY0eEj1dDZvBX+zS5kaDzT77L9D
	 kpsd+bWVlhMHJkycv0aQ5Ez1/KgxRal3IqmCJ3e9Ke7hB9mbqHsn6OwrWwzq32MJDx
	 WS4oD5KfJKptTyjiYkrpJMorP8pONvyaGYWiVYnJNy9H37cTEA/Fm9yoa3EpLIKNJG
	 L7FL908zWAvXQ==
Date: Mon, 18 May 2026 14:22:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] net: team: fix NULL pointer dereference in
 team_xmit during mode change
Message-ID: <20260518142230.4403b3ce@kernel.org>
In-Reply-To: <agrdjt6CjpJo3AYF@Air.local>
References: <20260509181825.1523951-2-bestswngs@gmail.com>
	<20260510082509.1530a1a3@kernel.org>
	<agCtGqWLK53TWCaS@Air.local>
	<20260510095937.598c27a6@kernel.org>
	<agrdjt6CjpJo3AYF@Air.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-289177-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 114B0573C52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 17:51:54 +0800 Weiming Shi wrote:
> On 26-05-10 09:59, Jakub Kicinski wrote:
> > On Mon, 11 May 2026 00:06:50 +0800 Weiming Shi wrote:  
> > > The handler function pointer against the mode_priv state it operates
> > > on.  On setup, init() writes mode_priv, then smp_store_release()
> > > publishes the real handler - the paired smp_load_acquire() in the
> > > reader ensures the handler sees that state.  On teardown,
> > > smp_store_release() publishes the dummy before synchronize_net()
> > > drains readers, so exit_op() won't tear down state under an
> > > in-flight reader.  
> > 
> > Still does not make sense to me. You already add sync_net().
> > And if it's possible to switch from dummy to non-dummy mode
> > the ordering is inverted.
> >   
> > > Not specific to the bug, just a reproducer detail.  Dropped.
> > > 
> > > Sending v3 with the updated changelog shortly.  
> > 
> > Please don't rush new versions out.  
> 
> Hi Jakub,
> 
> Apologies for the late reply and for rushing v3.
> 
> I was muddling two things. On teardown synchronize_net() is the protection,
> the release/acquire is for the setup path where init() writes
> mode_priv before team_adjust_ops() publishes the handler.
> 
> If that makes sense I'll send v4 with the corrected commit message.

Can you provide more details for the init() path race?
What's the sequence of events?

