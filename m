Return-Path: <netdev+bounces-108925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 913759263F3
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32DF1C213F2
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0391EB48;
	Wed,  3 Jul 2024 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXbiaGxf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC12A17B401
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018565; cv=none; b=GuJFIylLqbUriKYtc3TAyDJeViaQeSND/UVDD4me8rLK0Fu0FZ5cyIstQXV1BdJDBGc+Cna9mRgOYNnmVLkt27RvY09xWPY4vg7BRo8FyEpcjfPfXuinaNrEhh1IF39hcHZsYEJg3hh30taBzgIgQxtBD3EZ9AF5T/zDR/MHL04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018565; c=relaxed/simple;
	bh=Dgdp5oTdgqKMpKLeLcUWKv7BNSJPyJRv/hMOP28evnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rU1TWtBpF3WEu5k9l6qzYrY3NzpNMQAzgcp6UBooS9AtXCQHOWol7FYbmlZqEP/F/V65kpJH/DaNZkqUXMNTnZiCYyI/fK+rZ1JaqS2JuoWP+kkdoxiajo9z81Uf2Hp6V7z2bdmM8YtJ6yFIabXH0lmUV0IQASySjWrq55c87V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXbiaGxf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52e976208f8so1061778e87.2
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720018562; x=1720623362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=St5NTLDJGESzNQt0He5IT9eM28Qr7L3335ywq/nA+bw=;
        b=TXbiaGxfoIiC1SMA0nwDm+LdmBvz0ZCueirchpXwBdDg2vJc+mcesLlPVtetFpq8gi
         1SXeTJa/cvF8Ic4ebpsicSAzVH+ohnJHBBmsXzjR6Gk7Lt9Huw18qbgq1xQ/gHp0MW93
         KEYAyrglbBp+bUpXtvP7dpBtH8MXtjC564rDUDvx64lmyDAfFBBHjTEzu3wzCJ0vZoNe
         6kyJErgrmpTC+qbvLK59UBlnlHyp0JB/evS7jwlJ8rW7m1zg1MbiTnv/qNmmrvsOc7nj
         1OzxZ/99TTCvdUPBSPZmGmvUyAN8hXx1KdzjSles7dAg8uEWoyswZ6VWzfvXvg/EMcyW
         HDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720018562; x=1720623362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=St5NTLDJGESzNQt0He5IT9eM28Qr7L3335ywq/nA+bw=;
        b=uJttbW2S08aF5+l/W/4X7yA9PmS4ehvzV9ESeMVGD1FY5Xq3vvZQgsSkeNQFFMcDBO
         tGHpBFWE33oSokbXFAGRbHYBv7A/iZQwyiU3DzkMyShDW4h5GtZSLkkSY4rxl2QoZA9h
         7/Tn7/mGFuHoHCFx/SOMK5zZpDN9e9XtyXvfZ9y851S7OIehIB4KdclXot6BpbdCpvn+
         sujo5yO1I4657QPlTODeINp1YWHLWc9yze+OV0Gs85amyDahpsqp+Q+Tejdz3aVGxZrg
         ZDfm2RFHoIH//+K5W/OfIZc60/P5J+OFIocQIBmxlkeK2oxFYR8REtbmkmTOhnEguTkx
         osmw==
X-Forwarded-Encrypted: i=1; AJvYcCV/XfUPbxPSbeJHTOUqU/iYQ521KdZ+GrQnRPzH/1+6/mS1G2GolDlcyoX4t863AK591o0+/jfFudwKCJBiIaZzU82dnP1P
X-Gm-Message-State: AOJu0YzPhsnWSU3CzW2lIQ9kBLVvEEz8eQiKKD/Q/O7G2MMhasQvhW7v
	Yv7NyuAlrTj0tGwD6xF3qZ6xFAkLl33VQAE8IOf1aNDxFzMy9va+
X-Google-Smtp-Source: AGHT+IGl1J9vb+WFtLo8hl7UjT0IkBNw1LW1SITgCFkNqJlXxUn2U7tVH2jbngo5o3iR6BPcIZm1pA==
X-Received: by 2002:a05:6512:3d29:b0:52c:dba6:b4c8 with SMTP id 2adb3069b0e04-52e8264da08mr11273998e87.13.1720018561740;
        Wed, 03 Jul 2024 07:56:01 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e979d2318sm252988e87.109.2024.07.03.07.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 07:56:01 -0700 (PDT)
Date: Wed, 3 Jul 2024 17:55:58 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Andrew Halaney <ahalaney@redhat.com>, "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: dwmac4: fix PCS duplex mode decode
Message-ID: <ydspunec7webewlnluxgms5egx2beg7buto3o4b3ugxmq2v6jo@mvsjflg4cnjx>
References: <E1sOz2O-00Gm9W-B7@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sOz2O-00Gm9W-B7@rmk-PC.armlinux.org.uk>

On Wed, Jul 03, 2024 at 01:24:40PM +0100, Russell King (Oracle) wrote:
> dwmac4 was decoding the duplex mode from the GMAC_PHYIF_CONTROL_STATUS
> register incorrectly, using GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK (value 1)
> rather than GMAC_PHYIF_CTRLSTATUS_LNKMOD (bit 16). Fix this.
> 
> Thanks to Abhishek Chauhan for providing a response on this issue.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Right. The PHYIF_CTRLSTATUS CSR has the link status bits defined
starting from 16-bit position. So the method has improperly detected
duplex mode. Bit zero is occupied with the TC-flag (transmit RGMII,
SMII, SGMII configs) which is never set and which means the method
always reported the half-duplex link mode.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> index b25774d69195..26d837554a2d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> @@ -791,7 +791,7 @@ static void dwmac4_phystatus(void __iomem *ioaddr, struct stmmac_extra_stats *x)
>  		else
>  			x->pcs_speed = SPEED_10;
>  
> -		x->pcs_duplex = (status & GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK);
> +		x->pcs_duplex = (status & GMAC_PHYIF_CTRLSTATUS_LNKMOD);
>  
>  		pr_info("Link is Up - %d/%s\n", (int)x->pcs_speed,
>  			x->pcs_duplex ? "Full" : "Half");
> -- 
> 2.30.2
> 

