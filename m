Return-Path: <netdev+bounces-224382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF04B8440D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63DD4A0855
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4006D301466;
	Thu, 18 Sep 2025 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZflD9WoM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD552F60A6
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193232; cv=none; b=P/z2HkLEXjhxmQK6FE+BEFM0h2w1aI7XxHZMZ6luSfx7iDiFvaXtjiZ4z5EYDKMg4ZCz9pyeSRSSPf/jAhnPjzcNGfKjNYyE+N7km+xLSYFrU3XVMjnGm0v+G/MYoQNp3ooe6HDfRVZQP3YSiW8H48W7YkC7QIdL2KP7J02VR3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193232; c=relaxed/simple;
	bh=1vJOiUg12eOw9SKaR/xyTrh+bc5LbnK/5rBq3fmB4XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exwG7MYenrcZYGTsa5PJN6jLhivlrHRzHRx2WaA4z0pGKhe4BhfflmbQ3yBeEG3xwBAttwPLokDNKaK1V5h4GAdJ8D8vLg2zfBQkyS7I0vGJHjtn01R/zkhV2nUrwDUT1ookSty17ZeorjuuvuadfnaW4g8Lr0Wfs+TRC5Ir0vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZflD9WoM; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b3d3f6360cso8162141cf.0
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758193229; x=1758798029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXX9Pd07gBMtRdpX7laTywvFXTkQX5wlfDb0swVx5yc=;
        b=ZflD9WoMuhwT+43LAOuJEmNMRSEdAGywx5dElJC+9C/ZqEuaQHB3Gf2NDmor8kdiU6
         hEVpt+7+p5CCwONt7Fpv2P9+JE67jZ1YfJBSPrgXvSrpks20+lKXQ3jXaKOTzD3f1Zk6
         3m88ZPKyEF16W+XI9/gxb3GEJ2x9j8TdF1BHDrpSJviylSDkyWbcqIa0TPNHmF6cfNSY
         qn6awUJcZvj+GEp0Y9rCITJMkelu5Ebm2TOHJ+wxxmmCW181xbMcqa1yXkFFxxAY8N0+
         8kXDfLwJ7/B4cnDz6MvXNH9vRB50u6ih66DalWPXY3BkvIei9Ljk/YZ46AYpKafMEmj8
         8vOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758193229; x=1758798029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXX9Pd07gBMtRdpX7laTywvFXTkQX5wlfDb0swVx5yc=;
        b=Bsg2WwlCH2t5Z1F6KhVls4UlLEVc/0AZPbeW3NWhquKNUNEMfjekfGU51d8E9y7nhV
         FT89zLyklZ+qwHeCpnxHzoCa7E+Ex9mi9AVCnYzeVcePhfaAWzphU/rNSA5OLr6f5MoX
         W7dMySIRW+Xd1IiMVgMNt4Xf3JUo38NTnBsjr1Ktm7CHgKv45cJJsHQbVKALP2qubhtV
         UqPcElQwXRZHbmNM6Kj/+w2Aj249/3dXXdQUNddkahcorcVoqGuSM+0PfJzyVBzgCD6B
         ELydzQACtgQp5VMkqFVPsB0xmTofKlOm5vsDnTVO794+OvOXAWDq7idNTQkSCsKzNb/F
         3NIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqP0Kep6jRa+GtGj0LBPHgPYJgYNNlSIj0btL/sGQ3E4wDkEO6okr80talnyKmHnlR5wkPSxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4UOyqxcYB/5xaWHRJBG7wB2T8s/ZoGOi34T1uG23iUWtgCCkG
	Wx6FayN+0DjU/+VVbMAv/t1LgGEhAiFtbdHPtlyV2aIhuYlT4CO1K7KetaTrskW4tdBiut/Im9M
	VJaYTsqgukOA4RZggosdpJWgZ3cJiF6L1SZsqKeIL
X-Gm-Gg: ASbGncu7oLFicjV5vR4b9g2V30//pbxkEZhE1KUJS8rQ8NpG+Y50qJ+HAmURGJyf31m
	f0b4PbTBHloek7BHD0Uu03Vr+BADCKDF1bIabCrvjdviJx3mONm28gnLavoLgrj3JgKZPAQAAtS
	rUNrgSLCjyy62bNIfI0qavWGlE6sAosdqW7Klq6pDweDIH0o1sgmI+0KcciwL44vMt3Nr6UH4Y5
	afMz9ahl0IbPRH9AXWskhXGeul9M17y
X-Google-Smtp-Source: AGHT+IHw4wX5s8YhuxS+d3J3MvBKiIlVhPalyIEnmHbfLRME8wdoVUP/exuT3945oq+nQ/GlrXZ3XApw00klZKNZMjE=
X-Received: by 2002:a05:622a:40ce:b0:4b7:a8ce:a419 with SMTP id
 d75a77b69052e-4ba66e0c45amr57172341cf.26.1758193228590; Thu, 18 Sep 2025
 04:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917000954.859376-1-daniel.zahka@gmail.com> <175819262850.2365733.8295832390159298825.git-patchwork-notify@kernel.org>
