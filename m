Return-Path: <netdev+bounces-224413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3523B84605
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864FB1BC2FD2
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09B62FFF9F;
	Thu, 18 Sep 2025 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVbBIAMY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F8927A900
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195429; cv=none; b=IbfLShzhyVmBkW/Wt+JW6NCPrOI8NuGm801WMTtK5UzneKDYuCkitZd9mWuGK3OGF1DnjlXQgrenMPBIArIKRIHoVZ0DtG8EYgAejExomYI7x+kz7ipn1Lwd+xZBAzjcH2NFnISkGWfAR04lJTGDQwXl3Hqm8rdIdmye9/5cm1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195429; c=relaxed/simple;
	bh=EKAfO+nPMJMSJowvub3a4qvTRvsieZCGcilKvT+JpJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCTFYvOqgDqukltUL03tLMt/w6usQCwAwMIocVV4QEHVnObVw9meVLsRFsyqrwpjp4D1hWLvCVu1xTTteY3tdViqj3I/0Fi+F/GRqVOFv2ou9JNTP0Ijhgb2hIRIfodY69tUSe2uEyYcby+EbVZ35ZMx6JaJc0/KYWNpg17oYjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YVbBIAMY; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b5ed9d7e96so8965021cf.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758195427; x=1758800227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EoZiMl0vd2sqT+BZYWxVXWZ1xkNjMJ4o+PJZT1j06w=;
        b=YVbBIAMYBtxxyUbIkDGkbido4+NHe70CkBdvb7ARJmp9LBnYIFNUAUSDk/mnOOLyd8
         X1cHTQYP8tliKaIEzJMkQV39CDofHd+dwi75JYIyOMRIs7NkskIzsduBwYQibBkK5gy6
         a3XTxgD9PJc+lEikXzzx1zaShmKyoUQDiaBdaXpgTnpLV0+8Qkp074o26eEF40gw5HsC
         ofXJhTEgaAldmnpWPeXLA//RH0OtK4KGtjI7HGr6u8uUjsLnaDZ7jpY0rAaAinOnxALy
         xp0zvbHP6i1Ggm+GUSFKdP52w9YqeFbtxy63utSXUjPCkNAAi1ueM7HGBrpXPwdU8Oq8
         hLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758195427; x=1758800227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EoZiMl0vd2sqT+BZYWxVXWZ1xkNjMJ4o+PJZT1j06w=;
        b=bObeHWHfdPcvunVZcEWqecP0zKwq0S6DKjDtJYzpklxWEiaFMyPP478otwkNhphzHw
         YNJEUJTjmw4t/eFC9pGsgqrcd4eI7PavvFOqI7rlJeXmgT+rzhNH+KPtI5U/Dzte/tBt
         S2Lr7/lYxwxzLBkXWFR8HHsHv3ZyM1Y1Xr1TGYKNQ3mgMsgbuLDe+fgeO90yoYA+pGHK
         Dx3ijx5CKeN4Lo0F19gOtHwqXFUell2TfL6PlJg8pFMY/2xAayKuFXGsvbYeQ8F0Sncr
         cK4kMWSCl4F15U6xbl0LvmHqaTHZZtXwoCm87KbCX5BSn8QGtDKicJ/jkQezRIk1aqkH
         lYmw==
X-Forwarded-Encrypted: i=1; AJvYcCX+nPYV3IzjRfKy1mzfQH7+MKckBF5SXAeH67C95KKVsnXJywdW+cnYny4L40vkckZdq0UWMh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8FSncNfjl0u8b8+gfU0GKQvAEQi+a8LizTTfuMct+TNnYzi1
	NexV6FU+Qm1CtMMhRw9ssKX1pjmuciToLqpmPLRZ2kUvUOBpGYMhfKYlZDhhXIVe3t498PMiEG/
	aRwRvu/01iXuRir5CsR5Ut9K8w9F4K8QOt0xLSz0D
X-Gm-Gg: ASbGncshffli4iKQZof/mKEooDsw2Dvcd/BqoXDpwTiAfUHHs552608kYiEHLHZIQ0v
	VOWj0YM0a4u44Epyxv8jvIlSdipN8LX/1jhnhWer8GIYqMM0H/FLF7yL8oI2QxOfyFdAMXfIKM0
	mQgGZi7ECvKeDgZoBwFMhHrQUe96FLT+66qUin8d0ofHDJU/NyDmMGvli3M2sqAp3E+nlhGfEw3
	Gl/9Vj4JQl4jmdi5Th5cfKdkF9BsXEV
