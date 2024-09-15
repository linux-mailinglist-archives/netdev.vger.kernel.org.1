Return-Path: <netdev+bounces-128399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BAA9796C4
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 15:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FB9281816
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 13:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA061C57BC;
	Sun, 15 Sep 2024 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZbJUdtW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D19125DB;
	Sun, 15 Sep 2024 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726406375; cv=none; b=D58cMZZ2ZFRDYXjRGbtiyRleQPzAYBJfeAB1SR6SQx1jjGCi0xP5Eh1cPNGPiaFid6e3HZbSOKo/9U4xJb92qGIDZqn+8yKEiW/qX3q7DulkXxA7KqUWNRIKwLOvRbJg3VmEW4LScfnkHyUpirNBo1yRldJNCyACIfui3blSslw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726406375; c=relaxed/simple;
	bh=MuvvQtM7fwdZJa/bwbF1tHLEof5aFeaDVB9j1PWXKpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbYjbtYYyP0m9kHNNea/UvWsdKeBvuAVIhriPE8J/3acgXsP2sLiJMuwwcHZ242XcgKlaFJb+qeWZ2nnDD3ig1x/SMahs51wwihTOsGeBQv7K1pcEAX1wHlt7+2ZtRl9Z8uZvhIyx1NzGTU8q0Ajvb5P3lay2CZ77x0FYX07/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZbJUdtW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso31374095e9.1;
        Sun, 15 Sep 2024 06:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726406372; x=1727011172; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AF7WkrSmhukxWPyBbPwpLzoSomwCZZkNT/mqHuOjSFE=;
        b=CZbJUdtW4bcbapvR6QnSTFJEVyQkzcXvHJ4sTIT1+PNaL/RELyYfkT1a3jnrGudPep
         ZComqMa11Ut58qKKNuF3VfL/oF+wY5z9tnOVyUr68CC8mOPpPB51Ee7RKxQ/wDEf5xGN
         0iIKXFGdO5nIuD7zl+KmG31Oqyb8+jz+ZGdmnGW/sDTvHMhWYwfewKdFKnR+z9KraEf0
         /RxEcp56eNZmM6vtqyP2fnL1+EQZlQae71Hmt6o0Fe/MyUNX14eSAOPLdfgxanrkPUIj
         L7ZSGQfNWCyzwXJ24aI4fvNsDxaDLsqAEhAQPAzUxldeb3kbBi8wrZ9oAHfA9Lra8fW/
         Usig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726406372; x=1727011172;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AF7WkrSmhukxWPyBbPwpLzoSomwCZZkNT/mqHuOjSFE=;
        b=b+ETRkGXAFKHU9uOeWmBm9mcokIFfNjn/m/qe6QajZUxXJcN/X09bmA88IhRJvok/I
         wFLHyWlgLFEctjW/KX5jnSWjus6oxRMwz54LGpC/Szq+lANmSRFHbVPx6ABJ6FhNkGtt
         GuqnTf804i1RLZuk+AKsLCACg25j23R/gQxCweByy2j4bUwZh1g9Nhar00cqznrwLh+e
         VHJ4IxVgE4q9BXfbfLDKgTtP44gXiR+VdXpavtZjb1PD64ZF1dJKXQdkCYAXy2NKwY3i
         9vh/bJeRBiZXB9zPKBhLEK5LkCLxU7CJzuGeXH/uEOM9EDCFFL9TQBT22JeyRx1qH9t5
         zeng==
X-Forwarded-Encrypted: i=1; AJvYcCUMTbPHSHGRwJtoSEQ+KMRTz7VcrA3jP9FVebMAbwG78kOqo3qYDJeWRj5zL9iba+a9uYgK9O9J@vger.kernel.org, AJvYcCXV/DjjuJkpDaCAwl43FRwRmSy3HDXpeMBxRLY5z6JhZMuDavujoOeBqaZeGWLsgPn6AxpmUx45ujYBxZUag9A=@vger.kernel.org, AJvYcCXfdgMnGdDzxpzc2EHYZzYaBtnCL+GfpT51P1bDKsbHfBje8WSPX9XkmKWN35cOpyrtTC6YuJee43eq+S8F@vger.kernel.org
X-Gm-Message-State: AOJu0YxsEB1wmGtSO2p9vprAtEs4loukjqtrB4HrpwCV5gN5N+gCWWuC
	3FYzajtSVxQYsBxNyAu0+2F96PgoCktHDsWj4P6wy9PrLonOd2L+
X-Google-Smtp-Source: AGHT+IFAwLzBrNKFrRTltiipNkVkw4zNb0BTGC+vauJu+ZGwteb8ucgAyC7W+mV9IYzVDXAPVZ+v2g==
X-Received: by 2002:a05:600c:4590:b0:42c:bb58:a077 with SMTP id 5b1f17b1804b1-42d907221a9mr86397615e9.14.1726406371162;
        Sun, 15 Sep 2024 06:19:31 -0700 (PDT)
Received: from void.void ([141.226.169.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e6f2486esm4758458f8f.0.2024.09.15.06.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 06:19:30 -0700 (PDT)
Date: Sun, 15 Sep 2024 16:19:27 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] ethernet: chelsio: fix a typo
Message-ID: <Zube3wPVKqhtWtWl@void.void>
References: <20240915125204.107241-1-algonell@gmail.com>
 <1a997ce3-1060-45c8-88cc-c75d49745fd4@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a997ce3-1060-45c8-88cc-c75d49745fd4@wanadoo.fr>

On Sun, Sep 15, 2024 at 02:56:59PM +0200, Christophe JAILLET wrote:
> Le 15/09/2024 à 14:52, Andrew Kreimer a écrit :
> > Fix a typo in comments.
> > 
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> > ---
> >   drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h b/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h
> > index 4c883170683b..ad82119db20b 100644
> > --- a/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h
> > +++ b/drivers/net/ethernet/chelsio/cxgb/suni1x10gexp_regs.h
> > @@ -49,7 +49,7 @@
> >   /******************************************************************************/
> >   /** S/UNI-1x10GE-XP REGISTER ADDRESS MAP                                     **/
> >   /******************************************************************************/
> > -/* Refer to the Register Bit Masks bellow for the naming of each register and */
> > +/* Refer to the Register Bit Masks below for the naming of each register and */
> >   /* to the S/UNI-1x10GE-XP Data Sheet for the signification of each bit        */
> >   /******************************************************************************/
> 
> Hi,
> 
> Nitpick: a space should be added between "and" and "*/" to keep a nice
> layout.

Absolutely.

> 
> CJ

