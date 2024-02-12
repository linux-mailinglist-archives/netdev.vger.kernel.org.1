Return-Path: <netdev+bounces-70867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7D9850DF8
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 08:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D001C20359
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 07:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A006FCA;
	Mon, 12 Feb 2024 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW3A3yqp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0D7462
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722695; cv=none; b=FMDvJM8rZj8vfqAeLmrBwePPS/kAhJHQ7x4NgYdxR2VTLvRC8RbLMiTCey6QW1xO1G6hiUV+YptJZFQVO9JGm9p/abb+YD87DNTHJLUXaPYA4wXUPaqxuevMsjWNuAFW3qnnqiYmoy6exlU3G5O7nik3XSnoMysTYCtk5JzqbbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722695; c=relaxed/simple;
	bh=7aNyuTB21OsLfcmUPrfCOX6NZq6zlmFvfFTNbiOqESo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2bEsol/J/Nx5739o/hkaVyLeR/B1fxz5/4IboqNlsvRyhOq8y89tVObR7YH9e+BSJOFiAJ+5860kKQ+CMVzYOOAeI7qihvc+OQd3pmQJUMkaQljVLzS6GIzdIAfpRBFppoZPZlo2McC3P9jq3+NpUbcWpDTYNaIXs+q4QncZck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BW3A3yqp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d93ddd76adso19991765ad.2
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 23:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707722693; x=1708327493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gfl0wj6/Cn4bCVEaM5s1TdWJKaiuhl55mCd1HFuG/5I=;
        b=BW3A3yqp4gFUIWCGtVBEQ9cOBMpelA0RYCrU4NRYCaMMdDGhP+MQcdfmvbEM63zTD5
         EkKAcnOw067HFQQ27HNTGUnAKPKbFRPr/jTvkaJ2gJMx3a2/WgRMT4qG0jWQMb4SUQ5M
         hpaEsbCMCu6G42isYt/Ho7RKoVXSK9rm20ZEM1d7NahGMI0Bju5jb6DbXFr/LZRu8KXE
         +mMGNSPR/2szPeYQsnA1ljxoSlr6FhAHCy+8cVO9pTyKVwxaUXIFEDwHvoyvt76uvuIZ
         dO1RhooHZe2KDWaaTlUPHXT5vR9cPtLY3IFLygYVCnYFfDZMUfCfDpe/oTfPFLTrMa5t
         noMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707722693; x=1708327493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfl0wj6/Cn4bCVEaM5s1TdWJKaiuhl55mCd1HFuG/5I=;
        b=CXfBsWDqEeEQ2rMQHug7TqfZYdCe+ykbEaS0JtkzGMW2MzrP9nvEbSZl+1qrwm3RyT
         b2BkxM8kBXEbjPueC3ZTVMPOMsFTgbIcPGtQQ0Z6SqXxJfoahTLwKR38lBaRwApdhnxF
         6XTK3jyDRSHDL6lrm0XDHXC604TxXSLPcBrTI3/qhptrYYQRGJ2lEIlAjplRj7uJ9pn+
         FNkzuvZomY3XgL4WmEmumggdfYUe+YKq/ltVzOMtllXX7pTlOd3PxIHznrPrZ9hDXV8i
         Z198kqYTLbD58tdrLLpy9Nyz1Gjm9rFWnhtl0IpuiwJKzlQKFXqJxNueNzH7PQsENyfG
         2sag==
X-Gm-Message-State: AOJu0YyMwv0Cm65Q6B587Y4agf6YI6VZU+Cxth96zUd2i/k6dFbjLS32
	Uy8RHLn1kydaq+DaAsigEyVqvUGIuke5P+YkkJ6hF0KDN0VTvZQ4hwfMxXhynF4oJQ==
X-Google-Smtp-Source: AGHT+IEvUhL9T4g0Zrmwi6O9XqmcSQg5JN1hxAFi3ttaXREIGehRUQBLuUU3YUW/OoXcF2aIAv5UKQ==
X-Received: by 2002:a17:902:e84f:b0:1d9:bf01:165d with SMTP id t15-20020a170902e84f00b001d9bf01165dmr6995108plg.10.1707722693210;
        Sun, 11 Feb 2024 23:24:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEuT52j1LOuevFWodKn919y7ZSGNR/5i/aBmwRxE3LmmOk/6FKnkLsOBJlEn+6es4fUQn7Pq+p1Y0KuPjzYXdt
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y6-20020a170902ed4600b001da1efbd306sm3209948plb.61.2024.02.11.23.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 23:24:52 -0800 (PST)
Date: Mon, 12 Feb 2024 15:24:49 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com
Subject: Re: [PATCH iproute2] tc: u32: check return value from snprintf
Message-ID: <ZcnHwRCr6s3T8VXt@Laptop-X1>
References: <20240211010441.8262-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211010441.8262-1-stephen@networkplumber.org>

On Sat, Feb 10, 2024 at 05:04:23PM -0800, Stephen Hemminger wrote:
> Add assertion to check for case of snprintf failing (bad format?)
> or buffer getting full.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Hi Stephen,

Is there a bug report or something else that we only do the assertion
for tc/f_u32.c?

Thanks
Hangbin

> ---
>  tc/f_u32.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tc/f_u32.c b/tc/f_u32.c
> index 913ec1de435d..8a2413103906 100644
> --- a/tc/f_u32.c
> +++ b/tc/f_u32.c
> @@ -7,6 +7,7 @@
>   *
>   */
>  
> +#include <assert.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> @@ -87,6 +88,7 @@ static char *sprint_u32_handle(__u32 handle, char *buf)
>  	if (htid) {
>  		int l = snprintf(b, bsize, "%x:", htid>>20);
>  
> +		assert(l > 0 && l < bsize);
>  		bsize -= l;
>  		b += l;
>  	}
> @@ -94,12 +96,14 @@ static char *sprint_u32_handle(__u32 handle, char *buf)
>  		if (hash) {
>  			int l = snprintf(b, bsize, "%x", hash);
>  
> +			assert(l > 0 && l < bsize);
>  			bsize -= l;
>  			b += l;
>  		}
>  		if (nodeid) {
>  			int l = snprintf(b, bsize, ":%x", nodeid);
>  
> +			assert(l > 0 && l < bsize);
>  			bsize -= l;
>  			b += l;
>  		}
> -- 
> 2.43.0
> 

