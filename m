Return-Path: <netdev+bounces-189296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77F2AB17E9
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 356567B13B9
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4360E224AF0;
	Fri,  9 May 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx7d8mKa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCE5142E83
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803068; cv=none; b=lnLS3PLTaKEgl1bcQOAsL5qrdDPrFRn07nfAuo+dnskBq1QeErzhqpfQP1rZQioVQgEjI+jERcskslqNmHOLPdk71ruDnN7xeMt+6f0qTdrWbYexjFPNfQOxzueN4kZXS7MyUyCKHyNLeEVuBg8JZJs4J0kcu1/uIAYa31D5FDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803068; c=relaxed/simple;
	bh=so96zrxczNFnPW4zHtLR2+8194AXSxSVMw5oDXFQlm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBeoH1QZEdEz9OUwzBrdQzFten801IyOSzgILf3uKYGrjv9scwN5l4q84QYQGWvR7DH4l0ywm8VsM5zxJwj8T49yYUXlyc/Ie/AaNba5Ja6PgoCDM3cp2iwlj+ReCRnFmW1LQ1isQeK+ju4auvGwLaZugTTrnMAB96kWq3K8HWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mx7d8mKa; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30ab344a1d8so2253455a91.3
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746803066; x=1747407866; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xn7HbBy2BRduAq+CrI+lYptVKrOLVgqBZuSqIldDfyY=;
        b=mx7d8mKaWqGu/dVszBq2DMBcOHYX9f83ZaGTa8C9TVystz18cOG11muIMh1ac2GqGm
         EIkIbIEYwj+DKu5zQY87xQrp00JdspYRpA388ifgOZohXBabsM1v73a8eI0WH9LyBocB
         u/Xm42J32pacqCqCilMy1ZEGSD5vN1mkCY19hJpHP7Z6YXfdRsF1sttd5kEn4Y/GBvXs
         +SpJ0jjbaqnvRYH4GpQhAId1RJCu7ufoqel1M4z4Yul4T0TqipPl05wnHXlOfDAc3BrZ
         8m5AeeBzhUC9nGDnjuJEV6bOWYCIDjvkAw88IYwteRtxuFJYWQuEpqAwDDs/1cGFZg1A
         8jNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746803066; x=1747407866;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xn7HbBy2BRduAq+CrI+lYptVKrOLVgqBZuSqIldDfyY=;
        b=u5FexkbDIM8+IkH81Ui1KZrm8fdii2pSIwvheukfjNAfnyXuiyT3mQ+dHg1ndJc/Rk
         B6iU0TQcMMydYypfb4Wskq5c3eCkUjRC2VmKTf3zi7cO1Ty/Uhiyi5vvWzWqj5fJKVPD
         tfm1ZMEkEprAXvavkMAlumz1R/hwFt7UwXCTKuG9OMXWyzDaMsNbqqXKZvew200zEO0x
         TamjMxNZXlQGpzhU8+sJS/uAnSFTeF8rVBR4GKpqzK/suaoqFpRwjq3WkZu8j+yRcjeI
         LBYFCimF6MjYWCIrax+os44OYq+QeW71Q0ToEgmt2yOl8v9Gt0T7V/2gaBq1MGPCpgfJ
         ubsw==
X-Forwarded-Encrypted: i=1; AJvYcCXkmFsYXnmmgmcL9TgsxX9MI4o+HSlga4mYHNQPrbL9J43ZxN2L3DOimKgFY9eAfcW7QPl0tNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJll0SY4CU3nGs8y+KHDSnp9ztmAxFfB24WmeXhDTMRSqbWtA9
	ABhswKcEoBA4bNay/qshjbB30OjT00YHL6BTDrLzzq+/1F+7DqQ=
X-Gm-Gg: ASbGncvhzUHbcrEcBiYvi9M7VCVmDAJRgrk62TT7suo/UoKzuksKda0J2gpo4HlUoCE
	Q4mhCUtb5oMcaz5K7EdWHT/12zdbyCgM4umDqKa+ZgsXhFHlIInbRzBfG5BrMgXOILiDSgY7KNf
	zgxoG+5mGKuJA0EIUrtQPsrVA44HOaoRYeWqmn131tGvPFBb1RApxtgqdaeESZZuNvQhfC/omU5
	fra86VTwSUMJIMG2q/VpeRysVkRmo4B9+Mmehao1RxwaTRBmlBEWl2wolINJfmmUsiqrc5kNeqf
	EAu+sYp+QSn27l3pLNcvzh0oo1RODjv098Ep1fpt+E+Sc6ICvjRnJm2E2i2dPqYJYLZiZHCahy5
	Ljw==
X-Google-Smtp-Source: AGHT+IFi4qwe7Z+C8dCIedx2GfpVVNq+yYMAzqy9alNHiVXgFxfTokZlaiL8MEeyY7rMnaJvRvFb1w==
X-Received: by 2002:a17:90b:3c85:b0:2f9:c144:9d13 with SMTP id 98e67ed59e1d1-30c3d64652fmr6676538a91.24.1746803065850;
        Fri, 09 May 2025 08:04:25 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30ad4fe23b2sm4138944a91.37.2025.05.09.08.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 08:04:25 -0700 (PDT)
Date: Fri, 9 May 2025 08:04:24 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] net: Lock lower level devices when updating
 features
Message-ID: <aB4ZeKV8m3GKL9qc@mini-arch>
References: <20250508145459.1998067-1-cratiu@nvidia.com>
 <aBzYAzPtf_TlhT0n@mini-arch>
 <b14f2b94b9ecfcb0926c09f8bce01dc2a52a0eca.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b14f2b94b9ecfcb0926c09f8bce01dc2a52a0eca.camel@nvidia.com>

On 05/08, Cosmin Ratiu wrote:
> On Thu, 2025-05-08 at 09:12 -0700, Stanislav Fomichev wrote:
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -10454,7 +10454,9 @@ static void
> > > netdev_sync_lower_features(struct net_device *upper,
> > >  			netdev_dbg(upper, "Disabling feature %pNF
> > > on lower dev %s.\n",
> > >  				   &feature, lower->name);
> > >  			lower->wanted_features &= ~feature;
> > > +			netdev_lock_ops(lower);
> > >  			__netdev_update_features(lower);
> > > +			netdev_unlock_ops(lower);
> > >  
> > >  			if (unlikely(lower->features & feature))
> > >  				netdev_WARN(upper, "failed to
> > > disable %pNF on %s!\n",
> > 
> > Any reason not to cover the whole section under the if()? For
> > example,
> > looking at netdev_features_change, most of its invocations are under
> > the
> > lock, so keeping the lock around it might help with consistency (and
> > we can clarify it as such in
> > Documentation/networking/netdevices.rst).
> > Plus, wanted_features is already sort of ops-protected (looking at
> > netif_disable_lro+dev_disable_lro).
> 
> The critical section could be extended for the whole if, but there are
> a lot of netdev_features_change() calls in many drivers, which I am not
> sure are ops protected. So I'd be reluctant to state that
> NETDEV_FEAT_CHANGE is ops-protected in
> Documentation/networking/netdevices.rst, even though all core
> invocations would be made with the ops lock held.

Ack, I don't think the calls in drivers/ matter, none of these are
ops-protected drivers, but we can do that separately.

