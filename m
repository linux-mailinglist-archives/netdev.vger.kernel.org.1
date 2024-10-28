Return-Path: <netdev+bounces-139612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFF69B38EA
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 19:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1C41C222E4
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2031DF251;
	Mon, 28 Oct 2024 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwZAILUi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C251DF254
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139423; cv=none; b=eJLiPpaeJmtIbJAwku+FsiCEGIneA0kRMIxPtEarOkxUhwhL0Lf3aKDvg9WempPMLBWe1FlNO/SirGkqkCL5fdhohKTIOXbi/AU2IcxYGwguruDmfpfJdnA/EEIGCA3lpnVqVTStKYFIB649pp5kabVyo5ruSh0l3sjtwOs348s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139423; c=relaxed/simple;
	bh=jNv5eywtec1rxxiPYEyjudAvtODlzk0F37yJwX0omnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aE8vYxCqtHoUBxqmK3um0er8x9YGinPqkuC71Z4oxkeqEU6m6l5VzfdZf3+0jVR34scHc2Z25oZGQIRkwaqt5yg4gFwJL/C76xCPlkpfouomHGr1qo8H8dG/1/J1kiW3nTUH9MtS7OBFFDhpNUgxPiwrlhmcu7zQbvpK7tAAL9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vwZAILUi; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e681ba70so3110e87.1
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 11:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730139420; x=1730744220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNv5eywtec1rxxiPYEyjudAvtODlzk0F37yJwX0omnI=;
        b=vwZAILUiEKsJ3wuwfoJwZNP8FwzQof2mp91gG65N6fvHJdc+9RQJIsRSgnPj/lXDWi
         BgV3oTJM3DFN/QfIQn1bkSjrrkgxPZuwIba22DEwZSGfjX36WhiZNzimKkqNPJN75xsW
         T67lDng6++DvPi+x1jH+WTTqOE2gCgVW7DDFRClGhlzuDKCokOPo8gNAQxwvqY+MsucD
         MbKvcxs2eRFU66OoA6ds18Szr9/35YWBdROAtube2HaMpuOQO48o2eMEAwnCB/DHg5nf
         yCPn1NUutXzJdfKZPqTCCShLTiKaOi5aGXhD3LNd89ELd5WJI+gn3UaXejt48bee22qb
         n89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730139420; x=1730744220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNv5eywtec1rxxiPYEyjudAvtODlzk0F37yJwX0omnI=;
        b=pZ1GDUUA7yhKaCrMjwF646WJNgIDWPl1U6btyPY/6LrIj9MwcHgOr7Tkeky5NWXBKA
         8Dx3qDC/AWVWwhzVfAi7oaQ6E5GvcHtA68yAV9kcut+oVR92pAMW+HkKKpKTCXPs+fIz
         Vtq6fAZo6jyn1g03afmYLjOZO5SNQ3oKuG29xFSlNoPgzAfF76JwzqkNpUiGpqJUKx90
         kmiqLLRrlN0qNH5TsHWoDmQ7yDtr+prPkCpeHQrKfOiPBl28fyCN9VS7VhQzZBzET5R2
         N5vITjmekPmAdIceOHy87h6nMu4BAURa1RgmgV9+YmJ6uHneuCj1QZ8sqq3SLZIcYn22
         /IEg==
X-Forwarded-Encrypted: i=1; AJvYcCWYUFCx/gO2GquwsRb+nxjj74/jpBqAfXgus8fSgdqFJW2P1qxSWE3+ptiTltGV2U3R0UsS7rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOQ/cl8VNZBdp9JzuZr8eOcA4iV49hFDD+sfQtWNXS2bA43Y8s
	v8eYzC3wdcXIfI0Us48u1AXVO3zx8HEI9o7Wc4UkItEGKYnrPalveLZQZnioWr6gVFYiOzv9T51
	QfIBT0wsrUeo2Wg5ua+i720wBvxa2Mz38XGcv
X-Google-Smtp-Source: AGHT+IF9yTafYE67NiwnHGoeNUG1gliLEeEGz094NkSs3y+iHUTXSxLiyTT6mKEydSJudjQJQ9SLpRkyWT5FQ8zV0iE=
X-Received: by 2002:a05:6512:4017:b0:538:9e44:3034 with SMTP id
 2adb3069b0e04-53b480a3b88mr18505e87.6.1730139419620; Mon, 28 Oct 2024
 11:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012114744.2508483-1-maheshb@google.com> <5b614738-31e8-4070-9517-5523b555106e@redhat.com>
 <ZxEZG-sPkXP2br2V@hoboy.vegasvil.org>
In-Reply-To: <ZxEZG-sPkXP2br2V@hoboy.vegasvil.org>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Mon, 28 Oct 2024 11:16:33 -0700
Message-ID: <CAF2d9jhQsp8D=NmPUHn-NbVLBUwrp_FckhXBncgRjjPOGXBwCg@mail.gmail.com>
Subject: Re: [PATCHv2 net-next 0/3] add gettimex64() support for mlx4
To: Richard Cochran <richardcochran@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	David Miller <davem@davemloft.net>, Mahesh Bandewar <mahesh@bandewar.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 7:03=E2=80=AFAM Richard Cochran
<richardcochran@gmail.com> wrote:
>
> On Thu, Oct 17, 2024 at 11:22:12AM +0200, Paolo Abeni wrote:
> > Additionally please fix you git configuration; you should set
> > format.thread=3Dshallow
>
> Yes, this ^^^ makes review much easier for us.
>
I see. Thank you both for the suggestion.

> Thanks,
> Richard

