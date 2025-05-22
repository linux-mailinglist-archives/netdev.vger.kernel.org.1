Return-Path: <netdev+bounces-192527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E4AC043B
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 07:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07D94E1F4A
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 05:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970B21C245C;
	Thu, 22 May 2025 05:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="DUypTwfZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE161B87F2
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747893043; cv=none; b=pCFKkPa/ZoxFhVv2+EUISd90sdZjjdWwUcBna7aMNLZlff7xkIJy7cQnrFAtztTDTm3d47WFBV/yJhbb39VCUvihLo0xP+9cNp4TTa0gs6g0DmUznEBJNPLcydXu9qwYiBHM4tuqOpSK2psqkv5OW4PyE9PBpqs25KPxygk6uB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747893043; c=relaxed/simple;
	bh=YV50GskFXJ2ev8Z/3nbduah3VMCBmsDUNg2rJH5F6ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC4DIp1gGrJ7ONQsffDbdF88gCo8g+Xhz+Cbp9n0DzTuaMHfQoCIPw1nmY8vawdgF4HY0SS+d/Km/PUEBHlhfj+dN61PkVxaF6OlnbDfEL6ydFnrE90LIv/3xq8i0hhC9Z4v0G62sdq2OGhPo87BMVRMOhPdaoGxwso7SvOhk0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=DUypTwfZ; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e87DkCF/t3p+UP6FVSaRezF0+54RjunM8iUL/ZuLnUg=; t=1747893042; x=1748757042; 
	b=DUypTwfZ9r1AruMhzmMy98yuGp4ERYAUEbzEpPwNM9WFL+cXOfpKFxV0eH+LPJ5K631fTrR/rqk
	8x5LImbpTnZTOe1lTmfNG/9Nk8Ny6uxntj1W8KUNP9QL9NSVDNxrAjH5fZIlvLwBPUyBIfpiQiT2P
	uRzQe119rZPBfK12iUKVRUrVO0TVEDcNI/Bt/p93+Ia0UBymdmWuFmDs750oIaF40VpqfbUfew5k8
	GTj2go8K/1Tx77qNtPWYin4Bz3JWa0K2acq3s9b0rJnvz9R8tp9JubB/GzGEE2fTYeZnoUVazi8LS
	AdeyM6vWHa80nIQHkZ9dzDPArZFLg0RsN2qw==;
Received: from mail-oa1-f46.google.com ([209.85.160.46]:52352)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uHyXB-0002jz-3I
	for netdev@vger.kernel.org; Wed, 21 May 2025 22:32:01 -0700
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2d060c62b61so4790751fac.0
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 22:32:01 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy9SaQUbntmSWjDLFhsyD07z94+3XyizYFtDEtF+Tb8Yt/w7gww
	MTHvSJ2ecbDZ6qro1vwOX3/xWf5FZtnw/e2Cxp/kdckS/cFDxPVqKNLM9gqhWHZa4y7REERlXlZ
	4M3wiUT0SamIZsTAyONmoK0+Ty8Gi1bM=
X-Google-Smtp-Source: AGHT+IExCQagCxnscX17HTV58B7UH+C/5t1QSnniAAZUT3yqOPIYvOOQdKxO2NOwpnUrzU+gRqT/eJjC9nEB7JNO1Cg=
X-Received: by 2002:a05:6871:7b81:b0:2d4:ce45:6987 with SMTP id
 586e51a60fabf-2e3c81f8f20mr14431632fac.9.1747891920500; Wed, 21 May 2025
 22:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-3-ouster@cs.stanford.edu> <835b43b9-b9c4-4f09-9ce3-9157e1d9fea6@redhat.com>
In-Reply-To: <835b43b9-b9c4-4f09-9ce3-9157e1d9fea6@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 21 May 2025 22:31:24 -0700
X-Gmail-Original-Message-ID: <CAGXJAmzxOxYHR+nM8qhFx2DrCD8dbPyzF-xsv40p3tO6EdDP2g@mail.gmail.com>
X-Gm-Features: AX0GCFsyV-dLtbE91ew-GhoT0lpxp_7x5dBAfyPj_m3yMHbFEPOJghFjXKe5FuQ
Message-ID: <CAGXJAmzxOxYHR+nM8qhFx2DrCD8dbPyzF-xsv40p3tO6EdDP2g@mail.gmail.com>
Subject: Re: [PATCH net-next v8 02/15] net: homa: create homa_wire.h
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: f219e97bb238ccbb8ed40879dafdba3c

One small follow-up:

On Mon, May 5, 2025 at 1:28=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
> [...]
> > +_Static_assert(sizeof(struct homa_data_hdr) <=3D HOMA_MAX_HEADER,
> > +            "homa_data_hdr too large for HOMA_MAX_HEADER; must adjust =
HOMA_MAX_HEADER");
> > +_Static_assert(sizeof(struct homa_data_hdr) >=3D HOMA_MIN_PKT_LENGTH,
> > +            "homa_data_hdr too small: Homa doesn't currently have code=
 to pad data packets");
> > +_Static_assert(((sizeof(struct homa_data_hdr) - sizeof(struct homa_seg=
_hdr)) &
> > +             0x3) =3D=3D 0,
> > +            " homa_data_hdr length not a multiple of 4 bytes (required=
 for TCP/TSO compatibility");
>
> Please use BUILD_BUG_ON() in a .c file instead. Many other cases below.

BUILD_BUG_ON expands to code, so it only works in contexts where there
can be code. I see that you said to put this in a .c file, but these
assertions are closely related to the structure declaration, so they
really belong right next to the structure (there's no natural place to
put them in a .c file).

I see that "static_assert" is used in several places in the kernel,
and it will work in headers; is it OK if I switch from _Static_assert
to static_assert?

-John-

