Return-Path: <netdev+bounces-224403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C7FB84560
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8FC17A9E3
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C391D28313A;
	Thu, 18 Sep 2025 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Chqizf9s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF3754764
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194673; cv=none; b=YCevvfUuYpX3dqMKsp/Hl2vLrRL5DOfuBLMIMUUkjQngs5xluGL8TltRWZyoeAEtDcps0cLGZXl4H5ceZS7vuKQK/ciiPUXySpveew058l7lhQjAjU2JMWOcd5i9uhYhPK1d6ufqkNxXgB5BNUQ7wZJaQtnn/0nJSxwfVOAcPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194673; c=relaxed/simple;
	bh=l6i0LlO6/QzJt4X7K6PlTpFPkX26n+eZ39UJBqL+MiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfwDHUfG8Crtry95RHGF66AnL8GrWoB8eWFQAgMemeEX+RK2cVe3WYK4cuNiPWFjl2HAiV/c5eMYW6tBaNIjxhs3Y+gtHJujAjLA9wJGvrORb04MCw/ouVQ0E3fiPGI/QYZbUDQiDDI7nTSPif+i+FHvSe4o5AUePO9Mjp/UrhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Chqizf9s; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b5e88d9994so10223661cf.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758194671; x=1758799471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMOyjC+33kkXSLahahIjAH9W+UnhdArEEIl4cMkBYMs=;
        b=Chqizf9sM9Ibmf0J8i6RpKAAAgRO6qyS490CBvVFlMRdk5kPDdk35SMw0QuHh40QQB
         Uk4NFS1nHqGCbKt3DKUdD9FQYhwyaLGLOfihygpMO6GQMWzofaR9KnT7kDK9X4puX79U
         AQf8g0VmsLCfDqXqOjQb30mcOPTy2s1gLL+wHfCS9IliDSWFD/ubNTvFaZ1EqO9q5unZ
         LZ6cVpli+4hrj2HB0gJexEGasP8SuzBn8Jb3OQ8q2NUuIbb57i+AmJJeeFDPC5Ldgybu
         RlRHBRQe7CDmp7HX3phzAU8dVYxkyazWv6LyCsFDojTL/PzsWrJsnh9Rj/kioGW+65bx
         tiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758194671; x=1758799471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMOyjC+33kkXSLahahIjAH9W+UnhdArEEIl4cMkBYMs=;
        b=ik1Pdv6+OyU/gLgQDgRIzzQ+kjRTpYGM4dci248CbrQpK/NmEgpF2vkcn5Pcsi6DHW
         wBA0zwouYoNjKduqF9D/54wz0RaA0mOjaTNMde5jqsYTFN8VhRGmJ/+7TCA2OrqeJvu5
         I8GjRXhMs8DqY+FOXFPgCN2K5c//KE83noYoDsdDN3kR2IrB4jjfSV3FhWufZ0vrSPyR
         dbNlBfsknAOzdldB9Df81fcBhmvjT2Rz+WAkJ6uIT3gBXefzaY0hzuqKfGIQktgT4v92
         RAD/nfkBO5dMoOOR7RdMum12vKo8i86s6Y32LxdciXbfmF8SfxxhTUqBCwFH/APlUwkW
         wAhA==
X-Forwarded-Encrypted: i=1; AJvYcCWAQnnWFXEMUS17LXH7ZswodvYKl5bI8AneET8FAFFFtAyIWvL5mSP6XckiHlAMpiFk0bIkjG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD4Odg7ZWy6bFmCcSKfYtlsC5pquZmUN7fe13MaUnK6MEDrbAD
	fB7G7Q36wKQu0QfrxA23mqPOS1dWxbswe/ExUldUpm5s1MW/gHX0Bu9gUU0Cc8l3xQl64DZ+jCb
	PExvxFGJKkNpYpDbYfKgTC4RY2mRQx5uEdmYlUUrh
X-Gm-Gg: ASbGnctK/iTJJPwc0nIyxnrO7DBnFbG0RzuWXsIMijgayWFJ0cfGORfMpeKd/L9YjpC
	Cd5qORjxnGLLmdE7He0Wodo7vJAe+BfqAIYeTFtetxGvTbo4iDAHiRdWJSocZsl+EjwdvXv+SSA
	g6ICzA9WcAXnBFPd0xqOWuiGhS9X4aFPMVQ7j5I/ToUEWZKqn2a4CiZPSV0Jpc9JCHQMC0w5dGl
	qRNA2BGnuz4MU8k6tPYBc6Z5wYhrUqo
