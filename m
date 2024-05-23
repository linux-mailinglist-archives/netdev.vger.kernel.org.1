Return-Path: <netdev+bounces-97829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1538CD66B
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 17:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F14B1C21BE0
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F0C538A;
	Thu, 23 May 2024 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+aH0G6d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7F66FB9;
	Thu, 23 May 2024 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476403; cv=none; b=ZXEDd1k4tVF1HnKCFaKSKkBPx+Y6U6c/QEiiH9W/TsPKYXtNgy+lH3+5W1m3De3VCTk92cygLy4aDMt+0UOxkH4VSHBfu+mtJWkY6xCnHPHA8gr+bvLa8BbKe5ZleBUjMvRE2Ladbh0XNGpCTYXp6nfxdp7jO5tPJAV+/jPjyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476403; c=relaxed/simple;
	bh=SAOCWyE5winR3sfCd14gHp7mco0EGetdVtps2eCt62I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cwoqXEnTathjcPL8KoAYu8NusMayplHLvnGtOrNyDkqcrpLBCveO6WoGGw6j4Bwphc5xzMlQ1vC8/wB+xq2p8cR0FmeYj9GSaS3sllLk4soWsIH21orUO9M7Glj3KTm8Kr/BJdsT9/aRYcUF5pVzpctzmc8cYmmrl6QYq805kCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+aH0G6d; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-df4e81e0b22so1939625276.3;
        Thu, 23 May 2024 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716476400; x=1717081200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pzvpZz45nT1lL1/WYOVJvhpVhqZ+zX2th+ykDS47iw=;
        b=E+aH0G6d+xzpc+LKTNxursx2/AhEsiZOjRu2NXSXSayVWfjdtyK8NqbIAmUsrGrxE/
         2vF6ciAocDLh5p1LyrBWxxJPKBPCr6OD9DCvs4d1shrpt/M5NtdwoLnUor4Hq8SLKiz2
         bzEHbs2yXAwFmMgJMUo0Jm2PTc1Ns5vz3lCV6CLnEnsrIanzHXdDidfz7XlNmjoHom3L
         2tsUh5AWtZRIaPD4ykYEDc6WMS7Fn5VL6pUAgjzhM7RtOaOVCmgsw7gv0JxvO/zizPHJ
         DD0p4h57x4qkYrTGkSe3zBZp/Px/OYBWPYtvqlSkZ9hecyRDbBWRL34I0MA6E3Bou0xg
         0DhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476400; x=1717081200;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2pzvpZz45nT1lL1/WYOVJvhpVhqZ+zX2th+ykDS47iw=;
        b=WoOVVTx4FFXdJYMmGy7/Oq2USnTITUQCOQH1Xmg2EUHfp7PB7f07ewutrmaD7HZAgF
         XX7kednpDuTAZAi3Nq/hBgVg8Svk3cBaiVbquJbUnMuIvRBhqzs8zeW38wwK2ZO33mT/
         N1C+jFa/E0f/yx16kUBChgfj/6xsQEGqVqetWah9utSbGOVewbvdYvorSpHziWqF+E6X
         oH0MFcrAuOauALU31YVMqRaCn+0keVZPE1PTADLkeQnLsjOJlrEwE4gws9e2dvSv1Lkp
         tMlPNqPAGNMz8iwnI9cp4/gc0DDV8SuM3UAGhrkoQmc6eAFJTRQA8R7QespknEzW58yZ
         5gfw==
X-Forwarded-Encrypted: i=1; AJvYcCVcde5K76dFgKPNAOHRXoa6othsNKMTk6M9Tvu6oo/RObLVpaukya3npxRc5PrG8c4Sm8pc9webswT+zC9M64IWCT/dPsG7
X-Gm-Message-State: AOJu0YyzUsd8/VM6M1DzGjhbLXbApbnHL6z6CNF+Mb/aTv6XazLtzRPQ
	d+wc86H3an9q17uaa5LanzVzLlf4oCkOo5UJmDCBMSekSudd59WeC8UDtA==
X-Google-Smtp-Source: AGHT+IF0s0+xHBS8iHKnTWrDlRyAwmj/nJRi3prOJDDqcze2NocDRfUC22GnS69mlHtKPLHdp7ulLw==
X-Received: by 2002:a05:6902:2211:b0:de5:6a82:49dd with SMTP id 3f1490d57ef6-df4e0a760eemr6165214276.13.1716476400389;
        Thu, 23 May 2024 08:00:00 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab8be59ba7sm11024876d6.24.2024.05.23.07.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 07:59:59 -0700 (PDT)
Date: Thu, 23 May 2024 10:59:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>, 
 "kuba@kernel.org" <kuba@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "davem@davemloft.net" <davem@davemloft.net>
Message-ID: <664f59eedbee7_1b5d24294ef@willemb.c.googlers.com.notmuch>
In-Reply-To: <664f3aa1847cc_1a64412944f@willemb.c.googlers.com.notmuch>
References: <20240428142913.18666-1-shiming.cheng@mediatek.com>
 <20240429064209.5ce59350@kernel.org>
 <bc69f8cc4aed8b16daba17c0ca0199fe6d7d24a8.camel@mediatek.com>
 <20240516081110.362cbb51@kernel.org>
 <15675c6e0facd64b1cdc2ec0ded32b84a4e5744b.camel@mediatek.com>
 <664f3aa1847cc_1a64412944f@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net] net: prevent pulling SKB_GSO_FRAGLIST skb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> > The problem now is the ethtool in ubuntu can't support "rx-gro-list"
> > and "rx-udp-gro-forwarding" although it is updated to version 6.7 from 
> > https://mirrors.edge.kernel.org/pub/software/network/ethtool. 
> > 
> > There is another verison in 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ethtool.
> >  We download the sourcecode but don't know how to compile for ubuntu as
> > no ./configure there.
> > 
> > Is it the one we should use?  If yes, could you please show me how to
> > compile and install this ethtool?
> 
> https://git.kernel.org/pub/scm/network/ethtool/ethtool.git is the
> upstream ethtool repo.
> 
> Since you are testing a custom built kernel, there are other hacky
> ways to configure a feature if you lack a userspace component:
> 
> - just hardcode on or off and reboot
> - use YNL ethtool (but features is not implemented yet?)
> - write your own netlink helper
> - abuse some existing kernel API to toggle it, like a rarely uses systl

And as shared off-line, virtme-ng (vng) can be a good option for
working on tools/testing/selftests too.

Ideally

```
vng -v -b -f tools/testing/selftests/net
make headers
make -C tools/testing/selftests/net

vng -v -r arch/x86/boot/bzImage --user root
# inside the VM
make -C tools/testing/selftests TARGETS=net run_tests
```

Though last time I tried I had to use a slightly more roundabout

```
make defconfig; make kvm_guest.config
./scripts/kconfig/merge_config.sh -m .config tools/testing/selftests/net/config
make olddefconfig
make -j $(nproc) bzImage
make headers
make -C tools/testing/selftests/net

vng -v -r arch/x86/boot/bzImage --user root
```


https://lpc.events/event/17/contributions/1506/attachments/1143/2441/virtme-ng.pdf

