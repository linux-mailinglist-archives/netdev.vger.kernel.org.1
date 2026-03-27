Return-Path: <netdev+bounces-272552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG+XDPd/xmm1LAUAu9opvQ
	(envelope-from <netdev+bounces-272552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:02:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC50344AC2
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE89D302DB72
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361333BA226;
	Fri, 27 Mar 2026 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YN8sghLm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94C03B6340
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774616132; cv=none; b=HJ9VSRUyha7ixudc47ZjGtctdGJMaJFVlyIlG2Gp7xo5ymA7zTJ5lWhQv/wEgChmCTNi92BUJFK+iWbM4OKv1CASKM9OQHorwiLnrY0Jb2RYCSbxCvJKykMJmyK0rJ5DYfeWLIJuOmhFfikEWv8JeLhHMrKjIFFTY7QK7KFn0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774616132; c=relaxed/simple;
	bh=LWqbvh3FeikukKL/Ot4NgwDYa+s99h0ef6596oxgW00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7vE/43aTSVvXk8PoXNLOEoVHFS9tRfVlJ0+/bYaD0MBIqiWxyU+ftv3FE2NQz/dBXUhAOI+NiOLXzKU3Q/cQkXk+quseNlHsl5n2RIwrNTua5ynLk9WUosRywuafwN5KlMUVBuLtPYCoF5bSZtiUh9soJ+jZkz3rzpGwZqBOw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YN8sghLm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so16826865e9.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 05:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774616129; x=1775220929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MP30gO10RQY6yXiMpOxuMeuGTT1rodnXb+jcK+Xa1Wg=;
        b=YN8sghLmTaOw2FvVeIPViL24BP2LmqV69Iu1JTPmXnGAX2BRw+MMm3U6aRuqsUVZDy
         n2i2p+t+Q7pg6PcpV3XEYAsOkMsYzN4D4df/2IwdkaTowinFc9Xq2Dv6kX8bvtNdSDed
         Yq21nD16yE/VGIjU6xFN0FUsMmxmLeN5T5uOk2u+MO5DiOVZ3+U2xWyzV5oAw2jqCkTg
         Es4cId3ZX8EW6KunGxr5UaNph9u8WIayf6SgG0yB1RC/Ss7+/Sa8yx9hUdXJFYh/bW37
         FpUyEHedOXP0u3PYRfLsydyeU4igik2La6KlI+QJQ/y+fsaaz87NmEma3EBjw3emtXKT
         rMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774616129; x=1775220929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MP30gO10RQY6yXiMpOxuMeuGTT1rodnXb+jcK+Xa1Wg=;
        b=eqEaplmA3EbJByRC9nkWgqeMLfxf3TaoUGL6Mwnwy1eDgNPRdQpcafsWlVvUJElraw
         19Q3MjnP5oP4c9cxJvx+ZKNxn9f67YsKT6HS15gWeNH4SNHHewQeOOoNHXe5bpYysM5Z
         bEiVcYm2L3+GQXduaRhFQwO0CbTvBb8+9yyW2B3H0b/8PfQJ1rr8ADL4W84fqyhS38gr
         BdjitUSwBDClypdcb9MeoSd6oK2wPVYcWDBT+vuin1CmVntRfatvGQ7U4dJvnX8AlsC1
         3kv9jW6pRNJrWld8764UCuRb0cZtCFR+ebsuRGWEZCwl+N5655CFiGo6nGRgch+B0Bv7
         q61w==
X-Forwarded-Encrypted: i=1; AJvYcCWnS9vHNXav4jlZ7gCrq+sk57XOYP0sL+KmG3sHJvj96hcn6pWWlrrT0ZjmbZkAOt9D5H9RDnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgtB/h8d9tdFtz4PUjFSsG2536i1mTQV1pr5Zb6qjrQzKJSf/p
	a0rlaYlaK3rb0esPquMgCRJ4xDy6EkbIshDd4B0BAp1bgXQJSIu99pn9
X-Gm-Gg: ATEYQzxy5a6ulCRHse4bV2XH9glORVPhYg8zOxrUbfTAanPM0mP6+lLbbp1XvUfGUye
	zDTh+sDr/o1xOb9BVsY2pGLugOxV7haY4Fh//RGgWBVlUzmMyLd+H7sCtvuyuYu0uv7cjGwFPoV
	a3RwzrnjDyw8NZ+z3dieL9vIfOMOn+d6Wb6YgQv4SjHK2/P2ddR1aFFNWKsR9E9f1d2QsGoRgbU
	ujf2snj3z9xypOUKiaRcEdfRZNvjjVDOy9QY5dpNUq/Mgeo5LUIHddNDPAVkiYRBT0qQCTZ33H/
	KbCO/C5wAqO0dtmvdGYHWUqeyJRKWjhl2UWaRFjN2rrqasYLWdWGafj6EnU5Svy7vWT1sRvaVdw
	6XE5FzvYNGjUyfQNjpzqgFGYNtCBJhd6zjWIzoo9eTXvaIcEpTpmAU7axHbpvcIAA4Jo6VDXcqu
	x1P7cg+uVV6M7IGKyqMSHTz9B5zEEPkagitCPqkim63+ntK5LkmjPJ1RGeDbc6RIjz
X-Received: by 2002:a05:600c:c168:b0:485:35a4:939f with SMTP id 5b1f17b1804b1-48727eddeacmr41627195e9.28.1774616128950;
        Fri, 27 Mar 2026 05:55:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722be608bsm118640275e9.0.2026.03.27.05.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 05:55:28 -0700 (PDT)
Date: Fri, 27 Mar 2026 12:55:27 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal
 <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH next] netfilter: nf_conntrack_h323: Correct indentation
 when H323_TRACE defined
