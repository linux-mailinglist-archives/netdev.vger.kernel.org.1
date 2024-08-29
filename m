Return-Path: <netdev+bounces-123159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 007D8963E37
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AB6EB20D17
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632A618C023;
	Thu, 29 Aug 2024 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvYl67KD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B678D18C021;
	Thu, 29 Aug 2024 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919653; cv=none; b=Wubq5vDtxgJe0UiT8lQPYHtQ6OCkaDt/Kmawetvv2oQcUC1s/31op75WCrD5vAg9/Qt4LbmPYbmOS+VKxsNjBYQLyJEp8951EPTKWDxpmQzheAdEjW9eE9mmQG2b2JiuHLHlkx2T7Rr2Kl9etpzn4LhFOF8LronFdTaMss1eBkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919653; c=relaxed/simple;
	bh=FJgsYlILKYE6AZml0b+hyh4/86XwcodMKNhsDQGUxJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUOZElGyUFHPmlThCMfnLlIK14V4+9IuiFzlalIO+/JYAYBpQh7J80ufWF6RoXXsAIFUKnqUhHe+PEcPaQksntiUE4kk11bCTYY9t/udiIeVL57JaUB5+u79k3ZDQIhtJv/MQhcLwoO1qzuWoolgM57v8tkTADNTZ2OslQ6l44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvYl67KD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42bb72a5e0bso2506295e9.1;
        Thu, 29 Aug 2024 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724919650; x=1725524450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyWujZXUph0LpAdyIQjvJMmkqt6sQ3l3/uAnrfaVN6A=;
        b=LvYl67KDW8kubIiJZOof15lBR9RFHCdVspnAC+pBPk8NvsV63atcwRlwYisDjtRyol
         hhOjLsEG5Z8qJ7y+sOyt2w37QVZfTyBFQOus4cTNROAFLJz5qDzY/tlE+ASJcbTXmb7m
         56QPNd96FPQwaG83Nd9asAj42w50/jCgfCISPY+81Bo2VLjb5dXuY7HMJHkNuaLPPAW3
         /bwlIb4msb+Ap5dm1L0+gP894tUgtFrLkpnrw1bWLIGI/0xV8VAM0OKTcY4SJJNqjKT/
         AhiWA/UER6/oEBcqHdusnJvQVxqS7KgvB1OtIgYrlxw6Y+EOMOyERkh+vS5AzG9DIfpe
         YtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724919650; x=1725524450;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nyWujZXUph0LpAdyIQjvJMmkqt6sQ3l3/uAnrfaVN6A=;
        b=AOGFIHLS7cT0FN4FJj7TYFBV/QHXi2bRTeerty0mVmtGEPeA2YxIUBJPnDO5uU8/kb
         XmwXlSF7qJcAVgxI4b7K2ugLxzbjxLahbpyikpfw3ZcV+x+e7GVJxpUE9UbH8y4IAPUJ
         f6gjqxyCaQXiePayvISxlycS89qf/Gz3s+uyde0tGmEhedo1NfGG/rSTyCwdatJFCECY
         pp7oEs639XlgQO+BxkGAYnGHboKiSd0PRKh/wr/GJCNkzQHYkKHTcAyg8V8nNQVGfg+B
         yXbWw4Lx34yjxhpTLGa70DgNXmCFnA/1b1HI46sWFX48uYjT6wqwXReTMajEgsP1DXrE
         EPig==
X-Forwarded-Encrypted: i=1; AJvYcCVLU5ke2qXTv5rtFCMLtjF64Ef3/ESH6WcfY5xXHR0CazN1GTzPF4brEDXanspvlxzkRARfmwIG@vger.kernel.org, AJvYcCXWEXtuarRfdHqQfQhoaSqrkF3YeATWfflh/gA86OP0O6VbK4LToO1C5cz90wO3ICVlkXuJaWpIQ1gzNfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy21sK14Ge/tpk8k0Pyd0y8aUCnfiEqhmJBaBCrRo0Ix+NngfKq
	mUofnktU2FsIJ56FGJJpkTspi48aAOf7kcEmLYTLbzH+Hgf1DJ/c
X-Google-Smtp-Source: AGHT+IFYa2f9NUTllmq3w8T8mdv55B6znRTNYxVksHlaze70fPmQwiMF+jdriFc0E5XQyL+UPsGOMg==
X-Received: by 2002:a05:600c:5102:b0:425:80d5:b8b2 with SMTP id 5b1f17b1804b1-42bb01bd7f2mr14006675e9.16.1724919649482;
        Thu, 29 Aug 2024 01:20:49 -0700 (PDT)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee73fa0sm784667f8f.43.2024.08.29.01.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:20:48 -0700 (PDT)
Date: Thu, 29 Aug 2024 09:20:48 +0100
From: Martin Habets <habetsm.xilinx@gmail.com>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: ecree.xilinx@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v2] sfc: Convert to use ERR_CAST()
Message-ID: <20240829081951.GA67561@gmail.com>
Mail-Followup-To: Shen Lichuan <shenlichuan@vivo.com>,
	ecree.xilinx@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
References: <20240829021253.3066-1-shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829021253.3066-1-shenlichuan@vivo.com>

On Thu, Aug 29, 2024 at 10:12:53AM +0800, Shen Lichuan wrote:
> As opposed to open-code, using the ERR_CAST macro clearly indicates that
> this is a pointer to an error value and a type conversion was performed.
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
> v1 -> v2: Removed the superfluous comment.
> 
>  drivers/net/ethernet/sfc/tc_counters.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/tc_counters.c b/drivers/net/ethernet/sfc/tc_counters.c
> index c44088424323..a421b0123506 100644
> --- a/drivers/net/ethernet/sfc/tc_counters.c
> +++ b/drivers/net/ethernet/sfc/tc_counters.c
> @@ -249,7 +249,7 @@ struct efx_tc_counter_index *efx_tc_flower_get_counter_index(
>  					       &ctr->linkage,
>  					       efx_tc_counter_id_ht_params);
>  			kfree(ctr);
> -			return (void *)cnt; /* it's an ERR_PTR */
> +			return ERR_CAST(cnt);
>  		}
>  		ctr->cnt = cnt;
>  		refcount_set(&ctr->ref, 1);
> -- 
> 2.17.1
> 

