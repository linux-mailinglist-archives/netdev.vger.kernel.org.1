Return-Path: <netdev+bounces-106419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1408916243
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 11:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF301F25BE8
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA6E1494DB;
	Tue, 25 Jun 2024 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V41gf9nu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C4F1494AF
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307422; cv=none; b=YlWDjdg0gZLPJwNOpf8waOUxySCXrzEmwDgmdpvByvxXkg3vwQ1zr9V2MoLkD+3X1vpSyjBfQ55JLOuJKRLfJfkIDkAkePLjiaYZ3+Za23dRYsBQBaU6vwgV3YXxXyvqrD74LapiNyzPiz8pRpAQEG58Gu3DqNNnTIEQkFwGJxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307422; c=relaxed/simple;
	bh=rOUdR4UXlPv0HMOIols1rL3X/KRjDi1uSyCL6yzW3zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU+u0ChYGbrVQgOA1NTXAOIjpEeeZeQQVGdi+nCUTfhcYK7pHSTAFyHRjQBoOkOVaZnHW9YgG1VwUFHpTAFCDhpWpnxXrYHu11nz+eUYrovK37/w2faFkRGQ3bJME0kabcC8Ux87eWohIrl4FJv9i6UNPnJN+fnkW6a5D/+PAds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V41gf9nu; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d55cfebcc5so57055b6e.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 02:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719307420; x=1719912220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uVGzFd5q8l7ZZf1kAdLFB+K/N7ZL5du4NsuCLhAw664=;
        b=V41gf9nugabNO+AK/QGfHKZ6xhPj+Y0p2xXMAZgj52sM92QHcMwoJg8cfJtzffZYNm
         vhuqeTUKT2Jfuq+KGcx5ie4jdsF8WyYID4t2hIaNSzh3R7YvmXMBW9efwx39z+uWkZPZ
         Rjw/welp8xSz34CKQWnGJygi4mGCbwrezXupNQgRU98UmnFA9cFTOeecKDYD7+ksvlDG
         Xovi5GEHo3keUuLbfnsuHX6D+lUq7MNam1vICile/RODSD/GAtAErV8pMO3+BjvXt9Fw
         JYoUMqQiYAtLGccrkXpOoyzvJlmbxYlQjARvPbygglEW4W/KufzjaJumpuNkP5Mnw3ZD
         xrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719307420; x=1719912220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVGzFd5q8l7ZZf1kAdLFB+K/N7ZL5du4NsuCLhAw664=;
        b=WxzQa5jWTdEPuQs90fjopBCdqyJdkf+VRDCBYAEx/SV/KpH9Ic1mHTBVSqS7GLB4sn
         hqyC7T8UuXRNuAzn7SjpuGV6/ChLC7SIc86BzumxEpoMMpbPhtxW+j7tszsvI2OLtKnt
         bZV2/ce3EwlsL0bqcfpIpaGtlL2goo1XoZLyR0zOlIEPAatCvvFju73DzKRC8zBr0x3m
         QSQkKHgUiT4i4vshVJH9xFw2w3VjAsAS5jA2/kkzjH1RFmnpi1Jz+qXe060nJxQbNV5R
         Kvm7Scr0THbOUEzBODXPsr5pZ/QKDjG5KuJJFQElXt4umZyH8DGmOWf/QhVlfCIlbvTT
         Hepg==
X-Forwarded-Encrypted: i=1; AJvYcCW6LPyaafRLCENRBj6IXzOhutKTP0zV6LCKB2IXTzHQwMKAr86JH5W5rFz8jwx9aseVC4zNvo8CAyK7vcfRHYd/YtSF0/3A
X-Gm-Message-State: AOJu0YyvT6VijMrZi6qJtPnXSyyRLtAyRr/NGDZ6UPDxBIqgZE15hdYW
	hPRbqKJRDXTJdEW+jC27vGyMX1bl3/f2VLjtvZ8rRDsOBRjKu8BUWE9Pj3edog==
X-Google-Smtp-Source: AGHT+IF/TD8QJ6PBiGj+PIp+ZPQnfxQrPZRAsnw7JmWE9Cx2usjPK36heD0+jTYNL7QGRrft9W9G1Q==
X-Received: by 2002:a05:6808:17a2:b0:3d2:3e31:6cd9 with SMTP id 5614622812f47-3d54599437dmr8266510b6e.26.1719307419614;
        Tue, 25 Jun 2024 02:23:39 -0700 (PDT)
Received: from thinkpad ([117.193.213.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065129b9edsm7840159b3a.148.2024.06.25.02.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 02:23:38 -0700 (PDT)
Date: Tue, 25 Jun 2024 14:53:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Loic Poulain <loic.poulain@linaro.org>, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, netdev@vger.kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: Re: Re: [PATCH v2 1/2] bus: mhi: host: Import mux_id item
Message-ID: <20240625092332.GE2642@thinkpad>
References: <20240612094609.GA58302@thinkpad>
 <87aecf24-cdbb-70d2-a3d1-8d1cacf18401@quicinc.com>
 <20240612145147.GB58302@thinkpad>
 <CAMZdPi-6GPWkj-wu4_mRucRBWXR03eYXu4vgbjtcns6mr0Yk9A@mail.gmail.com>
 <c275ee49-ac59-058c-7482-c8a92338e7a2@quicinc.com>
 <5055db15.37d8.19038cc602c.Coremail.slark_xiao@163.com>
 <20240623134430.GD58184@thinkpad>
 <6365d9b8.265a.1904d287cfa.Coremail.slark_xiao@163.com>
 <20240625074449.GB2642@thinkpad>
 <6dfe6dac.89aa.1904e82ae8c.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6dfe6dac.89aa.1904e82ae8c.Coremail.slark_xiao@163.com>

On Tue, Jun 25, 2024 at 04:28:25PM +0800, Slark Xiao wrote:

[...]

> >Hmm, sadly we shouldn't have used the same controller config for all these
> >devices across different product families. I didn't really paid attention to the
> >device name which is supposed to be unique (that's my bad).
> >
> >For instance, because of the controller config reuse, your SDX62 modem would
> >print:
> >
> >"MHI PCI device found: foxconn-sdx65"
> >
> >which clearly is misleading the users...
> >
> >I've submitted a patch that uses unique product name across the product families
> >[1]. Please take a look. After this patch, you can use the modem name to
> >differentiate in client drivers.
> >
> >- Mani
> >
> >[1] https://lore.kernel.org/mhi/20240625074148.7412-1-manivannan.sadhasivam@linaro.org/
> >
> >-- 
> >மணிவண்ணன் சதாசிவம்
> For same chip platform, I don't think it's necessary to separate into different parts.
> Like t99w368 and DW5932e, all things are same except the 'name'. For previous
> mux_id settings, we would like to add it for sdx72/sdx75 platforms, but shall
> no difference on T99W515 and DW5934e. 
> Otherwise, we must to update both mhi and wwan side if we have a new foxconn
> SDX72 device support since the name is different with foxconn-t99w515 or
> foxconn-dw5934e.
> 

Name is an important factor for an end user. Because, even though both products
are same in functionality, they are marketed as different products. So the users
should be provided with the actual product name, not baseline.

Even though it requires an update to the pci_generic driver, it ought to happen
for correctness.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

