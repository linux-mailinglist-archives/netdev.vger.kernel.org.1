Return-Path: <netdev+bounces-176997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EB4A6D31D
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 03:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0A93ACF45
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 02:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFBA13C3F2;
	Mon, 24 Mar 2025 02:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WExvZ7HO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE115E96
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 02:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742783995; cv=none; b=gTFvAuEosZgKyVszz16fFLAonCW4ep7NYasOjhwPwAGowot0Sek27rQ0RvmqiJyWBhNfG5krHDCUKX/+IEg/7T0by6tv0EL4FR0IcQ88yr29/95Ef7ssM3FNOKa0pOkChdOXpdq6vLFhEyqbCFcoayQgLLIo4SwaRnKTBHNRDh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742783995; c=relaxed/simple;
	bh=fy75JpqMftDy+evC81AOqEt2qZ4fikc2qckd3bueMIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfEfnpHPrmpdFxXc4uNjtwutYtAHoWdx2ezz+no2uDXrKHa9mqzVRvbvMgapnA0ZTuxAaWBRaP15ku2+VYQju5ZzVVo1gW3VDZBLDQ7bUyVZJp1gAnacpY/kNJ0dXcFEkFRRsUirH/ebd+EcCt+euKY4OtV35IW30g2gD+ZNU+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WExvZ7HO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2260c91576aso63655105ad.3
        for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 19:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742783993; x=1743388793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3YSuSRh5wYbbvql8ON+ETrhvLOcGuoDUIZcRVeNxLM4=;
        b=WExvZ7HOeeHSTQ2GYJiHhbvzaYOT3YE/IlNz6xlJnuz58Ze90uSN9V6uzliZ/+Pxr0
         Wg48oFxRCIxqXvQlxy8MXJHBCjyt2zsuP0i/6vMDXNWlYudDHj0Ku8To0WNVYnzw3XIA
         G1MEos7D530shiygguOnJpzvuBBZwnNoKh3mLkKTTvUVPGlXZ6Sty4PfmsjW8lbzs/cZ
         x4ixnEMWtxtQ7NXEJTAwvDAwJ/ZWefusXB3dCPEP732xuZRBc+ywPCc66yFQftVVcDLF
         FqjNPxLuWNEsUvt7EbE7YEheeGPMjiNxhCbgvJqO7zwPN9vPLSdnmgfkO+eYKDj/fuDQ
         PxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742783993; x=1743388793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YSuSRh5wYbbvql8ON+ETrhvLOcGuoDUIZcRVeNxLM4=;
        b=tQBGbFP9kcwo7k1+PgFMQnt8/5CDpqF5Uv+ZBIMvVG++sCsI1/PIB9TifR4kuaqP4c
         qMJv4LBJQGw48Lri1q8JsQVtcUujvRR0JYECCEheWqVdIV19DuYW4fq/cIvOw/x2nHNL
         gpa1JcN5ASswlftZtT3jXXYUWQ8D3fePRk7YW5Nt3WZ6SVRuPHzh1SYT9TDc7L4T7xnN
         XGqfwZ5a4ofPoKUU9+7vl444nReRIsKCNtHDzR5VBZ5E4jPaZqisMSEJdOTsh2CIYwcd
         Eru+l+CIvZHsw1iuVGz5iEwlSaMYDYCaxbxw5MUZ+TSr0X3+8Zyc9gDmBKMAH7CR2K8W
         4YSg==
X-Gm-Message-State: AOJu0YxqdgWaDa51Up0wveLgURdzyF/GiK4VP5//FTMYN+eVn3xLn+Px
	suKnf4qb/XvfYWMVUf6BHtcymL5iyJGBbosP/GaSiQqu9VNwCck=
X-Gm-Gg: ASbGncviU0B+uuvfcUrBOwXQo4wVxifGePDVMiGA6nfFRG1jnTmhbsxmAYqTJdPLHqY
	/1tGB8pS/DChXUY47f6qnIiKA2HgZiVVsQykJZlsN8gLSRkKo3n0SD6DbgJh2kTeQnZZKWhPILs
	ochYI5PRZqaBFaw3Nb4ky4dZQB3LDyjtK9vdJoG6BVzCTfhYYa0VMH/d0h6y7FQgOmc1R8oxbk+
	THtB3MQwjjmcDKMgpe5UEdozrGM6aUUTzBm9b7IIvBOtWRNghSQAulKyGiWUjn5fCOClOYsC0BS
	P1/p8maScTJ9vX8JbbfluWY0whCsjSbibiHnsiRsBkhQ
X-Google-Smtp-Source: AGHT+IHWiF9nWynpyqaJdEYQGTTJBqX0DekUPjONEK4gAYoaUANbpJ+MgfOu6TIAgFpi69hF0uLS+g==
X-Received: by 2002:a05:6a20:2d12:b0:1f5:97c3:41b9 with SMTP id adf61e73a8af0-1fe42f08f5fmr17410493637.5.1742783992565;
        Sun, 23 Mar 2025 19:39:52 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af8a27dec60sm6049428a12.4.2025.03.23.19.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 19:39:52 -0700 (PDT)
Date: Sun, 23 Mar 2025 19:39:51 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH net] net: page_pool: replace ASSERT_RTNL() in
 page_pool_init()
Message-ID: <Z-DF95BDIYF2h_k0@mini-arch>
References: <20250324014639.4105332-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250324014639.4105332-1-dw@davidwei.uk>

On 03/23, David Wei wrote:
> Replace a stray ASSERT_RTNL() in page_pool_init() with
> netdev_assert_locked().
> 
> Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  net/core/page_pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index f5e908c9e7ad..2f469b02ea31 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -281,7 +281,7 @@ static int page_pool_init(struct page_pool *pool,
>  		 * configuration doesn't change while we're initializing
>  		 * the page_pool.
>  		 */
> -		ASSERT_RTNL();
> +		netdev_assert_locked(params->netdev);
>  		rxq = __netif_get_rx_queue(pool->slow.netdev,
>  					   pool->slow.queue_idx);
>  		pool->mp_priv = rxq->mp_params.mp_priv;

Not sure we can do this unconditionally. Since we still have plenty of
drivers that might not use netdev instance lock (yet). Probably should
be something like the following?

if (netdev_need_ops_lock(params->netdev))
	netdev_assert_locked(params->netdev);
else
	ASSERT_RTNL();

?

We should probably wait for https://lore.kernel.org/netdev/20250312223507.805719-11-kuba@kernel.org/T/#m2053ac617759a9005806e56a7df97c378b76ec77
to land and use netdev_ops_assert_locked instead?

