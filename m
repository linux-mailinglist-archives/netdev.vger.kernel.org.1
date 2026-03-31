Return-Path: <netdev+bounces-273636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBipIcDNy2luLwYAu9opvQ
	(envelope-from <netdev+bounces-273636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:36:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0631836A562
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 15:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 956E5306BE29
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 13:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEE23290CB;
	Tue, 31 Mar 2026 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgYHReJr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32094329E4B
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774963850; cv=none; b=rWeq1lEaO1dqlYTIdbad8f5+846weR7uEMih3YZuYCzQeBitNIIXtHaTY8EjBGJ8FeKFspBPfulKX+A6RA26CYD8xTwGmzpaMLnv0kXbFYeRWKCaK68XilihWXhHmoLCFJwdyaQXVE2Sq1PXpZriENr5W31HFpPksX3mD+UFHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774963850; c=relaxed/simple;
	bh=a6/h0nRA/suTsqPE/WawpkvnxzoGb6AularCVcUHJ5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gf0u/z4NCdKqSpbUuaGzsi6hNMzVwDgHXcTJhHCzl5YtBU6826kpJsocccykASN+7tQqOQjDkm/2oOGwzTnef2Q4wU3i/DdN83R1tWNzSpEymNqUTofxnLIWvELwSMsq8aVoRffw+dsKCXBXH6Iw19bcFuCjK0+GJpyfhFgZw0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgYHReJr; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a3342d301aso8167696d6.2
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 06:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774963848; x=1775568648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oA+nmByjrigQwAhG7tnX73MVu+dN3/EPL8uAihH9kgY=;
        b=RgYHReJrLGAAJTzMOtPuIVwU5ej/y+Fj6ZNWdudZ+fUlyVu172ia9cNh+zLSVNojU4
         /sn6BJvFleMqSfIRLHnl58cPKHq+u/QvMTaFnRDLXjf4DhUKJhTuyXgz8uxBK4LlwBTh
         PHIrOi4iv/HNXb5rRE9nGzMqPJ3P1o1EAbRS1E6HEsUacr6arY0HSSUpbSlnPoYrqB43
         2ltSm2/2kIM7Lr6EiQHsXDDm5cAMKSB5CEIXTAWwroBuuDjq9mkwSG+H6wLrA6Euzo0N
         fpyTFtQUkI4fFAkcSTFbE4eWYNg3Gmnfaow8sBgqD2cBDh5T6BbO8z9GB6a0wxaHxiBu
         FqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774963848; x=1775568648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oA+nmByjrigQwAhG7tnX73MVu+dN3/EPL8uAihH9kgY=;
        b=alYOQlfZEylZgTdDYrrDpZnzg35N0b8fn/3a3Dxsrhy8Csx26WODUkW7iKdBR3rp+9
         0M925Oypu9c5GzdLTMHybws4w39ruD2swvDTNkvfSSzTA+WWGVFSXF/rwlfG2/RZNflP
         oXfMcGswBNdjn19HtXbPB/Y6YruNjRAui6/7P/yk6e6QF5IiEX/MkSpsmzIBOVJPZ2FU
         AfatTdFSAEGnPvdy3RpG584+ppx5CkRPn3C6QFKIMMgD0T97uot7uZVH31Yu4lXz7Pdv
         blMCLQ0Vz1GGD1ts99WTCaLRPASzFzMGCz6qVoHS/FJwDVkrVh+HZr18eYbsISCdL6JZ
         5HCw==
X-Forwarded-Encrypted: i=1; AJvYcCXcJRK6BWk7a2ZgStupN88j9T/UEdj1VM+h1/7aCR5X6D40vDhydJu2F2pp2GAAJINvtY63xbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWWfjmYfodLgeyyh+/UsMk/C3emwHtNW3vn+rq1ak/z5suZEue
	cfRZee/OSj3qssR+7gee0zFR+72IupWhSP0vZ0NWOPWYokPEnE+dP8U3Dv2ngsEd
X-Gm-Gg: ATEYQzwZqx0Qczco5psiAHf60UI/qIcHhXqrLqq8kodG3/vmkx4j01+knDmOtEoqNPq
	4wUGfjWneibqqzc1Yd4ldBHL1wC1kY0Z8WkBDLh7prM3T7cOEf+gb7O0rctzr6bE/TpskuFlz8p
	+XdE+lfUUrxuUWw2CaAuZQsZkEfnV1r3QUnq/6uTWiw6kCN8co+mkLn84zZFvEXMkM6jbBC+Obu
	FSjP9HPoLIJFuMJy9qYZAiWwbmVdzviA5YZZLDnIgJv+BYngxmj4RKiByscWjV3DvChtRW50SG9
	zxkOv2oSxe4xzpOxalNlSmRe3pQny+4407XtRg83wefMFOu3j4cZtgvQxh93KL3Aj7NYksvpgYj
	WGy1U3hZnC830hNcMDWQ6PgPfRUvlNX5bn1LAtQyw685QArvOA7+4Fk32PsqAtktdsp30XUCO1V
	RJ8v+Sr5bNsYvM2+9/M7vg7VUcrLf+VgfAjlNb+e/BThTlyCeSEhnKxcD26GA5EBTXP+9yg/jnX
	D/KiHJlGAO7INI=
X-Received: by 2002:a05:6214:252c:b0:89c:ba96:5fd7 with SMTP id 6a1803df08f44-89ce8f7e986mr218048546d6.53.1774963847675;
        Tue, 31 Mar 2026 06:30:47 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:c599:9014:d27e:9c09? ([2620:10d:c091:500::1:4033])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ed02364e2sm90101416d6.45.2026.03.31.06.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 06:30:47 -0700 (PDT)
Message-ID: <1d013236-e945-46fc-8acb-c7ab9ac32a1f@gmail.com>
Date: Tue, 31 Mar 2026 09:30:46 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 net-next 3/5] psp: add a new netdev event for dev
 unregister
To: Wei Wang <weibunny.kernel@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
References: <20260330223143.2394706-1-weibunny.kernel@gmail.com>
 <20260330223143.2394706-4-weibunny.kernel@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260330223143.2394706-4-weibunny.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273636-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0631836A562
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/30/26 6:31 PM, Wei Wang wrote:
> +static bool psp_notifier_registered;
> +
> +/**
> + * psp_attach_netdev_notifier() - register netdev notifier on first use
> + *
> + * Register the netdevice notifier when the first device association
> + * is created. In many installations no associations will be created and
> + * the notifier won't be needed.
> + *
> + * Must be called without psd->lock held, due to lock ordering:
> + * rtnl_lock -> psd->lock (the notifier callback runs under rtnl_lock
> + * and takes psd->lock).
> + */
> +void psp_attach_netdev_notifier(void)
> +{
> +	if (READ_ONCE(psp_notifier_registered))
> +		return;
> +
> +	mutex_lock(&psp_devs_lock);
> +	if (!psp_notifier_registered) {
> +		if (!register_netdevice_notifier(&psp_netdev_notifier))
> +			WRITE_ONCE(psp_notifier_registered, true);
> +	}
> +	mutex_unlock(&psp_devs_lock);
> +}
...
>   
> +int psp_device_get_locked_dev_assoc(const struct genl_split_ops *ops,
> +				    struct sk_buff *skb, struct genl_info *info)
> +{
> +	psp_attach_netdev_notifier();
> +
> +	return __psp_device_get_locked(ops, skb, info, false);
> +}


 From an AI review, but seems plausible to me:

psp_device_get_locked_dev_assoc() will proceed even in the path where 
register_netdevice_notifier() and psp_notifier_registered stays false.