X-Google-Smtp-Source: AGHT+IGzrmvJkoFznn3r0cppa9BZ50pNmPe1OCUrwQf0Iadjr5XvvpPMuqujO/T94oIaYK21N6wKcqn+9hHpYWgJZpw=
X-Received: by 2002:a05:622a:116:b0:4b6:3109:24ce with SMTP id
 d75a77b69052e-4ba6ae9aef6mr69866401cf.38.1758194670302; Thu, 18 Sep 2025
 04:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917000954.859376-1-daniel.zahka@gmail.com>
 <175819262850.2365733.8295832390159298825.git-patchwork-notify@kernel.org>
 <CANn89i+ZdBDEV6TE=Nw5gn9ycTzWw4mZOpPuCswgwEsrgOyNnw@mail.gmail.com> <CANn89iJ5+y2PzyMzvRnEqTBW8NgBVDCHA6C7O7VB-pPwqZQS=g@mail.gmail.com>
In-Reply-To: <CANn89iJ5+y2PzyMzvRnEqTBW8NgBVDCHA6C7O7VB-pPwqZQS=g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Sep 2025 04:24:19 -0700
X-Gm-Features: AS18NWARObCMP4wBMBKj4t4aL9P-EjogrmexglhIxH_BXYAiejGcEu1F8YbTrjA
Message-ID: <CANn89i+Kqm_jXM4W=ygC08HstWnjnctJYWF+WK+z6f0ZoFLNMg@mail.gmail.com>
Subject: Re: [PATCH net-next v13 00/19] add basic PSP encryption for TCP connections
To: patchwork-bot+netdevbpf@kernel.org
Cc: Daniel Zahka <daniel.zahka@gmail.com>, donald.hunter@gmail.com, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, 
	andrew+netdev@lunn.ch, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	borisp@nvidia.com, kuniyu@google.com, willemb@google.com, dsahern@kernel.org, 
	ncardwell@google.com, phaddad@nvidia.com, raeds@nvidia.com, 
	jianbol@nvidia.com, dtatulea@nvidia.com, rrameshbabu@nvidia.com, 
	sdf@fomichev.me, toke@redhat.com, aleksander.lobakin@intel.com, 
	kiran.kella@broadcom.com, jacob.e.keller@intel.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 4:02=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Sep 18, 2025 at 4:00=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Sep 18, 2025 at 3:50=E2=80=AFAM <patchwork-bot+netdevbpf@kernel=
