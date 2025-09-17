Return-Path: <netdev+bounces-223873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E04B7F9F7
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A08166AC1
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 07:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C422BD020;
	Wed, 17 Sep 2025 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KD8gUSuL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52EF299928
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092622; cv=none; b=P3zSz7sEdcr9/OyYfySR/XzS7ozLowKDeSrmde1wtiBfwVwxlH6elW+6+/MNyS5SFCOy+p7UDRtYgtheAAzUT7Afe9YuFroaRHoXuJxd3Jk/omtSoKe0R10HYLBuYsxqmKSywd+0aLEmJT7cTkU0Cr+gsY1hXHgktm6YIDdM68M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092622; c=relaxed/simple;
	bh=ZtJdwHsCQacx7vT+1PGPgg7gCIp7k++eP+19pc8gOjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpdJoU2aDP5w6bFN1JAhvNYpKgxb9p0Nbemx3ikNBiKGJzsIUBoG8ZHYv32W7sXbGBzTP6qx+2ZIuEQt2CAGiqtmobdmIvdmQAl3w5EpvCtFABJp84Szysp1JudleaI1gJdFiJjVb9s1ncGdFTctsoPOuOaZekF3YKyMVbnkQ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KD8gUSuL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2677a4d4ce3so29147355ad.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758092620; x=1758697420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5J1YBD35YzME4fUnRREYzYzV7J9Xh5Amzs6Qryaeq1c=;
        b=KD8gUSuLGPKG+5n+5D2HmmxLUtFVSP9gGkup4+V4M7+X12wp+ZmZHfWTjWJdSmXwn/
         qLH1degeEoxNghZKQ3lTdfBkLkvPUILGbzggbMV2FJ0GFJqbvRUd3jVTDWDIb82hQdTu
         XFKMSRz3A5kxWxTZ9eiuDNkt6D8W1qlfCLVftfrN1d283mYDDTTpj6PPE49KtwZN3aVa
         J7Z0ba/BiTrp5zrj4Jo6/lVFx8INKePcZzSFHNP9CFNKUEzszyArUa2p0FbT5DrQ7TPI
         I0bYVlEmkLC7PSnVEZM9udm9JC8roNnvjrfOwoeJu5HSgjeBuG5/WkN9tvZnfluLEXvI
         pOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758092620; x=1758697420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5J1YBD35YzME4fUnRREYzYzV7J9Xh5Amzs6Qryaeq1c=;
        b=p1AUblYwAJUtROvK2PuwegPhQ7I+YVlARAhOldbk0sCSmz8OEhoAAuwUzP1psUIxpE
         yveXsAh2TpwFEQUHxMQoOcCLEozlyQiHV+ZkBN553U/QDFRglCW7L4AKBVWhmylx/BTg
         wiMJH4uYwBukt2CjppAhEHKhx6E1fs0rCpj7Fg+15Rz5IuCCJFrBTiz+tIXFIa0s8R8w
         CNL0G+4o//VcgJG/zNG7RPLIudN52IYKHyxe7qfGU6eSzsjBa/N7kCT4ZcHb8EalsC1M
         KqRHhqD5cYEZnXmbPUgKhaqzuJulsC9xcEZt6Al/p8+D245DUJmqOmwmD6EC1s1IIDDO
         7MTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmEqMnb/AkxRrnvwIdogoeGaiBSATw5qQ4vzaVaIUdTVrH9mg/atwZwKqUxnLyaAcUrG3JdCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqv1Mw0DGrkN/lrd6ZNxdEmQp1Ee0WQShHU8nk3plKQoBh8XAe
	PBb4dkV9JiOMLM7Tx6m+qhbSwIHtVEM/LTW+swtniHms/UjxlPl1KNkiRdUVCsDYF9FtpTEjYDp
	oru+qaOy0rhgCw/yf0Qq0lqCDCsb+oiKjxydWJvfh
