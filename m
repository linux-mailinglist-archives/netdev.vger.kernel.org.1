Return-Path: <netdev+bounces-194555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 377B6ACA932
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 08:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6DB188BDEE
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 06:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD93C18C002;
	Mon,  2 Jun 2025 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pf+qgvAb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2E2A8C1
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 06:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748844219; cv=none; b=daWErb2IrGXFUViexlN804NPiih7DriVgk9VHfAy1WQ7E1GHB+Sg3C8hqkdsR+DKhFvn2tqh2bE2n/GxDU+7c5r5ZhJTOf9qwdlWKNwJPBqO8z0wKkQuMt412fNTejQ8ieHg6XduMLXKuDJFiUV5tGelq1SSRHwsGUDdtQsH6K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748844219; c=relaxed/simple;
	bh=eEW107ipIPy61Sk24Q1qrxcbmZLvd1y/kuKYBUoXKlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWEqIF9a5/RR8FZBJ3z3K9RdVmvma45TnT30lfqZY8SCl9w3zqxMPlkzKOm+Gc9YyMhBXvT/GP9To4AZ2QG1l0UO/Zs/R4mqPebypAm3QtesduPEQqhjDU9zwBj/NdloCjW39Ju9cSl3drIXJqQnCDkmuCwN7la+ETQXkM6UpEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pf+qgvAb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450cfb79177so19768215e9.0
        for <netdev@vger.kernel.org>; Sun, 01 Jun 2025 23:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748844215; x=1749449015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VT+t88x6BILNu5xqyX1dO4pc6n5FbFQHrDThePEkea4=;
        b=pf+qgvAb38MKBtH3sGtsAeClqJaum1sp9tzib8AS7ap08n2Y/h+fbuchIDOUr/kCFO
         twqKlS2f3pj8my5bGAJmwky9Zow5DqHiGK5GT0svE2CS5wAC6RvdEkTA65/NxpXRveF+
         oR+KJHbL1dZcKomfvXG8j+0NuWdPUGU7Gw+QyPaDkL0URl2CYYtUT3lDVTYwc19enALu
         smwc4x2DA4vxbw7N01IIErGPJ++InkWrc8RqH/GSIY8ZybKYptHCYjjp1fq6uyk8CCcT
         elYHskdyGkb5cf57wXfOZ7yciUUb5xZuPkwEDRE2p5Hdb4H8z9CA/clgdyQI+c07NHMy
         C8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748844215; x=1749449015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VT+t88x6BILNu5xqyX1dO4pc6n5FbFQHrDThePEkea4=;
        b=rm4Q7nPE1k8Gi+LEmYQ2tgfejbddYgmKvilaaQxFWVR1Zm0Vv4pgKsugjU8a6Mukib
         z6ix4Lt6R/nx/NNlvilRe7+Ua/59NWlIiBG7CxGxL+4lfb3u76NMpxHFdh0uJKUnTsGv
         8kuDOOthhyqScZRDzBMfq4nCokmiFTQeq4EZXvH4rq277QQUU53/rIi3MpbLS7JmUm4m
         iUDjBoXg8/9bZjzg71RYGp6kN313IWg61k15p/7pJEYm/fRPxTjQ40mJgWIuelskQ9w+
         LLM9XiypYQKK3rutBnNlnMpsYx+vtKGBvycTCZUgwfTVa+ljhUAXJBo2qHPGIMJlNJYw
         3F4A==
X-Forwarded-Encrypted: i=1; AJvYcCVAgURlXNEvqRsA4xOtp25gv1WgAWiGkekkJRPwA142MxcA/Bf1QWTP0pIr+l62FZDyDOAE+PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzicDZSyL7sHAO/KZt9dBxRaOo/+6o3jCiYytV2HsCwG3H8oQJH
	QORb1LZc5hxXTbqWRVjWYWMq5yyJVvNT+AZCJXAlVRcoxuZcyxvRjzomtE6XmlgpoHY=
X-Gm-Gg: ASbGncvJvc8+Ki+3gTalS0IghVqrQjpAFm1/lTxTGAb2oaFlpxA7zLC7Zo5eP+J/Tii
	R9lqjOX2CP98iSAeqy2ejBXbdmPG8g3yHTn7rRxJ1xQPo1BMQ8yyzbymMOLAM/uW5Klw+4gqw8C
	iIwCBURnGKKbrX5HVIyZWdd3XaZjwzL38gdHD/PM18s9Y61nwjvtrDHcCo/j8Okoc051kDwyT8A
	aGPrp8ilZvQe7f5lONA6BKoa8qE0SLPJ4t/pmgfbm0NWKjWZSmjFcR9fn+M4LpcixVVgWuMOW72
	1ekgfNm7rOHdoYUqtApdtcbXRcZ5SCsFKtBKxYeakjFr100sq+b70Kf4Bsr2i6RoTA==
X-Google-Smtp-Source: AGHT+IFiHvYxhztMfN11RapKmiEYv4gtaP/8gucGt4yDxjSNPii/2nMxpa6+aKJVEioWfWekhwNrGQ==
X-Received: by 2002:a05:600c:3b8b:b0:43d:b3:fb1 with SMTP id 5b1f17b1804b1-450d8876dd6mr86632475e9.27.1748844215286;
        Sun, 01 Jun 2025 23:03:35 -0700 (PDT)
Received: from localhost ([41.210.143.146])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-450d8000f3esm109149925e9.23.2025.06.01.23.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 23:03:34 -0700 (PDT)
Date: Mon, 2 Jun 2025 09:03:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mark Bloch <mbloch@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Vlad Dogaru <vdogaru@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5: HWS, Add an error check in
 hws_bwc_rule_complex_hash_node_get()
Message-ID: <aD0-snUAsqT2_3NH@stanley.mountain>
References: <aDbFcPR6U2mXYjhK@stanley.mountain>
 <782913be-5e22-4b4f-9867-26a6019271d9@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <782913be-5e22-4b4f-9867-26a6019271d9@nvidia.com>

On Thu, May 29, 2025 at 01:26:17AM +0300, Yevgeny Kliteynik wrote:
> On 28-May-25 11:12, Dan Carpenter wrote:
> > The rhashtable_lookup_get_insert_fast() function inserts an object into
> > the hashtable.  If the object was already present in the table it
> > returns a pointer to the original object.  If the object wasn't there
> > it returns NULL.  If there was an allocation error or some other kind
> > of failure, it returns an error pointer.
> > 
> > This caller needs to check for error pointers to avoid an error pointer
> > dereference.  Add the check.
> > 
> > Fixes: 17e0accac577 ("net/mlx5: HWS, support complex matchers")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >   .../net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
> > index 5d30c5b094fc..6ae362fe2f36 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
> > @@ -1094,6 +1094,9 @@ hws_bwc_rule_complex_hash_node_get(struct mlx5hws_bwc_rule *bwc_rule,
> >   	old_node = rhashtable_lookup_get_insert_fast(refcount_hash,
> >   						     &node->hash_node,
> >   						     hws_refcount_hash);
> > +	if (IS_ERR(old_node))
> > +		return PTR_ERR(old_node);
> > +
> 
> Agree with the need to check IS_ERR, but error flow is missing here.
> Need to free the previously allocated IDA and node.
> 

:/  Yeah.  Sorry...  I'll resend.

regards,
dan carpenter


