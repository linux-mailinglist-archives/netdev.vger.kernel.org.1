Return-Path: <netdev+bounces-184775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F95BA97241
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 18:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9FD1B639A6
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6AE290BC7;
	Tue, 22 Apr 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gK0KhgRE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333719D071
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338426; cv=none; b=EqLW/7IDN+hrmd1CWpg7vTOXkMIS2ABZRsQ/WD5p7sY7HwyXbuSXDh0nxeWi9N1dbfhGGMeQ+0RCQaXdDywQkcZh05PnNkR+cgDNiT7sPDKsPsJLBsP35lIaj/J0JjE0cemvBIofYhr9HjGVdacX3MVEIu74Mk3LZ/j2EJuDxfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338426; c=relaxed/simple;
	bh=mUdjY0Z+ZK0iDG/VdNolX9e6qH1IDQD5bW7zDq6FdII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpJpvc0LbK0A4jpeSXc1BoSNsESuBPq3y8Miu/MHohr4hduB1O75J62EuloAsqPdRyRlGwGchxgumnmTYhRsarm6jSxvG3i5Snzp7aNF7MZWsdTfx87xQabsYgqHGmcdhmikGxROQzlDMTGXBHRJ6v6zcIysc2CxHZymVXDP8Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gK0KhgRE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22c3407a87aso80385975ad.3
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 09:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745338423; x=1745943223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kCJMTdTdGrMypkN6aePZhm/LPtstu8ev5ubEzZyTVWw=;
        b=gK0KhgRE0dcn6eJbud8AdjQIkomdGOGprOauLq1OofJE22nFzqjx05rz8DtZZxsohO
         iBlrzY6QfWBXe+53FJi1hgkiB8FH2JQg8N7E9eERjmhz2bYfkzLgVZ8TZS4qsSaevbzc
         0M35IgYv1HgGmIEY+zXJWjh/1YQpaasRvTQkToF0m0WmqoLqfjwCmS8QSssxrQLKQv22
         129bsjZljs0qr5KruTe+OBUvp7i5m2/xy45Qf+DFOGuE/LQ7CsrK3Pih/FDEookB/nrf
         0xRrQB/blnD/a1DGuowdoazQO3xpFazCTzxiLF6HiBWYw+pysIvfuOtCiy3A7gcDwlwX
         lMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745338423; x=1745943223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCJMTdTdGrMypkN6aePZhm/LPtstu8ev5ubEzZyTVWw=;
        b=wJM2fjulH14i02tjWuNu2wHgUQ3u3qieyw4wHwxqFvS7J4cznLQDrCo5xpza0xaGb0
         DpIOOIRk6CNnu544g+nlcaVYYGkwxLMrb5NNoEff/o8xGwZrEqM93C6Uj17MZCV0lzW/
         RW1NOhgI2jQoyIPHfMHVyVZZe6VlwBMfVqcpwClg5IkM7Ctd1vbbXgHZBJOtd1QsQcwT
         ZoKoWHOMol5SpeMz4DVT7yspFmiwfcOBrpRcK9ExGMcWrfa/UgRTNLeo3U/yqvzPRqlc
         zxeZ6L/zrpGdHSptuwFMw3BvMWTFnlu7eq8nyUAOHJfFsWlRYq/R7jkow0+2mQd2QvxD
         G6jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxU1LAyxLZjDK4Mo5JlRvpMdyy9Qk7t4jFpOjT10g+XiWMRrXPJMEQjyQRhFyMMfjbXZAsdak=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt/S11XCNU69AQwbKCGoSSb6q22y4cQ3v6KgCgkN5XZYj73kaz
	kLfBOlw8S7x1w0GCI2ZrsEyubFLuCOJz3YE8TBXUQQoLNc774LA=
X-Gm-Gg: ASbGncurmBlz8OdXYGpxllD6QGN0C5IWzTDrVjzidk4CpYpLR6/BuSKwmIseMHw30qh
	AW3RgUJG44vpSyVH4i064ZDpV/TUVGX0PqJpTiFmGLDkIzSGOWtetPk2xnX9lxSXzFzpFJg5Zya
	Fl4AP49DoJlyI5yvh7Hp6OFtCGq31lXf+EP2CHCEqdGcjsjmxhRXCxMOX+fnMqqSsRuxOlCoL6P
	jdjfFPAITcTxlRfMt0bpKOxq/BwjdpGewvPjwEzC1WL0FO/iEZAuXdESwJfygVLOVm7v9/OQXvH
	rgJks0xlYoLhJw+FTX34lWDglgF/0pa+GruPtJDciD7aQm4vyOs=
X-Google-Smtp-Source: AGHT+IGZmkgS5tA8cTBRR2XePeAb6RTguzTvkP4xEJcXMC8tWiiltTOC80emmCoLFaApPyU9eZ9rKQ==
X-Received: by 2002:a17:903:2344:b0:224:23be:c569 with SMTP id d9443c01a7336-22c53583780mr261718905ad.22.1745338422697;
        Tue, 22 Apr 2025 09:13:42 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbf8e46eesm9055241b3a.65.2025.04.22.09.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 09:13:42 -0700 (PDT)
Date: Tue, 22 Apr 2025 09:13:41 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
	dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
	jdamato@fastly.com, dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 16/22] eth: bnxt: adjust the fill level of agg
 queues with larger buffers
Message-ID: <aAfANdg0sfIXdVMx@mini-arch>
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-17-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250421222827.283737-17-kuba@kernel.org>

On 04/21, Jakub Kicinski wrote:
> The driver tries to provision more agg buffers than header buffers
> since multiple agg segments can reuse the same header. The calculation
> / heuristic tries to provide enough pages for 65k of data for each header
> (or 4 frags per header if the result is too big). This calculation is
> currently global to the adapter. If we increase the buffer sizes 8x
> we don't want 8x the amount of memory sitting on the rings.
> Luckily we don't have to fill the rings completely, adjust
> the fill level dynamically in case particular queue has buffers
> larger than the global size.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 28f8a4e0d41b..43497b335329 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -3791,6 +3791,21 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
>  	}
>  }
>  
> +static int bnxt_rx_agg_ring_fill_level(struct bnxt *bp,
> +				       struct bnxt_rx_ring_info *rxr)
> +{
> +	/* User may have chosen larger than default rx_page_size,
> +	 * we keep the ring sizes uniform and also want uniform amount
> +	 * of bytes consumed per ring, so cap how much of the rings we fill.
> +	 */
> +	int fill_level = bp->rx_agg_ring_size;

> +
> +	if (rxr->rx_page_size > bp->rx_page_size)
> +		fill_level /= rxr->rx_page_size / bp->rx_page_size;
> +
> +	return fill_level;
> +}

I don't know the driver well enough (so take it as an optional nit),
but seems like there should be a per-rxr rx_agg_ring_size pre-configured
somewhere. Deriving the fill_level from the per-queue rx_page_size feels
a bit hacky.

(or, rather, reading this snippet makes it hard for me to understand
what would be the size of agg ring given all the code in bnxt_set_ring_params)

