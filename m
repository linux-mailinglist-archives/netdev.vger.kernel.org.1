Return-Path: <netdev+bounces-272483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AvTN5ZUxmkkIwUAu9opvQ
	(envelope-from <netdev+bounces-272483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:57:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E2834212C
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCD03300B9CC
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 09:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4372A3DA5B4;
	Fri, 27 Mar 2026 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHAxITSf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B34194A60
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605123; cv=none; b=pvq2hsx6qTW4ApYbCjaVri9H41UHYH9iknB3fZyC+Pb9YWXhDISMi622cDtAdrl621O2dAAiQ5Z7LhPiysg/cesn4k5fCy9EHWh4ehHl/+XvuxTtqbRybCN2erwQHNSdoX0TyppP7hKrPRuW90Ct5l8tJnXirrT1HBkft/Hzi+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605123; c=relaxed/simple;
	bh=Dp3MNtbG2Ra9D72qFSlN6BDBrNLkOm82BcB2DQzMSic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruaSlEP5yho2eDTFFsAFNazOoRRw7sou9NNPUV4hACneDcI9oVTCh+A3RI+91sezDKOFF2k1C/b2PIUgdvOBn5yMYxFUGDwVuWyZGTInh6//m97AA/0jcINpEkUbOHzt5lcxZCpwW2r1JDdZpIVJVYNMNmcL3EO7y+By3rVdADc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHAxITSf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so17077405e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 02:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774605120; x=1775209920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSyUmVr4YfJQ06RNZPzlXo9OSQ4ExGfoU6kw5PEeudY=;
        b=EHAxITSfOxYp09Bf9cxlozZ/4Ro0+hOe19GQnmU9L8oSnBppCxcgpemDarS/mR7/K1
         GuvFA7FrjTFTogP3WOXoxPai5B4Oy0IzO+yOxOP8H/5czi6/Uisr6B1W1wzhszyohyEj
         mkTXr/b63vMCxJLOw3esatdPf/BguT2zHmo8PKp4iEKn+xWoZqsKOqgop1QtTJJhC/8C
         dXbpA2gybSXtG/kWygY6rAdcVzu9UXqwiVuHxNl/kJE8bs/dP0XxDEVAZtYZ46xdt4xx
         AOQGusltHEXtYMHiRkGZXVIxS3Uu2ChWZNozwwVGe+JnFyVbEpzf/6DeIi7lFpIvZlOw
         tHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774605120; x=1775209920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oSyUmVr4YfJQ06RNZPzlXo9OSQ4ExGfoU6kw5PEeudY=;
        b=aSTNY64wph3pc/U1qavPHNJ+R9gYEIm4TG/WaP6dNr4TEANOb8SawD4e6AHgOmpvkq
         hK94YCWPRDAIE8ezwRRorspoUwjdt7t6cKGnzraI7dLeQQqE11FYD2dS9Cy7D5Ki6FdT
         KNIySP7WIxqJPy51P3Omk8E+gR6KL7v7NiYOdUIr1ZNXydr6P3EOxJoHyGmc0s6G/hxx
         M4DCE/FNYXbWUbFQw9Lthjl0bHRYMuHORaEEqpALsXU7ucx6vXkMn94KED3NUIK7TQLF
         fn/CkdlxjMRzDu0FqAczVFU7xBvE2KUrT2nhB9V6XNyadGe6o6DCAd9N5wVeWNlfYMWf
         gD3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPKdVsj4QBIGF/kx5IqbkaL3ixMfOGAKbPSpGgMbSWxZbYpL8VZzXNimloNY/jB8Pz3LrnCgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt4Xk//6TPzYDosp9ERbCwAPX2CRzenRTJH0p7EtajH8e9z7P2
	Ea9OHuFA3kvNfahMSaok+DXC49ytl32Xpm8gWfz8VwlkfsrumX5o867f
X-Gm-Gg: ATEYQzxTn+AAb7Q/BCmZK0nyWFB3zeIHfczNG32Jr2V5sRo/feM1xlY6unAs1H7Ke1E
	7QUKhJGY9dMY3RQta6h0QoZ15Zc9eKWJ1SBXcVMeoiHgKt088cxXTRTrqm7c2nSUmixf7zeXEIj
	CziilKHUdUQcpa2YYlqF5Xu9TSr2jK/KPnscPcQEmVwOATRUm0W5l40pOrIUWiKNQMmzOmjYGlC
	75X+If0rjLceWbULynlPY7mrTqe2jKaTXr6tRkyEmAs4blmxKxZoNpqFlYNffpI1bRgaJr56Z57
	8xmW6TIkzSgSgHHZcY9QdF7O3U9hZtHgUX9jWBEsk57WUhcGlyR3RfSUy8FVeT+GHMPKss305jo
	W8qbakDRVgUqa0Y3hMdl/r46J41kw0oHrtaLMwW+mZ91nGC0KA9rn3UUd1zlITwnkdIecA9H4dW
	nwoOuXj7dWcDIb7lsnhHXcaTd17XkDtCjD7X1TZvmParoOs2HXV4Oz//DX6fnOMwUD
X-Received: by 2002:a05:600c:4e0b:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-487290a9254mr22274755e9.1.1774605120105;
        Fri, 27 Mar 2026 02:52:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c7cec3sm82055945e9.6.2026.03.27.02.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:51:59 -0700 (PDT)
Date: Fri, 27 Mar 2026 09:51:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal
 <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Petr
 Mladek <pmladek@suse.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next] netfilter: nf_conntrack_h323: Correct indentation
 when H323_TRACE defined
