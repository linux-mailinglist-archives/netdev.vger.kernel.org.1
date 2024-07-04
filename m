Return-Path: <netdev+bounces-109306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DD9927CED
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 20:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42C41C21D45
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 18:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DDD49637;
	Thu,  4 Jul 2024 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJ64SsWR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE90273448
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117155; cv=none; b=e03TBPM3aCri2EjPjqSdN0bvqm/gECSDzvM7xExL2YYTEc/o4qbGguMmGsN40f96uu8roxYXJrbjufqIE3WV0BIXozAiIpl+6lBwv4xhQ+kitvZv60iY3n16gzDXomRw1A9RYIQGosHaNlvRdWAuyTrATRfrEh/Kp9Y9lOsnlmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117155; c=relaxed/simple;
	bh=KnpuVQFOnf2fkJZukzaCJiA96LgpiyUtyW+fSxmLtVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+PIUeXekyTIEzQWFVUdyl4tP6/5teGDEGdhyVSRLfeDpi4i8tpsH4ikenfM0hIlY3hzwUVr7qbM0aRhaFLGgtSoUiMs0SQSJQ/DyTUXz959ayUbh8VlOobblx+DknAnK3C5ZafQ2o/pdJkcLhTS0fm+G9ACDnI85yWuFhgQXhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJ64SsWR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720117152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4WkjCAgFtwIPJLhnWcIN/D4NL7ObjbUspf1+15Ff5s=;
	b=PJ64SsWR+i5WPihrRlQeb5MDH/mjy+oNL54h9hHximJn8tUtz/NNy95g9VXu9rU1a1QUEh
	0tj5CXTVWHfox2yIkqk7d7/NdhkO5XU/fg+YH+X44VSaozlZSBC3+Cs6AG7grD2oCQSh3E
	Q0i2skP42pTSzF+GLnBdwd+K4wImq5k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-YIArFQHLOf2iEgAvr9-T1A-1; Thu, 04 Jul 2024 14:19:10 -0400
X-MC-Unique: YIArFQHLOf2iEgAvr9-T1A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3679ed08797so546066f8f.0
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 11:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720117149; x=1720721949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4WkjCAgFtwIPJLhnWcIN/D4NL7ObjbUspf1+15Ff5s=;
        b=IZF0iVd6MOz8oY7/Z3JN9nWHS2CNLfs+yjhTzfAeaA8GbncRejNpWi18/C1h8m26bM
         OZbCTOofaH9ZkG+CA1U91v3wghb3dsZnoaPBoksHJRGaLRberjw1DT1Wk8m3xDQBwi4k
         aXtvxJnO+jXx35cCxnM4Llv7/V034lxTPizbeqqThe+NgTkdf3wvQKiZgPslDW5a8i0n
         NJZWssZTl/CJe/GzCu77VMaSop8Q6IvIk9fSBwevXmMNsRVgktxC8dpz6NfK7gaa3u43
         lTej5PZAMPsJ01YHp8ApUlaDvXsd/ub88pqDP/a972CNA6/2kaFGAlJKfKHjX9nY4wrR
         99Wg==
X-Gm-Message-State: AOJu0YxUS2x2SpRIeVg9fRYhU2KO7/ulyr3qJ26RjDZX+IMBpS2APN+p
	a2pr/O3Uiyfs3oslIatcfX33k5oiSFr32QTUpPGYNsda2OzDrceLtcsfmu6IRKfhCmGq3QAkO9A
	JRi+GTnzynsOboQMESV3oiHK5OFyC6H50RYYydL9cB/7bomHuRwYHAhfv+8wqlg==
X-Received: by 2002:a5d:58e5:0:b0:367:895a:dd10 with SMTP id ffacd0b85a97d-3679dd315b8mr1617032f8f.35.1720117148974;
        Thu, 04 Jul 2024 11:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH23BsdWhrQHKBiZMatkdsyM46Rzw8KKGHFPEfRpJSJq7PIqAAZRW5nt0hPaxUvvu6pfzSFNA==
X-Received: by 2002:a5d:58e5:0:b0:367:895a:dd10 with SMTP id ffacd0b85a97d-3679dd315b8mr1617021f8f.35.1720117148218;
        Thu, 04 Jul 2024 11:19:08 -0700 (PDT)
