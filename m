Return-Path: <netdev+bounces-129558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEB4984747
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 16:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F35A1C21693
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 14:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045771A7273;
	Tue, 24 Sep 2024 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHzZ9R1N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544231A706C
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727186818; cv=none; b=AMGxZlfBZ+MA0faGWj+x/IE6z1b5Yhe7j0clmHV70LSJMa0aErcQxw2UzH3aU8o769+kjq18P5HrofPIWGhvRnKqijGEzSEZrRwHHpEoWhnPsxNJi6y9YzbM+Ns+SA20x0Ba2vRBp9il+tQTh1VjWkG6Q8uG4w3i+gQ0BfoD59E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727186818; c=relaxed/simple;
	bh=1MeXJwQgeHIcneOKXc/V6H1GQFp1pJcY1tGx8SsHiD4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CL+lfF/LM5Pe6pSW09QHz791ySbh7TRu/emMUp544X6opv/Ve5n3zuNG2QWnP4rfxFoTK+9Oswh6M9M7R2w5TzsPywuv4bQ9bYivSC7Xcoxf0tvoCzINk5/UeFXdWZBHeAw0O3Ur8lhtcAYLqnv7ZfrvTVKgBYW/5UZamtW7Bfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHzZ9R1N; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d29b7edc2so833227266b.1
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 07:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727186816; x=1727791616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YYqRfiJqyY3G62QsNkA/W1w8bwXLvhx/dOBn0s7eBPY=;
        b=UHzZ9R1Ne/UsaHElvL5ZY4qMFvq4UVMwLdxoO21kxJqC1QZ5mBLpECcrfgih3KMgTo
         O9itaXlZLHYvKhQfrz9JveO52iHRh2lMAFo7i7kIRTzmXx7uMmvPNLzsyKz161888QDv
         6f2WMNAanDLkwX46U/rN8V0jbSaNWlrSv5mXDYKkVnesmWNjIS0lUPlgeD+3IhGa8Wuo
         XcLB7hBRanS4Sw00o2RuEEPT1diiGtfNoy0lyaVmdkZCHJJcaZP64u0WHvC53x9qvWfR
         97udkxsAUjvK0A2lYkmBMrYEeGAmcce8z2tAj4DNqq0EGw0/mhA8RsFnaoBbGA7XjFhN
         X31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727186816; x=1727791616;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYqRfiJqyY3G62QsNkA/W1w8bwXLvhx/dOBn0s7eBPY=;
        b=tu52THKwZSatccdv1W86jwBA4eAsoBMO0YSFJBVoTHkKH9uOtYIE02QO4aJ99xyY3j
         rVJULe5+irDtskSFNzqJ62KjTQx2vGoskjjYL1W5bBom6qA+bz9gAJKNQ23NE0J+xSME
         zU0TNBumUscPcCJgFL37F/cwXMAAeWGKAanNa1yvPAB96+kF2bJlkhWAhS3YofxIvmeV
         u/sr7kZXw/oCbsCf9+LIHQfiWaG2XwT6M/F8NCIpkkk2ASP5XJXAzVyDhnWEm5DHyu6i
         ABmsh2w4P/YDDH/oQT0DRv1e+vJ9f05VBgEttpg+tymgFxu7TcBqBkc816b8yOn0iGB8
         BQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCUu2ZBCWZnVKJNioruJt4/4nL3Pn26lz27ePh0jUR6LmoOiPj6CIrn2UHzwn7t9r9QyvMwD6W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztZmXgUjqciV+0KZYcF22r2LfN+kzeVRr5hWT3lzj4rjB+9X/a
	I0OdmeswMha2pVlTlAgao4cUP/iag9+ylrnHoPf7gU3ISiDgDK4S
X-Google-Smtp-Source: AGHT+IHNxOd4e66iKCDp+tld13MEXDtQD2lEv9CJXo7OE+/qIeh2oo8gAJJNIGeOSlhHsvUVCieftw==
X-Received: by 2002:a17:906:7949:b0:a8d:128a:cc49 with SMTP id a640c23a62f3a-a90d57793f4mr1442235566b.52.1727186815344;
        Tue, 24 Sep 2024 07:06:55 -0700 (PDT)
Received: from [127.0.0.1] ([193.252.226.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f33de6sm88716966b.4.2024.09.24.07.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 07:06:54 -0700 (PDT)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <c739f928-86a2-46f8-b92e-86366758bb82@orange.com>
Date: Tue, 24 Sep 2024 16:06:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Massive hash collisions on FIB
To: Eric Dumazet <edumazet@google.com>,
 Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Simon Horman <horms@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
References: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
 <db6ecdc4-8053-42d6-89cc-39c70b199bde@intel.com>
 <20240916140130.GB415778@kernel.org>
 <e74ac4d7-44df-43f0-8b5d-46ef6697604f@orange.com>
 <CANn89i+kDvzWarnA4JJr2Cna2rCXrCFJjpmd7CNeVEj5tmtWMw@mail.gmail.com>
X-Mozilla-News-Host: news://127.0.0.1
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <CANn89i+kDvzWarnA4JJr2Cna2rCXrCFJjpmd7CNeVEj5tmtWMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/09/2024 08:59, Eric Dumazet wrote:
> 
>> What do you think ?
> 
> I do not see any blocker for making things more scalable.
> 
> It is only a matter of time and interest. I think that 99.99 % of
> linux hosts around the world
> have less than 10 netns.
> 
> RTNL removal is a little bit harder (and we hit RTNL contention even
> with less than 10 netns around)

Given this encouragement, I'm proceeding towards the the "million-tunnel baby".
And knowing where the current road bumps are, workarounds are possible: instead
of a direct 1M fanout of (netns+interface), I'm doing 10k netns with 100
interfaces each, which works like a charm.

But doing this I met an entirely new kind of bottleneck: the single FIB
hashtable, shared by all netns, lends itself to massive collision if many netns
contain the same local address.

Indeed, in this situation, the fib_inetaddr_notifier ends up inserting a local
route for the address, and the only "moving part" in the hash input is the
address itself.

As an example, after creating 7000 veth pairs and moving their "right half" to
7000 namespaces, an "ip addr add 192.168.1.2/32 dev $D" on one of them hits a
bucket of depth 7000.

To solve this, I'd naively inject a few bits of entropy from the netns itself
(inode number, middle bits of (struct net *) address, etc.), by XORing them to
the hash value. Unless I'm mistaken, the netns is always unambiguous when a FIB
decision is made, be it for a packet or for some interface configuration task.

Would that be acceptable ?



