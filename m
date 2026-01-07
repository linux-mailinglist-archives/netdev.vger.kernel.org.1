Return-Path: <netdev+bounces-247794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 675B9CFE76F
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 16:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1211830A0D8F
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 14:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5D235CBC6;
	Wed,  7 Jan 2026 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMYUCLYq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEBF35CBA9
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797980; cv=none; b=lG54nNzT6kJsnQjRLNl9i8dLKAa4n5qPcRenHFctya/R4IgBzEoHXyOQCQ8feDGKOf8+ihD91b3gXOh7Y430404qtsNodl7OuDw0u7IGK8aq2bRU41UyB7n7JenwIgCYq8Vh2w4G+bknzgJH1FdbtqPxQRd1pqkWj7D3W9U7SZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797980; c=relaxed/simple;
	bh=/g+VPdf5RLxM3FpCwylvaiin4nBnMP86FjrQ2QeZu2c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=R+kddu12XYVwyoDFCiONFHLKyJZ5USK7lLurJ1UlWOvXFL7im83uJMeGl37ajmNlRYAmQ9aFXQi7CvkQJvvnfI7+mI+c3Zih2D09xf3qeJ6MURmLZ/8EdPcYPxEQ5IGpyYX56tG2B6OBowSrWYDzROIfOTsLHCU2X1iEXdCcyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMYUCLYq; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-790ac42fd00so16847677b3.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 06:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767797977; x=1768402777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygEsBMOtQfOnd+ceAekCXMasHvVQy7UNaDcAc1PawvA=;
        b=YMYUCLYq2dJWMCKoC+oWjv27yM2iCKeBsMMNIcYPVJ9aPbwlMM8WtvDtWj38GIOR7M
         xIXoIb+anvUvL1HInj6BrdYuCF5TcEZ83PRLVED0/wPj8vrvYRE9dIWIUi+I5gXJ7wNJ
         AViT+KEm/wB9VJrs+ov9E65HzNnRdlQ+og0eR2x7lyu8sqQL3yBzaUrIHb1r616fPO7x
         oPDtFodb8sG1ZMTR1ERrrCuDDcGwr5h8NbNd2EFfakTSmajcIGGzWdIQ+e49NsF5kDel
         9V8DXIIZVW1I+Dc2SGMPmO/uVJh8W8wGn+5gq8Rs8rMYPHfyt6KshxnKAgIs91C1d4d2
         LJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767797977; x=1768402777;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ygEsBMOtQfOnd+ceAekCXMasHvVQy7UNaDcAc1PawvA=;
        b=HDRKWHbmcDsL9J3OAP5Yb0qlqMi7n/xrM6T3YCiiviicRIOTj51f7u2Bw3NHy4tYgt
         wmbMIM5yoI7gIGYK0euBN6mSvximzKIZoyv6hY9r+2gY9F0Yc+DjyHudr8rfVQ6LnkMQ
         iMDMsBbti/qKAy1ZMo5Bc1fLb6LPAFutmvObORgqeDPSs9x16S+UlUDRsoiKMyIByoM0
         zdYXxiWKXu8GrrcdbGOPVs0AecshUzawrTYxbMSsMRrfDwhYf4yqVn1sdR2Nl2tzI58F
         MhABBBEfX0X6b/WbSHgjn4jzh/cEqQtP3DdnmwIrHZ+uBCkaC7c8psQwdv4P+ttEBUJj
         DH1g==
X-Forwarded-Encrypted: i=1; AJvYcCUADy0aJOGBqbH/kLgpG+7TeHB6poij0RGMCS1S/nZuytf3U+qWftDlJw/jE9lHT8kpUU9t1mU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxgd94e1oSVy627POf2ufkvVxGEo7d2/l8HA1l3WFtdLQBcxNX
	D0fxcX4bXqEkUcs2XQ/Uox9laW3EEzWFyWilAbdw/4LByerlzBR8Qr82
X-Gm-Gg: AY/fxX6ijk68+3v+BR5MPIVQBXFZE+IO6XIPp1Mv9PXJ/3xXteHHGkwDmgYd+HjEaCU
	2xN3/RH1plCEqwWzjTIf7z1DMormPvKlaSRaxiW5Iu/R1wjFbNhuThDS54lDXpNgthAV6HF7IbO
	CJHNE9VNxHWGqrTnxgfkKOgBOYvzhCslaOvGUqobB2fUcf56luGocJDciZbHJMj8vzs6YsKJ3X4
	8HAUdaOR2PdMRN2TfrHxuybBJlUIOGpn8J+rxIm2Z3hvfWaerWZzV461FJd7v9mLZk87HA8nhXs
	qUKzTZtNDTcJfLgzed++aIflde0+Du8qWB32jhAlfBnQhVlJ1PW1a2BdhmWBmLmPGQiciHxTpdx
	yFzeSM6cTUOoT2DwQFxFMusNiqWLm5jTrHZ/ZxdXb7REycvExvmS8RYqCnI38if0OYMdkkYA+xk
	/7qt+VO3E/ab6J2+se602dkTeKsCW0moPl8qDWDtL25o6ruTfo3Q464tF+1Mo=
X-Google-Smtp-Source: AGHT+IHGckZa869lQuPtJPN6tXowxLF91dFKwcfoBAPflAsajZxCtT4RbtUWJmXlz8CVoUJtC1vKmA==
X-Received: by 2002:a05:690c:315:b0:789:3166:25a7 with SMTP id 00721157ae682-790b5828b28mr57702757b3.46.1767797977574;
        Wed, 07 Jan 2026 06:59:37 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa553750sm19318617b3.9.2026.01.07.06.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:59:37 -0800 (PST)
Date: Wed, 07 Jan 2026 09:59:36 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Xu Du <xudu@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 shuah@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.24d5d52e43030@gmail.com>
In-Reply-To: <CAA92KxkOYKA9vsihvk0FR58m4zgM8-oZVWGsLDYycnk4UWmQAg@mail.gmail.com>
References: <cover.1767597114.git.xudu@redhat.com>
 <willemdebruijn.kernel.3ae0df5f36144@gmail.com>
 <20260106145822.3cd9b317@kernel.org>
 <CAA92KxkOYKA9vsihvk0FR58m4zgM8-oZVWGsLDYycnk4UWmQAg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/8] selftest: Extend tun/virtio coverage for
 GSO over UDP tunnel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Xu Du wrote:
> On Wed, Jan 7, 2026 at 6:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Tue, 06 Jan 2026 17:14:05 -0500 Willem de Bruijn wrote:
> > > For instance, can the new netlink code be replaced by YNL, whether =
in
> > > C or called from a script?
> >
> > +1 looks like YNL is already used in net/ tests, and it supports
> > the operations in question, so that's a much better direction.
> > Please let us (YNL maintainers) know if there's anything missing
> > or not working, IDK how much use the rtnetlink support in YNL is
> > getting.
> >
> =

> Thank you for the suggestion. I am looking into replacing the netlink
> with YNL to reduce code. But after reviewing rt-link.rst, I found that
> rt-link currently lacks support for VXLAN. Would more significant chang=
es
>  to the patch be acceptable if I switch to Geneve to leverage YNL?

These are only changes to the new code in your series. SGTM. I assume
it is not a significant burden as the two are fairly similar. Is that
correct?

Eventually it may be nice to have VXLAN support in YNL akin to Geneve
support. But sounds like a separate goal.

