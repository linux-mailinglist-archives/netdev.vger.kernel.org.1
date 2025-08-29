Return-Path: <netdev+bounces-218133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A240EB3B3B7
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 08:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551EB3B517E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 06:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D91E25FA0E;
	Fri, 29 Aug 2025 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xpRvFsf1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07836223DD4
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756450686; cv=none; b=tAJPkbLGyhI8BmjhvlZ3wSEpKEbD4gAAYo0BdNEl7UycH6Ris5T/248ubI8JtrTEil4OsWclda6mcPorSbN/Bjvym19xL6ZbVm+5qmkuU+PO5EQtDU8ty+oZc/LLAwDvbAnxd6osONhDbYnOQ9WmS5qMpXdXPSR2kys0Txii5rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756450686; c=relaxed/simple;
	bh=3rOtzOHHDPq9HSlzNqzDGA+DghFk+f2ADdPUgAC3LDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Si3R2hSDyxI/4yJ0KX/ku6rs4EWSxMfqdRcv9e1Z7Ax7XbZIiQFutJVhKMXgGshCbZWQbHn9ayJgM+WKNzAZ3JBvCTPQo+K0wjS3CObRKzQDEUB59qNfc8QtrSDD50pI02t0z1Aw/OO1N86pG2KDYFLaoTilWKNYyQzOTCeH3Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xpRvFsf1; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70ddd2e61d9so20588736d6.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 23:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756450684; x=1757055484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GMOgBCXCpSurXEEo4IwRVHqSvR1GSKXeReRAqFAB8o=;
        b=xpRvFsf1Jceku5kyKw5xqVSiuiXMyThfgT3Dgas2klTU3dA65r2++fLYHrEICxkQSY
         luSc6eN9nfv1+4EShPs9tUnWqlNZH9UpfPKsBryEZ1syZOn4ymXCoJkqQyP4PrcuPrSf
         PY3aupPe1dt61ZgPE47amfr6M87S/H++QHE1o3jENm6Vm0xKOnxboHBkFnjMN4joUqTO
         bEkQpPYaNbHpKkbOqsEJ0TbpfpO7GRk0iKdn9nKwdpMmuaUaRpb6Gzc0LTVPuuHM2apB
         tIbYND6T7A+9/5B9DOsXLJIPCDcg7OkRs/yu3a3aujIf0do2DvxBK3sMAeviu/K4aljh
         +s7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756450684; x=1757055484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GMOgBCXCpSurXEEo4IwRVHqSvR1GSKXeReRAqFAB8o=;
        b=v2ArSkCWn0kyUMNcHVoMl3iw19+G1Uq5UiDwhgIhry3O4xkkxcnQMfcvGNtCQeo9/r
         s0Qrl2O8GKUqxpda56Hds3t1TVeyoz0uzSetbOydlowCbsyjRsoCkBI3MnC1hIzkAUyB
         FWNUyGMFkTDG+hLghEvCD7W519osWzbzOEPzU1+DH0zod9yX9BVP16uiVRnxYIRu1GBl
         AZwy5+TuFTs722tM3eiJD4p3qaDZddCuJ5pAW+PVn5Ty8WpvcFaLts13n43z3YnOP5o+
         9ZNsKI3uv9wJxjPYTzFI8cvyRK42p54tyQ55q6avDCx3DM5J7b53zjWLoz6frZ4vKhOT
         mFxg==
X-Forwarded-Encrypted: i=1; AJvYcCUgzBT38YGNDo99LqOjS4jwBhmukb8r8bd36Ab+EeloV0i+WO1wkRLMwekO9froBtKPGP6byWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4n0JKv0JAgN2XdxBtMYFDthaDzTPRht8D7nqEdEpb8pdUDCJ/
	jBrzA6Y3Qv3tdceLiPoRvw3ytsI9jXMY4Fs5V7XNhrGEooMTGcRpPq9bCASROecHdtA2iyIrVQ2
	8y+rcIsMuj45cGpTu96UI0EO+nWn07fZvB/QERYFl
X-Gm-Gg: ASbGnctOvt3ttWrAdrMwWNf3rdLpW5RUCCi5JgGBLgE/90XOtiUgnUtO1MlMrSteLYp
	RbC39OEPUkuqQRg6Uomuoun49zFzoU1UmHVEp8vDA1VsUdYR8tMDE2Boq2aH/Pz19B9jxcHD4rp
	FNfeUt7mrg5/4HSRaHlITK7RI4n90BAgBZ66pMZNcKvPF1Vp6rsiZegv5i6NR4Ixlx/BmSJsFZZ
	AoiL3IzgbuJ
X-Google-Smtp-Source: AGHT+IGS7ic8R6PYbx2irn9yeGve2sr/HFbNUxO0hORen32grEwr06iAE6KRKdvMY+og0tAvccye+BfR/H8H2hBLxHk=
X-Received: by 2002:a05:622a:148e:b0:4b3:741:2e30 with SMTP id
 d75a77b69052e-4b307413398mr40030321cf.9.1756450682677; Thu, 28 Aug 2025
 23:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828164149.3304323-1-edumazet@google.com> <20250828164149.3304323-3-edumazet@google.com>
 <df07de96-5b35-4e64-ae9d-41fcdb73d484@huawei.com>
In-Reply-To: <df07de96-5b35-4e64-ae9d-41fcdb73d484@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 28 Aug 2025 23:57:51 -0700
X-Gm-Features: Ac12FXxDodk7cVRVRyrit8t4Io0T-rS8nBWSOadSjni3N-LbmknC1SlJE6t_DGg
Message-ID: <CANn89iJvMWSuuPmYG2GojejXcx6uaHEGH5hq3TKRP0QUhK_OZA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/3] inet: ping: remove ping_hash()
To: Yue Haibing <yuehaibing@huawei.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 11:47=E2=80=AFPM Yue Haibing <yuehaibing@huawei.com=
> wrote:
>
> On 2025/8/29 0:41, Eric Dumazet wrote:
> > There is no point in keeping ping_hash().
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Reviewed-by: David Ahern <dsahern@kernel.org>
> > ---
> >  net/ipv4/ping.c | 10 ----------
> >  net/ipv6/ping.c |  1 -
> >  2 files changed, 11 deletions(-)
> >
> > diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
> > index 74a0beddfcc41d8ba17792a11a9d027c9d590bac..75e1b0f5c697653e79166fd=
e5f312f46b471344a 100644
> > --- a/net/ipv4/ping.c
> > +++ b/net/ipv4/ping.c
> > @@ -67,7 +67,6 @@ static inline u32 ping_hashfn(const struct net *net, =
u32 num, u32 mask)
> >       pr_debug("hash(%u) =3D %u\n", num, res);
> >       return res;
> >  }
> > -EXPORT_SYMBOL_GPL(ping_hash);
>
> The declaration should also be removed
>
> include/net/ping.h:58:void ping_unhash(struct sock *sk);

Right, but you probably meant

include/net/ping.h:57:int ping_hash(struct sock *sk);

