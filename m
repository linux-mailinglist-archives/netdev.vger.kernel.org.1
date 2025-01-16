Return-Path: <netdev+bounces-158985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4CCA14061
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 18:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C49F188519F
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A088222CBD8;
	Thu, 16 Jan 2025 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4M+1ffC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE62A22A7F9
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047445; cv=none; b=aExtGLdKdIxxmfO6ZJFxIdADb+7UBdvzxMpMrTDjqdxi8BCEzHepWlaGbF0A+q12M51L58nmV580CHg7nW1/9ixYZzeRwLw9D8nKLEC5V7zP8I0x747komPacdZD61f3rbXx6kiKkcWFfodGbgvt/aQZl7BrpgluBSImE79N3fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047445; c=relaxed/simple;
	bh=oUvyCOuGB3fZXMyY5iThkvLDZvN8pcXcnTV+VvWUi/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9G1TzhgerSTczobl/jkOKq2C3nmJUAyqCEbVsTppJXvjWIHyDhm1puBgVjoHHC/zOzs9shih2cBSLkTqGIZU7W0uihnTfzbGm2aJanji/UJngy82yCKEaeGaIlPWtcJnpC9C+1VEqcOJDt/f6D4pAjMMDI1r7dmEmRksMWp71g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4M+1ffC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737047442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FutC3X0hdfu7bjmQneXmcvMkqrpcwwErUZ/tyQjmIk=;
	b=h4M+1ffCj9MyL1RdDAKTFRKj5qWDZC0nMfg+hCMiNwei6Pxy3I9Skg4MPM1SDqyPeyviQI
	zqplNJ0jy+sbkeEAps5/VViHce54I6uViuq8lS4Bc/p2YqaBzP25oY+7dCvGHfg5Mxpqfp
	OswWbJjBrHRJ46wfNJl/fqqYH1zT684=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-pZ-tK4uOMlKcBQq5DvHZgA-1; Thu, 16 Jan 2025 12:10:41 -0500
X-MC-Unique: pZ-tK4uOMlKcBQq5DvHZgA-1
X-Mimecast-MFC-AGG-ID: pZ-tK4uOMlKcBQq5DvHZgA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43621907030so9281325e9.1
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 09:10:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737047440; x=1737652240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FutC3X0hdfu7bjmQneXmcvMkqrpcwwErUZ/tyQjmIk=;
        b=VsXsS7fIG3R84ZRKyWMuEHGXN2qtDVM/XGNAAV/wsLavCVT/167BG9amJib2XMyG2k
         nCGDycNbl7ldG+qBuG6Wsk8YwQy+MECyUHSuYp589p/phG66SCTSurV5LHB7yTDfNWi9
         qzSvZqxG9EXMPDOGnne7qb394BZEjsLmnuwgIu4p+szz5Q3rVGBjCyf00xQsHf03RE8u
         GsD0q4/HyWWsXI12z/4ydw4xjKflqw3Y5RDbpy30y2DzuGSDSk+GTKYm14if9FR/KIwK
         6xgXp0L5yjxUnOgQjSEpEy9YBOZ+ArKnsKch9RM5TLH1cQfQBDWHaTD4h75nab7U3h5Q
         Prkg==
X-Gm-Message-State: AOJu0YzGhhaNmgGSLG9IQss7T0HDEcayHWfzvIsyoU2n5lI71yr+daXC
	T68/eXKKP/uaiQs3g09b6JVLPaynOhZVNfWDabIYTHtMz/f00wG7uElsY4KCMwW8LQwLgnEPnam
	YclQIT0GNeotubIYqlbS1sgT1FcJ/kIxaCsU/0a5ciRn/iEVwp5bBkA==
