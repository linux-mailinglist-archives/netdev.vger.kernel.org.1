Return-Path: <netdev+bounces-266016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKeFBM38r2mmdwIAu9opvQ
	(envelope-from <netdev+bounces-266016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:13:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A860824A212
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CBA530BB854
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22009386C01;
	Tue, 10 Mar 2026 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yp38DEhX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNw8lqSI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED055382391
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140796; cv=none; b=YiKxR4T/uG3xgJRZng4M8JbTwGLMVgmzgn6H7/IjJE/ftIewj1b70u5XMBkz8vp8MXvRVKgNI9xI582HoShT6mo/CZHwzQF6hWYjUHGTPPbGnXBQmc3kMk8P2+WkbnV+DKvP+eeLTPs1953FLv+Y8W+/bveUth/9BAnPJBzBBnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140796; c=relaxed/simple;
	bh=xizap0WDd3bk+cV05bm/94G/gSVnO8jIIE/fLVblhCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2Cw1KI22UW87YUHzl8jVe0hexEQtqCjX22fikNgWlC/GVQI0bGJwPSi9IbwU19iFEIrTFzOFnieSGBX11aNkrdGNPFo6e65leHHXFGEYSgOOT3woNbyUGvBFAn1h2gSKbZ2uSJ6I5UwqUEh1LRFWfTRpWYG5+WpAEBZl679Gnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yp38DEhX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNw8lqSI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773140792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQmnv8N9Rzvz3Q1rfAEua10tLTzUnmwhpxs3ijK8p7g=;
	b=Yp38DEhX2K+ZZYR6i2Md9j2YIBHo04MXxVp41j1FPT8RNNyGQpUrWsLC+fIisliaR9rb0N
	VQ4ns3LuxtL6jkos3uh+gvGO+VxfxrPTiUuoLGB8Url44CJPTWaqpEkZRhFKk+Z6v/7p/3
	W4Ewu4fZcvmIxQDUxk+xfhtNxplPyFo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-Kaju4Y_yNoOtKK_AjLz8lA-1; Tue, 10 Mar 2026 07:06:31 -0400
X-MC-Unique: Kaju4Y_yNoOtKK_AjLz8lA-1
X-Mimecast-MFC-AGG-ID: Kaju4Y_yNoOtKK_AjLz8lA_1773140790
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so116758245e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 04:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773140789; x=1773745589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQmnv8N9Rzvz3Q1rfAEua10tLTzUnmwhpxs3ijK8p7g=;
        b=UNw8lqSIlp/yBM1augfXCRiPPh/5eoitI4666G+vd3ZoGsJ4/oLnGuXYMZ8IAOD55p
         Y2vtl0NLsboMfcpabbThMP3quikSP6285iGGu0PwJg+thFouTDwSrkKCPToKZnb/AAfF
         uHnEKeVGeSSFnJ0uRnf8K5oC0o1lROk6A0lrtV8US+MqgZk+MWCUtxDK4XdmVW2VUKFy
         PSGsRyqd+9s+pxomlKAzTjlMGlIy5YnbRoEJ0VZhkYVXcuVrzJ1WEu3ojIewzIQN2nLy
         AYwDvr+IFOqGgxwRsvvCGN9F4+vVpBR7ls5/A4RbLXsHoSTX74dDMwfD1WLbJgdYP3Fg
         hEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773140789; x=1773745589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQmnv8N9Rzvz3Q1rfAEua10tLTzUnmwhpxs3ijK8p7g=;
        b=amazUgsUSmKkD1nrbVBQlvBpVgWq1weX3VSX111HC89hfkpsM31L/gc3e32QQUX5Cd
         5VQhXyID6RgK5x4uct6b+FqXkvEmOafZ+YxF9kEJzbNFuWqlMrpMhl1uEZF3A6GpcAii
         igBRDS8CfkfRhkNurQR2vJTH1LiJzps1RJleJl4nyvPm4NeW8r8ae8FrA372+PhA0G7o
         w1iI2sLLZryM9VTX6joXQcji48NZ8aktweK3tgi68pimmf9LK0vBNM84DJHtfYhad9Pf
         /oH34Sp5WEe0jTTrsvrWBliGoS817ZNko5a/STlfK6n/Ce4KSN6QTNnhqhQeZTYjiyEq
         Cxww==
X-Forwarded-Encrypted: i=1; AJvYcCUuGluNlWc4zk/SyG835fK2qA9GN/6dzBqhMS4E6s1VUvuh1ZxkCagBiJxpRX1L3YX1Er+mlxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7BfuEQof6YgKcCy78qgLXtu+OLvIhfKj+5q7ARFNgQl0iknT0
	j8C6c5rZV+IbsMK6U1QoTMvlYQPIaEdoCL/zEGAVzV9n2CREv1lZ5benbU3a9Cx9+fslKThm+Js
	XML94gAmGuEKbrbZZU85jCkwl+/5F2GEEr5Kkyuy1xdaAPSYQyWoysktQKi1EhWbtfA==
X-Gm-Gg: ATEYQzwKgjiRxdIWg86AH4GBROJdv7lGrFCAGf455zMwy13TGRvfVJIJhufcdTd3OLy
	kpOxveuaepX9n6vJUMhVWucmngB55HqblqQcGyIzADAxlnsfwuYxRBkHADi29T8t8/zM6N8GIvw
	tjnnRvO4jv0hnvGzQToliU6FbC4oPUbAmZAs3OTX6LClhfHryRfIBW4i/5y99mfHWR3qn1MyJ5H
	8tBThL6+mEkIkC0wP6DzW0rtD+XCdbnk39MSEXHcQipqMfYTwnkbhg402670i2M101sQ22/BvWL
	d6sSlq3cPLlW0U84mro+yjEM9a/036w2gIPW6KD4J6776PENNJ3NtC4sNiSoCfLetL1n5K7yZSv
	lrq6+HJqNoH7VGOzs0AlWaRTivZ3z6mkjPY4IKf3DLsB5RgLG80kilKms
X-Received: by 2002:a05:600c:1d04:b0:485:3428:774c with SMTP id 5b1f17b1804b1-485419a286cmr48914585e9.4.1773140789264;
        Tue, 10 Mar 2026 04:06:29 -0700 (PDT)
X-Received: by 2002:a05:600c:1d04:b0:485:3428:774c with SMTP id 5b1f17b1804b1-485419a286cmr48913995e9.4.1773140788630;
        Tue, 10 Mar 2026 04:06:28 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f6b7sm90558735e9.9.2026.03.10.04.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 04:06:27 -0700 (PDT)
Message-ID: <965eb715-4e15-4ee2-bb29-bcb523411869@redhat.com>
Date: Tue, 10 Mar 2026 12:06:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net 2/3] amd-xgbe: prevent CRC errors during RX
 adaptation with AN disabled
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, horms@kernel.org,
 Shyam-sundar.S-k@amd.com
