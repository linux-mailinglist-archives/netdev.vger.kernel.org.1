Return-Path: <netdev+bounces-295424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zrvhEuzuIWrAQgEAu9opvQ
	(envelope-from <netdev+bounces-295424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 23:32:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 566896439F1
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 23:32:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FRNqCzl3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295424-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295424-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81542301071B
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC563FE37F;
	Thu,  4 Jun 2026 21:32:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F5A3C3791
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 21:32:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780608741; cv=none; b=JmzNK4ysYIhL3Ij+SOZlfobs1anJzAD80kV2MMfb9EXxyDIEuyf0hBsstrSV9kIGg2t6cjyNfL3tQ9mI9fQQKFwybAAWT2zJmkJVWxgXVUOVSx2ZFTWruhNxJ8LWY85yGT0iQTyaWBCMz+elL6DUPCCroyCbmuxbFg8SiulhWpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780608741; c=relaxed/simple;
	bh=SgWKOY85N4QXHw6DJquJOy0hqfu11eB/INo5oQyQqiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5ghDWRKhN03SeT/5x4MHH725jHvUHe4XkUad1255xyDPKg4mKcsh/UeqEheiQsMBhRGNpTvUmJAKEAw/YB49OjPiiduuuKz3XK0i2AHTlMjGRglc5pi5z+iXnP8DI1aXk0ZH1e8yyixOf891r118cgfIyjJEnrRyR8MBGwsQVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRNqCzl3; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so12604105e9.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 14:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780608739; x=1781213539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQN7agybo6gzy0fVoImTNH+8qqV3opcO9FSCB/3Heuk=;
        b=FRNqCzl3sbzOovDDK978itlbuhw2Msse9nhImaUZTPk6UF67PziAOWjVIcPIk+8ALo
         8YY5/h8G1rsC0C041mmtds/9kfbCfhpe5OroEUoax84EXhJ/rQEaWVwG8zWS73M0FXG+
         5780ygw4cLNX4n9G2SDqg4BbQAmPB3ehcbTy6IRURs/lv6iNBm61LMY3QxQq/FEiB74L
         1H/iSXfZQ2XiRKAHo/hLDw/6khkBJIu8xChkKgkALJPhdzgMcNsyz7pF2NTwdiQ6JwE9
         Ci2332wI0A0RwxWDFOaMf603qqFIIHQkl8aLC3n3BeKqCghDikbtGmFTracqB+y/P7Cf
         5t9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780608739; x=1781213539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQN7agybo6gzy0fVoImTNH+8qqV3opcO9FSCB/3Heuk=;
        b=Ur/I/eQlQUN3721WAsCDJTSXtr0mysSqkX5yl9yS+pkyAYH1gbyv0d111voZPqSnX2
         meHAVHgK2SgId0zA3cFEkWido+bPU7eACIchoihE6So6BZ1HF8jb7QuB8bR4YVlcXdiu
         xW0nuejSK9rJ4pQXskDcl+qhr8ymRilSOlTq4MBHyA0LD5XX6fJoNBLCoeq7MwQE96J3
         nDN4PKeCc8kEDNXd0Lo3ZanDBQI3q0xmCO/qiI1mGsJVJECR59BKF6MiWPhe8/Z39+5Z
         Btnx0A4VQzQl+bJkkdujzxEyV43Kp0+J43A2Ysg9u6VqxrFVGJ/R+yINym/tXNPYwKaL
         BFiw==
X-Forwarded-Encrypted: i=1; AFNElJ+sNIGbyusfxqQ03s8SPlbPxupDSSszHsHxRdpU+R9NnpWcPh1yVi2T18hbFVh4vr2e4wW5pI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLbDzFrMojDtyEhxd3an2KMNaMNzkVDX6WslAzzlVzNDrOO5Fi
	+4bhHx9gUrJlwzOnyXOzBoOqs2eI8xm+hN1oeYsLsLgcsZqt+uhMGODH
X-Gm-Gg: Acq92OEJgyUgdGOY/UEQLl3+hhg7u2+iE1NaYmCHjTNj6G6M0d3ivjLKQm29+owSOca
	tTI32ni/JcVL7qmu0ZD8FSvR8aTd5boKelfn2//pyWM+LlI3eZUPLYEpTUJVb4cxsUksCDK5xGT
	FCuznIL58g4oVbf/GFLF5W7IGWFrQvG6vF/rvW2JZCC/9tm8F+cOOYRRoi9aX3UflvRwa/yNibU
	eDyHe9hMtbGwykrhYO82b2G5/ch4BV7W9/HT4hI1eYXmTaZf7SDdREC+IRERYl7qmpnZ0jo8ybH
	sH3279R2xKIwjHSR71lsNLsid5FQ5UMcb6QnqMi/vR0KM3IQ9DqpQavcv4Gr+dRr8gN9SlMgQk9
	Qvj3cEueKkzeVmYQKFzraadwG99cuNjhKicjYhj2rDKGBpk66jF7Tvj10MT7UMN24rZ4QE1CxVm
	ut5NMnjD+AePQWVhChdiKv6ePVFvCVJ7b882uee9dPWZg0pW8tmhtS34KLAkqfoU+6Pu+clXg=
X-Received: by 2002:a05:600c:348f:b0:490:4b89:5372 with SMTP id 5b1f17b1804b1-490c25e2739mr4133095e9.11.1780608738825;
        Thu, 04 Jun 2026 14:32:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3918fcsm111713545e9.3.2026.06.04.14.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 14:32:18 -0700 (PDT)
Date: Thu, 4 Jun 2026 22:32:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Askar Safin <safinaskar@gmail.com>, metze@samba.org,
 akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
 david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu,
 netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de,
 viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260604223216.73468830@pumpkin>
In-Reply-To: <CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
	<20260603211736.755139-1-safinaskar@gmail.com>
	<20260604100609.6b37f500@pumpkin>
	<CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
	<20260604183829.63c35fd9@pumpkin>
	<CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295424-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:safinaskar@gmail.com,m:metze@samba.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,samba.org,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 566896439F1

On Thu, 4 Jun 2026 12:30:30 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, 4 Jun 2026 at 10:38, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > Bool is another matter entirely, (IIRC from a couple of weeks ago)
> > gcc will assume that the low 8 bits of the parameter register are
> > either 0 or 1 and clang assumes that the low 32 bits are 0 or 1.
> > You can't even check with 'if ((u32)bool_param > 1) error()' because
> > the compiler 'knows' it can't be false.  
> 
> Nobody should ever use 'bool' as a system call argument. Anything that
> takes a boolean should take a 'flags' field with bits.

I was thinking of more generally, not syscall arguments.
In C you can't really guarantee that a 'bool' variable will always
contain 0 or 1.

Even if you write: https://godbolt.org/z/81P87vv7o
int f(char *p, _Bool b)
{
    return p[b ? 1 : 0];
}
you get *(p + b), neither (int)b, !!b or (b & 1) make any difference.

Talking of broken compilers, had you noticed that:
struct foo {
    int a;
    char c[32];
};

int b(struct foo *f)
{
    return __builtin_object_size(f->c, 1);
}
returns -1 (size unknown/indefinite).
You can't use __builtin_object_size() to stop code running off the end
of anything referenced by address - even when the size is constant.


> But this is basically what a lot of the SYSCALL_DEFINEx() macros are
> all about - sorting out ABI assumptions.
> 
> For example, on powerpc (iirc - maybe it was 390), a 32-bit argument
> is always sign-extended by the ABI, and the compiler *depends* on
> that.

I think riscv might sign extend 32bit values in 64bit registers.
x86 and arm both zero extend.
Zero extending is more friendly to the kernel where pretty much
all values are non-negative.
I think I've used signed variables slightly more often than fp in the
last 47+ years.

-- David

> But at system call boundaries we can't trust that the user side
> actually follows the ABI, so SYSCALL_DEFINEx() will actually take a
> 'unsigned long' and turn it into a 32-bit argument so that things like
> this are well-defined and you can't fool the kernel by not following
> the ABI rules.
> 
> The same would be the case if some system call actually takes bool
> (but I don't think such garbage exists). The SYSCALL_DEFINE() macro
> magic would take the full register content and *force* it to follow
> the ABI conventions, whatever they are on that platform.
> 
>               Linus


