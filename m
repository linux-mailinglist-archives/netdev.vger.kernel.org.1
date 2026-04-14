Return-Path: <netdev+bounces-278433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDjtB2Mu3mnxogkAu9opvQ
	(envelope-from <netdev+bounces-278433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:09:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A84B93F9CDE
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C09E0300D4EB
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C003E51F8;
	Tue, 14 Apr 2026 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="Lq7s86bb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D9A3921E4
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168544; cv=none; b=rLLLS5sNyj92PEpIih4eSUyCrCKfe7SPDtcMeIw7SC+1gdclg2zoyb0To0zzfkttCDtzu+izza0V4UpIZ18PS8nMKD6nJ6XgkBVqgvhBr3jmsllMVhS2rTVtp1u1XfFQvxbYfU/jZZD4CoHpLyatUOGkm396HRl2croEXqm1urk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168544; c=relaxed/simple;
	bh=2dKC+bNzART0TN1K0cGjO0fj56UlUraZs5ruQszSvF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZXgyz5tpd4SnPwcwDHg/udY3YBc68VvGgj0Fg68TFZiYDRGuETvb0mXwfjuKUwJpnt+bZkHnmfET99i9GE3tGLqkwJz0fqUIRo2ipZXi2NKJ4IJoxFJHn8yffg0jodLrP5mvqkaM94E9m9KiPstXNWK81aOkbqrq740lQtZrLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=Lq7s86bb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso53455895e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 05:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1776168541; x=1776773341; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2dKC+bNzART0TN1K0cGjO0fj56UlUraZs5ruQszSvF0=;
        b=Lq7s86bbWgl7HZFmbhLkjJUhPeb56Ly+ZSHa9rnH0vktGsXnPUBFcbWV9unFTi+N41
         I6m7HV1kRjYe4+Z5ZK8BMi6hRodRU/Y0FSg6t7WDOw2mhi/Vh1m0m7wh6uaJVFYSa3a2
         SLR/YOOhzs15rcwrW6E4+fSQq6Uqy1AoA5arLwkOObiBpG2/DHB/D7LegUbWGeEONNSx
         1tkBtQ/8qf9Cc38q+vd7w0+l6fTna1g8WF3aC3B/t5SkxNmPVyf28nrlND4x9pAPhjQM
         eUznqhcfHBMfr2bws+bXMB8uhZy3X1eIJexwb8las6g7xHrMysCCB0cy23kxd/QxsQmh
         O3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776168541; x=1776773341;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dKC+bNzART0TN1K0cGjO0fj56UlUraZs5ruQszSvF0=;
        b=LwO4lnTAh5RuVHsCa1J9a1gx1oJ2z1FdVypy1wYeVVtQkEHgvfnNC14LbTv85Sg56V
         xv6QSFkxnYhlxIK0TbBunQFf1yksJXxInG4AlyLeVxjMPqH6oQY6QM3/C3fwEUVHHbhK
         FQrMcLg2yXJIiIcDD00qRzZrcPaG+rsZEEuO58ET/gf9PKlOdMdi8P78ZA7bH+QvU430
         Z1lQPKfOdKt9rsM+lo79A53f9bNuKT4qY9b5a7CZL5jAdQgn4d67vgmhFri+hNuHh7th
         lToU0tyMhMqLMH+dgOQLm/H8uwpxetZfXBEI6sYFruj0Ai+KRAI+3/jnoNttcgQSoUDN
         OuNA==
X-Forwarded-Encrypted: i=1; AFNElJ/ABXGy0hQhOosuhvYgbF/5iUhHiBfOeFvG14zD8r9IR2wpMEjus9w/esIIMB/s8l7wdEBnenw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlCy8UcfNc+qgsLmtoezkc9NmNm0nnMhA5Da6o8feubXbEEIJK
	oRua5byb7sekAsh9J1q38/o9RScopTCViQ42CrXR3+uty/85m1yQX1//GJGy+L9vZMc=
X-Gm-Gg: AeBDievv3yE1ts1Ijy+syUVL9INIroaO3+J0TdeICihmMp7kn6qVxvJ4MqNAmb2a3a2
	5s9meVRAb2LsyQGf8+xEfUlZhGpe2Voo07VSyOkJa4nNhXk9lRH9rzil8/y0sDPHuQ3z7Itj2OO
	B+v3UZDzTFMlQsGG3oMlFzAAB4r2LOFhyy6TLyHUOFRcDZ+4HZTQbSNFktEOMg8jmW7sSIRPkq3
	EdfvoEOsdRwVeeh+2VimGL75d3pss/DlHfyvTyhFDba5a04fs/KbegJp91dT4EipxFNiOy6jlCu
	3nyh+4m3sBZjPFzFD9ea4pRf0+spzVv58vbRvTOml63poao98bAbbUaFrU4f0+1Db8QW9WVH0ep
	o41fOJhdV/exFPyO2GmJu08BNuLvrfV4Iry1+IeBasc8MLaA8r0RLz4frjKnX5NdosK7kZiA2yS
	IqF7fA5JyjLax+buzBsDFqtVErg97MjgjekTxKNsw1IBT4S8EZDgdKjFy5M1sg18bFQ7YQ0b1Yl
	Y33JQ==
X-Received: by 2002:a05:600c:a11c:b0:487:2671:fb8f with SMTP id 5b1f17b1804b1-488d67fa40fmr168478205e9.8.1776168541312;
        Tue, 14 Apr 2026 05:09:01 -0700 (PDT)
Received: from localhost (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1df12sm106112055e9.4.2026.04.14.05.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:09:00 -0700 (PDT)
Date: Tue, 14 Apr 2026 14:08:58 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, 
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] tools: ynl-gen-c: optionally emit structs and helpers
Message-ID: <ad4ox7ibZoiW-tje@localhost.localdomain>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Philipp Reisner <philipp.reisner@linbit.com>, 
	linux-block@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
References: <20260407173356.873887-1-christoph.boehmwalder@linbit.com>
 <20260407173356.873887-3-christoph.boehmwalder@linbit.com>
 <20260412125502.3f8ff576@kernel.org>
 <adzVUdf74CVk2DwJ@localhost.localdomain>
 <20260413104939.5ef4d9dc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413104939.5ef4d9dc@kernel.org>
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linbit-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linbit.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278433-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,lists.linbit.com,vger.kernel.org,linbit.com,gmail.com,google.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linbit-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christoph.boehmwalder@linbit.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,localhost.localdomain:mid]
X-Rspamd-Queue-Id: A84B93F9CDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 10:49:39AM -0700, Jakub Kicinski wrote:
>On Mon, 13 Apr 2026 13:48:32 +0200 Christoph Böhmwalder wrote:
>> >Can we just commit the code they output and leave the YNL itself be?
>> >Every single legacy family has some weird quirks the point of YNL
>> >is to get rid of them, not support them all..
>>
>> Fair enough, we could also do that. Though the question then becomes
>> whether we want to keep the YAML spec for the "drbd" family (patch 3 of
>> this series) in Documentation/.
>>
>> I would argue it makes sense to keep it around somewhere so that the old
>> family is somehow documented, but obviously that yaml file won't work
>> with the unmodified generator.
>
>To be clear (correct me if I misunderstood) it looked like we would be
>missing out on "automating" things, so extra work would still need to
>be done in the C code / manually written headers. But pure YNL (eg
>Python or Rust) client _would_ work? They could generate correct
>requests and parse responses, right?

