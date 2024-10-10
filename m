Return-Path: <netdev+bounces-134247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EFD998841
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C341C211A3
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E3F1CBE92;
	Thu, 10 Oct 2024 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NrYedPSs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE671C9EDC
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568162; cv=none; b=AOUZWH2YJT3zBddl4XqOF8TFZK7SB8mN3dEZgLuuu3aqRz/PuI6U+UpyEPv3osiSvsjSasVx7c59f8mVEq4gTJ+em10umG5INLlyPUt08GoTJ+NuxwtvIzEoZ4Z/F0DmG4gpIaEYgWK5yVIl72gkL6xKNFAF+5/pMsYYs98FMTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568162; c=relaxed/simple;
	bh=MkfzJPryuENSyvLa2fWlHXY7JSZm/ynNAd9cER+oGiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joqzPllWniu2POpt6pVWWm5hn2jlpxJTbGnnBcKzmpnfueY8BVe8Cf0vH9LPXyS0ND/oaL1hixFDg/AcZe8MXGBAU873Gy8X0Z8lEwheovq5AAn3xYbAfQgnthadY5aFqu+0BAkJNT7x3+vW167twV9LrYqZ/FHBBfBUDAAGUpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NrYedPSs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so8468985e9.3
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728568159; x=1729172959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kVs/IOPgNM31y6y82QiYclQ6PlIE3YW8FKJDe7DuIfc=;
        b=NrYedPSszYcTF/lX9Ggg8P97HFVRoHeOLwcbclPABVKexpO5NP/g78xUfIdekNLoaN
         BQbAkhqoxbZBPSYWvAABThcgss3WQ2f8ODSJCFE/m4Yrf3hRp6d4/Cj0+JzbjHbZ7lFB
         8Rs+OuIYQxAFFFmrPxldGBmMZ4mkrqwk8wnvpl9hB+rcOb/cwG2Shn9iBZrxx74en3vY
         bfCkzMakg0N7Ox+6jOs9++mTloZCqLAv9jO45dgT19KBDuOqGoesFEyFrvsDgar1njwh
         KTXGgtzlWr2ctKHNk3rJzJgelq/4zHxh6cGDxZTpdH4wOE87G4aigl2oPFSByWHyYtqJ
         ZmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568159; x=1729172959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVs/IOPgNM31y6y82QiYclQ6PlIE3YW8FKJDe7DuIfc=;
        b=r7W+a/g6kDTc/nuFFHpw92KVfWSM61tkkjDWzqRn48S17NIjiPQQOHe52EDhRc4+W0
         ueL8JLAbdogA+39erJg1ZK23lhh0KfhvKtpH8Us9+wX2YPO8fY9Ws63gmx2g9vA754PX
         9rDVY+f9vHV7sKShBsEhkQ7yrxkGev/ffnYWFiPvnZSC8PRHDN5uVgDtqe7oLMbOIGUh
         pFdpakwP572Lt2OCUn/xCNyqSzzh4VYM0lQMcrO5mLUx6p7O7MnPMcS4rn2OHFSGBXLR
         VePQcvllT788cCxpo0xyyFtNXft44S/eax6I9pB2ogJj64M3xFzNhTztJd3/4+zk6pnn
         Smpg==
X-Forwarded-Encrypted: i=1; AJvYcCUIqwgF4cp5XoaKY+y5gFjkWXhDxhgkWtUFjfNQyA3GZmAHbn8yM6y+cCW299YlgjeiEteO5zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWgdyM0QxK66cOQ/eEQrSK/y8hX00kMrsIffofN2j0Ed8wbUru
	Ry8iM7WDGpsDPAL+beEp+mvwzmdaO5pclTV1BDm+a+VGngQwKbFrSZmDt3PmM6M=
X-Google-Smtp-Source: AGHT+IHjkW70IvZpZidBcOOO1FW1z74uz5tbvpksvMoBr6DAW85JUj00bLvuq5bdwty4viiClMPJXQ==
X-Received: by 2002:a05:600c:4ec9:b0:430:5887:c238 with SMTP id 5b1f17b1804b1-430ccf2879cmr53610325e9.11.1728568158920;
        Thu, 10 Oct 2024 06:49:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf43da8sm49649975e9.11.2024.10.10.06.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:49:18 -0700 (PDT)
Date: Thu, 10 Oct 2024 16:49:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] octeontx2-af: Fix potential integer overflow on
 shift of a int
Message-ID: <15043c16-019e-40c3-874d-fb6d1392a9d7@stanley.mountain>
References: <20241010131122.751744-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010131122.751744-1-colin.i.king@gmail.com>

On Thu, Oct 10, 2024 at 02:11:22PM +0100, Colin Ian King wrote:
> The left shift of int 32 bit integer constant 1 is evaluated using 32 bit
> arithmetic and then assigned to a 64 bit unsigned integer. In the case
> where the shift is 32 or more this can lead to an overflow. Avoid this
> by shifting using the BIT_ULL macro instead.
> 
> Fixes: 019aba04f08c ("octeontx2-af: Modify SMQ flush sequence to drop packets")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 82832a24fbd8..28f917a37acf 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -2411,7 +2411,7 @@ static int nix_smq_flush(struct rvu *rvu, int blkaddr,
>  				 NIX_AF_TL3_TL2X_LINKX_CFG(tl2_tl3_link_schq, link));
>  		if (!(cfg & BIT_ULL(12)))
>  			continue;
> -		bmap |= (1 << i);
> +		bmap |= BIT_ULL(i);

There is a similar issue in the next loop.  Could you fix that as well?

regards,
dan carpenter



