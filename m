Return-Path: <netdev+bounces-188747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA35AAE755
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 19:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAAD952328E
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E220528C024;
	Wed,  7 May 2025 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b="IwX7XXVm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B44628C03A
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746637334; cv=none; b=Zl6S1V41IZA03v7jxf7VacFOd4C4HNBcXIFcMjF5dA2PsWDP1mPCxz8cowoy0Ux+BYBEer0HEXSS2DlUrKs+if3b2Jt1h4KW3PoT2kXYYbyhbK1ltdIcC3FXGHjtlbfZfegy/IlUBr5nIb/9zcfjaqeUo6sttUllE8Mn6PCCEDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746637334; c=relaxed/simple;
	bh=OcE+GoKOw7LhrCuLbrKh/LcbzJpz8rlGel67AsCJzTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3dFYzOI2Ry9HNT+SYH/WzBCdmv/xwb3YEiSg1EB4pfikywfO3gGM7TVDHN3U3Rr/uJcdW04EvZXwZFieAN6stcpHd9aeRkpw3LOv9l3SJrUDznPcds+enCf1e5GUFn1OnQCN6dZxxC+xsv2acT1k3g98uCzSuPnGnf6cXMhvlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com; spf=pass smtp.mailfrom=riotgames.com; dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b=IwX7XXVm; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riotgames.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30a8c929220so151261a91.0
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 10:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1746637332; x=1747242132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evCH9GiqYG33lbncK47MNfRK8jVnMEAaPU/9KW+jEKQ=;
        b=IwX7XXVmfZBHK1jv7uFvyWJPfH2Ob6HJJku8lJw8iIdD0Qy/IFOPLz8eL3mT2meOAe
         C7kXnRyzAekCUrv1sRAizd2SI6LAG2UFeqg8uPtb/Nn3qBvhNAu0Xz+h0sCFkB996HLf
         t3d0Oy4qyjyx4s0QJjog0S3kCwcuhp7Hbzsl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746637332; x=1747242132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evCH9GiqYG33lbncK47MNfRK8jVnMEAaPU/9KW+jEKQ=;
        b=ZzM9PIbsrOsnR6dL33D6/In1CBvCH4xGZC21NhREhDXVpqJupmxHV6sqOjUQKclhFw
         90f8YXdbnoB1Vt+WyR44rer0RYIaX6i+wnq6nHJizCNXTN2ZMbsWWqf3CA5Sm8H+3sW6
         jmQee1YuLuGqnQV05wzc/8wDTYocAMFzDDKymbUMP65HAlLxoaxjbUX7lvQdw2yGUdfm
         iQ+jatB5eZmzHs2chmHjZLpFiulTdq83gKXwJ4TAWjXSvN/cKE4xoGSF87fn5eCQqAps
         PszBdic2SUMKGO03R2rzczW8iACpKUaAzw4mZJ4W1A/YakDaZ6zz18P7FV5p+D+3aF18
         FL7A==
X-Forwarded-Encrypted: i=1; AJvYcCWrXb4oksCxIiq+tyt5+Xvzz0tLwRCHEZHaW4g6KKFFwrxAyXoJ9eOSiUtdM54Z2NfFKXg9QuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN+W6Gfs5wcV2iREyAt0qBYCwuRr+xSW6cs/svxHckuGs7IslA
	Of3BcLak/OpQaHB2IrFz4e5IHpAsrEhSkhPQfSGFS+M+yQIsqEXKgOYGLpmwlJYsBksLWLEx73c
	UVE4xGRBU558R3mXsaHYaIL4PQsTAcHPfp5wliw==
X-Gm-Gg: ASbGncsVjCUQ8aH3hh6Kox0iqIBC/wKyukMMr+QCLrLxKrqR4vqVexas4FmmmfwiOEL
	LBiA+qq2XIe2JHgK056vYA9HL22Sf+QytfumWl1lUxOgYe36dYTN5tXwJD0TcbSKKXDwCKKnJwY
	lV6iHVw2SzrhnGkw+VO1UJpw==
X-Google-Smtp-Source: AGHT+IGFj5vERsIsOzMMzWHx4KyiQNS3ACFY3x+qC86Qtz4zl4CEaYY14fFJaSflTT3GMneoxBCaK3B2zsphjb3Nipk=
X-Received: by 2002:a17:90b:4f46:b0:30a:9025:84d1 with SMTP id
 98e67ed59e1d1-30aac191600mr6879065a91.16.1746637332399; Wed, 07 May 2025
 10:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506125242.2685182-1-jon@nutanix.com> <aBpKLNPct95KdADM@mini-arch>
 <681b603ac8473_1e4406294a6@willemb.c.googlers.com.notmuch> <c8ad3f65-f70e-4c6e-9231-0ae709e87bfe@kernel.org>
In-Reply-To: <c8ad3f65-f70e-4c6e-9231-0ae709e87bfe@kernel.org>
From: Zvi Effron <zeffron@riotgames.com>
Date: Wed, 7 May 2025 10:02:00 -0700
X-Gm-Features: ATxdqUHeYs9_StQV2Ta3ALi0amyLtmj3B1nixRHGF-7WCF8a8jaznKs7hOx7vKA
Message-ID: <CAC1LvL3nE14cbQx7Me6oWS88EdpGP4Gx2A0Um4g-Vuxk4m_7Rw@mail.gmail.com>
Subject: Re: [PATCH net-next v3] xdp: Add helpers for head length, headroom,
 and metadata length
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Jon Kohler <jon@nutanix.com>, Jason Wang <jasowang@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 9:37=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
>
>
>
> On 07/05/2025 15.29, Willem de Bruijn wrote:
> > Stanislav Fomichev wrote:
> >> On 05/06, Jon Kohler wrote:
> >>> Introduce new XDP helpers:
> >>> - xdp_headlen: Similar to skb_headlen
>
> I really dislike xdp_headlen(). This "headlen" originates from an SKB
> implementation detail, that I don't think we should carry over into XDP
> land.
> We need to come up with something that isn't easily mis-read as the
> header-length.

... snip ...

>>> + * xdp_headlen - Calculate the length of the data in an XDP buffer

How about xdp_datalen()?

On Wed, May 7, 2025 at 9:37=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
>
>
>
> On 07/05/2025 15.29, Willem de Bruijn wrote:
> > Stanislav Fomichev wrote:
> >> On 05/06, Jon Kohler wrote:
> >>> Introduce new XDP helpers:
> >>> - xdp_headlen: Similar to skb_headlen
>
> I really dislike xdp_headlen().  This "headlen" originates from an SKB
> implementation detail, that I don't think we should carry over into XDP
> land.
> We need to come up with something that isn't easily mis-read as the
> header-length.
>
> >>> - xdp_headroom: Similar to skb_headroom
> >>> - xdp_metadata_len: Similar to skb_metadata_len
> >>>
>
> I like naming of these.
>
> >>> Integrate these helpers into tap, tun, and XDP implementation to star=
t.
> >>>
> >>> No functional changes introduced.
> >>>
> >>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> >>> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >>> ---
> >>> v2->v3: Integrate feedback from Stanislav
> >>> https://patchwork.kernel.org/project/netdevbpf/patch/20250430201120.1=
794658-1-jon@nutanix.com/
> >>
> >> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> >
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> >
>
> Nacked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>
> pw: cr
>

