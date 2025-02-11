Return-Path: <netdev+bounces-165046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F012EA302F8
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 06:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E05E188B4A1
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 05:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F051E571B;
	Tue, 11 Feb 2025 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="giKA0Z+c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5E81E500C
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 05:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739252622; cv=none; b=ErgAXwC4mKR53ncgFqstxFbRlqkn7SPYexBBAE/qG0xnlq+WDNglycXBm2sFcYL2tnkQ1GXLMkKxmSbuFiCCccr7n6wydwNf4SOeoFq4/Kl1GRC1FAxcZ7htnciJpiE2YEdr/eCwmwPSkiSQJm2b879Vy+V3VKHQFvuIxGyiNtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739252622; c=relaxed/simple;
	bh=yiutF29gJafdhIkoJFYAc9y4gay9BN34SrcFu5zNZuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3LyRIn67+CAFveDn20IpR8CAithsEq92CGFYhCJogo/SYjhxD6SFE9mYlfNA3CJiyR0XmcWrPu5cBeY+PBo3cBS+mmR+0WIM+dK6Xsc3HAKlvjdFrdEEDVsEmnWQnb+skRWluQeK8Ii8rE+idVyAHI6pBxgUoH0PQ8WZtthPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=giKA0Z+c; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-471836d9c05so51cf.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 21:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739252620; x=1739857420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvPUz/tKMvoI4V8mQFLMl7NVNOQxnWrC6+o5gP+Aun4=;
        b=giKA0Z+cSWBx/0zURPAyC5USWyiKNT4/tZZGr0Sq9KXKX5F1ZhQJjccoWb73tiQ0n/
         fKkLcuUJPejL8SvB2aNBf5PwQM0dXgllqlyoSXX0/gwVsFA8SQU9NOCIUMSv88CUhAN0
         8g0JUdyoLVonAanr9RTAGvGochFKDl9ZtSPnAaj4i7spJlB6S71JstBnsGQ7+TgnmXTv
         k/Iz9tVWy7w4O2tBILIXeMsSb8zhX6PTgjTjC9A4Q/N9jC9xi4Mg/9uT/aijh18i4aSk
         0kGvOH/iyBr33M2ylf9FNsE0uUW6WDBRN6seVei0GOIVCbOOz4n+0a1zFY7EHkmeweL5
         nHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739252620; x=1739857420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvPUz/tKMvoI4V8mQFLMl7NVNOQxnWrC6+o5gP+Aun4=;
        b=lwFw7PUTvzhpF5WIe3sAKgbajyCKWRzsISh5nSDzPUOSIQT1IWVNjUjtAlxVeccwlr
         Kkz/LogAVPnoJntPNFPOASoxkhGUfht+r1dpxBLtMXoauUJkXZnmnbdIERw0tF4Z5FwT
         Vx9fAagsV+kAifo8UrYvzxoStoOSaDqPouS8Dnkv5UTC7tCWswVF2WP9ECDqaDueKTXL
         Y8JkWxjVjGsSCuwqs1pt4U06b0/ItzhAkj4er2q/PCjbBuR3SwZppRipJnqPwcj5g/nB
         O9sDGXh3AyP0ZM8pTWHth3TUryJWM3tMXzKP0SjBApijY46tuQ3kZ7//jAtdrA0zTJ75
         D9pg==
X-Forwarded-Encrypted: i=1; AJvYcCUpVy5GybWjURHmJV2JJ6aYthCx5NdLKSpf+ajm8i3DUbGRIIU0gCbOTml/Pyg59lAR8KKJ7ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOtF8kPQH+5gtSR94OF9BP1Im8cnTs5gXenxhtjC48ChLjGCTW
	vPWejj5lqQNDDPVxZCrsG04yyXJ/fkLc/GR4it8q8yVcPHw9wDlKg2F8M/jja3uJiNLssi3bW3t
	+dxd1zHb8EnTRbV//5K2j6G1Xbg/g6QF7urw3
X-Gm-Gg: ASbGnctwR83ipXbxxgBmdMg4OxfWIudKGmUIucwiG0UTv25smn2Z1eHMGNBQLsEBYnN
	z69KaMKOQ1ddyx+I/kQaoaxGmR2OxYJIQTMyPhtsclvjhd/Lrf2cT7Bwzhb5HDU0TaL5D54jZ30
	I=
X-Google-Smtp-Source: AGHT+IFdPC2jxNjIQ60tB1qHYw35wQPcR+ebUuPbTINTbB3BgR5ZvL+qydjb39WrysC4U8S2UIzDA8MJwdVbCXOxWXU=
X-Received: by 2002:ac8:66c6:0:b0:46e:3537:f21e with SMTP id
 d75a77b69052e-471a910d664mr4321cf.2.1739252619289; Mon, 10 Feb 2025 21:43:39
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207110836.2407224-1-yuyanghuang@google.com>
 <20250207110836.2407224-2-yuyanghuang@google.com> <20250210161306.GE554665@kernel.org>
In-Reply-To: <20250210161306.GE554665@kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Mon, 10 Feb 2025 21:43:03 -0800
X-Gm-Features: AWEUYZkxPTkcoZEBe3_5sAnOnmrjICkKYhcLeSxWg-C3j3ZJ3rn8M2ow9fKXuiY
Message-ID: <CADXeF1GP24uJNYBPjjegs=sycUa1d=cVacvchKdAk5+p=ZOj8w@mail.gmail.com>
Subject: Re: [PATCH net-next, v8 2/2] selftests/net: Add selftest for IPv4
 RTM_GETMULTICAST support
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Hangbin Liu <liuhangbin@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, petrm@nvidia.com, 
	linux-kselftest@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>FWIIW I think that the YAML spec entry is distinct from, although a
>dependency of, adding the test. I would put it in a separate patch.

Thanks for the feedback! I will split the change into two patches in
the next submission.

Thanks,

Yuyang


On Mon, Feb 10, 2025 at 8:13=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Feb 07, 2025 at 08:08:36PM +0900, Yuyang Huang wrote:
> > This change introduces a new selftest case to verify the functionality
> > of dumping IPv4 multicast addresses using the RTM_GETMULTICAST netlink
> > message. The test utilizes the ynl library to interact with the
> > netlink interface and validate that the kernel correctly reports the
> > joined IPv4 multicast addresses.
> >
> > To run the test, execute the following command:
> >
> > $ vng -v --user root --cpus 16 -- \
> >     make -C tools/testing/selftests TARGETS=3Dnet \
> >     TEST_PROGS=3Drtnetlink.py TEST_GEN_PROGS=3D"" run_tests
> >
> > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > Cc: Lorenzo Colitti <lorenzo@google.com>
> > Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> > ---
> >
> > Changelog since v7:
> > - Create a new RtnlAddrFamily to load rt_addr.yaml.
> >
> > Changelog since v6:
> > - Move `getmaddrs` definition to rt_addr.yaml.
> >
> >  Documentation/netlink/specs/rt_addr.yaml      | 23 ++++++++++++++
>
> Hi Yuyang Huang,
>
> FWIIW I think that the YAML spec entry is distinct from, although a
> dependency of, adding the test. I would put it in a separate patch.
>
> >  tools/testing/selftests/net/Makefile          |  1 +
> >  .../testing/selftests/net/lib/py/__init__.py  |  2 +-
> >  tools/testing/selftests/net/lib/py/ynl.py     |  4 +++
> >  tools/testing/selftests/net/rtnetlink.py      | 30 +++++++++++++++++++
> >  5 files changed, 59 insertions(+), 1 deletion(-)
> >  create mode 100755 tools/testing/selftests/net/rtnetlink.py
>
> ...

