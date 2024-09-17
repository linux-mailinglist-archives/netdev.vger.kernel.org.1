Return-Path: <netdev+bounces-128656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C9197ABB6
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 08:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1451F2282B
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 06:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108D071750;
	Tue, 17 Sep 2024 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDFxUzqE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2E7A920
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 06:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726556364; cv=none; b=qa3PgbpUxyYzZLpDiKsaniSNH3c6Hh4jCXMHgq6xiTtU3O4wd4Prt+WeDVkoay7CLcOvMhthmhOjNHPICB8DYqkOEV43lB7QT+v6Ov4WrmQCFvL6psy+pKjG3B1o3zN+hkLU60paK/Ywl2p+6cJRfdGnUvsFR7iqn7Q7/ordMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726556364; c=relaxed/simple;
	bh=HKBn5ZxoXATgX1sIo5qE++pAzgcOh1ovTQYnHTHSWMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLol4ZZjbRNB1iMuXzAxNtCYrV9omAIpT9dfoFnI/SHewkrhUxo7lo5g9rrIUqRcZD55UPpwhyqbUiBd5IfNafFo7cq4uv12KvP+Gjfca+mz3hiGUVEi1VVng6lA+7HmFinnH6HeTmv6kk0LmFYMTSbgtrLczGKnsM+MlOlkKHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nDFxUzqE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c42bda005eso3603743a12.0
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 23:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726556361; x=1727161161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKYvQ200AYDv4o95wLLADVmet1GvtwxMWo7HQTbhdPQ=;
        b=nDFxUzqEjfvth1GNrBQnwAK8R9mWDpK88Pnw5YgpoV9rb/zLS7cY5UHXdYeFJrjU0E
         f8NlnQ413X86icQS8e5Ot7qCLAkTvaMMFCFhjBgepQ1Eoxs+giOUe52rTC4X1+ZKNIP7
         R59PlQNIb++Kuz/AvV+Xt0k05vmQIDlSHJf9S0c47KwLVR1Hi/PgEg800BuFrV4VWe/I
         tTOYfN48hAqlJXnERscn0yUsMfa81maGYiX/cHLz9nhwBRBL0Sw/33q0DFBciV3zrNBU
         YVLGSCfiDwDbASqxnvr/N+omfxfD9QePqqhxY62TfLIGRaGsuhVGou8I28XH9HdznL9D
         RNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726556361; x=1727161161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKYvQ200AYDv4o95wLLADVmet1GvtwxMWo7HQTbhdPQ=;
        b=YFD8mRO9Ql6j3DebIhgONjNVSupmDDiiDq5KJnTq/9u3nHgEqbQL/tIinTaQTeTH6K
         vrkIDFaR9evRme7/3zYfsuBKx30KeYXwZnNXsR0BFcx3UYUc7/Ef4R+yyrh3O+JQYmQF
         jZ6scj6tGGLwcL8bB6YSlRgUN9mF9K39hV2vYEt97aMvKOLMtRQQvRNoqAqHgwMmIg5g
         7b7yvx3dvBoHkqmFJ05ZRj/ZTVKVznNbGP32UVBc+KVVMO7BcTApL8bAVteLrtssguR7
         da3/DUIwlkqcQZDFsLPlMsRFZBGcM5ZIAs3QhL8EYQ3azbUpg1heU48XP4CTl8M3KRGX
         Cc+A==
X-Forwarded-Encrypted: i=1; AJvYcCXdLhvCZFxpOBqmUBSi4r7xzpbjHCCJfa8fE2ZUuMLA1LtRfrUE53FWJ5lKcGL2saP8njVbgrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2vXFDwbvc46G2pSO5Gsowrge7P4zaxtfwLzU3JpYtfqeLNq6f
	TobkOMEgkMSGCjKA5ORjeORLJTv/Rp1cOaOzrmSeXYLJyx8aNl9Zw7gxgVD8k0TNbSiHc59YUev
	PE9Fljvw/0qKdtVyXLQ+HGyAkdec0FTfwqOcG
X-Google-Smtp-Source: AGHT+IFye1WGPT6ViGrzwffj3xtBa5d9iGGWSIcTjVG8ZYQl2FfdQCm9WdnQ+hk6RPKQfL0WAIysQktXeoWGFp0KOI4=
X-Received: by 2002:a17:907:3f8d:b0:a90:1300:e613 with SMTP id
 a640c23a62f3a-a9029663045mr1919858666b.55.1726556360337; Mon, 16 Sep 2024
 23:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
 <db6ecdc4-8053-42d6-89cc-39c70b199bde@intel.com> <20240916140130.GB415778@kernel.org>
 <e74ac4d7-44df-43f0-8b5d-46ef6697604f@orange.com>
In-Reply-To: <e74ac4d7-44df-43f0-8b5d-46ef6697604f@orange.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Sep 2024 08:59:05 +0200
Message-ID: <CANn89i+kDvzWarnA4JJr2Cna2rCXrCFJjpmd7CNeVEj5tmtWMw@mail.gmail.com>
Subject: Re: RFC: Should net namespaces scale up (>10k) ?
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 12:06=E2=80=AFAM Alexandre Ferrieux
<alexandre.ferrieux@gmail.com> wrote:
>
> On 16/09/2024 16:01, Simon Horman wrote:
> >
> >> > Any insight on the (possibly very good) reasons those two apparent
> >> > warts stand in the way of netns scaling up ?
> >>
> >> I guess that the reason is more pragmatic, net namespaces are decade
> >> older than xarray, thus list-based implementation.
> >
> > Yes, I would also guess that the reason is not that these limitations w=
ere
> > part of the design. But just that the implementation scaled sufficientl=
y at
> > the time. And that if further scale is required, then the implementatio=
n
> > can be updated.
>
> Okay, thank you for confirming my fears :}
> Now, what shall we do:
>
>  1. Ignore this corner case and carve the "few netns" assumption in stone=
;
>
>  2. Migrate netns IDs to xarrays (not to mention other leftover uses of I=
DR).
>
> Note that this funny workload of mine is a typical situation where the "D=
PDK
> beats Linux" myth gets reinforced. I find this pretty disappointing, as i=
t
> implies reinventing the whole network stack in userspace. All the more so=
, as
> the other typical case for DPDK is now moot thanks to XDP.
>
> What do you think ?

I do not see any blocker for making things more scalable.

It is only a matter of time and interest. I think that 99.99 % of
linux hosts around the world
have less than 10 netns.

RTNL removal is a little bit harder (and we hit RTNL contention even
with less than 10 netns around)

