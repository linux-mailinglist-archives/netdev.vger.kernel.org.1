Return-Path: <netdev+bounces-86869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D3E8A0885
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 08:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24B19B2333A
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 06:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3BF13CAB3;
	Thu, 11 Apr 2024 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1YzeAQVF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0DA13B5BA
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712817279; cv=none; b=dR5MdlHoe/QMD6/RRJ2Tbr+AMRIJ6zAJhacx+i4DB+e2RJsnQo2zIHu+L4aBnbQvHs9EpP3ppbWBz2XjOUMYyNyHUeMyRRrTAZ2DKCiSE8rwHi+wSns0/s50QQtZmg2J936nHaEF1MGi/Ja/X1P5YXO9+UA9eOCupm5VMvOlhHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712817279; c=relaxed/simple;
	bh=ObuoOQmCK8gUlvTP5nscYhRAbR5j9i/hAuLi+p4+QuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lpq5YYvAkBbRsgkvG+iTb8NJ5BhnJ6n263LHhAVqwHurMquMye8jasAryqtgaLDqG7/gHzZpQF/Wvf/kCsmMu0HafiTDCUeuziM17WWvLg7/PGxlqFZJktzcb/T6jDQ/rPbP2u5Q/oUk8WoCIDn9vIxO6yhdYosYE3CQSe0mvoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1YzeAQVF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso797158166b.2
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 23:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712817276; x=1713422076; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gACNAQK/3KMTgTHdAXSuj1n/QGKhg5qwwF8BZdwnAbY=;
        b=1YzeAQVFljvQKLvX2zgrY4Qv63OfrGVfOjcB2TQPxMJHo0jpDsp9qR5flTPhjn1QfJ
         vFCp6Bso+IYrlAGulqydEx1wF2++jkT/Q7Gj2qTl3TCi4xdGQ02j0FFMACrHcRHkExLB
         MRs1g4i3KAj1IJ/MpMKRAkC9vK/V+umIEodYz8c/q0LGOOCLWGxZpkSc0CBuRI0iXU+m
         GnJB/JgLmOCiqQhDFJoJsHE18XEzyFscBJIaSZCQ8W1cnB7gFFO+vFF1ZA/wmUqgR3f+
         SLeVcj4aI5bt7t7xiKMjwMD5mRFrPz4evihJ/+J6Z0KmtVrCV6tOY3d/fLbKuOmdBndZ
         jDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712817276; x=1713422076;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gACNAQK/3KMTgTHdAXSuj1n/QGKhg5qwwF8BZdwnAbY=;
        b=rT66OvZzhaZX9lQlFXgB/b5OqgK3AyxyCde371JEoJ25EUqM8Bi8XA3vpKOKXuMAGV
         NhRjGVXtue+5BxkT6eEbDuw9Np8ACB909KfEC8rsdBvS8CUUS4zpCwt+YDHbu3AkxkLp
         DJ9TAzOrSuX1lJkzuR7knLApQPtIRF6QW++yXvDUHkamik9qHDbD5ZZ/FBA4yfz57bLh
         ZmPTrzthReaphzX1wdyVpj/rCcmD7Mv6v9UT1pha2llGjdjyQYvfKbYqG6m3RVHOuHJa
         B59VU3MEzsDLf5ZZsbqEfhRUStg+YkHdOtpCQ11czSd9tlHFE6hdWKlr4tLB1ufILDd3
         nn5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUn8epF8n23rXbF27VqhiEyAppGnsuqWOyIaEoL2kuPV4ApQ8n10p/PHhDSoU2M41qUUhJha25AwLszckjsjkfWfwAzmlrn
X-Gm-Message-State: AOJu0Yydsk7p/diaSA4zbQYwM8rGuWtsniHNyZ+YoCm2ij9fKlnJfuIy
	5yugY6ZTg+ejlZrtQWIvnm5yP37sYC3ZyiNgKpFHXJyiblMtW3nZZNFI0TBesbE=
X-Google-Smtp-Source: AGHT+IHsOeiG9iP7Zif3ocJyJINoKkP8etLHrDqisAkt+e8GRUFWs1wEHdC5HgQCYtdQmH59yR/upQ==
X-Received: by 2002:a17:906:2554:b0:a51:adac:e1dd with SMTP id j20-20020a170906255400b00a51adace1ddmr3369527ejb.26.1712817275732;
        Wed, 10 Apr 2024 23:34:35 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id hg20-20020a1709072cd400b00a5225c87f65sm122045ejc.56.2024.04.10.23.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 23:34:35 -0700 (PDT)
Date: Thu, 11 Apr 2024 08:34:33 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, pabeni@redhat.com,
	John Fastabend <john.fastabend@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <ZheEeT-Gajp0rl3H@nanopsycho>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org>
 <ZhZC1kKMCKRvgIhd@nanopsycho>
 <20240410064611.553c22e9@kernel.org>
 <ZhasUvIMdewdM3KI@nanopsycho>
 <20240410103531.46437def@kernel.org>
 <c0f643ee-2dee-428c-ac5f-2fd59b142c0e@gmail.com>
 <20240410105619.3c19d189@kernel.org>
 <CAKgT0UepNfYJN73J9LRWwAGqQ7YPwQUNTXff3PTN26DpwWix8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UepNfYJN73J9LRWwAGqQ7YPwQUNTXff3PTN26DpwWix8Q@mail.gmail.com>

Wed, Apr 10, 2024 at 08:01:44PM CEST, alexander.duyck@gmail.com wrote:
>On Wed, Apr 10, 2024 at 10:56 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Wed, 10 Apr 2024 10:39:11 -0700 Florian Fainelli wrote:
>> > > Hm, we currently group by vendor but the fact it's a private device
>> > > is probably more important indeed. For example if Google submits
>> > > a driver for a private device it may be confusing what's public
>> > > cloud (which I think/hope GVE is) and what's fully private.
>> > >
>> > > So we could categorize by the characteristic rather than vendor:
>> > >
>> > > drivers/net/ethernet/${term}/fbnic/
>> > >
>> > > I'm afraid it may be hard for us to agree on an accurate term, tho.
>> > > "Unused" sounds.. odd, we don't keep unused code, "private"
>> > > sounds like we granted someone special right not took some away,
>> > > maybe "exclusive"? Or "besteffort"? Or "staging" :D  IDK.
>> >
>> > Do we really need that categorization at the directory/filesystem level?
>> > cannot we just document it clearly in the Kconfig help text and under
>> > Documentation/networking/?
>>
>> From the reviewer perspective I think we will just remember.
>> If some newcomer tries to do refactoring they may benefit from seeing
>> this is a special device and more help is offered. Dunno if a newcomer
>> would look at the right docs.
>>
>> Whether it's more "paperwork" than we'll actually gain, I have no idea.
>> I may not be the best person to comment.
>
>Are we going to go through and retro-actively move some of the drivers
>that are already there that are exclusive to specific companies? That
>is the bigger issue as I see it. It has already been brought up that

Why is it an issue? Very easy to move drivers to this new directory.


>idpf is exclusive. In addition several other people have reached out
>to me about other devices that are exclusive to other organizations.
>
>I don't see any value in it as it would just encourage people to lie
>in order to avoid being put in what would essentially become a
>blacklisted directory.

You are thinking all or nothing. I'd say that if we have 80% of such
drivers in the correct place/directory, it's a win. The rest will lie.
Shame for them when it is discovered.


>
>If we are going to be trying to come up with some special status maybe
>it makes sense to have some status in the MAINTAINERS file that would
>indicate that this driver is exclusive to some organization and not
>publicly available so any maintenance would have to be proprietary.

