Return-Path: <netdev+bounces-213127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD55BB23D00
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 02:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFE43B9906
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 00:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5F81362;
	Wed, 13 Aug 2025 00:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zOZWMji6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4200128EB
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755044212; cv=none; b=i0j5GQNRxzU0aZC6suODXPVG8O6Hi1tfZ3Tl4v2PLbpj51EoM4d+fv+S1zMStmd/P+LIVrhUaYZQIDdTCuy9+L4lcTbLCzOlJ0Nd2DhyJPrUirCkGAYob4zUYebbuA3+OeuudYxuaFNsZq9Kmvl/gWwZvGPoHzPCT9oiCCms+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755044212; c=relaxed/simple;
	bh=XzuKIs7vtDLlqgGoJcceSI7gyg399jNW6VySbtdmOoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRVLSyjwvgq9T7bNVpBKbvzq7w3ARFZPXkfvq0ONCtZ08gRMftAiJ9Dx10J28ih+jAQPi+8HchqJDKR/IZyhEb1D6Ze1NhPWa1BpxPc3ZI96LKITf9nsH6vjTX/Vh/RLoITwHBuyMxZSKjPtpGB23M6BxfC5w//APTPLrCGe8Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zOZWMji6; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55cd07a28e0so4485e87.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755044199; x=1755648999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzuKIs7vtDLlqgGoJcceSI7gyg399jNW6VySbtdmOoM=;
        b=zOZWMji6bwzyeJRKtoicldgyUoRmqysVaw3OezGEIDGTB2YBN5u3Goa80ee9hbO5/J
         A/w34nEcX4YiXNMPTK+KERcA+o0MXsbtRfjgEUGXLv+rOqw5FSwk+Vw4yASyXBNwE4tn
         CPM6u/4wm18DnzC9wAuyzoUWZf4o4EgVg6O2vNintmGQfpziCVjQGAzwhIPdYEj64WuU
         QhEA2yqMOCpd2EtbbaryjIZNilnOm1DAf0b6bh1n2DF3sADUuLTMx1t9IhtJPkWQlfZW
         vRHe8lidW6LSrnFbizlJWyHxe4LaHkqMW1CqVmxC+mJ/YyhijXCfdvLsW5eMQg+r3LHr
         UP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755044199; x=1755648999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzuKIs7vtDLlqgGoJcceSI7gyg399jNW6VySbtdmOoM=;
        b=FCnGGItSBX5hvDAEzzyPbafyDMJPu1HFqonoSclnDFOeLKjskOq6+wa4tFM02XqOmd
         h21+g4Ci6IVb6BcA2xrRRXxWY2uB8N6NEzVaWef0Vc+RxLy8IHLPGK2mMs90P9lGDunx
         m+M+adsn8YNeP+qsQm8J7/8f5n3zVsju/JFNGnCvTmxvIdh4w6naNorTB8WaYXgGru2t
         /StWChKhQ6BC9bwgse9hDXjDQcA53lXh5wlxM5b0U9y/C33iBWgi3EpTSiLVhWw4MeGW
         /IXpePtHIx2Jg7aYXcaXqOfW763e9p5pvkqMO0k0C1MSeiuSwLRRT3TxNycuDcby80+q
         7lCQ==
X-Gm-Message-State: AOJu0Yx0LgWn9Afz1i1psm+i5P7X7To17z6dJgRDwaQYsSBXDZlPUv/b
	JIPYHZnruKBqriJ2gFrbReYQSpLJjfZk/2FJ7Y1E/cASFMQaKvZEJXgOWUGOHgQJEAh7x0dWIIn
	VJaO1R5nOgFBFF9vQrBo0NVPmpFpHjuDd46Sdj7g1
X-Gm-Gg: ASbGncvU1Hj5qw891/7MK+JF9jH3gWsUCPi34x5fGlT1FLXuMAGS1kr1Mf01gVUBGco
	mrOLK7ISizVEFQpNFrR7TxRTgLg3PWcK4xyq0l06OW+kB2WUYNjD81f45sm4+51bgX1fgmfPALz
	WjNtu0P409GGV8uHjjSmHfoFtmg81seF8TNXeDhyqXUIAzLgWEKreKdl7Qyerj3w3+OOSXupWS2
	BxPCxDP4DJ5kFvKx0N6vHh8Oy4HPnH/h5vc7InnosvPjmTfeB3dtz1azw==
X-Google-Smtp-Source: AGHT+IEsyTTVlhlKsCj6swerrcVvgcVF2/OaPW5994PaxI8uYTZ/ECzk7CKgqTc0G0pWT4Irg+n/a5BQhxjoC9jm/oU=
X-Received: by 2002:a19:6402:0:b0:557:eadb:253d with SMTP id
 2adb3069b0e04-55ce1245024mr71030e87.1.1755044199133; Tue, 12 Aug 2025
 17:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754929026.git.asml.silence@gmail.com> <7468b556ab5f9ac79f00a530464590e65f65e712.1754929026.git.asml.silence@gmail.com>
In-Reply-To: <7468b556ab5f9ac79f00a530464590e65f65e712.1754929026.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Aug 2025 17:16:25 -0700
X-Gm-Features: Ac12FXwEwAxOGTmnm95I_XOvW4Xv5QEa78nu8fTGwTSEnfKe_rxax5ekYCP0mvM
Message-ID: <CAHS8izMD2nnmBWbMp3zRuNwWjiphdwu7NFpVCvmcy0SkBLFG7Q@mail.gmail.com>
Subject: Re: [RFC net-next v1 6/6] io_uring/zcrx: avoid netmem casts with nmdesc
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, 
	sdf@fomichev.me, dw@davidwei.uk, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Byungchul Park <byungchul@sk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 9:28=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> There is a bunch of hot path places where zcrx casts a net_iov to a
> netmem just to pass it to a generic helper, which will immediately
> remove NET_IOV from it. It's messy, and compilers can't completely
> optimise it. Use newly introduced netmem_desc based helpers to avoid the
> overhead.
>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Great cleanup actually. I didn't realize how much of a pain the casts were.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

