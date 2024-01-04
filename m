Return-Path: <netdev+bounces-61622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8C2824696
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCEE1F24130
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5985725119;
	Thu,  4 Jan 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNWcAmAD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E81F2510D
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ba14203a34so501694b6e.1
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 08:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704386911; x=1704991711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgOlYKn6xbvoT7F8HPogu0v5FK9JJcXzpzqnhcjQyFI=;
        b=gNWcAmADGxdVfbVkYJcoXU3xv0fq4jbDbZzG9rU5Ie3/et/7/1GI4a5+1Zva3TJBxF
         2D4X4tSHDsMP1B6jytn3ey6lpZP846lYzEnVe9HZzWS34dssCQ0S9TAilrBNv0d+/y/p
         qWiWEojxUJnKvfPT6ScZseaz6HAiE73FOVVsMo2BtDBesrjNYljXymRbYwhvZNAp3r+m
         JPMy0wujkGaKvvo3wrXhinNlDTm3kPcQtcKFRwGFOUEKnmaFPvDST21n2V2vrzplsEqV
         favo/WVqhuZwCv47Zd0BXnBuiB8tnr8kg/3DfYFqTStw9aJjtfEuLx40CtBBkIT8Fpb1
         6Cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704386911; x=1704991711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgOlYKn6xbvoT7F8HPogu0v5FK9JJcXzpzqnhcjQyFI=;
        b=BpHsGCTlRv3UE33k4BZBc2dQOn/VVP79civRQf51DviVvavBHFiELQ66x8NW/Z73Ud
         aWlkKPSgQn3vauXxkREYvAacd0czNPYsO3HheUaRXdbiU/FF6FYD9tS4en69s97VeS97
         Yac2rmqko+/cI4wc2c7cQr2SFP1bGVa3FXdmMUwtttm7G03Xh/hKx3OqJFceuiNpG0JN
         8/vt/V+UG1GOAgOhx0EGm0YYEqFMzjnWq7eD83gRE+RJYwTruxcwXuC1tPhbm4cWx7kE
         nxWn0Y1YnT3ZkGosm6JZmpoZE7hUexx5CfD5THm92t7txwPAvHLDtforygTT5Z2i8bw4
         UE/w==
X-Gm-Message-State: AOJu0YxY33A5Pvr//3TsiIqSH+ADmw8we+C/eYuKVqUMMJPCz4P3/Dwx
	RnLvsmig1y1dlcYYRpfHrfFGCxLGE6VCsKqTz7M=
X-Google-Smtp-Source: AGHT+IEZi4QDa5k0Idsk4Yib/75NHayi8xEXDG/vV3z1LTJVlBImUsV6XBSp/+NoCaH5hTi9aPBeCjfbBKvgPAID6ZU=
X-Received: by 2002:a05:6871:aa12:b0:1fa:f6e2:6fce with SMTP id
 wq18-20020a056871aa1200b001faf6e26fcemr914421oab.33.1704386911002; Thu, 04
 Jan 2024 08:48:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228081457.936732-1-taoliu828@163.com> <20240103174931.15ea4dbd@kernel.org>
In-Reply-To: <20240103174931.15ea4dbd@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 4 Jan 2024 11:48:19 -0500
Message-ID: <CADvbK_euHyYmBSUGUCBsV13b8EU8HLe=Z0jZq7nysUP1qQwzRQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_ct: fix skb leak and crash on ooo frags
To: Jakub Kicinski <kuba@kernel.org>
Cc: vladbu@nvidia.com, Tao Liu <taoliu828@163.com>, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, paulb@nvidia.com, 
	netdev@vger.kernel.org, simon.horman@corigine.com, xiyou.wangcong@gmail.com, 
	pablo@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 8:49=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 28 Dec 2023 16:14:57 +0800 Tao Liu wrote:
> > act_ct adds skb->users before defragmentation. If frags arrive in order=
,
> > the last frag's reference is reset in:
> >
> >   inet_frag_reasm_prepare
> >     skb_morph
> >
> > which is not straightforward.
> >
> > However when frags arrive out of order, nobody unref the last frag, and
> > all frags are leaked. The situation is even worse, as initiating packet
> > capture can lead to a crash[0] when skb has been cloned and shared at t=
he
> > same time.
> >
> > Fix the issue by removing skb_get() before defragmentation. act_ct
> > returns TC_ACT_CONSUMED when defrag failed or in progress.
>
> Vlad, Xin Long, does this look good to you?
Looks good to me.

It seems that skb_get() must be avoided to use before ip defrag,
and also I see no reason to keep the skb if defrag fails in tcf_ct_act().

nf_ct_handle_fragments() is also called in ovs_ct_handle_fragments()
where it doesn't hold the skb.

