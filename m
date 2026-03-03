Return-Path: <netdev+bounces-263165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBU4Ah7Mpmk0TwAAu9opvQ
	(envelope-from <netdev+bounces-263165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 12:55:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E881EEB5D
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 12:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2581731C2F2B
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 11:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCC8423158;
	Tue,  3 Mar 2026 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsDy82/J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="klgmATDF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4639F3BD62F
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538019; cv=none; b=V4eU9YbomPay9Op6QKm+2uURMoHllZS2fjDTpopfkN8OUN5VD2CnJwRJkwRE/vVwzPE7JQvBULN/tuLskSsHLLgsIMyNMAa+74mcZPpCyxu5nELiVAs0YlWwmsMhtXd9M+h7b/Xzq6Fxp1MlBRmbUDYEAjWs61bIkWFwNdG+Xy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538019; c=relaxed/simple;
	bh=FB1H1bYPfRo0l1AZR+g9a4rGWIneluw8K3NlXPs8LFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbCbyqZCcd0iWo7koSq7NO/GH4UahbLrUKjzc149UvxeYBkvFFujkvsuOZLCrtwOZDt5hphJ93Q7tWK0l7T79c4u+WqU3QIrnmy4dI9TWeuYuiH2st+G59/17CZNSo2b+NmWjb8/c+H6tqik2OdLDDoXxJbQ9JP9qEk8XHJJmUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JsDy82/J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=klgmATDF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772538016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXN4uN03dt3iGK+UzX0iN4D4fHvi9Hm4rvLipzFnq+Q=;
	b=JsDy82/Jp3Lnf1c1c5o2nKO6ez2vzZxFruNMnAHWnHtmvcxs3lqVaPdPiNe+McdnXDijFZ
	6yxrvFvnIZ8I18k2nSBEQiL5IOnneKlk46k0m03LrRdJEa7poXjSqFWVZje1wWPH+ZD3+j
	bgpWWffbylboDCInSgTJHiLo6ZIC0SY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-sYIo4w35N5Kv5TwfTxHeNA-1; Tue, 03 Mar 2026 06:40:15 -0500
X-MC-Unique: sYIo4w35N5Kv5TwfTxHeNA-1
X-Mimecast-MFC-AGG-ID: sYIo4w35N5Kv5TwfTxHeNA_1772538014
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-483101623e9so49813305e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 03:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772538014; x=1773142814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UXN4uN03dt3iGK+UzX0iN4D4fHvi9Hm4rvLipzFnq+Q=;
        b=klgmATDFDppR0i7poUvsn9bqfdbvMdBHAaNGHcDSHW6qP452tYEaPUUu7xo850nT65
         Lf95k81ITI/vgchDKrsC7+IAbAN+1MgSGVeZ3iqF4XN4K3Ucxsjir6XpXZcc1S2YWC2T
         5s3puyoLHV3W9P4t7Y2filaIfJqSyvtZRn3jgE48tDFjuKuzNbTtVxtnSVg69yNtOj8B
         n5ru2ZGHW3ukfps0zBMFC3vGbQ+L14XWkGkD4o1xHCmQitYTPm2ytjIF5rdTYVxagVGM
         NRiV5+XNpPIaaEY0cj9KL2cDdCooENjISWrxOjRCyOheh1/8ZHYzfmnHWx9ZdpBwVlzH
         ThTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772538014; x=1773142814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXN4uN03dt3iGK+UzX0iN4D4fHvi9Hm4rvLipzFnq+Q=;
        b=O/KmZKH2IgxSSaq2l8qyTpzUnx/grrdGnZSfMCQJPoQ1ZxGJ66PkSRYnoAKC5LL9FZ
         cM84aXoqAem6Nlb0JEFQj8ypkdBsCxLeAaCFbbJB+Hx73Xujrb0D0suoJ4iYvHLB8mkx
         vz1/kW/5ZpSSj5+BSiwPGlGnnBVpl+vUR6jaobNTmNEjfkrvEiOGFMOM8fK2d3XxBqIp
         vEDVjXVtHghJH4Ezgidk0d4pJPu1XYZNPmyNi5rRBsYGTwFpQ6K3S6699WhetwATZrmy
         RgUVvdyEhpYOd/KUMor+n5FBYp1D4F7NdRJXh02Zdj6RmZ6/pqDxD+J9oxEsCTpxRkV3
         hGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx6yGtYXxyJGlyIsu3YMpstVBdW+9J6CazcgQTsQZ260XICrrvtw4oCrGxoqYtqoKSyYbKY2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZQlZY3IL0K7p2yYWm5JR7mCrIsdlqMHKDKdjUbcd/xZqy9M8I
	n7tIQA+dg1jG6hwn0uxYaoAwmZC+EQb71MtBP56oBZqXgBDqXuymKefseHrr+QGLFV+n19ykHUS
	EebCh1rVAwnStU7VDnu4wvZ0A+Q9oYGEaePKIBEg4cvs14iKU2/kXD+eRfA==
X-Gm-Gg: ATEYQzwzidafCgRKSQiz1o2MsSEtxbgZvp6SkIIWQMCJr4zc56fhEoY9uUXb9B3TNcl
	XZlCGG7sv3lZMOv1l8p7t9nFaacq4sMkbIugbrQDQWKKEKTjmxFWW8ExgNpm1eYb9wr61YgQPvt
	DhA8yIq9NgGUrtInK1AbZZ2JNtU0e08w5X+Nw6/4g7VyI8b2zZqMZZzi4kqYuxQGnxqFf7M35KU
	C5Zwg/AulIxfQk2EEQIetnvKm6WNA629ycdNnF/L2VQAsV7U5wCzOtoqEu8ZGlrYKyWF5zBG5zS
	t3TbH0Yukpu9etibBSwDxcQ/zoegPgta0lHToPSFDsN5M1eA7xGzTOP6lQI6WU3O1GHBsqa7kMb
	5+J4lHPgiMVBbIS7o0+jh5GmO
X-Received: by 2002:a05:600c:a4a:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-483c9bb7c31mr276327805e9.5.1772538013783;
        Tue, 03 Mar 2026 03:40:13 -0800 (PST)
X-Received: by 2002:a05:600c:a4a:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-483c9bb7c31mr276327355e9.5.1772538013272;
        Tue, 03 Mar 2026 03:40:13 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df9fsm561235755e9.13.2026.03.03.03.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 03:40:12 -0800 (PST)
Message-ID: <ef76d148-79d1-4c14-af92-448803e83ac2@redhat.com>
Date: Tue, 3 Mar 2026 12:40:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: dsa: yt921x: Use u64_stats_t for MIB
 stats
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
References: <20260227135057.2730254-1-mmyangfl@gmail.com>
 <20260227135057.2730254-3-mmyangfl@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260227135057.2730254-3-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 83E881EEB5D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263165-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.987];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 2/27/26 2:50 PM, David Yang wrote:
