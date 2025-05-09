Return-Path: <netdev+bounces-189395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18337AB1F92
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 00:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6221C4460C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 22:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127B521D3F6;
	Fri,  9 May 2025 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIzYbLGd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEC73B2A0;
	Fri,  9 May 2025 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746828120; cv=none; b=UmvVbbwCXZ1VbfHsiCaOA6/kH417TysGk9zVGRUhAZIyhQnQi7WmAhXeI+5wraUJDNS55Ki3xr9hcvbY1XtCbCiBjYkiM0zkjKty9T1q8eu9H2jOM0DkVZqwwUCq14jajAYy+h3Baqwb8NiQQ7eP8sjlYfIqAUR+/Th1I2Ax3nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746828120; c=relaxed/simple;
	bh=gNZ3Syvjxa7YmkuREENTU9TsK6j8EtpbYbPGp0Oz+iM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8tP9N/Jmuf5liCSHpP9v5oylx1l5GVNR0/PHBd5YZSYN2ZJiL6ZaFpeHKLfnDFwJ+RGHTmQ+Gvcq+HPv0gQqc19qbpYQAZu+NL81hWwSUZVtIl/cOnbvY+lAkGam7k4mBw7SgS5MfSyXvBelinYiOUVvoIBsuWwcWnbJbfBovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIzYbLGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2B5C4CEE4;
	Fri,  9 May 2025 22:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746828118;
	bh=gNZ3Syvjxa7YmkuREENTU9TsK6j8EtpbYbPGp0Oz+iM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SIzYbLGdKoxCOsVq94Z3lV63td2xvY+ylEJqzlgtqKp86q7mcV31BKzACjDfOtw0J
	 k3uakoWbnAmEQ4CC9N1ER2LtjucJQnhC30Npo6Xko9BgUzLaeLWz1QpzGbiGIsFJ6q
	 qyXbKgH50PayyUCY6qhovbnsv5MEc/NbUKNlR/u6XrBA2r9UA+UJWT76iMtN8v3FoL
	 7Ee7VjXWZin5NJ19EFuoxh3P4XX8yusHSgK3p+ZxTdBaLaZjKuHWFxieLlGldgum86
	 BNoIyDAhyrYRCuzh03K8PPQ0JByfbgA5tKRASU7/XtWHLsKmQHr+u6+kvgreDXSvoM
	 LBrQ4f+yYMoAA==
Date: Fri, 9 May 2025 15:01:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2] ptp: ocp: Limit SMA/signal/freq counts in show/store
 functions
Message-ID: <20250509150157.6cdf620c@kernel.org>
In-Reply-To: <20250508071901.135057-1-maimon.sagi@gmail.com>
References: <20250508071901.135057-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 May 2025 10:19:01 +0300 Sagi Maimon wrote:
> The sysfs show/store operations could access uninitialized elements in
> the freq_in[], signal_out[], and sma[] arrays, leading to NULL pointer
> dereferences. This patch introduces u8 fields (nr_freq_in, nr_signal_out,
> nr_sma) to track the actual number of initialized elements, capping the
> maximum at 4 for each array. The affected show/store functions are updated to

This line is too long. I think the recommended limit for commit message
is / was 72 or 74 chars.

> respect these limits, preventing out-of-bounds access and ensuring safe
> array handling.

What do you mean by out-of-bounds access here. Is there any access with
index > 4 possible? Or just with index > 1 for Adva?

We need more precise information about the problem to decide if this is
a fix or an improvement 

> +	bp->sma_nr  = 4;

nit: double space in all the sma_nr assignments

>  
>  	ptp_ocp_fb_set_version(bp);
>  
> @@ -2862,6 +2870,9 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
>  	bp->fw_version = ioread32(&bp->reg->version);
>  	bp->fw_tag = 2;
>  	bp->sma_op = &ocp_art_sma_op;
> +	bp->signals_nr = 4;
> +	bp->freq_in_nr = 4;
> +	bp->sma_nr  = 4;
>  
>  	/* Enable MAC serial port during initialisation */
>  	iowrite32(1, &bp->board_config->mro50_serial_activate);
> @@ -2888,6 +2899,9 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
>  	bp->flash_start = 0xA00000;
>  	bp->eeprom_map = fb_eeprom_map;
>  	bp->sma_op = &ocp_adva_sma_op;
> +	bp->signals_nr = 2;
> +	bp->freq_in_nr = 2;
> +	bp->sma_nr  = 2;
>  
>  	version = ioread32(&bp->image->version);
>  	/* if lower 16 bits are empty, this is the fw loader. */
> @@ -3002,6 +3016,9 @@ ptp_ocp_sma_show(struct ptp_ocp *bp, int sma_nr, char *buf,
>  	const struct ocp_selector * const *tbl;
>  	u32 val;
>  
> +	if (sma_nr > bp->sma_nr)
> +		return 0;

Why are you returning 0 and not an error?

As a matter of fact why register the sysfs files for things which don't
exists?
-- 
pw-bot: cr

