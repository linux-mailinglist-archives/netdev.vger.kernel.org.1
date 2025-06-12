Return-Path: <netdev+bounces-196801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E8EAD66F2
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 06:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970781BC0175
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 04:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B891624E9;
	Thu, 12 Jun 2025 04:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dxKpNa9H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD70F2CCC9
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 04:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749703983; cv=none; b=R4lb3V8BheqdzFiW/gNIkakCDbjFsZ8HNRNA3soVDux1z6yzqgCi4VsBZNbNj3NfHXNkGeTGMgp0zTiJoILvQec/eEeXztRWYnVwLSI09QCRS2tGHC6U9bIUNKm/2XkSDD4oY/yleKdRVIY/rH+zYPGGv0oC2xABab0PuETlpF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749703983; c=relaxed/simple;
	bh=JN7PESSUpb2dkcTr3UklwuIC/3db+uAVTehxCFYg+YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWDZfyndQ+uId0GtH/ilKfIDVP9qiXt2AnbSmadAqkKlsRSRtKhUKaF52vfW7z3gPgqnHhvvNQC8nq9VTzwTtSH/p2v+6AAIcX0o5zR3HGulbdgdsKP2DMwi9qmMiNaxrbLMqbNvFbXjvoD2D7aBgjMurJ3HyLuVeYcuLrb+5rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dxKpNa9H; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2348ac8e0b4so78195ad.1
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 21:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749703981; x=1750308781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JN7PESSUpb2dkcTr3UklwuIC/3db+uAVTehxCFYg+YA=;
        b=dxKpNa9H18qiZ6tvNSAz0QyFo/O0CYgjxzrbWCG8vcNHgpxje6TEUVMylZtMEbpuJN
         Q27VPEthzqWLeaVKfUbWmmffwHaTYNfHI9gtXgHdr6VxxSnOAhbTEq/rB70k9gITnHmH
         ktWZ6oRiYsJwCW/MMRGTreFeKDe7sYFBYgvTaEldOOOiM2DlTP7P5sWrkTMl6wVRx8Mr
         0oW2IvVNshJ90bBbGvsI5VgIEtmO7LmMsWiqA2W+RorZB2+0CMj8WnNjRX8wzFAKj5sS
         Bs7shYT7j9uzQ8dl/flyPtrkdwPuv74pDUMObzgOEclhbPRfdsP0Td4bJwNEZk+l7Z0S
         mIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749703981; x=1750308781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JN7PESSUpb2dkcTr3UklwuIC/3db+uAVTehxCFYg+YA=;
        b=Pz9v4ogQol5VKtFeewLLx5oZLe1ckzOVxqxeV9F8IaAx+gH5X+JGE0Fm92Ey2Dl28i
         IZS/w9u6+Q85Cc9qzoabUH/GOsAWUary8AXzcLfz36PXA4nJkCsVYq8+RJaIVLYJwrwK
         Jbjj/aaNNjnQpRYF4WOgcNfWza2T3qK3TeQ9w+vwALpyHU4SD8zzPhrTfDAtzc5mGDFn
         KcJGGFXc1ihH9ksol25L+nhAVj4kME3pqjWZbMzrFMUtu2Y7/xjsywFjB2H9RH3c7XFp
         lYNjCcJ8bAZFbpX2Tnq757w9LUjfCqtBd/LmQbheUT1iEsKjeN00oYJJ4925V2Prq3Db
         XaIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIRuqwOdpTnGZ80uT9Ohs5gmyplTBcFFwgYsxbqIZNI5Fir0qsN9iWZiPLfBOpp1PS5CRi3Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjFsuNhzj+HrP0rnATzbLgSwX1upe+rSm3MXzLJpkrypGyYviu
	b/HdXtJpMdVs8Bv7EsPZBOBfWTB/z1+plUvQQwhUO1gBsrJzS6VLw2PTRAVw/SRTVy73Bj/upE3
	jTsOq8v/0AmrzKNjlCjIrL1fCRmISRt+1xmnfiG2j
X-Gm-Gg: ASbGncs+oAGrgvQZt/xCJUWop7MhdrZXFAt+d7MaDZpy6bd/RNKCTqQfD/999FoCZLY
	okHgt70Gfh99H0HM+S038l0ngDpgz5RhJzDztm39zxrmmZbjwvxLn2iP8IgBmEE1lvls0DPPbKW
	9GqGwharFqhR7slw6PUsvjC/N4fKkQ4OLWsfHIvHdVOApq
X-Google-Smtp-Source: AGHT+IF9sI2+TSVjeDsyCsMhNK2tYq652eey2qbdj9oGkvAU4h9hMqqw9fQg0pUIUw6GrHibgaGuCKYfworr/47Spj4=
X-Received: by 2002:a17:902:f54b:b0:231:ddc9:7b82 with SMTP id
 d9443c01a7336-2364eb2b4ebmr978315ad.13.1749703980736; Wed, 11 Jun 2025
 21:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610150950.1094376-1-mbloch@nvidia.com> <20250610150950.1094376-2-mbloch@nvidia.com>
In-Reply-To: <20250610150950.1094376-2-mbloch@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 11 Jun 2025 21:52:47 -0700
X-Gm-Features: AX0GCFvzBtcSK4oFAp7AxIqQXQSZWU21N-dciM4Bw9ZhMgTYOZ3S9uS4MIxcR6Y
Message-ID: <CAHS8izOzZnNRbBvMohGzB2rxhuLun8ZcPKg38Z1TbXo3stqZew@mail.gmail.com>
Subject: Re: [PATCH net-next v4 01/11] net: Allow const args for of page_to_netmem()
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com, gal@nvidia.com, 
	leonro@nvidia.com, tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 8:15=E2=80=AFAM Mark Bloch <mbloch@nvidia.com> wrot=
e:
>
> From: Dragos Tatulea <dtatulea@nvidia.com>
>
> This allows calling page_to_netmem() with a const page * argument.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

This is slightly better, it returns a const netmem_ref if const struct page=
:

https://lore.kernel.org/netdev/20250609043225.77229-6-byungchul@sk.com/

It's probably too much of a hassle to block your series until
Byungchul's change to this helper goes in for you, so this seems fine
to me in the interim.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

