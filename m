Return-Path: <netdev+bounces-297844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id csM7KaLcKWoeegMAu9opvQ
	(envelope-from <netdev+bounces-297844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 23:52:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 053B366D20A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 23:52:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iWdxJgxm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297844-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297844-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2085E3144E7D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 21:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A919314B8C;
	Wed, 10 Jun 2026 21:52:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B512D6E72
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 21:52:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781128340; cv=none; b=iOnH2gjTs7B913JjbaGhqJSOAQJKZE+WnhCLyXA74UPN7TzTR1gPGg2MUWGtwo/2McqvDjIIuKglWJsFzXppc4baG3CSFNY+KAmzmZELU2xlnT93+yVa9zuzJljzfAZMwYTVr+j0F2c5oqVLViGYXvSjMm2s1rxfnzmHafgx6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781128340; c=relaxed/simple;
	bh=zipjgAzMkalo/Pp3aPEMTis0IPGNah676JG0Rbdr1Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/KVBwWrE5/v3AO587SSq3RC0RIPoGcSddep/oDU7oZS6qcfAPk3cM47hKQDyCX9FQvlka1h7C6oLze7/HOoV5hCeLkg6+HTX7ERTp/F+BpvaQUiErRJdveBFSzq2E6ld3tAZYnSstqcn0LofjGhr7FQ966jFGkA8g/oZ4jcczs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWdxJgxm; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490c1915793so52278995e9.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 14:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781128337; x=1781733137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pu9xDm8soA90OJqRQivplXBBU0m7fynUgXp21Gt49gw=;
        b=iWdxJgxmJSl41iMKUWNQwH7uxtH+pJcubLpLFRPhIBlBPjFwjdsJen4+dX7KaEZDui
         I+RB7uRhhO3vd7LPDzyxqzx3IdE9TItFrGh0ARFm+qaVrtUmPAz9elVqQSJSrHYaz4s1
         oPcyavXq/w9Hv2yBLC5VFlOAF9DPcid/EQM4uxBEUuCv/IktUB8eiIvNcJEZw8MDMOZT
         I039gT+AQGvLy/9ain8uO0JgVeZ8yqfHKcGlzjW2VFwCccmJM4S8tct9tNRQg8w+5TKa
         auRbgtpHGo1nV0xP/erVAW54qFmH2X2W4Ox9Y6yHSHWBacv1ydSameF2JPFMlDolGyoK
         WJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781128337; x=1781733137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pu9xDm8soA90OJqRQivplXBBU0m7fynUgXp21Gt49gw=;
        b=d9/3MKCW9lCBYSU5DMrRwiOSqPYvR38RC5RNSgp2/nlMP0xWyAfg1ba7bZAMw0S6KC
         hGz8DWobjq9ptMTcQWTlsrGE/QSSLQfb/P2atHfw5yfkAqI/rxJL9qj9JoIBgKS8Ta3/
         qb8nDwFDzDXGXRHe1UCx/Q7J2ASRMMEdA/P8gsgs5YTZUxe/nOhVBA9R9z5PuXSf2BWZ
         c0LaVq6vCr0vKduIOUlX1eLvMfmOp3UukZ9BXQe4deH0geJGNbRpZxLTkL/BjeR3/S7X
         pjdnLfdKRFJ2yXANWEbm4LYEKrYPXUDgbdyiBp02JLkH1L6icl9GcZNocmwaiIWtTTJd
         CkWA==
X-Forwarded-Encrypted: i=1; AFNElJ/59IG2imGfB99ri2RHyHzHaEzS3rIGAz3eAK7B5KIY/wbiyTtayztOFlOh0Vibze66ue411A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJWIEaOhyGhqY/I6mXW19rWqTozk0ZSEYI7hIxxrqVBEBPaY+l
	FtcFNESM51/4JqV0Lpm4G4lxq7+IbnR6YJtQI3JLrP3bqJadLwIM07yhsC7IL+h3
X-Gm-Gg: Acq92OGKh8wc/zhyU4CG26/TuUZUetjIqqqfxABNI578rVfypvF0UHOOldb5lCJArky
	O6YxAhSEWxA5hAmNZJf0QrZgEVI1wNZfhjDqSLmcWrYkXMY5+1nyktkDpRIZe5P+uEY6uHMOOx+
	dyHtdVfQXIxSUYrovndrlXUOKHoSbCiPsL3he7xaXLA+7diOPByoN8ACtG0YmYY18GvD9FyGgT9
	kc/DnpI9KgESy4j9oj/xZrYldQ58FR4AkajDUhgvjSlIKAjES49+SObyZbdnt/md4Ru+pva2JGU
	m5k+yhh2H+/wzf9nzfudv82XYMeiYUU9bSKUioN759nOVUIu8NnT19JxdpDSHaIw1ZA6fOqR4SY
	OaQ+xcuCWBuxJRPSZ5CYXzjH86dV4ZBFNA2+Qb1Ykw3vxkh9f7iAQHbB0ftYCRSmWcNPuvF4aW6
	AoIR/WY5/eILVE6zdboVYoAu++MQdhzp/m++3wgmrbjAB1HzzENAR/GWOeqMK8WnPm5Xd0wm9nc
	uZv2uovaw==
X-Received: by 2002:a5d:64c5:0:b0:460:2d45:fe8c with SMTP id ffacd0b85a97d-460677b902fmr46333f8f.38.1781128337225;
        Wed, 10 Jun 2026 14:52:17 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344558sm71699352f8f.18.2026.06.10.14.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 14:52:16 -0700 (PDT)
Date: Wed, 10 Jun 2026 22:52:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Arnd Bergmann
 <arnd@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
 <jiri@resnulli.us>
Subject: Re: [PATCH net-next] net/devlink: Use strscpy() to copy strings
 into arrays
Message-ID: <20260610225215.6783c5bf@pumpkin>
In-Reply-To: <202606101355.6353D5C1@keescook>
References: <20260608095523.2606-13-david.laight.linux@gmail.com>
	<c6eb816c-3f2d-4705-82ea-8c2c0ad70ded@redhat.com>
	<202606101355.6353D5C1@keescook>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297844-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:pabeni@redhat.com,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:arnd@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:jiri@resnulli.us,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pumpkin:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 053B366D20A

On Wed, 10 Jun 2026 13:58:51 -0700
Kees Cook <kees@kernel.org> wrote:

> On Tue, Jun 09, 2026 at 03:39:35PM +0200, Paolo Abeni wrote:
> > On 6/8/26 11:54 AM, david.laight.linux@gmail.com wrote:  
> > > From: David Laight <david.laight.linux@gmail.com>
> > > 
> > > Replacing strcpy() with strscpy() ensures that overflow of the target
> > > buffer cannot happen.
> > > 
> > > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > > ---
> > > This is one of a group of patches that remove potentially unbounded
> > > strcpy() calls.
> > > 
> > > They are mostly replaced by strscpy() or, when strlen() has just been
> > > called, with memcpy() (usually including the '\0').
> > > 
> > > Calls with copy string literals into arrays are left unchanged.
> > > They are safe and easily detected as such.
> > > 
> > > The changes were made by getting the compiler to detect the calls and
> > > then fixing the code by hand.
> > > 
> > > Note that all the changes are only compile tested.
> > > 
> > > Some Makefiles were changed to allow files to contain strcpy().
> > > As well as 'difficult to fix' files, this included 'show' functions
> > > as they really need to use sysfs_emit() or seq_printf().
> > > 
> > > All the patches are being sent individually to avoid very long cc lists.
> > > Apologies for the terse commit messages and likely unexpected tags.
> > > (There are about 100 patches in total.)
> > > 
> > >  net/devlink/port.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/net/devlink/port.c b/net/devlink/port.c
> > > index 485029d43428..108926d3f899 100644
> > > --- a/net/devlink/port.c
> > > +++ b/net/devlink/port.c
> > > @@ -1222,7 +1222,7 @@ static void __devlink_port_type_set(struct devlink_port *devlink_port,
> > >  			devlink_port->type_eth.ifindex = netdev->ifindex;
> > >  			BUILD_BUG_ON(sizeof(devlink_port->type_eth.ifname) !=
> > >  				     sizeof(netdev->name));
> > > -			strcpy(devlink_port->type_eth.ifname, netdev->name);
> > > +			strscpy(devlink_port->type_eth.ifname, netdev->name);  
> > 
> > Given the above BUILD_BUG, I don't see how this change can help?!?
> > 
> > Generally speaking, I suggest restricting this kind of tool-assisted
> > changes to real problems (if any).  
> 
> How did this patch get generated? This isn't an "unbounded" case: both
> devlink_port->type_eth.ifname and netdev->name have known sizes. I think
> a way to focus these kinds of refactors would be to replace strcpy()
> with a macro wrapper that fails a build when the sizes aren't known, but
> then otherwise calls strscpy instead. With that in place, you can find
> all the actually unbounded cases and work through each of them, and once
> they have all been purged from the kernel, that strcpy macro can land,
> which will keep new unbounded instances from showing up.
> 

My current wrapper (which will allow the above is):
#if !defined(ALLOW_STRCPY)
#define strcpy(dst, src) ({ \ 
        size_t _dst_size, _src_size; \
        char *const _dst = dst; \
        const char *_src = src; \
        bool _use_memcpy = true; \
\
        _dst_size = __is_array(dst) ? sizeof(dst) : __builtin_object_size(dst, 1); \
        BUILD_BUG_ON_MSG(!_dst_size, "strcpy() dst size zero"); \
        BUILD_BUG_ON_MSG(_dst_size == SIZE_MAX, "strcpy() dst size unknown"); \
\
        if (__builtin_constant_p(_src && _src[0])) \
                _src_size = __builtin_strlen(_src) + 1; \
        else { \
                BUILD_BUG_ON_MSG(!__is_array(src), "strcpy() src unbounded"); \
                _src_size = sizeof(src); \
                BUILD_BUG_ON_MSG(!_src_size, "strcpy() src is zero length array"); \
                _use_memcpy = _src_size <= 32; \
        } \
        BUILD_BUG_ON_MSG(!statically_true(_src_size <= _dst_size), "strcpy() src too big"); \
        if (_use_memcpy) \
                __underlying_memcpy(_dst, _src, _src_size); \
        else \
                __underlying_strcpy(_dst, _src); \
        _dst; \
})

__FORTIFY_INLINE __diagnose_as(__builtin_strcpy, 1, 2)
char *(strcpy)(char * const POS p, const char * const POS q)
{
        BUILD_BUG_ON_MSG(1, "Direct call to strcpy");
        return p;
}
#else
...
#endif

The one I was using before required the source be a constant string.

Note that this is just intended to find the unbounded copies at compile time,
rather than being a suggested patch.
The ALLOW_STRCPY is needed for things like the acpi code which are out of tree
(and other files I didn't want to fix).

The acpi code is stunningly bad, it saves the string lengths for the kmalloc()
calls and then uses strcpy() to copy the data.
If anyone manages to gen them out of sync it will overwrite memory.

	David


