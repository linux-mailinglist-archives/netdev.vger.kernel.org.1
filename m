Return-Path: <netdev+bounces-211370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8F5B185E7
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 18:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893F41C80EA4
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 16:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5D31A5BBF;
	Fri,  1 Aug 2025 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r2EVDS66"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97001A2632
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066431; cv=none; b=OrV+rM7w20aLGrC+nV4vgBFoYvVS5TyOPiTzsvXDz1sqRtdU07iV7bVi61Wzg/D5iYlE7e2D1302Ze3AG4Br2sgA1NeYS0VhlaAx/49SeXbUg+3gLRXxT2BRQbocDWMbBxX0vOf4+W854unA8/DSP6WWpIBEJE4Y+UMnbU/jl+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066431; c=relaxed/simple;
	bh=NVRaPNkWEiVk584Q43nPTvrPYCxP5q62CxOl3nu1gRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7Q1JiLTBWc2ywHTQKebuTc6BdAkMO1/lCG3sQ7ll99+uDAw5OaTRnhJaDC/cVESe6hGVTguxiw6k222VeIZXplTvzOGQxuKAGedsG+ey4VNKW8JSMlmWo7JwM+X1uyLbuBgkMe6XaCdWpdqcVadBCQYyZQcPkYTPWrd3TmppJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r2EVDS66; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-240718d5920so157805ad.1
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 09:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754066429; x=1754671229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVRaPNkWEiVk584Q43nPTvrPYCxP5q62CxOl3nu1gRA=;
        b=r2EVDS66DD2Sx/Mq7OlPnrl1snQabKUD8QKeEWqN/mEu1+4vMj5QLb4/o4fYqbYZPz
         swIwg8G38jt3GbsqEot+7kEoo0S7RcQoca5YlvIDtxdmiX+oPYWsyl2bpFpCMjHkEcs2
         To3h1cn19xJuZ6LVgb6sMDwZStr2nO749+vy0pUdUknAT4wG24JZv2QuF6jHh3BuRriO
         PxjGYyTtnFrLlzGJfpmey2tbePLWGtD14A8QiDxB2QT02e+WTNr/2YqotI3xvqs9KWtc
         yePCIKtOONU2X9Yd2AQZ+iVH+0/mpqOGePUOQ4j8iis4egSSuIIYcI8AgufYe6AR5IZe
         KFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754066429; x=1754671229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVRaPNkWEiVk584Q43nPTvrPYCxP5q62CxOl3nu1gRA=;
        b=X1ahKih50wqyENz8HRgiW7B71PEiGDb4H6cwMS4y/iNTWUplnydl79KQc/4tcDbF5Z
         7K7+Nco2yE1SmfhEBIgpte/Odze/OWu9fk1HFx5U6wVC+m3LrUvgOoNpPWbq5TxCxaTr
         uKXtwTpQo1HhaVDlIZSz9jEg6xOd7Kf7cE4SkP72s8J+Uum+HZ4BfL5bl/zWXZ7Sus+i
         L1lIlD6b14+AqT4yTQpeQWUfsZlyDAF8tkqQPH9y9bGAMgSXGpU/uxoJEaJruziNZids
         cHGpz4iCMsZZe5UlaXDM1BmGWXodPRLD1ykfhB3aSJ64im08AaagKIa8xUMl6gE0BkQ7
         hbWg==
X-Forwarded-Encrypted: i=1; AJvYcCXiBbQ+iDBHQjYaaGcyMix5nKuAAxaUjSjqze+tvlEr+cQGSqgia90449bniU7qCYS+wSWgVfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygHvtdhVwL/YfBUv821JszwCNyVXs1wyVlG41nlWj4L0vSYkV8
	vF1nUnpX6FBUvuysNDN/3Xav0PJBQ2Df/38QaV4OxRENzXZzGNfK3L44/4NGx/1vvMtgy1Dmdft
	me9msmcS451eq8lxt0nXB0A4KUcC77NY/TSCzBbIy
X-Gm-Gg: ASbGncs8RUoheytrTxMNFaHqxDM2DByyMd1creUPdiSeTFalqrkFw+0LRswS8UdIFlV
	GzgZJ+vtgLmDP1U43qcEWiYn5HBGkHQ1Nf2Gzm2Xs4533UM5gv8tivXWTN1s54NKzNL0ng08UwK
	aYPdGiRCr85nbBNFtbt7A51ofM1NI527QMxWuyOs7aCUNUAB85KCAvNJzXmd0ShhQcYJYgOnsaT
	PhZMsmlighCanSJjGTLHkDpiktpCxvrHNfiyXwia4kRkf14
X-Google-Smtp-Source: AGHT+IHICPxSrY2fp2CBU/J4864A98geIRJAz8831Kq4ZWEu7nikPYXd1XcMokZjIcsLEPa7GDO1wQmFRk0dE2isW5A=
X-Received: by 2002:a17:903:41cf:b0:234:9fd6:9796 with SMTP id
 d9443c01a7336-2422a43570fmr3511565ad.19.1754066428757; Fri, 01 Aug 2025
 09:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801011335.2267515-1-kuba@kernel.org>
In-Reply-To: <20250801011335.2267515-1-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 1 Aug 2025 09:40:15 -0700
X-Gm-Features: Ac12FXwY_BCgB-OT8rFm7C0f9sfn-9Y-5npqefEdx_cHLh5Fhpfl49kX241T6Go
Message-ID: <CAHS8izM8qUOK3P8X=tKsR=zvMe24RBqYJUwSvAyWs4iXStjvag@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: fix DMA direction on unmapping
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	asml.silence@gmail.com, sdf@fomichev.me, dw@davidwei.uk, kaiyuanz@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 6:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Looks like we always unmap the DMA_BUF with DMA_FROM_DEVICE direction.
> While at it unexport __net_devmem_dmabuf_binding_free(), it's internal.
>
> Found by code inspection.
>
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

