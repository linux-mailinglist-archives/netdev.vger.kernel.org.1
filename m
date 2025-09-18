Return-Path: <netdev+bounces-224407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEDAB845A5
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2641BC7D0D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7847B2DA757;
	Thu, 18 Sep 2025 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t0eqC0SJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE2303CA8
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194891; cv=none; b=Uho/6tREYvM+1ERNyKs7QXdlV5aCd5IPiYX6Czeg5YpupzlIfergD7HWuE9SvuxCf/SpHGe3EWbewasO+3+eS3flSfk5OdG7feSsS3comv0al+sMvnlNhxj+JaOAgr67+sA7pb7Ej/CQ4BmK/M03ome9F5AuKIfGkiJgZsk5GCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194891; c=relaxed/simple;
	bh=XMyufqiThv5CLGW+yP9uZZtAut5MYukn7yN+7hdTJ58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AP1vpYVVVoUkqFv9vmywKiHuQLXFoEhYbjxORziVBaIrqmG2GiGYiw5yCD1thtoL8nzxHCuQoaOME6bqT1vEzqEiJhnhSJcpr66v9jEN7xd9lFwsbSZvt4ckY4wzw8uUtYCjNBAji3S1TQGBVMaoYKZ9QvSf+nkNSjEGNH9YuFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t0eqC0SJ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-82884bb66d6so88946785a.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758194888; x=1758799688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZQJPCWgHu26e5hvoXYAwwNw3KCniGxLt0LYgHNmFaM=;
        b=t0eqC0SJb1oGyU5jzaCZgvg6CjRGuglaVC67dgb6OqLKiunAklJ5+P+Mxy9XrKe0AB
         SLyuA64D41KXh/qvvZFySXVK8FqK8XVKSc84KH12htYJ8zwruju9nLtYz5+sQo1Uxs+w
         FXNIo2pzjUSXiYvvnTFMDgPLEMcibmTx+udabadCQrjCve1Q6rvRipqJSuO5GWuYPs9e
         DhdB/orc/XtXUMtsFwG0qZ5FLjh6ORTHzacfu9JXGPSKhTORxmrjOF1JomIP5oV9jqiO
         qD6mc+tHZwFlXEvBglitVHEM2hOfTe1Q8GL9EAaGK6u1kbkyoyVWV+QT3aykbamfj9A1
         ObdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758194888; x=1758799688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZQJPCWgHu26e5hvoXYAwwNw3KCniGxLt0LYgHNmFaM=;
        b=Foc33D2qbcbWgF8lGZZJueXe/yvgzK6HMy/0XHJgE9XLKduiPUc9V89W5lc4z+RmoJ
         NDAxH1IwSJc/Dr6hcs4oURfv3UquxjqMGzdGMxB9B790GVH5l6BmGm79zqiB4viLTqyL
         HS1NSJAQ0rrHSz0FhRCzAVu1FK4GJ3f8b1HfbGjRyvN72VSM2LrdPne0dRzjtdFeKer9
         6YbZO5NwWeaiPSIPW3dyZfEhilgo/m69gR0vFmoMI+FQKnfYaVyTB7ggg+jw4JHXe5/6
         NWivRYcnuUY19Bqwv2bI8wGpMpkDM6JeIvG1Mk3O0aDkWkoEb1MR3YMrVzjg07EYNcvw
         xIHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjDAiq20U4Popa1C405a6L3TsadyjZTxx7gyRpH9wPSh3c3Tq0yZgEgqcUN+YZuyzeEuLZMIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwND+rzpMoFiJyczpE3DjBODjYb1fHdQhgZJfx4UPn3/D+HbWbB
	yn4J8BfZTSHMP16Ct3Hf89LlHFbSblvbdnD0Yz4LBCujQaRZ9dyt27AaUXm4jTWzI8D1E7CTfh5
	qicaP2M8yQF2VURLYfjaF2fJr8IXWU4PcJfK5Pwci
