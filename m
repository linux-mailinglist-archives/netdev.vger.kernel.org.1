Return-Path: <netdev+bounces-125845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E05C96EEB6
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15B7284F61
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4A11BAED1;
	Fri,  6 Sep 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/AXWWqd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FC21B81A2;
	Fri,  6 Sep 2024 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613274; cv=none; b=CfUB+Pg6u4IaPeoYmzXW3gTwFAYlCBvefcFlC4Qs89LvepcgJBLQRR6YjOcps4lz3YAOBF9l691yQFHjRAR/t567FZkts0G5NPZ07Svu8zEhiPtNkP6iyG/mty0Xy62IUDlgQSzCu+HcZXDfmS+Q+0GSAFR/ROJnu4+HNu6xX7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613274; c=relaxed/simple;
	bh=HK/tw2uxBqDJPowbMAuoupXHzSzMAsbiM4LjuYB/6d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvsDDG55/YHo/0OvhqZXZd82d5m28xkjm98i6sQrwHQ4iCSBrqMlNMSGZPjsu2/50mXaLWfDzBv8apOQe4AXj9uRrrA6YpXi0Qm9CPDno6ZsnwRgwBRwMsoThLcLzMRcI/YOQC56Pq/pp+jayrQtZIuWw6guzPEKz7uXLy4jgAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/AXWWqd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a81bd549eso191813766b.3;
        Fri, 06 Sep 2024 02:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725613271; x=1726218071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQbEZ6XcH1APJebNQRNGD4r1TkVc0oQyvy2xtA0n2gU=;
        b=W/AXWWqdLjt/RIGgHOElpcQ9yj6u6ttM6XngofxbEqJtE7yhlvvktP1iQ5hxOEORNU
         qGO/sYmssvk5ImkLoorfHDU4r71MrJNt0OGZ3JZzKo7eprl0MtTGTNeThIELcNlv+OD8
         1SVz6732aHZcC7bgHVuGxplBGgWA5Qhf8vMjR2eKZl/Pi9yVVHv316aR7oGobbBbcnlq
         AxGPfN/VGQ60k86XDKf0MvJMF19qfI6ZJUh3CZx7C1KuyiJ9ahjfj14DwGa6UNmjMRoB
         DMgdma61S8kw2yGmyjEY2K/0zzUT1rhv0ai7g9SCPvp44XSxqW8Gc7Q5BFaYTlOvi03s
         StRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725613271; x=1726218071;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQbEZ6XcH1APJebNQRNGD4r1TkVc0oQyvy2xtA0n2gU=;
        b=nRkfipz2N/KixMUcuBlL1/kipetytmjuu5HirKn7l9ReKAtC1g6whG096GYTJTETBj
         EQNyk/f2sBW2GeIySAS4tPvZ4ZML/bN/PvDKQdfMgu+faoAf1rj5gwT29JRosXaknTvK
         M01P3e01x1c9QzGZUpqgCghxiO94LbDML1jfg3ab6K//dgne/CQsvOGSKeWZcJXW9P1i
         BwMghZyABMG4Y4FIiCU8IxirG38vluhmyHBHctFmsvDvy4fm3/uGO8YQd8kh+gwCoJCA
         kya/PtShEQBbHyQAk2WvttxXeRcvSBOF9Q1E4sU1S7ymeT6wBvIKv2Or2ipknCEuzvyZ
         BTuA==
X-Forwarded-Encrypted: i=1; AJvYcCWxzgrmZmiXRSm77OHLhM2yG+xuqH/UNiUNnREBh8RdMKpOQXpG7UU0wNcXnu0LRbnmhAMGlMOl@vger.kernel.org, AJvYcCXbReTE8SmUQSQO7mI+PwEHQt3nkJ1RmR3EyIz+pcJKVzu2lCHHfSTlQMDr0exXOTvueilaX9Ir8Qsa/Ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVntBEMVLWd1GzngqrBiEVxpSuuoWNebKII+ZMWnqGxaERXcKv
	TGaWdHN8WpL8d8lsv6tJdqJpt5rlZvPY48fwEkZr09JhkngkFHSA
X-Google-Smtp-Source: AGHT+IEq45mJqB7495ubNXhkBcbGo/PvxOrh0N9+QX11jDkTJLgClhLAnZZzbTzlWLuhytS5HCEkGA==
X-Received: by 2002:a17:907:934d:b0:a77:f2c5:84a9 with SMTP id a640c23a62f3a-a8a885f66b6mr146385166b.18.1725613270810;
        Fri, 06 Sep 2024 02:01:10 -0700 (PDT)
Received: from localhost ([149.199.80.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a839fb377sm96658166b.128.2024.09.06.02.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:01:10 -0700 (PDT)
Date: Fri, 6 Sep 2024 10:01:09 +0100
From: Martin Habets <habetsm.xilinx@gmail.com>
To: Rohit Chavan <roheetchavan@gmail.com>
Cc: Edward Cree <ecree.xilinx@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sfc: It's a small cleanup to use ERR_CAST() here.
Message-ID: <20240906085955.GA17975@gmail.com>
Mail-Followup-To: Rohit Chavan <roheetchavan@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
References: <20240906055950.729327-1-roheetchavan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906055950.729327-1-roheetchavan@gmail.com>

This was already done as
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=74ce94ac38a6

Thanks,
Martin

On Fri, Sep 06, 2024 at 11:29:50AM +0530, Rohit Chavan wrote:
> Using ERR_CAST() is more reasonable and safer, When it is necessary
> to convert the type of an error pointer and return it.
> 
> Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
> ---
>  drivers/net/ethernet/sfc/tc_counters.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/tc_counters.c b/drivers/net/ethernet/sfc/tc_counters.c
> index c44088424323..76d32641202b 100644
> --- a/drivers/net/ethernet/sfc/tc_counters.c
> +++ b/drivers/net/ethernet/sfc/tc_counters.c
> @@ -249,7 +249,7 @@ struct efx_tc_counter_index *efx_tc_flower_get_counter_index(
>  					       &ctr->linkage,
>  					       efx_tc_counter_id_ht_params);
>  			kfree(ctr);
> -			return (void *)cnt; /* it's an ERR_PTR */
> +			return ERR_CAST(cnt); /* it's an ERR_PTR */
>  		}
>  		ctr->cnt = cnt;
>  		refcount_set(&ctr->ref, 1);
> -- 
> 2.34.1
> 

