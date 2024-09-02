Return-Path: <netdev+bounces-124299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1B1968DE5
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5011F222A9
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C301A2652;
	Mon,  2 Sep 2024 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="dM/7OZi5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7868C149C50
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725303142; cv=none; b=SulJB44tVcAtNkfaUub36W5w3Bkdrsi22tFenIdKB4yHNC4Kr3y1WwfY9uFkDrkiBLzpkycMDXNTZsoxF7uQQnurORd0B1KvV/eH8zfAVB3m1LC4/HLvR2U7On7L828QpP35jzUBBXY2HjWCJjGYWE67WsBZR8x5N9JrKijYI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725303142; c=relaxed/simple;
	bh=WkWUcNb9O/mWuTBarjMXFJ/9aZOBmOFHrhoO/w7H52E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQuTbPoqcIU6gsK57xeagHsFdPc0joT0YJGhTL9ltKD0FOV5kliXSbItEbIYYmaV7SvEWzCUm9OIretFJASkDEpY4x1zPSGfMq8MEiDu0XoqcTp5i/29D8CAKOU9bX1WYgysQbJHcZ4R/0TJY60vRqJahf4Ep5cbazaTk6EVrk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=dM/7OZi5; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-2f3f163e379so73737641fa.3
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 11:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725303138; x=1725907938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0crOABu0R7IrVV27OIoda++f/q2NKplaU9Cdp2ZiLQ=;
        b=dM/7OZi5c2dhrGCIWEjs9/Fryhf+HwUKaa7U+32L5PQ7ZkgQRvZU/YExmoGl30cS9W
         Dp5aLOIfMHKNTJA+SN3RYsMmgpHql+YnYKOVwT4nC6kduAkYhkLseutg3y+hLP81wlgl
         ul637p8ANq/R8UGn0ApYk6n55pdE8yyQ8UfVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725303138; x=1725907938;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0crOABu0R7IrVV27OIoda++f/q2NKplaU9Cdp2ZiLQ=;
        b=GUPLbf1G6DNYv2LNWXHOjb3FZB1O9Yob+9OqlsFT0lo8MPZPpzX12nLos9YvSjD5Pe
         W2T3ve/5tzcMqcRAkqOafBohIaVRHMJxwgVeUG2peXsRllDpy6oryUVtkrjI42EaCVaL
         XdcksqyLxRTdspMG9IMOOYCKKpzxdYezt3BG9W97k/EBmVtuRXeo+TFv7cY25DpReDOc
         n+dxos5fMGwskRtuG083Oxhhdg1pVqlLVCTKuOIPaRTRlSsmDgSpxagHJjHYP5w3QdMK
         nw7/qzhOzBUrNo+PQfXXjBGa99cZagtx8uBMGDVAR7XVzXNAqFvHgKCk3Gk+snb5CDoo
         bCnw==
X-Gm-Message-State: AOJu0YwSuer99gs8HkyitnJvn9eeTng5wxdu4nU78quTx8V4hE+zwIbr
	qteCaK04dwjmIqD4ZF+RiaWAcB8IJT0SVCK9aTLnJHVqQV8VgTEgMy76w6dFpwcCJMJs4YbJN4d
	CNxQRit0l2bXoZyhUzwnE/iI4sVcawai6UtuNswcddxcMM7DMXQzOwsGNvuafy0Mr3ol7blA0Fy
	UjKbOL+Fk5l6JSyqNIw3QqIwzKzuUPhFwMS/sQsJfjppA=
X-Google-Smtp-Source: AGHT+IF2/e+8ropXwn8w9YMdE52Fig93BA5UowbDTdE0PxoacKlavN6KCGsHdXUWCim0+AY59xsHog==
X-Received: by 2002:a05:6512:31cf:b0:52c:e119:7f1 with SMTP id 2adb3069b0e04-53546bfcc07mr9989504e87.51.1725303137478;
        Mon, 02 Sep 2024 11:52:17 -0700 (PDT)
Received: from LQ3V64L9R2.station (net-2-42-195-208.cust.vodafonedsl.it. [2.42.195.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb05csm591769866b.6.2024.09.02.11.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:52:17 -0700 (PDT)
Date: Mon, 2 Sep 2024 20:52:15 +0200
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, Amritha Nambiar <amritha.nambiar@intel.com>,
	stable@kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] netdev-genl: Set extack and fix error on napi-get
Message-ID: <ZtYJX2HTeiglkxUU@LQ3V64L9R2.station>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, Amritha Nambiar <amritha.nambiar@intel.com>,
	stable@kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240831121707.17562-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831121707.17562-1-jdamato@fastly.com>

On Sat, Aug 31, 2024 at 12:17:04PM +0000, Joe Damato wrote:
> In commit 27f91aaf49b3 ("netdev-genl: Add netlink framework functions
> for napi"), when an invalid NAPI ID is specified the return value
> -EINVAL is used and no extack is set.
> 
> Change the return value to -ENOENT and set the extack.
> 
> Before this commit:
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                           --do napi-get --json='{"id": 451}'
> Netlink error: Invalid argument
> nl_len = 36 (20) nl_flags = 0x100 nl_type = 2
> 	error: -22
> 
> After this commit:
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --do napi-get --json='{"id": 451}'
> Netlink error: No such file or directory
> nl_len = 44 (28) nl_flags = 0x300 nl_type = 2
> 	error: -2
> 	extack: {'bad-attr': '.id'}
> 
> Cc: Amritha Nambiar <amritha.nambiar@intel.com>
> Cc: stable@kernel.org
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for napi")
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  net/core/netdev-genl.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 05f9515d2c05..a17d7eaeb001 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -216,10 +216,12 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
>  	rtnl_lock();
>  
>  	napi = napi_by_id(napi_id);
> -	if (napi)
> +	if (napi) {
>  		err = netdev_nl_napi_fill_one(rsp, napi, info);
> -	else
> -		err = -EINVAL;
> +	} else {
> +		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_ID]);
> +		err = -ENOENT;
> +	}
>  
>  	rtnl_unlock();
>  
> -- 
> 2.25.1

Based on Eric's comment regarding my other patch [1], I should
probably re-submit this against net-next instead of net.

It's been over 48 hours, but I'll wait a bit longer before
resubmitting.

[1]: https://lore.kernel.org/all/CANn89iLhrKyFKf9DpJSSM9CZ9sgoRo7jovg2GhjsJABoqzzVsQ@mail.gmail.com/

