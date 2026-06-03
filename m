Return-Path: <netdev+bounces-294880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1Xj3A01zIGqO3gAAu9opvQ
	(envelope-from <netdev+bounces-294880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:32:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CDB63A949
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 20:32:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=GMezNROI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294880-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294880-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3C1330942DB
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 18:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608BA3F1AA4;
	Wed,  3 Jun 2026 18:29:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEFE19F12D
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 18:28:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511341; cv=none; b=EBiewNcOpBSbmeD/Y8fNGa8RnGMa9JXGb1qNfN41WMLhpdf4PyouuQk+KTSyAs9RBZlfL+rq5u9g/KhJpGrH0uZCA5cGreE2JO19B2fb2bdvjoWuZmwuS8lygFOEOl/pSN/gkLUOtWR0xDtnvaXOsjhBubSfMlKEs6VAtevO0Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511341; c=relaxed/simple;
	bh=GrDoA4gKT8W5olxXPEI9oGi6uCk0mHf0rlEhckvAfu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajVSyi98XsGVWkSoECX9S+W9QFt/fh0S+NL7eXpeMBGM76FXKjH1O5VIugvQ14wXDvLDjjCCwzmwdzvzL4N9dLqH1DwoiCDscK9i3F5lS3g0//SNLCO4IqA7NWPlLjw9itxiqyhXxnNGBLaz6IpsgprV5s0Kt/h4ov6hknfYLnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GMezNROI; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso5785262a91.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780511339; x=1781116139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VYe+dW7ZDjb/fodoLbEwUxVzR4phhS+HhNp00MJ/BA=;
        b=GMezNROIFX1uIiIYotmtiB1yX6MaGT7jHa6XdElYfOJeMLmy1b+cS+XYSVIIDXih0Z
         KSOsotlHLmctWpfttFox387XsSeyNb2WeU0Ju3EhY/DExSX59vOI7gi7lSef9Q39nvJ5
         bHx2iWJ1EU18iD5dL6u2+PB1clej5NzXYpg6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780511339; x=1781116139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8VYe+dW7ZDjb/fodoLbEwUxVzR4phhS+HhNp00MJ/BA=;
        b=j0TEkKC3I+27EeeL+LASRJlxR3pWnzjS2aMxl7IH+sfUPyvzaICd5dDWOtxZhcsSG1
         DlSH0ZnoduSO0bdcY3WUey2mu60RPtu7YDfNnD6YI+Ebk0G/V3LKWgvKIu2ADj7m9kjp
         9zom9KBhwYD1UrdRfGieQm+MYBezMr4lWXz1I9q54aZuK1CFiox2bYo03+7sAIDD+eET
         GqhbcLXtzoSvZFQaVDJD0C0pJPs5aYsoSs4CWob/ud3xsHTbFBLj/2Wc3BAinV2grLiS
         axdVPbYgmUrziOsXGjNEl1YimSOK+ibpQfNEV/GbVK54sUcqMYcT3ueKJSYxS42iO4cL
         6I0A==
X-Forwarded-Encrypted: i=1; AFNElJ8590hcpq9f3ekU44vJiMSFdaJdSIlKcJ4Nh8QxR/lYHEScTWv9MR79jcOQQCA74Oa41TwDVv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykcVToqKTRSu229FSRwZjPz8xxKEXQXnJajyFXvfuxIJm0QQyq
	0N5wRzKF9gnIpL551pHLci/7Ig2vwgbb5/mwgwq/RavM6/LaKLGWYGukYnKMR4TvkF45bSGaH4U
	EZgK1VZ8AkQ==
X-Gm-Gg: Acq92OHbfNknaK/zW/pO9Vm1zSAGn9e27Bx2TUr5rEA2VER+hkuKH0JATkA5TDvQeIO
	MI5WJDt9ekLFWZfsptMgrJEYJljof5GJs7l74sjC2hF+aOkhjPG9H0DCpMfScayd6cKdlUD4H6s
	MkWO5dFT812F4CCyXpD2/Pan8Oa15Q88Z/2U8SmaTKB+rfWrBLijVo/4Bzij+Zdj32bdARjK2i5
	QHgqj/UFtuLRDutHcCc41jFu9NNgGg8HDASQIsySiaivI9S8T8vuWSqZrS68iuxBPyIO+P4tg5m
	qkzxxVdCkfuJCa3FOtcjsPSC2lKaXMzp5qG4gFo+5Qj2re+lEvHhknapdFtUV1tw5kjat60p694
	IkrJ1RDnd67vvlEEE3f7slvDQ/OiWoaf7IiOSgg6XZlDIvTFuRj1G8R7ehQRWvzkELQ2YovDkr5
	VAkj1mQrY/5dHCwfe1UKMyxDyw/+1RQ9CrxXLKueBnC+UStxBs+ytXw8Gbd1j3E1a8JU9bxCuGk
	L/2G/ZEeBNCz6Y=
X-Received: by 2002:a17:90b:1d44:b0:36a:fcf5:64bd with SMTP id 98e67ed59e1d1-36e32380e54mr4514750a91.2.1780511339311;
        Wed, 03 Jun 2026 11:28:59 -0700 (PDT)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com. [209.85.215.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6c668f9bsm366789a91.7.2026.06.03.11.28.58
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 11:28:58 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c8583b8fd89so3032615a12.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 11:28:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9RSvY1LxfSYj4L7FjGg0S9heduJv8w2600ktpzenamR9dSUCoD3bK1zlVyIHjDDsRIKegZIo0=@vger.kernel.org
X-Received: by 2002:a05:6a21:50e:b0:3b4:736b:da61 with SMTP id
 adf61e73a8af0-3b49790c56cmr5052599637.35.1780511337548; Wed, 03 Jun 2026
 11:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com> <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
In-Reply-To: <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 11:28:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
X-Gm-Features: AVHnY4I2wCOVMf6tT9iCpMFfYRmksgwgXPr0UvzSy7WYplz1D2yZ52_F3Jv-p8Q
Message-ID: <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Andy Lutomirski <luto@amacapital.net>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294880-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:luto@amacapital.net,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:from_mime,linux-foundation.org:dkim,amacapital.net:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61CDB63A949

On Wed, 3 Jun 2026 at 11:10, Andy Lutomirski <luto@amacapital.net> wrote:
>
> So maybe we should make sure that, if we go down the route of
> disabling all the splice magic, that we leave an API, maybe the
> existing sendfile or maybe something else, that does an optimized copy
> from one fd to another and that is at least capable of sending from a
> file to the network with at most one CPU-side copy.

Why?

That is *LITERALLY* the attack surface - and the complexity - that we
should be removing.

sendfile() was a mistake. It is literally the "file->socket" thing
that has been buggy.

I absolutely refuse to get rid of splice code but keep the buggy sh*t
cases that caused all the problems in the first place.

Because *THAT* would just be completely insane and pointless.

> Even if we=E2=80=99re just doing that, I continue to find it strange that=
 we
> require that a pipe be involved. What=E2=80=99s so special about pipes

Again: it was never splice or the pipe that was the problem. Stop
barking up the wrong tree.

It was "file data to socket" that was the truly horrendous issue.

That said, to explain the pipe: The reason for the pipe is to act as
the kernel-side buffer.

Now, these days we have much more capable iov_iter interfaces than we
used to, and in that sense the "pipe as a buffer" is certainly not the
obvious choice now.

But even then you need to have a *handle* to the buffers for the
general case, and that's what the pipe fd ends up then still
effectively being.

It was also done to avoid the M:N translation problem, because people
wanted to do zero-copy between other things than just "file ->
socket".

But again: we're ABNSOLUTELY NOT keeping that "file -> socket" thing
and getting rid of splice.  That's literally keeping the bath-water
and throwing out the baby.

Splice is the *good* part (well, relatively - splice is bad too).

ile->socket needs to DIE IN A FIRE considering the security problems it has=
 had.

I hope Jakub is right that the problems have been all fixed, and this
is all theoretical, but having seen just *how* many there were, I'm a
bit sceptical.

Because if people think splice is complicated, you haven't looked at
the skb rules. They are completely arbitrary and complex and spread
all over the tree.

               Linus

