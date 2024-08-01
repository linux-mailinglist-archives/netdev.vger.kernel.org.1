Return-Path: <netdev+bounces-115144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368AF9454DA
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 01:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AC828362E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 23:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE1E14B96F;
	Thu,  1 Aug 2024 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5cmHYb3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F0E25757;
	Thu,  1 Aug 2024 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722554193; cv=none; b=Lc8bLuCJBXwEwo4npOTGEbf1HotfQbgGwQh3S0jxJJEzM++ITYAUm8Xvu9E/TGvU4bAboBLsPyCCQWHgSuEJjs8QhPvekLbPA/7+Rc0CoJvJUlI33sOtswWkhlTAumzlpvw/zGOsYP+ogxiXxMYE77xTJUaa3IC0dSy2LH57N4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722554193; c=relaxed/simple;
	bh=vXrXSocHPLt5kpPthnb3umqHOKVbJkhNsSwmQrp5ANk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pj2FHeppu09NDSUHqMLrS3GutTBb12AxcY3IaqXd+484JYnYY3Hq2hUuriT64/dL3PCYgkhOjBvQXDzVBXjeRYToaeAEABeaOWPgbLpnjhCI4Bhf0uKkyjCoqrhNhS0Q+h3Bfl4/ebODPHSODad88oz4AIgGBuYvFgI/Qu11C54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5cmHYb3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a8553db90so1021076966b.2;
        Thu, 01 Aug 2024 16:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722554189; x=1723158989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vRHY8LMAMsDzYIYRh2DEhqf/+ZSkBDumcnyt9s3s3SU=;
        b=e5cmHYb3TwYC3eJvC/B/V0w4c9jnTJzMhDoWbhJrzAqeTduDXiSWKatdizImU8V2wv
         lr3fE9woVohtyBpN7dIN0wgu1Crq32eSXzZ6+/yk0J7EkG0TkFLVMkpHIYByk7zBbXf+
         lo10hqjk7v1vy5KXjHZ8g6LnuKnFDPTV7r9Z9bnVO7H7sg/YCUjKQWQvdq3ejUthwiC5
         VZZuLmRXUoYW/rAMFN3nvQF54vTkOQubyQPKRAljnw3HMj6R+diPbCerfYjIpY5OzgXF
         XTYwyIiGPzOeFMUT3dIUJFug+oWKmoRQn/ZCfDVzNdzDx/vfNxicbiIiN7Y3bdms9qEE
         e+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722554189; x=1723158989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRHY8LMAMsDzYIYRh2DEhqf/+ZSkBDumcnyt9s3s3SU=;
        b=lk5XZQmR6Af7KErqmnVjAz+qg9yWD+tEA+Ed8ZYQVTxoL7CT1A1g+OCPcVVeNzSjjj
         vMXcXPzLfj3Get/n5RMy25J91WNPPxgyaTXsY8nhoS3fVTxTS0v64DuiHhFdbRqgWvkS
         87RoDZrrWXIYaiCZGV7APpjNhTbKpmkrH0d2Tmq9n87CBve5mFHOemvUyMX2Z3XdgFPV
         IFyqaDGYdDquilOgm+m3rQkoOe7p8zOh+Sb+3FcnCceHR72R4y5V8ho/WOgmxjnOfOim
         5rqfB8kzwE3sUozVZlQ+rh5BpuCLV4tIMwF0jYbtEbmrGJD+mH8yHcuDsczJAW7Kj5vb
         xyUw==
X-Forwarded-Encrypted: i=1; AJvYcCVRBJDxNAW8oBcj4fkR2GeJWEK7fwuOv3V3D6GYkjdrQg7fxLgKW18F5tZJqZeTCfglWrilQtpAAv/W1z4RhKh22YDFScLNQmVKycC9cFTWbw4AJBND8IyoDEpJi9JUvnjjJGTf
X-Gm-Message-State: AOJu0YwXrbRwRHqo19Eg5DU5tNRABy3eOYbw34lZ0K2xupywkH3xH2WC
	RY027ATBNIhvMfsGVWDcO9jhjzuYUwMrWtbR2WxkM3FGqzCP+Em4
X-Google-Smtp-Source: AGHT+IEsxgfvGijlQDD+0yGHl9Bv4Sl5rFZvFBX00pRtsgyK5toVPnhYX03gaMnFF/r02MjdVSWnNg==
X-Received: by 2002:a17:907:3f28:b0:a7a:acae:3415 with SMTP id a640c23a62f3a-a7dc4db4b08mr146394566b.10.1722554188713;
        Thu, 01 Aug 2024 16:16:28 -0700 (PDT)
