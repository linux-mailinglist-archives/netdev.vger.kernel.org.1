Return-Path: <netdev+bounces-112881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B82693B968
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 01:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2EB41F216A7
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 23:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C9213DBB1;
	Wed, 24 Jul 2024 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qy42YCSZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208613D51C
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 23:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721862822; cv=none; b=jMY3MPaVr/AIBmIatTN667Y8ii1xNP4mflkzLE0euMTeMA5EXc8FBMnewwxL/RqYmk+99yYcZ8IINwc4GGYc/8pCDHrhgzYQi5bjfMvEfuxGi8wPJv+oB3DDgOgx0lYnucXvLC85vfDbn87dqFje0HZU1/bPtsEgR4zYlP62S/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721862822; c=relaxed/simple;
	bh=Z9UCdjQkajAMGg+VKP2WjMYx+FBwnrs/7dfcKKnX+f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfzfQLZoL9X2hbI4FQZx4wiUhIfCeFvoUjjO9UWqxP6F/fthzLWXb4HL3I0kawE+R2qsgLBUcg0wWEU250IDsJARrNDkIVFB4VZX5iMJWRgNUlgAKwX14NPnF4zKU4VlkzpqUgAUx0J/gL+or/mCi3nJ3qVVnpbwcwys/P2Y12s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qy42YCSZ; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-260e6298635so815354fac.1
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 16:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721862820; x=1722467620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JVZralwPwiyvAuVLFB8SHSI/9xmSlrRnq5tuPqIjMK0=;
        b=qy42YCSZdQSZ6eVK0C8X/j3LioXcc9YccB0vJGlmE/lc5y/+ji7UmgXcQGSNB8Vdof
         wnpIGslwnNMw0bdi5yWpf4wmdwKmVmeS1HrQL7tJqbkVUX/HJwY1ZWGoUJOmHFcn2ose
         oNC+Q4Wp51SQmcVwbSq23EML4+xuMvB7x6hUnJL0NVaZ8P4zXIUqvv0YhkJ3/tLNgBLE
         4ap8RfR7W7XSjTUVk5pmdS4rPpLghebo+wRqleriP31vCoG+YAi2+XI7w/zPQ3c9ov0l
         9cfUXkeqCWygtbFf3xCaDey5crHZAuSTO8XuVXX07k0d0Lojg3seFLaB7lycoYpPnCrO
         pFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721862820; x=1722467620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVZralwPwiyvAuVLFB8SHSI/9xmSlrRnq5tuPqIjMK0=;
        b=i96D20vRfWhoOH+NfriT0qqH439vabTxW/8W/DM9iz26FD2CHKut4U97koNjc7tbFE
         rikKF2iiFV4f2eHbLSqKTcdaxi+y1GVnEBClBoNKMrIcTvM9g1jifD+g2Aje6Sy6dIVa
         iJXYH5kW4EKPK6h1urx5lnFexqYFq1gHRs2oTMbJo8s+MeCAb6598oDM7wQwhqdtXWIK
         v8tKZ5g5MnT5a/qZJFjJLAS69C6kVU8FiG4sQ9zycHHvekzhwvo92ykv2HygkcTPmrIb
         LtGzOfeCShFjLjV6eOmAxusyMIvVjNrzjWWdq85WCjTPFdww2QMP9g/Rnf+b+X+j4IMq
         crWw==
X-Forwarded-Encrypted: i=1; AJvYcCWrqnRgJEPN7QYZGEuRVSMQWNrK/lkLVeEViFthHg4UzXWqbOx3ZEaGsIXfnnJ6QMypx9HXv7xx3XsvOYy+WoJh/TzFOjCX
X-Gm-Message-State: AOJu0YwRw3S/mEoBYczQtNAboZa6/UHBWpc65sHO2koCWKB+R1r6U6oi
	/Iyr1E0/sraALrQ6VSN/GyQfF0OlHcfIgxLZZIXktgRP+iiIKcXOEyNlZci7wnk=
X-Google-Smtp-Source: AGHT+IHc5ncP/7OxvEdUdVvNovIn0BJIcsES2AgG9AcaRyNRoBxTRkF+ars3EyxOOy7F4tNt1SFfhw==
X-Received: by 2002:a05:6870:289b:b0:25e:ba6f:a93f with SMTP id 586e51a60fabf-2648e8d17a1mr1881105fac.13.1721862819725;
        Wed, 24 Jul 2024 16:13:39 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6751:f2ec:fdb9:323e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70930712849sm87262a34.26.2024.07.24.16.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 16:13:39 -0700 (PDT)
Date: Wed, 24 Jul 2024 18:13:37 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Karsten Keil <kkeil@suse.de>, Karsten Keil <isdn@linux-pingi.de>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-XXX] mISDN: Fix a use after free in hfcmulti_tx()
Message-ID: <bf7461e5-ebf5-4e1d-b58f-c59d7d6bd8a2@suswa.mountain>
References: <8be65f5a-c2dd-4ba0-8a10-bfe5980b8cfb@stanley.mountain>
 <20240724185302.GI97837@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724185302.GI97837@kernel.org>

On Wed, Jul 24, 2024 at 07:53:02PM +0100, Simon Horman wrote:
> On Wed, Jul 24, 2024 at 11:08:18AM -0500, Dan Carpenter wrote:
> > Don't dereference *sp after calling dev_kfree_skb(*sp).
> > 
> > Fixes: af69fb3a8ffa ("Add mISDN HFC multiport driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/isdn/hardware/mISDN/hfcmulti.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> I guess that this is net material.

Yeah.  I verified that it applied to net but forgot to update the
subject.  :/

regards,
dan carpenter

> 
> Reviewed-by: Simon Horman <horms@kernel.org>

