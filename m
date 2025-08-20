Return-Path: <netdev+bounces-215410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE0CB2E856
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 00:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7C83A81CE
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 22:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC7B2D8DB9;
	Wed, 20 Aug 2025 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UB9hHzzT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538EF1A9FB4
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 22:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755730310; cv=none; b=Ng4apAY0rR7m0GXxInIpFTlkJsev8Cr6KlOXmDTxDOGAeFnu8hXakf//z4v+ClLl9kS0zUnf2SLg1A4IB1VaY/PMkHGy2eqd5NgGjORDIaKh//tN1ZwU2t0cb2MNS/n+GZusQkatxgpWiD4iEUPaAwyv72V7qpHMPdWrqelRS7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755730310; c=relaxed/simple;
	bh=qvvuIz19HGC1hOLci1Y9hd0AIbbn37AkPmcNmEkMdTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Siymb3XVW8dLrH5lrkeGRya1QoPAPIa/mn7YyeCo5gAtnk+5dbvLpgRmcCZKYUChf5uLo849BExKG53WrN9mqAp2Tx+9ZZNvVchAnTGDIp6pR7JGmrSHpHYySA2uFUcU21+ZJ4Jzh4/+xhpsA0I6o815e7C4oOcPBAXZWebylX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UB9hHzzT; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b0bd88ab8fso94331cf.0
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 15:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755730308; x=1756335108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvvuIz19HGC1hOLci1Y9hd0AIbbn37AkPmcNmEkMdTo=;
        b=UB9hHzzTaJmPUi9zCbIdPAVON+3+3T9QmJROyC2PQ3nrMT0+s0tIeoR64I/Mgblrc9
         GDojHAMA40aN+MwVZ5g9shjRDRjsRLdm4eawKMVlcFuSI4WdpjxfopegIF2ROhT760oW
         yOXiGhJwyOWTSi5rehdZOdxANknsr9sOVBbu+nW4kF8ZPNlzlt7NXhv4YLYOy93w/G1D
         /nwt35FAp2ViXSrWDwAGMSVTq5WY0N2x2cuFvGn/Vj0MbGptFJ+tkxWfgvTwDVsOqSAL
         JgYrc7tVllqK0d1p/YqgD0QsfUIE0jwpN+0EySRaqq0dH105aERjRXbHlM76+Hl6RIg1
         cZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755730308; x=1756335108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvvuIz19HGC1hOLci1Y9hd0AIbbn37AkPmcNmEkMdTo=;
        b=Y0iYmUwcbM3iB0PcVbiCaw48GDBuhzQobIi1P2w+GOlcJjcpsYHo7LUlLIroZY7lIm
         8I6MnMPQqNKtuaGiFRmVj4MODYxICnRgzYN7K1AeCPJzhszpCeu+WpOcPIfa/KkApUpC
         UJmMBgw9l1A4xVqqutyvHZxxRJEI9Ftw0PpnouD0lQSn52EG8Oxctib2qYR9zxYyhc8p
         bpW4/J1R2LDkX2D7uSHE6qpiZikF89n5rDyjGyg0K0yOzkDmgtFaHJZRuyw4MH3MDc2+
         490Y0nrwOQLAXl9iF7J+GzwT8DMntDEWCbaBkmw6V3jrTfnaat2XitLDx4eNCuNRDS3U
         gs5g==
X-Forwarded-Encrypted: i=1; AJvYcCX3TifIh5h/Hu7cp404h9HvWE0lLjuv990aIaPwKxdDwKHJjRP8UcsEhz929BuIT9HmBNTTFQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK79iddTy74kgkXQD4IzrYYtDO1gu9yhComBIqOU2b56Eg6JFM
	2H+0H26XMXQhhoBTEjX9H8xc4ELRqrLWZi03OLcFsh048HF3DX0e/p/QcINQNYFPwkuUfJqn20R
	6r7RExDPPZOwfGiHFbi7J80VexPkuObDRhiXQDanW
X-Gm-Gg: ASbGncsXfxX71iq1I+DY7YXpGHjQBtZj9fGPCGBrItrgoEn6Kuyk02/bUdCl/M4n0KH
	51UxzVJw4iBJ0S68cpWp7SYph6kFJe49pZE5l/n3O267APfkyXoC1dasAa5+qSE2jNbohIyoO0K
	jUZJBdIMMwsjFk9Dn0uO1H4WCj4FLOzY9jMOvYUfyacx2AUKW8I8aEYTk/jIsf9ZZ57siaWPYKs
	qQqdCjC0qtwdLEkyvMtHnOn3yc4kdnWp8JcKOkj4qd9FNObc1trfeg=
X-Google-Smtp-Source: AGHT+IFnucqctbq+X2MkFIfcQxZd9U9ajSEePzBmifl2qKpLWyoa80CJHDHVTlJtgs6cetttll6Fnn+54EACtnz3c6w=
X-Received: by 2002:a05:622a:241:b0:4a8:eb0:c528 with SMTP id
 d75a77b69052e-4b29fa23c6cmr537741cf.15.1755730307790; Wed, 20 Aug 2025
 15:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820171214.3597901-1-dtatulea@nvidia.com> <20250820171214.3597901-8-dtatulea@nvidia.com>
In-Reply-To: <20250820171214.3597901-8-dtatulea@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 20 Aug 2025 15:51:29 -0700
X-Gm-Features: Ac12FXxgjSFgx5660hALKbajeFHBX9DsXuvcIjQ739CmkZy1azdx8SzH1hWqlKI
Message-ID: <CAHS8izNRcVcAfBBaDwZvPYrs4cK2NYqyXOq5+6sbsbSfpgc7Xw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 6/7] net: devmem: pre-read requested rx queues
 during bind
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: asml.silence@gmail.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, cratiu@nvidia.com, parav@nvidia.com, 
	netdev@vger.kernel.org, sdf@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 10:14=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Instead of reading the requested rx queues after binding the buffer,
> read the rx queues in advance in a bitmap and iterate over them when
> needed.
>
> This is a preparation for fetching the DMA device for each queue.
>
> This patch has no functional changes besides adding an extra
> rq index bounds check.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

