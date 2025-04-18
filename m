Return-Path: <netdev+bounces-184209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B90A93BDD
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 19:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477561891DB8
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 17:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190B7218AD4;
	Fri, 18 Apr 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xv/WI/pE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752134CB5B
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744996802; cv=none; b=LFl39PeyRjcb4F7UFjY0oaXuz0Q5XfXfE+606k1gdmWf1JpuvCGV/XyKM3Cd+EzT32s6pGhLFd5QTvvn7xKbwO9uJb5KNY+co9cw68wA2xWp1THRjfhxpngqbsb1a5ONToX10+thoEG433zh9V4MDNL6fdVoaKR+C10d089Bj0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744996802; c=relaxed/simple;
	bh=PWbi3qOCeNMmoebmI4MGIqqPL/ybv2B/CUSwhdG0Zm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D020qtZzIGDvaEZQBeKKoqgscSE9Mvz+C8w3lniougfprwWSuilAVfOc9EC3JutkOtLsXjbQQ/8wwINUhkRjGgAX/Tn21pe55N4NCUrBN9eqSKh+jFeV11f8JarB/HkOqGkIJNReijBqFlGTqd9hVK3j+NHKe0MNSheg/t7K2eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xv/WI/pE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22c3407a87aso32269495ad.3
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744996799; x=1745601599; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pb7dou6qaOkmtmlvJ9PnLmsY8FpVZuSXL6FcVQKAvPk=;
        b=xv/WI/pERoXS6ngvU6rnByK6TCEX28/xuEW59nM1LfLPK2FTrUNmzEsj9yzTB7dtQ3
         kL1Xh1jG+DALz6zBZqZObxM+u0AyqtupHJ6bCOrfg75rdbMaXNwQIGoCITBdn5A3tQQj
         81PX5eSV1tHHFIF1mR2zHOZj0r3E+h0Lu+CxxLDDHb667m40hgDG5keaz7d7X/B2s+jq
         JN690s36GCxyFgpNtEz6bKKpnoEMAWfaspwPfKIVdjjkpO1DdZzBiVtVLG+Z+XMuNvmw
         IefSdFmE41FmDmsM2zPcBt3JfCSZRhHkpBNaA2BIAscWDN35q5ADjjwuxfYHm+xkg9w1
         BgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744996799; x=1745601599;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pb7dou6qaOkmtmlvJ9PnLmsY8FpVZuSXL6FcVQKAvPk=;
        b=c/g1VgLZKO1MjSJmFjX18iTe+Ds0ghLQg2VAQodkIl0/NYTGsczWWmmkf5iUi6VtQW
         q7+XahmJJKL95ath/JzkIHU1QWFqsBxIkVVEa4Lay9mUT6s98LHyPbuPrSTqXu73hqQS
         T97EHkTYeCjFPZKmrT6CU+l1mw/dzeAsEAnOEW83vzonBiXobOOAk6JhQU+eey6bgOb4
         qVai7UQ1ALYK1hU79DIZaU4UPgpiDPwfbppkplcN8UK3x+RZUeCDYjwUnns4rvrW5IXm
         MKxIiHNy5RX5KetQ8w5Xuy37U/Hc0WW8YnfnuHgxmK4cWFFC69/turceBRSIjJXLdHM7
         I1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVPJIPFirxyDq7n8WWaS0TWSE31J7VorRzC1RDawY9t5l0mlB5dkcON1iRa2ojDmzFYzXtojjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEZhv9EEUGPx3YQ6ManS3BeEJcWZGDAMcawARGdBZgrX4dQG6+
	2ud98BE8+yYiPJ3U2wbfTifRU22snaqgl+gArc+obcTR3nhwgE1aoWzm+Pd4cg==
X-Gm-Gg: ASbGnctRNm+ZlhTxLhlTBqTTIqerTa93MOOMaEM+Y8Nl2fnOgE7hBGn4nLlZ+EST4Tj
	cCVD4nIYLX49xUoz7LUOrrTM28tfgE/+I4MmqVqLbFec189DKPd1Voh0kFyMZ4w0neqRjMvpEKq
	1oyc0LJjZKprZQqp+3L+HEs4+lAy2L1Vts8eHwLyzTkM3U3q5K4sZTskLCRrHS+xcqr4zhKbYsV
	LQl2HrU8oLSLyu64KZeOkBJyR7AP+XC6UVwqW0tG2YZQ9AEM71poyuPTnWxd/dChzf0qD5582AO
	5qqxYCtbQJ32ZjwVoBTKx/cUMhlf7oF5M5k9WvjjudtwvQD0kKI=
X-Google-Smtp-Source: AGHT+IHmJOiZ6+W50BRcTwdNEuKuVYhOCIw3dLynB6Vl00Og+N3C8NoARgXqTontxnJJGyHPoHjh8g==
X-Received: by 2002:a17:902:e2d1:b0:224:13a4:d61e with SMTP id d9443c01a7336-22c536207eamr39253365ad.51.1744996799635;
        Fri, 18 Apr 2025 10:19:59 -0700 (PDT)
Received: from thinkpad ([36.255.17.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf3b87sm19370915ad.85.2025.04.18.10.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 10:19:59 -0700 (PDT)
Date: Fri, 18 Apr 2025 22:49:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] r8169: do not call rtl8169_down() twice on shutdown
Message-ID: <jikqc7fz4nmwd3ol4f2uazcjc3zgtbtzcrudhsccmvfm3pjbfk@mkcj6gnkrljj>
References: <20250415095335.506266-2-cassel@kernel.org>
 <4f8d3018-d7e5-47e5-b99d-550f8a4011ee@gmail.com>
 <Z_-7I26WVApG98Ej@ryzen>
 <276986c2-7dbe-33e5-3c11-ba8b2b2083a2@oss.qualcomm.com>
 <Z__U2O2xetryAK_E@ryzen>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z__U2O2xetryAK_E@ryzen>

On Wed, Apr 16, 2025 at 06:03:36PM +0200, Niklas Cassel wrote:
> Hello Krishna Chaitanya,
> 
> On Wed, Apr 16, 2025 at 09:15:19PM +0530, Krishna Chaitanya Chundru wrote:
> > On 4/16/2025 7:43 PM, Niklas Cassel wrote:
> > > 
> > > So perhaps we should hold off with this patch.
> > > 
> > I disagree on this, it might be causing issue with net driver, but we
> > might face some other issues as explained above if we don't call
> > pci_stop_root_bus().
> 
> When I wrote hold off with this patch, I meant the patch in $subject,
> not your patch.
> 
> 
> When it comes to your patch, I think that the commit log needs to explain
> why it is so special.
> 
> Because AFAICT, all other PCIe controller drivers call pci_stop_root_bus()
> in the .remove() callback, not in the .shutdown() callback.
> 

And this driver is special because, it has no 'remove()' callback as it
implements an irqchip controller. So we have to shutdown the devices cleanly in
the 'shutdown' callback.

Also do note that the driver core will not call the 'remove()' callback unless
the driver as a module is unloaded during poweroff/reboot scenarios. So the
controller drivers need to properly power down the devices in their 'shutdown()'
callback IMO.

> Doing things differently from all other PCIe controller drivers is usually
> a red flag.
> 

Yes, even if it is the right thing to do ;) But I agree that the commit message
needs some improvement.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