In-Reply-To: <175819262850.2365733.8295832390159298825.git-patchwork-notify@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Sep 2025 04:00:16 -0700
X-Gm-Features: AS18NWAWlAgMHoG6y9ufZXhFoFwYo7GO6OYKGdvyuZjKM0Mjoi9Jr4mcU6VQzdk
Message-ID: <CANn89i+ZdBDEV6TE=Nw5gn9ycTzWw4mZOpPuCswgwEsrgOyNnw@mail.gmail.com>
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

On Thu, Sep 18, 2025 at 3:50=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This series was applied to netdev/net-next.git (main)
> by Paolo Abeni <pabeni@redhat.com>:
>
> On Tue, 16 Sep 2025 17:09:27 -0700 you wrote:
> > This is v13 of the PSP RFC [1] posted by Jakub Kicinski one year
> > ago. General developments since v1 include a fork of packetdrill [2]
> > with support for PSP added, as well as some test cases, and an
> > implementation of PSP key exchange and connection upgrade [3]
> > integrated into the fbthrift RPC library. Both [2] and [3] have been
> > tested on server platforms with PSP-capable CX7 NICs. Below is the
> > cover letter from the original RFC:
> >
> > [...]
>
> Here is the summary with links:
>   - [net-next,v13,01/19] psp: add documentation
>     https://git.kernel.org/netdev/net-next/c/a9266275fd7b
>   - [net-next,v13,02/19] psp: base PSP device support
>     https://git.kernel.org/netdev/net-next/c/00c94ca2b99e
>   - [net-next,v13,03/19] net: modify core data structures for PSP datapat=
h support
>     https://git.kernel.org/netdev/net-next/c/ed8a507b7483
>   - [net-next,v13,04/19] tcp: add datapath logic for PSP with inline key =
exchange
>     https://git.kernel.org/netdev/net-next/c/659a2899a57d
>   - [net-next,v13,05/19] psp: add op for rotation of device key
>     https://git.kernel.org/netdev/net-next/c/117f02a49b77
>   - [net-next,v13,06/19] net: move sk_validate_xmit_skb() to net/core/dev=
.c
>     https://git.kernel.org/netdev/net-next/c/8c511c1df380
>   - [net-next,v13,07/19] net: tcp: allow tcp_timewait_sock to validate sk=
bs before handing to device
>     https://git.kernel.org/netdev/net-next/c/0917bb139eed
>   - [net-next,v13,08/19] net: psp: add socket security association code
>     https://git.kernel.org/netdev/net-next/c/6b46ca260e22
>   - [net-next,v13,09/19] net: psp: update the TCP MSS to reflect PSP pack=
et overhead
>     https://git.kernel.org/netdev/net-next/c/e97269257fe4
>   - [net-next,v13,10/19] psp: track generations of device key
>     https://git.kernel.org/netdev/net-next/c/e78851058b35
>   - [net-next,v13,11/19] net/mlx5e: Support PSP offload functionality
>     https://git.kernel.org/netdev/net-next/c/89ee2d92f66c
>   - [net-next,v13,12/19] net/mlx5e: Implement PSP operations .assoc_add a=
nd .assoc_del
>     https://git.kernel.org/netdev/net-next/c/af2196f49480
>   - [net-next,v13,13/19] psp: provide encapsulation helper for drivers
>     https://git.kernel.org/netdev/net-next/c/fc724515741a
>   - [net-next,v13,14/19] net/mlx5e: Implement PSP Tx data path
>     https://git.kernel.org/netdev/net-next/c/e5a1861a298e
>   - [net-next,v13,15/19] net/mlx5e: Add PSP steering in local NIC RX
>     https://git.kernel.org/netdev/net-next/c/9536fbe10c9d
>   - [net-next,v13,16/19] net/mlx5e: Configure PSP Rx flow steering rules
>     https://git.kernel.org/netdev/net-next/c/2b6e450bfde7
>   - [net-next,v13,17/19] psp: provide decapsulation and receive helper fo=
r drivers
>     https://git.kernel.org/netdev/net-next/c/0eddb8023cee
>   - [net-next,v13,18/19] net/mlx5e: Add Rx data path offload
>     https://git.kernel.org/netdev/net-next/c/29d7f433fcec
>   - [net-next,v13,19/19] net/mlx5e: Implement PSP key_rotate operation
>     https://git.kernel.org/netdev/net-next/c/411d9d33c8a2
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

I just saw a name conflict on psp_dev_destroy(), not sure why it was
not caught earlier.

drivers/crypto/ccp/psp-dev.c:294:void psp_dev_destroy(struct sp_device *sp)
drivers/crypto/ccp/sp-dev.c:210:                psp_dev_destroy(sp);
drivers/crypto/ccp/sp-dev.h:175:void psp_dev_destroy(struct sp_device *sp);
drivers/crypto/ccp/sp-dev.h:182:static inline void
psp_dev_destroy(struct sp_device *sp) { }
net/psp/psp.h:16:void psp_dev_destroy(struct psp_dev *psd);
net/psp/psp.h:45:               psp_dev_destroy(psd);
net/psp/psp_main.c:102:void psp_dev_destroy(struct psp_dev *psd)
net/psp/psp_main.c:125: /* Wait until psp_dev_destroy() to call
xa_erase() to prevent a