Received: from debian (2a01cb058918ce00ad3cb3d1d6486b90.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:ad3c:b3d1:d648:6b90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a3016f8bsm995075f8f.46.2024.07.04.11.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 11:19:07 -0700 (PDT)
Date: Thu, 4 Jul 2024 20:19:05 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
Subject: Re: Matching on DSCP with IPv4 FIB rules
Message-ID: <Zobnma+cQPMhIlSy@debian>
References: <ZnwCWejSuOTqriJc@shredder.mtl.com>
 <ZnypieBfn3CxCGDq@debian>
 <Zn3DdfGZIVBxN0DR@shredder.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn3DdfGZIVBxN0DR@shredder.lan>

On Thu, Jun 27, 2024 at 10:54:29PM +0300, Ido Schimmel wrote:
> Hi Guillaume, thanks for the detailed response!
> 
> On Thu, Jun 27, 2024 at 01:51:37AM +0200, Guillaume Nault wrote:
> > 
> > Could removing the high order bits mask actually _be_ an option? I was
> > worried about behaviour change when I started looking into this. But,
> > with time, I'm more and more thinking about just removing the mask.
> > 
> > Here are the reasons why:
> > 
> >   * DSCP deprecated the Precedence/TOS bits separation more than
> >     25 years ago. I've never heard of anyone trying to use the high
> >     order bits as Preference, while we've had several reports of people
> >     using (or trying to use) the full DSCP bit range.
> >     Also, I far as I know, Linux never offered any way to interpret the
> >     high order bits as Precedence (apart from parsing these bits
> >     manually with u32 or BPF, but these use cases wouldn't be affected
> >     if we decided to use the full DSCP bit range in core IPv4 code).
> > 
> >   * Ignoring the high order bits creates useless inconsistencies
> >     between the IPv4 and IPv6 code, while current RFCs make no such
> >     distinction.
> > 
> >   * Even the IPv4 implementation isn't self consistent. While most
> >     route lookups are done with the high order bits cleared, some parts
> >     of the code explicitly use the full DSCP bit range.
> > 
> >   * In the past, people have sent patches to mask the high order DSCP
> >     bits and created regressions because of that. People seem to use
> 
> By "patches" you mean IPv6 patches?

Not necessarily. I had the following case in mind:
https://lore.kernel.org/netdev/20200805024131.2091206-1-liuhangbin@gmail.com/

I'm pretty sure this revert came after someone complained that setting
the high order DSCP bits stopped working in VXLAN. But I haven't
managed to find the original report.

But there has been fixes for IPv6 too:
https://lore.kernel.org/netdev/20220805191906.9323-1-matthias.may@westermo.com/

> >   * It would indeed be a behaviour change to make "tos 0x1c" exactly
> >     match "0x1c". But I'd be surprised if people really expected "0x1c"
> >     to actually match "0xfc". Also currently one can set "tos 0x1f" in
> >     routes, but no packet will ever match. That's probably not
> >     something anyone would expect. Making "0x1c" mean "0x1c" and "0x1f"
> >     mean "0x1f" would simplify everyone's life I believe.
> 
> Did you mean "0xfc" instead of "0x1f"? The kernel rejects routes with
> "tos 0x1f" due to ECN bits being set.

Yes, 0xfc. I don't know what I had in mind when I wrote 0x1f. That
value clearly doesn't make any sense in this context.

> I agree with everything you wrote except the assumption about users'
> expectations. I honestly do not know if some users are relying on "tos
> 0x1c" to also match "0xfc", but I am not really interested in finding
> out especially when undoing the change is not that easy. However, I have
> another suggestion that might work which seems like a middle ground
> between both approaches:
> 
> 1. Extending the IPv4 flow information structure with a new 'dscp_t'
> field (e.g., 'struct flowi4::dscp') and initializing it with the full
> DSCP value throughout the stack. Already did this for all the places
> where 'flowi4_tos' initialized other than flowi4_init_output() which is
> next on my list.
> 
> 2. Keeping the existing semantics of the "tos" keyword in ip-rule and
> ip-route to match on the three lower DSCP bits, but changing the IPv4
> functions that match on 'flowi4_tos' (fib_select_default,
> fib4_rule_match, fib_table_lookup) to instead match on the new DSCP
> field with a mask. For example, in fib4_rule_match(), instead of:
> 
> if (r->dscp && r->dscp != inet_dsfield_to_dscp(fl4->flowi4_tos))
> 
> We will have:
> 
> if (r->dscp && r->dscp != (fl4->dscp & IPTOS_RT_MASK))

So, do you mean to centralise the effect of all the current RT_TOS()
calls inside a few functions? So that we can eventually remove all
those RT_TOS() calls later?

> I was only able to find two call paths that can reach these functions
> with a TOS value that does not have its three upper DSCP bits masked:
> 
> nl_fib_input()
> 	nl_fib_lookup()
> 		flowi4_tos = frn->fl_tos	// Directly from user space
> 		fib_table_lookup()
> 
> nft_fib4_eval()
> 	flowi4_tos = iph->tos & DSCP_BITS
> 	fib_lookup()
> 
> The first belongs to an ancient "NETLINK_FIB_LOOKUP" family which I am
> quite certain nobody is using and the second belongs to netfilter's fib
> expression.

I agree that nl_fib_input() probably doesn't matter.

For nft_fib4_eval() it really looks like the current behaviour is
intended. And even though it's possible that nobody currently relies on
it, I think it's the correct one. So I don't really feel like changing
it.

> If regressions are reported for any of them (unlikely, IMO), we can add
> a new flow information flag (e.g., 'FLOWI_FLAG_DSCP_NO_MASK') which will
> tell the core routing functions to not apply the 'IPTOS_RT_MASK' mask.
> 
> 3. Removing 'struct flowi4::flowi4_tos'.
> 
> 4. Adding a new DSCP FIB rule attribute (e.g., 'FRA_DSCP') with a
> matching "dscp" keyword in iproute2 that accepts values in the range of
> [0, 63] which both address families will support. IPv4 will support it
> via the new DSCP field ('struct flowi4::dscp') and IPv6 will support it
> using the existing flow label field ('struct flowi6::flowlabel').

I'm sorry, something isn't clear to me. Since masking the high order
bits has been centralised at step 2, how will you match them?

If we continue to take fib4_rule_match() as an example; do you mean to
extend struct fib4_rule to store the extra information, so that
fib4_rule_match() knows how to test fl4->dscp? For example:

    /* Assuming FRA_DSCP sets ->dscp_mask to 0xff while the default
     * would be 0x1c to keep the old behaviour.
     */
    if (r->dscp && r->dscp != (fl4->dscp & r->dscp_mask))
        return 0;

> The kernel will reject rules that are configured with both "tos" and
> "dscp".
> 
> I do not want to add a similar keyword to ip-route because I have no use
> case for it and if we add it now we will never be able to remove it. It
> can always be added later without too much effort.
> 
> > 
> > > Instead, I was thinking of extending the IPv4 flow information structure
> > > with a new 'dscp_t' field (e.g., 'struct flowi4::dscp') and adding a new
> > > DSCP FIB rule attribute (e.g., 'FRA_DSCP') that accepts values in the
> > > range of [0, 63] which both address families will support. This will
> > > allow user space to get a consistent behavior between IPv4 and IPv6 with
> > > regards to DSCP matching, without affecting existing use cases.
> > 
> > If removing the high order bits mask really isn't feasible, then yes,
> > that'd probably be our best option. But this would make both the code
> > and the UAPI more complex. Also we'd have to take care of corner cases
> > (when both TOS and DSCP are set) and make the same changes to IPv4
> > routes, to keep TOS/DSCP consistent between ip-rule and ip-route.
> > 
> > Dropping the high order bits mask, on the other hand, would make
> > everything consistent and would simplifies both the code and the user
> > experience. The only drawback is that "tos 0x1c" would only match "0x1c"
> > (and not "0x1f" anymore). But, as I said earlier, I doubt if such a use
> > case really exist.
> 
> Whether use cases like that exist or not is the main issue I have with
> the removal of the high order bits mask. The advantage of this approach
> is that no new uAPI is required, but the disadvantage is that there is a
> potential for regressions without an easy mitigation.
> 
> I believe that with the approach I outlined above the potential for
> regressions is lower and we should have a way to mitigate them if/when
> reported. The disadvantage is that we need to introduce a new "dscp"
> keyword and a new netlink attribute.

What I'd really like is to stop the proliferation of RT_TOS() and to
get consistent behaviour. If the new "dscp" option allows that, while
still allowing to simplify the implementation, then I'm fine with it.

> > Side note: I'm actually working on a series to start converting
> > flowi4_tos to dscp_t. I should have a first patch set ready soon
> > (converting only a few places). But, I'm keeping the old behaviour of
> > clearing the 3 high order bits for now (these are just two separate
> > topics).
> 
> I will be happy to review, but I'm not sure what you mean by "converting
> only a few places". How does it work?

My idea is to go through the functions that uses ->flowi4_tos one by
one. I convert their u8 variables to dscp_t, but keep ->flowi4_tos a
__u8 field for the moment. For example:

-void my_func(__u8 tos, ...)
-void my_func(dscp_t dscp, ...)
 {
     ...
-    fl4.flowi4_tos = tos;
-    fl4.flowi4_tos = inet_dscp_to_dsfield(dscp);
     ...
 }

Of course, the whole call chain should be converted, until the function
that reads the value from a packet header or from user space:

 void another_func(const struct iphdr *ip4h)
 {
-    __u8 tos = ip4h->tos;
+    dscp_t dscp = inet_dsfield_to_dscp(ip4h->tos);
     ...
-    my_func(tos, ...);
+    my_func(dscp, ...);
     ...
 }

Depending on how complex is the call chain, I introduce intermediate
u8/dscp_t conversions, to keep patches simple.

The idea is to eventually have inet_dsfield_to_dscp() conversions at
the boundaries of the kernel, and to have temporary internal
inet_dscp_to_dsfield() calls when interacting with ->flowi4_tos.

Once all ->flowi4_tos users will actually use a dscp_t value, then
I'll convert this field from __u8 to dscp_t and remove all the extra
inet_dscp_to_dsfield() calls. That last patch will have to touch many
places at once, but, by renaming ->flowi4_tos to ->flowi4_dscp, we can
rely on the compiler and on sparse to ensure that every place has been
taken care of. Also, that final patch should be easy to review as it
should mostly consist of chunks like:

-    fl4->flowi4_tos = inet_dscp_to_dsfield(dscp);
+    fl4->flowi4_dscp = dscp;

But I'm not there yet ;).

Note that I'm going to be offline for a bit more than a week. I'll
catch up on this topic after I get back online.

> > I can allocate more time on the dscp_t conversion and work/help with
> > removing the high order bits mask if there's interest in this option.
> > 
> > > Thanks
> > > 
> > > [1] https://lpc.events/event/11/contributions/943/attachments/901/1780/inet_tos_lpc2021.pdf
> > > 
> > 
> 


