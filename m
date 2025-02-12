Return-Path: <netdev+bounces-165619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D5DA32CFD
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA981889942
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0EF261378;
	Wed, 12 Feb 2025 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m8rJ8RXE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2DA260A5C
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380025; cv=none; b=qK/+9S9Tnrki1dzBqDVFS6Kr1aVWFcLjq96e6cFaaFLDZh4zQ2hyGXRFs0BMIE29+tIl3zZkj6BbRiJOA3WMBINW1psXlUGwTO3CA7sJ2ExZBdlMAe3TQYacO0SO7gd3128glObNlChXGf6Bn6BfDJnq14LM6XVkFJmzdCy9iAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380025; c=relaxed/simple;
	bh=lteTsHAofWcNmBaXCw2mHJ/LxVM4Lx/RZ4wOuwiWnt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhPfr+k9duywOj4G8xOf8WmC+VA7oGHyIDxEHqiDgzVPHbVuMRkyXkCQhciVo41OG2/oftETqgFC1/2KSNVcifg7z84Pqe3hW24XaLTXTjN0jBRFiyDFe+7ShpBZGl2Hi1VrhA7qb4irLiIEKReLYoEm1cwsOqtebikpDv5du80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m8rJ8RXE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f44e7eae4so120890605ad.2
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 09:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739380022; x=1739984822; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iMfbhD6wkX6MaCnkRWtypNgtVIrRM7/Oh0qieWzgO1w=;
        b=m8rJ8RXEs4UMpNHdBa39t96D3WvuE4TNCtkDZmPZ+FXgkNVhySzfuP4FoZSHVVHsY5
         VROK/DnL3I78r7VOieozX25g/HV02dEfYFOXoj8EXaCDl0Nb7RzkGynag8G3V7PyAO2K
         aIOlw6XEMPO96/xEvTbC95y+0BowXQyfxrKU3LXloyBjwHQu4K4MfkAA44zkm80PWIz0
         Sko7nltWJ2HpOHeID8GggZucdfpACSfRUF3VcpHG0YHmePCSviroqsnjX69sflSsTL1Q
         PkT3PgUHFW0X5lbsqB8yntRo9boV7swCJeRlZvrntaaTgQSki/vRzmYyOFxpN2RLBcJ1
         Yn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739380022; x=1739984822;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMfbhD6wkX6MaCnkRWtypNgtVIrRM7/Oh0qieWzgO1w=;
        b=GKh2JPirUVYq/S0uKNlQGZ+CnpzCdizRzt0xALozqv2TMRe5PXleNx+1qaqzMjf6by
         fQ+KZKO9wFsWJ22xRg1hQrx2XCAc2oPTe6zrOns5/N8w3BD3de8aM/8HIyBFMv6qohsx
         takZfoDWdWJHV+cZfW/iXU6WsQHuwsiWbUJWZH14gtIy/f//HvJj6kMDc0HNoQvk/LXb
         52SzAl168WgJH6kPGAgrxD5u24IhtX0QFMgIr2H+thxXoLLVdndlNkKRnAa6d4Xazjx/
         psC3EorzK/lIkx+66stt83q82NFcxCAmMA9i6G/i6svcWSagxqtFBTmDsApq/GqDuvDm
         h12w==
X-Forwarded-Encrypted: i=1; AJvYcCX/CYeG+fZUBPaGcIVqxdJKT0jkxBlsa/ox3AfDJBCY71aFcaC/vR6MCzDlS4VUeZ63Amvcdds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKhThNL4dd2qvb3lCB32zpGxhP9YuTQFoLaRv10hHyDGdsUVLs
	Vk1XENEFeCZInmRDcLuCShVezwHaOU7qY8XYUDSKSamLZJsC2rj9EnvcLSi6+A==
X-Gm-Gg: ASbGnctQ/aafqW5xq3qs4uawYSc9axYRjFjB17XeLAoM2WQRODBUnoNJ3FUMp18Uc2l
	VJRsL5S73nH7+4OWkIpp2RlAnCOiy0hma7zprotOR1ExCuh9LWtOMsjqtV+LEVkN42tv+pOi0oy
	aIMf7A/7G2fRNE4ZoFJYKX7c4r3APw3NFXY5nXTKToxX5oGYFmW1Mzq+xgg46J6WhIPyNm6ucFp
	GRAGpcNVPRvkGQUsQHP/qSp3DNa1evFHKtR7cAe56LEXRJBxClxOVn0QggBMxaB0Prs5nlaJ/7/
	te/jXB+tFrwD8ols9BKq/ci92X+dYwM=