> 64-bit variables might not be atomic on 32-bit architectures, and could
> lead to load/store tearing. Use u64_stats_t to ensure consistency.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/dsa/yt921x.c | 197 +++++++++++++++++++++++----------------
>  drivers/net/dsa/yt921x.h | 114 ++++++++++++----------
>  2 files changed, 178 insertions(+), 133 deletions(-)
> 
> diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
> index a968a3fb56f8..8129c278e224 100644
> --- a/drivers/net/dsa/yt921x.c
> +++ b/drivers/net/dsa/yt921x.c
> @@ -20,6 +20,7 @@
>  #include <linux/of_mdio.h>
>  #include <linux/of_net.h>
>  #include <linux/sort.h>
> +#include <linux/u64_stats_sync.h>
>  
>  #include <net/dsa.h>
>  #include <net/dscp.h>
> @@ -670,22 +671,20 @@ yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
>  static int yt921x_read_mib(struct yt921x_priv *priv, int port)
>  {
>  	struct yt921x_port *pp = &priv->ports[port];
> +	struct yt921x_mib *mib_new = &pp->mib_new;
>  	struct device *dev = to_device(priv);
>  	struct yt921x_mib *mib = &pp->mib;
> +	u64 rx_frames;
> +	u64 tx_frames;
>  	int res = 0;
>  
> -	/* Reading of yt921x_port::mib is not protected by a lock and it's vain
> -	 * to keep its consistency, since we have to read registers one by one
> -	 * and there is no way to make a snapshot of MIB stats.
> -	 *
> -	 * Writing (by this function only) is and should be protected by
> -	 * reg_lock.
> +	/* u64_stats_read/set is redundant for mib_new, but I don't want to
> +	 * declare a plain u64 yt921x_mib variant.
>  	 */
>  
>  	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
>  		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
>  		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
> -		u64 *valp = &((u64 *)mib)[i];
>  		u32 val0;
>  		u64 val;
>  
> @@ -694,7 +693,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
>  			break;
>  
>  		if (desc->size <= 1) {
> -			u64 old_val = *valp;
> +			u64 old_val = u64_stats_read(&mib->stats[i]);
>  
>  			val = (old_val & ~(u64)U32_MAX) | val0;
>  			if (val < old_val)
> @@ -708,7 +707,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
>  			val = ((u64)val1 << 32) | val0;
>  		}
>  
> -		WRITE_ONCE(*valp, val);
> +		u64_stats_set(&mib_new->stats[i], val);
>  	}
>  
>  	if (res) {
> @@ -717,14 +716,29 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
>  		return res;
>  	}
>  
> -	pp->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
> -			mib->rx_128_255byte + mib->rx_256_511byte +
> -			mib->rx_512_1023byte + mib->rx_1024_1518byte +
> -			mib->rx_jumbo;
> -	pp->tx_frames = mib->tx_64byte + mib->tx_65_127byte +
> -			mib->tx_128_255byte + mib->tx_256_511byte +
> -			mib->tx_512_1023byte + mib->tx_1024_1518byte +
> -			mib->tx_jumbo;
> +	rx_frames = u64_stats_read(&mib_new->rx_64byte) +
> +		    u64_stats_read(&mib_new->rx_65_127byte) +
> +		    u64_stats_read(&mib_new->rx_128_255byte) +
> +		    u64_stats_read(&mib_new->rx_256_511byte) +
> +		    u64_stats_read(&mib_new->rx_512_1023byte) +
> +		    u64_stats_read(&mib_new->rx_1024_1518byte) +
> +		    u64_stats_read(&mib_new->rx_jumbo);
> +	tx_frames = u64_stats_read(&mib_new->tx_64byte) +
> +		    u64_stats_read(&mib_new->tx_65_127byte) +
> +		    u64_stats_read(&mib_new->tx_128_255byte) +
> +		    u64_stats_read(&mib_new->tx_256_511byte) +
> +		    u64_stats_read(&mib_new->tx_512_1023byte) +
> +		    u64_stats_read(&mib_new->tx_1024_1518byte) +
> +		    u64_stats_read(&mib_new->tx_jumbo);
> +
> +	u64_stats_update_begin(&pp->syncp);
> +	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
> +		u64_stats_set(&mib->stats[i],
> +			      u64_stats_read(&mib_new->stats[i]));
> +	}
> +	u64_stats_set(&pp->rx_frames, rx_frames);
> +	u64_stats_set(&pp->tx_frames, tx_frames);
> +	u64_stats_update_end(&pp->syncp);
>  
>  	return 0;
>  }
> @@ -772,8 +786,8 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
>  	size_t j;
>  
>  	mutex_lock(&priv->reg_lock);
> +
>  	yt921x_read_mib(priv, port);
> -	mutex_unlock(&priv->reg_lock);
>  
>  	j = 0;
>  	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
> @@ -782,9 +796,11 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
>  		if (!desc->name)
>  			continue;
>  
> -		data[j] = ((u64 *)mib)[i];
> +		data[j] = u64_stats_read(&((u64_stats_t *)mib)[i]);
>  		j++;
>  	}
> +
> +	mutex_unlock(&priv->reg_lock);
>  }
>  
>  static int yt921x_dsa_get_sset_count(struct dsa_switch *ds, int port, int sset)
> @@ -813,31 +829,33 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
>  	struct yt921x_mib *mib = &pp->mib;
>  
>  	mutex_lock(&priv->reg_lock);
> +
>  	yt921x_read_mib(priv, port);
> -	mutex_unlock(&priv->reg_lock);
>  
> -	mac_stats->FramesTransmittedOK = pp->tx_frames;
> -	mac_stats->SingleCollisionFrames = mib->tx_single_collisions;
> -	mac_stats->MultipleCollisionFrames = mib->tx_multiple_collisions;
> -	mac_stats->FramesReceivedOK = pp->rx_frames;
> -	mac_stats->FrameCheckSequenceErrors = mib->rx_crc_errors;
> -	mac_stats->AlignmentErrors = mib->rx_alignment_errors;
> -	mac_stats->OctetsTransmittedOK = mib->tx_good_bytes;
> -	mac_stats->FramesWithDeferredXmissions = mib->tx_deferred;
> -	mac_stats->LateCollisions = mib->tx_late_collisions;
> -	mac_stats->FramesAbortedDueToXSColls = mib->tx_aborted_errors;
> +	mac_stats->FramesTransmittedOK = u64_stats_read(&pp->tx_frames);
> +	mac_stats->SingleCollisionFrames = u64_stats_read(&mib->tx_single_collisions);
> +	mac_stats->MultipleCollisionFrames = u64_stats_read(&mib->tx_multiple_collisions);
> +	mac_stats->FramesReceivedOK = u64_stats_read(&pp->rx_frames);
> +	mac_stats->FrameCheckSequenceErrors = u64_stats_read(&mib->rx_crc_errors);
> +	mac_stats->AlignmentErrors = u64_stats_read(&mib->rx_alignment_errors);
> +	mac_stats->OctetsTransmittedOK = u64_stats_read(&mib->tx_good_bytes);
> +	mac_stats->FramesWithDeferredXmissions = u64_stats_read(&mib->tx_deferred);
> +	mac_stats->LateCollisions = u64_stats_read(&mib->tx_late_collisions);
> +	mac_stats->FramesAbortedDueToXSColls = u64_stats_read(&mib->tx_aborted_errors);
>  	/* mac_stats->FramesLostDueToIntMACXmitError */
>  	/* mac_stats->CarrierSenseErrors */
> -	mac_stats->OctetsReceivedOK = mib->rx_good_bytes;
> +	mac_stats->OctetsReceivedOK = u64_stats_read(&mib->rx_good_bytes);
>  	/* mac_stats->FramesLostDueToIntMACRcvError */
> -	mac_stats->MulticastFramesXmittedOK = mib->tx_multicast;
> -	mac_stats->BroadcastFramesXmittedOK = mib->tx_broadcast;
> +	mac_stats->MulticastFramesXmittedOK = u64_stats_read(&mib->tx_multicast);
> +	mac_stats->BroadcastFramesXmittedOK = u64_stats_read(&mib->tx_broadcast);
>  	/* mac_stats->FramesWithExcessiveDeferral */
> -	mac_stats->MulticastFramesReceivedOK = mib->rx_multicast;
> -	mac_stats->BroadcastFramesReceivedOK = mib->rx_broadcast;
> +	mac_stats->MulticastFramesReceivedOK = u64_stats_read(&mib->rx_multicast);
> +	mac_stats->BroadcastFramesReceivedOK = u64_stats_read(&mib->rx_broadcast);
>  	/* mac_stats->InRangeLengthErrors */
>  	/* mac_stats->OutOfRangeLengthField */
> -	mac_stats->FrameTooLongErrors = mib->rx_oversize_errors;
> +	mac_stats->FrameTooLongErrors = u64_stats_read(&mib->rx_oversize_errors);
> +
> +	mutex_unlock(&priv->reg_lock);
>  }
>  
>  static void
> @@ -849,12 +867,14 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
>  	struct yt921x_mib *mib = &pp->mib;
>  
>  	mutex_lock(&priv->reg_lock);
> +
>  	yt921x_read_mib(priv, port);
> -	mutex_unlock(&priv->reg_lock);
>  
> -	ctrl_stats->MACControlFramesTransmitted = mib->tx_pause;
> -	ctrl_stats->MACControlFramesReceived = mib->rx_pause;
> +	ctrl_stats->MACControlFramesTransmitted = u64_stats_read(&mib->tx_pause);
> +	ctrl_stats->MACControlFramesReceived = u64_stats_read(&mib->rx_pause);
>  	/* ctrl_stats->UnsupportedOpcodesReceived */
> +
> +	mutex_unlock(&priv->reg_lock);
>  }
>  
>  static const struct ethtool_rmon_hist_range yt921x_rmon_ranges[] = {
> @@ -878,31 +898,33 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
>  	struct yt921x_mib *mib = &pp->mib;
>  
>  	mutex_lock(&priv->reg_lock);
> +
>  	yt921x_read_mib(priv, port);
> -	mutex_unlock(&priv->reg_lock);
>  
>  	*ranges = yt921x_rmon_ranges;
>  
> -	rmon_stats->undersize_pkts = mib->rx_undersize_errors;
> -	rmon_stats->oversize_pkts = mib->rx_oversize_errors;
> -	rmon_stats->fragments = mib->rx_alignment_errors;
> +	rmon_stats->undersize_pkts = u64_stats_read(&mib->rx_undersize_errors);
> +	rmon_stats->oversize_pkts = u64_stats_read(&mib->rx_oversize_errors);
> +	rmon_stats->fragments = u64_stats_read(&mib->rx_alignment_errors);
>  	/* rmon_stats->jabbers */
>  
> -	rmon_stats->hist[0] = mib->rx_64byte;
> -	rmon_stats->hist[1] = mib->rx_65_127byte;
> -	rmon_stats->hist[2] = mib->rx_128_255byte;
> -	rmon_stats->hist[3] = mib->rx_256_511byte;
> -	rmon_stats->hist[4] = mib->rx_512_1023byte;
> -	rmon_stats->hist[5] = mib->rx_1024_1518byte;
> -	rmon_stats->hist[6] = mib->rx_jumbo;
> +	rmon_stats->hist[0] = u64_stats_read(&mib->rx_64byte);
> +	rmon_stats->hist[1] = u64_stats_read(&mib->rx_65_127byte);
> +	rmon_stats->hist[2] = u64_stats_read(&mib->rx_128_255byte);
> +	rmon_stats->hist[3] = u64_stats_read(&mib->rx_256_511byte);
> +	rmon_stats->hist[4] = u64_stats_read(&mib->rx_512_1023byte);
> +	rmon_stats->hist[5] = u64_stats_read(&mib->rx_1024_1518byte);
> +	rmon_stats->hist[6] = u64_stats_read(&mib->rx_jumbo);
> +
> +	rmon_stats->hist_tx[0] = u64_stats_read(&mib->tx_64byte);
> +	rmon_stats->hist_tx[1] = u64_stats_read(&mib->tx_65_127byte);
> +	rmon_stats->hist_tx[2] = u64_stats_read(&mib->tx_128_255byte);
> +	rmon_stats->hist_tx[3] = u64_stats_read(&mib->tx_256_511byte);
> +	rmon_stats->hist_tx[4] = u64_stats_read(&mib->tx_512_1023byte);
> +	rmon_stats->hist_tx[5] = u64_stats_read(&mib->tx_1024_1518byte);
> +	rmon_stats->hist_tx[6] = u64_stats_read(&mib->tx_jumbo);
>  
> -	rmon_stats->hist_tx[0] = mib->tx_64byte;
> -	rmon_stats->hist_tx[1] = mib->tx_65_127byte;
> -	rmon_stats->hist_tx[2] = mib->tx_128_255byte;
> -	rmon_stats->hist_tx[3] = mib->tx_256_511byte;
> -	rmon_stats->hist_tx[4] = mib->tx_512_1023byte;
> -	rmon_stats->hist_tx[5] = mib->tx_1024_1518byte;
> -	rmon_stats->hist_tx[6] = mib->tx_jumbo;
> +	mutex_unlock(&priv->reg_lock);
>  }
>  
>  static void
> @@ -912,33 +934,41 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
>  	struct yt921x_priv *priv = to_yt921x_priv(ds);
>  	struct yt921x_port *pp = &priv->ports[port];
>  	struct yt921x_mib *mib = &pp->mib;
> +	unsigned int start;
> +
> +	do {
> +		start = u64_stats_fetch_begin(&pp->syncp);
> +
> +		stats->rx_length_errors = u64_stats_read(&mib->rx_undersize_errors) +
> +					  u64_stats_read(&mib->rx_fragment_errors);
> +		stats->rx_over_errors = u64_stats_read(&mib->rx_oversize_errors);
> +		stats->rx_crc_errors = u64_stats_read(&mib->rx_crc_errors);
> +		stats->rx_frame_errors = u64_stats_read(&mib->rx_alignment_errors);
> +		/* stats->rx_fifo_errors */
> +		/* stats->rx_missed_errors */
> +
> +		stats->tx_aborted_errors = u64_stats_read(&mib->tx_aborted_errors);
> +		/* stats->tx_carrier_errors */
> +		stats->tx_fifo_errors = u64_stats_read(&mib->tx_undersize_errors);
> +		/* stats->tx_heartbeat_errors */
> +		stats->tx_window_errors = u64_stats_read(&mib->tx_late_collisions);
> +
> +		stats->rx_packets = u64_stats_read(&pp->rx_frames);
> +		stats->tx_packets = u64_stats_read(&pp->tx_frames);
> +		stats->rx_bytes = u64_stats_read(&mib->rx_good_bytes) -
> +				  ETH_FCS_LEN * stats->rx_packets;
> +		stats->tx_bytes = u64_stats_read(&mib->tx_good_bytes) -
> +				  ETH_FCS_LEN * stats->tx_packets;
> +		stats->rx_dropped = u64_stats_read(&mib->rx_dropped);
> +		/* stats->tx_dropped */
> +		stats->multicast = u64_stats_read(&mib->rx_multicast);
> +		stats->collisions = u64_stats_read(&mib->tx_collisions);
> +	} while (u64_stats_fetch_retry(&pp->syncp, start));
>  
> -	stats->rx_length_errors = mib->rx_undersize_errors +
> -				  mib->rx_fragment_errors;
> -	stats->rx_over_errors = mib->rx_oversize_errors;
> -	stats->rx_crc_errors = mib->rx_crc_errors;
> -	stats->rx_frame_errors = mib->rx_alignment_errors;
> -	/* stats->rx_fifo_errors */
> -	/* stats->rx_missed_errors */
> -
> -	stats->tx_aborted_errors = mib->tx_aborted_errors;
> -	/* stats->tx_carrier_errors */
> -	stats->tx_fifo_errors = mib->tx_undersize_errors;
> -	/* stats->tx_heartbeat_errors */
> -	stats->tx_window_errors = mib->tx_late_collisions;
> -
> -	stats->rx_packets = pp->rx_frames;
> -	stats->tx_packets = pp->tx_frames;
> -	stats->rx_bytes = mib->rx_good_bytes - ETH_FCS_LEN * stats->rx_packets;
> -	stats->tx_bytes = mib->tx_good_bytes - ETH_FCS_LEN * stats->tx_packets;
>  	stats->rx_errors = stats->rx_length_errors + stats->rx_over_errors +
>  			   stats->rx_crc_errors + stats->rx_frame_errors;
>  	stats->tx_errors = stats->tx_aborted_errors + stats->tx_fifo_errors +
>  			   stats->tx_window_errors;
> -	stats->rx_dropped = mib->rx_dropped;
> -	/* stats->tx_dropped */
> -	stats->multicast = mib->rx_multicast;
> -	stats->collisions = mib->tx_collisions;
>  }
>  
>  static void
> @@ -950,11 +980,13 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
>  	struct yt921x_mib *mib = &pp->mib;
>  
>  	mutex_lock(&priv->reg_lock);
> +
>  	yt921x_read_mib(priv, port);
> -	mutex_unlock(&priv->reg_lock);
>  
> -	pause_stats->tx_pause_frames = mib->tx_pause;
> -	pause_stats->rx_pause_frames = mib->rx_pause;
> +	pause_stats->tx_pause_frames = u64_stats_read(&mib->tx_pause);
> +	pause_stats->rx_pause_frames = u64_stats_read(&mib->rx_pause);
> +
> +	mutex_unlock(&priv->reg_lock);
>  }
>  
>  static int
> @@ -3423,6 +3455,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
>  
>  		pp->index = i;
>  		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
> +		u64_stats_init(&pp->syncp);
>  	}
>  
>  	ds = &priv->ds;
> diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
> index 3f129b8d403f..0f4231accf3e 100644
> --- a/drivers/net/dsa/yt921x.h
> +++ b/drivers/net/dsa/yt921x.h
> @@ -6,6 +6,8 @@
>  #ifndef __YT921X_H
>  #define __YT921X_H
>  
> +#include <linux/u64_stats_sync.h>
> +
>  #include <net/dsa.h>
>  
>  #define YT921X_SMI_SWITCHID_M		GENMASK(3, 2)
> @@ -530,55 +532,61 @@ enum yt921x_fdb_entry_status {
>  #define yt921x_port_is_external(port) (8 <= (port) && (port) < 9)
>  
>  struct yt921x_mib {
> -	u64 rx_broadcast;
> -	u64 rx_pause;
> -	u64 rx_multicast;
> -	u64 rx_crc_errors;
> -
> -	u64 rx_alignment_errors;
> -	u64 rx_undersize_errors;
> -	u64 rx_fragment_errors;
> -	u64 rx_64byte;
> -
> -	u64 rx_65_127byte;
> -	u64 rx_128_255byte;
> -	u64 rx_256_511byte;
> -	u64 rx_512_1023byte;
> -
> -	u64 rx_1024_1518byte;
> -	u64 rx_jumbo;
> -	u64 rx_good_bytes;
> -
> -	u64 rx_bad_bytes;
> -	u64 rx_oversize_errors;
> -
> -	u64 rx_dropped;
> -	u64 tx_broadcast;
> -	u64 tx_pause;
> -	u64 tx_multicast;
> -
> -	u64 tx_undersize_errors;
> -	u64 tx_64byte;
> -	u64 tx_65_127byte;
> -	u64 tx_128_255byte;
> -
> -	u64 tx_256_511byte;
> -	u64 tx_512_1023byte;
> -	u64 tx_1024_1518byte;
> -	u64 tx_jumbo;
> -
> -	u64 tx_good_bytes;
> -	u64 tx_collisions;
> -
> -	u64 tx_aborted_errors;
> -	u64 tx_multiple_collisions;
> -	u64 tx_single_collisions;
> -	u64 tx_good;
> -
> -	u64 tx_deferred;
> -	u64 tx_late_collisions;
> -	u64 rx_oam;
> -	u64 tx_oam;
> +	union {
> +		struct {
> +			u64_stats_t rx_broadcast;
> +			u64_stats_t rx_pause;
> +			u64_stats_t rx_multicast;
> +			u64_stats_t rx_crc_errors;
> +
> +			u64_stats_t rx_alignment_errors;
> +			u64_stats_t rx_undersize_errors;
> +			u64_stats_t rx_fragment_errors;
> +			u64_stats_t rx_64byte;
> +
> +			u64_stats_t rx_65_127byte;
> +			u64_stats_t rx_128_255byte;
> +			u64_stats_t rx_256_511byte;
> +			u64_stats_t rx_512_1023byte;
> +
> +			u64_stats_t rx_1024_1518byte;
> +			u64_stats_t rx_jumbo;
> +			u64_stats_t rx_good_bytes;
> +
> +			u64_stats_t rx_bad_bytes;
> +			u64_stats_t rx_oversize_errors;
> +
> +			u64_stats_t rx_dropped;
> +			u64_stats_t tx_broadcast;
> +			u64_stats_t tx_pause;
> +			u64_stats_t tx_multicast;
> +
> +			u64_stats_t tx_undersize_errors;
> +			u64_stats_t tx_64byte;
> +			u64_stats_t tx_65_127byte;
> +			u64_stats_t tx_128_255byte;
> +
> +			u64_stats_t tx_256_511byte;
> +			u64_stats_t tx_512_1023byte;
> +			u64_stats_t tx_1024_1518byte;
> +			u64_stats_t tx_jumbo;
> +
> +			u64_stats_t tx_good_bytes;
> +			u64_stats_t tx_collisions;
> +
> +			u64_stats_t tx_aborted_errors;
> +			u64_stats_t tx_multiple_collisions;
> +			u64_stats_t tx_single_collisions;
> +			u64_stats_t tx_good;
> +
> +			u64_stats_t tx_deferred;
> +			u64_stats_t tx_late_collisions;
> +			u64_stats_t rx_oam;
> +			u64_stats_t tx_oam;
> +		};
> +
> +		u64_stats_t stats[39];

The above looks bug prone if the future chip revisions will support more
stats.

/P


