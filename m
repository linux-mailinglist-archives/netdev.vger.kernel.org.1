Return-Path: <netdev+bounces-182625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A0FA89626
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C477A4EE4
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 08:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4040D275870;
	Tue, 15 Apr 2025 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfOZ4QBe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC04627A92E
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744704694; cv=none; b=Uj2lKg1w3JFxZLPUEHH7Uqv7E9Q7W++2Epg4dantaADw7QQJdaIV7gzijTLZ8tzjaknF8HyaJt/qn/VF3jUzde/GurzP6G+BF86hLV/ZZ72yrlJGHsvWryHcjdmbVQBGgsSsEoOsGZ92WGTKxYPigwOAjZrD7oAnqBK8xfjuPS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744704694; c=relaxed/simple;
	bh=lPwecMh4YmtdU4J8YGajfK+ncCjB10zBnsBkMA7E7DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYDGUjN44kfdZQbKomm2av3npSHNicYEIPTJ/tu/HnaQ7dJE55lVuoz1QxPFi9JzV8xjhW21j9XdfJ3wlM2ScA6+JjBfJgmuuT89PdS7WRssYdYE/Hsnj0t3dK5y8h9qZ81rqJnbtpT8qkVXVSFbxqCCM5PmxwXdnKG+x0rZ7w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfOZ4QBe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2295d78b45cso73672065ad.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744704692; x=1745309492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DcIYY172oo727jZz6L0Z1mLSYsl1+0URE/gKUkoMMlI=;
        b=EfOZ4QBeG8nPh+u2QYftKyrHmWgGTQq7Ayaxu2pPeu/8bV9Y/6pjEyQap15f7h2KHm
         pMk2eroew9Q6jSdaXvgT5s9vinA6hkTRB7b7XItYlFJYPtjvfBZCMNlWUsIT0l73WUwV
         zQ/V1AqvWLB9XG7ierKgsLN43JuXBFvwpTM7RSwnxpc0hrdFmedVoPCbcqno70P0cqth
         cX0ZbMJOnumquo7GyQAtCZrBzYTuz0vrb4sAeDHlpSIQgT19HeZy6l6Szqxwve61UbMq
         AcLBcTAbv9iZzpkV9N8dN+6JN/80oiP45+0qnNK2T5543x1ToubaEDf/WvH4C2UdJ7IF
         fDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744704692; x=1745309492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcIYY172oo727jZz6L0Z1mLSYsl1+0URE/gKUkoMMlI=;
        b=X7b0I08SGwBNoRtocorL/8/MxDKwB2kILJQgi2ajsyb0Jk1Izsdp49FP2HpM4H0j2s
         DRfqakn4pdYwL58rRj3bKVVDGhEIP0IoKOEpirgIVGSuvELFHN5I498bTbeVn9aIEmbl
         dYTgAZ07W3n5rXIYl4Lz343y2JeQve03bmKlX8dtAlMfwyZJDOjaoBMFBqqch35o7dDM
         X+NFk6oF38pu68wJvltUMPpxnRuXjuCeCRK0BXbEGSA+98pi6OrTing5/mlut16OPIKZ
         zPMi9IJGhrOpSKrp+8v6NXjyfy9+LsSAl6h/MluuTSI6TtMpvtt6XQqXtneCR4yc/ZWv
         qlKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7zKo0eNLl4TDHyLw7CnvvN/UAxdn/QcX4cy2YWRkQFmN6l6CRmLrXKo53z8BrE5nl5l86M28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCcG7EXT2d4yMVi4FbO4SGHpBN8MwjyqnJvyy24b1ewQur9rdq
	SA3wvvVxgTmAeDo+4o+Q+RVz3rM9DEnoQFLf9v/RILT8vhIsHvt5
X-Gm-Gg: ASbGncurJNrq1vNBB62Um9IvV0RKXIEdjVBtwdAzrftOOD2S1bAfeqXs0JBh6ZBRx/G
	yHHUOIwk5HNTyF/tEftt7z3D0CziOMx/lRQV5jqF3KtSQ+1cHjZbEULUESt57pECEuuF2uQKMq1
	00AoT3Lj2SyJJ3tDkRIlS9USP5eZ72fJhgAZuqEwX0kpkMq6tMy5ALB9vfxJoa3QD6iEXTV/HI8
	RSY5pEcgFhPKxcTV748H8IC3PWhjXEtaLy9RyIs5MUYlVA8V3nMaLSzFVSVgPWd66KMMsbgiP2a
	UXJVxN+Y28P0Si3hpp/MeDvE8QAAPn77b30jo+iVN7NE0Q==
X-Google-Smtp-Source: AGHT+IEQL6seOfu385F1KEwxncoCGPoveCp+JWtwGqpnOnKBEJZPHxvQT3NWUVxMugoDH0dcNc26nw==
X-Received: by 2002:a17:903:228a:b0:224:1781:a947 with SMTP id d9443c01a7336-22bea4b6de2mr218575865ad.21.1744704691623;
        Tue, 15 Apr 2025 01:11:31 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b90d8csm111421445ad.100.2025.04.15.01.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 01:11:30 -0700 (PDT)
