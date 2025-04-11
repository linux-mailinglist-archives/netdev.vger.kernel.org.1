Return-Path: <netdev+bounces-181692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E09CBA8631D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD17E172D9D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9869021B8F2;
	Fri, 11 Apr 2025 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+sLpqrP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18831213E65;
	Fri, 11 Apr 2025 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744388559; cv=none; b=sd/4GFvJLLuge7mHqfuzn8sHwen8AsWg4cmXbFZ+d5AQ8bGm0J3dU8uMARTOsHebuW31omIiB9KTfS1OpfB5MX1aenwv3MI0nelYeLgxk5XaxA2r+i8jNg9eSLQTTcbxu9eaLxB/8Q3ub0dnUjLFCIr559fqnT75Nv2B5H/55sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744388559; c=relaxed/simple;
	bh=+d5DKKo1v78kV+TNR5Gfv+4eKPOxFTR8Ql/9UIjtyKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS/mkv8VWwLec2wEmfITYo+u3yd4z9jC2moIXJgRRQFVeMH1pQI7GDapv6fLpKW+WXNV9gfCAcdD2fDi9MRU/mZh6ivvHW+3wQKvQhsK4lF7GTJWPDp/2HN+wMOk3z2sGAO86LJ8NZb2zHMKDeXfyBpOmLP6GZ2B+D3LbTsjXSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+sLpqrP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22622ddcc35so29812345ad.2;
        Fri, 11 Apr 2025 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744388557; x=1744993357; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7xeBHVKhYndq78B4q1huCzjJY9AapOKvL/UNB0eTr0I=;
        b=G+sLpqrPpHWHl7cjUvrZdZonLXZoLligxnHVBo9vqMYwniNJW+GAp6gGMfngQGt/r9
         XV7ibT35dU8KoOF7yanHEv90iEkO2BrtYPiLwCmmYNDJGdgvg/FPAQdLEck2fN7bq488
         6vGHJysSQF95g1vEzI8RAzRyKja3JXZrUkOkPNSU7A5AwG/sGO4LO8aVXNGnDxAZDGUo
         bd8FsG+7oQG5dzPN1/lv4OyUozEETj7XYotgR1JWIt8lxSGxCJIXBozeRWBUvdxTJHoh
         M0KzoAWtTdikzfXKlVCs1BCcjbzRHjIml5Ht/1BhPwVB4jQ4jL5IDRNsMhEPxdSwxrgv
         KFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744388557; x=1744993357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7xeBHVKhYndq78B4q1huCzjJY9AapOKvL/UNB0eTr0I=;
        b=HxzzoiYGFTSot8hPgJ3n/zQsx8e8Vs6bx8rc3yx63UPDWjAVGrCzSrXJs5HzxugdHJ
         hdIeTGDM/4nqX1BKM9tE75sIAzLA2/Zwfe/SZsbVIx6CAMRmCogNcls3ug6gsTAEPfQz
         m0UFu/l6YVon5bp7lS/MHKqtvrslqaYpn6G98urmxmAc+q3z/6bF1TXZM2sfaXiyHNcY
         EtfzNzm0Tyb+WrgNZ3JZecYO5zNjBf6HcTaMtSiFCOelDDc5iKXEHIcMfVBZ8dY52w5R
         TsFfIvMO5dw5fmfRcNhk7LO/PIC1E6I6w/Irv6IwdkE/C8/QFFp4DWMGBOl4kyj7VNns
         Qoww==
X-Forwarded-Encrypted: i=1; AJvYcCUKPAarnxo+IxD7h/UPh7SEAt+RC8TuH2pzPTMX5gRC7XTMlLCdSZggxJdBvzkuWqPgRgqkTGFb@vger.kernel.org, AJvYcCVJoZjYdEYFQwdjQHRyW8lq56vprrbMA8IIA8Km899J8Rp2fe8mBLK0lsMmIXLwTXLUSVCa6eKdiJn4dFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxFHzp7BQug6wyjlXSyAtQyipD93312S3KJIhdWVtsF5YZGWMg
	5WxukRwg718yAedz8vNWUGucgA4H2dTpEmhoQoqkMp1vrTW0hvqs
