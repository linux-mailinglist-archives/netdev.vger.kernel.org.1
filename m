Return-Path: <netdev+bounces-119747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55267956D0E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 824411C22CB0
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0256D16D30E;
	Mon, 19 Aug 2024 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCnSvQan"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC6116D305;
	Mon, 19 Aug 2024 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077245; cv=none; b=Ye17IgfzNqqQ8YZG1oM7s/m7gSRl9HGHtfGMbXL6ARsQ7CSFJ38W7rIlLQja65VKCZ9knBn/zkGdKsSIB23d54JrlSDU5bdybcnf+IYwXi3Xzi8sBpIBL82tJbNVjITZwWxIXq1TSTIxG8MSITNqnxmgXGbdeAUK4gvBGf1Q/kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077245; c=relaxed/simple;
	bh=i+Cyk4r1wqyjIg8aK3AHCOEqai+Hp9QaEvJ9zMfwxq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=db+4gJ2a0g1LLsuiPQTLAFH3SSOfp+XGE1AeQ1DLw5eeLfJXCJRaefuV0WlUsErGWFKzx2Hq62MYK7H8HTS6Ndwh8VIRvrRZRxJnmPqLAFeD+RP6jjPeoXX1YSi3bKPktejzuX5+3PAGfYrlF+lVFpjHtKrM8BxsxA3sLPOh4j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCnSvQan; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d5bb03fe42so2509366eaf.3;
        Mon, 19 Aug 2024 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724077243; x=1724682043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i+Cyk4r1wqyjIg8aK3AHCOEqai+Hp9QaEvJ9zMfwxq8=;
        b=iCnSvQanm2i47rEy/+9dcqsW5jCCsCp+UiR2BVrEAw+cjhxJwhXPQDPN3UHpDzo6cg
         bjshFUB53u2B5TRfnBQowOwnuWfgZLB2SYPWxAwspuE2Af/g+PJAao5gP2ibKVm1Qd/O
         oU58gxiSIWcKZLWlhBvm4eQR+01qMxIafYfcs7xvNiqiq9IZfPs7Mab8GURQeAwNlfz1
         ZYZmT9SGndJ5+apwN8gMlnXCefVa8QH2rs2GXIQus1z2D+94sOQZiV594RnQaLhACRCY
         P8AZgV04gTZLPKruJqah3sEjeQ8ootBzB2KoJSTaYvhF6lCrjnBzWPAlTkQxROWeDKZV
         FH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724077243; x=1724682043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+Cyk4r1wqyjIg8aK3AHCOEqai+Hp9QaEvJ9zMfwxq8=;
        b=s38IJRwUchF8ojtEod6Is2GEhZ4WwNBIVpQvzKWXu9aovT4nDkgD8AAqqOSL75CIau
         81wETiehksraOJjN9Qu0jvjZNPa9AgXWbhhNb0QwUWtejpnvy2T0ghOKFgMCIEAhRDtG
         QUtLMEAVf3IzxqqkYyIhD5mUEOVyg8/a3z8whxV2e4WAOuhML0lM80+BdBEbqZ4lRqdr
         wfSM7sJuNF4gCqH7+irLsPmCOXTN0aHM/IK6MabYc9DOyuaTovC2y06KgJKugSQZRtRN
         Es1XC7v3TjSb1kpEeSfUCZkAonnh5UuU8YEeag9Xm6J1uyG7IYZ9DyLXoaH2e9DG8gxw
         VazQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmi5bHhaTxTzuVBpDW4C5lepx7bMJ1fE710K9VjKQXXvkxjQTMXBew32avFfZhBhAUUJDuBobr9XMtvJlcJ2F41QHxRatrl/zYM7IRZn71A9k9RwQ6bnPalH5DLf6zoQUb9IV5
X-Gm-Message-State: AOJu0Yz84BSK1iDmJpmsjk2QpY32gKX5DyrJwsaQiaWxQ9ZKey2TODR3
	8C0fuUr8eXsRDFw/jCVaqCQcs7a6g0mZFccBIqn7o8IUTBLrMhHHd8TL97HLsaO5R1lGNPVQ4et
	mnObe4q75/GHlVauyYc9ZQq6HIuo=
X-Google-Smtp-Source: AGHT+IFTkSRzt0owH9+yJEHG4u9PJMGi5AoL8RR3InQdF/CMGMP6iPcXFKK+OzDvsvqIAvV30TQVVskU3NPpYZS5vfY=
X-Received: by 2002:a05:6820:1b15:b0:5c4:144b:1ff9 with SMTP id
 006d021491bc7-5daa76dc4a5mr9523550eaf.5.1724077243652; Mon, 19 Aug 2024
 07:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819101238.1570176-1-vtpieter@gmail.com> <20240819101238.1570176-2-vtpieter@gmail.com>
 <20240819104112.gi2egnjbf3b67scu@skbuf> <CAHvy4ApydUb273oJRLLyfBKTNU1YHMBp261uRXJnLO05Hd0XKQ@mail.gmail.com>
 <90009327-df9d-4ed7-ac6c-be87065421ba@lunn.ch> <CAHvy4Aq0-9+Z9oCSSb=18GHduAfciAzritGb6yhNy1xvO8gNkg@mail.gmail.com>
 <9e5cc632-3058-46b2-8920-30c521eb1bbd@lunn.ch> <CAHvy4Aq=as=K48NZHt3Ek8Yg_AzyFdsmTe92b8SFobzUBM9JNA@mail.gmail.com>
 <20240819140536.f33prrex2n3ifi7i@skbuf>
In-Reply-To: <20240819140536.f33prrex2n3ifi7i@skbuf>
From: Pieter <vtpieter@gmail.com>
Date: Mon, 19 Aug 2024 16:20:31 +0200
Message-ID: <CAHvy4AqRbsjvU4mtRXHuu6dvPCgGfvZUUiDc3OPbk_PtdNBpPg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: add KSZ8
 change_tag_protocol support
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Woojung Huh <woojung.huh@microchip.com>, 
	UNGLinuxDriver@microchip.com, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

> On Mon, Aug 19, 2024 at 03:43:42PM +0200, Pieter wrote:
> > Right so I'm managing it but I don't care from which port the packets
> > originate, so I could disable the tagging in my case.
> >
> > My problem is that with tagging enabled, I cannot use the DSA conduit
> > interface as a regular one to open sockets etc.
>
> Open the socket on the bridge interface then?

Assuming this works, how to tell all user space programs to use br0 instead
of eth0? Both interfaces are up and I can't do `ifdown eth0` without losing
all connectivity. I'm using busybox's ifup BTW and it says:
$ ifup br0
ifup: ignoring unknown interface br0

Thanks, Pieter

