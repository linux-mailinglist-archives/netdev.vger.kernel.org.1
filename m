Return-Path: <netdev+bounces-120660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6752A95A1EC
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242D228D7EF
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332F114F9E1;
	Wed, 21 Aug 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvhxToZB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820B814D71F
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255015; cv=none; b=bZ6hHPEmxacWS2q7gWVUlFsCC1s/BiuaFf5lpskQvXOjt3ntAGGiBDr9eGSjgoqwBGPxutND14VlHYLsbG5OxSqwsqrt4shyyoMawdnxJtT4duJQBOSbICcFdA+vDLteb3f7f5FLpguDrcEZuQW/SIzHnzuSlDb3sSkDbUt8yEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255015; c=relaxed/simple;
	bh=FE4aY/q5CVtWooWDCyJ3ysUxrUcqnG1S++u6HwB/bVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eiVHCrKkikYAqMva9OwEAiPYEcGg4eklsmjOG9v9u9MCc2qe6kHwUwufPKz6Ok/VJ/eT/ipGSBb25CEuqby0v4FBxvDkIFI9Kpa5+Dc2DfBHQkGrYDTdaaCwet4M0HVlyGVEMUJS8DjoAvgPkCMorlHKNSiESw4mAK/dUo1WtTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvhxToZB; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so752060066b.2
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724255012; x=1724859812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FE4aY/q5CVtWooWDCyJ3ysUxrUcqnG1S++u6HwB/bVY=;
        b=fvhxToZBeFVduwXh5P1sqnp/H0MBFjS8mLvyAwEqiHLl3ig0HhoKGlNgjhCq0djQZG
         9B8K4IXWhN69uLuPZmh+CgrMbrIbf42bA00oMpIJTjg47YFWCsflLs7K/Ppe7vHmgC0/
         TB8aimcd+/8f0v4KRZXgLbFugXpEoPBL4K5EDQq6O7WdxLTYAy6Q1m5rCz5ura/Idpui
         FAisZiT2EwcpV6BC3O6xNwvz3fFFPbO4SQGJcwP/glU3bxeKrujpMynwOy+hbdZauFGI
         qlefeMIs8RxSUaLNMmLBWKGVGzqKN7A8CEq9BnuFWU0l0vE9Vlu26PSgX/Pgnbyn0ItT
         8RDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724255012; x=1724859812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FE4aY/q5CVtWooWDCyJ3ysUxrUcqnG1S++u6HwB/bVY=;
        b=xEValnVrlQpWIKqX5hNUo3yAievi+tRLNFJI+11veW0JnOTWpweU3f/9nDVqXnRfet
         WpwNDSuQZ5k/HUIpMD0zJSKC1NjFXNCPniTuIuPQkPuSOUlVCF7jghT4L1vToBQMCZBW
         GakQe5o7j9SMldaYmA+k6/lb9wzHXhBlCBlOJCfwOlXpnWDl/6rKcGoaq+lTt9oehYyy
         O3wF9N6f9e+uKIkz/XxMssw7OhoVubL2kbDQFUUZL8rY6MTk6YQt8yOs+we2/fKmFtoP
         DYBSKvbswxS/D44qz/HtP0Ma1lkTkGUk4K10adgKlvLN0BlxOjLFIPRx3ks5xIGs0Yhw
         ngOg==
X-Forwarded-Encrypted: i=1; AJvYcCWs11G8bl9zudW5lHF1W0zu+JeUjRRk2zt5N+T3HoZjYZxdPOqCtvJH1eEHtCN0QxbIy6oUYhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Pk45pqxGesGw/ryP6yXhzITtZJvmLMaUTky6kf1lg0QIE0Eq
	JbekuDk5s8taBHSOPPrRGBQuTb9UVpOD9poZTjoC8ovPwNsQUQ9XtuLfmAHQZ5Th/zE6MekxFt5
	FLZKWfwsFMv5qiDq1P8UOr2zMfnzCmSBnakZK
X-Google-Smtp-Source: AGHT+IFXM1haTH3Tft82GioemDeMyJeWgfsUvV1Z0FDSHL0znQ9kGlTog6+S/Takg6dPBnQDSWoR4E6wLJW9Oj0YiHI=
X-Received: by 2002:a17:907:c7c9:b0:a7a:81b6:ea55 with SMTP id
 a640c23a62f3a-a866f9d2804mr249205766b.56.1724255010853; Wed, 21 Aug 2024
 08:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821150700.1760518-1-aleksander.lobakin@intel.com> <20240821150700.1760518-3-aleksander.lobakin@intel.com>
In-Reply-To: <20240821150700.1760518-3-aleksander.lobakin@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Aug 2024 17:43:16 +0200
Message-ID: <CANn89iL+VTJ6tEe-PZ24h+0U9BYs0t4gZDndiy7j1DwuKMBEFg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/6] netdev_features: remove unused __UNUSED_NETIF_F_1
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew@lunn.ch>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 5:07=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> NETIF_F_NO_CSUM was removed in 3.2-rc2 by commit 34324dc2bf27
> ("net: remove NETIF_F_NO_CSUM feature bit") and became
> __UNUSED_NETIF_F_1. It's not used anywhere in the code.
> Remove this bit waste.
>
> It wasn't needed to rename the flag instead of removing it as
> netdev features are not uAPI/ABI. Ethtool passes their names
> and values separately with no fixed positions and the userspace
> Ethtool code doesn't have any hardcoded feature names/bits, so
> that new Ethtool will work on older kernels and vice versa.

This is only true for recent enough ethtool (>=3D 3.4)

You might refine the changelog to not claim this "was not needed".

Back in 2011 (and linux-2.6.39) , this was needed for sure.

I am not sure we have a documented requirement about ethtool versions.

