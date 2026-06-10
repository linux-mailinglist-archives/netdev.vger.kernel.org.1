Return-Path: <netdev+bounces-297704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3o6tIIt0KWp5XAMAu9opvQ
	(envelope-from <netdev+bounces-297704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:28:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE39566A364
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:28:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=gdiP8RXd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297704-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297704-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F41CA3040DBA
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AAB317160;
	Wed, 10 Jun 2026 14:18:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776DC2F747A
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 14:18:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101091; cv=none; b=exRMk65dAg9wzYffEuSnSBn9JP4hlJcoCXTay5WyjtBM5SvTTjwL1J5MwLQn5GDWaduLr0BDucPK0rwpYb/6VLuWQnbG9Rh3tBT50TAR4VE1CGFt66anKnZYu0AFZLxxrysgUq/jdOrNrZ1JPt2FegVEXBRsSQEXLn/Zt/HLN1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101091; c=relaxed/simple;
	bh=BJ9c/ol6w+Ube8nVPNM3mIfu3An8puBsF+RZnr8il0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvz3VGof2iriulayIEZaN2Id2JjssCgbZLKwTk2H/ruHaOUTSOHJ82kWAqAjBWO/F6IIrhU3tk643PaSJbTmzVKJsHpG4LamZI1I53WYgGQ4fdONfo8bPBuB7Y4ngGk4WsglAG7udTYQzKsYOWl7GJYUob6NxG2uAJI+2lRId7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gdiP8RXd; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf3781ca51so62518275ad.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 07:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1781101090; x=1781705890; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TtsvHh9Pn+Rylz6+XRT7TQz3RFIWkIYkOyPrXmDgVAQ=;
        b=gdiP8RXdTJCVfh3JawA+ddNlkyUX1gaTteGdoqt9nDamvQzSlELWAwj/jvQKjmcX26
         3thqtAN4ZYzA0GSIgRftk3uSlqtiSULcJHhV8TyQ3/vPuJvERx+4gDfzbQkiITeGXyy6
         3BNJkG9HBpRnMAh0eQga/8hAPFBdZ7d2VQrvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781101090; x=1781705890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtsvHh9Pn+Rylz6+XRT7TQz3RFIWkIYkOyPrXmDgVAQ=;
        b=UofRDUC/nseb4S7c2qk8yp1rMOBNbqVGPRp7jLkmKkmPfzkHxKmAdKC2bZR8nkSlZL
         16KVsv5KlRF/Ekcc/GtWdHjd/5i3GupEWs7rb0kunc1wLd2G8kk7l6Sw2CHVyaWRKCWn
         QIDhotTwZNeKdo/I8/CZTSowMILp7GYBYvaJsQ3sDdK8x4xzmWTkLWLFDiYYz8zEovVG
         EGlasv9OUDfAVYcEQxrKa+mybGEJVjIwlOoPFRplJ7EMOvmZgPm1QSaBEX3jP9Y1+sgj
         71BhGDZrxwzP3YfwciE5TX3iV4lewAR1in+mnPlivH+iDpGt4x3697wwVXn+wHGQ8Z8j
         3RMw==
X-Forwarded-Encrypted: i=1; AFNElJ83bOUuGes3l5wfKxbYDc5NfR3U9fPkwc4USugIe9OGffFFfyhIyhoBpFljJh0Z2ltu0+yZfPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPUaR/j6jRXHev3UNRZ4rBIrO8EFpxwsw882EYzURcBxYhUhNE
	oNvvmDaVJPGDa9Evz2ylb7VK1GMz6FQ9omO5uPwCQHFpPGFDAyzm7+5wGRhEnJZjxRM1NSssI76
	hdH5scdg=
X-Gm-Gg: Acq92OGNoZpjxQx8l/vpfIHOp28idwBMjMhAyNJEaOFDqhiFj6Qonk06dPodOEKx/SW
	CgADunCZSIXTM/D+v3z9aqcHRQgJN9yiEnYvv6RJpuj5XZLbsgt2Hpg+AwkrG9vxK09es+U0+SO
	38cGgYVNXDl+d+jnqhJHOIAnacheef1dQatVnzxYUWY42NHd0/BjiG+qftQK9+1LOqExySWbU3d
	NEWmAqAH6EPYUTWiYSoyKY8jrYgor5eicF3VTLxGOIqpTm+DHIXKDMyP1icqp4ImjEG3uvhDVYr
	hJr2J6OWa0cz4UStBFsJRQWcR5fXHeq3f7POpitwkxAfTgj87gvDgERc5XSSr6wYfSrz8oQeAsY
	sGkLbkY6l6ovcBwatllGjiOv8u35e5ULzy9KkYkpMdFCam9KBxEiFwOZpFa3lfK8/o0JhZTs9VY
	oQE4hvrlVSMrAjmPBUoCQLEX1qdm6O7x9JTe2/QjwbvmRElDDd0aM9ve0uXeqbJUvD3VG3P3Y8q
	1uog7yeQnQ=
X-Received: by 2002:a17:903:32c6:b0:2ba:3e2f:6883 with SMTP id d9443c01a7336-2c1e8209e55mr302513495ad.19.1781101089240;
        Wed, 10 Jun 2026 07:18:09 -0700 (PDT)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com. [209.85.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609df63sm244781625ad.40.2026.06.10.07.18.06
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 07:18:07 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so7368087a91.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 07:18:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+KodyXEd9xUgF4RlS9pJiLvDR+Vtx64k/AbQIeYbxoE7Hdil77KlH1u7HqO6AqRPCgWugJCiA=@vger.kernel.org
X-Received: by 2002:a17:903:244e:b0:2c0:ab92:584c with SMTP id
 d9443c01a7336-2c1e8209b98mr287326215ad.25.1781101086478; Wed, 10 Jun 2026
 07:18:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whL0oLvmh3FO9SapDhgrXMT_d6qkP2V3OBjysOWXod2Og@mail.gmail.com>
 <aijyuX14ahOf53zM@gondor.apana.org.au>
In-Reply-To: <aijyuX14ahOf53zM@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jun 2026 07:17:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeLy2n9H82_THob=wzOEfsQT_yP05ZH9qY7NTWgj2R_A@mail.gmail.com>
X-Gm-Features: AVVi8Cf89LEbA8IWp6kUXfdfvHtLXSvqRDQpEPExTR6LsZaq3LaagKRbHX8i3Yg
Message-ID: <CAHk-=wjeLy2n9H82_THob=wzOEfsQT_yP05ZH9qY7NTWgj2R_A@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: metze@samba.org, luto@amacapital.net, safinaskar@gmail.com, 
	akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297704-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:metze@samba.org,m:luto@amacapital.net,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[samba.org,amacapital.net,gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE39566A364

On Tue, 9 Jun 2026 at 22:14, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> How about using write access as the gate to zero copy?

Well, it's too late now - no sane user would open files for writing
just to read from them.

And if the file isn't opened for writing originally, it won't show up
in the fd. So we'd have to do some after-the-fact "is this writable
using the credentials we had at open time" thing.

Which we do for some /proc stuff etc, but it's disgusting, and it
isn't how any of this should work.

Plus honestly, in any *good* setup, the normal case really shouldn't
be that the source is writable anyway. In benchmarks, sure. But in
real life? Hell no.

If you're doing web serving of static content, your web server simply
should not have write access to what it is serving. If it does, your
web server setup is simply hot garbage and probably riddled with
security issues anyway, because you clearly spent absolutely zero time
on any kind of "minimal privileges" model.

(I'm not saying that splice would be primarily for web serving or that
serving static pages like that is an interesting load - I'm using it
purely as an example of why saying that writable files should get
better treatment is crazy: it's not how *any* of this should work at
any level at all).

So no. We should not treat writable files as some kind of preferred
model for performance. We should discourage that kind of behavior, not
encourage it.

                  Linus

