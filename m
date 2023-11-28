Return-Path: <netdev+bounces-51559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2DB7FB1BE
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 07:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC394281DC0
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 06:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF84111A0;
	Tue, 28 Nov 2023 06:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PmawFOqG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6BCD6
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 22:06:11 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b472f98a3so12447835e9.3
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 22:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701151570; x=1701756370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqDZG9xlXv60WjgIbT7jCyTvnkgOn98sFBaOwyS4grQ=;
        b=PmawFOqGjBrJqL8ySoCSsxKShviFeZPzvPKV3mzJhewbAeVzQbFDgttS5xIdXCIXLO
         BW1KI/FBsv9kpdpEkzZTYvzdv6BJ9T8SV7gNicvkD0RRUphJkw1R4sFL3S5OiBYxasq4
         qfRviBKdgkK3ZPQ2R7z+8qmpImmz7HKRNtJKs8FO96OHSlEQYqxLqIWeMKpc+MmLEplY
         EpTVLv1oPYw2BqFCeZTngT8Uvyn0F/DpkfSUUqu9er96XN1XTFMxkjc6nY3RJawolpij
         WMmC+UoGgz1hYwUzwh0VtvuwNjT8FRqAsITzkF05Q1TRfLeFyAEO2TRL9YRXFC8u+QUK
         29SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701151570; x=1701756370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqDZG9xlXv60WjgIbT7jCyTvnkgOn98sFBaOwyS4grQ=;
        b=Kq7MtrEkYIRHxyItFxe7UXbnCcq9VLV+Vrwc1evjhQ7iPpBtNzSIjNeXICecIRGANT
         gZUQqxGmzaXHVTYowMS9qe9oNOTIk+f6rcBmNe7nowtfLf+oU8M6WktFYDNg7ORiTeYE
         TW2IFgbwM6L92oOMQOnFf7qkhrV4O6KVwjCp426L3x0TwoUAQZjxR3EC1B7R70d5it8x
         8Dk8phIwOADYMCsFvXU+aIpoaCAQGddkBmQdDAXql5raa3dtYjHoPpmdwr/b7/n5OB/u
         10yxnwP/mFFXgOcN8p+Cre1YDjjfOJVW/z3Q3iLsHA1ergx2S6I8VEG38YTDzUkCVdLd
         8fQQ==
X-Gm-Message-State: AOJu0YwkMnLnXipgUBiiJww1UzUKyk8asn6EXEZ0PfbTjcuD2s34pA0L
	XbIFrzGq8oxlcjVdqMIsbup/0Q==
X-Google-Smtp-Source: AGHT+IGff4oeXXsg9qhz9anR4cuTUZrTAHFxG1uxfVWjFPmd1JjYRxLfxrLHr9fsz2t2GMUoCEUvHg==
X-Received: by 2002:a05:600c:310c:b0:3fe:1232:93fa with SMTP id g12-20020a05600c310c00b003fe123293famr10525180wmo.22.1701151569895;
        Mon, 27 Nov 2023 22:06:09 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a15-20020a05600c348f00b0040b33222a39sm17141094wmq.45.2023.11.27.22.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 22:06:09 -0800 (PST)
Date: Tue, 28 Nov 2023 09:06:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] net/mlx5e: Fix snprintf return check
Message-ID: <cb12b2dd-5544-45f2-bea4-969c0134719d@suswa.mountain>
References: <d17868ea-cef9-4f8c-a318-9f98b8341f5b@moroto.mountain>
 <877cm3826e.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cm3826e.fsf@nvidia.com>

On Mon, Nov 27, 2023 at 10:46:17AM -0800, Rahul Rameshbabu wrote:
> On Mon, 27 Nov, 2023 16:00:53 +0300 Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > This code prints a string and then if there wasn't enough space for the
> > whole string, then it prints a slightly shorter string.  However, the
> > test for overflow should have been >= instead of == because snprintf()
> > returns the number of bytes which *would* have been printed if there
> > were enough space.
> >
> > Fixes: 41e63c2baa11 ("net/mlx5e: Check return value of snprintf writing to fw_version buffer")
> > Fixes: 1b2bd0c0264f ("net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> 
> I have already sent out patches targeting net for this on the mailing
> list. That said, thanks for the follow-up.

Ah.  Good.  I hadn't seen the earlier discussion about this.  When you
said "follow-up" I worried that I had reported this earlier and
forgotten about it.

regards,
dan carpenter


