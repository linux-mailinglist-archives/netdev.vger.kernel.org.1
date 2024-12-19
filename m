Return-Path: <netdev+bounces-153436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F319F7F28
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58678189089E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45555228C84;
	Thu, 19 Dec 2024 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uf8qxjFM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CF92288E3
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734624842; cv=none; b=B0CUy53sRKw16mxS+Uyb7HWjGcnfv+AXhFKA18GgPJaJue22MoCs9gxLog28e+0w8rxPK185Y4cHdBqTI0oKOBK9+2rV6UHS9qeaHuUxCt86Uw0Pgi5FCYX1XtzAcPiJ/22RPqUb4olQzDugPtdRp3uKRyT2Clysazo0yNY/lzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734624842; c=relaxed/simple;
	bh=Ao1M9tsAYMe/J2ewOjf8yqlnleUiHC7z6nKS8hyU3vM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EL0JuwKzBlb3soPShzJLgLHqMycQNbwnqP8hzZQ5eUWDpqxaSwXyN9VeC0tdQ6xv3id+dwcBnAT56TWdwLJJnm/T5TGsbr5H07I8O5WzHpGjRAytMJFEYMzPfs6d+WbufJP/uGSqIJVOZVdtNMaANMcci06D6wId2njPHN8KinI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uf8qxjFM; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a818cd5dcbso305ab.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 08:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734624840; x=1735229640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao1M9tsAYMe/J2ewOjf8yqlnleUiHC7z6nKS8hyU3vM=;
        b=uf8qxjFMztS1QpTY0ZpD4O+sITLcetjkJj/9GnUOb1wemJMTQ54CqhoKXZXUCNbdxl
         c6SyVDxb372MTXhB4jdY15HzvJhgAI+vKftVPhdn9coOqTciSbwTbGyrmO20Q2gExDIo
         EGHf+mUcbtWxo1SNx5BVbjti1rc/HMPwZON6VdDuK8Zt7FAEgLt1dAtnCTNKtUP0LYcS
         X5OTZ8m8QW6g37vwcyiRLeyWm4h+BEzrWU+3oOenIAetoaNMYbax4PA4GPWRqW00gVY1
         C/He29kv0NbPrpRePxOB2gTXwu+Ly3InQ4y3ok6gKz3ZTInDhZ9+wn8kuIBxNVdcp2w9
         Z4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734624840; x=1735229640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ao1M9tsAYMe/J2ewOjf8yqlnleUiHC7z6nKS8hyU3vM=;
        b=r8lsglX8RQjJHtCSpk0BCJxKh7P7+WTKkRaL7DwXgXDfPbu+XCZ+lUTIlhH2vxy/H9
         mhcCmPV8KbmVBSDjkV1ftwgssrrQX5bCi9WKAcA2oKb1TONPXjMi60a0bucxxv/045Hn
         rfvX/d1uBDXTrvPfUIPuxp2VSMedMqIK2KjCQWAUMGgDJez4He7ZlBCfW2OgFNP9Xq76
         rur8mnaDJyz/mNuezVCQ/9234LOjLVRrNPtBkueg/iQxfAHl2hnmLPceZ7cJmT+SRVMl
         hOlBEw7UeeoAD0mBvs+K5FvvcBBwXDswPcd1XyaV6rhaEkDKmMHtbXVwjNjujAxemIGD
         tWqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNQzE9pdZXZpslKDIiJCYsw2NkLxHwRXYtM0FAOdSrAwpYByacWiztwTmxZWgdjrKV+lGbSU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6EQgkiLX9KAm7yKIR7d1cLyfMqXKGgtFAfdYn6OU98ydaxKKs
	EJgxXSdnJfNUH5nC9WTNKQknVw4dBiLQydErvQxl2sRh2LMdp5c5i8KtSzws16V/VJUy2Ha125j
	Q2PatYj5RqAdsGEUG2CBx6vqebFNuvti5YbsC
X-Gm-Gg: ASbGncvRA1FSdkUKGHqkOHixbdt9jLrTFmDNbPhjNHs43k/c5a9rhTZ1bbThoLnf+OC
	5+gJJqVjGYFavGAgAZiWYTpLvuWxAoY5mwhk+CnIOocAmO5ilfVtGRKy5XW4/rc+L9LhRlHE=
X-Google-Smtp-Source: AGHT+IH/DVNRKjvM8vgJxbGcE+1BQG6yAxpuOxGzyRKMPwP1oPkyCthNQVlsBED8laj9mGC+2zZKYAazjvoVkIbUbtI=
X-Received: by 2002:a92:c26d:0:b0:3a7:d682:36f6 with SMTP id
 e9e14a558f8ab-3c24cbd5995mr129695ab.0.1734624839207; Thu, 19 Dec 2024
 08:13:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219132644.725161-1-yuyanghuang@google.com>
 <CANn89iKcVDM-na-kF+o3octj16K-8ZRLFZvShTR_rLAKb-CSoA@mail.gmail.com>
 <CANn89i+SMrCH1XqL8Q9-rr7k2bez1DNqeQNhO0rBrrHiyOrFXw@mail.gmail.com>
 <CADXeF1Gg7H+e+47KihOTMdSg=KXXe=eirHD01=VbAM5Dvqz1uw@mail.gmail.com>
 <CADXeF1GvpMOyTHOYaE5v6w+4jpBKjnT=he3qNpehghRWY+hNHQ@mail.gmail.com>
 <CADXeF1E16ffcJ2tsYDHWr5OX=9B9u0_t3QoKus=RnuQw_e_0EQ@mail.gmail.com> <CANn89iJEz=HWXN9fV4iLX6uGumBuOvcup6pEJvPWs3efy4=4OA@mail.gmail.com>
In-Reply-To: <CANn89iJEz=HWXN9fV4iLX6uGumBuOvcup6pEJvPWs3efy4=4OA@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 20 Dec 2024 01:13:21 +0900
X-Gm-Features: AbW1kvbuIRYKCj1K9XHi90nKy9fd7ykqu9gmDzYrBLB8E2BAQzO9lVfVgJgS7iM
Message-ID: <CADXeF1FVRY4t7L-J16FDu_6SvuvU3_jKJQo3+kFyDR7s_92kAg@mail.gmail.com>
Subject: Re: [PATCH net-next] netlink: correct nlmsg size for multicast notifications
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, pruddy@vyatta.att-mail.com, 
	netdev@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you very much for the detailed explanation.

I will change GFP_ATOMIC to GFP_KERNEL in the v2 patch.

Thanks,
Yuyang

On Fri, Dec 20, 2024 at 12:53=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Dec 19, 2024 at 4:35=E2=80=AFPM Yuyang Huang <yuyanghuang@google.=
com> wrote:
> >
> > >Same remark for inet_ifmcaddr_notify()
> >
> > Moreover, for both IPv4 and IPv6, when a device is up, the kernel
> > joins the all-hosts multicast addresses (224.0.0.1/ff02::1). I guess
> > this logic also does not run in process context?
> >
>
> Hopefully all these paths are stressed in kselftest.
>
> A wrong gfp would trigger issues when you run the selftests before
> submission, or in netdev CI.

