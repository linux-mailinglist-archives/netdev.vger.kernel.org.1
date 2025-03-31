Return-Path: <netdev+bounces-178430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B822BA76FF4
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 086C9188B8CD
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2326721B918;
	Mon, 31 Mar 2025 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xbo3fpA0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF2211A0D
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743455593; cv=none; b=iWR8td0CqsdEoEs82ebeYBdXtOsyL1ygfasS3WrCyaf81NKRo/F/F6AJc8HOQK0tXgg1yambt8DLHRddUB02EaCaQlwgTd7BG8QGH3kN2aOYe47KTMxxmYD8YJ/FntzUQAx7+GMfLXgLFTDvNTc7q5VsoZ+zp21T6PrVTJd/QWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743455593; c=relaxed/simple;
	bh=zbDQcReaLgDlS2W+RTgVrLvamypf9afmyIpdHnjG/HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fh1MM5CpcYDR3qCugiSai1JFztY+8R6Nii2fb02xNhSJkEPYCDU40mnoBPhlW+y2F99+TY/99gXNzVmXTlfcLTsrwMTTzeyZIUk3SG1m34AbHgDLoQTph/mog4Ssw4ZrxXM4APooouW0n2OlXlsgPQ+CfR0vsVTvYeJWHiB+Oj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xbo3fpA0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223f4c06e9fso89103135ad.1
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 14:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743455591; x=1744060391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IyjGIUUIv8fBjIKA4kZCyilBd9sXS+iEoTsrwefd6ng=;
        b=Xbo3fpA0QIy27HhonLYeI3YMT5ObMBYdvZ9m2C1Le9rr0YRbZrPs+8b4oEhA85KZ80
         4is/kuEP4q1czPNeEppw0yNW8PsTJ18kfBj06OV6AKVWl8eJm9HT1INbMVpaFh3g7Mcc
         GJdZRVGFd2v5/dxD00b/PC15D5jarqCYLpHD66gzVQjehkPdl1c3R8Ywr4g4nGhb603u
         RVz/AJ+Zb+V9B3oKZMb+M//vckKsdAfG1tXqquIOvED7WscPk3HmXBBZy2D3pLNhsiNo
         W0s/WneH4x5urCpxuuqMt6RfUUPD0sUJpRuc23tAowv2kG0ov4E4FfmxKLKBYrKvAoAT
         Madg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743455591; x=1744060391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyjGIUUIv8fBjIKA4kZCyilBd9sXS+iEoTsrwefd6ng=;
        b=J9tKK7owO/EN6zdV5xFbtid5xk6NAolyBy729mYLnNU2iGTmiDE7GPtXV2HdgbFlqv
         3MFmcG2KpPEgYCZFFoYy6ETtny33Rmo2Cv10ADfo+hiU5x5gd3DtPL2SThcq7a7d0Pbl
         RBb5+2bKNdk0UzN+T/kC/XqBM89i6BV0NEoSsyppYy9Ihkl3xDvaLPNu29xWVbDxTXsz
         E74DRQhuk8cXOGA+DGEWrALU+CjXC+FwL/EwQQI1Y4JuXwZeVYXePuqMzQPW0u0uHAhZ
         fHXhLdMb9ww5eAWOIokONskQB4MxSEYpqsWrvv6rjH5X2SegUg3F2KgaOmJJ+P5URiLM
         Ub+A==
X-Forwarded-Encrypted: i=1; AJvYcCWPxoFREMirezC4DY9uHz6nSP4oi6BNGnpTkuoey7XeJYN9I0m5JHBOpIaJ9hEslNe9U+Njymo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHi0e5EwnLz5e2rZ/6e6g/Z/rM7f29aiZxxR1GyOAf+tFBU0wd
	2H0PHnGIbDx3DMz3wPv0/Lv6Yz+kdyX8y9K8ppNlvFLlz505UvA=
X-Gm-Gg: ASbGncuynF8u8+R0JA3e0fSRlTLDN+wGhhiM1xDFxr5zB+oMBcB0Hxj4C/6fhYdvnQY
	YbPxWnZf6sEYS529+RBredlU3cUIFWFRpICodqa7k6dklAH8eYvcsziTWrajE42FntiCgzyz6a8
	4YlMZgpQoO9qjh0AFUIja4bU3P1TkAEzrHYbn9RLDxHCkJU+7ThKmWr7tdf6E1YT1WvcRd3jYUE
	hJBbjCmgliZi6YoAPgH7/zTxy0qOyxGiP13L8uXC6+GkB2ECYTYp+uFIMK9A7bnxl8lgQOqX67n
	8RJugk2EtyFIsIQuwayp4LxwU1UKYxeNE39j3vtzYF3E
X-Google-Smtp-Source: AGHT+IEiGAfNf5tevO11TtdmZwL0aIRP2uYZC9pJWvRkh4tr4i/sMgsT5uwo/e3NNijdahwJ0dGlQw==
X-Received: by 2002:a17:902:da88:b0:215:58be:334e with SMTP id d9443c01a7336-2292ee792f4mr151387575ad.10.1743455590888;
        Mon, 31 Mar 2025 14:13:10 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291f1ce08csm74207415ad.127.2025.03.31.14.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 14:13:10 -0700 (PDT)
Date: Mon, 31 Mar 2025 14:13:09 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v4 02/11] net: hold instance lock during
 NETDEV_REGISTER/UP
Message-ID: <Z-sFZfPR9QlDwhoI@mini-arch>
References: <20250331150603.1906635-1-sdf@fomichev.me>
 <20250331150603.1906635-3-sdf@fomichev.me>
 <20250331134811.02655264@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250331134811.02655264@kernel.org>

On 03/31, Jakub Kicinski wrote:
> On Mon, 31 Mar 2025 08:05:54 -0700 Stanislav Fomichev wrote:
> > Callers of inetdev_init can come from several places with inconsistent
> > expectation about netdev instance lock. Grab instance lock during
> > REGISTER (plus UP). Also solve the inconsistency with UNREGISTER
> > where it was locked only during move netns path.
> 
> Couple of nits, with that:
> 
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> 
> > diff --git a/net/core/dev_api.c b/net/core/dev_api.c
> > index 8dbc60612100..cb3e5807dce8 100644
> > --- a/net/core/dev_api.c
> > +++ b/net/core/dev_api.c
> > @@ -119,9 +119,7 @@ int dev_change_net_namespace(struct net_device *dev, struct net *net,
> >  {
> >  	int ret;
> >  
> > -	netdev_lock_ops(dev);
> > -	ret = netif_change_net_namespace(dev, net, pat, 0, NULL);
> > -	netdev_unlock_ops(dev);
> > +	ret = __dev_change_net_namespace(dev, net, pat, 0, NULL);
> >  
> >  	return ret;
> >  }
> 
> nit: no need for the temp variable for ret, now
> 
> > @@ -3042,14 +3040,16 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
> >  
> >  		new_ifindex = nla_get_s32_default(tb[IFLA_NEW_IFINDEX], 0);
> >  
> > -		err = netif_change_net_namespace(dev, tgt_net, pat,
> > -						 new_ifindex, extack);
> > +		err = __dev_change_net_namespace(dev, tgt_net, pat, new_ifindex,
> 
> nit: over 80 chars now

It's exactly 80, is it considered over? This has been done by clang
formatter which has 'ColumnLimit: 80'.. Will undo regardless, but lmk
if the rule is >80 or >=80 (the formatter thinks it's the former)