X-Gm-Gg: ASbGncuALdk3YcGNvGsOM9CQNurEVdSYyWjq6/qNaz7rOe35lJxHJdFVqcv/kSClmkz
	c/sc3UYw69GRI9oelDQnslqVr3yR8ROi2jyoMn2nNondSNwwL2QMBJr49vVc3KxmcPx6Kg3P8Lf
	4mtr+fgZLRsvg3IuuVAZkFDPEKdh8pDnlQxb3hUCUjz7XC+HfJOU+CHfrphdxgdvP6AJxv8WwBT
	ZUJ33oxbp+bcx3/iYUmIsqvM1pdJsJyRMvcq0y3YywWlEUwffzTu3x8H0Oe+WDK7jE=
X-Google-Smtp-Source: AGHT+IFHqqSb0iZeLJZY85eRucnrDK2myNCsnrye3aGyc3jn1Chr0LEkdru+rbzxnAqB29LvtQoRAz7rfDOuHcs9NJY=
X-Received: by 2002:a17:902:dac4:b0:248:f84f:fd3c with SMTP id
 d9443c01a7336-26812166d0cmr13573895ad.13.1758092619855; Wed, 17 Sep 2025
 00:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910192057.1045711-2-kuniyu@google.com> <202509171359.658ddb38-lkp@intel.com>
In-Reply-To: <202509171359.658ddb38-lkp@intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 17 Sep 2025 00:03:28 -0700
X-Gm-Features: AS18NWCDLFhRi5V-YAZb1sP659_dYtJBp3pw_GvlN50RKdZinoKi4N8ZdQCAG4E
Message-ID: <CAAVpQUBZT4dX9hU8h6s8ew5BYX9C6yBPaRODP4zM3F-=BB4Dtw@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next/net 1/6] tcp: Save lock_sock() for memcg in inet_csk_accept().
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Shakeel Butt <shakeel.butt@linux.dev>, netdev@vger.kernel.org, ltp@lists.linux.it, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:37=E2=80=AFPM kernel test robot
<oliver.sang@intel.com> wrote:
>
>
> Hello,
>
> kernel test robot noticed "BUG:KASAN:slab-out-of-bounds_in__inet_accept" =
on:
>
> commit: d465aa09942825d93a377c3715c464e8f6827f13 ("[PATCH v8 bpf-next/net=
 1/6] tcp: Save lock_sock() for memcg in inet_csk_accept().")
> url: https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/tcp=
-Save-lock_sock-for-memcg-in-inet_csk_accept/20250911-032312
> base: https://git.kernel.org/cgit/linux/kernel/git/bpf/bpf-next.git net
> patch link: https://lore.kernel.org/all/20250910192057.1045711-2-kuniyu@g=
oogle.com/
> patch subject: [PATCH v8 bpf-next/net 1/6] tcp: Save lock_sock() for memc=
g in inet_csk_accept().
>
> in testcase: ltp
> version: ltp-x86_64-c6660a3e0-1_20250913
> with following parameters:
>
>         test: net.features
>
>
>
> config: x86_64-rhel-9.4-ltp
> compiler: gcc-14
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4790T CPU @ 2.70GH=
z (Haswell) with 16G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202509171359.658ddb38-lkp@intel.=
com
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250917/202509171359.658ddb38-lk=
p@intel.com
>
>
> we saw a lot of "BUG:KASAN:slab-out-of-bounds_in__inet_accept" issue in d=
mesg
> uploaded to above link, below is just one example:
>
>
> [  468.984291][T30180] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  468.992753][T30180] BUG: KASAN: slab-out-of-bounds in __inet_accept+0x=
5c6/0x640

Oh I misused sk_is_mptcp() which assumes that sk_is_tcp()
is always true and should not be used if sk_is_tcp() is false for
SCTP, so sk_is_mptcp() test was unnecessary

I'll remove it, thanks!

