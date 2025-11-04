Return-Path: <netdev+bounces-235447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 793ACC30B02
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 12:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C18518C0B39
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 11:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E332E54B0;
	Tue,  4 Nov 2025 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SLfcYD2v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3902DECCB
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254844; cv=none; b=XfgV5+xpntMMXXFIXLt4ZKDRprK9uaalhUk0KTooq12ChB9FH0R3N41cRSQom0HM4pjw/xeLX/7RiNk8MiF17kloU6by25APF7f/8udOTejw9mu2UOWNKzz9Po6teypedhx+oKamFmpL95gZLFmESIxmKCTZjma288BrQwReL3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254844; c=relaxed/simple;
	bh=it/Jdp7msEglbDWxsnHvWioHPr2s2B4Ga9S1OeFv8Hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCFs75f9UOy0JftkTJytkytLEc9q0n81XcGFEVJeJKXZp0MCnwn5cciO8Zwsfhtf9pYy1bDuM+AZPbVx0jPfJWMEhz75ZjsIIiAPyhs1ZyMs1My3kQ4gk0hY1DZ7INFXPY8S68z5YkyKTK6CDEU7Kq9Wi0MwWTvdU67JmZvDLSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SLfcYD2v; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed0f3d4611so52656091cf.3
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 03:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762254842; x=1762859642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=it/Jdp7msEglbDWxsnHvWioHPr2s2B4Ga9S1OeFv8Hs=;
        b=SLfcYD2vkg0LieR4vomBBxPE1i+xeqGRjyoGAJ10CbXe+0HAEXPcw2ByRSVq1MQnYc
         OYCxrdEd6NH0hfNX7ygRTCTqe49cgHoeUup7VxwVgqhTlQO//gjRFxQ69U8t022BcQTj
         TMNUqmx5mXiOQM3Oa+cGIAuTSKT5k3CceFKNLbTYMBFvfbN/pGU5KgkcXW+dniTx3xOQ
         VO11GlcJM6QdqOJ5kU6Vzs04Fp7cWvU8j0fyovoVBNVHKyq/z1eR1ngkPa6m46IqnT/z
         JF0ny/5WQp8kSvINPqnNPOy5xOAwFjSfKgN8Tu0jtaW0kTMw9QX9ovLcN/QkST3mY54Q
         19hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762254842; x=1762859642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=it/Jdp7msEglbDWxsnHvWioHPr2s2B4Ga9S1OeFv8Hs=;
        b=V+8f/Ygf4NsKjJGxAgbolJNxQaBdWvcM1FbuLuFyHwJENUGEC1aOgWOv9n+RMSet8Y
         6OMbO0WV73ZYR1KerWqR3BX7FXpmcp1D4HXoUj5oADl4lu0zTmT7E/ZuLUmRMuFFncAp
         x1c1syamBXJGbxv69ARMUENdMHf9xjeKWe/SPhSTOxYA10MR9pyNF9/3ycBrW6v6Mcsl
         08n/dwpyJZaAL7tq1EJCYwGO6NBS7r5Q5nd27vPxNrkps7bVC5Sj66hsOQnvYkLDAcme
         jLCzM03hKAP+ryB1sY/fRvh2W8hPa3qOjeqytx78UF3Rccj0PCl6hlMibICOi2rHdDvk
         e9CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpOVmZHGJbXGgEGqtr1RvcTPynrZ3g7PBDXzIahjeedaAhgAXFju4UDCQJ0sOjZEyNOF0uD60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx64hpkWS2cT0SUUJBTyuqFSk1YdwT10SytvAWs1bwAakjYAGM8
	B8Wa84F0DgAdotwEEnrMGNhuhXMC4PJLDXDNqvMfcMToRWCQT2f48vV7Nj8ax31iMTIiDRflQQj
	CfTx9/u91WI9lAvqn9JGXX973YKIysst3iSWm9O64
X-Gm-Gg: ASbGnct/93HOHFbsOJB08NVMNhiiiSjOR2jGUKD8szaA28dwnFfuqvfypXNOmSKkIy7
	UOmPN9c0FHkQvRu3rbrIwYAK0gfrOLoLHvA28yJuR4LgDV51uJbUZ+Sg5Oxl6J33pIDTtqYNvVh
	A/V4SWB+p5Xi1suizKJ5e/KR9nGieBM/ZuKTf3pDD1K+5st0BblBbUSTnQyko4jQJUUXeT/yRyy
	cumeG7UtXgLAgBXitJIKV4LPRgJTQjHGjYju7NodAtPDB98Ckuh1gSZQhYW0aSVffecf8Y=
X-Google-Smtp-Source: AGHT+IHAPnFeWkd76w7kkGmKF4NBtOuZVJA80CKeGkDZGgGocKZ3MAKOixHc8rhHtXRqqUfSB9bRYObMtfxy2aSQOTk=
X-Received: by 2002:a05:622a:4f89:b0:4ed:6c4b:a6da with SMTP id
 d75a77b69052e-4ed6c4bad82mr3491861cf.15.1762254841707; Tue, 04 Nov 2025
 03:14:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103154006.1189707-1-amorenoz@redhat.com> <87zf92nltc.fsf@toke.dk>
In-Reply-To: <87zf92nltc.fsf@toke.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Nov 2025 03:13:50 -0800
X-Gm-Features: AWmQ_bnf2UFo9kFzB64m_l0WwHYhNa_KUKadImPMRiaFA0yATSmMZ69tvLmSTYE
Message-ID: <CANn89i+z0Ti_2m=nGs1xG_88eZHB0-cZG4pMYG+1pQNGCHzREA@mail.gmail.com>
Subject: Re: [PATCH net-next v3] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in IFLA_STATS
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org, kuba@kernel.org, 
	nicolas.dichtel@6wind.com, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>, 
	Cong Wang <cong.wang@bytedance.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 2:17=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Adrian Moreno <amorenoz@redhat.com> writes:
>
> > Gathering interface statistics can be a relatively expensive operation
> > on certain systems as it requires iterating over all the cpus.
> >
> > RTEXT_FILTER_SKIP_STATS was first introduced [1] to skip AF_INET6
> > statistics from interface dumps and it was then extended [2] to
> > also exclude IFLA_VF_INFO.
> >
> > The semantics of the flag does not seem to be limited to AF_INET
> > or VF statistics and having a way to query the interface status
> > (e.g: carrier, address) without retrieving its statistics seems
> > reasonable. So this patch extends the use RTEXT_FILTER_SKIP_STATS
> > to also affect IFLA_STATS.
> >
> > [1] https://lore.kernel.org/all/20150911204848.GC9687@oracle.com/
> > [2] https://lore.kernel.org/all/20230611105108.122586-1-gal@nvidia.com/
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