Message-ID: <20260327125527.13aaf590@pumpkin>
In-Reply-To: <acZSPeowuYC7ivgA@pathway.suse.cz>
References: <20260326201819.3900-1-david.laight.linux@gmail.com>
	<acZSPeowuYC7ivgA@pathway.suse.cz>
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
	TAGGED_FROM(0.00)[bounces-272552-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBC50344AC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026 10:47:41 +0100
Petr Mladek <pmladek@suse.com> wrote:

> On Thu 2026-03-26 20:18:19, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > The trace lines are indented using PRINT("%*.s", xx, " ").
> > Userspace will treat this as "%*.0s" and will output no characters
> > when 'xx' is zero, the kernel treats it as "%*s" and will output
> > a single ' ' - which is probably what is intended.
> > 
> > Change all the formats to "%*s" removing the default precision.
> > This gives a single space indent when level is zero.
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> >  net/netfilter/nf_conntrack_h323_asn1.c | 38 +++++++++++++-------------
> >  1 file changed, 19 insertions(+), 19 deletions(-)
> > 
> > diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
> > index 7b1497ed97d2..287402428975 100644
> > --- a/net/netfilter/nf_conntrack_h323_asn1.c
> > +++ b/net/netfilter/nf_conntrack_h323_asn1.c
> > @@ -276,7 +276,7 @@ static unsigned int get_uint(struct bitstr *bs, int b)
> >  static int decode_nul(struct bitstr *bs, const struct field_t *f,
> >                        char *base, int level)
> >  {
> > -	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
> > +	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
> >  
> >  	return H323_ERROR_NONE;
> >  }  
> 
> The change is important for making the kernel %*.s handling POSIX
> compliant. The dot '.' without any following number is handled
> a zero precision by POSIX. It would print no space "" when
> also the field width was zero, aka when level == 0.
> 
> It has no efect if the field width (@level) is always > 0 because
> vsprintf() would add the required emptry spaces ' ' anyway.

That looks like C&P AI output...

> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Best Regards,
> Petr
> 
> 


