Return-Path: <netdev+bounces-93172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983FF8BA67F
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 07:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54093282511
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 05:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AA1139584;
	Fri,  3 May 2024 05:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mE9wK429"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C013957F
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 05:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714713044; cv=none; b=DnlcARdsZAcTKWV7YM6O54BV5y96vv2drpae8F+5fNlfJL4TxbdTi1e5eGPwS3U+yOWmB2r+j47s9gUuaXu86W5HRaXcI4yBn3rldenwGFw0/f3FWS4+0MFGmeZ7Y0uJ5qPNRbVxZq3r/aE6HgnSZiRykHphTckeNDbFAhWAHDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714713044; c=relaxed/simple;
	bh=i6xVZ2OTZFg+doyB55myf+prJAIhcqeLstOYtxEC4xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiuKKiBsYm6ut06yfj6PBxMtsGgmwexgswCLFGsup/6+7eg65lfxjm3z3wYJlgdRVZxHncuXXgv4SZcwf/W08N8gkvwFfsTuvT2jSFfS96USqatglfZbJUKN5nPw3+BzlhUjVKkQC6KYedV8uJzpHBqMYvo+R0I9ftqiSlDwYW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mE9wK429; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34ddc9fe497so1359748f8f.3
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 22:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714713040; x=1715317840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oiqsy4w/6pSqBHe80gOjS5HO5nOoXfBcie0JvHJoK1Q=;
        b=mE9wK429YuJ9KD1CSefE7yiZVAsKGPmy9V4u5rUAN01WJwS6kfMK05+dxhqdsY/uwo
         R8A3EQLDkba/MBpAd3Eg2cYMHwqQuzYnI5cmHx2b2Zs79zpD5w1yblIdkiSk20EAU5uv
         eDp5tarvigm/KwL39KUwAD9m5EiBMc7y+IawUQpdX+PE2xbNkmhj2dyqPL0qIVodCV0r
         DaUjZCB2r1NGHkSKo6+oyz3jBbILplUZAZsw2Vke6KnAciq4BxONX7IZIotcYcVnXKNe
         vPhoyBnlA8QDbbfsf/EabMSQVKq8B9++/wPmAHqEg+AoF32ZZClKBmh4EGXIb6CqXO2x
         lBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714713040; x=1715317840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiqsy4w/6pSqBHe80gOjS5HO5nOoXfBcie0JvHJoK1Q=;
        b=GXEwkbxgG6YvHTZ9XYEmjn81XpcoTollgAxE3VIQlGPrHCi7GphHGqRgWRbMY33Hgz
         eojut75m93UYdA44YtwFPI1e/+m9s4GExj22w5nEpLfuy9RpUPOh+st0AmseOvJvVnTl
         YdZqgzWwNrg8LVGG2G4VBw9yFbQDBNjSX8Jbag4gcPRgcuAL4SJhZoPHr1bR5GC5yaFr
         GmEsl0hRHCD8OJIxWvC2c9MlVr/4sSCiJ8NKhvzs4kQf6/qYxrYLctrNOj0NOoJhpiyi
         p106ej0ZcQaUIIUot1VNz/VfcPxdxRvA3ZitkrUT707Y2oNkOuVVH24BoAhbRXJ2LTzj
         y6jw==
X-Gm-Message-State: AOJu0YzRFEN2eDsauQpAKE0zWOTU2jlahPU3+iXeqdStxG/gJy7uH+6z
	DDBOl1W0TgEMyzyTzwmD3aO1421Fp6ZC440ZDchfU1ZYZ5Y2UikKxed5Roy4sDY=
X-Google-Smtp-Source: AGHT+IEFI6t09BZdnrbU73Nv4BNQA6nBUHiWnYitJDrCNHhRK4suZbi2QUzyoiOqgOh+sXpCQpyszQ==
X-Received: by 2002:adf:cf0c:0:b0:34a:e73a:67a1 with SMTP id o12-20020adfcf0c000000b0034ae73a67a1mr1381329wrj.56.1714713039839;
        Thu, 02 May 2024 22:10:39 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a7-20020adfed07000000b0034d839bed92sm2783119wro.64.2024.05.02.22.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 22:10:39 -0700 (PDT)
Date: Fri, 3 May 2024 08:10:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hams@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, jreuter@yaina.de,
	horms@kernel.org, Markus.Elfring@web.de, lars@oddbit.com
Subject: Re: [PATCH net v2 0/2] ax25: fix reference counting issue of ax25_dev
Message-ID: <af86eeb7-d07a-4b7e-b582-90be162e782a@moroto.mountain>
References: <cover.1714690906.git.duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1714690906.git.duoming@zju.edu.cn>

On Fri, May 03, 2024 at 07:36:14AM +0800, Duoming Zhou wrote:
> The first patch changes kfree in ax25_dev_free to ax25_dev_put,
> because the ax25_dev is managed by reference counting.
> 
> The second patch fixes potential reference counting leak issue
> in ax25_addr_ax25dev.
> 
> You can see the former discussion in the following link:
> https://lore.kernel.org/netdev/20240501060218.32898-1-duoming@zju.edu.cn/
> 

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


