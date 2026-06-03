Return-Path: <netdev+bounces-294888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fzj2E5d/IGp+4QAAu9opvQ
	(envelope-from <netdev+bounces-294888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 21:25:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC79363AD52
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 21:25:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=S2btUDHo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294888-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294888-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 481E73056636
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 19:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C4548BD45;
	Wed,  3 Jun 2026 19:24:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E552348BD22
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 19:24:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514667; cv=none; b=VvE2X7BNrpBTGeEze7CErQII0/e7KjAdRApmX2CiU6XRYHP6PMF1mqF+Cg7PlUoeUCzjor8LQ5apexZlVDfbqFNjUkEpUCW6Bi+NBSvrqHqKeeciicJzgnfj0sEwGeyfO4QcXG1A83OMaMOmZmvuZtf1zLxO8rxWQ9mHj3Lwp+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514667; c=relaxed/simple;
	bh=9gfUHrdoR1LzqY63DNhYraq2XhjxJEOvKb6+mvRgSVk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=OAB4rBYK1EKINdo6pKzp2hYJAST2UYenvGcYQGXCbCFVWqSiAlMhcI44grti8Pk3NAkbrQ0gi2UKWS23sdK43iUhuuXUVJr6zOo7oGY5LtWDJn+cGbBNSUNtkOLMZeY9g2ICowy/I7VbxEmhgd2q8UYGfYVpyveyFl/WCbHCLnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2btUDHo; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780514664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9gfUHrdoR1LzqY63DNhYraq2XhjxJEOvKb6+mvRgSVk=;
	b=S2btUDHoQOyZdSdiYKwowfluTm1qoxKHXKrE73zhUMTLPgsA7fVLoATceiGt1Vr1Z9adVR
	O2/X/h5W36t+057F+kg8fnx//8KW31fVNjBFkGS7zk6P1Ep48LR5+TP8gCcNYvVrtq8Ghh
	6rhZOEfcMtmFD7Rl9NMg4dghfhHG4yM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-lMJTVDivP3Ogp6JqZBXk8Q-1; Wed,
 03 Jun 2026 15:24:19 -0400
X-MC-Unique: lMJTVDivP3Ogp6JqZBXk8Q-1
X-Mimecast-MFC-AGG-ID: lMJTVDivP3Ogp6JqZBXk8Q_1780514656
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CFCE18002FF;
	Wed,  3 Jun 2026 19:24:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.52])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 219B0414;
	Wed,  3 Jun 2026 19:24:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wiFuud0Nn3B9YpTWyQja08TeXVk2AB-aAkmVXyigOagbQ@mail.gmail.com>
References: <CAHk-=wiFuud0Nn3B9YpTWyQja08TeXVk2AB-aAkmVXyigOagbQ@mail.gmail.com> <20260531010107.1953702-1-safinaskar@gmail.com> <CALCETrW__=8mSusayfXG7UFCfue5BGbx+vqESj1d9wqOfX4s8w@mail.gmail.com> <ah2nBAdsE5vVJ2PL@casper.infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
    Andy Lutomirski <luto@amacapital.net>,
    Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
    Christian Brauner <brauner@kernel.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
    linux-kernel@vger.kernel.org, linux-mm@kvack.org,
    linux-api@vger.kernel.org, netdev@vger.kernel.org,
    Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
    Andrew Morton <akpm@linux-foundation.org>,
    David Hildenbrand <david@kernel.org>,
    Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>,
    patches@lists.linux.dev
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22833.1780514647.1@warthog.procyon.org.uk>
Date: Wed, 03 Jun 2026 20:24:07 +0100
Message-ID: <22834.1780514647@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,infradead.org,amacapital.net,gmail.com,vger.kernel.org,kernel.org,zeniv.linux.org.uk,suse.cz,kvack.org,kernel.dk,linux-foundation.org,suse.de,szeredi.hu,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-294888-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:dhowells@redhat.com,m:willy@infradead.org,m:luto@amacapital.net,m:safinaskar@gmail.com,m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:axboe@kernel.dk,m:hch@infradead.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:patches@lists.linux.dev,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,warthog.procyon.org.uk:mid,vger.kernel.org:from_smtp,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC79363AD52

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Well, since it pretty much is what I suggested a few years ago, I
> certainly won't NAK it.

I've been wanting to get rid of vmsplice for a while, so I'm in favour of this
too.

David


