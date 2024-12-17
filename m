Return-Path: <netdev+bounces-152610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F62F9F4D16
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD0E188E94E
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5DE1F3D5C;
	Tue, 17 Dec 2024 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYRbXIOv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BE91F4E50
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444316; cv=none; b=jNh7Fo0Due1d6il9FPQ/+tO03PiltusCzwrkKwwFRLhIdeN5gXqIXiIF2BwDN6wkh5skOln4oETYjyYrcBhBgs47T6ZAb7dGIbKP5RF+D1h/2w5w8ouoSQ5GXMYXpBhBxbFqlA4UTNMr+DHgVmopH4AWzPvkn60Kr+fNEwCjNhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444316; c=relaxed/simple;
	bh=4fYN+B0Xl27tnYNHbL/YXbaC2Civ92bOxl5DBR2nRJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPQIlKCQYLTEHGRAfoM01wLrxzX8YgQH79FQJyTs06LN1Ehp4o6pE9rG12m34cmvuP3bL6kYk0Y+nf4GGoQGtOW9wh6/x1S7PgAemZpbI/wPOd5Qms84FG7yy8so/qJFEiPs/0WGdsIAbpzbTo5Ay7YJ8EBjimZ3K6JFSwk1CBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZYRbXIOv; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso8472995a12.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 06:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734444312; x=1735049112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zp7cHqi/Pt41mzvsdCOmjWae9Nstzg8G0tVJY7fkuD4=;
        b=ZYRbXIOvkaM2azmgWDTyByf1zAJ2eDCAdVa27GyOMtc5TPpwl4F5nnG+D1Mm0CqSMq
         gSHxE0xRElEcsPXnRes4mff8hb6WjVFbv7++hRpYDcqf/l9hDw8NaUkQqoe+11/m+1FZ
         QcIw8/cqxppR9ovI0hCoypo//wtAN6EfMSUtj+9RBkipFwYqRhkVn64ZHySjFyfWG3dE
         +dglpV6iW1vep3IRRma3Fdy3hVFNVwOeal3ZgpmKfKSHNYynfa2Ok/+Zq6wu/o+K/wQq
         eRHTklaSuvCdr783d97PSCPIm8HrlywFZkaxd3ai82B47A0jEAdTJ2KnoEGKyP6sWPOB
         dcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734444312; x=1735049112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zp7cHqi/Pt41mzvsdCOmjWae9Nstzg8G0tVJY7fkuD4=;
        b=JyeoaDR+ignmUGVzAziPbMN68w+jrH0IFUpSrk0C6YtK9QDvPvwj87qO/7YhqS0Y9s
         gkGD3Of8XQhjiOTmxlqMeeJnkh95vzCsQyDGaWguu3Wtqy3SbLQ5r/uSdwC6BiUAs9ie
         IodA983nAuD8vnT7o26mPKdeEHwlxEy8ePXv0SwKkVH1v91NNtHQdhJuTWVoAtNHoY7z
         M2j16EjuUqWqZvTwFpbVukb0d2FVTLVdMDOBMFUDnejR98d2+qflM3G1Wdy/VPrTL/31
         3u/Bi+ZFne1OodU5ik40ZJHHerrWViEpZzDVXv1qgdlSQNBtg3vRuiZOLyqdc5wa7kJX
         maxA==
X-Forwarded-Encrypted: i=1; AJvYcCXe3G/0kZqUIqJ09FDVIBRlwBsRIqDS03PY0bJcK2xyKfGxpc7UfXIQfKda6uzh6Ywbt6wF96c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU7bh9i42w6SkSi9oJa8BexkYp3M3G/BN1Lup9gDMuQw2kUGVH
	JKo48Vwdnu2+QlaN6IpF2AKV7/Ha1Z3sS/AXgMR4hC+rmwHQocWj2jM86aYuaVw=
X-Gm-Gg: ASbGnctSR5dnoyyZvxyQdKZO2BfTwNjbn7q7ctZymiPdcsyxia/UXqeLJquQK39b9al
	YTBVsBCtMzUDqX37ORDJacdpqy+1UJ70H4EzBK/a8QC/QYQ30hPIRc1OOOVa+w+rTGZgSgz5VJ5
	ydhR72iEda91zKGeuVavHImhdOA/XJK3L79fPfjfll4i1hlLntoYpbHetvOPxvRvvQISfVVyh4e
	sN01XG3WGRB1IDEHFVk9rebz4E5MwbSpJ9yBBhkAvzaJnvMf4kTcFsuyOVZ5w==
X-Google-Smtp-Source: AGHT+IEKKZ3RAtfM0C7C07ICN+hYr0v5iMJA45zIGgO6iUmPYu35D+j/lTqb3mz7m1U364RyeulNEw==
X-Received: by 2002:a05:6402:1914:b0:5d0:d91d:c195 with SMTP id 4fb4d7f45d1cf-5d63c42dd88mr14094574a12.32.1734444312497;
        Tue, 17 Dec 2024 06:05:12 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ae124asm4301863a12.40.2024.12.17.06.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 06:05:12 -0800 (PST)
Date: Tue, 17 Dec 2024 17:05:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: sebastian.hesselbarth@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2] net: mv643xx_eth: fix an OF node reference leak
Message-ID: <d507355d-64b9-4aab-9614-de7339118412@stanley.mountain>
References: <20241216042247.492287-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216042247.492287-1-joe@pf.is.s.u-tokyo.ac.jp>

On Mon, Dec 16, 2024 at 01:22:47PM +0900, Joe Hattori wrote:
> Current implementation of mv643xx_eth_shared_of_add_port() calls
> of_parse_phandle(), but does not release the refcount on error. Call
> of_node_put() in the error path and in mv643xx_eth_shared_of_remove().
> 
> This bug was found by an experimental static analysis tool that I am
> developing.
> 
> Fixes: 76723bca2802 ("net: mv643xx_eth: add DT parsing support")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
> Changes in v2:
> - Insert a null check before accessing the platform data.
> ---
>  drivers/net/ethernet/marvell/mv643xx_eth.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
> index a06048719e84..917ff7bd43d4 100644
> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
> @@ -2705,8 +2705,12 @@ static struct platform_device *port_platdev[3];
>  static void mv643xx_eth_shared_of_remove(void)
>  {
>  	int n;
> +	struct mv643xx_eth_platform_data *pd;
>  
>  	for (n = 0; n < 3; n++) {
> +		pd = dev_get_platdata(&port_platdev[n]->dev);

You need another NULL check here.  port_platdev[n] can be NULL so
&port_platdev[n]->dev is NULL + 16.  The call to dev_get_platdata()
will crash.

> +		if (pd)
> +			of_node_put(pd->phy_node);
>  		platform_device_del(port_platdev[n]);
>  		port_platdev[n] = NULL;
>  	}

regards,
dan carpenter


