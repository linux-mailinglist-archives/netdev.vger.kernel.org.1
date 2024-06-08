Return-Path: <netdev+bounces-102007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6A7901151
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 13:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FF0281E01
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 11:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7933914B956;
	Sat,  8 Jun 2024 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSgZAd3J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04741CAA2;
	Sat,  8 Jun 2024 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717845389; cv=none; b=OfbdDBGzP+4KkzDSt3wpNnTVF9q3LMXRU7FOoTK/qI/g4PmUmBBtgkkEJb3dVz1ntRZInN0jZkFcN5wlJBXkic8TM18LNXMgBfIXnABqEcVB0COrHqZy4NLdSZPg2g5iPhCDxEZFUmLamnQ/KDJfBOOy8Z1Rz0wGL1gTvb6yhBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717845389; c=relaxed/simple;
	bh=jvizYpBh/846u79/ri9njeTMhe898iK4HlK2JzCGn6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icmQcjuKAO2AmjBp8MmhCQq51EyRrUMOtBSdN5ElQBPdyeY3VkxKwBOhdsyq1SUKlO+hdjrKyXA7idfs2VWtTrfQrpi7x4A+GqzNngB+y0uPw/YjVlSUxXa2qgLQedFUwCVeN1WZsX5zfdmeAFgtyzR/S132McLIZBkcKxZKzwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSgZAd3J; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a68ca4d6545so519310766b.0;
        Sat, 08 Jun 2024 04:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717845386; x=1718450186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PtXxKMBWiGQ1B2oZBxOrPQhSy0IwrF0BuuPyQk2cWyw=;
        b=HSgZAd3JFVVi9WTp0BU99BET/xnTCS0bHS+bwww958oBSbQQ883bNQHIfLDrDsu7QE
         VQUBjgXQsF3uE67QK7oivbKxdGvdaRuih8IX5RxZNujR3U/jySeqSTxZeCGvfAGaAT8v
         3syUPyj22VFh5hIhc0v0A67oAqnpPgiaZka5GmXJuZpKX2th9lTe+eYuoxEZu//7H84x
         pq2qFbDOeO5D7S7yZ7jAZ4yBzf0JqPEjM8torHA3g8lZm39a2jX1A35RUo36yy0UjiNj
         sQQw37y62kcahcFur4ksQTJLow0GMEEdJTrMPAjc4NF9GKcgM6J4AXVeF9tkLtKkfLk1
         L1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717845386; x=1718450186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtXxKMBWiGQ1B2oZBxOrPQhSy0IwrF0BuuPyQk2cWyw=;
        b=DTDaHpdywa+5Yvzn0lhIetwlVPNAmQL5Na1S6NsptyKTzErvf5xpbRdwwp/dOe2u8I
         7cn5SnBgrzsozoawsbH5PsKNcshVv1kDxBOiuIdyJVRVpzNgWfOOGStWJiGplQjrjmlT
         ZpqEVk6LDAEY08M/UVlaGEhLkYmAQh6bWJGdUcIBYgPZ+esNWPj3iFrRrt0sYKEm4FYk
         hcY1wCy7uPHTqL8Omh3jhOBfiyYdjGJKk15BUnRrq0wUKb2PC64B0bsI207fVq6QGTCA
         qc4iz0715uJi/TWtFHkta+GTk4koeKJ8r1n3VjHaLe/VW4tbycEYaY/4fG6AjIoyhV9+
         AfWw==
X-Forwarded-Encrypted: i=1; AJvYcCXfIC8kyt6tdW/8ygBESZ2eD7pzkJ/eHb4IYjB1zTUpooYdNqEqhLkDZTo7jwgjMkFITqU7sNQZzy+fE6DbQknLC2fX4nb6iniIrsx84Fj7e+TKOZScO7sWI77UnCjAUxrXbjJr
X-Gm-Message-State: AOJu0Yy1Tc0ARJC0HGsL2MyC2BTyieYTsDk5OwAd5VcNZPTIGATNkl2p
	VX7Cz0zlK8yXKl4sjdBEEoybPldZnifDdUKYehgC1zx6xE5OfCA+
X-Google-Smtp-Source: AGHT+IELhGMfpxFt70JA2lImQ9hXz89V1CMxUo0K9yLXNAygI/b4E25TAhfw7hwBUPVqr4qgvlH2TA==
X-Received: by 2002:a17:906:b897:b0:a6e:2c34:6c0e with SMTP id a640c23a62f3a-a6e2c717611mr287777666b.22.1717845385591;
        Sat, 08 Jun 2024 04:16:25 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806eaa4dsm370256066b.110.2024.06.08.04.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 04:16:24 -0700 (PDT)
Date: Sat, 8 Jun 2024 14:16:21 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	wojciech.drewek@intel.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net v4 PATCH] net: stmmac: replace priv->speed with the
 portTransmitRate from the tc-cbs parameters
Message-ID: <20240608111621.oasttwwkhsmpcl4y@skbuf>
References: <20240608044557.1380550-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608044557.1380550-1-xiaolei.wang@windriver.com>

On Sat, Jun 08, 2024 at 12:45:57PM +0800, Xiaolei Wang wrote:
> The current cbs parameter depends on speed after uplinking,
> which is not needed and will report a configuration error
> if the port is not initially connected. The UAPI exposed by
> tc-cbs requires userspace to recalculate the send slope anyway,
> because the formula depends on port_transmit_rate (see man tc-cbs),
> which is not an invariant from tc's perspective. Therefore, we
> use offload->sendslope and offload->idleslope to derive the
> original port_transmit_rate from the CBS formula.
> 
> Fixes: 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
> 
> Change log:
> 
> v1:
>     https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240528092010.439089-1-xiaolei.wang@windriver.com/
> v2:
>     Update CBS parameters when speed changes after linking up
>     https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240530061453.561708-1-xiaolei.wang@windriver.com/
> v3:
>     replace priv->speed with the  portTransmitRate from the tc-cbs parameters suggested by Vladimir Oltean
>     link: https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240607103327.438455-1-xiaolei.wang@windriver.com/
> v4:
>     Delete speed_div variable, delete redundant port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope; and update commit log
> 
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 20 +++++++------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 222540b55480..87af129a6a1d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -344,10 +344,11 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
>  {
>  	u32 tx_queues_count = priv->plat->tx_queues_to_use;
>  	u32 queue = qopt->queue;
> -	u32 ptr, speed_div;
> +	u32 ptr;
>  	u32 mode_to_use;
>  	u64 value;
>  	int ret;
> +	s64 port_transmit_rate_kbps;

The feedback that came along with Wojciech's review in v3 was to use
reverse Christmas tree (RCT) variable ordering. That means to sort
variable declarations from longest line to shortest. It is the de facto
coding style standard for kernel networking code.

pw-bot: changes-requested