X-Gm-Gg: ASbGncs+ns0NC/fzIXzEU+Tuy9uqke85unNop1sBafMNA5ICzhmKw725YCqeGDqDhRA
	OrLoJceOaG6JV4GG7a0zZDUJlGNtMRjF7aHRNtLumsIFPgPv44G16TtGkQ1UXOZOSUegXnzHNSv
	In4O9fqOQevNItCsHPJmKOmV36yYDK4nYEsWRfFY3rMZ+awXYLKnbkQ1So4zScHs9wKxJ9Ismif
	EgyrvheGZNIOx9n6j1YrODcbyt23k2bKNd+Ohwo/oQPYU7kDA8Y1tg=
X-Received: by 2002:a5d:6d02:0:b0:38a:50f7:24fa with SMTP id ffacd0b85a97d-38a87357a07mr33378017f8f.54.1737047440099;
        Thu, 16 Jan 2025 09:10:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2KCWOgVxUdu2bQSr8F57dq5xQnAExD6XNbyjBd3g+I7aDxl8qlFGrIyoSEPyWZhlI99KwIQ==
X-Received: by 2002:a5d:6d02:0:b0:38a:50f7:24fa with SMTP id ffacd0b85a97d-38a87357a07mr33377989f8f.54.1737047439721;
        Thu, 16 Jan 2025 09:10:39 -0800 (PST)
Received: from [192.168.2.73] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384d2cfc2sm22692466b.82.2025.01.16.09.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 09:10:38 -0800 (PST)
Message-ID: <d74ccdf9-a1a4-40b6-8b95-9f3cbe89fb96@redhat.com>
Date: Thu, 16 Jan 2025 18:10:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH intel-net 1/3] ice: put Rx buffers after being done with
 current frame
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 magnus.karlsson@intel.com, jacob.e.keller@intel.com, xudu@redhat.com,
 mschmidt@redhat.com, jmaxwell@redhat.com, przemyslaw.kitszel@intel.com
References: <20250116153908.515848-1-maciej.fijalkowski@intel.com>
 <20250116153908.515848-2-maciej.fijalkowski@intel.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20250116153908.515848-2-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 16. 01. 25 16:39, Maciej Fijalkowski wrote:
