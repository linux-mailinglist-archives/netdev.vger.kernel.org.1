Return-Path: <netdev+bounces-111496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AB7931628
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BC01C21C62
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D632918E761;
	Mon, 15 Jul 2024 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VckmF9LA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC9518E75C
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051770; cv=none; b=NSkuPnkxfiXisOnsWzJ58sFfqHi/sLTDckuXMy3sb4tmcAFHZehKFQMfFUt+w3msxWMHNVu/BWqbS6vvg9puPKUKtOh32kw/2aAYGF15vfhpsOMlq/h9bhw4geW4ZQrLe6hUyfKgLGWEqUN+R757S6+KxCaBsJXAFt7kCFkl8qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051770; c=relaxed/simple;
	bh=bFfVPAx2FlUnlozD4rqd8fm1zpOfw6gmIK7m8y/1tHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNPpDi8gnVQ/HXHgALdtrSS4Cn2cpcAsB/nhFrE4pmG0EalFTLtLjGO93PrdtKhOCouAJLAQThCaxuSylnQfpVrXhmp9ZdCfN2zlVfT7kDC8DQkxF6xIDUa55bkk/buC+CJ/2x7RhHqNZbtxEn9Kvpoal5oCgJDQPAI/plXp8Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VckmF9LA; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-65465878c1fso49288687b3.2
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 06:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721051767; x=1721656567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0RA1IZPWVo6ohqXGHAjDNLvDb7ueOxWGeXQQfV/F8Kg=;
        b=VckmF9LANyatWSYc263xsUb1dE8YaZd0+OHrKdBVypEhlZyTt/28QtQu0NN8SiLsko
         aDFkuPul2M801zOgD/kJL6eY+lL89146fdgpoV47AnllbmmINMmaam/HYwqSK3U/lF4g
         xSvi6amEI68xqa2ZGuN0MOks2VG10yCm/EDvhXLstuiiAz/CKhtD7w3aIYjrDAes68Hu
         kf8tkPe3WKhEA/HYy6mXjI0HrlhKdkK3XE+XEW7eg4Y8ispGFVhYhlxmXevafBuvYepa
         WLb47ZGkuyAkN3PSe5Mh13+agJX0MTee5HR5kxjZrMJ3pcCm7QV/whRPq6oZJZzZdiYR
         RjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721051767; x=1721656567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RA1IZPWVo6ohqXGHAjDNLvDb7ueOxWGeXQQfV/F8Kg=;
        b=GckwBM2ZE2Ri9yBmACJ95qFTZmBh2cGiGKYQbVKX8PN5cPIDWSHvJNiREpZxuOSnqC
         WaqgFRKOIw9w5a24zDjiZrOWtnPC2v2PrCHqm3/BZvA1YP1QdUTBQSXlNTrQpd26s+Z7
         +RK7/xjMwJMZR3ONZGTbMOirQLp5DKERngxD8b420h3NrMC1o+aKcU+Z9pO9+l2QluVk
         w2w0YStVU9oLk0IgnazC36JxJQLG2CgQqZw1Mlf+tBoKy+ALxJxhGsMGMXC5fot+19nM
         Pfm8EN5hZkl11qMVfPhWpbYLUj/szWrC448TCuN4/uoLIsrbOYHdKNXWpSVGctzbYjTb
         rQfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVibppnsOXrfrRoR8goCQuU8RXUlOH2dAcvHg31sLan2gWjyHfbc1pUrSjt/SbcXJOJO4/ZBW9BCREoH3RAB4vwcx1fWHkb
X-Gm-Message-State: AOJu0YwEMRRdwPrjtqw30CPA7uRzxrNEhTegrtv9O6DenWHQbu2vUUhc
	/eoJfFEXb9EgXHV0KDsAVX5HnwssWrRuLEGmhT6Nv1iyYQRqfaLj9C82i6A/J49HxVqxCSmVXXd
	jGRu30oKkkryAX+nG2yf9IonYNbVlefsEjOaVLg==
X-Google-Smtp-Source: AGHT+IH8Fq8sJFyAFjhvFfVJKLzJiAL0sfiMFBS9QPy9MR14k7PHxaNSoHG8a5OwITL00/vzZC9olfgQjDEoFeOZGqc=
X-Received: by 2002:a0d:f6c3:0:b0:650:a5cf:ef5b with SMTP id
 00721157ae682-658f0ebd21emr207164357b3.43.1721051767156; Mon, 15 Jul 2024
 06:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715015726.240980-1-luiz.dentz@gmail.com> <20240715064939.644536f3@kernel.org>
In-Reply-To: <20240715064939.644536f3@kernel.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 15 Jul 2024 15:55:56 +0200
Message-ID: <CACMJSes7rBOWFWxOaXZt70++XwDBTNr3E4R9KTZx+HA0ZQFG9Q@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-07-14
To: Jakub Kicinski <kuba@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 15:49, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sun, 14 Jul 2024 21:57:25 -0400 Luiz Augusto von Dentz wrote:
> >  - qca: use the power sequencer for QCA6390
>
> Something suspicious here, I thought Bartosz sent a PR but the commits
> appear with Luiz as committer (and lack Luiz's SoB):
>
> Commit ead30f3a1bae ("power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets") committer Signed-off-by missing
>         author email:    bartosz.golaszewski@linaro.org
>         committer email: luiz.von.dentz@intel.com
>         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Commit e6491bb4ba98 ("power: sequencing: implement the pwrseq core")
>         committer Signed-off-by missing
>         author email:    bartosz.golaszewski@linaro.org
>         committer email: luiz.von.dentz@intel.com
>         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Is this expected? Any conflicts due to this we need to tell Linus about?

Luiz pulled the immutable branch I provided (on which my PR to Linus
is based) but I no longer see the Merge commit in the bluetooth-next
tree[1]. Most likely a bad rebase.

Luiz: please make sure to let Linus (or whomever your upstream is)
know about this. I'm afraid there's not much we can do now, the
commits will appear twice in mainline. :(

Bart

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/log/

