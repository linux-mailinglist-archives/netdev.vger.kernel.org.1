Return-Path: <netdev+bounces-160125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7446A185ED
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 21:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FE0160749
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 20:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FEF1DF989;
	Tue, 21 Jan 2025 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV9Q+KpN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEEA129A78;
	Tue, 21 Jan 2025 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737489883; cv=none; b=Sftc0aHK0q5Z0CbPiTvRjxPeNFAUdWyKcvNIIXcYjcHuJ6Xr0U5T6MlnUVkm90KerPRnSXCwGo5nY4AYTiDH7tRr47qOMA8ORJ1qnMhGeR/reFnSdN2ZAx0/QBGD8oV5MO262FHyey23bXz6SdpChKZM+W6oRLuPYwa90qt9G3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737489883; c=relaxed/simple;
	bh=datY8z3uZ6FINPElO4Av0+duadguLJSdvL8InBcdve4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgQV6gQKPKFUta9ekNbICxFKwGl+Y2qa2hf2PYpzlbtXnMzjDv6POQqmYO3VgmlYGIpBd2bsgR9LXbH5Gq3FPlAen/MjoUupkqvTqVQwWaULaWHwJ/hxyurFpNKMBpxniuD8FxzCmFuJXEs4jOlPq0siyptiD904o6tC/pP1geE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eV9Q+KpN; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef79243680so1311026a91.2;
        Tue, 21 Jan 2025 12:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737489880; x=1738094680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=datY8z3uZ6FINPElO4Av0+duadguLJSdvL8InBcdve4=;
        b=eV9Q+KpNspoYuZn68UXcHtABVnN3/gVtNgHyOWZwpgaa1qcHvEPY7BSbCbcaYvjEb6
         Ctzb5OKzT55fZ2l9JnfuDfJqt179+JfevPzlh8cF7xIMADsYLJ4BCBZ47WHZVigsiBMD
         VyXQkTiJDJ0RU5FLRJq5WHxyBb1fBGepk8QqUlxl3JqVgnF6JY8MMRhCWZ4d/CXMdDEf
         lfkkvWB4dEcwzfrJWr+RV3UcLhL0axa9CA7NMBxdGRzJ50bIdZMxXtG0697P/z4Pi9OY
         PTfxJW3IGUJWeWfgy6E5Rs8gQo8kslqRLhuMZXACqPGdpuVHpyMyXQ01eyO9eWqFD35u
         DEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737489880; x=1738094680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=datY8z3uZ6FINPElO4Av0+duadguLJSdvL8InBcdve4=;
        b=bOMOVhaLNz3jxKYfmepvv/pzMRxG7x7Ld5DHUPuEmV0DVFtdNUjCXT3McZNVvRAE3z
         oLx/slG9f7ipTc6KmoWSw5pBhIyPCvFcc1szTYsXBYasPnHWO5TphNOhxy0Ov5ydPWAK
         WRXrZkYGLHvyXB+TJur5B7gChwCUr3AXub58K2jeIlhamjZwL21Ojqv9r8FKwqjcAOks
         8vSwCnyueQfZoHaxVzGQZUMYq2kLaUkXSXkWV3LQVKpKd+oLrTX5fzgAcnwTpd8B3pW5
         UFNkWCV014n5VeHGvRKKiEsoxLYlKeBS3hjZ3qi9o/HX/ES8dXe2S2HIXzsunj4cklMt
         Rexw==
X-Forwarded-Encrypted: i=1; AJvYcCUe6n6zHRwgdHu/o5X4KtRLkR1aisLJcB1RE2iSaSd6ocwRv+wz2l5bcTLsaB4tRpRcM8biHY1KNtfqxOc=@vger.kernel.org, AJvYcCVJq+v9mNxW5Qn9YaMiye+VANN5cdBC0++TRN7I32ujyJ55g/ek/dUHZCIpXDgXa393XShHz/Sg@vger.kernel.org
X-Gm-Message-State: AOJu0YzkgiGdBTqZAiWuT3lR3+n1KIoImUelNGUcklNCHJ2i6/y0TWrb
	e/lC7GReoAgemzWKBErU3+XYrwqvwrGOerhf+hLlIgdQo9nQJneYNrwzpjcNWmCM/YjNWXALrBs
	GwRoF8NeSoHWax6iLgO7QFEsY2A==
X-Gm-Gg: ASbGncsyUsQhfhLI3Z/j9iAg2J4pn02JXuTuIGocrUnS6oa503D0ilB0rawiEJqzS+/
	rk2bVhrlOOQulsdfY7sS/31ecm76ITOnGuMAPQYJqOnOY+IIyWePcz3uBsxVCJLO49Qbd1+rjtJ
	Zp82iO
X-Google-Smtp-Source: AGHT+IE71M9h633jh87AVDvssGoXfLRlohiMUXLNqh33tWGbeKHkyb3O+34fNCcs+0bG0qWawpaLuhIzk28fo61Bta4=
X-Received: by 2002:a17:90b:4ece:b0:2ee:948b:72d3 with SMTP id
 98e67ed59e1d1-2f782c5502cmr10449356a91.1.1737489880347; Tue, 21 Jan 2025
 12:04:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120222557.833100-1-chenyuan0y@gmail.com> <xttnvcmu3dep2genvce3r7spreliecx3dc3rynups25q6xilk6@tf4wxe6bdxia>
In-Reply-To: <xttnvcmu3dep2genvce3r7spreliecx3dc3rynups25q6xilk6@tf4wxe6bdxia>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Tue, 21 Jan 2025 12:04:28 -0800
X-Gm-Features: AbW1kva5JauRtye6rGFdp5m21Dw3u8bYGN4NLQTg2EOnnJemb8dFlZHyqF7dhus
Message-ID: <CALGdzuqsjddPKgpCdOtDyAAJcJcfd1UUyK7o4YzL8a1E5EsNKw@mail.gmail.com>
Subject: Re: [PATCH] net: davicom: fix UAF in dm9000_drv_remove
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, paul@crapouillou.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, zijie98@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Thanks for pointing this out!

On Mon, Jan 20, 2025 at 11:33=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Mon, Jan 20, 2025 at 04:25:57PM -0600, Chenyuan Yang wrote:
> > dm is netdev private data and it cannot be
> > used after free_netdev() call. Using adpt after free_netdev()
>
> What is adpt?

This should be "dm".

> > can cause UAF bug. Fix it by moving free_netdev() at the end of the
> > function.
>
> "can cause"? Doesn't that trigger reliable?
>
> How did you find that issue? Did this actually trigger for you, or is it
> a static checker that found it? Please mention that in the commit log.

This is detected by our static checker. Thus, we don't have a
test-case to trigger it stably.
Basically, it has the buggy pattern as the commit mentioned below.

> > This is similar to the issue fixed in commit
> > ad297cd2db8953e2202970e9504cab247b6c7cb4 ("net: qcom/emac: fix UAF in e=
mac_remove").
>
> Please shorten the commit id, typically to 12 chars as you did in the
> Fixes line below.

Sure! Should I send a Patch v2 for this commit?

> > Fixes: cf9e60aa69ae ("net: davicom: Fix regulator not turned off on dri=
ver removal")
> > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
>
> Best regards
> Uwe

Best,
Chenyuan

