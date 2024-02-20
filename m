Return-Path: <netdev+bounces-73227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A944585B72F
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 10:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABEC1F25EF3
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 09:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CDA5F477;
	Tue, 20 Feb 2024 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewe15Khs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F785DF2B
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420864; cv=none; b=UBXZUFIUnbYTTDfiGndjwxRsnukNQyft7P6ZaBIZyQqMIj2EMH8WO2k0aTKGoEHMbbUME87lvYVXn8bbhYD5UVxj5IPQi7ymoRKed5NAW4qEWZNcISUN1xQ7s5fd05auskrriJ3HMWp6jH6FZr3yosf2hItBm/6ngNx1M1dpwco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420864; c=relaxed/simple;
	bh=y1I4lTWwMTia1vum2loHj23cfAeVFH7AFIJDi2XeCcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhyJCIm6qaud68ZlFkVozEDFk3RBs0ujRiANqC/w+hsiYzSVAcvL0YWa9RJ4wxZTZWRrbzDhxfWDzi2T0Gr1mYIkQL5BM8g+y82/RZhsFRAIx/PBdTHra1fh3axtJArfoy23RVpk5tG5jboBtubMe+75byYhBrTnQ5azhHnfKLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewe15Khs; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512c4442095so585355e87.2
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 01:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708420861; x=1709025661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fdhB/OebAUjm/AFv0XF6TY7b9nkZEns3B+QEhrz2u2s=;
        b=ewe15Khs0WgdPKvCv04FslogBOrRftG9nHjvtKSRNUL6+BZu9v8zYgOzhFRTw/moJ8
         oDsVew0onkgYmfVDOyPN/FWkxCSz2tpLbqKwVGNQ3A4tojuC9w+2EQAZ0UMULZK8kInR
         aAxtL0urDuHp+nh4f3aZDDNSHHRANsU2PN/OF7ZWtpGAXIENqysc2j4qY+AAV4avxyGH
         7OQgAtybHFCebKx2LUmgwjed6c3NLVQ7rmUfaBY94xyWH2IaghWfpTgJh/pRquhRC7Q+
         /WqsYPBHxN3eRzu5A9+dL0eV3kpeE4v6erhbtLHBUYuwPJ+vcsiCGRm9/MUiiiUxYKe6
         BhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708420861; x=1709025661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdhB/OebAUjm/AFv0XF6TY7b9nkZEns3B+QEhrz2u2s=;
        b=J//olePwLkSIbAkNWrS+Ba19jAf+cDnzxoYfD4qJ9jOu846SJmRb4OMcJTBAlx9wz+
         V8W85mvTBu3GBNJwdEjOjvu7MjQXc96fihcrSfbTtymGyKfMDGX7ttwj9UIO2fiMUyAH
         eSZCWsbBLZMdwjc77bKvAt3Js222HBzp2B20GnDXUo3RGcluhZMV9/AS5wrk/BEovVR4
         rsWO8PXkpilo1VOOsKsl3eEfCGiuJnAAmW4L9QGsZqqJl79qowyyACd4ep5T45dHVOVn
         nuN11f1eWDiaKsbQDB5aj4ysBoEi3UQlUk7EPE2NMI8YeOdOwjB8p7ZJxDlvyLw7fnnY
         UNZg==
X-Forwarded-Encrypted: i=1; AJvYcCXCQyhKw05GkZbRL1A3Ow4vnxgFTp9u3pA0IvQy99Ursdr2tIRC7qEhnOnnLBx0j3rvL8tvsayI2RUXLo9lwYLA4Cx0UW4E
X-Gm-Message-State: AOJu0YzGUbLONXyDnlUz0798PmpCS1+pBXAM8N36FvPQmnvXu8OkcwIW
	JIXom4ZHb71Omc6449Livvh7XgvFUSfkEAvcju5DuN9sXZGejbciBbQEdSqV
X-Google-Smtp-Source: AGHT+IFENXQ2/kIvaynag/3ye0EYbZr1RqBX2LzSkz1tqwcz87hMFLb+HYFe/A4uzUmPS1D8iGWrkA==
X-Received: by 2002:a19:655d:0:b0:512:ab03:f4 with SMTP id c29-20020a19655d000000b00512ab0300f4mr4763035lfj.37.1708420860434;
        Tue, 20 Feb 2024 01:21:00 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id x28-20020ac25ddc000000b00512a3f5322fsm1151146lfq.8.2024.02.20.01.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:21:00 -0800 (PST)
Date: Tue, 20 Feb 2024 12:20:56 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rohan G Thomas <rohan.g.thomas@intel.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: Fix EST offset for dwmac 5.10
Message-ID: <mmjrlyzhegve5u3s3lhw4hmhooxixn3pwxkkdikxgxno4teqyz@rtetljwg6ffg>
References: <20240220-stmmac_est-v1-1-c41f9ae2e7b7@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-stmmac_est-v1-1-c41f9ae2e7b7@linutronix.de>

Hi Kurt

On Tue, Feb 20, 2024 at 09:22:46AM +0100, Kurt Kanzenbach wrote:
> Fix EST offset for dwmac 5.10.
> 
> Currently configuring Qbv doesn't work as expected. The schedule is
> configured, but never confirmed:
> 
> |[  128.250219] imx-dwmac 428a0000.ethernet eth1: configured EST
> 
> The reason seems to be the refactoring of the EST code which set the wrong
> EST offset for the dwmac 5.10. After fixing this it works as before:
> 
> |[  106.359577] imx-dwmac 428a0000.ethernet eth1: configured EST
> |[  128.430715] imx-dwmac 428a0000.ethernet eth1: EST: SWOL has been switched
> 
> Tested on imx93.
> 
> Fixes: c3f3b97238f6 ("net: stmmac: Refactor EST implementation")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  drivers/net/ethernet/stmicro/stmmac/hwif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> index 1bd34b2a47e8..29367105df54 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> @@ -224,7 +224,7 @@ static const struct stmmac_hwif_entry {
>  		.regs = {
>  			.ptp_off = PTP_GMAC4_OFFSET,
>  			.mmc_off = MMC_GMAC4_OFFSET,
> -			.est_off = EST_XGMAC_OFFSET,
> +			.est_off = EST_GMAC4_OFFSET,

Unfortunate c&p typo indeed. Thanks for fixing it!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

>  		},
>  		.desc = &dwmac4_desc_ops,
>  		.dma = &dwmac410_dma_ops,
> 
> ---
> base-commit: 40b9385dd8e6a0515e1c9cd06a277483556b7286
> change-id: 20240220-stmmac_est-ea6884f9ba3c
> 
> Best regards,
> -- 
> Kurt Kanzenbach <kurt@linutronix.de>
> 
> 

