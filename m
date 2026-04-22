Return-Path: <netdev+bounces-280412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEH1CSbD6Gm9PwIAu9opvQ
	(envelope-from <netdev+bounces-280412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:46:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A24A8446220
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AED53054C3C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB5D3DFC62;
	Wed, 22 Apr 2026 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnesut9B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8D93DE430
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861532; cv=none; b=cfChViwl8j3CKrloq/78ipM9F98xWrRlE0GEi4/8DU58xDBnqKeIgrrBwzzTUtvNmNxkiL6Fj2ja7doKFKR9B4Dx4yAb2hfva4gd6IDYCydy4UlnWQraiMbYjt1jmWKfn98g8jKTkdxqsjLE8xVKylY1U4cPN2+42qk+tbo2xug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861532; c=relaxed/simple;
	bh=d4ef7IAFUxku2M0r86wx3uqfV/9wiLiDDgfV2tIkiK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoYsPNojP3YAIrXJqy5TlvBqYt063OLwC3fs51pFe7+0GdmN4VvhuX6HX1TNHAjm9in+pygz2HhfcIwFQ/NxcHZ9FoX0/9DCgK03nka2BPl2LOxk+Olw/Lqui5+Xp8Q6cp5pmcyvya5yAEpotFEbqlECImSkaY8dKfbx1sqGOW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnesut9B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776861527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HS3D+Ha+v73CcIBqqMttlWxfU9Mtl9bP1rVBmSpTvX0=;
	b=fnesut9BzZG+hjQxpPiF9oiLi2g1qhiez+dh+Lf2luYn/n2DCMGf5IItdS7ehUPAyQ/AtU
	0qUu4qS9/3+OxFViqvhekvp8nI6HZ3FxixW+w/2lQuGOlZVulK79bulWmCbmWuE6wirYRn
	tu0/CK6U0GnJWLxpw9PBj4Vx51TMgUM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-krGhUvjEMcKMk7sFEZSnsg-1; Wed,
 22 Apr 2026 08:38:44 -0400
X-MC-Unique: krGhUvjEMcKMk7sFEZSnsg-1
X-Mimecast-MFC-AGG-ID: krGhUvjEMcKMk7sFEZSnsg_1776861521
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4E17180034A;
	Wed, 22 Apr 2026 12:38:40 +0000 (UTC)
Received: from thinkpad (dhcp-64-111.muc.redhat.com [10.32.64.111])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8213E1800345;
	Wed, 22 Apr 2026 12:38:35 +0000 (UTC)
Date: Wed, 22 Apr 2026 14:38:32 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, kees@kernel.org, kexinsun@smail.nju.edu.cn,
	luka.gejak@linux.dev, m-karicheri2@ti.com, yuantan098@gmail.com,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
	xuyuqiabc@gmail.com, royenheart@gmail.com
Subject: Re: [PATCH net v3 1/1] net: hsr: limit node table growth
Message-ID: <aejBSAoS0FY2AFt1@thinkpad>
References: <3bdbe54e81bd89c1443b05500368fb45bddc3191.1776754203.git.royenheart@gmail.com>
 <aeiHa7rzmSqzMIaJ@thinkpad>
 <20260422085242.3TkVbXc2@linutronix.de>
 <aeiYpkiWUD5MtGEB@thinkpad>
 <20260422105854.trLbmAmZ@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422105854.trLbmAmZ@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280412-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,smail.nju.edu.cn,linux.dev,ti.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A24A8446220
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 12:58:54PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-04-22 11:45:38 [+0200], Felix Maurer wrote:
> > > I don't think the node count exceeds 100 in production. So having a
> > > counter which is incremented while adding to the list and decremented
> > > while removing items from the list would optimize the "worst case". So
> > > instead traversing the list with 1000 we would just give up.
> >
> > The counter is what I had in mind. I agree that allocating under the
> > lock isn't what we want.
> >
> > I'd argue counting through the whole list is the normal case.
>
> yeah but counting here is just a register increment which is cheap.
>
> > hsr_add_node() is only called after the node table has been searched
> > already (without the lock). Here we go through the whole list again
> > under the lock to prevent TOCTOU-type situations.
> >
> > I agree that, overall, it would be optimizing the worst case, but I
> > think it may be worth it to prevent the memory allocations and walking
> > the whole list. But I'd go along with the (current) on-the-fly counting
> > as well.
>
> Yeah. But then you have to manage the counter on add and removal just
> for this "we have too many nodes" case. And theoretically you would have
> to hold the list_lock while checking the counter because nodes might be
> added on both sides in the RX path (unless you check early lockless &
> optimistic and then again before adding under the lock).

Alright, I agree. Let's keep this part as it is (counting while iterting
through the list).

Thanks,
   Felix


