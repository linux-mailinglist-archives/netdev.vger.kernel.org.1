Return-Path: <netdev+bounces-79447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F317879471
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 13:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6274F1C21E3C
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 12:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E3856750;
	Tue, 12 Mar 2024 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IVoMUb9n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D717C811
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710247697; cv=none; b=CfKl/i0QVZS7Ix1lLTJDTz2swDl9tisOW2Ir2wxU6HxyiH4eKb1LaTmkpTEdKlb+g8e83kaUYWMtc2OLsfgJS4h+//G71Gq1iZNrfYOm3RHSLzc84aUQM/RFd8qr7V038wKlFKumTJkDq7JTrnVujia6VO6Y/GW8VK5YWJhNq9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710247697; c=relaxed/simple;
	bh=bQ0z986SOhhYZK5di0Ia9dTWWx+TjDC6xwoTwHkCPOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWYXujdRkis0DSb6R1hZFMJmanDKxgDt0U8wbs5N0l0aMe4w10PzYlouMFwBedgI4TZx2drkr2jusJwORUXrXrnFVuc4XKkc+IdHDQegAl3onxuVlE8nTbulLB/z6BOt176myiybUClVZsDpP33/svUIEcF5By0rTO5ntr8BlDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=IVoMUb9n; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so810149966b.0
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710247692; x=1710852492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gLj2dDtz5N7Wgq2r5NkiG8l+uO4ptZ5w0qKAdq3xnwQ=;
        b=IVoMUb9n40mFBNPx95bzExH7AOJ2BC05XWLO96lX4t/aRdNL1lWQFGXZDXYNQafhbB
         I3Nem5it9toe0LpV/Mq9C30mjSI6vRkc7MIVRcxywiRcOLRCyTTFzFzK6sX6HHqvC2mh
         2uJgH38GgJ/EE3PGLzSaG34UFgfgndtnukagNUqeXgWK3Ge+6KWawERnFDa2ZmopQDJD
         NpZf7yNRozlqlctq9POJNGT4unq+TU4szg02PxpYoTrjXSQLD40M73dCuQhCmplHphsw
         v+yXA/B1Xan8VMp6ZFWCsqp7er/vZXYfnzFwJ+LtED2BXoBeDX/r5sMhl4ZvnHyCcSqX
         xQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710247692; x=1710852492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLj2dDtz5N7Wgq2r5NkiG8l+uO4ptZ5w0qKAdq3xnwQ=;
        b=rl6+SqtNCdeZWYNBHuOqaCGpS0WpuQMtokj0QARe9KJiMLxCQBUGtUV1m3lGMfmNTz
         GHTTA3zSFwf3Dw2NddoPcyDG3Z6I0UG9nKUbpz4RptyCzpwu2VsUYEO5ihMljxvtuZGx
         s4uK0VorK2LUSjS6wHGKJkwobVPiaQ/9Cflvsf/Qwmtga9B0N+d1o/DZNSnsBb6cMqJb
         +N19EJO8q9HMNs21QQKVcs19S/3Hm/uoxepVQU+xibnizDhvdySLD+xfWQYSuVzDE8fA
         9lkUmyyD2kIXP831TUw86ekgBEOreMICzn2ffzjenRkEQrMz94Qih8rUTNzuTnykUPW1
         s2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUm/DJfHweMG7QZ7zuIpWZrOmDyJ/JQ8aSt8gUZkgIlFMWBSCClXOrSm9GUbW6TLRve9FdiBjFKRCpA39fpbJG5/h8kHZuD
X-Gm-Message-State: AOJu0YzQgJ9XXVfq1/EGKg0QzwGZ5X9COeBNFS1+0tbqaTLB8gzwIkrt
	zmRxYPt87yF5r8qxQyjjNNz6olPbNFVK+vWhVguZU13fPDTH8QST+dC+aXdgJxo=
