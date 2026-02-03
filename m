Return-Path: <netdev+bounces-256260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBAvMfXegWmDLQMAu9opvQ
	(envelope-from <netdev+bounces-256260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:41:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2C4D8876
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 12:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2EDD302AD4F
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 11:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E59F336ED1;
	Tue,  3 Feb 2026 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPFLi+XQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwLzhcDa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CC53191B4
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118894; cv=none; b=Fae1zrRPVdUL1tGCqRI7SfdMsE6t7M54MDCa9zoWd77cwkTwMiE2/kmRT1tj/H656tpIJuxBrE72v3qVv8WySDIMf3Wf99eFi7TKm99IQV06KBG0pfcX6aKK5CBnOBT4ueCe7U0F49h4uSCTsSirwXVaUw5J7sMFqBLxMsm9qG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118894; c=relaxed/simple;
	bh=OnOqQ7zGtU1F8PYO5hDacXXOIbXvG8vx3iFiBcA6zPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4JLKLJ33v53cIPuJJxQfD0hiGcra+z0GYtEPJoyehdjWcbACSkaZ+OXzbNLe9/dWGhpwmm8k8UD+PIEBdIGXDgA4N6SA07Rsroj2k29LAqWvjHnGq6AE1qcKGES7OP09I3XZxZp0mWgKbYVU7DjHuv9g7725cDxvVpi27JB5SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPFLi+XQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bwLzhcDa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770118890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7LSei9XQMCIZvXF7U7iOMHf2h9cD0XujsB63tiFmLxs=;
	b=UPFLi+XQlCCeUjY/FP/SY9T+wggV8igxr4ledstWpKr9p0Iic8jsrz6YDUnqBZtZqdoFkU
	maiYZBpOTMTqBkiXFAOyW2HvBrrwHulQ5V4gV5/GvwewKSFJXuvYJ7ThSJVH+d6uuz6u43
	JqUtF3wl4Ol40CloPnusuMIdxDuxPJk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-F8djFBD9OP-favAhZMS0PA-1; Tue, 03 Feb 2026 06:41:29 -0500
X-MC-Unique: F8djFBD9OP-favAhZMS0PA-1
X-Mimecast-MFC-AGG-ID: F8djFBD9OP-favAhZMS0PA_1770118888
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-65820bba158so5078745a12.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 03:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770118888; x=1770723688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7LSei9XQMCIZvXF7U7iOMHf2h9cD0XujsB63tiFmLxs=;
        b=bwLzhcDaegAdHlHMddcLaUKCbhwWuFVYyzu2424LkGDRaQ2FYuRPJ67nUBPBESP1w/
         zaah0huj2ad7G38WldxuA9RASTB6FnD+dj+qQoUr2Zubuj89Taa4/Kf1R4o06i9PU3p7
         7ZLugiwxusn5zGQOogvl08kHQmL9u8IwdLB4gxpP4PKZAOBK88gaPomtrA93dMT+lrSU
         G5FR0mRjvtodzyvMZ3yLiG9fC3uT2tl+2MnypHOVvQP29t+jMIYNtV3MFoCHDs6DgO07
         VmVYOZIu+FcTtyFbk+piOoThv7FIQ8xj7EOMQTwrm0DUzK8Lm9PGXo1CyulEANQ352tW
         xsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770118888; x=1770723688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LSei9XQMCIZvXF7U7iOMHf2h9cD0XujsB63tiFmLxs=;
        b=GDbR0HVNLT9FZucc28WoJ5w5VkkswBb4QPJk+/4t0jEjMti7zyhGIZrV1lZsxKoFlw
         5a/IGK0cVT6CI/rQql17ihKb6XegTaF0Ntec/wmpc8U10/MakWAmeWQpS2XTPieqJExg
         1QdOgLqqzG1s1c0od1DZMD350Q5RrcyfCEdVk6exm9dUMELA3e8RQiT+QAxRUpyInQ8k
         Ui+uxfTx6F5/Ku1yQmNpifd4ZR9+Ozt4rVEF+taP8MBhkJIMxpFvjr5W8jDoi54zJqiu
         JdaeWpcKf6rwQv08qGci3o30o5IxFAA6yMgjNEIt1krN+TeMTRwSuaQOTDq+Loo6vcpb
         cAQw==
X-Forwarded-Encrypted: i=1; AJvYcCUQuyvZUe3RF1U+KaGtYF+bOWhY+/hhPWBIL2g2F6KplxPzBBZmcTicwBczTV0N1LDWi3anZvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvhnXCvkUjt7G0YR/YqhOGB0hJtgRUFAz7el+99pXx2Wy9R+BI
	4/rOEkUn2Bpgepr32Z90EajQOEvq7G+FbEyh+Bzzytwcruh1Kh2VUlUFCw05p26j9mUsRRwKhp3
	fTAfSmcbIHxW7MfNJQP066/BDC9Y2BPPheprxG/8SA25rJ7guY4PgvB8Bjw==
X-Gm-Gg: AZuq6aI6Gsg7uA3HfuUXtYTc/Vzq8A20gLHpuS7/7sbykdGBZG/LwzlHcXO9l4YEPo7
	pWJJI4+eV62HEg7Y1Q3d29iGQSCu6w/Dfd/nnM1Dy3zycaBOKz6F2QvxHEm8wEP/NdjO3T3ko4f
	VytOy8gT3eFEyr1L3lsk8dAl7O/4uh067BgnzKbXUbt6Kk/TCt12jmjcT6Z+1O5T7P563iY0U3x
	ABNsylbJb+iATaEty44qz8anvi0YD10y+cH6aRwRfTamncAZ8GNAa78jLRev1nulfBMBLr9W/1T
	wfwPpi4FSXN2waw/hQ9L4zOp50R4X/MluqtXNA6SyGikQvYv+MVmb1ZwgzEUSUrYxq0Q4yj+QGO
	5i0STQAIS9Sk=
X-Received: by 2002:a05:6402:42c9:b0:649:64d3:1554 with SMTP id 4fb4d7f45d1cf-658de57433emr9791566a12.15.1770118888084;
        Tue, 03 Feb 2026 03:41:28 -0800 (PST)
X-Received: by 2002:a05:6402:42c9:b0:649:64d3:1554 with SMTP id 4fb4d7f45d1cf-658de57433emr9791546a12.15.1770118887634;
        Tue, 03 Feb 2026 03:41:27 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b44527eesm9043949a12.9.2026.02.03.03.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 03:41:26 -0800 (PST)
Message-ID: <cc23a37e-3b12-4dd5-89a9-ed8977601379@redhat.com>
Date: Tue, 3 Feb 2026 12:41:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: mscc: ocelot: add missing lock protection in
 ocelot_port_xmit()
To: Ziyi Guo <n7l8m4@u.northwestern.edu>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 UNGLinuxDriver@microchip.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260131044911.2257072-1-n7l8m4@u.northwestern.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260131044911.2257072-1-n7l8m4@u.northwestern.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256260-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6E2C4D8876
X-Rspamd-Action: no action

On 1/31/26 5:49 AM, Ziyi Guo wrote:
> ocelot_port_xmit() calls ocelot_can_inject() and ocelot_port_inject_frame()
> without holding ocelot->inj_lock. However, both functions have
> lockdep_assert_held(&ocelot->inj_lock) indicating that callers must hold
> this lock.
> 
> The correct caller felix_port_deferred_xmit() properly acquires the lock
> using ocelot_lock_inj_grp() before calling these functions.
> 
> Add ocelot_lock_inj_grp()/ocelot_unlock_inj_grp() around the injection
> code path in ocelot_port_xmit() to fix the missing lock protection.
> 
> Fixes: c5e12ac3beb0 ("net: mscc: ocelot: serialize access to the injection/extraction groups")
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
> ---
> v2:
>  - Add missing Fixes tag
> 
>  drivers/net/ethernet/mscc/ocelot_net.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
> index 469784d3a1a6..da8579abea1e 100644
> --- a/drivers/net/ethernet/mscc/ocelot_net.c
> +++ b/drivers/net/ethernet/mscc/ocelot_net.c
> @@ -559,15 +559,22 @@ static netdev_tx_t ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
>  	int port = priv->port.index;
>  	u32 rew_op = 0;
>  
> -	if (!static_branch_unlikely(&ocelot_fdma_enabled) &&
> -	    !ocelot_can_inject(ocelot, 0))
> -		return NETDEV_TX_BUSY;
> +	if (!static_branch_unlikely(&ocelot_fdma_enabled)) {
> +		ocelot_lock_inj_grp(ocelot, 0);
> +
> +		if (!ocelot_can_inject(ocelot, 0)) {
> +			ocelot_unlock_inj_grp(ocelot, 0);
> +			return NETDEV_TX_BUSY;
> +		}
> +	}
>  
>  	/* Check if timestamping is needed */
>  	if (ocelot->ptp && (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
>  		struct sk_buff *clone = NULL;
>  
>  		if (ocelot_port_txtstamp_request(ocelot, port, skb, &clone)) {
> +			if (!static_branch_unlikely(&ocelot_fdma_enabled))
> +				ocelot_unlock_inj_grp(ocelot, 0);

I'm under the impression this static_branch_unlikely() usage is racy,
i.e. on CONFIG_PREEMPT kernel execution could enter this branch but not
the paired lock.

What about moving the 'Check timestamp' block in a separate helper and
use a single static_branch_unlikely() branch? something alike the
following, completely untested and unfinished:

	if (!static_branch_unlikely(&ocelot_fdma_enabled)) {
		int ret = NETDEV_TX_OK;

		ocelot_lock_inj_grp(ocelot, 0);

		if (!ocelot_can_inject(ocelot, 0)) {
			ret = NETDEV_TX_BUSY;
			goto unlock;
		}

		if (!ocelot_timestamp_check())
			goto unlock;


		ocelot_port_inject_frame(ocelot, port, 0, rew_op, skb);
		consume_skb(skb);
unlock:
		ocelot_unlock_inj_grp(ocelot, 0);
		return ret;
	}

	if (!ocelot_timestamp_check())
		return NETDEV_TX_OK;
	ocelot_fdma_inject_frame(ocelot, port, rew_op, skb, dev);
	return NETDEV_TX_OK;

Well, after scratching the above, I noted it would probably better to
invert the two branches...

/P


