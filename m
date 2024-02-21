Return-Path: <netdev+bounces-73669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EF385D7EF
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 13:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0BC1C220BA
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF42B67E8E;
	Wed, 21 Feb 2024 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+R65GQ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263663DB91
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708518790; cv=none; b=ME6hrNQXqIyKvTVYSIDEGZ3MyuR49lcdbz3VicheKf76hcsQObS0OSJLic5MCLW0Zc42waZvIKhQJE3hK7TAycp08D1iJ2TbkEaimKnz4nQZpzrWs9xS+oxjUfgz6ZrnEEpUIVKLqRqQhz+K0CPyevqvkOD4EhTd9sUJ9Orf3EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708518790; c=relaxed/simple;
	bh=FD6fi4gzBDDSUxkv7a73rHXnx+O2lgsfmS/NdAH+G8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnLdCClCjXO/f3+QkBk6pKTz5I7rkhl4MbEgDCs0HdEzsnZz6WFlzLtzJuuvP8nbrQLCI/PyOTOeQb+jXFKyqXP9Ou4sLVt094I5ECZVErQVK+rKNsu+43MPO02K+h7gmoPRq7R7LAQNRXKrjNdMncUyeNxeSgo3CwOj8tU/VtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+R65GQ2; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512bce554a5so3676212e87.3
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 04:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708518787; x=1709123587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iCLjkXGSjSoqlFRr1hCuospNqyJKYoT2UJnBFsfq3q8=;
        b=e+R65GQ2q1j8v6ps98j3IQU9875cAbopjw8SKdU3Rw2STdCH6vDgqoCvVMDedVglyw
         zEK2zp0zW9UizRku+HfhL9z5Ty+tlWSFGJrs6r3fNIdpzK4Hur10UAuFV2uPALcyTcax
         KESWHPLchL069QQnN7x8NSsy0KjKdWLjX8SoHvCAt2NVaTceLBfnILYXavK0Jgy/zzVO
         T+wQQl6y3w6/ZqXFU2ZDeYLlqwXF7Dnh2y/gJy8knrvQQwq24CiSHgYX5pod2+308wMh
         9txZK+mp7sViYzyDaL4IJFwHlnV3ir53ALk9LbDPivBCy/0ILd0vwXmziXxaV24IyUi4
         E7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708518787; x=1709123587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCLjkXGSjSoqlFRr1hCuospNqyJKYoT2UJnBFsfq3q8=;
        b=rmL6kqG33dM8ZGURLK/QMyVdYCt8ZoUIsfR59F1JglXHYPxnQnC0hgQkB2+AWGuzc4
         0w4jS+iGTj7uRuvTu6wvP8eMIvUJ3Pe7khUPn+8tqrAlkKqNI9eK0uFyDSJxqlNro8n6
         c4Vc0NNpmYw9KcyEYmgzdrp2OqW9eriMbLF8HWjagFkaCUOWLoS22B54P8d7The43SDF
         tgsRsXCk9Zlqpx4AszP+iY5fxcUSIW1XmyM2qB05P75zjwHvmipQGKXYRHl/5x2AeQD1
         ie/foLoIGRLE9kTY011lGIzV0s5EK2dXgPkbuTK8fzhSCoiDbOdCuAg/RnBEHfBV0oPp
         6Ayw==
X-Forwarded-Encrypted: i=1; AJvYcCVBnXuIc36epmrYj0L8a5EcSvFsW6eZUq7RwccgjDfsZjurDFRlN7W5kPjSU4+U90FWTggv/N6WXwJOTReNPt+TDJWWF7bA
X-Gm-Message-State: AOJu0Yw3huLYzCMp0rU1soCF8GYgXYDQZ0UceYsiVPNtUklDIF9NtGq4
	lmGJ+AMKBixxgdffhXteaE7VkNT1YqvR0BJRRYDn9o3c0gRHFGXO
X-Google-Smtp-Source: AGHT+IFDFjdxTUnMhbX3qqDhII4SIxP2+L3e3O0qYSMAl6hox3r688DoiIHvB26KnqSfhxXiaeTXig==
X-Received: by 2002:a05:6512:709:b0:512:b354:c3e1 with SMTP id b9-20020a056512070900b00512b354c3e1mr5170202lfs.40.1708518786978;
        Wed, 21 Feb 2024 04:33:06 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id v29-20020a056512049d00b005128d5d670csm1634052lfq.193.2024.02.21.04.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 04:33:06 -0800 (PST)
Date: Wed, 21 Feb 2024 15:33:03 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: fix typo in comment
Message-ID: <yzzae6r6ablywrxgdbvjwpvpfuoxx63h7mnmc7fdcwkyzgjk7k@oi6rxjlfthvy>
References: <20240221103514.968815-1-siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221103514.968815-1-siyanteng@loongson.cn>

Hi Yanteng

On Wed, Feb 21, 2024 at 06:35:14PM +0800, Yanteng Si wrote:
> This is just a trivial fix for a typo in a comment, no functional
> changes.
> 
> Fixes: 48863ce5940f ("stmmac: add DMA support for GMAC 4.xx")
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>

Thanks for submitting the patch.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
> In fact, it was discovered during the review of the Loongson
> driver patch.:)
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> index 358e7dcb6a9a..9d640ba5c323 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
> @@ -92,7 +92,7 @@
>  #define DMA_TBS_FTOV			BIT(0)
>  #define DMA_TBS_DEF_FTOS		(DMA_TBS_FTOS | DMA_TBS_FTOV)
>  
> -/* Following DMA defines are chanels oriented */
> +/* Following DMA defines are channels oriented */
>  #define DMA_CHAN_BASE_ADDR		0x00001100
>  #define DMA_CHAN_BASE_OFFSET		0x80
>  
> -- 
> 2.31.4
> 