X-Google-Smtp-Source: AGHT+IFMyoZMmivun1Wc0cCcysCZSYvLg//aUTXLVCzps2yVnQpmTA/HDDSsCuHoKUY2B2Rf5FTJtA==
X-Received: by 2002:a17:906:bf44:b0:a46:4799:8f44 with SMTP id ps4-20020a170906bf4400b00a4647998f44mr1171727ejb.54.1710247691747;
        Tue, 12 Mar 2024 05:48:11 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id lr1-20020a170906fb8100b00a442e2940fdsm3866569ejb.179.2024.03.12.05.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 05:48:11 -0700 (PDT)
Date: Tue, 12 Mar 2024 13:48:10 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
Subject: Re: How to display IPv4 array?
Message-ID: <ZfBPCpo2peYBUMHW@nanopsycho>
References: <ZfApoTpVaiaoH1F0@Laptop-X1>
 <ZfBGrqVYRz6ZRmT-@nanopsycho>
 <ZfBMbZRbgwFOFPmk@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfBMbZRbgwFOFPmk@Laptop-X1>

Tue, Mar 12, 2024 at 01:37:01PM CET, liuhangbin@gmail.com wrote:
>Hi Jiri,
>On Tue, Mar 12, 2024 at 01:12:30PM +0100, Jiri Pirko wrote:
>> Tue, Mar 12, 2024 at 11:08:33AM CET, liuhangbin@gmail.com wrote:
>> >Hi Jakub,
>> >
>> >I plan to add bond support for Documentation/netlink/specs/rt_link.yaml. While
>> >dealing with the attrs. I got a problem about how to show the bonding arp/ns
>> >targets. Because the arp/ns targets are filled as an array[1]. I tried
>> >something like:
>> >
>> >  -
>> >    name: linkinfo-bond-attrs
>> >    name-prefix: ifla-bond-
>> >    attributes:
>> >      -
>> >        name: arp-ip-target
>> >        type: nest
>> >        nested-attributes: ipv4-addr
>> >  -
>> >    name: ipv4-addr
>> >    attributes:
>> >      -
>> >        name: addr
>> >        type: binary
>> >        display-hint: ipv4
>> >
>> >But this failed with error: Exception: Space 'ipv4-addr' has no attribute with value '0'
>> >Do you have any suggestion?
>> >
>> >[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/drivers/net/bonding/bond_netlink.c#n670
>> 
>> Yeah, that's odd use of attr type, here it is an array index. I'm pretty
>> sure I saw this in the past on different netlink places.
>> I believe that is not supported with the existing ynl code.
>> 
>> Perhaps something like the following might work:
>>       -
>>         name: arp-ip-target
>>         type: binary
>>         display-hint: ipv4
>> 	nested-array: true
>> 
>> "nested-array" would tell the parser to expect a nest that has attr
>> type of value of array index, "type" is the same for all array members.
>> The output will be the same as in case of "multi-attr", array index
>> ignored (I don't see what it would be good for to the user).
>
>Yes, this looks a do-able way. Although we already have a similar type
>'array-nest'...

That is something else. That is you have a nested attribute that holds
multiple nests of the same attr type with attributes inside. Something
completely different from what I see...


>
>I also figured out a workaround. e.g.
>
>  -
>    name: linkinfo-bond-attrs
>    name-prefix: ifla-bond-
>    attributes:
>      -
>        name: arp-ip-target
>        type: nest
>        nested-attributes: ipv4-addr
>
>  -
>    name: ipv4-addr
>    attributes:
>      -
>        name: addr0
>        value: 0
>        type: u32
>        byte-order: big-endian
>        display-hint: ipv4
>      -
>        name: addr1
>        value: 1
>        type: u32
>        byte-order: big-endian
>        display-hint: ipv4

Or, special value "any" or "all" that would match them all?


>
>With this we can show the target like:
>
>     'arp-ip-target': {'addr0': '192.168.1.1',
>                       'addr1': '192.168.1.2'},
>
>But we need to add all BOND_MAX_ARP_TARGETS attrs. Which doesn't like a good
>way. So maybe as you suggested, add a new type "nested-array".



>
>Thanks
>Hangbin

