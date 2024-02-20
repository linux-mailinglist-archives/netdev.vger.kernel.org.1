Return-Path: <netdev+bounces-73198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3CD85B54D
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 09:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495B01F21076
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 08:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012DB5B1F1;
	Tue, 20 Feb 2024 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bu45147j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC022E3E5
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418041; cv=none; b=YAbOtBra4Mia9iKHlBYKEUGf/5rcxf6Teskk+3CrzPMvtEhGWngeor7TKrxd8sd42iCS3Mf9rwJJBRN9PPVY80MH0szIS9WjaVEGpy9gdAt7I+keNnLjxkImNypWi/s+G7a4E1fVqIyXDcC9teFoZP+NwAhq5Tv5vPMB4EywE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418041; c=relaxed/simple;
	bh=icAPRZSpg4V82iGL4DTu/zx37dPi2E2n7rpbC3WZrwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rx7PuZKJjbGpNGZ1TAO5LvKwqkLZKn82HLIxgSZzXDh/QrmIR/7rHLIQKU8lbkW3vw6LvoCC+BF4q3dhquPJ6F3Ni4lrcCg5t5T0jqlWS7kYF1sJHdbfRpPPh+AJWt8ZLO78g1WEiKez2NhVWCaA4VSD0PkDqjfyd5hvCmV3Ons=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bu45147j; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512be6fda52so1506459e87.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 00:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708418038; x=1709022838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L9E9ChH+6n1G+101FS2J1COXU/iQsd4q5LaJjRxIESg=;
        b=Bu45147jna1nRTbA2QAx7LCDutzr0XVkv6RLanb/49/1IfDG+DrvSqVLDoGTMWkma2
         NEM9Brg1nTtqyWy7Q3c5OKyALdiuWVCHfnaUqzTEh8BEM3cO3/EaCgAgA+2G5E1Qo2dy
         i5nKKP12aj7kEpl7vAxELDzxX58OLlx7V4LxO6ikrhVsJsVizHyvg2yAgfBiYtHDbbiP
         kZ2MDPukdh5sLxwpTfEJ/+qOkc6tkUiuJPwxhoHE599Krw3x/OfgJVoHYO8Uo0Ew2Zo0
         Bf6SDvSkVXJQzmtHyckYaTjm3XpZDBFnZBuhs1ox6NuDzqIZPKuA8K36cvD6CJmIunV2
         oNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708418038; x=1709022838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L9E9ChH+6n1G+101FS2J1COXU/iQsd4q5LaJjRxIESg=;
        b=jLdUypNQtXWiwxKYTd8EbP/Y0Dm8fGXAcrZdqc6IUQziannzwfgjZ5dYQXdnQFiYnq
         KNo4D9XKsyHE0OXUZiig1z/NwEa3kqcJrPSWFafG9EsBVW33Su+0tpzsUE/e1zzCPOte
         bE13AQGf1K2ZBwIABhNWxYoSEtMuDJBOGfMEwWLUBadr8UBCg4S0o3/tz2Dnygz3eZU4
         zT5O36sBOuSBjlodtA1pTcdk+7WA0mAdl721pBt+nRsaUJBzD0ANtiCx2x542bpjcuw1
         3e3reR9i1FkyKUWTQ0lR2YCjM/hQR66WyXgge9qW9+GsoqCQkpWfQC0bLZLIsLzWtRpx
         HGmg==
X-Gm-Message-State: AOJu0Ywl3gx63BHNtnbKEc3UDfwVjEC3xqOl3u0AWHrCd0q/cmCIycM6
	en8r1EQKd/edMjWjCQ+CedA4odL7Y5lMImRZJd1sw/maySlNEgofEfd8k7+0Mywkp589j10MukE
	6h4LSXV0IGvnj17ybrEuIUpO/HY/qKk69YkwBbg==
X-Google-Smtp-Source: AGHT+IG71c5WmlRGxp5VgsnyMOJxfhmh/uVGlt8DannEIxI71OxJbEgyL5P3ic2gxVDY73KyFoMNfjUFWrNc1SNudRQ=
X-Received: by 2002:a05:6512:12c3:b0:511:8d49:4b4f with SMTP id
 p3-20020a05651212c300b005118d494b4fmr11237265lfg.6.1708418038314; Tue, 20 Feb
 2024 00:33:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <25512af3e09befa9dcb2cf3632bdc45b807cf330.1708167716.git.lorenzo@kernel.org>
In-Reply-To: <25512af3e09befa9dcb2cf3632bdc45b807cf330.1708167716.git.lorenzo@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 20 Feb 2024 10:33:22 +0200
Message-ID: <CAC_iWj+sO_42HYY1Twgny1kkXs-Yhfk2fPY6-ktT=Fai1qGHhA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: fix pointer check in skb_pp_cow_data routine
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, kuba@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, hawk@kernel.org, 
	linyunsheng@huawei.com, toke@redhat.com, jwiedmann.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 13:12, Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> Properly check page pointer returned by page_pool_dev_alloc routine in
> skb_pp_cow_data() for non-linear part of the original skb.
>
> Reported-by: Julian Wiedmann <jwiedmann.dev@gmail.com>
> Closes: https://lore.kernel.org/netdev/cover.1707729884.git.lorenzo@kernel.org/T/#m7d189b0015a7281ed9221903902490c03ed19a7a
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  net/core/skbuff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 0d9a489e6ae1..6a810c6554eb 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -950,7 +950,7 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
>                 truesize = size;
>
>                 page = page_pool_dev_alloc(pool, &page_off, &truesize);
> -               if (!data) {
> +               if (!page) {
>                         consume_skb(nskb);
>                         return -ENOMEM;
>                 }
> --
> 2.43.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

