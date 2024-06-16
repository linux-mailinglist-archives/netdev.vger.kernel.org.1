Return-Path: <netdev+bounces-103879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 689EB909ED2
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 19:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0161F22605
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 17:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19971C68E;
	Sun, 16 Jun 2024 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asAvKkQB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B38B8BFF;
	Sun, 16 Jun 2024 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718559295; cv=none; b=oGOcscVnmOuJWTFkWYclGsAFDbJpHIuz3kLo3uV2jIH2gxqbRGtgjrVGd35ABtO2YZ9pIGhf/7M5GRFoRaJYBsIoS7WA38zNDsLvt/5Q+PaNs3zE1XZ4tl67pGdlH7OLD34fnXFRqD06//5tnpTH7xGKLs8pbc8Qq85duzJ7jv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718559295; c=relaxed/simple;
	bh=nBoRWY7j+KChaT05OiFvTI9j9fKmSRxurLI8csfuT4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPdo80TRynB2UzGAX47rDeB7mhe512O609nvv/yFh9NRcMmaQaZG0+VCcxJba3jTesYl1SGaiZI1hkD3AWd7Wg+K/dKSpjSV0ZOsVMzL4ImTdYBK92SAj6OeuwR1wsy7FwavhIIMVnTxxcczjK6fiu7se7ckDR0ypaXkadAZu1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asAvKkQB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42108856c33so28927805e9.1;
        Sun, 16 Jun 2024 10:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718559293; x=1719164093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nBoRWY7j+KChaT05OiFvTI9j9fKmSRxurLI8csfuT4M=;
        b=asAvKkQB9diEEPeQa/8J29rj3DLZ5fa522Zy3lBSeX6pMC2PsRHICovFslntKfS98Z
         VJwrpvwSYfdOi4HsrOlxqkBlB0eotbU8qWX0mVhrzynQ2PIac1UmuQrVVj4ItlH1Juhv
         m/7zDvV88QgMal2LO0/5f+H608hCHWpw0v9bhfGHP1qUv1aIdt/d4g8JizU/MNP4zs1C
         K5Kf55us0mioWitwriwQ0r9kc125zbswzJC4bl9Uly7KxNpJqq2CbOi2tRcGnqv+MAO4
         MCxNbveCPjnPX00SIjjCFkHPsnL7cX68F9xX5Z+2ZstQ4R3O49pddkTCdS2STrj6Sj8H
         qLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718559293; x=1719164093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBoRWY7j+KChaT05OiFvTI9j9fKmSRxurLI8csfuT4M=;
        b=H/7EcbbaPaS2wOvzJRA5fuo7jGIVzswIK3WHJ6NxONLjczGM0B0HAMbVyhOcG81ADY
         9tbZ89bcKoN21VFphDx5KYDrfubj8gN+KjW3fXkDkQNxvE1ZDWzj26W9TVtJpeZAi8lM
         G74F4yArSUwBUK/yJk275zouD0KILMD47E2tlYZp6lTXMAsdVbZEbvgNbTCziWw6+lvF
         8D/5AXLWAHL6XNSTgCJUlYs35W0ob1m4iDBaRqyEOyIWy2RAk6i2RoRevBh5kawy0UbW
         6Ph5DsOXI1vzDIa54Rs3HmIJJfhK9o2h6gkDvPQ+c3eGLpnrAS5ezF6qoNQstIVTBhFa
         lPvg==
X-Forwarded-Encrypted: i=1; AJvYcCXvyhvptrgP+Zwd729JdZ61zboVxyMWhvHClmzJk3Zu/7MeCwZMO3bFPTakz9GFZG/VcETaYKZ4TbyeYwWif2nzOAvGD1O/P0l27RtSZZwEABLgTmJ61aShViMS8vK9GsRYDZ9I
X-Gm-Message-State: AOJu0YzeEKIR4VS1csTCl7mxpn5YE02PYrs4GsBtYZs2O84yb6XJ9vmO
	3xkyJpDDAAaR64qXpMCIq/8f6URDUbwJU5vr+pxQgz0GBARQs4vKhSgGeNt3uc969aPdpYUlPRE
	cnOuCfTK70RNMuVxlRFPgTJhWukkTpzNjRWs=
X-Google-Smtp-Source: AGHT+IEu9R5ps8z0ag1x9yvDbuPzRc4SvSDrkTZnExvKYz8mpN3z/gMPOIu1p69pbspBEQ/QMPtSYcClfLge19czC1o=
X-Received: by 2002:a5d:6e8c:0:b0:360:7761:e304 with SMTP id
 ffacd0b85a97d-3607761e376mr9263379f8f.1.1718559292499; Sun, 16 Jun 2024
 10:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607082155.20021-1-eladwf@gmail.com> <171824043128.29237.10490597706474690291.git-patchwork-notify@kernel.org>
In-Reply-To: <171824043128.29237.10490597706474690291.git-patchwork-notify@kernel.org>
From: Elad Yifee <eladwf@gmail.com>
Date: Sun, 16 Jun 2024 20:34:44 +0300
Message-ID: <CA+SN3sogd29XG7Sgz1EOqBqtxxcVzFkB_mFq10TW+eYGKtdDTQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6] net: ethernet: mtk_eth_soc: ppe: add support
 for multiple PPEs
To: patchwork-bot+netdevbpf@kernel.org
Cc: daniel@makrotopia.org, nbd@nbd.name, sean.wang@mediatek.com, 
	Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

It appears that the current sanity check is insufficient. Should WED
be utilized, it will be necessary to find the appropriate PPE index
through an alternative method. Kindly revert the recent commit
temporarily until I come up with a solution

Thank you.

