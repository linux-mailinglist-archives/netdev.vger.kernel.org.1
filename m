Return-Path: <netdev+bounces-99047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E198D3898
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD43B1C21F02
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9798B1CA84;
	Wed, 29 May 2024 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDw5Xi7h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFFC12B95;
	Wed, 29 May 2024 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991449; cv=none; b=qTbblvjWsqFFAsF2XJKZhL4Vk6lQjDXtxbzM3rcBroDU88DvSWsJ7obWWXV9sQGiNBv/NIkQ7S1VeOaQtYlK/Y6OxmFCHVU7W9VTjLYH8Je0zuGrx5uhC0ZvO/sfTPA0wYQb8pI16PK6zbdVaDf4Altfe1Ojl8K+/yenWrq7fm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991449; c=relaxed/simple;
	bh=iJYrtpX9ka5VFZ07GiTH2MWKv9spjWrvU0W38Q3AYDo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qClsjk8fxNp378nzHhEpnr9JfAJ36fYVLva0LG7+2zmlVGyB8JrIwjVhOMxekQEtYSuiDYjXWbXpqEZXMABqseDXfhuoDKqymNbJIJpOefwtYsJ5FHJBuUBNRYfV0cPBWbuEx9JtprBnMfOCvpN+rwzeR4nZA+onhRCtlV9crhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDw5Xi7h; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ad654913a0so11564986d6.1;
        Wed, 29 May 2024 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716991447; x=1717596247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TXrxAfDrmeaY9/60Ysmq8ztm0OX/wGOddNeWUJZZdY=;
        b=TDw5Xi7hnjxXw03kEHQ0ROpsSNjktX0CogAF95tolSeqef4F9ZmvaGbWEkGDiLCStE
         TkJOM/NucMN5M5e8sD8rJt8WMXCetD1gmPBq23MYlYXUQYgKW+QC360LSHoEi80F8cbP
         5LRvSH6rgqliSsPMz347xDP+7+n8lHxB4ejfncLHUaYzaErvCap2mHr8DUhi9KCjYXfd
         Yx1nGqhD7cMXbD48abuP3sUKVD0Thf3tEaS0UqVV8ZmG2V8Qq8dO6P8+bKeBtR88wWbf
         W73KE+aiVH8xCcB6v6pCo/cth/Di5wkBWmhYftFVRCSh7/c4+Ae9B73ciJXKvCTGMKWr
         W7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716991447; x=1717596247;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4TXrxAfDrmeaY9/60Ysmq8ztm0OX/wGOddNeWUJZZdY=;
        b=d2kfRyMwD/kZ4SoPZvkscYLVUOSfULRVaYn21BKh3jCgQwHTxqEH0HHvF6AEqBBLPp
         UJOn8Ab0X/zPfCVLPCDqJ2XGr4EKdQnSFFtljdJbjXpzFGGqpuuSxezdzsK9pnKKlgJo
         +koRc9n+Is32ESsLxw/3pfhuiHIfEptLHpKRzusEruM0D6d8x3M3IsgtUyQ6wCJd+n1d
         JPJ/eV366cZLeTjnXQcQHPx1nMNl2seIF+6/V/NFKHJIn13TWt7RyhN8j9mkZQFsOdOu
         oA38uf5eJCrPVcfEBRx9sE86BeTY4TilrbrUFyVNCeIY9Z9eBtYgLLUofUrMr1su3zV9
         vxXA==
X-Forwarded-Encrypted: i=1; AJvYcCUkur9L94bh8btjNnN50soK/LnNeANGdSjqC1pLWpcwmf9+vK70BK9wizpKP/VTtQ+/jQia3R1bceroYlPkDskdg7Bz7Irn
X-Gm-Message-State: AOJu0Yww4spSjlAyj2Js2+8tTv2skZ5W1gKOHK70EEg5Mkep+U00tarT
	btsWlSbgCgI/+U14wxB5dCumudd4kTQ/xHft7aIBmlpH3h6/SqULum7sAw==
