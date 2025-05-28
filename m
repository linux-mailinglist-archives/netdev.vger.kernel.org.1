Return-Path: <netdev+bounces-194069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 387C2AC730F
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 23:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECB8189DEEC
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 21:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D431C221273;
	Wed, 28 May 2025 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x2C+2CcU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA9022069A
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 21:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469230; cv=none; b=mntqpqGc84g0KQbRkuqteLcVjXvOao4HdQJZICRW2wsgLNkTmj9mBJ6prQrmddDCpGIzoBLO+inHFTmKm9R6Dgb5dLhDTvGV5HrrV52+WcUetxOzskuMg27elKAI6uQgDZiW+lXLhpjxuxSh4NFJ/PrJkS7QLf/oyYtK/5LcApo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469230; c=relaxed/simple;
	bh=tdBL4OiCynGHS5/1GtWDlewdITtZoeyQQd0rZF5zWFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGpioXaXGOjiWFJwFOxQkm52n+uC13CNuXHURaZ2SVmt3dHpEHA2oQYGEiOir8AuRBt1uYINlZixA1x4kDrfSI39An0pbPlBJ6oTRZ2IcpoMsSRZP2ux6eXPIGSjSB6U7JIy0AYBKzWXX9iezkf3cpeZK/GrQgBhha0mDho4fpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x2C+2CcU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2348a45fc73so61975ad.0
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 14:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748469229; x=1749074029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdBL4OiCynGHS5/1GtWDlewdITtZoeyQQd0rZF5zWFQ=;
        b=x2C+2CcU0IuvJK0AS3AaXmDxQnTVzpTipjmpeEu4Uc2Xs5Lxa8DaNrTC5/952yDt+L
         uHcY72aHEgrPtLB3mmscmG8p1E5hdtxJNg4Wu2MScluGc3IrZbXujNoGKbthnRf81pzl
         6mH5Fbl5cKIpCMuCPhT7U+Gla1xfkIOL3dKP3H1A3flxA+ZGB0ar287r04AwyXyfQMy8
         jLVU3OZSoZJoi+Hqvse6PCe0yuKKnY4L9CXZ9vrqIIOF5jkPaMqNKrQ3wptBt2CZGDtA
         DgCUcFApZL3Kj4xgew8kcNtuLCAdoYMGeaLVG3XjNCkjnz8T8NOXftIiKUYyzpeKrJOK
         I96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748469229; x=1749074029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdBL4OiCynGHS5/1GtWDlewdITtZoeyQQd0rZF5zWFQ=;
        b=hZ0NmTjTehpCE4QTiA0XIoyEkzj/jC1BrcyB7PzlY6xlNKTl22TwdRd/HKkWLSmjS8
         16IbaQf+2/e5trTQrVOAwMnECs7YsiMVRHVV1ejAansfqrvyL5JHfopjgXT/eT21HcyA
         xS93obpt+s54+pUY0keNlALcv+eXoOyTvW8Fwi0zHDwKP1c2hbfZghmfyblc77K5FetT
         6757u3p/tNQohEmokUbrC0EyMxHrG5C8xFlNn4CfFmIW207W6sWEcjZ63r3HcE3/w3mt
         2V+mslVYg+1ilHGZiBFQIbO+HTjURN3cFka5KNfOEMWC6bXUOO50rdAfJ9V0a6D8doR+
         NJWg==
X-Gm-Message-State: AOJu0Yx6Bo3d38kUITMTp9GDxmJJ9/+AiU/oGfpxywjwnPN6uQ9JYLMh
	ZtmaJa2noJirHCB3nB25eT+OdVYhTWydp1W7laRoOU1jvcGDvT51x+m0u0NMn22m3GOygr4Zl1/
	nyaNpXU8rc1elaknukJZ9lG6yhRUdnXhyAleQK+U8
X-Gm-Gg: ASbGnctaPdIHdDxKTUpxafh47aO5x77vyBzOks+Uc8nKjiJlQ9NsMmld2NwroXJ8siu
	GlY/tQSpZ8pksWGo/Y+f+/7mRgaSHyxVMfc0GIacqeGlx08+r/k58MAhg27b3RxP6sqYzVpU5fZ
	T6hDuYWMg+Y068f3Nx2gZez2RwB5qOrFAg49HkPXCoV9xzeZMSJKzN9dueUVAcvLpwZOsvArh6i
	tPinNXeAObZ
X-Google-Smtp-Source: AGHT+IFjd2gU4UQSJCjlqIvJwy4nwFdqLPkwcqaX2VVHjyCIXWweHec6ZUWh6KkIdhJ5YTxoolAdZ0V8xYb7cMsPXo0=
X-Received: by 2002:a17:902:f60d:b0:234:c37:85a with SMTP id
 d9443c01a7336-23501b91c53mr1061405ad.24.1748469228461; Wed, 28 May 2025
 14:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528211058.1826608-1-praan@google.com>
In-Reply-To: <20250528211058.1826608-1-praan@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 28 May 2025 14:53:35 -0700
X-Gm-Features: AX0GCFucimbYCQDn2ZRqylxWQl2lDmqEMcsSf1WKh40OYjWwm8mU_thgbFVewl4
Message-ID: <CAHS8izO=64PCgs7mjobznH0D7sQ76fBXjWoTTNxzO-Or+hqhcQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: Fix net_devmem_bind_dmabuf for non-devmem configs
To: Pranjal Shrivastava <praan@google.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 2:11=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> Fix the signature of the net_devmem_bind_dmabuf API for
> CONFIG_NET_DEVMEM=3Dn.
>
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Patch itself looks good to me, but currently net-next is closed.

I've looked at the maintainer docs:
https://www.kernel.org/doc/Documentation/process/maintainer-netdev.rst

I'm unsure whether this needs to be resent to net now or wait for the
merge window to reopen. I think net is for fixes to code in mainline
linux, but the devmem TX path has not made it there yet (and is not
even in the net tree yet). My guess is that this patch should be
reposted to net-next once net-next reopens.

--=20
Thanks,
Mina

