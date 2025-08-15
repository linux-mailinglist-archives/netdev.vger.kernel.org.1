Return-Path: <netdev+bounces-214126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A369DB28528
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565F35E7614
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC32F23E356;
	Fri, 15 Aug 2025 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SNnmJ3c+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0164B31771A
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279063; cv=none; b=ppVHTACZ/ig63dyjF0di3KfyjPCZwv3lrspCBN5Dd3/uKa2ZZ+nd1RaXUbCs/90EzYfTreXJj363ZkIf/76CFcC28jVfNI24zds3vod9RkHeharVJ/3FXXnh7czpFWU0tBYcoPQDTHDF9t3LTSnNXIQByebRjQWxQgD/HgG9/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279063; c=relaxed/simple;
	bh=mobCmTcoervvzQDAYEWLNYw7eUh0P2pRE/LXg+15ToE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ho/tjGXEVG9pofezJTYu1wXBGG/rhTNcOEW7t9JQlkx32Gu3NQ9lzmd59Gm/9OjImViJyMm24XggWfDVUriKq3DZE5ZKmeDX0GId0vorqAMoUGHUMjDyv5SekUkWzbcvCI9pmZifArSzVnn5ahkIRsXdUv/IAzrgMxb4TZk+t/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SNnmJ3c+; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55cd07a28e0so565e87.0
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755279060; x=1755883860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mobCmTcoervvzQDAYEWLNYw7eUh0P2pRE/LXg+15ToE=;
        b=SNnmJ3c+A7eYqv4cFy3cOGLSAVL+7SjEsP+/N2eRx+x41uroO3UwAeA7kz4Y2THuXA
         AUGdsd5pK41WEaE629OmUxrBQ4G62JoC0tjPGyJUUP20LPKrURwF+6xDGVlKR1K0C0GL
         P2kCZpKyZBJwgXf5+ogzS8K47pmcW3YnbO6GX5LUPCbQTYaIy3v/Wv1+ZAzsOGdq09c/
         CyK2NolnE3o50vvFguHc+WvPtwv11G7L7ohPSkO0M+tT7HfblRjNQNMiWIwX225pSyaL
         yGg2nY2hfj+/eVphcq69wjNg65iz/Nja5UulVPHRcnAJbg8gqCjEY0lfg5epny5Uv0zJ
         2jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755279060; x=1755883860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mobCmTcoervvzQDAYEWLNYw7eUh0P2pRE/LXg+15ToE=;
        b=SRJ/6PL02tkUM9uRJl+DMYfOapPq28GEVXNACADv7/TjI0AHt49XvpzncEvR06sVta
         U4teJp3FyZKUe6ChHXtUX/LyhNqQeIMUyQ4ooxHQVesXNLr8epYdGBrUK1rnpsTLhAze
         uLYqNrfOb+PJua2ZN9FzkAK8HXlnNyQfE6VJf7jCz/v26Mt1OhqeFC/KY3KSsTIaDjdc
         UceMLD5rjoW84fOCRscgyVYMJdLY2hcfvqSD7kwU+40+b8haXmUTXYbdf7zlNFhNzzq7
         gSIv9eams44zESJXPBfI3k8y2+JGe1kO2KT2FjnkNV6qOzioPvJL9FDAG5Jis52xhxP1
         AIUA==
X-Forwarded-Encrypted: i=1; AJvYcCXkxYB8hPO0eBXkCApTrdD468pLD1txIcno6jP4XyAqiKVwPWywLyWYfuH+6CHiRLAdOI1fuSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkkhrBAeXDdrpr7qmtJ3lB5lmD09HgrqDA40ow7Z62bjMw8NEM
	vs0cqJBlzx4ut4+xJjOo05nsSrc+L5QFD2NdnngfoHVS/5MH3CeVcdOW4K19OSGRItAfdnAEKx2
	6Xmkn8WMTE2GB4bV+MloCu5rmBMv6G84fWm2b9arG
X-Gm-Gg: ASbGncuxb7OcdPV3ExDmhOPld3DvPMzBDK/u40XHSYFNHgyqWchfrMnEJWyu144Ba8B
	SisHvr6DTcl1OGhkgmhhmYr7oOW/D0IKIvjdlo+sf2gbYSyIL+J/m+08dmhhV6qnIlauo2CBWw3
	iLPUCvra2DGQrV+Rd/ZeQBh6+ycyDmCMVK0ags1yNloq11Khigp0nI/0dveeLeMfsSWu2o72Unt
	vEL9dz6w9m6AEQwUMNvBGlibQ7D1hWqF/BofgtD2puc
X-Google-Smtp-Source: AGHT+IFaLkuuDT/VVfMrvKtsqqc0E1bOYEvsZgrv1o+nssQyPwmOxJUpUXvxri1aojku/i/Ml6+2KjySp+8CaHa+pKo=
X-Received: by 2002:a05:6512:609:10b0:55b:528c:6616 with SMTP id
 2adb3069b0e04-55ced415845mr203876e87.6.1755279059754; Fri, 15 Aug 2025
 10:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815110401.2254214-2-dtatulea@nvidia.com> <20250815110401.2254214-5-dtatulea@nvidia.com>
In-Reply-To: <20250815110401.2254214-5-dtatulea@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 15 Aug 2025 10:30:47 -0700
X-Gm-Features: Ac12FXwfCeVBcjH2yFtZJrTnkRMbFtJPb_qiEU59YqydOOh0OBslEyMLgKNviV8
Message-ID: <CAHS8izN4b9b39DGmfBb3Ba8p5swQiHpgq7Q6nib3O7unhhScHA@mail.gmail.com>
Subject: Re: [RFC net-next v3 3/7] net: devmem: get netdev DMA device via new API
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: asml.silence@gmail.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, cratiu@nvidia.com, tariqt@nvidia.com, parav@nvidia.com, 
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 4:07=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Switch to the new API for fetching DMA devices for a netdev. The API is
> called with queue index 0 for now which is equivalent with the previous
> behavior.
>
> This patch will allow devmem to work with devices where the DMA device
> is not stored in the parent device. mlx5 SFs are an example of such a
> device.
>
> Multi-PF netdevs are still problematic (as they were before this
> change). Upcoming patches will address this for the rx binding.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