References: <20260306111629.1515676-1-Raju.Rangoju@amd.com>
 <20260306111629.1515676-3-Raju.Rangoju@amd.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260306111629.1515676-3-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A860824A212
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266016-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action

On 3/6/26 12:16 PM, Raju Rangoju wrote:
> When operating in 10GBASE-KR mode with auto-negotiation disabled and RX
> adaptation enabled, CRC errors can occur during the RX adaptation
> process. This happens because the driver continues transmitting and
> receiving packets while adaptation is in progress.
> 
> Fix this by stopping TX/RX immediately when the link goes down and RX
> adaptation needs to be re-triggered, and only re-enabling TX/RX after
> adaptation completes and the link is confirmed up. Introduce a flag to
> track whether TX/RX was disabled for adaptation so it can be restored
> correctly.
> 
> This prevents packets from being transmitted or received during the RX
> adaptation window and avoids CRC errors from corrupted frames.
> 
> The flag tracking the data path state is synchronized with hardware
> state in xgbe_start() to prevent stale state after device restarts.
> This ensures that after a restart cycle (where xgbe_stop disables
> TX/RX and xgbe_start re-enables them), the flag correctly reflects
> that the data path is active.
> 
> Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
> Changes since v1:
>  - Change the data_path_stopped flag to boolean type
>    as it is only used as a true/false indicator.
> Changes since v2:
>  - change the data_path_stopped flag to be cleared in phy_start() to
>    ensure it is reset on device restart
> 
>  drivers/net/ethernet/amd/xgbe/xgbe-drv.c    |  4 ++
>  drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 63 ++++++++++++++++++++-
>  drivers/net/ethernet/amd/xgbe/xgbe.h        |  4 ++
>  3 files changed, 69 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> index 8b79d88480db..39da2f811858 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> @@ -1277,6 +1277,10 @@ static int xgbe_start(struct xgbe_prv_data *pdata)
>  
>  	hw_if->enable_tx(pdata);
>  	hw_if->enable_rx(pdata);
> +	/* Synchronize flag with hardware state after enabling TX/RX.
> +	 * This prevents stale state after device restart cycles.
> +	 */
> +	pdata->data_path_stopped = false;
>  
>  	udp_tunnel_nic_reset_ntf(netdev);
>  
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> index b330e888c944..59a074ed312a 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> @@ -2017,6 +2017,48 @@ static void xgbe_phy_rx_adaptation(struct xgbe_prv_data *pdata)
>  	xgbe_rx_adaptation(pdata);
>  }
>  
> +/*
> + * xgbe_phy_stop_data_path - Stop TX/RX to prevent packet corruption
> + * @pdata: driver private data
> + *
> + * This function stops the data path (TX and RX) to prevent packet
> + * corruption during critical PHY operations like RX adaptation.
> + * Must be called before initiating RX adaptation when link goes down.
> + */
> +static void xgbe_phy_stop_data_path(struct xgbe_prv_data *pdata)
> +{
> +	if (pdata->data_path_stopped)
> +		return;
> +
> +	/* Stop TX/RX to prevent packet corruption during RX adaptation */
> +	pdata->hw_if.disable_tx(pdata);
> +	pdata->hw_if.disable_rx(pdata);
> +	pdata->data_path_stopped = true;
> +
> +	netif_dbg(pdata, link, pdata->netdev,
> +		  "stopping data path for RX adaptation\n");
> +}
> +
> +/*
> + * xgbe_phy_start_data_path - Re-enable TX/RX after RX adaptation
> + * @pdata: driver private data
> + *
> + * This function re-enables the data path (TX and RX) after RX adaptation
> + * has completed successfully. Only called when link is confirmed up.
> + */
> +static void xgbe_phy_start_data_path(struct xgbe_prv_data *pdata)
> +{
> +	if (!pdata->data_path_stopped)
> +		return;
> +
> +	pdata->hw_if.enable_rx(pdata);
> +	pdata->hw_if.enable_tx(pdata);
> +	pdata->data_path_stopped = false;
> +
> +	netif_dbg(pdata, link, pdata->netdev,
> +		  "restarting data path after RX adaptation\n");
> +}
> +
>  static void xgbe_phy_rx_reset(struct xgbe_prv_data *pdata)
>  {
>  	int reg;
> @@ -2826,13 +2868,27 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
>  	if (pdata->en_rx_adap) {
>  		/* if the link is available and adaptation is done,
>  		 * declare link up
> +		 *
> +		 * Note: When link is up and adaptation is done, we can
> +		 * safely re-enable the data path if it was stopped
> +		 * for adaptation.
>  		 */
> -		if ((reg & MDIO_STAT1_LSTATUS) && pdata->rx_adapt_done)
> +		if ((reg & MDIO_STAT1_LSTATUS) && pdata->rx_adapt_done) {
> +			xgbe_phy_start_data_path(pdata);
>  			return 1;
> +		}
>  		/* If either link is not available or adaptation is not done,
>  		 * retrigger the adaptation logic. (if the mode is not set,
>  		 * then issue mailbox command first)
>  		 */
> +
> +		/* CRITICAL: Stop data path BEFORE triggering RX adaptation
> +		 * to prevent CRC errors from packets corrupted during
> +		 * the adaptation process. This is especially important
> +		 * when AN is OFF in 10G KR mode.
> +		 */
> +		xgbe_phy_stop_data_path(pdata);
> +
>  		if (pdata->mode_set) {
>  			xgbe_phy_rx_adaptation(pdata);
>  		} else {
> @@ -2840,8 +2896,11 @@ static int xgbe_phy_link_status(struct xgbe_prv_data *pdata, int *an_restart)
>  			xgbe_phy_set_mode(pdata, phy_data->cur_mode);
>  		}
>  
> -		if (pdata->rx_adapt_done)
> +		if (pdata->rx_adapt_done) {
> +			/* Adaptation complete, safe to re-enable data path */
> +			xgbe_phy_start_data_path(pdata);
>  			return 1;
> +		}
>  	} else if (reg & MDIO_STAT1_LSTATUS)
>  		return 1;

AI says:

---
What happens if en_rx_adap transitions from true to false while
data_path_stopped is true?

Consider this scenario during an SFP hot-swap from a passive cable (which
enables rx_adap) to an active cable (which disables rx_adap):

1. Initially with passive cable: en_rx_adap=true, link down
2. xgbe_phy_link_status() enters the if (pdata->en_rx_adap) block
3. xgbe_phy_stop_data_path() sets data_path_stopped=true and disables TX/RX
4. Hot-swap to active cable: xgbe_phy_sfi_mode() sets en_rx_adap=0
5. Next call to xgbe_phy_link_status(): en_rx_adap is now false
6. The entire if (pdata->en_rx_adap) block is skipped
7. Link is up, so falls through to: else if (reg & MDIO_STAT1_LSTATUS)
return 1
8. Returns link up, but TX/RX hardware remains disabled

At this point, data_path_stopped=true and the hardware TX/RX is disabled,
but there's no code path to re-enable it when en_rx_adap becomes false
(except a full device restart cycle through xgbe_stop + xgbe_start).

Would it be safer to check data_path_stopped in the else branch and call
xgbe_phy_start_data_path() if needed before returning link up?
---

I think the remark is not correct, as AFAICS xgbe_phy_sfi_mode() is only
invoked by xgbe_phy_link_status(), after checking `en_rx_adap` and ev.
re-starting the ring. Reporting the remark here in case I misread the
code and this actually need a follow-up.

/P


