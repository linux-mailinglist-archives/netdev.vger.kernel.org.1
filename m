Return-Path: <netdev+bounces-227967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E643BBE410
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 15:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32198188A537
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99422D46A9;
	Mon,  6 Oct 2025 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6HJjoju"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178BB2D3759
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759759070; cv=none; b=Pf383USmGjSDSzJg67tn8xUdN4OG+q9tR6Kmvdno6crlezlbJKLqwWIvxHOjl90HIcL1bMPqqnhUBfAO+yAOSIHbsrPxm6w3UFag96xRh4fCpG0vNWAIPWC5Lx27idIY57pk94m6dNxqNf8zWaX8xFTEYimHhVvA8xszkEawp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759759070; c=relaxed/simple;
	bh=aoHPu3E0mvHoalx0FWQM3EH+lnlTpy4HtT99+90hPDc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=enUnSFRcW4DQ1KSMAm4UkFLY5s7rchs+PvkiGaR03PW3HnUmBNG8/9sxfdY4DBERYRTMWrUDNOj3qgAl12aoJerJkmnU58uwYfnl4EjFZhrb8zTjXd6QeQ8EE7P2/jfYZ1H7/dedMMBISzPCxPvT7KyS0/yA9ssIdJNL898YUsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6HJjoju; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759759067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N38NCXKatF4Nc9lTi4kU9EIStYgT9YorHxjupIC+4LM=;
	b=M6HJjojueNndtjlEmuosK+WA77fZPgzul4HhCQ7HEG3sT2fqwl515dDivx+tAYsQTjkf/b
	iagd0BkZN170wfJVxCSmhdrrOYQYZUQnJgX86P/cKULdefwcSrRK3/d9xEIL5b3vtAxBqO
	JqcmbxQ9zat3EkvryyA+1K2GoA+9AFM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-jgtYKLSpOx25Mu1NI9VKIQ-1; Mon, 06 Oct 2025 09:57:42 -0400
X-MC-Unique: jgtYKLSpOx25Mu1NI9VKIQ-1
X-Mimecast-MFC-AGG-ID: jgtYKLSpOx25Mu1NI9VKIQ_1759759061
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso2742582f8f.1
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 06:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759759061; x=1760363861;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N38NCXKatF4Nc9lTi4kU9EIStYgT9YorHxjupIC+4LM=;
        b=MENaX0BeLpjjJzO1PeE9fyeEaOv/BQJQmPLHrCc/B4mXPzk9tfC/ACFN3SjRWgOPOu
         Ds3KxJa9yceERBB7xTa3k2KMo5ryM+RPdK3Q6cklCRykJwDRH8m1KZtmaF0Sn1uFuQLs
         aIiiIHSdb06R8hvi2fRfrAbXLszg/SOiZjd1qry13D/kZ2Kesbbw9N1pDhn2xLZ0nxQi
         TAeNwDcujKKoF9wlsF1dS2iOHsld+LA2WQJCFgxc4s40Dk2uhruYwCXJJ+yXI0+lTnaa
         yG0misc9RQGE5SX+W4AGhCnvNYSt4+xeQpNdwrZVaLxC0+nqvhqFPJjPospNrn7dS9Un
         sP1w==
X-Forwarded-Encrypted: i=1; AJvYcCVKSXxkOWtrmFoKjV+uac7DHF8WHA6HbjCv8gTEldsFX/eU0okGHTHjmpr1C2K3+mWKDezFMTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyimOGB8XR5QyIYuj0XK2I40gS1257WRzIjARrEzV0/CUAtceX
	K1j+ZY3reoxYsc9t6BhHN6yNUxAofxuRTysdrs9ZBoL1c4M+mTRwzAiEf1rd/113FQncdlD6OJr
	YQmQVRJ7bcY6hKl4yqV/ARfVTsnqVQ+61OOECZA/UWS1t6Yty9WQP/CB/CQ==
