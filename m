Return-Path: <netdev+bounces-133711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85189996C4F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307F41F21D80
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63051990D6;
	Wed,  9 Oct 2024 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="e2NBnY5A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F06198E7B
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481056; cv=none; b=W/0SruNi+FnY55G7B3fnhY6rOVki72mL9DiC7/i5YGqgm222veC+jolfiv2JhmAYazbh699E3H64hA7kqnY2VutLgv7DmnUloyZaB/P8rmSh1+7SbbRTJwSncjHtBt6enUE5S6fbatnpAkFZmYIiQe1GzDzghQ7+IjC9a2H+1Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481056; c=relaxed/simple;
	bh=S2yg5CDYXmK0Yjzm1uFaKIz1Sf1NvCuAXDKRsqgX0M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llpn0TPpXcK9LkD3ALwCALOrxlYNehVoc4vMNDU6r+3SSPzABkpdxPCIoNttzlOw/ClCR/sYfJr3zAut50NDanesrxvrz8boBXkqrtLzzL81bVK/h+kKHq5e2gtTG8x4xsZQjKq46NKB/FHXkG17Nxrolq7tuNsbRBbPFeGcAHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=e2NBnY5A; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c91756c9easo1501677a12.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 06:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1728481052; x=1729085852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nqhwTa9NMzqePvf0HUbmEblIm7MIxbvRbFlw4JxRl9Y=;
        b=e2NBnY5Au3zu0EcE0psI5VTtg1WPwWkKccYk6dLVS+LjQvLnMXtk534zT6lw1mahia
         aRWw7hZRRnqnG3ZPCULoLp+HkLu2jwt7uhiwdPNerajBHc9RCh/0GMcEQNQvo+sm+vUd
         KAAxJz1XG4j46cmsE3yBn9YFuVmnxqrK3slSg7QwT3T2LlP23z4si0yjLa/5tzNw25qI
         hBPvYLmB2SwRBBTfelFSPj2GZbksJjFCrYy71gee0VyXxOc7i568zdArVzMGMx+kIo7j
         T8DvPoygeukLb0F2vfGOW+babsel/pjIo8I7ksD7EVjJdu7cGi7Nv4Hoz8wip3wo+QzS
         ewaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728481052; x=1729085852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqhwTa9NMzqePvf0HUbmEblIm7MIxbvRbFlw4JxRl9Y=;
        b=WMFURU5v02bvGMFinFoM6OJYGSDtOJtZGPayKp16ekTkQqJmby2LqbcoWMVBw0tuOR
         lSwlS37voLiBD8Q9oR1oF6LVSYcZq6kVbciRAfYemLBexSrViYX7HHzu98UgNoIzMvfT
         8AHJMgiKKPwWVRTDZ0Xs8Bi6Af7xK34+Tw8skUhEpeAS9ACDXP+tfOh0dtNjL6GMvKcu
         PY8GN6WziUo6lzl7dsMX1IYitax/kiQtSuSiL95yAgUJDXnRAjSbWT9SI3QcqkPR1x/0
         mkKn2OHc33+XMagrZjgKx6zS6JH31DjUxYM3TMBqGglBfcvSju8H3HQQzXVIb7koWne5
         HZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCUOh9mFAcKRWLDZKBDaVtZKETd7mW2Iz4c7nrGq9srJ3nsH9nUYpf5j1ZlPxK92rGzw+TYNr5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwh4RAmgAE9ctqp7HLHo3HDMUkSUIqAlVhWJ97n/utMAW2bZT1
	1+uY4xANVVdaDIfpndgbsBmA1Y0MgkwLOVT9HOXmIQIIcdOAoK/SvmK41n1PjBc=
X-Google-Smtp-Source: AGHT+IHWliCSvmBhKHKp00PfbHUDyLls4Jz3GroGyxWT0DpU7U7wTZezVGR9KVoAdwI2RmDTmCw8BQ==
X-Received: by 2002:a17:907:ea0:b0:a99:5f45:cb69 with SMTP id a640c23a62f3a-a998b138503mr323417366b.4.1728481052059;
        Wed, 09 Oct 2024 06:37:32 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99497e7975sm507636466b.201.2024.10.09.06.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 06:37:31 -0700 (PDT)
Date: Wed, 9 Oct 2024 15:37:27 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Antonio Quartulli <a@unstable.cc>
Cc: kuba@kernel.org, netdev@vger.kernel.org, donald.hunter@gmail.com,
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com
Subject: Re: [PATCH] tools: ynl-gen: include auto-generated uAPI header only
 once
Message-ID: <ZwaHF8ZEEHXV7yCE@nanopsycho.orion>
References: <20241009121235.4967-1-a@unstable.cc>
 <ZwZ7_qjDH_y0JIcN@nanopsycho.orion>
 <fbfc65b2-7614-44a1-9fcb-daa1a8f1e780@unstable.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbfc65b2-7614-44a1-9fcb-daa1a8f1e780@unstable.cc>

Wed, Oct 09, 2024 at 03:00:42PM CEST, a@unstable.cc wrote:
>On 09/10/2024 14:50, Jiri Pirko wrote:
>> Wed, Oct 09, 2024 at 02:12:35PM CEST, a@unstable.cc wrote:
>> > The auto-generated uAPI file is currently included in both the
>> > .h and .c netlink stub files.
>> > However, the .c file already includes its .h counterpart, thus
>> > leading to a double inclusion of the uAPI header.
>> > 
>> > Prevent the double inclusion by including the uAPI header in the
>> > .h stub file only.
>> > 
>> > Signed-off-by: Antonio Quartulli <a@unstable.cc>
>> > ---
>> > drivers/dpll/dpll_nl.c     | 2 --
>> > drivers/net/team/team_nl.c | 2 --
>> > fs/nfsd/netlink.c          | 2 --
>> > net/core/netdev-genl-gen.c | 1 -
>> > net/devlink/netlink_gen.c  | 2 --
>> > net/handshake/genl.c       | 2 --
>> > net/ipv4/fou_nl.c          | 2 --
>> > net/mptcp/mptcp_pm_gen.c   | 2 --
>> > tools/net/ynl/ynl-gen-c.py | 4 +++-
>> > 9 files changed, 3 insertions(+), 16 deletions(-)
>> > 
>> > diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
>> > index fe9b6893d261..9a739d9dcfbd 100644
>> > --- a/drivers/dpll/dpll_nl.c
>> > +++ b/drivers/dpll/dpll_nl.c
>> > @@ -8,8 +8,6 @@
>> > 
>> > #include "dpll_nl.h"
>> > 
>> > -#include <uapi/linux/dpll.h>
>> 
>> What seems to be the problem? The uapi headers are protected for double
>> inclusion, no?
>> #ifndef _UAPI_LINUX_DPLL_H
>> #define _UAPI_LINUX_DPLL_H
>
>There is no problem to fix, this is just a compile-time micro-optimization by
>reducing the number of includes to follow.
>
>I was recently told there is ongoing effort to reduce the amount of useless
>includes in order to speed up the compilation process.

Do you have some numbers?

So far I had impression that the common practise is to include header
directly when needed and not to depend on indirect include.


>
>I thought this was an easy fix in this direction :)
>
>Regards,
>
>-- 
>Antonio Quartulli