Received: from skbuf ([188.25.135.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bcada0sm30237866b.31.2024.08.01.16.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 16:16:27 -0700 (PDT)
Date: Fri, 2 Aug 2024 02:16:25 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1 3/5] net: stmmac: support fp parameter of
 tc-taprio
Message-ID: <20240801231625.uqa4gq7vokp63dfp@skbuf>
References: <cover.1722421644.git.0x1207@gmail.com>
 <4603a4f68616ce41aca97bac2f55e5d51c865f53.1722421644.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4603a4f68616ce41aca97bac2f55e5d51c865f53.1722421644.git.0x1207@gmail.com>

On Wed, Jul 31, 2024 at 06:43:14PM +0800, Furong Xu wrote:
> tc-taprio can select whether traffic classes are express or preemptible.
> 
> After some traffic tests, MAC merge layer statistics are all good.
> 
> Local device:
> ethtool --include-statistics --json --show-mm eth1
> [ {
>         "ifname": "eth1",
>         "pmac-enabled": true,
>         "tx-enabled": true,
>         "tx-active": true,
>         "tx-min-frag-size": 60,
>         "rx-min-frag-size": 60,
>         "verify-enabled": true,
>         "verify-time": 100,
>         "max-verify-time": 128,
>         "verify-status": "SUCCEEDED",
>         "statistics": {
>             "MACMergeFrameAssErrorCount": 0,
>             "MACMergeFrameSmdErrorCount": 0,
>             "MACMergeFrameAssOkCount": 0,
>             "MACMergeFragCountRx": 0,
>             "MACMergeFragCountTx": 1398,
>             "MACMergeHoldCount": 15783
>         }
>     } ]
> 
> Remote device:
> ethtool --include-statistics --json --show-mm eth1
> [ {
>         "ifname": "eth1",
>         "pmac-enabled": true,
>         "tx-enabled": true,
>         "tx-active": true,
>         "tx-min-frag-size": 60,
>         "rx-min-frag-size": 60,
>         "verify-enabled": true,
>         "verify-time": 100,
>         "max-verify-time": 128,
>         "verify-status": "SUCCEEDED",
>         "statistics": {
>             "MACMergeFrameAssErrorCount": 0,
>             "MACMergeFrameSmdErrorCount": 0,
>             "MACMergeFrameAssOkCount": 1388,
>             "MACMergeFragCountRx": 1398,
>             "MACMergeFragCountTx": 0,
>             "MACMergeHoldCount": 0
>         }
>     } ]
> 
> Tested on DWMAC CORE 5.10a
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 34 ++-----------------
>  1 file changed, 3 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 494fe2f68300..eeb5eb453b98 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -943,7 +943,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
>  	struct timespec64 time, current_time, qopt_time;
>  	ktime_t current_time_ns;
> -	bool fpe = false;
>  	int i, ret = 0;
>  	u64 ctr;
>  
> @@ -1028,16 +1027,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  
>  		switch (qopt->entries[i].command) {
>  		case TC_TAPRIO_CMD_SET_GATES:
> -			if (fpe)
> -				return -EINVAL;
> -			break;
> -		case TC_TAPRIO_CMD_SET_AND_HOLD:
> -			gates |= BIT(0);
> -			fpe = true;
> -			break;
> -		case TC_TAPRIO_CMD_SET_AND_RELEASE:
> -			gates &= ~BIT(0);
> -			fpe = true;

I don't think these can go.

In the DWMAC5 manual, I see:
"To enable the support of hold and release operations, the format of the
GCL is slightly changed while configuring and enabling the FPE. The first Queue (Q0) is always programmed to carry preemption
traffic and therefore it is always Open. The bit corresponding to Q0 is renamed as Release/Hold MAC control. The TX Queues
whose packets are preemptable are indicated by setting the PEC field of the MTL_FPE_CTRL_STS register. The GCL bit of the
corresponding Queue are ignored and considered as always "Open". So, even if the software writes a "0" ("C"), it is ignored for
such queues."

It's relatively clear to me that this is what the "gates" variable is
doing here - it's modulating when preemptible traffic begins to be
"held", and when it is "released".

Now, the "fpe" variable - that can definitely go.

>  			break;
>  		default:
>  			return -EOPNOTSUPP;

Also, this is more general advice. If TC_TAPRIO_CMD_SET_AND_HOLD and
TC_TAPRIO_CMD_SET_AND_RELEASE used to work as UAPI input into this
driver, you don't want to break that now by letting those fall into the
default -EOPNOTSUPP case. What worked must continue to work... somehow.

> @@ -1068,16 +1057,11 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  
>  	tc_taprio_map_maxsdu_txq(priv, qopt);
>  
> -	if (fpe && !priv->dma_cap.fpesel) {
> +	if (qopt->mqprio.preemptible_tcs && !priv->dma_cap.fpesel) {
>  		mutex_unlock(&priv->est_lock);
>  		return -EOPNOTSUPP;
>  	}
>  
> -	/* Actual FPE register configuration will be done after FPE handshake
> -	 * is success.
> -	 */
> -	priv->plat->fpe_cfg->enable = fpe;
> -
>  	ret = stmmac_est_configure(priv, priv, priv->est,
>  				   priv->plat->clk_ptp_rate);
>  	mutex_unlock(&priv->est_lock);