X-Gm-Gg: ASbGncscFx94HdgIzX3eeNKzkmBoBQ6g9IRVzkjj3U5kzdhpHiiPlwzmH9LzaFovS6G
	jFiuHKuYtghtjQ73gM5wnv+QodkGX30rObvgl0ImL/D50UHYkhmbKqzXqxB45u5Zk5Ec0Lbn+C6
	oVAmcAraJPEqcdAmtUJ+Vd6/mgk/tTc9qgon6DvlkO8yhQbWz4IfHLcULFbo2por80elhni3a8F
	UjSXKfDDO3G0qf7MqCt3Ct0LMQMfoXqBASWr86GQx9ZUD7Db4f2V9xEghyWW9jujYUM2v0NYBWE
	aK41h9/3kM7+c2FsRdwuAczPuG2QaITCBwrTOBkbTVgBQbNJKldRinuUcQkFTH4Agi8D6pLQ4gu
	KhAuUaBbyWeROQE3AX4Y=
X-Received: by 2002:a05:6000:24c8:b0:3e7:471c:1de3 with SMTP id ffacd0b85a97d-4256714c990mr8743299f8f.14.1759759061330;
        Mon, 06 Oct 2025 06:57:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSEXhNL5qt3C2EExsoRcqgHMQ8DFjBOOTUMJgsVGWdtBaHzjZoYrl+W+SOqr9EcfM/+bfqVw==
X-Received: by 2002:a05:6000:24c8:b0:3e7:471c:1de3 with SMTP id ffacd0b85a97d-4256714c990mr8743277f8f.14.1759759060881;
        Mon, 06 Oct 2025 06:57:40 -0700 (PDT)
Received: from rh (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de. [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6c54sm21356683f8f.11.2025.10.06.06.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:57:40 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:57:38 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Tariq Toukan <tariqt@nvidia.com>
cc: Catalin Marinas <catalin.marinas@arm.com>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
    Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
    linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, 
    Jason Gunthorpe <jgg@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>, 
    Moshe Shemesh <moshe@nvidia.com>, Will Deacon <will@kernel.org>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
    Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
    "H. Peter Anvin" <hpa@zytor.com>, Justin Stitt <justinstitt@google.com>, 
    linux-s390@vger.kernel.org, llvm@lists.linux.dev, 
    Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>, 
    Nathan Chancellor <nathan@kernel.org>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Salil Mehta <salil.mehta@huawei.com>, Sven Schnelle <svens@linux.ibm.com>, 
    Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
    Yisen Zhuang <yisen.zhuang@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
    Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
    Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev, 
    Niklas Schnelle <schnelle@linux.ibm.com>, 
    Jijie Shao <shaojijie@huawei.com>, Simon Horman <horms@kernel.org>, 
    Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH net-next V6] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
In-Reply-To: <1759093688-841357-1-git-send-email-tariqt@nvidia.com>
Message-ID: <e77083c4-82ac-0c95-1cf1-5a13f15e7c58@redhat.com>
References: <1759093688-841357-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 29 Sep 2025, Tariq Toukan wrote:
> +static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
> +				size_t mmio_wqe_size, unsigned int offset)
> +{
> +#if IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && IS_ENABLED(CONFIG_ARM64)
> +	if (cpu_has_neon()) {
> +		kernel_neon_begin();
> +		asm volatile
> +		(".arch_extension simd;\n\t"
> +		"ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
> +		"st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%1]"
> +		:
> +		: "r"(mmio_wqe), "r"(sq->bfreg.map + offset)
> +		: "memory", "v0", "v1", "v2", "v3");
> +		kernel_neon_end();
> +		return;
> +	}
> +#endif

This one breaks the build for me:
/tmp/cc2vw3CJ.s: Assembler messages:
/tmp/cc2vw3CJ.s:391: Error: unknown architectural extension `simd;'

Removing the extra ";" after simd seems to fix it.

Regards,
Sebastian


