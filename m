Return-Path: <netdev+bounces-178127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E311DA74D44
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91111899BB4
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 15:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2F515749F;
	Fri, 28 Mar 2025 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBFg1Ylc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1A835958
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743174111; cv=none; b=dQG1Jh8mnNZrT/L36XfVcFBv6ZlT+8m/djKkfbvHZNs8cjsFBJuSW9DRRIOGza+GNbqRjSK8xHeCiJeMFGDtDUFZOrqdtEEzIsN1DBVbx3YPzEEqe1INd8DILT1hehvDQztWWWIkInIvE74CrMiWZchjinSUrp950EraOSiEXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743174111; c=relaxed/simple;
	bh=6LKiKcVaYJQcF3hBEEl/K+3a87jpgWux956OslFPr+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cA8iPuk84/Ns7fzkPxSiwWxThIl2+JmAhIVyMBYZZam+UjFnOsjANZ2nA606lkZILyOTFO5M90hpvgZTeT417e7VIoFlapKyEQGQThnmXFx7TcrBFuekOBXek9TjIFsTlTwlQLUiMJ5rEj97ym+sbuiWUCVOtqSobDbhzJN2tow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBFg1Ylc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-226185948ffso47936935ad.0
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 08:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743174109; x=1743778909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7M7SlhWvI4CjdGxBcSgKiVZs+aaGrYxk/bqnoM2A7Fk=;
        b=bBFg1YlcXlkw/faoQAxjA7ATFXdNm0fwy987ZkyO/KgbmBDzCR1BhepzFFdENk7Yvy
         6mGn73z0NdoBA0i1f/8BgNW9Bukx1g0fy9Kad1ij1TtJiuvBEBh1esiggX7nhm0/Q/Xk
         +SQgsYRGGmhXKdrgtUH22gKN8I/XB6Tsc4Fdm/s/WrzrC7wBLD42FjPSrkLMNNDRhKHo
         WSIQaDRyvvkiXqdNWU/JXbhhar55MNjUQ8/QXEgf0qnnmoyW0rsMUDn4+XxjMdW/uZuG
         F3O3akRP5G2EibyJdfPH5ZNmW6E/TFbFUMTyR+fci+ua4m8+3eerr+XJhDsof6+7T+vb
         tfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743174109; x=1743778909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M7SlhWvI4CjdGxBcSgKiVZs+aaGrYxk/bqnoM2A7Fk=;
        b=Ul/j5fZ+rDxfDKk5+F4EtQUrHhK4ChXtAnIM9WEEYe71ubXknxuVxawOp81TiD9Dlf
         2J8nOTYsk3bFrmPozGJo+iPpt+6Kpp7hsN9G0kPwgorolF0NHybDzZtYEaXOFCEzkDNN
         /JMjMFs/9msF4VuBbTfSl33pHcr2eWt/kL68HfN2IdO13q+7tcf/run3xl2ic6wYrlh8
         X+20ZL1HtZiXGC/7vWl8PtnnhXtdc1Ptq//SgkX4jLWzBqFuuUMeMowDgXZcSTMPOHdO
         Vgu3QJ/vNvZUoV9jNfy3Qb6vaRJq7e4yFN0okr14QU6ZO7bbsrakYSH5pa16Jq+EWc+U
         dpjg==
X-Forwarded-Encrypted: i=1; AJvYcCWls588CMDaQOa5H4gAXORrmUeYZBwU3/hjpM9YIv6R2O5jcde9WxYtAD/xUvNzSY8mI3Fmk7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxGT/fNsTRnRauB+wPoYpl9Xq2iPw5Scjxp8vih0+4I7pZzTt8
	murOjy2HXCl54JKhLhuPC0NR31XX3HoFhm5AGV4rdVJhvgFZF8E=
X-Gm-Gg: ASbGncsYcLEZZIKEjEj+O7g/G5/oVKsD5BFQ8E3pRtsneVIHlmSVxxQ/Zbf7vdbI2gA
	YzMYzDeHep3MQW1H4ZJYyruzct6EFC9zKt2nnLhaXAPiwsR0LNQYjl9y2dOQ/c1cPHg248LbHcW
	5xvzvDXvmp7Fx24WGkF5IAJHBAOB4cemR/r5MoTdeFNtpdK1gqga38X6h7tIEeLv3AD0XaIHgVM
	7ZTrbKtVVI5ElLjz50o5M5MVzRCFnisdHpu+ciojcAl44EW5iKyu0bK2oXUMjcbBhNdhv2yQbMB
	Gw+PMwjWXr66ObTuj8jZBORZ5hbp0911w11Sf27nOCBa20f9BZtd0ys=
X-Google-Smtp-Source: AGHT+IGDhriNgLCTK2+eyJYX8KY0O4/auIkfxsLW8OSOiPDXE5bpWp92NEeVAqOgHq9hHcVSoF1d/Q==
X-Received: by 2002:a05:6a21:e89:b0:1ee:e655:97ea with SMTP id adf61e73a8af0-1fea2ff70ffmr14082906637.41.1743174108727;
        Fri, 28 Mar 2025 08:01:48 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-739710dd0f8sm1890690b3a.178.2025.03.28.08.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 08:01:47 -0700 (PDT)
Date: Fri, 28 Mar 2025 08:01:47 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v2 03/11] net: use netif_disable_lro in ipv6_add_dev
Message-ID: <Z-a523ukeu0uz27l@mini-arch>
References: <20250327135659.2057487-1-sdf@fomichev.me>
 <20250327135659.2057487-4-sdf@fomichev.me>
 <20250327120225.7efd7c42@kernel.org>
 <Z-W945lsWMmZtisy@mini-arch>
 <20250327143741.3851f943@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250327143741.3851f943@kernel.org>

On 03/27, Jakub Kicinski wrote:
> On Thu, 27 Mar 2025 14:06:43 -0700 Stanislav Fomichev wrote:
> > On 03/27, Jakub Kicinski wrote:
> > > On Thu, 27 Mar 2025 06:56:51 -0700 Stanislav Fomichev wrote:  
> > > > @@ -3151,11 +3153,12 @@ int addrconf_add_ifaddr(struct net *net, void __user *arg)
> > > >  	cfg.plen = ireq.ifr6_prefixlen;
> > > >  
> > > >  	rtnl_net_lock(net);
> > > > -	dev = __dev_get_by_index(net, ireq.ifr6_ifindex);
> > > > +	dev = netdev_get_by_index_lock(net, ireq.ifr6_ifindex);  
> > > 
> > > I think you want ops locking here, no?
> > > netdev_get_by_index_lock() will also lock devs which didn't opt in.  
> > 
> > New netdev_get_by_index_lock_ops? I felt like we already have too many
> > xxxdev_get_by, but agreed that it should be safer, will do!
> 
> I think we're holding rtnl_lock here, so we don't need an 
> "atomic get and lock", we can stick to __dev_get_by_index()
> and then lock it separately?

Sounds good, that should do it, thanks!

