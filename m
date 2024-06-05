Return-Path: <netdev+bounces-101122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F178FD691
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 21:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03A9289730
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49E114F9E2;
	Wed,  5 Jun 2024 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0Y+6V8d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B02414EC6C
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616066; cv=none; b=pY8k0VaHTmLbAjMXa8n/VRwTT5ed8Po5Lsrj8GEXhlbhcLm6pjkn8F0C6Nz305g9/+EosUUWywVMEVb0ByFYJSAROtw25wRM4EzIMoffxvqTRpYWMpY8cpvlb+mcyYKn96TQhYuoaZFoEGQK1yrBB2TrUEcQ7sFoWYovv70A9uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616066; c=relaxed/simple;
	bh=F6uGhyXxFRGXwvwitWPk6r8o7SgW5av//5iXJYuMwIw=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0DetpdJPxfiMoAaWdNl4ntZFmdRB6mTb5qZsllpORYlar1yriJJnc8gOWavwWibghCwFEKoPMCz3e5dvNoU8ThUBjySFcPaSG0gwaJSEv250GZsE8CRGp1pvDoNiVv1rUvPeynEShvHT39315VzcC1fVuxGWBiRqkqMGyvvXT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0Y+6V8d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717616064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jH6Sf/5uQSKSb+Ny2G5B2sTCcG7O89rYUp8bSy5I1tY=;
	b=F0Y+6V8d+OYIaPBE/Dyo26g1RKzn31xbfoIK/CTA23/MbVsawOs9ZV1BncHk1uVqiFuCbj
	9Q/XaHnzekr0a+Ex8AyvW5r0XW9v60pDNJp1TBdX1CWWahuegVdWBV9V6wWqPdApsUHr5d
	evzJeY/gZCnQ8B2Qs4/Jgdfx5wbdRnI=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-NZjUfth6OcGTjfOE5Cd0cw-1; Wed, 05 Jun 2024 15:34:22 -0400
X-MC-Unique: NZjUfth6OcGTjfOE5Cd0cw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3d201325932so105317b6e.2
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 12:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717616062; x=1718220862;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jH6Sf/5uQSKSb+Ny2G5B2sTCcG7O89rYUp8bSy5I1tY=;
        b=dAgaDH1Dlipqq0GaM4M4HBpoME7o4cEDz9v4LeWW9k8s0cUvxWq7OIrGYjpUr/kz0C
         LJcQMfQ+5XNcOdv/dhRH72an7pzdmcWTSK78k7NH/jo0PlRlPm0uiUyw4RWfqdsHvqbB
         iRYCliBYeiQj/2mpzwxO/AZCcCiGVfpWOwAI5IxCgRL/mXqJGRdOW3F+XPrvrMv2IkK+
         ij0iOYZzldRfpvj6zIcGjxexstrWQTUAZHaGQH7LEZt63Q/S7s+r6uZuZ8RV8iBu1Bcf
         DcjNDE0JJBlgA2xktEkNKz8fpo9IwHKz6l6DGimMMqXlTqpNGjQme1CPghvTm57rUVI3
         WV4w==
X-Gm-Message-State: AOJu0YzQKNEQGj6YvlUCki6ER0EhrvPRYuH5c5+TU+bebmuM6iSXfSCD
	SYzMN6WOrbXQZL9m+YHqVVMX9l/Qad2jL5QUkvKzIW7aw5bGKFkkiw46aUgBwPtkh2pFcwN/ocV
	RDGuPj87OPrf27gKZLe9P1Uk08Bop1Q8bUMxXms0+6EsbJxdVfRvH8533gyO7H+rPvD3WqdyrcI
	H/GdIp8jiXBhybLS21PIC54JUFvlxV
X-Received: by 2002:a05:6808:de6:b0:3d1:b4d5:88fe with SMTP id 5614622812f47-3d2043dbe5bmr3873303b6e.54.1717616062090;
        Wed, 05 Jun 2024 12:34:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgkFGoqjTxQfTUgtST68W0+4pEtir9khOtAK5Fhc6jUhofrXE7C0NKaHykTGdJIOM2zLahI1Ss4Ni/zH+fXrw=
X-Received: by 2002:a05:6808:de6:b0:3d1:b4d5:88fe with SMTP id
 5614622812f47-3d2043dbe5bmr3873276b6e.54.1717616061672; Wed, 05 Jun 2024
 12:34:21 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Jun 2024 19:34:21 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-7-amorenoz@redhat.com> <202406041623.ycwsuP85-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202406041623.ycwsuP85-lkp@intel.com>
Date: Wed, 5 Jun 2024 19:34:21 +0000
Message-ID: <CAG=2xmMUuS=VesSk1SQ2Pk0xHj_-Hfj6c5Wk7iV=7Ed0VdHiaw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 6/9] net: openvswitch: store sampling
 probability in cb.
To: kernel test robot <lkp@intel.com>
Cc: netdev@vger.kernel.org, oe-kbuild-all@lists.linux.dev, aconole@redhat.com, 
	echaudro@redhat.com, horms@kernel.org, i.maximets@ovn.org, 
	dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 04, 2024 at 04:49:39PM GMT, kernel test robot wrote:
> Hi Adrian,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Moreno/net-psample-add-user-cookie/20240604-030055
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240603185647.2310748-7-amorenoz%40redhat.com
> patch subject: [PATCH net-next v2 6/9] net: openvswitch: store sampling probability in cb.
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20240604/202406041623.ycwsuP85-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240604/202406041623.ycwsuP85-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406041623.ycwsuP85-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    m68k-linux-ld: net/openvswitch/actions.o: in function `do_execute_actions':
> >> actions.c:(.text+0x214e): undefined reference to `__udivdi3'
>

I forgot about architectures that don't have native u64 division. I will
use "do_div" in the next version of the series.

> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>


