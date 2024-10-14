Return-Path: <netdev+bounces-135223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F76299CF92
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 16:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609911C2342E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD6F1BF7E8;
	Mon, 14 Oct 2024 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcVXfDp+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A01C2DC8
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917595; cv=none; b=D1gTCgn81C/x7QdqnQ5ldVcWrd5aLqnpFk7ctV+g7671kjD6REutbrthP2g14sDio4EncCJJmaupe6FN+sjlnV+78ZRNqqMtMAtIqn0JXroRWGazk1EZ2I79eKTUj8u+labfkYcworYpaq7NoT4gqtfKrWnrm2leWJlJhsL92/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917595; c=relaxed/simple;
	bh=Mc0L2NsFHZ+l7K5EPIgitcrl7S2yI5e+H3LINpoTiOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYht2dIqzXcY/mE6yrwnL4eR4ow7m4pq/RcljBYqF9ZUsFzIER0hCMllSstgbBAK8Qgd+8iko3xBT/B1sWOwcfiYHPeeLdtipamwIkggacT3o33F9pcE5vPxK98StJCp8PMPBCsEBhHnlV7aZyGKaunKvfmLw0CUnyMqNUPQOAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcVXfDp+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cdbe608b3so9813585ad.1
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728917594; x=1729522394; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ghOd8jHdgvvqfY6Tl2tfqqm4MmET9dSjnc0zaa1x2Vo=;
        b=ZcVXfDp+qbDrJCgqOFnZEbJfAOps6hr2yEeXygjoJdlPRRjDwm1IePwvvgldqjW222
         Q3eqK3AmCz4GrEMzQh/AoaPLBTa9KUN25FNgBn+OkE6YCO6FOZM0KSnP8AZtIFE/Z+db
         F2L50S9lTiyH7VAPxkoWV5GPhdPy1A0DV1qmFU2O+YLUML0J/kDBQXbnoj9Uf2KWBDIj
         dynZlAq3M1ZpgEUrdAGNL1SmcxcMvm/ZV362+cCtBwydwZ+bSpxvgxVfYSsAgIGhuf5M
         q+Ae6vQOe0nxqZqoz+DQN19720nH8yG4xsdf6Yj4lbiQikG6DmtdHLwqShAURiOpeiIb
         CEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728917594; x=1729522394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghOd8jHdgvvqfY6Tl2tfqqm4MmET9dSjnc0zaa1x2Vo=;
        b=oYWUz9xj2EADA1qOcN6xFPXQ2942JCVi8D2BHGCetlfrzB8O/34p7CPmr5shLYjRte
         HPZwSGSK5+LHJBsMv90gFD1RLApjImvOTGWqKgF/h2UT4Eh5kK66036CVs2Ja81Nu1/x
         z0j41lWaACAHVLeUZeY4XVzoZbb4ZO6+NMBPVs1W2Z3PiNwHMdm+Sc32lNzDOAGR4J3G
         hq5YcZ8SiOuOlGvXbDzitogJz4oUufvm83REh1jvfgcSVj1nKVPpjdcSCCg4Psgoo7CQ
         3a9dG9A20iSfas5Q4fxrMQx/opXR43QClybQ3uEFDtnQ13uoBaC+moD5Kv7/B73/h65i
         KMmg==
X-Forwarded-Encrypted: i=1; AJvYcCV3z1CZYqfiTUTo75SnCnwZIk2jI6A+9ADg17Kz9UATBjPT7mC/hERhcLFRo/5DR8S2QsXdExI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztHbvi082aI/jkD/3VT+CIsIfr1Kv9W647KinAl0R7aXqcJBa9
	/OzFZ28OxA8+LLh9O9kBrnUJB3PUiUyYDw7D2ND8SxwyMOMgYvivNxud
X-Google-Smtp-Source: AGHT+IHAwBvWIz7PBG25kCnaM3/UGS8hS2il6FDqu5l69lHP7QCTj/IBmFSk0lXNFyrBosmR3wnMcA==
X-Received: by 2002:a17:903:2445:b0:20c:bea0:8d10 with SMTP id d9443c01a7336-20cbea0921emr126163625ad.20.1728917593592;
        Mon, 14 Oct 2024 07:53:13 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e772csm67345605ad.175.2024.10.14.07.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 07:53:13 -0700 (PDT)
Date: Mon, 14 Oct 2024 07:53:12 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v3 05/12] selftests: ncdevmem: Remove default
 arguments
Message-ID: <Zw0wWGl7KDYVWL3b@mini-arch>
References: <20241009171252.2328284-1-sdf@fomichev.me>
 <20241009171252.2328284-6-sdf@fomichev.me>
 <CAHS8izNuNwSjWTkHo545HT8r2JEp_idY34NGPEEyiTj8XmzW3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNuNwSjWTkHo545HT8r2JEp_idY34NGPEEyiTj8XmzW3Q@mail.gmail.com>

On 10/12, Mina Almasry wrote:
> On Wed, Oct 9, 2024 at 10:13 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > To make it clear what's required and what's not. Also, some of the
> > values don't seem like a good defaults; for example eth1.
> >
> > Move the invocation comment to the top, add missing -s to the client
> > and cleanup the client invocation a bit to make more readable.
> >
> > Cc: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  tools/testing/selftests/net/ncdevmem.c | 49 ++++++++++++++------------
> >  1 file changed, 27 insertions(+), 22 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> > index 2ee7b4eb9f71..99ae3a595787 100644
> > --- a/tools/testing/selftests/net/ncdevmem.c
> > +++ b/tools/testing/selftests/net/ncdevmem.c
> > @@ -1,4 +1,19 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * tcpdevmem netcat. Works similarly to netcat but does device memory TCP
> > + * instead of regular TCP. Uses udmabuf to mock a dmabuf provider.
> > + *
> > + * Usage:
> > + *
> > + *     On server:
> > + *     ncdevmem -s <server IP> [-c <client IP>] -f eth1 -l -p 5201
> > + *
> > + *     On client:
> > + *     echo -n "hello\nworld" | nc -s <server IP> 5201 -p 5201
> > + *
> 
> No need to remove the documentation telling users how to do validation
> when moving these docs. Please have a secondary section that retains
> the docs for the validation:
> 
> * Usage:
> 
> (what you have)
> 
> * Test data validation:
> 
> (What I had before)
> 
> With that:
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>

SG, will do, thanks!