X-Gm-Gg: ASbGnctsQpZ7Y5/oDEfhc+h03KLcENtKaGjD/3WBc9XRHL+wLPKpox0l/c+CLwtMPGp
	hkGP0GTKEIGLaX4a94Yi1v6EV4uuzwnC03zo3CptAlJxoJE9LAx/UWCRsHwNS561pSkI+L3TmVd
	mCVNrIdABRBmDJIlwkEmLCMBvWoyAcqyM1o4Tb/PsSFJxAw+vdAqDLcNOlZQdtXbe8U8VnBUjLX
	RNpunJwvixE2kTjg5jo7QDT9qCuSZxn
X-Google-Smtp-Source: AGHT+IFHIfBL/yRzBDUElhd3RNVjNae8GAieTC+J+U3t8vuchCrmBeEMQJ4C+1R3l7St2nGahK8Y6/nIWtR2QsjGV2s=
X-Received: by 2002:a05:620a:1a9c:b0:7e7:fba9:4a79 with SMTP id
 af79cd13be357-8363ad000ddmr316953085a.29.1758194885510; Thu, 18 Sep 2025
 04:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917000954.859376-1-daniel.zahka@gmail.com>
 <175819262850.2365733.8295832390159298825.git-patchwork-notify@kernel.org>
 <CANn89i+ZdBDEV6TE=Nw5gn9ycTzWw4mZOpPuCswgwEsrgOyNnw@mail.gmail.com>
 <CANn89iJ5+y2PzyMzvRnEqTBW8NgBVDCHA6C7O7VB-pPwqZQS=g@mail.gmail.com> <CANn89i+Kqm_jXM4W=ygC08HstWnjnctJYWF+WK+z6f0ZoFLNMg@mail.gmail.com>
In-Reply-To: <CANn89i+Kqm_jXM4W=ygC08HstWnjnctJYWF+WK+z6f0ZoFLNMg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Sep 2025 04:27:54 -0700
X-Gm-Features: AS18NWBsOtV0AE7FM44kPQHzUTCCfH8Ikwf_A6QMCp5pruogEw0EUOdIPCPO-aw
Message-ID: <CANn89iLPXwJgiQBFz_w6_UsA5XoyNZ9h_9zhAdKqO8MPMCxe_g@mail.gmail.com>
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

