Return-Path: <netdev+bounces-196966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF0AAD72A2
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D071C2698C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787AF241686;
	Thu, 12 Jun 2025 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="JCJMTve4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B6B1BC2A
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749735783; cv=none; b=IeG1dVehlrBf8Ep+DjKOyhmn3xolbrviZtcQpEWJVVSwADSeB0X2bomTKYW4A7n0yvRrvPEA7HGsTagfLUFocJW1EnXBg+N2mSVTvvlydUsV0LNUzm3cixF823PsNXP6a3D7w0u/Vt/qMQlU/0zk7jUUHSVxzKYCihJH4W3fR+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749735783; c=relaxed/simple;
	bh=HRpqT7CJV7R2st3zI4o7FNVJez0Nudlxgr5nBNYBoBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdVQohUsrSmZ5auaS73WBG/PczX3442nLUGdflbs9gWBmF9Yl1743qBVK/NXK8Aac71LTWJJn42b5e4sJRuA/Y34xR1Oy8ybzAhIng65AgSX4Gnk7c775swFonL4HpWrccJI2pOxyhNIvb6/gJ/l7k4sHJKvfm89mneca5pljno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=JCJMTve4; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso631116f8f.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 06:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749735780; x=1750340580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RevJ/gQJI0kAeinOh0Aa3oPwiioNpsblb8GshgA5Dxc=;
        b=JCJMTve4YZC6+meQzgDEurJ9Htnxxx3huFAicKrwiR6GuL5oC18mLYu+DNhtk8hNmT
         JyWqlY/iQvJ9v0b6RZnevkOw9iRYn+IAwzKX2xX7TF7YfGYzbD9u8pf80Al77ZyL+etu
         xiCyPU+C1u2qOmUXZc6FMXSJmWut+/jmjeyNExYFm54e0jGHOH8VDF9eHuEQV6uyR6jq
         ZGX5JFEj9ZcuE+uAoh4OUicSqwsVzdKaYGFw70VKFphfbu+H7uSrufLSWTQvWryzkdQs
         HeI2+/I0lJ222k+ACTIWvIvga7dCC+hK/wihIOT3r3bu+glW1OVWdxTTdLgDgAaXZsyc
         /zRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749735780; x=1750340580;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RevJ/gQJI0kAeinOh0Aa3oPwiioNpsblb8GshgA5Dxc=;
        b=M6lKVRzaasmUsW6ToVgOOEg+asUQKO+o7iS8tVyLZXsLe7Rk5HUm4oEfTrcCsm1NGg
         +JgUisenGQi2Vmt6VK4Vr8StdaSXmMXKVpUBvtjmpP78HxvCfBPuzLqw2wv1toa8Gb02
         eB4V3W/0yTc1iszsFKCbJzFcbLzt6ynhRJPp7I2DGXHWGXSLj/caYiVF03cuD32mv9Io
         jNt3ZqNtCPZ2ztHOFpv/j0DQw5uVFTbXljBJfNuo1GvSq2clWrsfyVwzbWB3V06C9opO
         LOp6evm2XOBqsJdX1/Ltm5YDXH4lTDENidmI1LeME/Ifveny1vd3hEybWWr1jQ66p3M+
         Z+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7som2x9D5MrqQuGbSnQZJ9RYXRL1U39uJ5TJXV0NjaKv8wsPMmZxCWnDEvT68onlWuOMoVVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzM/VdyZwmGbcBwR+7FAT3aw2wpNY+/ZHUSNTOnwoY2bNR5+tU
	kCrMIY6kRXE+g9spWIHjulQ2KM/IJplumZub3RbYt+ionXRCud72hSsLVfC1xfGZzDzCg/wOxKF
	JaJnauHc=
X-Gm-Gg: ASbGncvGGumr1w0nq97RMxSl1d2SiJmXHdG3jIzSW2X2KzDvQFc7Z0DbF9rsAUYa6BT
	CgV4yDPHBT8bSeaW3hzy/XpgksHVNA32L4pxiUv7B59gbt16MsLI3tjDc9YpNeh08IWSCi2blOM
	jaPFE4u4bVeAkNT26ivVvLP3pFienb1Xco+dmWM3gHGJMSX9UviyagE/AODNs6YtmVfaH1KtrQd
	+PiRh7Uj580/zp0tiprPk7x7Ndr68w9I4K+koYDcqsyu2viHSFpc8D74BFzt+DavRr9qi8SJZPP
	0IBRYYEQdD6Jxi/s/K6r+qKVeHmmJVBrwbt8DBgEuuXM5GGx5cJE15uKTmlBVKnlzlK3h4zHirW
	UWg==
X-Google-Smtp-Source: AGHT+IEuZZtThnI3hRXhwGPGYckc2m1iLnp3XfZhUwE/EycL2TcAHPJ73SFA2Bwg27KVkfdd3IkJrA==
X-Received: by 2002:a05:6000:4305:b0:3a5:1266:3e96 with SMTP id ffacd0b85a97d-3a558695737mr6259408f8f.15.1749735779860;
        Thu, 12 Jun 2025 06:42:59 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a56199a02csm2063211f8f.34.2025.06.12.06.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 06:42:59 -0700 (PDT)
Date: Thu, 12 Jun 2025 16:42:56 +0300
From: Joe Damato <joe@dama.to>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, brett.creeley@amd.com
Subject: Re: [PATCH net-next 2/3] ionic: clean dbpage in de-init
Message-ID: <aErZYDQsHPbvfpqZ@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Shannon Nelson <shannon.nelson@amd.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, brett.creeley@amd.com
References: <20250609214644.64851-1-shannon.nelson@amd.com>
 <20250609214644.64851-3-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609214644.64851-3-shannon.nelson@amd.com>

On Mon, Jun 09, 2025 at 02:46:43PM -0700, Shannon Nelson wrote:
> Since the kern_dbpage gets set up in ionic_lif_init() and that
> function's error path will clean it if needed, the kern_dbpage
> on teardown should be cleaned in ionic_lif_deinit(), not in
> ionic_lif_free().  As it is currently we get a double call
> to iounmap() on kern_dbpage if the PCI ionic fails setting up
> the lif.  One example of this is when firmware isn't responding
> to AdminQ requests and ionic's first AdminQ call fails to
> setup the NotifyQ.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/net/ethernet/pensando/ionic/ionic_lif.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 7707a9e53c43..48cb5d30b5f6 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -3526,10 +3526,6 @@ void ionic_lif_free(struct ionic_lif *lif)
>  	lif->info = NULL;
>  	lif->info_pa = 0;
>  
> -	/* unmap doorbell page */
> -	ionic_bus_unmap_dbpage(lif->ionic, lif->kern_dbpage);
> -	lif->kern_dbpage = NULL;
> -
>  	mutex_destroy(&lif->config_lock);
>  	mutex_destroy(&lif->queue_lock);
>  
> @@ -3555,6 +3551,9 @@ void ionic_lif_deinit(struct ionic_lif *lif)
>  	ionic_lif_qcq_deinit(lif, lif->notifyqcq);
>  	ionic_lif_qcq_deinit(lif, lif->adminqcq);
>  
> +	ionic_bus_unmap_dbpage(lif->ionic, lif->kern_dbpage);
> +	lif->kern_dbpage = NULL;
> +

Seems fine to me; my only minor nit that you can probably ignore is that the
code to unmap the page and set kern_dbpage to NULL is repeated, as you
mentioned, in ionic_lif_init's error path. Not sure if it's worth adding a
wrapper to avoid the repetition.

In either case:

Reviewed-by: Joe Damato <joe@dama.to>

