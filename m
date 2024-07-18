Return-Path: <netdev+bounces-112067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0118934CB3
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD06282355
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 11:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D0313B290;
	Thu, 18 Jul 2024 11:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtDpmt9g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9511613AA5D
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302936; cv=none; b=BDhBffXyqx6BIo2PQ8tQ3mvYSOjPt9VwdT7oK+fJTAAoQJekLGyAjQpS+fs/vp6nyumhmbiUtlxrQOH8ClvObrB9bHHOACuyQaVgR6hLo238OrJnf5Md81nxw0kCWkNU+NPuPbL5cBNnPGk7SoXhDVhVHHaiarDAOaIisIxOUhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302936; c=relaxed/simple;
	bh=CsIFKIoJ1YXjLfjqH25F/Qkf3TrIyFju1ckYHXCgzRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNE+x/VPS4uAiHaFnL5KjkRZqPouSh3HgNGx1cZ8vOqPmmt5s/PwxqhryTBw009c+n9tjvcy/pk44O0uM8iIaN2rEo9C3Uyzuh2G24c3Kiwk0X6135BnWTp6QUdwM+Y2XqZbFGvtC2E7F5AqUU73a8F+vl9rNMo4daptkEQD2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtDpmt9g; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fbe6f83957so5965445ad.3
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 04:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721302935; x=1721907735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d5giLIeA4gpo30H9KTLyGjvgYTIAiZMRZo24oZaVWMk=;
        b=VtDpmt9gKsZf6XqHWDYCvgsEOLZUz5P7OV2wDeesemwXyFEwUUB3G2nzJweiIL993d
         Bz7elJjB8+E78lymJNh6nKgV52fNy6zidwcODBXxWZ6oXX0JoL3RsSfVwGTRCar5U0oV
         EmNNCPncufxax0aJViIgKqObv+jmUsJqgH6ygXiP7LUeUq13n2egKWKlsz60XZBZOd9/
         0d6UzP6qOSHrRIZvXZhxnBtdMRfpVev6ohbe+y7Ik7BIM5HfaDgZb9ojA6GrFMlI0jY/
         rxbfiiuD+S24h5RUYijoLqtqRZd2ApWlzaDgPRVltGRKb1oqkFDVuUESR0Xux3AFqH86
         a4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721302935; x=1721907735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5giLIeA4gpo30H9KTLyGjvgYTIAiZMRZo24oZaVWMk=;
        b=w3UyqDStihJTzB+R0zzzKERvckQkkeiOJ00hWX68//1Se5jddyf1gH6TH9w5ibI+Dq
         oD9bpmVSyxcPqW6Wov9QVMxgtPAvbKDgg4UIEs4s1WjdjzY9Bm+Ion2Rw40nrQSQejBU
         c+yy+r2l8BeXN9z4cBRaraQjGd1zyyjPPRVEqnlG3gs2BcX4DJKw/aFyBq3CxMe3vXZ2
         7iGpdS9hN96EWJuR7d4SfPAJWoWU9UVQ1FtYPOUNna1ru3IAU/PF7LHm9cnTEWM+grz3
         O16lFJWzVXXKQjeAjW2yERo2+ZnLaJyBKh/h70Pb3iZ5g07IxFo1PGuYtijPsGGNjHCZ
         3yzg==
X-Forwarded-Encrypted: i=1; AJvYcCVC7qLKaCo+atchPqs5OPwlvl6A8vwNZQaQW08ZD7FCShZTr8pATvk0kkSaqi6Ivz/AR6quWm2nNok9mKohgPCTNYEJ5MoL
X-Gm-Message-State: AOJu0YwROvP1Qt8Wlv0KvFsUVtlZiTDvm4ZgywEhYiZtZ/vA1omVHOMv
	0n0L6Wj8CGlgbqOGi3jEzpxOz3qD7y2Bq7qzc47Vl4pwFIRNr0i4+bo5gQ==
X-Google-Smtp-Source: AGHT+IFFPEUHNOYEgYduiwdvFiJ0R9h8+C6sfaguNEpiUrhQTgsCvi0fn22LWTIeppP7g11qgGBjbQ==
X-Received: by 2002:a17:902:e84b:b0:1fb:7978:6b1 with SMTP id d9443c01a7336-1fc4e14458bmr32590875ad.31.1721302934792;
        Thu, 18 Jul 2024 04:42:14 -0700 (PDT)
Received: from mobilestation ([176.15.242.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc27345sm91123145ad.121.2024.07.18.04.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:42:14 -0700 (PDT)
Date: Thu, 18 Jul 2024 14:42:07 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v14 08/14] net: stmmac: dwmac-loongson: Init ref
 and PTP clocks rate
Message-ID: <juzkq4to4e7mxol5rqh3sx3kd4vhmjvtjamdcbeeothuvogmhu@na3zltibi77w>
References: <cover.1720512634.git.siyanteng@loongson.cn>
 <ffa2a75c6a88325b8b3b81a1b70130e68c59f6cf.1720512634.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffa2a75c6a88325b8b3b81a1b70130e68c59f6cf.1720512634.git.siyanteng@loongson.cn>

On Tue, Jul 09, 2024 at 05:37:01PM +0800, Yanteng Si wrote:
> Reference and PTP clocks rate of the Loongson GMAC devices is 125MHz.
> (So is in the GNET devices which support is about to be added.) Set
> the respective plat_stmmacenet_data field up in accordance with that
> so to have the coalesce command and timestamping work correctly.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>

Note the maintainers may wish to get a clarification whether the patch
should be qualified as a fix and backported to the stable kernels. In
the later case the Fixes tag should be added with the commit hash
causing the problem.

Anyway. From my perspective the patch looks good. Thanks.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 9b2e4bdf7cc7..327275b28dc2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -35,6 +35,9 @@ static void loongson_default_data(struct plat_stmmacenet_data *plat)
>  	/* Disable RX queues routing by default */
>  	plat->rx_queues_cfg[0].pkt_route = 0x0;
>  
> +	plat->clk_ref_rate = 125000000;
> +	plat->clk_ptp_rate = 125000000;
> +
>  	/* Default to phy auto-detection */
>  	plat->phy_addr = -1;
>  
> -- 
> 2.31.4
> 

