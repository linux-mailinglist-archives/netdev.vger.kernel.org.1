Return-Path: <netdev+bounces-224410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08130B845F6
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DB04824B6
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E532FFF86;
	Thu, 18 Sep 2025 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rnMsK+Jy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61D0283FEF
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195331; cv=none; b=BBJmJqKsZ8KDmvTjuR9FfMGyjXksW7CMDWBRg49dqaFykfG9O1HBzLkYne57XasoLIUwKBT1D7XM0IXqMzNgi5gOmMiRzIFs/lk5jPh5CfsJiSdSkBqrIHTQwy3eiWrsCOf9+Xs9Uq5NpmSdlXppnVGkK8jQ9ZS3OZ61mIa/r8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195331; c=relaxed/simple;
	bh=Yw/g68CqLxD0iKMTI1dYQwaLZlL5HQl1pkV4yOrMq3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbA+JfnMUGFjRd20rLR7g5EK2D4PBzlc+ko94Cha4dH68cpIKtcne9zvKkKvYy1pt2BP8ZJhf25dyW/FvbRSxP4WmGtxmQAua6DFPIPINdtfJJ/y9wOYMHGCWhhvFrtrSPB0Iovuk4HbQxgp7OcFO4/Sf7CLaJEQsyY7iFDWISo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rnMsK+Jy; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b60144fc74so11318781cf.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758195329; x=1758800129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSVxjbfjOwmiIzPsnG/ome0D5NySLCbYEgcq9ZT7qFs=;
        b=rnMsK+JymEvDiKTcg7UZOJVZySO7UcEoPHzApjEym4SpvFgBwp3wp4fpHyFHvbXt4k
         NiAyoDp9vIbc4s+j5qv9L0omBcXcDO11O1jRXUhpGKGFInE6NmTNXZFoB7HktCMcIMLG
         Ao6APl+p8fIRnrSzppiLzVKKMmRDl405qKYg+aTGFzJC4uBD/407KNlDi9y9/MHYMlKZ
         8ZxeF3H9A9U8POPlKAaDLMfjRIlkLX7BxkCL5EizaIqqtzGrwp8XDWZg5G/mXTYTyXUB
         FKPpoNNOnqlaZdy3yDk00Q3J95S6hI8deaTEYJaPO9BjXqLxbxhfWskEilN8DgBpP2HO
         OTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758195329; x=1758800129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSVxjbfjOwmiIzPsnG/ome0D5NySLCbYEgcq9ZT7qFs=;
        b=w1NUM8zki5UukUo2K9PHiGcZB8XOSc6YvKr2ifhP314m8EZXqLOp5hneK9TfDGHc7u
         37ZkMSqojIutHHKBqWjb1efvnqy+HNR2pQYBngqZp+7QdCooDGF1+pCw/f5hv+R9U7y1
         BC4kOQlKUB2oUYr7Kh0xZtbOCMOoRGXSvrM4WExuFGxTN1+Jvp5nMoFWal2TZJ2edwbg
         KzCK0iLn5O88OOVGTk/4E10DI+QcDG4HKHMKiiYdouBxY1yQ2aYMxpX7HnrM/lV1+Xoh
         43/8tTfAyvOUPcmikiSxq/UkCAaWaHzBjMaqNMLvMUT2FkaOaYkCClG5nzGy2mLbA3G4
         I4EA==
X-Forwarded-Encrypted: i=1; AJvYcCV+w+cnOFZFnNcJgwzXSHnvmDW6PE0FxfOp79FTZ0Wkqt7LJC+NNaS6OJR+tu1oNL1BmCbTjjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Hj9bPCq2vkwsGHNwTyZ3+6HHTyHFBHBA3X52ei1NoaItI5qD
	zLuGqudUAnbWTtl9u16oLAX6UFUFZ30kfnJLwGoI88GNTbHYxpiSnjUyJ2r7w/gjZ0NjHbRe1Zl
	6IPhXoMyYCLPzeKdTxf625ftSKO2HbDolu/mXzJnB
