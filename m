Return-Path: <netdev+bounces-108359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB759238E2
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01951F21C72
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 08:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B42614EC7F;
	Tue,  2 Jul 2024 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1p2epTo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749414A4ED
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 08:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909823; cv=none; b=Dx+4nuvhWv9UhZ2HShO7BK61zMYJYYEhdffH5gPfeif1KwFE9Xzi7pnLGRSkA6KGNlxfKWnRrRVknjwZ6VLM7cFzlO3Vc7AaGH7fwuZ9NDNCXkjUDsAUz/DKGUhVcPlm/e+CTBhSN0tuiJv7Elp24gCGqQcC0oU6eEugD4DOoyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909823; c=relaxed/simple;
	bh=2lGsLbD3/X0bbcV5T/UrCuuhOllMp5r3FRRNeq0XbHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqfzrfMB9xc2NRa0Mt2suQxW/RpP7JB08aUhDIlcHy62Ybv77kGYXUA/KNomnBJ7lIzkOK1KLRWVmThYPWRMCCyVGvy5sKI0XIn7itxV5fLe4y9Ir6HnsZyVVPkL/8i647kT963Qwp+b3QoPXb9Vb6YrrMok/EQqLZTEnz0SL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1p2epTo; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52e829086f3so3806391e87.3
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 01:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719909820; x=1720514620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzbQlfTsk2J+hyDVmnhmJepgjor2ee+VWH8cAdglbbc=;
        b=Q1p2epToduEXdQwGOxcasBD+RYWUVzK+FX4WX03u6/iNb2mM8U26SKLbq0JP0qISeh
         lKV9L1NkoI9XMb4N2Q5uNzJFkkLufH6bpWJtw/090pL14WANpbNZzFgav8NHesuF6kOJ
         eGhI/CJDlhoClRjtMMTvwsYoHL6JhJ7+l3aRrFz98Luzf/KYbou8lB1Y3mXMclmwE5nW
         ra28HsTIX6xd/S/T/0C4i7lfPGUu/YYael/z3/au/Bjn2o0Sfqkqe2NzyEb6izdykDyU
         IXMf5G/RKNdDamN7jl0/f3VrSC3Fh+PqdK2/8NvbZpvv7smSBhwO7w+dfwvakQBE/wev
         B71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719909820; x=1720514620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzbQlfTsk2J+hyDVmnhmJepgjor2ee+VWH8cAdglbbc=;
        b=enIJ7ueJRDY6zEp1S+1ak5sHRV+HDhlAYTlnb08qZZICYEb4QMQfUzhKCzjr8MNLeO
         gZTxQg7NpMbfIW5LNhQppvsn/VQHZl1hZ9ZzZef22hD8eEvTGrFWmomIUNIYxgI1mwCk
         CdaXunmuVU27y88z+iez7KFqNkOv4kQXV9q64euQTOxV9c8E01VqxSdFU6yCm2sFis1E
         XmZgTldjrxKbforjPVdIVqwfUGVx61VeY8U+E0L0YIL7O/yk8uQseUND4EVmNtzI0WAJ
         C/zoKOrsHJPjGrBwxKMgrMyHxncC8ABaARUIMDu7eReB0ufNr6T0TiZQ2kxXij7dv/H+
         1NPA==
X-Forwarded-Encrypted: i=1; AJvYcCXhcWAxkv68eSgnsF0/g7bdGqjlXGGG+y+ftrNilT3KWaLA7p8yg8YhKrTVpBYPz+we79hzZjvJpWMPiXT9EQBMwojl8IPo
X-Gm-Message-State: AOJu0Yzt6O6Nnm9teqOQ6Wua8seAJUFur3ui8ZexOoDuhxSTS1iHRrfV
	dr2gVDdPSnzpjYPgRjWbWbP0t0d3cRKYbwLGXHZzsM+HThe1Tpw6
X-Google-Smtp-Source: AGHT+IGNeILGZxF2YJ00+pELedyUgNf85QeetQ6yPBiGAu3WdXM4elWoyDvV8xRpvlDuw4hQ6UD84g==
X-Received: by 2002:a05:6512:2809:b0:52e:7444:162e with SMTP id 2adb3069b0e04-52e826f75femr5429780e87.55.1719909819349;
        Tue, 02 Jul 2024 01:43:39 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab2f721sm1732443e87.238.2024.07.02.01.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 01:43:38 -0700 (PDT)
Date: Tue, 2 Jul 2024 11:43:36 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 08/15] net: stmmac: dwmac-loongson: Add
 phy_interface for Loongson GMAC
Message-ID: <s72su7rcpazqhvzumec6yiw25ickabmcvd4omcz35gyqjv7meo@hoqzgm7bpyfv>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <b6c038eb4daa00760a484692b192957d3ac574db.1716973237.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6c038eb4daa00760a484692b192957d3ac574db.1716973237.git.siyanteng@loongson.cn>

On Wed, May 29, 2024 at 06:19:47PM +0800, Yanteng Si wrote:
> The phy_interface of gmac is PHY_INTERFACE_MODE_RGMII_ID.

It's better to translate this to a normal sentence:
"PHY-interface of the Loongson GMAC device is RGMII with no internal
delays added to the data lines signal. So to comply with that let's
pre-initialize the platform-data field with the respective enum
constant."

-Serge(y)

> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index e725c59c6c98..0289956e274b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -49,6 +49,8 @@ static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
>  {
>  	loongson_default_data(plat);
>  
> +	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
> +
>  	return 0;
>  }
>  
> -- 
> 2.31.4
> 