Date: Tue, 15 Apr 2025 08:11:26 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org
Subject: Re: [Question] Any config needed for packetdrill testing?
Message-ID: <Z_4UrgawRVfK-hcT@fedora>
References: <Z_0FA77jteipe4l-@fedora>
 <20250414101348.497aa783@kicinski-fedora-PF5CM1Y0>
 <67fd5419b11d8_c648429411@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67fd5419b11d8_c648429411@willemb.c.googlers.com.notmuch>

On Mon, Apr 14, 2025 at 02:29:45PM -0400, Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > On Mon, 14 Apr 2025 12:52:19 +0000 Hangbin Liu wrote:
> > > Hi Willem,
> > > 
> > > I tried to run packetdrill in selftest, but doesn't work. e.g.
> > > 
> > > # rpm -q packetdrill
> > > packetdrill-2.0~20220927gitc556afb-10.fc41.x86_64
> > > # make mrproper
> > > # vng --build \
> > >             --config tools/testing/selftests/net/packetdrill/config \
> > >             --config kernel/configs/debug.config
> > > # vng -v --run . --user root --cpus 4 -- \
> > >             make -C tools/testing/selftests TARGETS=net/packetdrill run_tests
> > > make: Entering directory '/home/net/tools/testing/selftests'
> > > make[1]: Nothing to be done for 'all'.
> > > TAP version 13                                                                                                                  1..66
> > > # timeout set to 45
> > > # selftests: net/packetdrill: tcp_blocking_blocking-accept.pkt
> > > # TAP version 13
> > > # 1..2
> > > #
> > > not ok 1 selftests: net/packetdrill: tcp_blocking_blocking-accept.pkt # TIMEOUT 45 seconds
> > > # timeout set to 45
> > > # selftests: net/packetdrill: tcp_blocking_blocking-connect.pkt
> > > # TAP version 13
> > > # 1..2
> > > # tcp_blocking_blocking-connect.pkt:13: error handling packet: live packet field ipv4_total_length: expected: 40 (0x28) vs actua
> > > l: 60 (0x3c)
> > > # script packet:  0.234272 . 1:1(0) ack 1
> > > # actual packet:  1.136447 S 0:0(0) win 65535 <mss 1460,sackOK,TS val 3684156121 ecr 0,nop,wscale 8>
> > > # not ok 1 ipv4
> > > # ok 2 ipv6
> > > # # Totals: pass:1 fail:1 xfail:0 xpass:0 skip:0 error:0
> > > not ok 2 selftests: net/packetdrill: tcp_blocking_blocking-connect.pkt # exit=1
> > > 
> > > All the test failed. Even I use ksft_runner.sh it also failed.
> > > 
> > > # ./ksft_runner.sh tcp_inq_client.pkt
> > > TAP version 13
> > > 1..2
> > > tcp_inq_client.pkt:17: error handling packet: live packet field ipv4_total_length: expected: 52 (0x34) vs actual: 60 (0x3c)
> > > script packet:  0.013980 . 1:1(0) ack 1 <nop,nop,TS val 200 ecr 700>
> > > actual packet:  1.056058 S 0:0(0) win 65535 <mss 1460,sackOK,TS val 1154 ecr 0,nop,wscale 8>
> > > not ok 1 ipv4
> > > ok 2 ipv6
> > > # Totals: pass:1 fail:1 xfail:0 xpass:0 skip:0 error:0
> > > # echo $?
> > > 1
> > > 
> > > Is there any special config needed for packetdrill testing?
> > 
> > FWIW we don't do anything special for packetdrill in NIPA.
> > Here is the config and the build logs:
> > 
> > https://netdev-3.bots.linux.dev/vmksft-packetdrill/results/75222/config
> > https://netdev-3.bots.linux.dev/vmksft-packetdrill/results/77484/build/
> 
> Nothing special should be required, indeed.
> 
> Individual git commits also have explicit examples of how the code was
> built and tested. Such as
> 
> commit 88395c071f08 ("selftests/net: packetdrill: import tcp/ecn, tcp/close, tcp/sack, tcp/tcp_info")
> 
>     make mrproper
>     vng --build \
>         --config tools/testing/selftests/net/packetdrill/config \
>         --config kernel/configs/debug.config
>     vng -v --run . --user root --cpus 4 -- \
>         make -C tools/testing/selftests TARGETS=net/packetdrill run_tests
> 
> and commit 8a405552fd3b ("selftests/net: integrate packetdrill with ksft"):
> 
>     Tested:
>             make -C tools/testing/selftests \
>               TARGETS=net/packetdrill \
>               run_tests
>     
>             make -C tools/testing/selftests \
>               TARGETS=net/packetdrill \
>               install INSTALL_PATH=$KSFT_INSTALL_PATH
>     
>             # in virtme-ng
>             ./run_kselftest.sh -c net/packetdrill
>             ./run_kselftest.sh -t net/packetdrill:tcp_inq_client.pkt

Thanks, after debugging, I found the fedora packetdrill using cmake to
build, which cause the all the test failed. After using glibc-static to
build the packetdrill, all the test passed.

Although I'm not sure why cmake does not work.

Thanks
Hangbin