X-Gm-Gg: ASbGncsZk+vhWAglqZhe2o8zEQI+cPU6WgYd2l1ufQxr6TmtYgKb2x4lWYgQ3wFrZBU
	omf9ZW86p3+S3ihnvbk78Jp+EG5Zgeg4qcA7H8iokKnfkxxaVxkesGlH4A8BmzUmhd7Aj3bgyQH
	1NIW+XMRJPh8quv8hpz1R7ttsifLyvoJ+8EDjDwPyXcj9dkoUf2sfa8apFcnI8rjf9Q1MpiWZy6
	PzOSQhV7L0O8KsvQWxVeByUENOvGAgh
X-Google-Smtp-Source: AGHT+IE2Xol3NNGm+6KSfBkOv48ZS0lmwpRY6m+NPedL4XnidHxHPmPss7p60lammuwnzeEJDcPgu2Cai1Ln0pQOrNM=
X-Received: by 2002:ac8:7f4a:0:b0:4b5:f28e:f85e with SMTP id
 d75a77b69052e-4ba676ba4b2mr73231781cf.27.1758195328082; Thu, 18 Sep 2025
 04:35:28 -0700 (PDT)
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
 <CANn89i+Kqm_jXM4W=ygC08HstWnjnctJYWF+WK+z6f0ZoFLNMg@mail.gmail.com> <71c34d95-3044-4301-a9f1-c5702a59b730@redhat.com>
In-Reply-To: <71c34d95-3044-4301-a9f1-c5702a59b730@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Sep 2025 04:35:15 -0700
X-Gm-Features: AS18NWAAc43TnJUhNeC9WUC8hhgnETk1v-l8SHADTsubza2Yf7cjUYtn0VIUCh8
Message-ID: <CANn89iLyCSnL+-hAXd8M29wXJEoEd0tk=c82LcE56y+1Ji=O7g@mail.gmail.com>
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

On Thu, Sep 18, 2025 at 4:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/18/25 1:24 PM, Eric Dumazet wrote:
> > On Thu, Sep 18, 2025 at 4:02=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> >> On Thu, Sep 18, 2025 at 4:00=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> >>> On Thu, Sep 18, 2025 at 3:50=E2=80=AFAM <patchwork-bot+netdevbpf@kern=
el.org> wrote:
> >>>>
> >>>> Hello:
> >>>>
> >>>> This series was applied to netdev/net-next.git (main)
> >>>> by Paolo Abeni <pabeni@redhat.com>:
> >>>>
> >>>> On Tue, 16 Sep 2025 17:09:27 -0700 you wrote:
> >>>>> This is v13 of the PSP RFC [1] posted by Jakub Kicinski one year
> >>>>> ago. General developments since v1 include a fork of packetdrill [2=
]
> >>>>> with support for PSP added, as well as some test cases, and an
> >>>>> implementation of PSP key exchange and connection upgrade [3]
> >>>>> integrated into the fbthrift RPC library. Both [2] and [3] have bee=
n
> >>>>> tested on server platforms with PSP-capable CX7 NICs. Below is the
> >>>>> cover letter from the original RFC:
> >>>>>
> >>>>> [...]
> >>>>
> >>>> Here is the summary with links:
> >>>>   - [net-next,v13,01/19] psp: add documentation
> >>>>     https://git.kernel.org/netdev/net-next/c/a9266275fd7b
> >>>>   - [net-next,v13,02/19] psp: base PSP device support
> >>>>     https://git.kernel.org/netdev/net-next/c/00c94ca2b99e
> >>>>   - [net-next,v13,03/19] net: modify core data structures for PSP da=
tapath support
> >>>>     https://git.kernel.org/netdev/net-next/c/ed8a507b7483
> >>>>   - [net-next,v13,04/19] tcp: add datapath logic for PSP with inline=
 key exchange
> >>>>     https://git.kernel.org/netdev/net-next/c/659a2899a57d
> >>>>   - [net-next,v13,05/19] psp: add op for rotation of device key
> >>>>     https://git.kernel.org/netdev/net-next/c/117f02a49b77
> >>>>   - [net-next,v13,06/19] net: move sk_validate_xmit_skb() to net/cor=
e/dev.c
> >>>>     https://git.kernel.org/netdev/net-next/c/8c511c1df380
> >>>>   - [net-next,v13,07/19] net: tcp: allow tcp_timewait_sock to valida=
te skbs before handing to device
> >>>>     https://git.kernel.org/netdev/net-next/c/0917bb139eed
> >>>>   - [net-next,v13,08/19] net: psp: add socket security association c=
ode
> >>>>     https://git.kernel.org/netdev/net-next/c/6b46ca260e22
> >>>>   - [net-next,v13,09/19] net: psp: update the TCP MSS to reflect PSP=
 packet overhead
