Return-Path: <netdev+bounces-112921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E4993BDB3
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 10:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26AD81C21C1F
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 08:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B32416DEC4;
	Thu, 25 Jul 2024 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pfS8JL2Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587D2172763
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894859; cv=none; b=VwxJ/cwFKY4uXzw4hY7R+Wv0lKuyE1IbFH6aMmjXP7YtEqIWgnctB+eU6EQwYaK/OqwVSziiwYFpOTBLDyX2xBSvY45bHIPx2qqg0D7iDrC/IcIzyRQBlDIZ788BXZDpjfd0saXpB/sCRfpkaODzO7uqOlGhho3EjCaiMSPmnOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894859; c=relaxed/simple;
	bh=r+M3o6SVfTD1vC9T28BpdhS5PBq7BQ34eYtryUx0Hug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSgU3sWsxsrhIJEJ9lChbXamY1eUSCXskTifU62ymf94PY7e5oC3wN/++0oIyTJUrzB8R3d2gYzUaV7GWxxcrFv7SddyVxqJkKBADD7gJko9ufbw8AUe7e8HDXcSLAla/Yx54RNZeJelJHsp7X9D1+j7tiEcFsAa/D3VttYXXBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pfS8JL2Z; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so7612a12.1
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 01:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721894856; x=1722499656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIQkCLUKnLONxhUVH4Hgod3J1H1l8mUYWFUy/48yoHk=;
        b=pfS8JL2ZPlLyJV5nglmj8azFy5FfgUOC0YyhWnMZ4zWoLT5NmivTGQvn/csnZutggF
         laNvy8WXY6Sw2kUF0ikg+LD10EteYOO4zB69VUB1Jo8B8MZxLwFteGIly5Fbumn23bxL
         tZ76dKHprGpKVaoRVb1YSe1odB+kMfxrGC+8+4jMBxFQdR0OQXoWyJcYrIhb3gPed2U4
         SDSTy8NbnmyL3QjZCfqFs0w0MdHsvtmBO+zS8y96PDhM/tsv+hhOfBKEDuw9j43WX/7S
         DwSOuwlW/WXZMnpKqFuzoEYS8CKlmdHDfum3lpFMWHT+EQ6iYMKdsGkcvhIcOTU8fo27
         Lgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721894856; x=1722499656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIQkCLUKnLONxhUVH4Hgod3J1H1l8mUYWFUy/48yoHk=;
        b=hCatB723X6H8476lgQ37Mo19BdMoAVcrVG8rxI/nLN6aLgrMEZmNi1uqeLzlNE3jHW
         TgisdhIbjvV205VPog0MNl0T5Q/Bl4uAypbzb+1tAEmhYKeagEiSdILTqTbuG1CCNAGR
         HwCg2feD7xlFkKIDdRPiH3vh7d71cFukpIjl7Z5sk4TDafTkEYEmEmNjIVAMJWdVeV7M
         +sWR1ZE9TDaVXldiI+RyM7nVFa9Dn6GVhQ+xCVVogaeXgsizNdPOST+q1ARWKLcT60/G
         4lqfeAAYRF+5QVme0TCtz2J1eyVc1E3lw6Dv1afNx/ZScnOldZQwSGjeL2SLQHi7D3w4
         jCeg==
X-Forwarded-Encrypted: i=1; AJvYcCXlI0faZM+tvBAmtOowvAM/jcWIeUmrZsSRNuysVB1lmM9c593uHYF+PwiZkhj0AsR87tmasxbu5ii9DfNRur6M8nd2F02M
X-Gm-Message-State: AOJu0YwHiEl6073FODmYFXK6obYvxRxrNR4dQ+KqwKSCq+dv0LCbT1e0
	7waYY9RPwBz6S3K3fcocOvre35fSLJGRkXl6tH6Ftd3TJeL5H+vpf1JplrdBkgN4aNDHy7DPphZ
	kE8Y39iG31M854+XCOw77kz3dYf6eJFaL/x9C
X-Google-Smtp-Source: AGHT+IHl0LhuIwDpRoXa6gfrudcKM9vX8uhEq/AZ3MBhrUx8F2WnDsHvrrDN5URTN7HjWmm6RbPaMKgp4O++3+UyhG0=
X-Received: by 2002:a05:6402:2709:b0:5ac:4ce3:8f6a with SMTP id
 4fb4d7f45d1cf-5ac4ce391edmr123068a12.6.1721894855222; Thu, 25 Jul 2024
 01:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407251053.618edf56-oliver.sang@intel.com>
In-Reply-To: <202407251053.618edf56-oliver.sang@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jul 2024 10:07:21 +0200
Message-ID: <CANn89i+Bia9PdGhAVfRbbubYo37+g+ej68qp32JmU88tsLLuRQ@mail.gmail.com>
Subject: Re: [linus:master] [tcp] 23e89e8ee7: packetdrill.packetdrill/gtests/net/tcp/fastopen/client/simultaneous-fast-open_ipv4-mapped-v6.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 6:55=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "packetdrill.packetdrill/gtests/net/tcp/fastope=
n/client/simultaneous-fast-open_ipv4-mapped-v6.fail" on:
>
> commit: 23e89e8ee7be73e21200947885a6d3a109a2c58d ("tcp: Don't drop SYN+AC=
K for simultaneous connect().")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [test failed on linus/master      68b59730459e5d1fe4e0bbeb04ceb9df0f00227=
0]
> [test failed on linux-next/master 73399b58e5e5a1b28a04baf42e321cfcfc663c2=
f]
>
> in testcase: packetdrill
> version: packetdrill-x86_64-31fbbb7-1_20240226
> with following parameters:
>
>
> compiler: gcc-13
> test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz=
 (Coffee Lake) with 32G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> we also noticed other failed cases that can pass on parent.
>
>
> 42ffe242860c401c 23e89e8ee7be73e21200947885a
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/client/simultaneous-fast-open_ipv4-mapped-v6.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/client/simultaneous-fast-open_ipv4.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/client/simultaneous-fast-open_ipv6.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/server/basic-cookie-not-reqd_ipv4-mapped-v6.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/server/basic-cookie-not-reqd_ipv4.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/server/basic-zero-payload_ipv4-mapped-v6.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/server/basic-zero-payload_ipv4.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/server/opt34/basic-cookie-not-reqd_ipv4-mapped-v6.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/server/opt34/basic-cookie-not-reqd_ipv4.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/server/opt34/basic-zero-payload_ipv4-mapped-v6.fail
>            :9           67%           6:6     packetdrill.packetdrill/gte=
sts/net/tcp/fastopen/server/opt34/basic-zero-payload_ipv4.fail
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202407251053.618edf56-oliver.san=
g@intel.com
>
>
>
> FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/fastopen/client/simultan=
eous-fast-open.pkt (ipv6)]
>
> ...
>
> FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/fastopen/client/simultan=
eous-fast-open.pkt (ipv4)]
>
> ...
>
> FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/fastopen/client/simultan=
eous-fast-open.pkt (ipv4-mapped-v6)]
>
> ...
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240725/202407251053.618edf56-ol=
iver.sang@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

This has been discussed recently in netdev mailing list, one ACK will
get more precise information.