Message-ID: <20260327095158.74c87ddf@pumpkin>
In-Reply-To: <acZM4qwEtWqANece@ashevche-desk.local>
References: <20260326201819.3900-1-david.laight.linux@gmail.com>
	<acWWBxmPd_BNqUHF@chamomile>
	<20260326221809.0b99df3f@pumpkin>
	<acZM4qwEtWqANece@ashevche-desk.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272483-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email]
X-Rspamd-Queue-Id: 39E2834212C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026 11:24:50 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Mar 26, 2026 at 10:18:09PM +0000, David Laight wrote:
> > On Thu, 26 Mar 2026 21:24:39 +0100
> > Pablo Neira Ayuso <pablo@netfilter.org> wrote:  
> > > On Thu, Mar 26, 2026 at 08:18:19PM +0000, david.laight.linux@gmail.com wrote:  
> > > > 
> > > > The trace lines are indented using PRINT("%*.s", xx, " ").
> > > > Userspace will treat this as "%*.0s" and will output no characters
> > > > when 'xx' is zero, the kernel treats it as "%*s" and will output
> > > > a single ' ' - which is probably what is intended.
> > > > 
> > > > Change all the formats to "%*s" removing the default precision.
> > > > This gives a single space indent when level is zero.    
> > > 
> > > Do you have a setup using this helper? Or you just found this via
> > > visual inspection?  
> > 
> > Found with grep looking for places which might be affected by 'fixing'
> > the kernel printf code to be POSIX compliant.  
> 
> Do we have the respective test case in printf_kunit?
> 

There are definitely related ones and this comment:

static void
test_string(struct kunit *kunittest)
{
[...]
	/*
	 * POSIX and C99 say that a negative precision (which is only
	 * possible to pass via a * argument) should be treated as if
	 * the precision wasn't present, and that if the precision is
	 * omitted (as in %.s), the precision should be taken to be
	 * 0. However, the kernel's printf behave exactly opposite,
	 * treating a negative precision as 0 and treating an omitted
	 * precision specifier as if no precision was given.
	 *
	 * These test cases document the current behaviour; should
	 * anyone ever feel the need to follow the standards more
	 * closely, this can be revisited.
	 */
	test("    ", "%4.*s", -5, "123456");
[...]
}

I suspect whoever wrote the tests found the code was non-conformant.
But there isn't a comment in the snprintf() code itself.
I've not checked what the kernel code does (I've just written/fixed all
this for nolibc - the kernel will fail the nolibc tests).

	David