> >>>>     https://git.kernel.org/netdev/net-next/c/e97269257fe4
> >>>>   - [net-next,v13,10/19] psp: track generations of device key
> >>>>     https://git.kernel.org/netdev/net-next/c/e78851058b35
> >>>>   - [net-next,v13,11/19] net/mlx5e: Support PSP offload functionalit=
y
> >>>>     https://git.kernel.org/netdev/net-next/c/89ee2d92f66c
> >>>>   - [net-next,v13,12/19] net/mlx5e: Implement PSP operations .assoc_=
add and .assoc_del
> >>>>     https://git.kernel.org/netdev/net-next/c/af2196f49480
> >>>>   - [net-next,v13,13/19] psp: provide encapsulation helper for drive=
rs
> >>>>     https://git.kernel.org/netdev/net-next/c/fc724515741a
> >>>>   - [net-next,v13,14/19] net/mlx5e: Implement PSP Tx data path
> >>>>     https://git.kernel.org/netdev/net-next/c/e5a1861a298e
> >>>>   - [net-next,v13,15/19] net/mlx5e: Add PSP steering in local NIC RX
> >>>>     https://git.kernel.org/netdev/net-next/c/9536fbe10c9d
> >>>>   - [net-next,v13,16/19] net/mlx5e: Configure PSP Rx flow steering r=
ules
> >>>>     https://git.kernel.org/netdev/net-next/c/2b6e450bfde7
> >>>>   - [net-next,v13,17/19] psp: provide decapsulation and receive help=
er for drivers
> >>>>     https://git.kernel.org/netdev/net-next/c/0eddb8023cee
> >>>>   - [net-next,v13,18/19] net/mlx5e: Add Rx data path offload
> >>>>     https://git.kernel.org/netdev/net-next/c/29d7f433fcec
> >>>>   - [net-next,v13,19/19] net/mlx5e: Implement PSP key_rotate operati=
on
> >>>>     https://git.kernel.org/netdev/net-next/c/411d9d33c8a2
> >>>>
> >>>> You are awesome, thank you!
> >>>> --
> >>>> Deet-doot-dot, I am a bot.
> >>>> https://korg.docs.kernel.org/patchwork/pwbot.html
> >>>
> >>> I just saw a name conflict on psp_dev_destroy(), not sure why it was
> >>> not caught earlier.
> >>>
> >>> drivers/crypto/ccp/psp-dev.c:294:void psp_dev_destroy(struct sp_devic=
e *sp)
> >>> drivers/crypto/ccp/sp-dev.c:210:                psp_dev_destroy(sp);
> >>> drivers/crypto/ccp/sp-dev.h:175:void psp_dev_destroy(struct sp_device=
 *sp);
> >>> drivers/crypto/ccp/sp-dev.h:182:static inline void
> >>> psp_dev_destroy(struct sp_device *sp) { }
> >>> net/psp/psp.h:16:void psp_dev_destroy(struct psp_dev *psd);
> >>> net/psp/psp.h:45:               psp_dev_destroy(psd);
> >>> net/psp/psp_main.c:102:void psp_dev_destroy(struct psp_dev *psd)
> >>> net/psp/psp_main.c:125: /* Wait until psp_dev_destroy() to call
> >>> xa_erase() to prevent a
> >>
> >> Indeed :
> >>
> >> ld: net/psp/psp_main.o: in function `psp_dev_destroy':
> >> git/net-next/net/psp/psp_main.c:103: multiple definition of
> >> `psp_dev_destroy';
> >> drivers/crypto/ccp/psp-dev.o:git/net-next/drivers/crypto/ccp/psp-dev.c=
:295:
> >> first defined here
> >
> > I will rename our psp_dev_destroy to psp_netdev_destroy.
>
> Are you building with CRYPTO_DEV_SP_CCP=3Dy? The CI build tests will
> allmodconfig. I do the same locally before each push. I can not observe
> the issue when ccp is build as module.

Yes, it is with CRYPTO_DEV_SP_CCP=3Dy