> Introduce a new helper ice_put_rx_mbuf() that will go through gathered
> frags from current frame and will call ice_put_rx_buf() on them. Current
> logic that was supposed to simplify and optimize the driver where we go
> through a batch of all buffers processed in current NAPI instance turned
> out to be broken for jumbo frames and very heavy load that was coming
> from both multi-thread iperf and nginx/wrk pair between server and
> client. The delay introduced by approach that we are dropping is simply
> too big and we need to take the decision regarding page
> recycling/releasing as quick as we can.
>
> While at it, address an error path of ice_add_xdp_frag() - we were
> missing buffer putting from day 1 there.
>
> As a nice side effect we get rid of annoying and repetetive three-liner:
>
> 	xdp->data = NULL;
> 	rx_ring->first_desc = ntc;
> 	rx_ring->nr_frags = 0;
>
> by embedding it within introduced routine.
>
> Fixes: 1dc1a7e7f410 ("ice: Centrallize Rx buffer recycling")
> Reported-and-tested-by: Xu Du <xudu@redhat.com>
> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_txrx.c | 67 +++++++++++++----------
>   1 file changed, 38 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 5d2d7736fd5f..501df1bc881d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -1103,6 +1103,37 @@ ice_put_rx_buf(struct ice_rx_ring *rx_ring, struct ice_rx_buf *rx_buf)
>   	rx_buf->page = NULL;
>   }
>   
> +static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> +			    u32 *xdp_xmit)
> +{
> +	u32 nr_frags = rx_ring->nr_frags + 1;
> +	u32 idx = rx_ring->first_desc;
> +	u32 cnt = rx_ring->count;
> +	struct ice_rx_buf *buf;
> +
> +	for (int i = 0; i < nr_frags; i++) {
> +		buf = &rx_ring->rx_buf[idx];
> +
> +		if (buf->act & (ICE_XDP_TX | ICE_XDP_REDIR)) {
> +			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
> +			*xdp_xmit |= buf->act;
> +		} else if (buf->act & ICE_XDP_CONSUMED) {
> +			buf->pagecnt_bias++;
> +		} else if (buf->act == ICE_XDP_PASS) {
> +			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
> +		}
> +
> +		ice_put_rx_buf(rx_ring, buf);
> +
> +		if (++idx == cnt)
> +			idx = 0;
> +	}
> +
> +	xdp->data = NULL;
> +	rx_ring->first_desc = ntc;
ntc is not delared in this scope
> +	rx_ring->nr_frags = 0;
> +}
> +
>   /**
>    * ice_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
>    * @rx_ring: Rx descriptor ring to transact packets on
> @@ -1120,7 +1151,6 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>   	unsigned int total_rx_bytes = 0, total_rx_pkts = 0;
>   	unsigned int offset = rx_ring->rx_offset;
>   	struct xdp_buff *xdp = &rx_ring->xdp;
> -	u32 cached_ntc = rx_ring->first_desc;
>   	struct ice_tx_ring *xdp_ring = NULL;
>   	struct bpf_prog *xdp_prog = NULL;
>   	u32 ntc = rx_ring->next_to_clean;
> @@ -1128,7 +1158,6 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>   	u32 xdp_xmit = 0;
>   	u32 cached_ntu;
>   	bool failure;
> -	u32 first;
>   
>   	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
>   	if (xdp_prog) {
> @@ -1190,6 +1219,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>   			xdp_prepare_buff(xdp, hard_start, offset, size, !!offset);
>   			xdp_buff_clear_frags_flag(xdp);
>   		} else if (ice_add_xdp_frag(rx_ring, xdp, rx_buf, size)) {
> +			ice_put_rx_mbuf(rx_ring, xdp, NULL);
>   			break;
>   		}
>   		if (++ntc == cnt)
> @@ -1205,9 +1235,8 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>   		total_rx_bytes += xdp_get_buff_len(xdp);
>   		total_rx_pkts++;
>   
> -		xdp->data = NULL;
> -		rx_ring->first_desc = ntc;
> -		rx_ring->nr_frags = 0;
> +		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit);
> +
>   		continue;
>   construct_skb:
>   		if (likely(ice_ring_uses_build_skb(rx_ring)))
> @@ -1221,14 +1250,11 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>   			if (unlikely(xdp_buff_has_frags(xdp)))
>   				ice_set_rx_bufs_act(xdp, rx_ring,
>   						    ICE_XDP_CONSUMED);
> -			xdp->data = NULL;
> -			rx_ring->first_desc = ntc;
> -			rx_ring->nr_frags = 0;
> -			break;
>   		}
> -		xdp->data = NULL;
> -		rx_ring->first_desc = ntc;
> -		rx_ring->nr_frags = 0;
> +		ice_put_rx_mbuf(rx_ring, xdp, &xdp_xmit);
> +
> +		if (!skb)
> +			break;
>   
>   		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
>   		if (unlikely(ice_test_staterr(rx_desc->wb.status_error0,
> @@ -1257,23 +1283,6 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
>   		total_rx_pkts++;
>   	}
>   
> -	first = rx_ring->first_desc;
> -	while (cached_ntc != first) {
> -		struct ice_rx_buf *buf = &rx_ring->rx_buf[cached_ntc];
> -
> -		if (buf->act & (ICE_XDP_TX | ICE_XDP_REDIR)) {
> -			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
> -			xdp_xmit |= buf->act;
> -		} else if (buf->act & ICE_XDP_CONSUMED) {
> -			buf->pagecnt_bias++;
> -		} else if (buf->act == ICE_XDP_PASS) {
> -			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
> -		}
> -
> -		ice_put_rx_buf(rx_ring, buf);
> -		if (++cached_ntc >= cnt)
> -			cached_ntc = 0;
> -	}
>   	rx_ring->next_to_clean = ntc;
>   	/* return up to cleaned_count buffers to hardware */
>   	failure = ice_alloc_rx_bufs(rx_ring, ICE_RX_DESC_UNUSED(rx_ring));