On Thu, Sep 18, 2025 at 4:24=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Sep 18, 2025 at 4:02=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Sep 18, 2025 at 4:00=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, Sep 18, 2025 at 3:50=E2=80=AFAM <patchwork-bot+netdevbpf@kern=
el.org> wrote:
> > > >
> > > > Hello:
> > > >
> > > > This series was applied to netdev/net-next.git (main)
> > > > by Paolo Abeni <pabeni@redhat.com>:
> > > >
> > > > On Tue, 16 Sep 2025 17:09:27 -0700 you wrote:
> > > > > This is v13 of the PSP RFC [1] posted by Jakub Kicinski one year
> > > > > ago. General developments since v1 include a fork of packetdrill =
[2]
> > > > > with support for PSP added, as well as some test cases, and an
> > > > > implementation of PSP key exchange and connection upgrade [3]
> > > > > integrated into the fbthrift RPC library. Both [2] and [3] have b=
een
> > > > > tested on server platforms with PSP-capable CX7 NICs. Below is th=
e
> > > > > cover letter from the original RFC:
> > > > >
> > > > > [...]
> > > >
> > > > Here is the summary with links:
> > > >   - [net-next,v13,01/19] psp: add documentation
> > > >     https://git.kernel.org/netdev/net-next/c/a9266275fd7b
> > > >   - [net-next,v13,02/19] psp: base PSP device support
> > > >     https://git.kernel.org/netdev/net-next/c/00c94ca2b99e
> > > >   - [net-next,v13,03/19] net: modify core data structures for PSP d=
atapath support
> > > >     https://git.kernel.org/netdev/net-next/c/ed8a507b7483
> > > >   - [net-next,v13,04/19] tcp: add datapath logic for PSP with inlin=
e key exchange
> > > >     https://git.kernel.org/netdev/net-next/c/659a2899a57d
> > > >   - [net-next,v13,05/19] psp: add op for rotation of device key
> > > >     https://git.kernel.org/netdev/net-next/c/117f02a49b77
> > > >   - [net-next,v13,06/19] net: move sk_validate_xmit_skb() to net/co=
re/dev.c
> > > >     https://git.kernel.org/netdev/net-next/c/8c511c1df380
> > > >   - [net-next,v13,07/19] net: tcp: allow tcp_timewait_sock to valid=
ate skbs before handing to device
> > > >     https://git.kernel.org/netdev/net-next/c/0917bb139eed
> > > >   - [net-next,v13,08/19] net: psp: add socket security association =
code
> > > >     https://git.kernel.org/netdev/net-next/c/6b46ca260e22
> > > >   - [net-next,v13,09/19] net: psp: update the TCP MSS to reflect PS=
P packet overhead
> > > >     https://git.kernel.org/netdev/net-next/c/e97269257fe4
> > > >   - [net-next,v13,10/19] psp: track generations of device key
> > > >     https://git.kernel.org/netdev/net-next/c/e78851058b35
> > > >   - [net-next,v13,11/19] net/mlx5e: Support PSP offload functionali=
ty
> > > >     https://git.kernel.org/netdev/net-next/c/89ee2d92f66c
> > > >   - [net-next,v13,12/19] net/mlx5e: Implement PSP operations .assoc=
_add and .assoc_del
> > > >     https://git.kernel.org/netdev/net-next/c/af2196f49480
> > > >   - [net-next,v13,13/19] psp: provide encapsulation helper for driv=
ers
> > > >     https://git.kernel.org/netdev/net-next/c/fc724515741a
> > > >   - [net-next,v13,14/19] net/mlx5e: Implement PSP Tx data path
> > > >     https://git.kernel.org/netdev/net-next/c/e5a1861a298e
> > > >   - [net-next,v13,15/19] net/mlx5e: Add PSP steering in local NIC R=
X
> > > >     https://git.kernel.org/netdev/net-next/c/9536fbe10c9d
> > > >   - [net-next,v13,16/19] net/mlx5e: Configure PSP Rx flow steering =
rules
> > > >     https://git.kernel.org/netdev/net-next/c/2b6e450bfde7
> > > >   - [net-next,v13,17/19] psp: provide decapsulation and receive hel=
per for drivers
> > > >     https://git.kernel.org/netdev/net-next/c/0eddb8023cee
> > > >   - [net-next,v13,18/19] net/mlx5e: Add Rx data path offload
> > > >     https://git.kernel.org/netdev/net-next/c/29d7f433fcec
> > > >   - [net-next,v13,19/19] net/mlx5e: Implement PSP key_rotate operat=
ion
> > > >     https://git.kernel.org/netdev/net-next/c/411d9d33c8a2
> > > >
> > > > You are awesome, thank you!
> > > > --
> > > > Deet-doot-dot, I am a bot.
> > > > https://korg.docs.kernel.org/patchwork/pwbot.html
> > >
> > > I just saw a name conflict on psp_dev_destroy(), not sure why it was
> > > not caught earlier.
> > >
> > > drivers/crypto/ccp/psp-dev.c:294:void psp_dev_destroy(struct sp_devic=
e *sp)
> > > drivers/crypto/ccp/sp-dev.c:210:                psp_dev_destroy(sp);
> > > drivers/crypto/ccp/sp-dev.h:175:void psp_dev_destroy(struct sp_device=
 *sp);
> > > drivers/crypto/ccp/sp-dev.h:182:static inline void
> > > psp_dev_destroy(struct sp_device *sp) { }
> > > net/psp/psp.h:16:void psp_dev_destroy(struct psp_dev *psd);
> > > net/psp/psp.h:45:               psp_dev_destroy(psd);
> > > net/psp/psp_main.c:102:void psp_dev_destroy(struct psp_dev *psd)
> > > net/psp/psp_main.c:125: /* Wait until psp_dev_destroy() to call
> > > xa_erase() to prevent a
> >
> > Indeed :
> >
> > ld: net/psp/psp_main.o: in function `psp_dev_destroy':
> > git/net-next/net/psp/psp_main.c:103: multiple definition of
> > `psp_dev_destroy';
> > drivers/crypto/ccp/psp-dev.o:git/net-next/drivers/crypto/ccp/psp-dev.c:=
295:
> > first defined here
>
> I will rename our psp_dev_destroy to psp_netdev_destroy.

Or keep psp_dev prefix.  I will use psp_dev_free()

