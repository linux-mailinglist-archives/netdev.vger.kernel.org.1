Return-Path: <netdev+bounces-237938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB2DC51CDF
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E695B3B2BDA
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C982F23ABAA;
	Wed, 12 Nov 2025 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ctUSWSzT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5762D8DB1
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944515; cv=none; b=KRS3QKXtlf2TTya2YOASM7HiAWMGK+ju9hBJat4AkOvmSyYnGakoF7si5Y8oGKMocihWhxwVRiBUyEFYU3GGnL0XNsabxY4tHwFohCXFkYTNBo4yPcMa5hr7womZm7qeLikQhRZL//NAXKvGGE0jLqZ8w24mHWo+dG5xzisoxoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944515; c=relaxed/simple;
	bh=/+aa6fDPTYj+qjzn67oNXlnYeeWJI8tJYBESafgTCLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfPLMaRb/U5bPefYj6sJFYW+PrJoPnw8grcWJb3MOnZyUVEh0esRSUGNFIwqxlOrbFvnyj5bCuKwtfhZz98YRLUvFC5NagHk7ZAqI6cMuu1hpj9mXc2L2d8gBLvaEGDcncaBY0wm4aqWT9KNjdj1x96u5HQSpAXlvwtbYm7wrTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ctUSWSzT; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3436a97f092so842097a91.3
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 02:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1762944513; x=1763549313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtWqGtULi5t1U9ILc6RI8y0vqCYzk5D39MUDHMoZVxQ=;
        b=ctUSWSzTCMNMmGL9Md44P4eP28Ha05/o6+2r8o0ZUcn8/DOj1nn0l0ZjMhKia+b6QR
         FDRFUInXnByeX4MeQU4aOoLkRtufShmFsEDwjClVgRJ/8Xo/WSVhm3b38ImXDr+ms106
         QWSR8Yt/Nk60qnhC9GfCrlW67IAl+fSi/25amd89qvqLD4RaqjTNMX7OR6dGrgEZ3GwI
         NDKX2lFNKy6r4B01tsq3ltASEwB7R0WBPbiHhtAnz3NRgt8Mw0hyL2pGHUa4mBk2DqLA
         eISp75aiHapF7Hdwrayk0s6XN+GgktAB0+lwL45lXCO7/9YhWPD/C+wgY76TbRVUmVUB
         gAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762944513; x=1763549313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mtWqGtULi5t1U9ILc6RI8y0vqCYzk5D39MUDHMoZVxQ=;
        b=VjdfVoNrWn8NNQwYlJba49rnsHCldNkhDg8W27Y7ebBVY5XJ3Q0JT95e1zsC914PLi
         QaUXYSQ3lwzKMrt9wsEZ8KP5oDxRaFmNj2vrRste365wwast6bCWkThjclQHf4vr92/Y
         bHUAJJPo4c9DIxIcq7OkOQdWRD6iygqCbPUmyhpXywCKnOctvJZVCtc0f+FIQaZxXxQ9
         sewXTWxBBOMoqxm3KfSz7S+OVJqCUCUkFSz2sqMdbZBqMmJhluEjw0kDxvYMP6r7yrfr
         UaCl4EQeiGb1w2g/lrPywuFvlOZyhwgQY+irQ9kKTwppNWnujFgpZeYT1WENoQGCmsyp
         2cDg==
X-Forwarded-Encrypted: i=1; AJvYcCUJITyeELnA9ERwjCImFGlWbW4HmFxNF4h6g31eEc2ifizGrHH14hBjkS3Xuf7DwACyH8RWKzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMhKd6sj+A8P7cm9wrKkN4lIHjT1INR4aWmuFiWIAGotS5GYgX
	kDhPAQ5mi6kdAjo5loq36+EHXdnDv442COnr+zx+Nu9Nup5nmjRsUg2XdpKEjmsIZDKv5QifXcP
	9Y2lCWW8qrCX2u4mOYX5+4rD/OwMVluhPX+NEEDpe
X-Gm-Gg: ASbGncsC8kHMd9AYVZ0cS/7MkjzP3bJjPL0h925Ztc4QyxOHDaxQlsDGA40qeKEI9fU
	2q8lmowRId0VtrQOAJ+yDww5L+1WsSL6NtEvLN1W/H4YzH48xqQELwDp30NHyg4IMjDHdEd73vA
	aTIQWOEe8pI89ipg74YDD3VUqX69uKmnB3zzdt0+uJqqoptiJlnCm6/pdc6Q0PALaRcFkAoEJjU
	eCXXVymgE5B6YCCuAvVMnP9xXgJMg9VKaOqnXCTAM4rrfD2/BpCj101N8rlgihIxxyafD/PpX/4
	Lyw=
X-Google-Smtp-Source: AGHT+IHjY6QQ/hXiL8gNJwMs6BAbuYYs2wjVJm11YnOI4a9isY5eBtqYo1pfzv8eFKkTIgzLqOZOH7UkDi41nFB29gk=
X-Received: by 2002:a17:90b:3943:b0:340:d1a1:af6d with SMTP id
 98e67ed59e1d1-343ddefee62mr3130904a91.36.1762944513524; Wed, 12 Nov 2025
 02:48:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109161215.2574081-1-edumazet@google.com> <176291340626.3636068.18318642966807737508.git-patchwork-notify@kernel.org>
In-Reply-To: <176291340626.3636068.18318642966807737508.git-patchwork-notify@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 12 Nov 2025 05:48:22 -0500
X-Gm-Features: AWmQ_bnHComti2QeZEYOkFv0a1p9BnUFG8ZGieRlZgS6HdYEpIQTlXBNjwFefCs
Message-ID: <CAM0EoMkSBrbCxdai6Hn=aaeReqRpAcrZ4mA7J+t6dSEe8aM_dQ@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
To: kuba@kernel.org
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net, pabeni@redhat.com, 
	horms@kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	kuniyu@google.com, willemb@google.com, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, hawk@kernel.org, patchwork-bot+netdevbpf@kernel.org, 
	toke@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 9:10=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
>
> On Sun,  9 Nov 2025 16:12:15 +0000 you wrote:
> > After commit 100dfa74cad9 ("inet: dev_queue_xmit() llist adoption")
> > I started seeing many qdisc requeues on IDPF under high TX workload.
> >
> > $ tc -s qd sh dev eth1 handle 1: ; sleep 1; tc -s qd sh dev eth1 handle=
 1:
> > qdisc mq 1: root
> >  Sent 43534617319319 bytes 268186451819 pkt (dropped 0, overlimits 0 re=
queues 3532840114)
> >  backlog 1056Kb 6675p requeues 3532840114
> > qdisc mq 1: root
> >  Sent 43554665866695 bytes 268309964788 pkt (dropped 0, overlimits 0 re=
queues 3537737653)
> >  backlog 781164b 4822p requeues 3537737653
> >

Hrm. Should this have gone into net-next instead of net? Given that
the changes causing regression are still in net-next.
Dont think its a big deal if the merge is about to happen and i can
manually apply it since i was going to run some tests today.

cheers,
jamal

> > [...]
>
> Here is the summary with links:
>   - [net] net_sched: limit try_bulk_dequeue_skb() batches
>     https://git.kernel.org/netdev/net/c/0345552a653c
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>