X-Google-Smtp-Source: AGHT+IFMZXtaopcewE4TBfwst23kPXW2Y3W9+3nDT62uskHHo3KR0i8OMI39zIH7ZatEZu9RiHgnlBiuDPz07tlIl4E=
X-Received: by 2002:a05:622a:206:b0:4b5:6f48:e55a with SMTP id
 d75a77b69052e-4bdaa89c121mr31107181cf.12.1758195426129; Thu, 18 Sep 2025
 04:37:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917000954.859376-1-daniel.zahka@gmail.com>
 <175819262850.2365733.8295832390159298825.git-patchwork-notify@kernel.org>
 <CANn89i+ZdBDEV6TE=Nw5gn9ycTzWw4mZOpPuCswgwEsrgOyNnw@mail.gmail.com>
 <CANn89iJ5+y2PzyMzvRnEqTBW8NgBVDCHA6C7O7VB-pPwqZQS=g@mail.gmail.com>
 <CANn89i+Kqm_jXM4W=ygC08HstWnjnctJYWF+WK+z6f0ZoFLNMg@mail.gmail.com>
 <CANn89iLPXwJgiQBFz_w6_UsA5XoyNZ9h_9zhAdKqO8MPMCxe_g@mail.gmail.com> <e05f2321-9246-466f-a577-6d0b83beaa89@redhat.com>
In-Reply-To: <e05f2321-9246-466f-a577-6d0b83beaa89@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Sep 2025 04:36:54 -0700
X-Gm-Features: AS18NWAVtWl4Fl2kqK5SKyI80sC1PW2p5UheAT05bpo8P0Xie_G7xgEWABWmpbE
Message-ID: <CANn89i+JHV-EUybxh=fuKYtm_2zv_nYbSbcgA+umax9Zw-YD3w@mail.gmail.com>
Subject: Re: [PATCH net-next v13 00/19] add basic PSP encryption for TCP connections
To: Paolo Abeni <pabeni@redhat.com>
Cc: patchwork-bot+netdevbpf@kernel.org, Daniel Zahka <daniel.zahka@gmail.com>, 
	donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	horms@kernel.org, corbet@lwn.net, andrew+netdev@lunn.ch, saeedm@nvidia.com, 
	leon@kernel.org, tariqt@nvidia.com, borisp@nvidia.com, kuniyu@google.com, 
	willemb@google.com, dsahern@kernel.org, ncardwell@google.com, 
	phaddad@nvidia.com, raeds@nvidia.com, jianbol@nvidia.com, dtatulea@nvidia.com, 
	rrameshbabu@nvidia.com, sdf@fomichev.me, toke@redhat.com, 
	aleksander.lobakin@intel.com, kiran.kella@broadcom.com, 
	jacob.e.keller@intel.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 4:36=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/18/25 1:27 PM, Eric Dumazet wrote:
