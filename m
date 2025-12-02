Return-Path: <netdev+bounces-243324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFEFC9D196
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 22:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48BD34E395C
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 21:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DF92356BE;
	Tue,  2 Dec 2025 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6EVjm4C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0D2E40E
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764711258; cv=none; b=pUis4j6fXYosSDm37yT6Pqliffke7JXz0Nezh8cK30XvaFjO1wMCZIWcCieOVCcjtCN9iBwnyEmfC3pK+hdwWbSJlEpXLnuWqUjLhPlVPLlcLKqBbPkXcUFmH0EGlyftQuukXrj/b3FkHHtZgEpxTE//mpLnH7NTR1pYQbjugYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764711258; c=relaxed/simple;
	bh=EmsEwczpiaola5ElXtwfAQVzqSInkvOEzVpRacRlODU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=W6jA8BvflnZmXaeaF7Bn9AKRG8QlmYYC1HiPD4Bx+79QJm9AQggm+M+25GjIDSklgdeZE4+RMWk+EkmIbzZlUsKsRIeuNFoO+Ja/N2sFvcoOxqey0seXzOhkUCFsB9kpXaCDbcR4JCIbRHVsRNqvDi/4ZtVNmuUQ6+pGXdqvpFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6EVjm4C; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6432842cafdso5479761d50.2
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 13:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764711255; x=1765316055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6hK9g+p/96n31OO0B26q4tuOLGZA8/pIAPxrIeRCzA=;
        b=C6EVjm4C+u+NzFg06wkBmy1KyggR4/SAhzSIPth28RiWlELyWI7qTZGD5NooCpRcrc
         jnmwPptH84aVuMIESKdGpuXfpxb5JQeAho0z//qeqVURrx4Q60t8+x6is70NX5AI+bqM
         rmKo4ld/vKr6LI2YhOqPkHXcP02VfISUXE2SRXYv+6+5+ZTdI2Bh7QY3pAe93s1iVgln
         F5VgAnoW4UFK7IhaF56tDcWG5SQf7AT6RLGxGoxzQhsEXxiOZkTeNi/HBpzv7ZgRaRvI
         xLOlqqPNruGDZ4KBOwx5yGR/RZJEpQBWO/qmqdq+5QL0AztjfrIO0luXfkKHIm61yGZi
         Brsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764711255; x=1765316055;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g6hK9g+p/96n31OO0B26q4tuOLGZA8/pIAPxrIeRCzA=;
        b=VwMfkmMpQ8VITuCkEDmHFHQkR0dILPAj/JubOodPkrT5VTmFvwu9xFdiD5UlgV7Wh4
         UmRRdrU0YYLXokQB4PkoGF0CfuAh4na5gEuMXEvotOp8+iJ8VYNk0Oj3lNw+gRaud90u
         JNwJiW8CWR/jZ+DnzVjZRGg3YxAEvAigM6CWfSqcCGFC8QBy8qRsa4H4UuhM2NwtjlUU
         whIGCfLy7ukgp7wtrH97XgstBgm9rpTM3QStuUPmOW/gVquAzDiZtN2FKmSQIhZq35Jm
         ursxR/cE8ZQJQVzdzJj9CMS1Zg879TIs1MjGxqL1jjvJTFC+84y5BXFY+28ZVmFB/SnW
         GVVA==
X-Gm-Message-State: AOJu0Yz31Y1V3jyAZJDsheggH6uPgRKlkeCA8dEbZn7Rb7QYPLLFfnFD
	obC8vrzrlsIB+DVXitJSyFdwuHNFmNDDxkP6iHN1bCzO2JOLbXn0jPO5
X-Gm-Gg: ASbGncthiBK9EPtA0KUsqfz2lO3vSZU1GyyBsfsSFEWEJoWJEzz0UUall0ifrqDRRiv
	Bmsn/KmkKaST5HTVXS7vE39IGLSFpnTh8JW+Tq4A32V1P5A/DwDM0q1MsEu/iqZBiouhQTLe0CV
	MlnA357ymq+ARCfL1Er0lHqMPrj8peGyzXgLbFvVe+65qCtTw73w7Jmh0U8nyeHv1ci/v7pjz3p
	mKcBSox2gTOWmjrxLgMyCd3OOfp9sIazcOJt1ud5rLrBjy27VwdAUU4Maox/WXyUYNZ1dsYiYZG
	URex4TRzkX2o8NVtIc8uEZ/egdj5H/13mbIED9feLZHyIotMC00OIUTBFjVEj+T0SWH8Ul21fDm
	0JrioGM+sKtDAUWszVold7/B9Y1u7SrpbMi/8QwJv/OmsZXlfV0RzooYEwPFmfqKfKMm3TC5pio
	6yP49sCKn1ETXjZxPFiMX1qusndNjASkyb5AFEN9FUTIy4XcRqN9FAh+fPuRBsA0Dei74=
