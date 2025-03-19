Return-Path: <netdev+bounces-176110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7EFA68D50
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 14:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2642B165076
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4547A254852;
	Wed, 19 Mar 2025 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgBqyot8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CBA1EB5F0
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389195; cv=none; b=YGwVAdAqmMMHtcn2skEOKwuodYubcqrnWsuaejB5ziYLXUkZj7riD0nL67pRO14ZukoMa9uMkeEKtEWowHh6kaTwFW3K9CwCXmjIUT6XL4zqewm190HDkslJhzZXpbHyChfAHvYlYNOUFU1iRBdmzYAsO4+7pVTkirbFpaa+ZKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389195; c=relaxed/simple;
	bh=7HJBss4m1jXmd2a1u10ukbX3MwZxUGFrNjKuUF3b92o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O6ov0uIaNr7HDHbUmpp5VvYipG9UuA06u+uWi1d4dcSh1ScfbpefBH1gD71IKiWIFccBRgoxW5RnY3cEdbhPWBepKZOqsY3zTot8DBrP9Enq0uH7rYb9o0HA/ldMwRlJd23dg4A/DZkuWyzfL1/ZmA1dAHpm4iOqNzskdkDzsk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgBqyot8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742389192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJi4K6M4263BNggmheBmASOREOqSLOqqexbufq6mDCg=;
	b=hgBqyot8gyj/GAHV5J93w68Dcvj0XPs5/kgOAmB/LjrxXMi+0FlVMjjIM+dXIg29+T4Cfm
	z64ehG/VLwWGojF684aZM+sJ0C78Wpp/Gg81RizqJDlpSKGqTIUTypH7aB8uYDpR1ha6qQ
	P3gzQxtFen2PWTiSxeYi7uiQ0Duciso=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-ifoXZ9ynPmmRUziykZJzug-1; Wed, 19 Mar 2025 08:59:51 -0400
X-MC-Unique: ifoXZ9ynPmmRUziykZJzug-1
X-Mimecast-MFC-AGG-ID: ifoXZ9ynPmmRUziykZJzug_1742389190
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43947979ce8so22777345e9.0
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 05:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742389190; x=1742993990;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJi4K6M4263BNggmheBmASOREOqSLOqqexbufq6mDCg=;
        b=mDyZ4EcmZSCf63qOiD6Q13HrTSOxPjTP2kwY945nesF74PbJmMmPR/3DoqE0T6ZhVQ
         bLTUzuyPMOeWyyxCM3Bz/dSZB9YC5wRTyicMAC4Kaf4hTe23OhZ/ye628n93h6eL/byx
         xfMYG/tq7yIDlOOCFeN2qyfltuKbNxeYa0tKHWP7EeHmKIMNaGNFgDA/zlyYg+vi8Pqc
         p02n9MpvM3VulF2sVBIBsiwfFSAVg448QoaINxbupmNW9iM0eHAkBB/CpyGTZczqHhnW
         ekBi8crg/iEx4ayUIj6pbEvXELWYoKwlX6zd8MgkXd2u7WeGErWrO3HKtMJPshlVF7Tb
         3VZQ==
X-Gm-Message-State: AOJu0YxvIP8miJNpg2DbsG59yjK+GB6KnL4QcOLShtTFAsZMaG3PVgI/
	z5kDVrngPXhwI6U9Cp0iPIU7hMytsTYLcQ2fNZlwjaNRLttbCEM62gdX7OM5RZBo4z+RxRbTHyI
	gq8VavXeOvVcXwIdh5jNbc4v3Bv8RL95/aee5UvGHTlABmy/hqVXRK0yarPRgfxZdTndMLDFLtq
	lc9FUmE/IexpYW/kHXRBo58k/Vp8qDr57rPLw=
X-Gm-Gg: ASbGnctPTSZC4uuVnjZBT7vRyPI3Mb7VgqVGk1Tq4nFM7PjkpwmgkS0jVOAYb/t64DK
	ORWAJBZ3qDYTIUpsh5eBGUTQxTt5v1aN17BxYSD7gjiZaa4NhDbJFg+7RzJ4FqHXPRyaZPkJsJU
	FH7Wf06230q5oVTGDiKPqVWgBKa/xJy3jRypOdQdwujaarhEl5kEAdUawyk2EVwpTCfyDSmpfmM
	LDuHn6B/LkQMx/R/8Lmj6CYQLKXqPnU272ShHLI8X/kDiEK1omsL/HIFJljosUME6oRQP60Xlt6
	xtMAtDDkdTVr1Lu6SIWxYiZQz5hyQgRmEnKLW6PtXODScg==
X-Received: by 2002:a05:600c:3b20:b0:43c:fd1b:d6d6 with SMTP id 5b1f17b1804b1-43d43842e8bmr20064615e9.31.1742389189629;
        Wed, 19 Mar 2025 05:59:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfajU88rxTcshE/buLX8U5Fb7ePGoFi8DarcV2DrGwzRt66pgaY21evGTdfZ+4lhZk6u9r9g==
X-Received: by 2002:a05:600c:3b20:b0:43c:fd1b:d6d6 with SMTP id 5b1f17b1804b1-43d43842e8bmr20064355e9.31.1742389189135;
        Wed, 19 Mar 2025 05:59:49 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f378eesm18714415e9.6.2025.03.19.05.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 05:59:48 -0700 (PDT)
Message-ID: <0063ca98-93c2-4df4-9c0a-7a145e5409ee@redhat.com>
Date: Wed, 19 Mar 2025 13:59:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: introduce per netns packet chains
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <2a1893e924bd34f4f5b6124b568d1cdfc15573d5.1742320185.git.pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <2a1893e924bd34f4f5b6124b568d1cdfc15573d5.1742320185.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 7:03 PM, Paolo Abeni wrote:
> @@ -2463,16 +2477,18 @@ static inline bool skb_loop_sk(struct packet_type *ptype, struct sk_buff *skb)
>  }
>  
>  /**
> - * dev_nit_active - return true if any network interface taps are in use
> + * dev_nit_active_rcu - return true if any network interface taps are in use
> + *
> + * The caller must hold the RCU lock
>   *
>   * @dev: network device to check for the presence of taps
>   */
> -bool dev_nit_active(struct net_device *dev)
> +bool dev_nit_active_rcu(struct net_device *dev)
>  {
> -	return !list_empty(&net_hotdata.ptype_all) ||
> +	return !list_empty(&dev_net_rcu(dev)->ptype_all) ||

Sadly lockdep is not happy about the above, the caller can acquire
either the RCU lock and the RCU BH lock, and dev_net_rcu() is happy only
with the former - even if AFAICT either are safe. I'll use:

	/* Callers may hold either RCU or RCU BH lock */
	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());

	return !list_empty(&dev_net(dev)->ptype_all) ||
	       !list_empty(&dev->ptype_all);

/P


