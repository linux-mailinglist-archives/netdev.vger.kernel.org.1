Return-Path: <netdev+bounces-222929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBEDB5709F
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 08:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B639F1896048
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 06:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9521D2BF3F4;
	Mon, 15 Sep 2025 06:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3FtC1AL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE98F29E11D
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 06:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757918973; cv=none; b=QSoB9WelHVrjP1zgK1TCSq4aF1Scvr3t1lmNWWY8iybaQYh06rD7we+jAIhlkjPeqXQyRLcjVnq8jPYY2WLrue1hXB+zuGFy4diZR+lN5XQyBxcPOWPuyJxMtt36yfnxzjdGCyBE40SZpuA1ML/Qm00eyZRRg14BJL1dvYNqcT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757918973; c=relaxed/simple;
	bh=y+Ts700dyFh7Sbo5E3aMbOkmEk/XXfH/85l7cyAHUPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAJawqtKgui/KyePPGzCT/H7VnLIqzF4poyJxg8SCO6Rnu1sIVv1/DtKXcYQywAlZVO3+Rr6H41NcEJWDU/C3uHRmMy2XiZV0UWk1vdY4jclx5iDdg/xxKnWCyf+PEBBIGw7xvKKnlcmrgsyqqUGQSd1GymOu5WDSBUZaDjA7T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3FtC1AL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e9042021faso897472f8f.3
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 23:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757918970; x=1758523770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRhn4UI1i6wUE9dvuB3tPiTpnLotqg1U3EdGZvL3C64=;
        b=E3FtC1ALxf7VFGt2+b1k9eKzXtSdqoxlHw1vlpwhV+5rI485BlWzOc6WwePeQCJLP0
         VL5GdG6xsXQd11vlDiacHpvww1KIxjkn9WWdhkvlJBvWYBUnfzQ8fhpeILEQun5W8RRh
         CLmKDVg/5+ZJHnKLxBMMdhO2dL/0Z29+npZy2vT+LGrkuULSdAOB0U1f9OIu297k0h/L
         y4nV9e7th3OlHeeoCMNLIznvtAUhyS96NC2DFprmsOgbbvOWVvr3bk1+RgY5n5QFpN2E
         XyVxINrzqJSfXGeiKtOW9VxCcuH7+uRcFgT44D0Csbu8SJQYb8bKc42lpdfzyQY1sos5
         7YHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757918970; x=1758523770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRhn4UI1i6wUE9dvuB3tPiTpnLotqg1U3EdGZvL3C64=;
        b=gX5tHyzGZsoxgIFbxTxD0rFeVmlBTJuK/REHkYb+4vQPgRw/KtBgNlzATlrrgPxPN7
         xclgdXVJ3YtZGVNIGHg3dLxuMVW/S9DDBCHsrC3dR0xpo8ygVtat3FHavdW1YtBFvMG+
         6Oo7hqNF5Cb6lo0VSa9NfZzd3vKAzKJO02dhfllKoVBAi3eu0J95IexREp6YQ8zXmPRx
         TC6ocOrNBgAbx1RAKEmakhqkmJ5N+pdobQNYczMm4Mbv5Jlzzd+KE0J4Lr7BmTIDTONQ
         fmYyDiBYMrlPOhatQSFe+HOYxveC1pBR1kVv5WVgWeZRVhQ7mxbUXmDmeeI1Jd2bePRn
         NcZA==
X-Forwarded-Encrypted: i=1; AJvYcCUe97UjuUOpqRB1NOUVs/pHn0e146FPJMxzvmHZQZ2LKt4nr/saaYj80HtOnL3ZA5M5PTVdP5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+aDMEHrp34XXrxnfEOIesYTL6vNoEy9eSka3/0PYoZAywehP
	oZZ8dxSDkSPnqU0Y/VF728yvSaGoFT69/hynHA4Hs14z5D2GAFoQ6I6s
X-Gm-Gg: ASbGncsMHeG3yq7b2PJfRbOeecnyZFZDMsVx19jOWYYvLsfD44N/3KzvP3frcYcgRC6
	qzILmjuFoJma7dUXTI8kSbu4jMdb7E0hv1Ms42qnA3Wnhp6ff3wD1ltQdohsAhTcwgenfZmzAZr
	BhPwts+gwmsV4er0DVUz8KmoZnRGrsS++SPQkfVfpWjY453pLMTCBjPBG4/tU7dzDmHQQqFNEpU
	HeI/DqP1OTqHPBvOsyJuu8OcbMpsKyeNihPzw+E9GJ+eg+J/5PDmLY+RITPu1Avc9vmh8dx15D9
	5o9Z10vSs5auh5p7SILYCogj/nXRxnuRhPMAf3EWHNv8J+EYhnL5zs07LLTzGRXBoLwTOOhMPXd
	GHYV2iAV122qJykzwBawXC9AGTj2BQEfX6wq9rcVR8Ng=
X-Google-Smtp-Source: AGHT+IGp2rgRuB3vs2/XV9q3gFpF1P9760GllJVKtJhrv1TfRfFuwwyt6IjSgk5kzHo5bQ+OFboa+w==
X-Received: by 2002:a05:6000:2dc3:b0:3dc:ca9d:e3d7 with SMTP id ffacd0b85a97d-3e765783063mr7692923f8f.8.1757918969993;
        Sun, 14 Sep 2025 23:49:29 -0700 (PDT)
Received: from [10.80.3.86] ([72.25.96.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm10789594f8f.42.2025.09.14.23.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 23:49:29 -0700 (PDT)
Message-ID: <dd2ba47c-79fa-4bfe-9eb0-c10b978a8260@gmail.com>
Date: Mon, 15 Sep 2025 09:49:28 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: fix typo in pci_irq.c comment
To: Alok Tiwari <alok.a.tiwari@oracle.com>, mbloch@nvidia.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
References: <20250912135050.3921116-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250912135050.3921116-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/09/2025 16:50, Alok Tiwari wrote:
> Fix a typo in a comment in pci_irq.c:
>   "ssigned" → "assigned"
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> index 692ef9c2f729..e18a850c615c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> @@ -54,7 +54,7 @@ static int mlx5_core_func_to_vport(const struct mlx5_core_dev *dev,
>   
>   /**
>    * mlx5_get_default_msix_vec_count - Get the default number of MSI-X vectors
> - *                                   to be ssigned to each VF.
> + *                                   to be assigned to each VF.
>    * @dev: PF to work on
>    * @num_vfs: Number of enabled VFs
>    */

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks.

