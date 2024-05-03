Return-Path: <netdev+bounces-93232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BDE8BAB1A
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 12:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519CB1C22626
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 10:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB88150982;
	Fri,  3 May 2024 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHM5YCtq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C1C153572
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733741; cv=none; b=JdnktQjtqKxPL9XD+DCnM5SiHEMrupcnsvxw7Xd2eqRkOpi8mcPLk7FwiN4JXPGVccT+03nfXFhQussOF4vYHFIwBnw02nRzrLK4FkiC7B4widrIx1ijUd/BtBeWRnX/fa/59x/EDZBaMaTS0JZ817/MRC1kgC8KKOjhkD2XKkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733741; c=relaxed/simple;
	bh=RuxT5zKU181r3InCydO7sh6qpNkrGor6m7MemwqA0Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvxHlA+bZO4vOoLL3+Mm4sAB5tgpc7t1Yb88hQmz6Ef4YjcIPXVwwpBqM8hju2Gt8t9faYwLo90BUJyFlBQ7WsfcOLSRXGl5Nr9G/m8tHnVokR9AJUBkvBZonr/vwq7SbQ9+WshGBL+6Hb1wN/pGdZ70H4cvzgzYoPJ9UAcPdwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHM5YCtq; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f74fa2a82so897542e87.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 03:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714733738; x=1715338538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+2SeuLCJvXSWm8kHZ3S79WPjc83PfW47nFTsmCfjpXc=;
        b=ZHM5YCtqBRUrEv8RQJ6bIekerPDWMH6BD2CvboREV7AvmI84wnNIv/2bfAiUAQYH0m
         OIaRSVgaubir2Dka31hTLzoAtEISkHDvGxivzho66N/yjpHsngs5zSmrkzM9og/BC6Aq
         IOBiJOq6sYrNyV2g4QXPeKlhv0xkGxJR8uyPdWfzaZprnUa10XShjQIjSJm+Dr9LgXdm
         IdgeK/dqwOS0GU0YENsI11BXp9os1mmQuRHI6TQAZPcoaj8AMUffBi/Fslhfdpd6lKax
         IQdGkHp8+5usdG+7XQVbZkixsiLDTWbBGrKQdusnGrl8KzIK3HyxtnPxHQZiwPE5aW+X
         fzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714733738; x=1715338538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2SeuLCJvXSWm8kHZ3S79WPjc83PfW47nFTsmCfjpXc=;
        b=iXhz5nBHS2TqiJhr+Yw07NR+iipHTD7UHyaqt+4+Kcnkisl1wIJ59PMvhI9ABp/+f7
         8eiNMzwEO3g8bcvYMpsOcsU8iA2uIbdRi0Yq44fc3M2lYD6ZmKF4UlLyNX2kDl6uVEwj
         JRkOi5qDol2GCCBAkeywP+spYEzG193aYquexFw29/L1EPol9fC6GKZZbyJSH5Ub9HTc
         D+woVOD6hragbB3hF2yGwHJjlDXDZJbjH8YRDrArlNZVxwpLHvMCEQP7AZbK7nOY7Lzk
         5C6Ewhav74F0Yh2m318+xCOFAFIUO6XGe68l/eldJHq3L2r9wUZNDREFi5fyaFkOstV5
         wkZg==
X-Forwarded-Encrypted: i=1; AJvYcCWOgtW68f71O6AHylJz48aKwXNFc4Gkyfr3UQm+S+wCJoahan+iTI7oxm/XtdQTKv3cXjZeOkZ2AvU7CsvONLCVjZizwJ3z
X-Gm-Message-State: AOJu0YxJYu0QFJVbAQ27G3m7Se3mgWpPVpWyIaxpYO0WC+kpLn5+gWeb
	mmFNw2HmrDqSTLXkp+Sn9TismZE+VjivrDl5R5UEjh5EvZwVqx4ZW6bH+g==
X-Google-Smtp-Source: AGHT+IH2nD6NEOkW+mgQ1DgKOXok1wd6jU7tRMq1oirktLiIJ2eSwtG3CEgt+pjgWlB04NB+4jJPiQ==
X-Received: by 2002:a19:5f18:0:b0:51d:9ae:87e with SMTP id t24-20020a195f18000000b0051d09ae087emr2043832lfb.46.1714733737977;
        Fri, 03 May 2024 03:55:37 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id y19-20020a196413000000b0051c00cb891esm512665lfb.151.2024.05.03.03.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 03:55:37 -0700 (PDT)
Date: Fri, 3 May 2024 13:55:34 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 04/15] net: stmmac: dwmac-loongson: Drop
 useless platform data
Message-ID: <wpr6eabfksol2sqmvifnivndnixberpoexcoskq5vbknvvadq3@4thpqbkkcyh5>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <37949d69a2b35018dd418f5ee138abf217a82550.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37949d69a2b35018dd418f5ee138abf217a82550.1714046812.git.siyanteng@loongson.cn>

On Thu, Apr 25, 2024 at 09:04:35PM +0800, Yanteng Si wrote:
> The multicast_filter_bins is initialized twice, it should
> be 256, let's drop the first useless assignment.

Please drop the second plat_stmmacenet_data::multicast_filter_bins
init statement and just change the first one to initializing the
correct value - 256. Thus you'll have
1. the multicast and unicast filters size inits done in the same place;
2. the in-situ comments preserved (it's not like they're that much
helpful, but seeing the rest of the lines have a comment above it
would be nice to have the comment preserved here too);
3. dropped the statement closely attached to the return statement
(in kernel it's a widespread practice to separate the return
statement with an empty line).

The unit 1. is the main reason of course.

A bit more readable commit log would be:

"The plat_stmmacenet_data::multicast_filter_bins field is twice
initialized in the loongson_default_data() method. Drop the redundant
initialization, but for the readability sake keep the filters init
statements defined in the same place of the method."

-Serge(y)

> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 9e40c28d453a..19906ea67636 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -15,9 +15,6 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
>  	plat->has_gmac = 1;
>  	plat->force_sf_dma_mode = 1;
>  
> -	/* Set default value for multicast hash bins */
> -	plat->multicast_filter_bins = HASH_TABLE_SIZE;
> -
>  	/* Set default value for unicast filter entries */
>  	plat->unicast_filter_entries = 1;
>  
> -- 
> 2.31.4
> 

