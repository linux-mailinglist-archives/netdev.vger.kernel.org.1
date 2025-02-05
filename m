Return-Path: <netdev+bounces-163239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C72A29A6B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D90F163AFF
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F8C205AB8;
	Wed,  5 Feb 2025 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uFqmbNS0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D2B1D6DD4
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785223; cv=none; b=a9+pNpq0y3j/i8EJRX53KoqqlgMhQNX6wpQea0lokkM43Au5sKuXTNimXFHvhd2xEhacs75839KAE6CNsplylRe5tdgLDYKSOJWh0FkLeras7BQbAQWNUT51vooRxHATTwihAOWpK/wQfVLJksteLsD3RdoVBay+raCT16Gu1qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785223; c=relaxed/simple;
	bh=6q5v84lcktHrl3Z/XuzQ2h/3k5A/dQfZvkx4mZLUD3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTWzTu4ZqKG1WvTpabYfwilrMkY5zliAi12suxCgHuL7P7uSrDdESCnM8LEudxJ5qHJqJqK7SIb6tj5JuerFC+PvW4F9TM1nyGw9+2OG/icoh0h2WUrZrHtHbhG44WAsSTpXup8lbdSC/nJlM+FyLzfV2G7km3KJ22VXsF1gieM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uFqmbNS0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2163affd184so24365ad.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 11:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738785221; x=1739390021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6q5v84lcktHrl3Z/XuzQ2h/3k5A/dQfZvkx4mZLUD3I=;
        b=uFqmbNS0aBRnuo9pIv0WlRbfYcyfLCZgY3fhAFoYmNRMInar7ONTMyWfrwIkc1o7Tu
         h/NNa5g8HMGIKel+KVJG+yqOExkoR0MXGAcvEWi5OElTbZVVa6GJ43In2ZXxNYEPdotq
         etguEabJ4EeAKgyL4y4RQ0WuNhvShkm/Zo7zDY4m1GjCqkwTiQLy0Jv9sObNcQ0uA+DA
         KdbhALjjkfSubZV5ENAirfaLKmMu5+CCXre1AqVY+e/09ztZMNm970g/tCTnmM9d9tEc
         QTzh7NbdC0EsuH3LEukcps4R6JpRPT1fNoAOylP+0Vq0tAcx2+AjhY1aXtI1sF/yyNOW
         kUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738785221; x=1739390021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6q5v84lcktHrl3Z/XuzQ2h/3k5A/dQfZvkx4mZLUD3I=;
        b=nrShGGBWbxBdhO33IUzqygtDUMR24MWuXSkBtdSzWCvXcoSjjwD1U3QsPKsGqFlnNX
         pyjieuyV/UcjI4+eqMJCBY7fNKE2DXddWWbnl063FyH1iiNUNRyvHuQzrIUWVgtbBVeN
         4NGCTK7Cs/gdAN7MmXmG7+NI0YWW00J/r6E2vBQOEAVG4pwQ7StcVFCzn1LHgh9WH6hk
         G/oR+NmtWadKmS0zo1QkHAn2OtBSdupuwJ9P+p6o+lzRvHBxyJ1hfSLO3RXe9hg5MGTU
         EHU1dKn5VeSWOft/cjqOQGwP3rCB/Sf3zuBUMiqloXJKzyXBYCySj3pZLjm2QqYXvLG6
         RKEw==
X-Forwarded-Encrypted: i=1; AJvYcCWDzY1IPlJpp7OHIiSaQRKhQPBWJPkUROfugq0c12TuG+MdsLMW/pV55LTagoeSsVve6+6/cKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzSucMldvSSuEc78C6tP2dw5ScaccJnDd35l9vfEEpMFrNOuzW
	LZNeP2PgYS31E6fCGOLisbYck8Hab4Fl//DeQuL+Yu8RXuH9BkP/EkAARMbEPDWlfyXoaGIzBhB
	9oEPBtzdZL165u9xlUvPcA6iA5dgM+4QatTpE
X-Gm-Gg: ASbGncumjAsWUktd/t4L9GohZE6GmX52swM1koakNv2e97W/S1sxCuXO04B+Mz95lAq
	ZDMhGnXqodxuiuq1cp2U7fvp3W7V5L0qCWNZkcqerxhXmV6gXsWVJZ47hlt673A1Rzzs37vnu
X-Google-Smtp-Source: AGHT+IFDcob/TSEuYMXb3hSVO++9mpu4Se8Bnl44BpJBOAaoFodhFrUGSu2xVB4BmBZwjRYxoARZ3TUatoE/oCz5blg=
X-Received: by 2002:a17:902:a9c3:b0:21a:87e8:3897 with SMTP id
 d9443c01a7336-21f3022831bmr337775ad.4.1738785220998; Wed, 05 Feb 2025
 11:53:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203223916.1064540-1-almasrymina@google.com>
 <a97c4278-ea08-4693-a394-8654f1168fea@redhat.com> <CAHS8izNZrKVXSXxL3JG3BuZdho2OQZp=nhLuVCrLZjJD1R0EPg@mail.gmail.com>
 <Z6JXFRUobi-w73D0@mini-arch> <60550f27-ea6a-4165-8eaa-a730d02a5ddc@redhat.com>
 <CAHS8izMkfQpUQQLAkyfn8=YkGS1MhPN4DXbxFM6jzCKLAVhM2A@mail.gmail.com>
 <Z6JtVUtsZL6cxsTO@mini-arch> <20250204180605.268609c9@kernel.org>
In-Reply-To: <20250204180605.268609c9@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Feb 2025 11:53:28 -0800
X-Gm-Features: AWEUYZmMVG6gb-GClyYhPSsDJYW5WzEYrdAHF0Dz0FhMB9-YcVD_emeIkz00f9E
Message-ID: <CAHS8izNPxqUHNcE-mtnLSMEpD+xH9yNCxEAkvn01dLekkuvT_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/6] Device memory TCP TX
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 6:06=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 4 Feb 2025 11:41:09 -0800 Stanislav Fomichev wrote:
> > > > Don't we need some way for the device to opt-in (or opt-out) and av=
oid
> > > > such issues?
> > > >
> > >
> > > Yeah, I think likely the driver needs to declare support (i.e. it's
> > > not using dma-mapping API with dma-buf addresses).
> >
> > netif_skb_features/ndo_features_check seems like a good fit?
>
> validate_xmit_skb()

I was thinking I'd check dev->features during the dmabuf tx binding
and check the binding completely if the feature is not supported. I'm
guessing another check in validate_xmit_skb() is needed anyway for
cases such as forwarding at what not?

--=20
Thanks,
Mina

