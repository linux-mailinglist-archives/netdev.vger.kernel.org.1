Return-Path: <netdev+bounces-193580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12E1AC4984
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 09:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3717AB09A
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 07:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CCB248873;
	Tue, 27 May 2025 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Im4qVtpx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937DC2AEE4
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748332012; cv=none; b=Xa8yIDLn55v+8BQZstDtXZoDvnJ5RtANom2klbY16GQTYnZ7mLQwyLICeQjK1z6iN1fuTa25W7SpQ/1y6iWQuu+6m2/Yj6U/6ZfEYuVuTdRwv33D/QjlCkoi5OxiYlBFWn0slqLl2EgV7PickNSdm93rY3pTHZFz/PMzRpXUMpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748332012; c=relaxed/simple;
	bh=UU7+oRb86zVwx+HEnFQvsgq6dEP8Udyba5tT6b19DPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iff0xoCOhyVitukVinvJqQekKESjsEAxvA/d4UVGJFo4SingYp+whmQa5kOJKWJkT9AqVxT4/ffrmaw2gFbQp2PQaMDxXQc9M7dlRJWxIwQJgejONgliR9zKqnQ7koxxa1iBiF5hCp6cpfTdym9ZvfGGmGjIH4UXd0215YhlW68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Im4qVtpx; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad5574b59c0so565921566b.2
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 00:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748332009; x=1748936809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kGjUxtNR3mJ/2u7hranrVFwikwHAbHm/cRFgPsL7dCQ=;
        b=Im4qVtpx+F4huEWmY0J0/WOS+oOH04KEMoGTiqfzBvF6fMNs9a/e0yXLwflVeV+tr3
         406rYR0ZGeWtWAtiIqKULbuE6m6CWECUEaIXvExkepk3DaK5015n7vKsmtcug40Zc8ke
         yBulrFiS1XB5zRlgoOZxJqKWfT4NX+En2PUQMgN1bMpdaK4a8gj4rtHUjuaVXNZ3NxlY
         qT28V5k6SRvBGZvcqpraYlHW+m622tvZmyEaNAUcmA9YHFRhIYS1ioi12yTrbAPKaYdt
         UdGo7cSPJ+fXLM5QaqThyxLTQLZfOqZkw4yFMIxUqgskVM2m1tHTpOX+gzjVVX1auloG
         Tz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748332009; x=1748936809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGjUxtNR3mJ/2u7hranrVFwikwHAbHm/cRFgPsL7dCQ=;
        b=UpOic4QCVM2cYCvkHxqRPKY/VuvbUEDEyDCkR0DWH14Hx3Q613xnh3TftRuiykTgTY
         xhAf8n4JHG9xR50DXLr4AxS954wwaxkjIX/XYpz0AQClqK9lDUUc8BTBlnejwens5UWK
         UsFSosYwqvOhHDjatxcYgxzmqweyd4bq02mFfOwb5jD8aO3oO5FDAd/8mRcp0TdLgrWH
         ofN98gYZNNBGNjheo9CWZ77/u+B5V+Tz5GhxGD+mLd1BL3eIKwlahK8zN5X1vpCuE3dE
         SoUc/xlTu9z5rtIwl4iWt4ZqIQswwTnuWV83HC5xuZuxt5FE1SG19PiRi+L1ZWleJTLQ
         sRRg==
X-Forwarded-Encrypted: i=1; AJvYcCUsIgei0wbm8MqGVI6oby5bn7H4gyOIb0MsdpSq12fo4yQ7ElYG9QLoZI71Dck7Td2Poiqj1BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXbOsmsv64Bez0oqonAPeDgHzP1Xcux4vn4pfM/EpnILpnEvZZ
	3wr9AL2m8dGYUgr5mFbuAdPfGQunG1VrTe7BISDLysn/pbD+7UgTD/2riY1EMZK3Ok0=
X-Gm-Gg: ASbGncvsI+Dk2AJR+4hnOow+wM54dv6V1NneKI8A+9/0tL8V41uwt8M23L67TMnELpF
	YufAQNHOVsZDBVfQP/pigewElupBQlHpkSwWzEtS5OOX03KZUn4b70523BZXRhAmcR2zwQvfEWb
	PLz0RBV10PdPt/XgPlx3ZTJbW2566HY2oqKux6NAg8j3ljmzRj7nPelrfVqdIgYC2yeP9rFlDJP
	fJgzTXxeCgomahMRbNwGcHEQsgkrT9eUc3j8+6RnSHAUsX9PaekItI6C83DMvaRbV/4cEfYkLyo
	awTMH5j8wTe5jECzKYsRsYoRl4w0PKjC1Y7xsKbKLxRx6a2mYX3Kq4/qWU7X1+eCDv3X8hv94pQ
	=
X-Google-Smtp-Source: AGHT+IEWcJvokDvwPgBmEe7nvuQpRK4D3ziJpdJh7OejYmQl2V009fIRSgH2jBGO0ZeLuhaFxXPszA==
X-Received: by 2002:a17:906:dc8a:b0:ad5:1bfd:30d2 with SMTP id a640c23a62f3a-ad85b2795f0mr1165498366b.55.1748332008808;
        Tue, 27 May 2025 00:46:48 -0700 (PDT)
Received: from localhost (hf94.n1.ips.mtn.co.ug. [41.210.143.148])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad52d437585sm1789776266b.115.2025.05.27.00.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 00:46:48 -0700 (PDT)
Date: Tue, 27 May 2025 10:46:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Eugenia Emantayev <eugenia@mellanox.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Matan Barak <matanb@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net/mlx4_en: Prevent potential integer overflow
 calculating Hz
Message-ID: <aDVt5LZe-jo7mVxt@stanley.mountain>
References: <aDVS6vGV7N4UnqWS@stanley.mountain>
 <aDVqSjcpG3kvl-0g@b570aef45a5c>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDVqSjcpG3kvl-0g@b570aef45a5c>

On Tue, May 27, 2025 at 07:31:22AM +0000, Subbaraya Sundeep wrote:
> Hi,
> 
> On 2025-05-27 at 05:51:38, Dan Carpenter (dan.carpenter@linaro.org) wrote:
> > The "freq" variable is in terms of MHz and "max_val_cycles" is in terms
> > of Hz.  The fact that "max_val_cycles" is a u64 suggests that support
> > for high frequency is intended but the "freq_khz * 1000" would overflow
> > the u32 type if we went above 4GHz.  Use unsigned long type for the
> > mutliplication to prevent that.
> > 
> > Fixes: 31c128b66e5b ("net/mlx4_en: Choose time-stamping shift value according to HW frequency")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/net/ethernet/mellanox/mlx4/en_clock.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
> > index cd754cd76bde..7abd6a7c9ebe 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
> > @@ -249,7 +249,7 @@ static const struct ptp_clock_info mlx4_en_ptp_clock_info = {
> >  static u32 freq_to_shift(u16 freq)
> >  {
> >  	u32 freq_khz = freq * 1000;
> > -	u64 max_val_cycles = freq_khz * 1000 * MLX4_EN_WRAP_AROUND_SEC;
> > +	u64 max_val_cycles = freq_khz * 1000UL * MLX4_EN_WRAP_AROUND_SEC;
> 
> 1000ULL would be better then.

Yeah, that's true.

regards,
dan carpenter


