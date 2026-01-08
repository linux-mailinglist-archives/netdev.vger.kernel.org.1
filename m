Return-Path: <netdev+bounces-248041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C636D026CD
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 12:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B0DB319BE9E
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 11:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4214A1598;
	Thu,  8 Jan 2026 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heNYvUk0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA412352C48
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869679; cv=none; b=ZryBNxhW7C2Ow4fp4gLs8EtQ30aXkfkI3klll7dzGuYNV1pzS//OFgZf6vX7O0i8qZE7kcFydDwM+L8TGJK8U98idY2qraEZEPoQzjG6gEf+yfq0edBSgBAK5XapGs8GGTaRVOho5p1xbodSq5sECAx6r/6I9OiCB3JIDW9rRI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869679; c=relaxed/simple;
	bh=X1AeJ7N4i8+SK2RnBDtq0LwFDsMhBf5L0Kh+mUydmsA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlQ6C6OAd3fBfN0BW9yJKVoE3ShYxQw1VKGbqc8yuEGfKqqjPc6W1se0A5UF2wvr2hiSLXEw7xt0F5dVPHlJ3H9vbfmSWCMdbywinZwhnoReFoD1AO8rEGKXOKfeukoDryVMJSvH/LIEkH6E3EPtTFt794gVtvzrKUp438gcQgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heNYvUk0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b79ea617f55so621533766b.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 02:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767869666; x=1768474466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGNSfyZ14mhgFHrLCd55IAkiSyATWPzAV9vrJzYyTU0=;
        b=heNYvUk09L/ox0xfss01QPVyOHJMjZXc2eJD+zXT+p9l9k0JYNH5N44rkiCUu5E0vE
         ElugXVTE3gons++KOttXOOBDLreREBtDshU7/T+HtQitiLwQM5MsAHz/tBi5H2ZfKnZB
         ibJeghXDTtp4OsN/BpQJjLT0XNjQjWSvlxW0rLaAGgeowFqlWL1Ed3BGohil0yCQpjK6
         QIpdAWz3NBjbA2hd+/B9OIefWSIY7RRlFkopVLWj1O86UEmb1NUvWjsfirWZHCftf8Zz
         oFlau0prZWz/MpCwBRdWIqMaYw6L5FJR/aEE1YBEgi9w2LwCjrEbw1ssNc+sstp2DZK0
         7pQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767869666; x=1768474466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BGNSfyZ14mhgFHrLCd55IAkiSyATWPzAV9vrJzYyTU0=;
        b=anRIp0TDI4T26uuSCUqkHMqR8P6VC5+IesasUN7pHCV1clfEUo6hVVBc6/qYuBfQCr
         honlqkIcOhpcy6PVnmLA743RA3OH9yaDnwkii1dSK4Kk2HWJRHDHcozZbgRYhH/lozFW
         CJcAK11F1ZYVHXm8qmHOsn6hUYiwO8o6mRMVanym27fNxvO05U7MwEq1bTBdlh1RH2J8
         NbfAyULjeOIRktize5kTgiASmqkXDw2b8sFDG3ITczPqbPwFHf67bz6uxpmKqFufWrO1
         gvPDYmHc/XHOpM+Hvt82UqHlNLG+mu+oMF/Adew1a45iEdZnKOL6+Jul+SKV+CmWtIdS
         4/3g==
X-Forwarded-Encrypted: i=1; AJvYcCXthENjTry/DP6uEiSB+ELJXRuNw+eZs9iAsTE8Ht30QmTCOY7euFi/RyJsuMBxWDzrME31a9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf2EmyEJyQvsOtKVj31o1VLFvlxJRS/7d7oJUZEuxigBmFSBSr
	/c9QutwkvcBNEliW/yF+bX/RgKcD4bdSpLMm2JcB8QL7qeR/6i1eZ+ICz0so9w==
X-Gm-Gg: AY/fxX4FxExlWaDBvMW03twxLC5zYqmp3vg6ScUfY9u414yx8hljeflBq9dVbcelktz
	GWZQse3TLxhMbZgKdOu21esmUnkcZH8EqJqvKLG2FzQSRDUCqTZz5VrkvYkv1YCAzP/ZW0WtEdq
	Ff7+dvNMVbHgPHGqkjBBbJOo97nmr+PUvGc+nLnYlYedGjKpj/qNVTyj+m1k68wUhPYdDAl/7xO
	p0QkbciT+MButQ0TRfDNPU4/Dcs28gwZoUJxb0r3SiDrnblqFHqxMX9E4C0ZO8dWTtEsK9Ffq/v
	g9E71aMY9lMVAo9NmN99mSPOUHo5ZAvLBZmR2zZ2xAzRJT0vfc9bEiY0JRlqXxkd3XUYsoe3IzH
	n4FoZQxGTQJegItwoh7bbWOZ4r84oswTzX0A+OqZ6mWMObbKv/b8/oWwdBdWrxpHic7uuaYha1j
	R/4azls03PgF6Pd0RsQR13eb5lGoiDTNYUJWjn+cX+V5Jcz6M3yhLm
X-Google-Smtp-Source: AGHT+IGqCP130UpuuANz8HR/GkYDcNsmaKPOj1V5+2tWgODMHf6K6iZQhaCL0rcFVNmgtFuaq57HWA==
X-Received: by 2002:a05:600c:3e8e:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-47d84b1820amr58573495e9.13.1767863116998;
        Thu, 08 Jan 2026 01:05:16 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f390a69sm141644795e9.0.2026.01.08.01.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:05:16 -0800 (PST)
Date: Thu, 8 Jan 2026 09:05:14 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: ethernet: ave: Replace udelay with
 usleep_range
Message-ID: <20260108090514.375a23fb@pumpkin>
In-Reply-To: <20260108064641.2593749-2-hayashi.kunihiko@socionext.com>
References: <20260108064641.2593749-1-hayashi.kunihiko@socionext.com>
	<20260108064641.2593749-2-hayashi.kunihiko@socionext.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Jan 2026 15:46:41 +0900
Kunihiko Hayashi <hayashi.kunihiko@socionext.com> wrote:

> Replace udelay() with usleep_range() as notified by checkpatch.pl.

Nak.
Look at the code...

> 
>     CHECK: usleep_range is preferred over udelay; see function description
>     of usleep_range() and udelay().
>     #906: FILE: drivers/net/ethernet/socionext/sni_ave.c:906:
>     +       udelay(50);
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/net/ethernet/socionext/sni_ave.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
> index 4700998c4837..a3735d81a862 100644
> --- a/drivers/net/ethernet/socionext/sni_ave.c
> +++ b/drivers/net/ethernet/socionext/sni_ave.c
> @@ -903,11 +903,11 @@ static void ave_rxfifo_reset(struct net_device *ndev)
>  
>  	/* assert reset */
>  	writel(AVE_GRR_RXFFR, priv->base + AVE_GRR);
> -	udelay(50);
> +	usleep_range(50, 100);
>  
>  	/* negate reset */
>  	writel(0, priv->base + AVE_GRR);
> -	udelay(20);
> +	usleep_range(20, 40);
>  
>  	/* negate interrupt status */
>  	writel(AVE_GI_RXOVF, priv->base + AVE_GISR);


