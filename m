Return-Path: <netdev+bounces-249519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BE8D1A650
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C69B3010BF9
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9A234D911;
	Tue, 13 Jan 2026 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IUN+F7Os"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7842FF17A
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322967; cv=none; b=SiMTyH/oASQneudLHZtHQHnhFvgD9S3ajVYxqzfLgNc3I8CbvMCZLnDhdz0fMjWKIHuE97dizxE6wFQbr7AARREuv3qSdQHXgrOkbkQI2Fbs1x4KiAhRZ/14ow32BfD0Pcq45ikLz5AxCgNv2jWcI+1+UdFezOHH5VQmGax/HpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322967; c=relaxed/simple;
	bh=FcKwhFtwMjJDEN2YQ222Ot6kSiGOtJGNAi5RAuQWTkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/lA2GkhUPLAPLuUOePYYx9rZHRDyWmvYIhmR7B0iN2RFcbhVjDeaVkfAyGsL1fDR0U4m2DRa5m4pnUSSc8vL+pUMHw6VW2BhHY3MO6fSuuvWxuPIiUnN2MNqEJ7fd5EcE6K6MCwASEI7YYuuXJscGh8dLMla34UJg/72Z4hh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IUN+F7Os; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4f4cd02f915so57548381cf.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 08:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768322964; x=1768927764; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FcKwhFtwMjJDEN2YQ222Ot6kSiGOtJGNAi5RAuQWTkY=;
        b=IUN+F7Os2CbsEpMXD+uy4zfUryF0h24o1jyx/IiYJq7BeVoHZ6z1GLN7ui8LGfBeDP
         DA6tBmkTPIySiWnRFO2xpwJfRu9SLXxaW5kpd8t9UaDDsOIyaFmhxxvdDzVLw7HDPgVZ
         tMZlJgPmwHU2p01l/jcmvEXdj1SWT2nHiRpYbfEBCcreb/F5llf+NsHfCACTdfcMNR8l
         DlZRQw8wRcmCaT2Nvcdpr1DkRQSeSiDyg/bGgMd6WUEpQRAUsjvSw0omNVCqKuNWw+pN
         il0/6wjhstUZFg/vaSnhZQGAGHC5NTUavNRSWwIyuKwrr+1bpAAkJdGo4G27m5McLDER
         h86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768322964; x=1768927764;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcKwhFtwMjJDEN2YQ222Ot6kSiGOtJGNAi5RAuQWTkY=;
        b=d/oxBA2l6PgAu6syMfO+vyuILKa2PpseZM179Sy3RSE706veanUi5rP+JEsFemTTk9
         CgWPrIhPMMNUMwxITVgGHOv2CDryo4Tia8pFvOTsPShQH/xjg3k6gEsUZWaE6x5c6NW3
         NZ4nlaY4FTlWMNF26XKi96ulDmNFvMRQI360Bhh54pSVjcrdf0kSuiCsJxgBpSBHVp96
         4r13roogqPuO+MI5VxpJjogc4+PEXTNgxKigVPrDGaLjxKUrfHGNgqQZB+370LGs/z2J
         sqnId7kA1+v1qFDidJuaaUpAlT0SskrGeS0Xv5UwfO58ONwBCsYSiIIfhDiojRAZb27z
         0qMA==
X-Forwarded-Encrypted: i=1; AJvYcCV6147H5Bv7DCzG86FqfAFiL7xmcI0EfHBZN4rKwMenaathxRXXivjrUyskTuL+UDAJzSsSMkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsulPMBlLkiM80kR5YmRtg1EOlS9S0LIiZfbzN+A1jrxliF//j
	in9l6gSbirgrz1qaZZYicwTiva65GcyDKo9lrucCYfF7kJte1Ly5G0/8I8KK3GJRRg8=
X-Gm-Gg: AY/fxX40P1kfxmxIJ+rlbSlFvPHGt+duuBzY5AvdY1YzBTjwxmg+ZxODeH9wE78L3dF
	5zXYWfaH0hwBeJkv+nNDVD+gPm3Yy/zSVP8pQpnkdH2AI1En7ToYG4FBQfNBlLhGzj+0W3kQ09g
	4Qu+hdR+cNUesJl9D6BDF4J13bv9FTtncmkVtqnwP4it1psl+8Wp0mfqlIYsIWPpHrbnSNP7OAM
	0m6DvmH26PUN7362OpOimLlyg2l7kg/gUXX6TkPgluOXzp/Yztq3RPfU6p/N5061VoOgAGx0hWG
	103yWGfmuQ2QK6lP98+cX/mrk6dSxD9T+p65UYeUX+2Lvs6GgGZS87Usn9mAQC7Mz6yaZ1/8esO
	S8g/ePU2N1hKzZB7Vl8kVLsO3MIlHTmzUdbM8oE/j1bdH3Hs3GFyef7sGV5JzR+xo+gE/BgITPU
	8T/OOF4g6TvHW21p1to472h7Vq1MPYX81fQzKu/TNLC4Fzt4qRseC7hu7wNp8P748Fc7w=
X-Google-Smtp-Source: AGHT+IFiSxb4uxmRYe6XxApgypPCZjK3lS4QULTVbEwLXNQHGmzceL2GIP7E4FtNXvFCswjqEyy+cQ==
X-Received: by 2002:ac8:5e08:0:b0:4ff:a9d4:8773 with SMTP id d75a77b69052e-4ffb4afd0e0mr293395281cf.82.1768322964364;
        Tue, 13 Jan 2026 08:49:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077253218sm159988626d6.43.2026.01.13.08.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:49:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfha7-00000003vHg-0bmX;
	Tue, 13 Jan 2026 12:49:23 -0400
Date: Tue, 13 Jan 2026 12:49:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
Message-ID: <20260113164923.GQ745888@ziepe.ca>
References: <20260106005758.GM125261@ziepe.ca>
 <20260113074318.941459-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113074318.941459-1-zhipingz@meta.com>

On Mon, Jan 12, 2026 at 11:43:13PM -0800, Zhiping Zhang wrote:
> Got it, thanks for pointing out the security concern! To address this, I
> propose that we still pass the TPH value when allocating the dmah, but we add
> a verification callback in the reg_mr_dmabuf flow to the dmabuf exporter. This
> callback will ensure that the TPH value is correctly linked to the exporting
> device’s MMIO, and only the exporter can authorize the TPH/tag association.

That still sounds messy because we have to protect CPU memory.

I think you should not use dmah possibly and make it so the dmabuf
entirely supplies the TPH value.

Jason