I haven't tested this, but yes, a regular YNL client should work with
this spec. The new flags only influence kernel codegen, so a client
that doesn't know about them could still construct valid messages and
parse responses.

However, if we drop patch 2 completely, the new flags won't be in the
genetlink-legacy schema either, so schema validation would fail when
trying to generate.

>If yes, keeping it makes sense. FWIW all the specs we have for "old"
>networking families (routing etc) also don't replace any kernel code.
>They are purely to enable user space libraries in various languages.
>Whether having broad languages support for drbd or you just have one
>well known user space stack - I dunno.

Well, one of the main motivations for porting the current "drbd" family
to YNL is to get rid of the genl_magic infrastructure. We intend to add
a new modernized "drbd2" family, which will be fully YNL-based from the
start.
But we still need to support the current family via a compat path, and
I would much rather have two YNL-based families than one genl_magic and
one YNL-based. Carrying both sounds like a nightmare.

So the spec proposed in this series would never actually be used to
generate a userspace client, if that's what you're asking. We would
continue to use the current libgenl-based approach, with some userspace
compat shims to make it work with YNL. Then, when "drbd2" comes along,
we could "do things properly".

Might also be worth to mention that we are also experimenting with
Rust-based userspace utilities at the moment, so once we have "drbd2",
there will be a real benefit to having multi-language support.

So I'm fine with whichever route you want to take here, as long as
it enables us to move away from genl_magic.

If we decide to carry the "drbd" spec in-tree, that would then pretty
much only be for documentation purposes. Otherwise there would be
generated code where the spec it was generated from is non-existant,
which may be surprising.

>
>> Maybe keep it, but with a comment at the top that notes that
>> - this family is deprecated and "frozen",
>> - the spec is only for documentation purposes, and
>> - the spec doesn't work with the upstream parser?
>
>The past point needs a clarification, I guess..

