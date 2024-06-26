Return-Path: <netdev+bounces-107080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5ED919B67
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 01:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E06B203F1
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 23:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCD91922FE;
	Wed, 26 Jun 2024 23:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3dSvlmO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CDA19146C
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 23:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719445906; cv=none; b=qh2dCXCwMXED6hk8PTLd+V74/OV8xncK+59g70h3FMiNtFJp7XrPP86GOVbrFoGEZH7j5HXIH0dfIwWvkr5GV/jdB8N86SDVwEBwY4a38zzp2Tm7kjkc5p5CqwXIS68oxTFEJH0ItYcvmEBPdzK1DzyPiKDA2hXAqeFUmdBOTcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719445906; c=relaxed/simple;
	bh=jmDH01onxD+4WaY7Nc1y5ZwevL+tjA1RIkLVOpmnaUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueQoKumCy2mbtMz9vc9YluUm3RMR2I1uUz9ReGFxcF5BNpBpxQXUMUjSstGEt4tn5+6PMTTxkAbcnAa8yESWJH8llGeT2uPl9WQobQX8dYc5yy/ZGgTMSYh5Xymn0VpHBFCGxzWcyLJXladWBsdVh+xaLRoqLXCB5uM0jkleGW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3dSvlmO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719445903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p0ek8Krpo61z47c32j8vg78WB/lUQuDxaKCNIhz6s7k=;
	b=Q3dSvlmOdxgUD2e0Q8lNCPbkMwu7kj9j565FhQRwINgTkS473g8xt+SOl1+oYjUNDilgTX
	sa4yKkK2ze/+fCERLlQk+5IODIEkWB0ZY00VF+rNPXkLlAnORQ7Uhp0gJQEYTIbK0IiPT4
	hsEE6eAUOQiHJMD62qGdCCNEw13jHIk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-Rydw8i6iODOPNfxYz8nqUw-1; Wed, 26 Jun 2024 19:51:41 -0400
X-MC-Unique: Rydw8i6iODOPNfxYz8nqUw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4246cf4c87dso44733085e9.2
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 16:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719445900; x=1720050700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0ek8Krpo61z47c32j8vg78WB/lUQuDxaKCNIhz6s7k=;
        b=JK/ISTcu6gAD2qSrDDSGHxYkY/aoLp0Kq0xgodXxj+OYh10DIQiY/ZKr980WUfwe/Q
         ly80D9wdc0q0GCzExE4tfPFhvgR3EnfRni9z3CyknLJQLujKa1bUOZMQausdCFpDGoPg
         47m2iveU5ECY+MYGcqnIkaumZ04mT907YA7bnZVD72/5j5pH9oEBJQHjt2z6JRt5Hu1k
         zee0TJXprvjiUkJ+j0Wxsw0/Z7cRjUWFOP9dIzYnFT7nstTjcqqvcJCB9MfO/fNv1P1r
         406AEPCP0vu6YkUcT56Z0WQwcBcp0bXDFI3MGbPWdDFQv1c7DrlKKtKGGHGuZfVIreWL
         kZRQ==
X-Gm-Message-State: AOJu0Yw1+FtpG6Sd64ehGagjXSHTbsiLTHfJ0kqSXHA7rgujMEC1aQJ6
	lbkSUyYFrO98TIVxAx76RmWOgNG2ATTMRgF1HZ2paoKRwAovjDlXKnFSpNOiPeSEDbkAY7wEl+X
	WEjgjWFsVaZVhfeuma2IffUUhRSdjaF9uRvoLt+mrrlXDlFEMwwsJDvWDegOzuQ==
X-Received: by 2002:a05:600c:829:b0:425:61be:c911 with SMTP id 5b1f17b1804b1-42561bec952mr10865055e9.21.1719445900140;
        Wed, 26 Jun 2024 16:51:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtUvtBKf5vDonnUjHrKtE83Nq51sjOY2q46Gb/azrFSBTJ/oRCxPUjsvDJKIvDIeMEuIU5Kg==
X-Received: by 2002:a05:600c:829:b0:425:61be:c911 with SMTP id 5b1f17b1804b1-42561bec952mr10864945e9.21.1719445899520;
        Wed, 26 Jun 2024 16:51:39 -0700 (PDT)
