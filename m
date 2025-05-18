Return-Path: <netdev+bounces-191328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F701ABADB3
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 05:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FCE1767D6
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 03:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC228199E89;
	Sun, 18 May 2025 03:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqsM0YCF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72153469D
	for <netdev@vger.kernel.org>; Sun, 18 May 2025 03:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747540224; cv=none; b=Q2nsgnfsfhaGo1AOynAjtJsr5VWxzAkvR6MDAgMvSEwp3gg7oaeywe4ef03AYwsJZba3duXNcTLinxOkea1P0qiDlO3FLhdXxASI3Sr05FgzSzmKlH3VwCm0xB7kYXiiZKgG55ht9AvvscLh+DZhG2YSdtHPjthaX+tMluagud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747540224; c=relaxed/simple;
	bh=80Ff83/Sc3aiKeq6u7rFfdcS9BDmv3QCbNXHIwNdEiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7VKVvOepUQ4wFjZ9QuYeY2KWrnjphR5dJ+EhUITMJ7mPVTv+o09A+Jmm0UA93ARA5q8lmywUrTJvQIHzwPa3w5UO4IcPK1VEdOj+eIvwaRF0MlnToievKa9EaRlw/HS6pYTN8FJkP8m5MFjhiQieglLv9EEvKDfCrJOeDMx0BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqsM0YCF; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30e8f4dbb72so1932741a91.1
        for <netdev@vger.kernel.org>; Sat, 17 May 2025 20:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747540222; x=1748145022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=exwrmOR3k+VqhT2rdUHEO7FbGbFA4c/6j+6IMkXX7/M=;
        b=RqsM0YCFvghBamKt6p02CHqCG8RlYB2sxvn8JotUzqj7mSG5YHbPW8RIgOOFsRYC3x
         71pwqOHRoxZACGzLPLBoX9hp7whVD1Fl1x1Zi1aEj0ErjeT3DtbtXIpkE/JBOVhHFz2t
         ixgmvI0fsN3sHoFCSBv+Ya+ny27LMnUVny4zMCfFgoPVp8WXTmoBGI6BpvewWbrTvprY
         6BYom21RP4oG1DLZ80x2Y9BtQlA9Q7JlUg318IbSpDe4Laxs0b2Idw7K+FYl5tkwHYNb
         92892MR7PCfvc/NaEkQutkbHeCZROsHunLcMXRR8KknDfu7yddKyUWismFz0kb80XY0h
         8ArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747540222; x=1748145022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exwrmOR3k+VqhT2rdUHEO7FbGbFA4c/6j+6IMkXX7/M=;
        b=JnSqT+D0zHgDy/qt4ioBwSHNaDrlfNOyEXG93ub4rXbS6dhf4MDip6h2dSqpipl9ZS
         dPyWPt4slL9asHg8CSBffKl3I120U665asqedd3o5TkPTOHWXGFHMC2c5RzZyYsGwtaV
         OBZsk2yoRIdr9kpk723ne6Budnh/Gm1mt/gzjqbpYZ9eGIBvbtILyyQ33Q1wOjkE8iCv
         Zwa5LMDf/dmX9OpfO1/f7z1x8/LoxS9SKBgzQD884r6J2F+Gcp9JEDQzHfh5ndLM6HYH
         q6D6GL0ejmLqKcfeG9CGr/OqnZk5HtM2lpfnTdtxGRtsnRaTxnNOVDPkh/XZKPrGX6AI
         zTxw==
X-Forwarded-Encrypted: i=1; AJvYcCVRFJt5W/JC9L+XQBnzjqPClZbPZGknoGJBpzGXBfH6z6fB/aIZz3p40vgi8YWD60t+V/tYBV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiK6nmoZFW4AZEdKnAP9WcuuIITNpAEfRtXkN/c8IRHx9VBOrP
	iT1clO3ueMy9oj4zcX1XDPJyXPrWKOb66TcC60V2Pg7GEp/uUcIaZxc=
X-Gm-Gg: ASbGnctgLjehTS/+lrNgS+nQ5uCU4JQ/+8gxUPyRh4fCJTCyx/0HzhisQzWyutSusML
	PiBIXL+cI4bZ4k9IvoM6mZTCiunVgB4J6peGQb8u9AsIdYB/q03TraJOnWPufs1laNJjWcrc+/B
	m4mUF6xy2ZQPTuhrm4jqyJ1jh3+UKipIk8ROAfVq2wCdhYkvi5ssjPLmP74k1D8P+/Rsqb+5JFN
	ZI3JkCTTu3YTpFfiBDrObVkppLlimpZj4MyhVagUxPyOUOrE0Kyc1hIffhucq9DoDOaP5+NCoQB
	aamcCwX28PNQmPtiQXwMmHEksPHIavYn45Rvw6yJT6U5sWKm3LiwiSs+zoW/OrIc/68VNmbKsSQ
	IBQZ+gsWvrHez
X-Google-Smtp-Source: AGHT+IEhqkn1CVBJGDz7DHVk+OB1FiCKJqEE2i3t6LE1y/IIGZ7UpQPNF9aqqooWpfR8GWhKx6mOWw==
X-Received: by 2002:a17:90b:2b45:b0:2ff:6a5f:9b39 with SMTP id 98e67ed59e1d1-30e8314fe2emr13808887a91.18.1747540222591;
        Sat, 17 May 2025 20:50:22 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30e7b4dda42sm4205472a91.35.2025.05.17.20.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 20:50:22 -0700 (PDT)
Date: Sat, 17 May 2025 20:50:21 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	kuniyu@amazon.com, sdf@fomichev.me
Subject: Re: [PATCH net-next v2] net: let lockdep compare instance locks
Message-ID: <aClY_Vy7RWOYD45A@mini-arch>
References: <20250517200810.466531-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250517200810.466531-1-kuba@kernel.org>

On 05/17, Jakub Kicinski wrote:
> AFAIU always returning -1 from lockdep's compare function
> basically disables checking of dependencies between given
> locks. Try to be a little more precise about what guarantees
> that instance locks won't deadlock.
> 
> Right now we only nest them under protection of rtnl_lock.
> Mostly in unregister_netdevice_many() and dev_close_many().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - drop the speculative small rtnl handling

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