.org> wrote:
> > >
> > > Hello:
> > >
> > > This series was applied to netdev/net-next.git (main)
> > > by Paolo Abeni <pabeni@redhat.com>:
> > >
> > > On Tue, 16 Sep 2025 17:09:27 -0700 you wrote:
> > > > This is v13 of the PSP RFC [1] posted by Jakub Kicinski one year
> > > > ago. General developments since v1 include a fork of packetdrill [2=
]
> > > > with support for PSP added, as well as some test cases, and an
> > > > implementation of PSP key exchange and connection upgrade [3]
> > > > integrated into the fbthrift RPC library. Both [2] and [3] have bee=
n
> > > > tested on server platforms with PSP-capable CX7 NICs. Below is the
> > > > cover letter from the original RFC:
> > > >
> > > > [...]
> > >
> > > Here is the summary with links:
> > >   - [net-next,v13,01/19] psp: add documentation
> > >     https://git.kernel.org/netdev/net-next/c/a9266275fd7b
> > >   - [net-next,v13,02/19] psp: base PSP device support
> > >     https://git.kernel.org/netdev/net-next/c/00c94ca2b99e
> > >   - [net-next,v13,03/19] net: modify core data structures for PSP dat=
apath support
> > >     https://git.kernel.org/netdev/net-next/c/ed8a507b7483
> > >   - [net-next,v13,04/19] tcp: add datapath logic for PSP with inline =
key exchange
> > >     https://git.kernel.org/netdev/net-next/c/659a2899a57d
> > >   - [net-next,v13,05/19] psp: add op for rotation of device key
> > >     https://git.kernel.org/netdev/net-next/c/117f02a49b77
> > >   - [net-next,v13,06/19] net: move sk_validate_xmit_skb() to net/core=
/dev.c
> > >     https://git.kernel.org/netdev/net-next/c/8c511c1df380
> > >   - [net-next,v13,07/19] net: tcp: allow tcp_timewait_sock to validat=
e skbs before handing to device
> > >     https://git.kernel.org/netdev/net-next/c/0917bb139eed
> > >   - [net-next,v13,08/19] net: psp: add socket security association co=
de
> > >     https://git.kernel.org/netdev/net-next/c/6b46ca260e22
> > >   - [net-next,v13,09/19] net: psp: update the TCP MSS to reflect PSP =
packet overhead
> > >     https://git.kernel.org/netdev/net-next/c/e97269257fe4
> > >   - [net-next,v13,10/19] psp: track generations of device key
> > >     https://git.kernel.org/netdev/net-next/c/e78851058b35
> > >   - [net-next,v13,11/19] net/mlx5e: Support PSP offload functionality
> > >     https://git.kernel.org/netdev/net-next/c/89ee2d92f66c
> > >   - [net-next,v13,12/19] net/mlx5e: Implement PSP operations .assoc_a=
dd and .assoc_del
> > >     https://git.kernel.org/netdev/net-next/c/af2196f49480
> > >   - [net-next,v13,13/19] psp: provide encapsulation helper for driver=
s
> > >     https://git.kernel.org/netdev/net-next/c/fc724515741a
> > >   - [net-next,v13,14/19] net/mlx5e: Implement PSP Tx data path
> > >     https://git.kernel.org/netdev/net-next/c/e5a1861a298e
> > >   - [net-next,v13,15/19] net/mlx5e: Add PSP steering in local NIC RX
> > >     https://git.kernel.org/netdev/net-next/c/9536fbe10c9d
> > >   - [net-next,v13,16/19] net/mlx5e: Configure PSP Rx flow steering ru=
les
> > >     https://git.kernel.org/netdev/net-next/c/2b6e450bfde7
> > >   - [net-next,v13,17/19] psp: provide decapsulation and receive helpe=
r for drivers
> > >     https://git.kernel.org/netdev/net-next/c/0eddb8023cee
> > >   - [net-next,v13,18/19] net/mlx5e: Add Rx data path offload
> > >     https://git.kernel.org/netdev/net-next/c/29d7f433fcec
> > >   - [net-next,v13,19/19] net/mlx5e: Implement PSP key_rotate operatio=
n
> > >     https://git.kernel.org/netdev/net-next/c/411d9d33c8a2
> > >
> > > You are awesome, thank you!
> > > --
> > > Deet-doot-dot, I am a bot.
> > > https://korg.docs.kernel.org/patchwork/pwbot.html
> >
> > I just saw a name conflict on psp_dev_destroy(), not sure why it was
> > not caught earlier.
> >
> > drivers/crypto/ccp/psp-dev.c:294:void psp_dev_destroy(struct sp_device =
*sp)
> > drivers/crypto/ccp/sp-dev.c:210:                psp_dev_destroy(sp);
> > drivers/crypto/ccp/sp-dev.h:175:void psp_dev_destroy(struct sp_device *=
sp);
> > drivers/crypto/ccp/sp-dev.h:182:static inline void
> > psp_dev_destroy(struct sp_device *sp) { }
> > net/psp/psp.h:16:void psp_dev_destroy(struct psp_dev *psd);
> > net/psp/psp.h:45:               psp_dev_destroy(psd);
> > net/psp/psp_main.c:102:void psp_dev_destroy(struct psp_dev *psd)
> > net/psp/psp_main.c:125: /* Wait until psp_dev_destroy() to call
> > xa_erase() to prevent a
>
> Indeed :
>
> ld: net/psp/psp_main.o: in function `psp_dev_destroy':
> git/net-next/net/psp/psp_main.c:103: multiple definition of
> `psp_dev_destroy';
> drivers/crypto/ccp/psp-dev.o:git/net-next/drivers/crypto/ccp/psp-dev.c:29=
5:
> first defined here

I will rename our psp_dev_destroy to psp_netdev_destroy.

