Return-Path: <netdev+bounces-227455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F43EBAFD82
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 11:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2703C6703
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 09:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53A527E077;
	Wed,  1 Oct 2025 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHKMtLub"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BF71D416E
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759310899; cv=none; b=A4Z3Hr3XUhqA9ckilZj54vKTnKT+rHt7BntTQplenaOikmVwPFnaSS/qQxyOZ2ceYWNzBUaOMowxUO5vQETDcSe6XeytXqfBlNsChZLChlTmY01COcwXEH2MnCY2EYcfm4z/31TeTdG6oNdcq9SbIqkbxnbqRn4EhIb855uu+Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759310899; c=relaxed/simple;
	bh=u8Q/puU00m1+Ma30hn2PbTN/YeCwD3+SnWOZqn5KRRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KoLhmj4dTDZC4Gg4oDXO85QAX3wI42vvzscn4T+iGtYL+cHviLTpMA4VV7tFsBrcUQPrM2qhgQKTL77DUwCog9WhXrnlX+aCVoR3IiSAKPliS6if2LyUpq8AzInVH/wa9PLKEV3JayNExhDjcx0rVOV/5ItoIhNm3GgoAhwSjOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHKMtLub; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759310896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybtVMUpvDW3U/F2Zx0MRGWKL6mjqpdZhKS9ovQqZCJg=;
	b=BHKMtLubZVnUb3kgB8l8GqsQOgsRsfJQJORgdf1eigTzkrvrcMBtWwXXK7JK45Gcw8Q6aR
	DLMdlexDdwY70oyFUA059g04mpYC6ew0fNiD55sKAkoeE0Gy1K+I4VXBrY3sVzbjTOJMQC
	i+NHFO2+xR92ZRiQRCz9b0OuIXQrQnk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-FeGLsQOZOiaBR6bgLxnZGw-1; Wed, 01 Oct 2025 05:28:15 -0400
X-MC-Unique: FeGLsQOZOiaBR6bgLxnZGw-1
X-Mimecast-MFC-AGG-ID: FeGLsQOZOiaBR6bgLxnZGw_1759310894
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f384f10762so4313753f8f.3
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 02:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759310894; x=1759915694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybtVMUpvDW3U/F2Zx0MRGWKL6mjqpdZhKS9ovQqZCJg=;
        b=HZzyAA7+DsNfff2SW4XgJTpYg6auXBsRTR4vVVuPf9PfzeXifboijn3GIUFMfP+bRK
         CqvrklAZ4sKbaIbJfaM+DTWEt/ONteAKv1OZ5j08UKDQQ9AnF0IuIFCUYaRlSdwm6ynO
         PbtIjsioe7M9557qzmHAue1h7PzGzluvtyr9I0Cao69bdTFmc26k/1Q4qNTLTc/nRJiX
         KBNPfZVxUVn9oiDqyjk4d+aleY+wr3l6a9r8JNqhqe2Mw15BKtachODQLDgJPwKOM4dB
         UOv4sd5/FpzNUgS1ZNX8RsK/XIaxZpPVIazaLRhyO+A6pDEgkBHhf5WrUiV1zyKsETA3
         AqWw==
X-Forwarded-Encrypted: i=1; AJvYcCWn0JeTv+sFvH3DRhSVq5m1X6IWdRV25nWs2sx8GPPVbpsp0yFA3TEFcQytGJWhJ4AvAKyRlo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHjnwiJPocxmSJ3rRIihF9ZO47eW2JWkh/YUf5xo0/FMRoDdLw
	CXGAaw/f2mTcfBpkYCmfEbzd1uVTh9nTiQ/o/ojrisPTfr5axtF1AuU4DjUZl9JCxL1S9dLq1FR
	A5/WZfrRhkkxkIT5U4ys2xSDEsttfDaOu6pdVtf5pr/BUnqGYAZzjGVojsw==
X-Gm-Gg: ASbGncvPJDOJPTIHm5ke2NShOD5787PEtf+QbancuPu98V+JH6goaZYzygs60nE4px8
	2ZSkNEugqsqnuMEeEGibGf42uqMdKfIW8S+Di6hbyRGnuhiR24oaOzm0Q0JqpTE3z+dhhQC1Pz1
	Zu7Q5reMRTfqT6xnCXKNU5yn1V4lm8IeBqjQTDDF2CkzwUrau1pmB2XjsMFOJ7+PjjoZx+mWt6u
	+ZxXcMv/Gn/Eg7+O2QrPQN0hSYOeOyVgxwdVVmqwzq3nnc/F8txUzzNXdswWKdtpfdb1BonUtSN
	ZpQL70KWmEWsS9G7Drq8dh8/Pvyav+/NdeaSMp3KXY+iEZxhKavMeTgCI423dZQcz7ZLJSbKDSR
	YuAmwWcFPnoPJPRmYmQ==
X-Received: by 2002:a5d:588a:0:b0:3ec:248f:f86a with SMTP id ffacd0b85a97d-425578183aamr2084058f8f.48.1759310893672;
        Wed, 01 Oct 2025 02:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2jGX49TGzAee2RWy6ApUBj/jwFn2OVqWsFJymuz8OiVF8ehgSB3/azRECWeXusX/4XaZBCg==
X-Received: by 2002:a5d:588a:0:b0:3ec:248f:f86a with SMTP id ffacd0b85a97d-425578183aamr2084020f8f.48.1759310893212;
        Wed, 01 Oct 2025 02:28:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fac4a5e41sm28042341f8f.0.2025.10.01.02.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 02:28:12 -0700 (PDT)
Message-ID: <651ee9fe-706e-4471-a71b-e7a12b42cc3e@redhat.com>
Date: Wed, 1 Oct 2025 11:28:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
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
 Niklas Schnelle <schnelle@linux.ibm.com>, Jijie Shao <shaojijie@huawei.com>,
 Simon Horman <horms@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
References: <1759093688-841357-1-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1759093688-841357-1-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/28/25 11:08 PM, Tariq Toukan wrote:
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
> index 999d6216648a..c281153bd411 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
> @@ -7,6 +7,10 @@
>  #include "mlx5_core.h"
>  #include "wq.h"
>  
> +#if IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && IS_ENABLED(CONFIG_ARM64)
> +#include <asm/neon.h>
> +#endif
> +
>  #define TEST_WC_NUM_WQES 255
>  #define TEST_WC_LOG_CQ_SZ (order_base_2(TEST_WC_NUM_WQES))
>  #define TEST_WC_SQ_LOG_WQ_SZ TEST_WC_LOG_CQ_SZ
> @@ -255,6 +259,27 @@ static void mlx5_wc_destroy_sq(struct mlx5_wc_sq *sq)
>  	mlx5_wq_destroy(&sq->wq_ctrl);
>  }
>  
> +static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
> +				size_t mmio_wqe_size, unsigned int offset)
> +{
> +#if IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && IS_ENABLED(CONFIG_ARM64)
> +	if (cpu_has_neon()) {
> +		kernel_neon_begin();
> +		asm volatile
> +		(".arch_extension simd;\n\t"

Here I'm observing build errors with aarch64-linux-gnu-gcc 12.1.1
20220507 (Red Hat Cross 12.1.1-1):

/tmp/cchqHdeI.s: Assembler messages:
/tmp/cchqHdeI.s:746: Error: unknown architectural extension `simd;'

I can't reproduce the error on any recent compiler version via
godbolt.org, so I *think* this should not block/be reverted for the MR,
but could you please have a look soonish?

Thanks,

Paolo