X-Google-Smtp-Source: AGHT+IFyxiFH4DS8xQoBF1ntUHwzAoeS4Sg/lci/+9tzGl7pl40gu6YoOozl2OmmggDo64waBE1EHQ==
X-Received: by 2002:a05:6214:459a:b0:6ad:69b1:6577 with SMTP id 6a1803df08f44-6ad69b16652mr154614656d6.28.1716991445263;
        Wed, 29 May 2024 07:04:05 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad6f17d7d6sm41111816d6.11.2024.05.29.07.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:04:04 -0700 (PDT)
Date: Wed, 29 May 2024 10:04:02 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "davem@davemloft.net" <davem@davemloft.net>
Message-ID: <665735d273a1c_31b267294ce@willemb.c.googlers.com.notmuch>
In-Reply-To: <782b9eb64af66eba132ac6382305d407e33dd604.camel@mediatek.com>
References: <20240428142913.18666-1-shiming.cheng@mediatek.com>
 <20240429064209.5ce59350@kernel.org>
 <bc69f8cc4aed8b16daba17c0ca0199fe6d7d24a8.camel@mediatek.com>
 <20240516081110.362cbb51@kernel.org>
 <15675c6e0facd64b1cdc2ec0ded32b84a4e5744b.camel@mediatek.com>
 <664f3aa1847cc_1a64412944f@willemb.c.googlers.com.notmuch>
 <664f59eedbee7_1b5d24294ef@willemb.c.googlers.com.notmuch>
 <782b9eb64af66eba132ac6382305d407e33dd604.camel@mediatek.com>
Subject: Re: [PATCH net] net: prevent pulling SKB_GSO_FRAGLIST skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> On Thu, 2024-05-23 at 10:59 -0400, Willem de Bruijn wrote:
> >  	 =

> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  Willem de Bruijn wrote:
> > > > The problem now is the ethtool in ubuntu can't support "rx-gro-
> > list"
> > > > and "rx-udp-gro-forwarding" although it is updated to version 6.7=

> > from =

> > > > https://mirrors.edge.kernel.org/pub/software/network/ethtool. =

> > > > =

> > > > There is another verison in =

> > > > =

> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/net/ethtool
> > .
> > > >  We download the sourcecode but don't know how to compile for
> > ubuntu as
> > > > no ./configure there.
> > > > =

> > > > Is it the one we should use?  If yes, could you please show me
> > how to
> > > > compile and install this ethtool?
> > > =

> > > https://git.kernel.org/pub/scm/network/ethtool/ethtool.git is the
> > > upstream ethtool repo.
> > > =

> > > Since you are testing a custom built kernel, there are other hacky
> > > ways to configure a feature if you lack a userspace component:
> > > =

> > > - just hardcode on or off and reboot
> > > - use YNL ethtool (but features is not implemented yet?)
> > > - write your own netlink helper
> > > - abuse some existing kernel API to toggle it, like a rarely uses
> > systl
> > =

> > And as shared off-line, virtme-ng (vng) can be a good option for
> > working on tools/testing/selftests too.
> > =

> > Ideally
> > =

> > ```
> > vng -v -b -f tools/testing/selftests/net
> > make headers
> > make -C tools/testing/selftests/net
> > =

> > vng -v -r arch/x86/boot/bzImage --user root
> > # inside the VM
> > make -C tools/testing/selftests TARGETS=3Dnet run_tests
> > ```
> > =

> > Though last time I tried I had to use a slightly more roundabout
> > =

> > ```
> > make defconfig; make kvm_guest.config
> > ./scripts/kconfig/merge_config.sh -m .config
> > tools/testing/selftests/net/config
> > make olddefconfig
> > make -j $(nproc) bzImage
> > make headers
> > make -C tools/testing/selftests/net
> > =

> > vng -v -r arch/x86/boot/bzImage --user root
> > ```
> > =

> > =

> > =

> https://lpc.events/event/17/contributions/1506/attachments/1143/2441/vi=
rtme-ng.pdf
> =

> Dear Willem,
> In https://github.com/arighi/virtme-ng it needs kernel 6.5 to setup.
> Current our enviroument doesn't support and we prepare to install a PC
> with a new ubuntu22.04.
> =

> Do you know any request for ubuntu version to run vng, Which version is=

> more fit for?

Let's take these configuration questions offline. I've responded.=