> > On Thu, Sep 18, 2025 at 4:24=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> >> On Thu, Sep 18, 2025 at 4:02=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> >>> On Thu, Sep 18, 2025 at 4:00=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> >>>> On Thu, Sep 18, 2025 at 3:50=E2=80=AFAM <patchwork-bot+netdevbpf@ker=
nel.org> wrote:
> >>>>>
> >>>>> Hello:
> >>>>>
> >>>>> This series was applied to netdev/net-next.git (main)
> >>>>> by Paolo Abeni <pabeni@redhat.com>:
> >>>>>
> >>>>> On Tue, 16 Sep 2025 17:09:27 -0700 you wrote:
> >>>>>> This is v13 of the PSP RFC [1] posted by Jakub Kicinski one year
> >>>>>> ago. General developments since v1 include a fork of packetdrill [=
2]
> >>>>>> with support for PSP added, as well as some test cases, and an
> >>>>>> implementation of PSP key exchange and connection upgrade [3]
> >>>>>> integrated into the fbthrift RPC library. Both [2] and [3] have be=
en
> >>>>>> tested on server platforms with PSP-capable CX7 NICs. Below is the
> >>>>>> cover letter from the original RFC:
> >>>>>>
> >>>>>> [...]
> >>>>>
> >>>>> Here is the summary with links:
> >>>>>   - [net-next,v13,01/19] psp: add documentation
> >>>>>     https://git.kernel.org/netdev/net-next/c/a9266275fd7b
> >>>>>   - [net-next,v13,02/19] psp: base PSP device support
> >>>>>     https://git.kernel.org/netdev/net-next/c/00c94ca2b99e
> >>>>>   - [net-next,v13,03/19] net: modify core data structures for PSP d=
atapath support
> >>>>>     https://git.kernel.org/netdev/net-next/c/ed8a507b7483
> >>>>>   - [net-next,v13,04/19] tcp: add datapath logic for PSP with inlin=
e key exchange
> >>>>>     https://git.kernel.org/netdev/net-next/c/659a2899a57d
> >>>>>   - [net-next,v13,05/19] psp: add op for rotation of device key
> >>>>>     https://git.kernel.org/netdev/net-next/c/117f02a49b77
> >>>>>   - [net-next,v13,06/19] net: move sk_validate_xmit_skb() to net/co=
re/dev.c
> >>>>>     https://git.kernel.org/netdev/net-next/c/8c511c1df380
> >>>>>   - [net-next,v13,07/19] net: tcp: allow tcp_timewait_sock to valid=
ate skbs before handing to device
> >>>>>     https://git.kernel.org/netdev/net-next/c/0917bb139eed
> >>>>>   - [net-next,v13,08/19] net: psp: add socket security association =
code
> >>>>>     https://git.kernel.org/netdev/net-next/c/6b46ca260e22
> >>>>>   - [net-next,v13,09/19] net: psp: update the TCP MSS to reflect PS=
P packet overhead
> >>>>>     https://git.kernel.org/netdev/net-next/c/e97269257fe4
> >>>>>   - [net-next,v13,10/19] psp: track generations of device key
> >>>>>     https://git.kernel.org/netdev/net-next/c/e78851058b35
> >>>>>   - [net-next,v13,11/19] net/mlx5e: Support PSP offload functionali=
ty
> >>>>>     https://git.kernel.org/netdev/net-next/c/89ee2d92f66c
> >>>>>   - [net-next,v13,12/19] net/mlx5e: Implement PSP operations .assoc=
_add and .assoc_del
> >>>>>     https://git.kernel.org/netdev/net-next/c/af2196f49480
> >>>>>   - [net-next,v13,13/19] psp: provide encapsulation helper for driv=
ers
> >>>>>     https://git.kernel.org/netdev/net-next/c/fc724515741a
> >>>>>   - [net-next,v13,14/19] net/mlx5e: Implement PSP Tx data path
> >>>>>     https://git.kernel.org/netdev/net-next/c/e5a1861a298e
> >>>>>   - [net-next,v13,15/19] net/mlx5e: Add PSP steering in local NIC R=
X
> >>>>>     https://git.kernel.org/netdev/net-next/c/9536fbe10c9d
> >>>>>   - [net-next,v13,16/19] net/mlx5e: Configure PSP Rx flow steering =
rules
> >>>>>     https://git.kernel.org/netdev/net-next/c/2b6e450bfde7
> >>>>>   - [net-next,v13,17/19] psp: provide decapsulation and receive hel=
per for drivers
> >>>>>     https://git.kernel.org/netdev/net-next/c/0eddb8023cee
> >>>>>   - [net-next,v13,18/19] net/mlx5e: Add Rx data path offload
> >>>>>     https://git.kernel.org/netdev/net-next/c/29d7f433fcec
> >>>>>   - [net-next,v13,19/19] net/mlx5e: Implement PSP key_rotate operat=
ion
> >>>>>     https://git.kernel.org/netdev/net-next/c/411d9d33c8a2
> >>>>>
> >>>>> You are awesome, thank you!
> >>>>> --
> >>>>> Deet-doot-dot, I am a bot.
> >>>>> https://korg.docs.kernel.org/patchwork/pwbot.html
> >>>>
> >>>> I just saw a name conflict on psp_dev_destroy(), not sure why it was
> >>>> not caught earlier.
> >>>>
> >>>> drivers/crypto/ccp/psp-dev.c:294:void psp_dev_destroy(struct sp_devi=
ce *sp)
> >>>> drivers/crypto/ccp/sp-dev.c:210:                psp_dev_destroy(sp);
> >>>> drivers/crypto/ccp/sp-dev.h:175:void psp_dev_destroy(struct sp_devic=
e *sp);
> >>>> drivers/crypto/ccp/sp-dev.h:182:static inline void
> >>>> psp_dev_destroy(struct sp_device *sp) { }
> >>>> net/psp/psp.h:16:void psp_dev_destroy(struct psp_dev *psd);
> >>>> net/psp/psp.h:45:               psp_dev_destroy(psd);
> >>>> net/psp/psp_main.c:102:void psp_dev_destroy(struct psp_dev *psd)
> >>>> net/psp/psp_main.c:125: /* Wait until psp_dev_destroy() to call
> >>>> xa_erase() to prevent a
> >>>
> >>> Indeed :
> >>>
> >>> ld: net/psp/psp_main.o: in function `psp_dev_destroy':
> >>> git/net-next/net/psp/psp_main.c:103: multiple definition of
> >>> `psp_dev_destroy';
> >>> drivers/crypto/ccp/psp-dev.o:git/net-next/drivers/crypto/ccp/psp-dev.=
c:295:
> >>> first defined here
> >>
> >> I will rename our psp_dev_destroy to psp_netdev_destroy.
> >
> > Or keep psp_dev prefix.  I will use psp_dev_free()
>
> FWIW, I think the latter option would be better.

Yes, I sent the patch already, with psp_dev_free().

Thanks.

