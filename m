Return-Path: <netdev+bounces-213078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFD3B23423
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 20:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83201562104
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 18:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112D72ECE93;
	Tue, 12 Aug 2025 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8/MIK+z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3314D2F5481
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023547; cv=none; b=pFMJBhr57mBkTYn024k0hQAN0tLrCQQTlS6HSaJkKf4F4jfmO2Lxd6sdvJ5zGW9hsCs6561GeRBzDzT+6dZgaE3ixmCwEzelg/zL23y+EqFt8RVbSi7Bw/alCmLyzn8mKGQwvN8Xwtrsy6SqzkSELHJr73DgpVyl9t0v6ST6GN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023547; c=relaxed/simple;
	bh=FZPHtgVyhX0m7jHHaFrr2FnifaR0Btl+pceIi79EiEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMCvPEybjCyEsKq7VjE0ppkz1fCJZWk5o0HVP0RzUv2x3+jXDIkQdnpHQFzQNWQz+xcCNpK8VjCYyFJMspVa9YZy5z7+QWtTA+XgKbE7MK8nfFYnV60CoKIrZ+wtSxmaNTX5G7qPdKFYw+613E+Q4FxW0YLJmc/hW7w9wczfTaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R8/MIK+z; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55cd07a28e0so2024e87.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 11:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755023543; x=1755628343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZPHtgVyhX0m7jHHaFrr2FnifaR0Btl+pceIi79EiEs=;
        b=R8/MIK+zOYicOriW/NHtucuUHhB8u2kLHlMZ3+KG4IDThxGMxN3L7HDW6VJcVsTfTJ
         7kumg9tKrStthMcXaIngNLs2gJqMQ/arzjUzefs2yBN2Z05j0Qq+IDjngYNku0rezqqg
         fItVVBFIDJ2AiPEDAoXQBJT1vMGAp/KI/8FJWfCJOR6cY6mN00AI56U6B/S4LGhjKokv
         fuQ1JmYC8BYzVzjanba3qxmlm06jcEnAtmTQEf+71ASFIOgxOWko31F5uHVhAro2WgfS
         2AFeYWUVhDR0RbWm2cKovIsHSe+xE/Ye04GK1PX8OY0o2ot9dTO1kH26JcsthISNESPe
         djfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755023543; x=1755628343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZPHtgVyhX0m7jHHaFrr2FnifaR0Btl+pceIi79EiEs=;
        b=NFNerBuw6eRSaCaUr2SrLvkIuDkVXBVUivhvLjHdlBaJDHOLLYTVj2sUa/9pPi5lYT
         HILE+59b98ugqx59PWPKglZgKsjPpFawTZIq37/aaqSqyhdoPn0Y3SWgT7d2LTtmXqH2
         3h9J7prNraG1ZuISDJigDoM7xBcIMbiWN+0GRdmEECC6ML39LosrVRc5efvybxHUFO5e
         LbRDdb6H0LMuU76i2ys8ne9xmXJg3dNuALukEDebP58f61luE+iXjqcxnzQkuRYj/jBA
         6GG1vPaaqF57tYsaNuVL8zZTsFw4RhUz9r642bPIcVpwTbkYsXQkvzPq5tCwzGQQCZRc
         zmMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW25KMgONHecP4W28OtVAbvWvn2IKtFd2ktMl++BnypxD0ocbdQxGrifGcsMHihcGf93/X6ymQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8guI7UOYTHURY9P9ECzw8vsL8YDdla8sEMIAyoVwiaF0u4Oe
	dCE22V/l4iP1PwuECPIP+pvDyGc5XN1TYT+/wgjsdRfnbnKeMSZJwlpR9zNnJsHP+qnhDDAwzJQ
	nk4htOQV1NpuwMwzlMNwXy1NXpTwwpBgSPs36220C6eHvK1GHdfIwwjli
X-Gm-Gg: ASbGnctOzef0f3ByteE49pf4QobKPWjoey/XXA5shNKRivwxfj9ypBVMnImoAaj0+2E
	y84nus9lPc3jBZmO+VGjjr52kfD6Bg5ggJIwWvUDNvIau9BXNW9VS7kl6FEdm+/aNkDTo+lPjwk
	qVVT1HylRw2I4bcdq6mR4I8whpZUPbmkvdWEfAfgKP1LzSPKYAjOJxd8ZFid3k+LTV8lRsIAOiW
	RSeGXQnA8SJmFUtNcK591Z1NBcHAIY8O1Oz4A==
X-Google-Smtp-Source: AGHT+IG8FaZ3ThAX6AeXsoA+NmzLH2hPy9bEMgldfmA2/376ZbHPWQiP/tjkthb7U8eOjAbKl6B+IO3Qu/uFgEhabfs=
X-Received: by 2002:a05:6512:ad1:b0:55b:af2d:393b with SMTP id
 2adb3069b0e04-55ce07374e3mr20418e87.4.1755023543040; Tue, 12 Aug 2025
 11:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811231334.561137-1-kuba@kernel.org> <20250811231334.561137-6-kuba@kernel.org>
In-Reply-To: <20250811231334.561137-6-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Aug 2025 11:32:09 -0700
X-Gm-Features: Ac12FXzfrsii7ur7xgN44tM2MW892PzoXxuy4ivcSLCGpW-vYAI4foQcDUESiTk
Message-ID: <CAHS8izP-EMxFFSF1f_8ceP2_1vt-Jrn0tnp-Bc4OKRgX3Uz_3A@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] selftests: drv-net: devmem: flip the
 direction of Tx tests
To: Jakub Kicinski <kuba@kernel.org>, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	sdf@fomichev.me, noren@nvidia.com, linux-kselftest@vger.kernel.org, 
	ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 4:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> The Device Under Test should always be the local system.
> While the Rx test gets this right the Tx test is sending
> from remote to local. So Tx of DMABUF memory happens on remote.
>
> These tests never run in NIPA since we don't have a compatible
> device so we haven't caught this.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Changes look reasonable, and to my eye the rx and tx commands are just
switched with no changes. I would have liked to test this first but
I'm not sure I'll get the chance today. So:

Reviewed-by: Mina Almasry <almasrymina@google.com>

and I guess when I have a chance to test I'll either give Tested-by or
a fix on top.

--=20
Thanks,
Mina

