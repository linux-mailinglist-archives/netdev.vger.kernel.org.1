Return-Path: <netdev+bounces-125189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9217696C326
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22462821FA
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B34A1E0B95;
	Wed,  4 Sep 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7PUDo17"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808761DFE09;
	Wed,  4 Sep 2024 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465347; cv=none; b=gKYYQf6m5vPUejTtvLCh65GWKeVXZMmZE2ItCKM0Q0eTH2izpUPhFIgSRpn5QnSn83IS1jLt2hZqzm0zinDBpEnAy5F+bsxzOxjLHucdfUD/Xh4XuuBAUkh3K54yggs89Wbl2i52BV/3dVgVeMiglDfXjSSy4vgZaouUuswIClk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465347; c=relaxed/simple;
	bh=lIG/n4AM39XI7CI5teW4ait/YVli6BRNl+UM17EkjSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CecUlxz4QFRUb4G59biLzsEvoUEQOLblKSd+y2O5YGvQLbfKYWvM/3o/bnSv8XsJUNDyceELg+WNa5USSN2EofOIqyMQmWipMThpogZgCtBehW+TTfBRXuNJ9XoKfnbQBeeqJ/DSoH6TAesX/RUhix0YwzBdYZLE5zXvwbMHbRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7PUDo17; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c24648e280so610430a12.0;
        Wed, 04 Sep 2024 08:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725465344; x=1726070144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mcX2cY1Y9Cg1FIm24tTfwc/xlRibf5mFH2JL1I2kqCI=;
        b=h7PUDo17wfZgqb8EqGSTWfz0zCg2w0zHHgAAyspW3jA3G4VCVqQvEVOTdAIsxgCuKA
         35N14dqhIFfqdEmjlsxg0DVq8bSp2cc62CLTnrBmwYWIxcFmxhA/YCbh5zE/bqvnqqfv
         sX5S530g6Zs8IibLcR5Qg6l2eMBjBT4XAJ7eZJYplXH7bJXQ1+tOCKFH0E5GItH9Kprd
         3/W7x3uuifjEw/zdKhieWeP6RgAKYJRrRBC3VqKjn0l4ckTJcjTLXKxWmLN0f2uqKS1b
         dqUxQBK8CaB9IP8ItTcgBB7F8MsIpXFd0V6uGBiyJrNLqaQPNPfNbgwXiBucRv5Rl93m
         mXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725465344; x=1726070144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcX2cY1Y9Cg1FIm24tTfwc/xlRibf5mFH2JL1I2kqCI=;
        b=IoytqYTySEzsqwcI3GiWul+Gv3Ffv6Vmn8ajozO1kz6At/GphhRKez3UcK655mT2cg
         jxxI785IV2avA0HKBIGPnIgCfsssu8yRZY6siLtcEZyNPBGZr7dU95r460fYRWpPa1PQ
         ivXIuywcP1mYe8fdZPdFh10xUnBaipldrGSOdZQIVvgdA+PEEps2RfDP0KCFweT9s7Gl
         aSISTKcGU6bDafKRrj6GS1JlQYRVSscN3yOPs8XcNpRsEZcDqtYtPs64F26WgpAP4VlX
         chH27nqxA8RONpR5f67ydVk6GE424NJLCZs6WuAUQkr2xwG2CgZK1BEdbbugfcqF5To2
         lQlA==
X-Forwarded-Encrypted: i=1; AJvYcCUIhstd0JVV0uhfuRamsQ47wP8j/gd7/AWRv1AJd44Vh0SNf8aD2jqdN+0kqLSPW+5nrr9xbgTU@vger.kernel.org, AJvYcCUf3bHEk7EeykvLTWWFPJ0yoTKLwTFnsukhRhzKLlHPESE66PNKbuxQtk9A2xnwQQqU5TcOENa493Y46Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqO0XN0ObvBaw7E3/hGPDZG5h+VJEG1o480lXLR1O/Xs4DjmJm
	fZL7FT+giou7Uu2qgEBZVaWcaEA+kuzDC4JXdmo7Gt3yZNRqkTRfaTJ5lF3OPp4=