X-Google-Smtp-Source: AGHT+IF2luvrqC0ykZO6VitJHSJWVQ71T5mlJNsMYUeoTgA9VEadsV/+zYxhfiPIyZqZHXO7crIAtA==
X-Received: by 2002:a17:902:cccc:b0:21f:5b1e:11ef with SMTP id d9443c01a7336-220bbc64587mr79261985ad.32.1739380021744;
        Wed, 12 Feb 2025 09:07:01 -0800 (PST)
Received: from thinkpad ([2409:40f4:3012:d471:d5a7:bf83:76ba:b479])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad5434dc097sm7690741a12.7.2025.02.12.09.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:07:01 -0800 (PST)
Date: Wed, 12 Feb 2025 22:36:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH net-next] net: wwan: mhi_wwan_mbim: Silence sequence
 number glitch errors
Message-ID: <20250212170654.tmynyd62szap6n47@thinkpad>
References: <20250212-mhi-wwan-mbim-sequence-glitch-v1-1-503735977cbd@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250212-mhi-wwan-mbim-sequence-glitch-v1-1-503735977cbd@linaro.org>

On Wed, Feb 12, 2025 at 12:15:35PM +0100, Stephan Gerhold wrote:
> When using the Qualcomm X55 modem on the ThinkPad X13s, the kernel log is
> constantly being filled with errors related to a "sequence number glitch",
> e.g.:
> 
> 	[ 1903.284538] sequence number glitch prev=16 curr=0
> 	[ 1913.812205] sequence number glitch prev=50 curr=0
> 	[ 1923.698219] sequence number glitch prev=142 curr=0
> 	[ 2029.248276] sequence number glitch prev=1555 curr=0
> 	[ 2046.333059] sequence number glitch prev=70 curr=0
> 	[ 2076.520067] sequence number glitch prev=272 curr=0
> 	[ 2158.704202] sequence number glitch prev=2655 curr=0
> 	[ 2218.530776] sequence number glitch prev=2349 curr=0
> 	[ 2225.579092] sequence number glitch prev=6 curr=0
> 
> Internet connectivity is working fine, so this error seems harmless. It
> looks like modem does not preserve the sequence number when entering low
> power state; the amount of errors depends on how actively the modem is
> being used.
> 
> A similar issue has also been seen on USB-based MBIM modems [1]. However,
> in cdc_ncm.c the "sequence number glitch" message is a debug message
> instead of an error. Apply the same to the mhi_wwan_mbim.c driver to
> silence these errors when using the modem.
> 
> [1]: https://lists.freedesktop.org/archives/libmbim-devel/2016-November/000781.html
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/net/wwan/mhi_wwan_mbim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
> index d5a9360323d29df4b6665bef0949e017c90876a4..8755c5e6a65b302c9ba2fe463e9eac58d956eaff 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -220,7 +220,7 @@ static int mbim_rx_verify_nth16(struct mhi_mbim_context *mbim, struct sk_buff *s
>  	if (mbim->rx_seq + 1 != le16_to_cpu(nth16->wSequence) &&
>  	    (mbim->rx_seq || le16_to_cpu(nth16->wSequence)) &&
>  	    !(mbim->rx_seq == 0xffff && !le16_to_cpu(nth16->wSequence))) {
> -		net_err_ratelimited("sequence number glitch prev=%d curr=%d\n",
> +		net_dbg_ratelimited("sequence number glitch prev=%d curr=%d\n",
>  				    mbim->rx_seq, le16_to_cpu(nth16->wSequence));
>  	}
>  	mbim->rx_seq = le16_to_cpu(nth16->wSequence);
> 
> ---
> base-commit: 4e41231249f4083a095085ff86e317e29313c2c3
> change-id: 20250206-mhi-wwan-mbim-sequence-glitch-cdbd2db5b3bb
> 
> Best regards,
> -- 
> Stephan Gerhold <stephan.gerhold@linaro.org>
> 

-- 
மணிவண்ணன் சதாசிவம்

