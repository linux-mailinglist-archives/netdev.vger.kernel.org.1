Return-Path: <netdev+bounces-224383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E520CB84416
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98890463184
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534A3296BDA;
	Thu, 18 Sep 2025 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c5fBOJtR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B5323ABA0
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193342; cv=none; b=ldYOMUHlTtcC+ElVThLRhVCbHInENdZPQZzi7+DKJ4kPX8JIrQLVMoaSFgf5oA3gjNdv/jfR2mDfgDUrwzdCvTREkWqthz8oGXWeU3m3O5TXYACJz6CVvpUGRWiItGMv7nS6fUWpDidEEu6NPkEMnOSeStQ2dKdDvYnNwHrKBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193342; c=relaxed/simple;
	bh=2J9wkLAKPk5bnXZKa+EPEwIG+I5djdFiPdhgf7wh6v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dB6qHSYV4TNFbevseXlGBTLFRNTFVxLaSicO4+F/dnHMeMJtWbTOLPIaouK9Vj+wIK7LJEeV9uuhfQ5aUsoMg0E1afunTBNDXqALCw6OCrgStWp7+wKc3540e41bco+fJR5DK10ya1uM3iVyynln1K8Ch0HUscdEPU4TPsM10DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c5fBOJtR; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-829243c1164so89121785a.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758193339; x=1758798139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=banPVEPj+ErhquWiTwSEXNtO6pB+JsLciaPDTlNTKDc=;
        b=c5fBOJtR0x0yiZk7b9Ez/JYFCrqqdCEcvytvzsf+jF0uAbax+abnEF0QRIynJfKz38
         0EQnp5NQT4uJ3eH6bI+4wPlF30HrkWM/ZBfjx4bevto0L1bAv2nKsn39D+uhXDbfNSEJ
         sY3kde0S0yJ89oJsAzFddij0+NDJVH1KqiBEkBGCeE9EJbrOAV/YQoAs3tDuds8z86OA
         rU9zXM5yjDdrbSp6b1+DR+NPMnTs03qN32ZhUIwHJE9bj3s4rQClsBuGSQtYeWpX3gWn
         P3LNZy+L8udTJI7Of0PU3yhUUGZQRJKsBiKcs3HlADSk3S7DfJYCDnSPMhguA4aGhoiS
         ofkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758193339; x=1758798139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=banPVEPj+ErhquWiTwSEXNtO6pB+JsLciaPDTlNTKDc=;
        b=usZ+qx7ZWs2SmQPMUiMQo/c/LSifg4TQwotCOv2u8BxsAzte0Ksthge4zmVYodpXKi
         FojX6ogXdQJJLAnQiFEfL03Oh+haLjRHXQ5amvIzV28DK3e9OmtbrG8Hbt6PKyI2xy8u
         gPwk3Le5SwBBM3s0vmoePfuSzabkiRWPAxju8qoW9zaYmcolYVDjsW3XLFxeu3rpBPxQ
         QHLdRcOEqmgXAtM2dPQ4QEwJSjzQZXpKLI6JFrxENOBCIMVADoNIj+wZp3hxU38OMZIY
         9+jVRabqenixKKcawoH55/HRX6Zj7XXjTYney1PRMVE4ptdXiUdEqe+5exNqGW9Kaczl
         z2Lg==
X-Forwarded-Encrypted: i=1; AJvYcCV4Y4XT9tC9kD/GVfEUBCrbXre4PpVHhJ2vU08+NSdjZfprwLxithVVNKAUBHRB9GZDuGANeu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1JKE+iU71Q86ITipZt0b8+GU/ifW+edCA9TaQ6Y4ZRI55yvmd
	BIPFgrKbm3ZZkKrTlUnLPmGliNfPQal29NgVMsrartfXzUwFAXo+GjxMYp1CLvJ+DChAw0dbr99
	9vy1E0cMvglZNZGon6w5QoMVihou20QjxqWXXWXUs
X-Gm-Gg: ASbGncuQSPBxytfFcPVMcqZjqL7jsPjSQ20lyEj+anyFpI6RlrP8Kc7YHCqx06uEQFa
	fUWqQVg5NwPHkL+8GmicZhm5/C2OxviLN73V0BAuqv0MQxmBeQKX7PHhBJw8aq6ywEPTphloI3C
	xMN56KrHwYeticXcMPZ5eI8cT2z7LRaWE2r7gY0Jzu0IvheVvbm2c03oF7/s6VNK6HdQzyKxhrM
	vZw4CgnrtwcNcJo/96SIicltodOIn9J
X-Google-Smtp-Source: AGHT+IGKC9qDTtnoJHTT6+sJNUgDVNv1pEEMgPe1/NsDE14IfEUNPt1mDu4A6PXeEReyt6HChzJp+ngnvYQx0kb9dFg=
X-Received: by 2002:a05:620a:172b:b0:82a:5c45:c5ef with SMTP id
 af79cd13be357-830fded0290mr545455885a.0.1758193338768; Thu, 18 Sep 2025
 04:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917000954.859376-1-daniel.zahka@gmail.com>
 <175819262850.2365733.8295832390159298825.git-patchwork-notify@kernel.org> <CANn89i+ZdBDEV6TE=Nw5gn9ycTzWw4mZOpPuCswgwEsrgOyNnw@mail.gmail.com>
In-Reply-To: <CANn89i+ZdBDEV6TE=Nw5gn9ycTzWw4mZOpPuCswgwEsrgOyNnw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Sep 2025 04:02:07 -0700
X-Gm-Features: AS18NWDWxaAiYTEwrnyw4t1w4-Wz6R3anmvrufYxwAbA1zCcdXnmW7MFNdlDLoA
Message-ID: <CANn89iJ5+y2PzyMzvRnEqTBW8NgBVDCHA6C7O7VB-pPwqZQS=g@mail.gmail.com>
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

