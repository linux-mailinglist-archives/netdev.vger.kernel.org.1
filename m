Return-Path: <netdev+bounces-184939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D251A97C12
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 03:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFDB3B0C2D
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7923625A2BF;
	Wed, 23 Apr 2025 01:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="daqp3zPZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B98259C9F
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 01:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745371305; cv=none; b=irQXszEXvFjYG/Wky61g/maR4szmNppGGw5PzJgsIK7tEmekRiCdhCnkcHigJqkD7cYGkPSKscR23CWvpeIXFZ+EGWDbnbu3ZhYxlQU6THki7pZBySQ6wP+Ln08k3Tw3teN5DBi57RjI8iTrOkSoivKgPPDR2KzdjlbGlziiMHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745371305; c=relaxed/simple;
	bh=7oCvZbjyJy+tbhwD741EF4yStpE1Dx0IW6TfkQyeRW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvNC8eMErbujNoQ3Q6XUiaereBEctIX/fkh1S2iJvfnwTj8ht+tBgFPNYThZPnYivLRnT6YR4siRresrjHuEXe7eJtqrR2IJA02/dJGL3ABG9FIhspeMYgLZ8zpzKrWqj2BcltfexGuHwtcgmwqfB9vN1X9AghgE5FUtojW7MAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=daqp3zPZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-227b828de00so62935975ad.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 18:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745371303; x=1745976103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XoWI2RzfOQa1ulADmyuzmk0HP40c08H5o4VzcnZv4o=;
        b=daqp3zPZNNV7iK4TepUPhTYEpn6RwbrbtR7sps2dPn3NSFLuSay/HsTFy4Ac9wq0Ve
         GGQWNZmSMHf7RqzU53AaXXmxRPhoJmT6mdib4L9Yii6m57XFhSujez8uRHhGQiITS/7c
         VxkJU94+g3O+UunhexUinKL91eqw5u6HQA/3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745371303; x=1745976103;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XoWI2RzfOQa1ulADmyuzmk0HP40c08H5o4VzcnZv4o=;
        b=FaKv3Eo7RWHdidyIhGfIkF+fFbHsph5vPo/i4p/a2Ihj+sNVINa42utxtuM9EJQphr
         ILXi2Qy1eGAW8cn1PMNQWIldquGBXiI6hEcQGmhOhE+p7v/H196dvFAjtIU6Im78VvNn
         lZy7bkI/y87Ny3ZFOTiyHXatXK4DrxEDGh+qud22jMFYZkCtkedIGg47dSwCA4bbIT/E
         1H+uBS5WUlWd3Xwpphj411axIXxpJa4aR+5+GhWd9cW1M5JESeNpXEwRYtcEARauiDYn
         zte9eHmbPnAwDHzGNUjmZlxrBL0mbh9HvadpBO0oc7C7xWZqah7KsHgYdlCDPdq+szSa
         zI4g==
X-Gm-Message-State: AOJu0YxDXrZFHLwKoIistxY3E9eSaGadhYOhHI4SSCLUIHvNDxx1uOeh
	ZSyy0t0/eNDyfKjjJWTTLBe36moYWt4dRi1D55tqK+1f4pFMeal3uATIvXZqXn0=
X-Gm-Gg: ASbGnctp/oHGLI/7oK9ZQayBRbXjBOE3BZq41Z8oJIqDBGS3Oyp+3FR1+q3EgAh1Fbw
	FDyeNx8wzFCPbC8Kk4erIn/sy9okPSUPBYR4FOCp/FKNyQbBqurBM011WEr0uS8PweZKYVWOre/
	iQJR6w+hc+z2WMedgsoTs8mKdJhfF6mog1BUvcwPTG9zDsdrxx8C0/V8nmbAnrTGeZPvDerqWrR
	ZYeC9EWu4p5pKq5c1dcnudtnMrGSNv80vltFlCrDVSLAo0v1aPSgMQ+IV0RgOJ3iP0ILUrXAHfP
	pSFaIr87iFAemry1o/nbRNG7ZmiLKS8B8YOkpwKY6hSTvl2ojAgy6V+unscKLC7uSdC8YKc0BFY
	tpNccHubmEBuhjkhAYQ==
X-Google-Smtp-Source: AGHT+IHFoWOXbc0yjeIcAUEo6Kb0nJ7VwpRb9IXpFAJ3MPY1vqBMFBg87lY6ydyBLOYb+AiXf+/KeQ==
X-Received: by 2002:a17:902:f70d:b0:225:abd2:5e39 with SMTP id d9443c01a7336-22c535ac94bmr241821455ad.30.1745371302877;
        Tue, 22 Apr 2025 18:21:42 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50cfae4asm92420035ad.106.2025.04.22.18.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 18:21:42 -0700 (PDT)
Date: Tue, 22 Apr 2025 18:21:39 -0700
From: Joe Damato <jdamato@fastly.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com,
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com,
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com,
	shailend@google.com, linux@treblig.org, thostet@google.com,
	jfraker@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/6] gve: Add rx hardware timestamp expansion
Message-ID: <aAhAoxmUSCQkq979@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com,
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com,
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com,
	shailend@google.com, linux@treblig.org, thostet@google.com,
	jfraker@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
References: <20250418221254.112433-1-hramamurthy@google.com>
 <20250418221254.112433-5-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418221254.112433-5-hramamurthy@google.com>

On Fri, Apr 18, 2025 at 10:12:52PM +0000, Harshitha Ramamurthy wrote:
> From: John Fraker <jfraker@google.com>
> 
> Allow the rx path to recover the high 32 bits of the full 64 bit rx
> timestamp.
> 
> Use the low 32 bits of the last synced nic time and the 32 bits of the
> timestamp provided in the rx descriptor to generate a difference, which
> is then applied to the last synced nic time to reconstruct the complete
> 64-bit timestamp.
> 
> This scheme remains accurate as long as no more than ~2 seconds have
> passed between the last read of the nic clock and the timestamping
> application of the received packet.
> 
> Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: John Fraker <jfraker@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c | 23 ++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> index dcb0545baa50..483d188d33ab 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -437,6 +437,29 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
>  	skb_set_hash(skb, le32_to_cpu(compl_desc->hash), hash_type);
>  }
>  
> +/* Expand the hardware timestamp to the full 64 bits of width, and add it to the
> + * skb.
> + *
> + * This algorithm works by using the passed hardware timestamp to generate a
> + * diff relative to the last read of the nic clock. This diff can be positive or
> + * negative, as it is possible that we have read the clock more recently than
> + * the hardware has received this packet. To detect this, we use the high bit of
> + * the diff, and assume that the read is more recent if the high bit is set. In
> + * this case we invert the process.
> + *
> + * Note that this means if the time delta between packet reception and the last
> + * clock read is greater than ~2 seconds, this will provide invalid results.
> + */
> +static void __maybe_unused gve_rx_skb_hwtstamp(struct gve_rx_ring *rx, u32 hwts)
> +{
> +	s64 last_read = rx->gve->last_sync_nic_counter;

Does this need a READ_ONCE to match the WRITE_ONCE in the previous
patch ?