X-Google-Smtp-Source: AGHT+IHCCHjeecVUu2mfuw+SZXICoUrUnjll4WII6neWRV8Wc3f3RmXhAL6+xuBDckdLKsiyVJeqRg==
X-Received: by 2002:a17:907:c21:b0:a7a:9d1e:3b28 with SMTP id a640c23a62f3a-a89a377d761mr766072866b.5.1725465343025;
        Wed, 04 Sep 2024 08:55:43 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236d16fsm7662166b.99.2024.09.04.08.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:55:42 -0700 (PDT)
Date: Wed, 4 Sep 2024 18:55:39 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, xfr@outlook.com
Subject: Re: [PATCH net-next v7 6/7] net: stmmac: support fp parameter of
 tc-taprio
Message-ID: <20240904155539.mh5crdw7xqudkjur@skbuf>
References: <cover.1725441317.git.0x1207@gmail.com>
 <cover.1725441317.git.0x1207@gmail.com>
 <3bf0857f46b15980e60f3ec71acd0f80452863e4.1725441317.git.0x1207@gmail.com>
 <3bf0857f46b15980e60f3ec71acd0f80452863e4.1725441317.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bf0857f46b15980e60f3ec71acd0f80452863e4.1725441317.git.0x1207@gmail.com>
 <3bf0857f46b15980e60f3ec71acd0f80452863e4.1725441317.git.0x1207@gmail.com>

On Wed, Sep 04, 2024 at 05:21:21PM +0800, Furong Xu wrote:
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 23 +++++++------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 9ec2e6ab81aa..2bdb22e175bc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -931,9 +931,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  			       struct tc_taprio_qopt_offload *qopt)
>  {
>  	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
> +	struct netlink_ext_ack *extack = qopt->mqprio.extack;
>  	struct timespec64 time, current_time, qopt_time;
>  	ktime_t current_time_ns;
> -	bool fpe = false;
>  	int i, ret = 0;
>  	u64 ctr;
>  
> @@ -1018,16 +1018,12 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  
>  		switch (qopt->entries[i].command) {
>  		case TC_TAPRIO_CMD_SET_GATES:
> -			if (fpe)
> -				return -EINVAL;
>  			break;
>  		case TC_TAPRIO_CMD_SET_AND_HOLD:
>  			gates |= BIT(0);
> -			fpe = true;
>  			break;
>  		case TC_TAPRIO_CMD_SET_AND_RELEASE:
>  			gates &= ~BIT(0);
> -			fpe = true;
>  			break;
>  		default:
>  			return -EOPNOTSUPP;
> @@ -1058,11 +1054,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  
>  	tc_taprio_map_maxsdu_txq(priv, qopt);
>  
> -	if (fpe && !priv->dma_cap.fpesel) {
> -		mutex_unlock(&priv->est_lock);
> -		return -EOPNOTSUPP;
> -	}
> -
>  	ret = stmmac_est_configure(priv, priv, priv->est,
>  				   priv->plat->clk_ptp_rate);
>  	mutex_unlock(&priv->est_lock);
> @@ -1071,6 +1062,11 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  		goto disable;
>  	}
>  
> +	ret = stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
> +					      qopt->mqprio.preemptible_tcs);
> +	if (ret)
> +		goto disable;
> +

Doesn't this break taprio for those callers of tc_setup_taprio() which
do not implement fpe_map_preemption_class(), but at least want taprio
without FPE nonetheless? As in the earlier mqprio patch, they will
return -EINVAL here.

Through code inspection, those users are:
- All users of .tc = dwxgmac_tc_ops: they have .mac = &dwxlgmac2_ops or
  .mac = &dwxgmac210_ops, neither of which implements fpe_map_preemption_class().
- The users of .tc = &dwmac510_tc_ops which have .mac = &dwmac4_ops.
  Again, this does not implement .fpe_map_preemption_class().

I can only rely on code inspection, because I don't know what is the
priv->dma_cap.estsel value that the above cores were synthesized with.
Thus, I don't know if we break a feature which was available before, or
one that was already unavailable.

My suggestion is similar: allow mqprio.preemptible_tcs to go to non-zero
only if fpe_map_preemption_class() is implemented. Then, program it with
any value (including 0) only if fpe_map_preemption_class() is implemented.

>  	netdev_info(priv->dev, "configured EST\n");
>  
>  	return 0;