On Thu, Sep 18, 2025 at 4:00=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Sep 18, 2025 at 3:50=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.o=
rg> wrote:
> >
> > Hello:
> >
> > This series was applied to netdev/net-next.git (main)
> > by Paolo Abeni <pabeni@redhat.com>:
> >
> > On Tue, 16 Sep 2025 17:09:27 -0700 you wrote:
> > > This is v13 of the PSP RFC [1] posted by Jakub Kicinski one year
> > > ago. General developments since v1 include a fork of packetdrill [2]
> > > with support for PSP added, as well as some test cases, and an
> > > implementation of PSP key exchange and connection upgrade [3]
> > > integrated into the fbthrift RPC library. Both [2] and [3] have been
> > > tested on server platforms with PSP-capable CX7 NICs. Below is the
> > > cover letter from the original RFC:
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - [net-next,v13,01/19] psp: add documentation
> >     https://git.kernel.org/netdev/net-next/c/a9266275fd7b
> >   - [net-next,v13,02/19] psp: base PSP device support
> >     https://git.kernel.org/netdev/net-next/c/00c94ca2b99e
> >   - [net-next,v13,03/19] net: modify core data structures for PSP datap=
ath support
> >     https://git.kernel.org/netdev/net-next/c/ed8a507b7483
> >   - [net-next,v13,04/19] tcp: add datapath logic for PSP with inline ke=
y exchange
> >     https://git.kernel.org/netdev/net-next/c/659a2899a57d
> >   - [net-next,v13,05/19] psp: add op for rotation of device key
> >     https://git.kernel.org/netdev/net-next/c/117f02a49b77
> >   - [net-next,v13,06/19] net: move sk_validate_xmit_skb() to net/core/d=
ev.c
> >     https://git.kernel.org/netdev/net-next/c/8c511c1df380
> >   - [net-next,v13,07/19] net: tcp: allow tcp_timewait_sock to validate =
skbs before handing to device
> >     https://git.kernel.org/netdev/net-next/c/0917bb139eed
> >   - [net-next,v13,08/19] net: psp: add socket security association code
> >     https://git.kernel.org/netdev/net-next/c/6b46ca260e22
> >   - [net-next,v13,09/19] net: psp: update the TCP MSS to reflect PSP pa=
cket overhead
> >     https://git.kernel.org/netdev/net-next/c/e97269257fe4
> >   - [net-next,v13,10/19] psp: track generations of device key
> >     https://git.kernel.org/netdev/net-next/c/e78851058b35
> >   - [net-next,v13,11/19] net/mlx5e: Support PSP offload functionality
> >     https://git.kernel.org/netdev/net-next/c/89ee2d92f66c
> >   - [net-next,v13,12/19] net/mlx5e: Implement PSP operations .assoc_add=
 and .assoc_del
> >     https://git.kernel.org/netdev/net-next/c/af2196f49480
> >   - [net-next,v13,13/19] psp: provide encapsulation helper for drivers
> >     https://git.kernel.org/netdev/net-next/c/fc724515741a
> >   - [net-next,v13,14/19] net/mlx5e: Implement PSP Tx data path
> >     https://git.kernel.org/netdev/net-next/c/e5a1861a298e
> >   - [net-next,v13,15/19] net/mlx5e: Add PSP steering in local NIC RX
> >     https://git.kernel.org/netdev/net-next/c/9536fbe10c9d
> >   - [net-next,v13,16/19] net/mlx5e: Configure PSP Rx flow steering rule=
s
> >     https://git.kernel.org/netdev/net-next/c/2b6e450bfde7
> >   - [net-next,v13,17/19] psp: provide decapsulation and receive helper =
for drivers
> >     https://git.kernel.org/netdev/net-next/c/0eddb8023cee
> >   - [net-next,v13,18/19] net/mlx5e: Add Rx data path offload
> >     https://git.kernel.org/netdev/net-next/c/29d7f433fcec
> >   - [net-next,v13,19/19] net/mlx5e: Implement PSP key_rotate operation
> >     https://git.kernel.org/netdev/net-next/c/411d9d33c8a2
> >
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
>
> I just saw a name conflict on psp_dev_destroy(), not sure why it was
> not caught earlier.
>
> drivers/crypto/ccp/psp-dev.c:294:void psp_dev_destroy(struct sp_device *s=
p)
> drivers/crypto/ccp/sp-dev.c:210:                psp_dev_destroy(sp);
> drivers/crypto/ccp/sp-dev.h:175:void psp_dev_destroy(struct sp_device *sp=
);
> drivers/crypto/ccp/sp-dev.h:182:static inline void
> psp_dev_destroy(struct sp_device *sp) { }
> net/psp/psp.h:16:void psp_dev_destroy(struct psp_dev *psd);
> net/psp/psp.h:45:               psp_dev_destroy(psd);
> net/psp/psp_main.c:102:void psp_dev_destroy(struct psp_dev *psd)
> net/psp/psp_main.c:125: /* Wait until psp_dev_destroy() to call
> xa_erase() to prevent a

Indeed :

ld: net/psp/psp_main.o: in function `psp_dev_destroy':
git/net-next/net/psp/psp_main.c:103: multiple definition of
`psp_dev_destroy';
drivers/crypto/ccp/psp-dev.o:git/net-next/drivers/crypto/ccp/psp-dev.c:295:
first defined here

