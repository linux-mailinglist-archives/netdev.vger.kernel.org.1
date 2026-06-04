Return-Path: <netdev+bounces-295407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 85q1BrzUIWpvPQEAu9opvQ
	(envelope-from <netdev+bounces-295407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:40:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8450E642F94
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:40:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=EZhk1R45;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295407-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295407-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A824230056D7
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 19:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E43374726;
	Thu,  4 Jun 2026 19:38:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8932572617
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 19:38:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601933; cv=none; b=P6Qj4PiyesO8Jw0WmwQUBRjF0rKpT3Z4MxT4sOfU7pSa9jPGGuFjKGzlANRlxTFdVV2gTyl5d3Ic/6fQ3Rb3zsh8iOZcNeWNgZs6TqmUBx0NU5bONLU33YkSo/TYblWq8jyMsrCGVr5UI1Xon6DFOEQlrjzlOOlFhpxQ2q95bK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601933; c=relaxed/simple;
	bh=d97FFwmE32XoeNnLtg7CNSRYTgucvS3+TBVC4MKcTx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsKpt3aE00rg5/hS2UtBhGiUttXO1NJiTAOQIT3bPcZEo3eyo4dkXPA2avQqDPf/BYTom2rl2kL+YX/Y1f5F8CpraSjcLP/Tp4ze5rEGFmKuADyIOv6Us6j6jzuzZsxJf8nv4TKYDjGX12Hd6ZM4z8nBlW4p7t6DPZesZn7DToU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EZhk1R45; arc=none smtp.client-ip=209.85.167.43
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa68dbb38aso1063454e87.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 12:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780601930; x=1781206730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/vRjXw0GxoiIE6driNbyJfpHo79+KlSJNRDFpalZAbE=;
        b=EZhk1R45Xm8OSXFfS7h3OdumneYJfPb+G93j09x2eVcBQZmfq0+FX1gqlx/KqVV34s
         mRxWeBM+TxTRKZ3GiGxsxtazmGtIwPEnHc1YokZ+oAqLYIj6g3LF7pbXgrtB2W+D3GiN
         saukT8RU6TVblHPtreYQXglMiJjYre/bEqv7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780601930; x=1781206730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vRjXw0GxoiIE6driNbyJfpHo79+KlSJNRDFpalZAbE=;
        b=n4l67tcZBd2JX7LU4IORt/GUCWqpjbQhRaGOxdNAAssMsedkSegBUdCc2xt5dRwWdi
         XvVHZLPitO0vb9ftoj2vfWAO0ci44LvOlCUXm9K1rcy5NKia2jjbCF5cNX5npwTdoR4/
         djlnxeHjt3cvtTE/AZbFFJlEmLvkrJ2HCtYTOgMA1TSOVjWYVAFl74m0a5i7S0mol8kE
         N7vsYIKDpWk7fdPg70Hp0OUbAaDk6X0mH+4rYmhZ/VQTvjlVXATqzOKCcF4jG1jf6RMy
         hLQ7uQE++P0jWsia+oTEZmKW2xJITmTJ9JWrZVhol/Vi12ixD4LJJSynHfnfFzLqgLES
         S0Rg==
X-Forwarded-Encrypted: i=1; AFNElJ9wTVIo32gSsS56hOIYO8BipYJQRwUb23GSNkmwDip2tNaF45uYUP4HSxqt54VwXTbljMlDatE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ramLpN1H2fxJIMjZRyxqNNlmPqBoeyzzFOi7UNrd+VsZv8EA
	+tQryJypYptwjyGphelhMESkHTmxle5pZmlT3MyIP6hupXUwfe45DbStn3SWHtizLeNXurrH2eJ
	4UFmEHXaTrA==
X-Gm-Gg: Acq92OH3vHk5/j+QXeVsRD5UH3BhIy9PalwuHO7zahPSjNt1M8QtlG3dpA/mKYfYlkI
	GXGSaooRRPqfrns322ibkx0+FCoYck1DOx8PouQMkmI+iYSY4YfDq4RFiQNRY0m3Y3QjD33ejf1
	eoq3nyhlvxsxOPY7BHjo4Y6lr+KXNP5J0NO85b2bjtJ9dShFL7vcQek5+joTTWEzPCWTRavqjAC
	pumXn+ETtHDU7dQj7JRnDEmP7ptj3uVebH5vlW+E68GE1xarB39DchOvH/zzs02JDNhMg35Y1ye
	h9yoa+PhWL1z5o4ugbv1Z6UsUUTHKfiUtttsD1a2UKuz/mtUEx5evR3z7HDS638bO9piMxD3PYP
	iKo9EXBPabz9T20LiLf+5cQo+UxHnDigqZ1jNG1CYB03bf7sJ5AFLQDP9bGGsJZkQEmSUxwNTr9
	37sw0RhrU/PBMtvdsGR6naJWDuXgkaHNd+4O5crx9eyR2FzimlGcNPjdsIKpH4dsS+OLX7k6IAo
	fuFB8M1lYspAzc=
X-Received: by 2002:a05:6512:3514:b0:5a8:6793:e701 with SMTP id 2adb3069b0e04-5aa87bc90eamr59268e87.33.1780601929644;
        Thu, 04 Jun 2026 12:38:49 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac0823f9sm18734671fa.13.2026.06.04.12.38.49
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 12:38:49 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-396775c26f9so10948681fa.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 12:38:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/lR5K6jdFYYR/6Mxp92UTME0ud0y3kyAQk4f1kR3DAoV/gh4DDukruB1CVqXr7KHupl1qRvFg=@vger.kernel.org
X-Received: by 2002:a17:907:3e20:b0:bf3:fe:1d5d with SMTP id
 a640c23a62f3a-bf373306d04mr3098066b.43.1780601447577; Thu, 04 Jun 2026
 12:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
 <20260603211736.755139-1-safinaskar@gmail.com> <20260604100609.6b37f500@pumpkin>
 <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com> <20260604183829.63c35fd9@pumpkin>
In-Reply-To: <20260604183829.63c35fd9@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jun 2026 12:30:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
X-Gm-Features: AVVi8CdPQe90u6Sxnc7w9w1KvqakJpNEvGXvNsTMWUZWIferNC2FIUNZ3K7Amh0
Message-ID: <CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: David Laight <david.laight.linux@gmail.com>
Cc: Askar Safin <safinaskar@gmail.com>, metze@samba.org, akpm@linux-foundation.org, 
	axboe@kernel.dk, brauner@kernel.org, david@kernel.org, dhowells@redhat.com, 
	hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:safinaskar@gmail.com,m:metze@samba.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295407-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,samba.org,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:from_mime,linux-foundation.org:dkim,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8450E642F94

On Thu, 4 Jun 2026 at 10:38, David Laight <david.laight.linux@gmail.com> wrote:
>
> Bool is another matter entirely, (IIRC from a couple of weeks ago)
> gcc will assume that the low 8 bits of the parameter register are
> either 0 or 1 and clang assumes that the low 32 bits are 0 or 1.
> You can't even check with 'if ((u32)bool_param > 1) error()' because
> the compiler 'knows' it can't be false.

Nobody should ever use 'bool' as a system call argument. Anything that
takes a boolean should take a 'flags' field with bits.

But this is basically what a lot of the SYSCALL_DEFINEx() macros are
all about - sorting out ABI assumptions.

For example, on powerpc (iirc - maybe it was 390), a 32-bit argument
is always sign-extended by the ABI, and the compiler *depends* on
that. But at system call boundaries we can't trust that the user side
actually follows the ABI, so SYSCALL_DEFINEx() will actually take a
'unsigned long' and turn it into a 32-bit argument so that things like
this are well-defined and you can't fool the kernel by not following
the ABI rules.

The same would be the case if some system call actually takes bool
(but I don't think such garbage exists). The SYSCALL_DEFINE() macro
magic would take the full register content and *force* it to follow
the ABI conventions, whatever they are on that platform.

              Linus

