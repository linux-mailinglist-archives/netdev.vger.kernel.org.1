Return-Path: <netdev+bounces-224751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59449B892C7
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 13:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106171885C67
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 11:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40CD2FBE0D;
	Fri, 19 Sep 2025 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AWbv32QH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F602F8BEE
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279647; cv=none; b=G8xbvdOgFwyL5q1MjgL6qRGR/dsShogVY8Hx+iWC5I8jEmc0IIuqsdegpeE9aUMCeN4WSm8XV/4cwFb09TAlfjxs/7YgFYwPwWkTD9mC+f3Asnc4uw802QvksLTfxJ2QrhChMJpAgNW2iJAkiO1idWsoWPrWZugQuWI8A9OyX0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279647; c=relaxed/simple;
	bh=803O1q3nJmNwEnJ0eVOOfvB5A5ny0SBSloh+zkYI6Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYmWbGxMpmGzhMhVvL6KDUNMcLFvVjtPhOfJewY6OF1RL5cKu5rIhNft0FQ1yFK/hIF+NYGQlgvuAB0pRnKaNaGqei8eC4d1E3YZCY9ldpisS3k5PlAnqD5VNpqt15+aYQQ/p+F0pp1YhhvPxWpAXtfR1VA7sy6fQFxQlX/XRaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AWbv32QH; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b79773a389so20600801cf.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 04:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758279645; x=1758884445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxSNVg4jPXGA+Rdup/zzB+BaOlzldW8RsQCH8Thuqv0=;
        b=AWbv32QHREzVeF97v9N0i9aUuwwa7lFOK0tmAfluvauWuLMtuuAmeBJMD+ltzbDjUC
         cYWcIqLUBseEypFwuOj3CAf93wYFSMsblrKqI/oRq+JkeFfCPn03hbXQJajusn3E3hb2
         JC0vIjHxqcy3ElUSuqZ5tjdMlGA0mlmrb92aQnrZOOFp/MZueJeWc3+c/UPZTt52sVcu
         MkgDIMtrgoHy39YK0tKT+Ilkj1pDuhJRgNrGxXPxyidrF3BpcXTsFPuEos4ocAMBgITQ
         K+CYk2Cw6Ixzx07fIThcAd2SXB9KYAzYQMZW+8Go1jNGGlHUml0m1cnnC/PkQhrZ0/td
         cE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758279645; x=1758884445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxSNVg4jPXGA+Rdup/zzB+BaOlzldW8RsQCH8Thuqv0=;
        b=FjhyOUmV8CO0amW3YJgk8KPBjYf/WtVFSxd1e5XhqK3OwPbY87YKSNS3rWxYlmqMCd
         fnZQO3VVjqNb88J+EwWznuOn86EucBttIJQGz900ArdBaMzdKMCYVSRXUdUPLgIVFlrN
         SiKTk+loyFw7kx8UpwNDHRJ3MGc3gzfX1Rtcnflh85KR9vkTjdUgeyUkuxpjABaaBj8U
         jx8TgRWtS83OHRTa7udntFP+tlif1/zinApAcdSQ/8OIueBrLCjl3+PxMZjNBPXJOqOA
         ojX6h+vxXRl9f0xDzp3a2mdvLsxuGeCdznTAZwIEgqw020Q48W3bPk1aBSFJaKOMlgDR
         AQxA==
X-Forwarded-Encrypted: i=1; AJvYcCUazj0ZNHBU8WV0xIiV3Sn9Afav07F1N4eEb+z10rWtKFPRbQt+/SF5P/2NnGoAMW+mLK3IvsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwolEbHGHGKwKv/PIQkcUk/YM6NGppOVo9jDfmxjFzxPHY6Kl3k
	yby+oGqKjxPrUOzM/z+xSZP3umUpWzAyGYR0ZAHopq1X+t6Cf9yLdAGCjp7+Qsdqk2YbseiwlqF
	DDhmZz4cKuSzKop6c/PiIsw6dOblo2x/2JR6rYRoT
X-Gm-Gg: ASbGncslO7juSP9ILXX4F5VmjtsOEMMjlBPMFObmaegUBZSy9MwXa2JXrimFRmYlha6
	CYs53f4K7L/tAh3tYXsT/7Bt74/Q4uudFpd7UgcqfWzCvT/P0fFTHa2NuqCPRuCnf/VJkN9LEVA
	HnABgAo55NdrHY85RG9NWZKNpbExHqP8b7kvFjp8gfFRZtt9VGAohbUnmMPQB1EZ/xs1cMu7WJV
	kl8pQ==
X-Google-Smtp-Source: AGHT+IF2reMFk++hNVQtYtc0bIdPcfWiXwD0EU0fwgyj3cejB40NBcLz41GyRKMkii9zzss3WeJEtKrOQx2MX/Cji4k=
X-Received: by 2002:ac8:570f:0:b0:4b5:e6a7:304a with SMTP id
 d75a77b69052e-4c06e7cde40mr29850201cf.22.1758279640369; Fri, 19 Sep 2025
 04:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918155532.751173-4-edumazet@google.com> <202509191711.gDaSokkJ-lkp@intel.com>
In-Reply-To: <202509191711.gDaSokkJ-lkp@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Sep 2025 04:00:29 -0700
X-Gm-Features: AS18NWCWjUkb5moSf9QpEIxwAisqsl5A0nzCKgyJNySSI2fgU4h2hVLwa-WEP4A
Message-ID: <CANn89iLGOppxi1JqVXdjpXpMB44akvVU7fj-CTP5e4RPABzt0Q@mail.gmail.com>
Subject: Re: [PATCH net-next 3/7] tcp: move tcp->rcv_tstamp to
 tcp_sock_write_txrx group
To: kernel test robot <lkp@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, oe-kbuild-all@lists.linux.dev, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 3:10=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Eric,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-m=
ove-sk_uid-and-sk_protocol-to-sock_read_tx/20250919-000602
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20250918155532.751173-4-edumazet=
%40google.com
> patch subject: [PATCH net-next 3/7] tcp: move tcp->rcv_tstamp to tcp_sock=
_write_txrx group
> config: powerpc-ge_imp3a_defconfig (https://download.01.org/0day-ci/archi=
ve/20250919/202509191711.gDaSokkJ-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250919/202509191711.gDaSokkJ-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509191711.gDaSokkJ-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):

Yeah, I think I will remove these CACHELINE_ASSERT_GROUP_SIZE() which
are hard to maintain and bring little value.

