Return-Path: <netdev+bounces-196808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67027AD672F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 07:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F69173925
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 05:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DCC199FAF;
	Thu, 12 Jun 2025 05:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2+xx4lR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28BC8F40
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 05:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705470; cv=none; b=D9kbr17boKlVx63HNtFeIIth5rdaERX83FXMGJFvGo3ut8okOPpYsCLEBP5FSNLWMEnZPVRsGx92uh5AusYDxVqnpzTfx7ZomL2HbICt90wTBCIYiYIuA2y1815UzLiL1IbyXsSaunXIOdMJkpYp982hhxeKwCTNj7468LAeHE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705470; c=relaxed/simple;
	bh=2SCdJ/+4doAXDA1dugfcerrihJYg32knCvs3SFTaAHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTlO07wFJcLgb3ztSCjFGxAzINaYXJsjvixe8WGuOhRJJ7dqyjSLPrjt7lFZwqMt35J+WAy5bLpIC7HCpGmDzMo41FnBAik/VyOOrlTE/Lz6L7Eyj//wEOD60oIjlr011Zm46u2evChLVY3i1CUOcPaqVyD/sFNdYh8fm/vc6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2+xx4lR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-235e389599fso126575ad.0
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 22:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749705468; x=1750310268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SCdJ/+4doAXDA1dugfcerrihJYg32knCvs3SFTaAHM=;
        b=l2+xx4lRk9VZdvj+XODaAdpfsmHoNTAQiuoBm+Vxve0ddmNB/2OTz8EJY4erV7FZGD
         6mhjNLpen8OIBrqasVtsOlcrBEVLpT/ZpMhjKJEZrINkvYjiRjvEKFcceRepBXWmUNEB
         kdpnArPcasSr1FwZG+zzD0Dp2hhxE3yzF9Gi4V1dRR9PwBuJRORakl5YBRPHWhPtz5bU
         /XBjGUoIuS+UdyiPkqG+8JolPkK8FQjKplfO1MMVLnJfJx7TtW9yTnBkt9bmFDlaXY/4
         szjqy6+2cZjkGPZ2rMDDgNYm4GVhYXJXKPpnIbPREaHqUiOgxlTy3OOjkd7NxYx9a5Z7
         o8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749705468; x=1750310268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SCdJ/+4doAXDA1dugfcerrihJYg32knCvs3SFTaAHM=;
        b=Ol6eFqLrL7nE1ls2lqNtcxGrTZBkicLNvbfK0x5ktHKivD+ULxSqyAztbQ1Qb4KC3z
         JASF0ihXmX0VTFvcCGfiTf6LpZno0OKWha5RMhEjJTLvh6XYCeBlzoTjVgrS+cCHqUMO
         8GnxUVdDTMn9vR85dZbDRL6NZEhG5y351/5umvnf166pTyS3KJbRfRplSxeNLcd+zrU6
         k8BxLkKxhve6p+toaZnFiSfADtQLwl90fFfQ23CfNjQPJC0Jz19vvZTcn8RISx0W74rV
         AlkanotMFibmrZZzQ3dbZ/FclI9BY60Z2rW38nWsK/jPq6s/HRYTMbWv4ZdpVBWISSoR
         gi6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOW3cub+vsn6rSKqS9PFn6TQUgc0FcGNN6vdptXkf5JSs2wCElUliHUfnlG/rBOfEL1k6RFdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Mritt7Q1uvd61FPHefJ6679luHO3PMTg3iVydr1Wj0qKAIUg
	W4/yf9O40Y3z7lv2wEC26HusHChRuSsbLaDPiPO64phedh9ITv0VsTX0CL60NgxrBlA8dsR+QOi
	oyhoDTWrg41yddoWfifR0V7CAyhKJABVGguKYxtCo
X-Gm-Gg: ASbGnctglJ6+NZtsFNQ/MzSx1GEle8mT/pHWzu5nh9yRbb+0HC2iK/+osafCdCxo957
	pZSKJupuZ+8CgcA06xOHZqVNdgzN1zrIknCKCWWLSzxO/gEuxI69VWuOWp/T3NE8PAmALtUl2A7
	N7d8XxxJGzUOHWghAJ4HWDBmkD+w9U/QqglTuczg7Nnnud
X-Google-Smtp-Source: AGHT+IGYP9KzkXjDzsA4+41CLW5Waykb3HixIBnHVes8taLU5EpIH0GQEyzbO+4zVc94uZKbBXgXshRqTVavOIadoX8=
X-Received: by 2002:a17:902:d2c6:b0:231:d0ef:e8fb with SMTP id
 d9443c01a7336-2364dc4e3b8mr1774665ad.10.1749705467691; Wed, 11 Jun 2025
 22:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610150950.1094376-1-mbloch@nvidia.com> <20250610150950.1094376-12-mbloch@nvidia.com>
In-Reply-To: <20250610150950.1094376-12-mbloch@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 11 Jun 2025 22:17:34 -0700
X-Gm-Features: AX0GCFsQbpdJnxhJgwGMagCQgzHoP4omoeUSZWQdZ5DAkp2-7EHR6n8NXEpEZgY
Message-ID: <CAHS8izMOcAYzcseZqud5xj_3ibaWKBUqEARgJd65S0_Wqs6haw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 11/11] net/mlx5e: Add TX support for netmems
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com, gal@nvidia.com, 
	leonro@nvidia.com, tariqt@nvidia.com, Leon Romanovsky <leon@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 8:21=E2=80=AFAM Mark Bloch <mbloch@nvidia.com> wrot=
e:
>
> From: Dragos Tatulea <dtatulea@nvidia.com>
>
> Declare netmem TX support in netdev.
>
> As required, use the netmem aware dma unmapping APIs
> for unmapping netmems in tx completion path.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