X-Google-Smtp-Source: AGHT+IHPXxH0QF+SOImMEvLWKUCEjNm+rj/AdZon1NUTUlPU12GKLqZILkKfyLi49mbAqJ0CdLkdXA==
X-Received: by 2002:a05:690e:1387:b0:63f:bb1b:b617 with SMTP id 956f58d0204a3-64436faf39bmr162816d50.8.1764711255492;
        Tue, 02 Dec 2025 13:34:15 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6433c4692a2sm6541931d50.17.2025.12.02.13.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 13:34:14 -0800 (PST)
Date: Tue, 02 Dec 2025 16:34:13 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jon Kohler <jon@nutanix.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 open list <linux-kernel@vger.kernel.org>
Message-ID: <willemdebruijn.kernel.42db6f47db6d@gmail.com>
In-Reply-To: <F48BA9F9-7E15-49B3-896A-5AE367DAD060@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
 <20251125200041.1565663-4-jon@nutanix.com>
 <willemdebruijn.kernel.1c90f25a9b9a9@gmail.com>
 <F48BA9F9-7E15-49B3-896A-5AE367DAD060@nutanix.com>
Subject: Re: [PATCH net-next v2 3/9] tun: correct drop statistics in
 tun_put_user
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jon Kohler wrote:
> =

> =

> > On Nov 28, 2025, at 10:07=E2=80=AFPM, Willem de Bruijn <willemdebruij=
n.kernel@gmail.com> wrote:
> > =

> > Jon Kohler wrote:
> >> Fold kfree_skb and consume_skb for tun_put_user into tun_put_user an=
d
> >> rework kfree_skb to take a drop reason. Add drop reason to all drop
> >> sites and ensure that all failing paths properly increment drop
> >> counter.
> >> =

> >> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >> ---
> >> drivers/net/tun.c | 51 +++++++++++++++++++++++++++++++--------------=
--
> >> 1 file changed, 34 insertions(+), 17 deletions(-)
> >> =

> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index 68ad46ab04a4..e0f5e1fe4bd0 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -2035,6 +2035,7 @@ static ssize_t tun_put_user(struct tun_struct =
*tun,
> >>     struct sk_buff *skb,
> >>     struct iov_iter *iter)
> >> {
> >> + enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_NOT_SPECIFIED=
;
> >> struct tun_pi pi =3D { 0, skb->protocol };
> >> ssize_t total;
> >> int vlan_offset =3D 0;
> >> @@ -2051,8 +2052,11 @@ static ssize_t tun_put_user(struct tun_struct=
 *tun,
> >> total =3D skb->len + vlan_hlen + vnet_hdr_sz;
> >> =

> >> if (!(tun->flags & IFF_NO_PI)) {
> >> - if (iov_iter_count(iter) < sizeof(pi))
> >> - return -EINVAL;
> >> + if (iov_iter_count(iter) < sizeof(pi)) {
> >> + ret =3D -EINVAL;
> >> + drop_reason =3D SKB_DROP_REASON_PKT_TOO_SMALL;
> > =

> > PI counts as SKB_DROP_REASON_DEV_HDR?
> =

> Are you saying I should change this use case to DEV_HDR?
> =

> This one seemed like a pretty straight forward =E2=80=9CIt=E2=80=99s to=
o small=E2=80=9D case,
> no? Or am I misreading into what you=E2=80=99re saying here?
> =

> Happy to take a suggestion if I=E2=80=99ve got the drop reason wired
> wrong (or if we need to cook up a brand new drop reason for any of
> these)

I agree that it's a clear case of the buffer being too small. But I
consider PI not part of the packet itself, but bad device headers.
It's borderline nitpicking. With that context, pick which you see fits
best.=