Received: from debian (2a01cb058d23d600d251a45a2ceebce7.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:d251:a45a:2cee:bce7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564bb6ce2sm2362525e9.32.2024.06.26.16.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 16:51:39 -0700 (PDT)
Date: Thu, 27 Jun 2024 01:51:37 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
Subject: Re: Matching on DSCP with IPv4 FIB rules
Message-ID: <ZnypieBfn3CxCGDq@debian>
References: <ZnwCWejSuOTqriJc@shredder.mtl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnwCWejSuOTqriJc@shredder.mtl.com>

On Wed, Jun 26, 2024 at 02:58:17PM +0300, Ido Schimmel wrote:
> Hi Guillaume, everyone,

Hi Ido, thanks for reaching out,

> We have users that would like to direct traffic to a routing table based
> on the DSCP value in the IP header. While this can be done using IPv6
> FIB rules, it cannot be done using IPv4 FIB rules as the kernel only
> allows such rules to match on the three TOS bits from RFC 791 (lower
> three DSCP bits). See more info in Guillaume's excellent presentation
> here [1].
> 
> Extending IPv4 FIB rules to match on DSCP is not easy because of how
> inconsistently the TOS field in the IPv4 flow information structure
> (i.e., 'struct flowi4::flowi4_tos') is initialized and handled
> throughout the networking stack.
> 
> Redefining the field using 'dscp_t' and removing the masking of the
> upper three DSCP bits is not an option as it will change existing
> behavior. For example, an incoming IPv4 packet with a DS field of 0xfc
> will no longer match a FIB rule that matches on 'tos 0x1c'.

Could removing the high order bits mask actually _be_ an option? I was
worried about behaviour change when I started looking into this. But,
with time, I'm more and more thinking about just removing the mask.

Here are the reasons why:

  * DSCP deprecated the Precedence/TOS bits separation more than
    25 years ago. I've never heard of anyone trying to use the high
    order bits as Preference, while we've had several reports of people
    using (or trying to use) the full DSCP bit range.
    Also, I far as I know, Linux never offered any way to interpret the
    high order bits as Precedence (apart from parsing these bits
    manually with u32 or BPF, but these use cases wouldn't be affected
    if we decided to use the full DSCP bit range in core IPv4 code).

  * Ignoring the high order bits creates useless inconsistencies
    between the IPv4 and IPv6 code, while current RFCs make no such
    distinction.

  * Even the IPv4 implementation isn't self consistent. While most
    route lookups are done with the high order bits cleared, some parts
    of the code explicitly use the full DSCP bit range.

  * In the past, people have sent patches to mask the high order DSCP
    bits and created regressions because of that. People seem to use
    the RT_TOS() macro on whatever "tos" variable they see, without
    really understanding the consequences. I think we'd be better off
    without RT_TOS() and the various IPTOS_* variants, so people
    wouldn't be tempted to copy/pasting such code.

  * It would indeed be a behaviour change to make "tos 0x1c" exactly
    match "0x1c". But I'd be surprised if people really expected "0x1c"
    to actually match "0xfc". Also currently one can set "tos 0x1f" in
    routes, but no packet will ever match. That's probably not
    something anyone would expect. Making "0x1c" mean "0x1c" and "0x1f"
    mean "0x1f" would simplify everyone's life I believe.

> Instead, I was thinking of extending the IPv4 flow information structure
> with a new 'dscp_t' field (e.g., 'struct flowi4::dscp') and adding a new
> DSCP FIB rule attribute (e.g., 'FRA_DSCP') that accepts values in the
> range of [0, 63] which both address families will support. This will
> allow user space to get a consistent behavior between IPv4 and IPv6 with
> regards to DSCP matching, without affecting existing use cases.

If removing the high order bits mask really isn't feasible, then yes,
that'd probably be our best option. But this would make both the code
and the UAPI more complex. Also we'd have to take care of corner cases
(when both TOS and DSCP are set) and make the same changes to IPv4
routes, to keep TOS/DSCP consistent between ip-rule and ip-route.

Dropping the high order bits mask, on the other hand, would make
everything consistent and would simplifies both the code and the user
experience. The only drawback is that "tos 0x1c" would only match "0x1c"
(and not "0x1f" anymore). But, as I said earlier, I doubt if such a use
case really exist.

> Adding the new field and initializing it correctly throughout the stack
> is not a small undertaking so I was wondering a) Are you OK with the
> suggested approach? b) If not, what else would you suggest?

Sorry for the long text, but I think you have my opinion now.
And yes, whatever the option, this is going to be a long task.

Side note: I'm actually working on a series to start converting
flowi4_tos to dscp_t. I should have a first patch set ready soon
(converting only a few places). But, I'm keeping the old behaviour of
clearing the 3 high order bits for now (these are just two separate
topics).

I can allocate more time on the dscp_t conversion and work/help with
removing the high order bits mask if there's interest in this option.

> Thanks
> 
> [1] https://lpc.events/event/11/contributions/943/attachments/901/1780/inet_tos_lpc2021.pdf
> 


