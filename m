Return-Path: <netdev+bounces-216784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D756B35229
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 05:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A077B1CB8
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 03:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06222D1936;
	Tue, 26 Aug 2025 03:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FowuDkiE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A5C2BE04F
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756178238; cv=none; b=EoIsZAJ5MMGjeFTNpAh0xtZEMTUIONyXBOvyrBMyUZBPW3yERlFelydAODFBgA7tGkb6yIcU1Tt3NX3X4hSryVDAoPgOLGIJdq9UwBmTle+xIVPYQGvd06ctok4HG5WrXemg2WDHUanJr9QP5XKTurrEiXYZMWYEk19vBiTuUrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756178238; c=relaxed/simple;
	bh=lQuyaZzCmOSly1JmwYweBeBbaXEnm2B+RIRBOXir5n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7aGQwja7fMqDCKltlWHeKMwCnw2t/SYxF+XYX9jQbRRG7NaJMiWjUIZznj3TXei/dynrgBv6w70jxN9Cf50A/OcP+dPMC21aMg52k/4O//WWe1g175LBk3olwpOcz8bTCGcZORrilxh84lu+TSO53Ex6Rsg7RwXnQ36eYhzl5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FowuDkiE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445827be70so50467015ad.3
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756178235; x=1756783035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1h4kvq+D+km1eVNwFE06zF6nsAzszroz7jTJgfoLFY=;
        b=FowuDkiEtJEO4C7+tmcIk2xp62hJXoIgffGp3axz6hQK3Q3ayb+ufJuZb9g/v7dWpQ
         SYIwbLwHx4AoJ48bgCNa2zsTgjMgmXdUNfkMTSTI+pYcWHfnoUGnHgEerFl0EtULfjp6
         WwKEIgAePcXwyCXIFrJbafVVhi4e0quwhJmK1BOX2Fp9Ac5MGRvskOcddYtR4kzbmtJy
         UiM4JZADTzNsfYY0TNTJ0U7SDKkAJkJgZN3NjJd31RgnQvF8kR6wJAU5Q8lBLCB2muFP
         eiFesfortttybDHQJq09VMZQwcxbYqfA2aiUQLMie+qaoH6oRNz+0A5EpVAOuELlZjRo
         yTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756178235; x=1756783035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1h4kvq+D+km1eVNwFE06zF6nsAzszroz7jTJgfoLFY=;
        b=rIzEyQOlR4iW3H14lMTcD+6otS5Co/qsHgQ7sWcmvarFrI17EIbzWqtcjbmzaay8u0
         F4Zoinda0JZmoUoh+eV3WdioNKeXMKA8VII2hK+jJf09/0O8I80Mo9hNZk+UImXnC3oE
         Q3KqQIy3LTweo7TMSTeCLHrvoYrBZ1NbhSsW9nBChv2rBzNw+/5Du2CWm9z42N9F2pkC
         buSaN8WvYVcHD/vvbG20jZGuUA+oIKE9wOcS1QPGK8yh7XfuVrgIaiKYZCoL/KP4URmY
         SvjYGCNFzPvXayNtgNBH9NiDo6Z6ZD1e0BfQWK0xCm7X697KjqPDJnv+Zm/VrP7TbaFg
         H6/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXceEcGfBlKisfLVC8oUs7Zl9szBaA7r+3nbVif2+Zas2oYU0iRf2miY7lP/VsGRn2tPYm5gXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ZO53Mo9qdozfXOGg9vldzt/SM6BaqIuvtfdCYxqD09YeYRFH
	qbZF7lHjws7tjprEqzzg2yMcxWTNRtOBjzRu5PXmiH+Sl3MKgcHOcnrKcXphGSyzkAM3sXtcTt1
	om/NZKgQSkhKpW3wr/KPC0z3E7Mg+X4e20hbYnJW4
X-Gm-Gg: ASbGncszibqQzb11wCyTmNyikBXpQ90GxU/slJ68NXw1l4993jv5Dy9+DVQJLWWytZW
	pwDfP3DBkZFR/IUtBgFGSgTDb8nmKw2dI1lO3TOxI+veNJs2MhhUJ+J/xJ0T8HpCXCVDhwjlDVQ
	A6J9yjg2EFDkpqsH+N7VX3XOiMjONCSb1qncsOIm+BsdAUWnGLfjSCjWxbuZCTLQpsmCR3sTLCW
	6Je1Zm3T0MkZlZcf6QPE26St5bOkeJMdy4e7euJeXeEiFL+DwzeHhY+vUbVLeInicRct9ledF/e
	+OqjG359trjdVA==
X-Google-Smtp-Source: AGHT+IESsrXr4/A9HV9CM4eWH41gEwhxKYe0NGRGYhWCv7FkNw6cH3wSdOT9yrR2tLXLXf1QXj5cDFh41SU75hN8Ze8=
X-Received: by 2002:a17:902:c94c:b0:246:273:c694 with SMTP id
 d9443c01a7336-2462edac306mr225808385ad.12.1756178235138; Mon, 25 Aug 2025
 20:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826025206.303325-1-yuehaibing@huawei.com>
In-Reply-To: <20250826025206.303325-1-yuehaibing@huawei.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 25 Aug 2025 20:17:03 -0700
X-Gm-Features: Ac12FXxSntQxaYwjVLf685rn5gNURA2vkqomZn26jKlmintI2ILPln9QYxxQ68s
Message-ID: <CAAVpQUDA5gCi--n9N7PQZC3rDBxhZxMW8AUFoaGs+09oT6Vebg@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: annotate data-races around devconf->rpl_seg_enabled
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 7:51=E2=80=AFPM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> devconf->rpl_seg_enabled can be changed concurrently from
> /proc/sys/net/ipv6/conf, annotate lockless reads on it.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/ipv6/exthdrs.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index d1ef9644f826..a23eb8734e15 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -494,10 +494,8 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>
>         idev =3D __in6_dev_get(skb->dev);
>
> -       accept_rpl_seg =3D net->ipv6.devconf_all->rpl_seg_enabled;
> -       if (accept_rpl_seg > idev->cnf.rpl_seg_enabled)
> -               accept_rpl_seg =3D idev->cnf.rpl_seg_enabled;
> -
> +       accept_rpl_seg =3D min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_e=
nabled),
> +                            READ_ONCE(idev->cnf.rpl_seg_enabled));
>         if (!accept_rpl_seg) {

Orthogonal to this change, but rpl_seg_enabled is missing .extra1/2
or this condition should be adjusted like other knobs that recognises
 <0 as disabled, .e.g. keep_addr_on_down, etc.


>                 kfree_skb(skb);
>                 return -1;
> --
> 2.34.1
>

