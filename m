Return-Path: <netdev+bounces-99086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9CB8D3AB8
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 17:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6001F26944
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD00181BAD;
	Wed, 29 May 2024 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NFI5yA3J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B87F181B9B
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716996148; cv=none; b=Q/O1/0Z18ZNSboD9wCuolHT4fpzMzFVj7Q7mu9EbOKLR7JrmEkiBP66z9aCUzrFsupA67zsuM9IQEoedALLD/hiDD4BDqN8jtkeVVixuZXZL8kBO6ZcrjSIyO1g/iAZLNVReyCjAKGKMW5AlbXJUIp7Yu/yxAqz/aqw67Raae5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716996148; c=relaxed/simple;
	bh=w9uIGdxr63VeUkA8E591wi2PpRm+tgEb098idcW+hXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1eIbE3osAk0TggNqVpMH+jl62IPzMUpeNMbH5kAFocplS00HnDKXVm7sKrAK3zz7WyYAk17tz2LldLPNVy6zSaTOnVXxnzs/94OVSSh5T7aqFapbGHewIi8W7tCMaUws8Pr/PMHhqslyU4o+fmhUSjb+gHMItecA8LLHvntB0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NFI5yA3J; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52a54d664e3so1205288e87.0
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716996145; x=1717600945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8yxc9y0W0aov/2jAGNd4z19XmPaqw8JlICBofmxVn/Q=;
        b=NFI5yA3JaLbRxUhIfaNJPhQA3B/TvTROxpnCecPOih78x7CB29/ILjxm9GexkhBycC
         jHB3NZaxc/3gidggWtA8RKgRgVqRylagsrqe4KTi5k62ds8juvqibcRhpTPKfm96izpw
         WmZWoudIu+pmDNnZzpqnQiGlWdGA9gcJ84ukN83mLIGb04MPiHomhn6Oo/DdSYFzoG1s
         bALewzsyqvVCqMdDMYMNbE1y6UbHtgYOJmazKRhFeNySO7lhW5iEsKmdkJTaKN+rzZUL
         iiS4K4YYrkNNi6iaqwasNuvhs0V1edgJ/27m5mPtrfG630y6hflPMeDs5DSrNxMdL8n0
         FCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716996145; x=1717600945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yxc9y0W0aov/2jAGNd4z19XmPaqw8JlICBofmxVn/Q=;
        b=MnOul/PYBYZxwlc0GeirXaZelYA+O6NdB2rFKK4lqqwceUox08l9E/MNwpODllAqqZ
         twFXjm0NVbQohuaTHiKLnwMpUmOkQ0oIA/EBjhF8ZXmuJ30fJV3OvMkOXzXozxavWfwB
         cldLFP0ahBkfK93f7G5b73yzNnwWY0/35WOd5jL/zLbW3aAgqILQrBeOiqM3fCnYGO2c
         zNPK4Hro9KFI2RWGfzJIDPMrJpCrGzRKXRNTwazbYrVkyDu23XO7cJM1kK8AL+rkuahi
         yyo//3erLRgkAOC8Uv4r21FOBWHTkHLJBgOBMykxNxBCoDM+DfAwbbLUMp3rwRuzFMhL
         m6yA==
X-Forwarded-Encrypted: i=1; AJvYcCXaBjRsRC2MoON6bNedLOQf90j2Lh7G+ZyToOwdk/27YDta8U4ZWXzJW7+BBeSz4A4Lz3SMBr+pTb33NlnyEGkInRyj2K17
X-Gm-Message-State: AOJu0Yy5ipzqKN9HWWWoOiusPKiL7sjIkAFOFfdFdfIchjERnhZ4/4d6
	hQ+u8yPLkKC1jxN0epp2DJ89m6/btlOCFfWAh7Z0oL+DqBG2YYCIipSrA8Ix5Og=
X-Google-Smtp-Source: AGHT+IGXzXzHE1gb62qsghAk7EzkjM7j8cU/yXt75lIA7Lyz09Yricld2iUuIGNqBwccRTaCNJCDSQ==
X-Received: by 2002:a05:6512:3d0d:b0:52b:4c20:5cee with SMTP id 2adb3069b0e04-52b4c205e1dmr1234641e87.22.1716996145081;
        Wed, 29 May 2024 08:22:25 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda46e1sm725394766b.196.2024.05.29.08.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 08:22:24 -0700 (PDT)
Date: Wed, 29 May 2024 18:22:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: duoming@zju.edu.cn
Cc: Lars Kellogg-Stedman <lars@oddbit.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-hams@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4] ax25: Fix refcount imbalance on inbound connections
Message-ID: <da31ff73-62ab-43c9-a1dd-c62bddbff205@moroto.mountain>
References: <20240522183133.729159-2-lars@oddbit.com>
 <8e9a1c59f78a7774268bb6defed46df6f3771cbc.camel@redhat.com>
 <rkln7v7e5qfcdee6rgoobrz7yzuv7yelzzo7omgsmnprtsplr5@q25qrue4op7e>
 <962afcda-8f67-400f-b3eb-951bf2e46fb7@moroto.mountain>
 <3cf699c4.20d18.18fc4df304a.Coremail.duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cf699c4.20d18.18fc4df304a.Coremail.duoming@zju.edu.cn>

On Wed, May 29, 2024 at 11:01:52PM +0800, duoming@zju.edu.cn wrote:
> On Wed, 29 May 2024 17:34:20 +0300 Dan Carpenter wrote:
> > 1) The Fixes tag points to the wrong commit, though, right?  The one
> > you have here doesn't make sense and it doesn't match the bisect.
> 
> I also have tested Lars Kellogg-Stedman`s patch, it works well. I think the Fixes 
> tag shoud be 9fd75b66b8f6 ("ax25: Fix refcount leaks caused by ax25_cb_del()").
> 
> > 2) Can we edit the commitmessage a bit to say include what you wrote
> > about "but rather bind/accept" being paired.  We increment in bind
> > and we should increment in accept as well.  It's the same.
> > 
> > 3) The other thing that I notice is that Duoming dropped part of his
> > commit when he resent v6.
> > https://lore.kernel.org/all/5c61fea1b20f3c1596e4fb46282c3dedc54513a3.1715065005.git.duoming@zju.edu.cn/
> > That part of the commit was correct.  Maybe it wasn't necessary but it
> > feels right and it's more readable and it's obviously harmless.  I can
> > resend that.
> 
> I will resend it latter.

Awesome!  Thanks, and thanks for testing as well.

regards,
dan carpenter