X-Gm-Gg: ASbGncvKh5cfqiBBpO+1q0ZUHQq41tFY0hp3XcGzFAl1z28zy3WP45Nf75ksWGEwfFJ
	fEeqk64TTldqg8dEavgq7LX8Ug368zXVSBY5E+8HGaG0QTZxgtDhuoBEOnuiBn5S3zAXPr4gGpV
	5G6dDc4D+ijT20N+AO0xobF4jTfdRFPGuPWrj7lPh/znbn/UpCgPPT1PFUh2qGocci/wiJ6zTJg
	odMUHK3PHba2PuCJqnSN9bf5AkB5m5e4e49ZRkrjfyNY3AshReZ2UUjoqlxWN2og9a4uNcEOeb1
	VzQ+0q5LxJRbllem7QoZ3OrJE8vF/KWt
X-Google-Smtp-Source: AGHT+IHLwswaT1bdi1ILiCjHIqFoK6E1VSFmRul2uIzZmlnn3OBHjYXh2A9RP8aYGTDuUJcj6/RCmQ==
X-Received: by 2002:a17:903:2bce:b0:224:a79:5fe9 with SMTP id d9443c01a7336-22bea4bd2cbmr48588625ad.30.1744388557316;
        Fri, 11 Apr 2025 09:22:37 -0700 (PDT)
Received: from nsys ([49.47.218.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c78a8sm1752135b3a.70.2025.04.11.09.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 09:22:36 -0700 (PDT)
Date: Fri, 11 Apr 2025 21:52:29 +0530
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Potnuri Bharat Teja <bharat@chelsio.com>, Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>, 
	Vishal Kulkarni <vishal@chelsio.com>
Subject: Re: [PATCH net-next] cxgb4: fix memory leak in
 cxgb4_init_ethtool_filters() error path
Message-ID: <o4o32xf7oejvzyd3cb7sr4whvganh2uds3rvkxzcaqyhllaaum@iovzdahpu3ha>
References: <20250409054323.48557-1-abdun.nihaal@gmail.com>
 <5cb34dde-fb40-4654-806f-50e0c2ee3579@web.de>
 <20250411145734.GH395307@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250411145734.GH395307@horms.kernel.org>

On Fri, Apr 11, 2025 at 03:57:34PM +0100, Simon Horman wrote:
> On Wed, Apr 09, 2025 at 05:47:46PM +0200, Markus Elfring wrote:
> > …
> > > +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> > > @@ -2270,6 +2270,7 @@ int cxgb4_init_ethtool_filters(struct adapter *adap)
> > >  		eth_filter->port[i].bmap = bitmap_zalloc(nentries, GFP_KERNEL);
> > >  		if (!eth_filter->port[i].bmap) {
> > >  			ret = -ENOMEM;
> > > +			kvfree(eth_filter->port[i].loc_array);
> > >  			goto free_eth_finfo;
> > >  		}
> > >  	}
> > 
> > How do you think about to move the shown error code assignment behind the mentioned label
> > (so that another bit of duplicate source code could be avoided)?
> 
> Hi Markus,
> 
> If you mean something like the following. Then I agree that it
> is both in keeping with the existing error handling in this function
> and addresses the problem at hand.
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> index 7f3f5afa864f..df26d3388c00 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> @@ -2270,13 +2270,15 @@ int cxgb4_init_ethtool_filters(struct adapter *adap)
>                 eth_filter->port[i].bmap = bitmap_zalloc(nentries, GFP_KERNEL);
>                 if (!eth_filter->port[i].bmap) {
>                         ret = -ENOMEM;
> -                       goto free_eth_finfo;
> +                       goto free_eth_finfo_loc_array;
>                 }
>         }
> 
>         adap->ethtool_filters = eth_filter;
>         return 0;
> 
> +free_eth_finfo_loc_array:
> +       kvfree(eth_filter->port[i].loc_array);
>  free_eth_finfo:
>         while (i-- > 0) {
>                 bitmap_free(eth_filter->port[i].bmap);
> 

I think what Markus meant, was to move the ret = -ENOMEM from both the
allocations in the loop, to after the free_eth_finfo label because it is
-ENOMEM on both goto jumps.

But personally I would prefer having the ret code right after the call 
that is failing. Also I would avoid creating new goto labels unless
necessary, because it is easier to see the kvfree in context inside the
loop, than to put it in a separate label.

I just tried to make the most minimal code change to fix the memory leak.

Regards,
Nihaal

