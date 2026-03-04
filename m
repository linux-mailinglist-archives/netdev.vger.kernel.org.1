Return-Path: <netdev+bounces-263852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDkqBKpNqGmvsgAAu9opvQ
	(envelope-from <netdev+bounces-263852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:20:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A4B2027ED
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBAE430622E9
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C3433120E;
	Wed,  4 Mar 2026 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+PRTnhn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AF6330D4C
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636488; cv=none; b=T0gbLnS//quOiG5z9LzRzoXynaUcXzpZk5td2kzZCRc3eIDdKcK0VAsAQIYfd3eHHFTnGIzbZLTgKavMdG2NHqbRInatNXn2fNJiOdmUWiZo/pSyXHKuV9IViZW4x2KKqWZMD1B62UYm2VZvdnFOusbIVzrZ8cN8jsxotrxk/rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636488; c=relaxed/simple;
	bh=w6vRzXgHGt7cYqVyrIrXXCXIT2HmVqjf+F+dn5zh9Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sxdm9cMukmFEsa1dSNyAVYjluElN+dGi9K9nuevmLiLEgUsvvD5uLb7oyDlvxDqQdy4G3aRPdLJEtgjdTh7Y0o3IDzWFgiKXOa+3sULUm3vIbhI/pzXTleCcZ3+/gvuaHJvKw5/wp+g7pmjsTwLuzevs4FS0fiB3Ou94EApBV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+PRTnhn; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89a05955720so38209476d6.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 07:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772636486; x=1773241286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z8rewBuz8Z+gvTQ8hKm8VCf8SS5YjJN48oj4GRDK7aw=;
        b=U+PRTnhnXFeLPh4zgLL8H3k6OG8Zx4SN41mD7hhwCLVNhJAdEhZWN4l62Hq2rhgWnl
         F4G9OccVQlEacH2lu5nn00DTFIAk2cbQrVPNggFluHg8bc9ud3MC/o1jlbUtNmmP9Rdn
         fXD3/xegPYSL/UYMjD95Ta+j7SlGYvuNJ/zfvB1Ks8H8WhMyjjfosUDc+pWYa62WK6p4
         YKoOwspF0p1LYd0qgWzitTZ9mAeC/S2gdCXgQ+JoJXJphC57eNuO0wZY/RfVMiSqjWXY
         Vv2jvugtivzzXaRxEsZTuPYwz1WJ+AC2aJSkpBhJekZSDddWN3CkKDgRG3CJ94d7Ralk
         9YEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772636486; x=1773241286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8rewBuz8Z+gvTQ8hKm8VCf8SS5YjJN48oj4GRDK7aw=;
        b=BBjLEyqb5iKqL+aS1RW2Ixm/23E/9vWz522+lpExhc42GbdYDzf+rHHX7bfQbE2IVE
         MoXuqxiEmSGClrwvcj7WIal+mqkG3cWEsEztvjV3HC8EksxdO0Or70d0E07P51Nk192/
         JK27OMHcmsT4tlnSHhh39ya6M0Ku6xW/LcNo2+VdEmlHblZ9hM+DRlL7gfWJhi8PKRkO
         OgZZdys/2bMBkC6tlDbpJX4IJjnP5S493+iCg5Zs0H/iPdQkyJNas8I5kpGuvSIkhk2K
         2oz8kwAiBdY/Rlx93gNjNeAfvYzJvO32sCQURWz/uNPmbFMIe3Fut4K8WHliuXgDy325
         pWVw==
X-Forwarded-Encrypted: i=1; AJvYcCWD8hp/FObi8e7xUZnl2wqaKUVU4QYd6NGLRVlWIK2v/AVfARtCqSLdssZuOGfl3ha3e0lIGMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR3eloRnpntKoNZbZrolrXmPZzA1Ryc9pbzQWOhGfuMoQS5eJr
	aqjxd0v4Db4E1TKyavv4sDMP5K2DAbkenjeXke0VAOm+ss8nPHcS/nJs6d1Ofw==
X-Gm-Gg: ATEYQzxDoVBzkmRlg+oCs3b2zv7Ea1SS9lQbJiUcpJFpbPKSWSaP53ErxglgMD/YMxF
	YJXf2uBThkuKSg/rd3W6MJ9excR5U4/UO8rgECcjU9lsOmwlDkVmJN3jRPqVrdWq76BWao/8OxZ
	roSg1TLLYYBYKV14doGipeSXcig+IcRGElyrW0MftiV2IldD+/2xGXXPsp928w7iE59wzylQWyt
	Zj21eZzoDy+RBs9mjrCWAtWPvm1cR65pXRd+IAkuR/owls5JjKlQ3w4CGsNzgIibofT+vZ5K+3t
	c4ODKm2IaBrUHTpGTaBXd6V6A1bMf7Dsr9Yu+K4Aq2SwvpRPx6NxbdpXbHkUKyy5xDy7rwp/jdn
	M0Dg9Iev0s5JoGLKwRaxkOg09h3W0sDQf9vSj7i9P0fxRr5mEgceeww9bHNSS1okeOGjwl86lW/
	zXzpt7SnIUAFW/EZt/2HIeh6m64duMjTBbHXHQjAQceHvigqkIjg+E
X-Received: by 2002:a05:6214:20a2:b0:89a:110f:894e with SMTP id 6a1803df08f44-89a19979d21mr28403076d6.5.1772636466704;
        Wed, 04 Mar 2026 07:01:06 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1145:4:d19b:d485:ed5f:e15b? ([2620:10d:c091:500::3418])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a0fbdbcb0sm39366926d6.45.2026.03.04.07.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 07:01:06 -0800 (PST)
Message-ID: <6fde8fe3-1ac9-4a47-89f5-b6f759c2f103@gmail.com>
Date: Wed, 4 Mar 2026 10:00:59 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 5/9] psp: add unprivileged version of
 psp_device_get_locked
To: Wei Wang <weibunny@fb.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20260304000050.3366381-1-weibunny@fb.com>
 <20260304000050.3366381-6-weibunny@fb.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260304000050.3366381-6-weibunny@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A2A4B2027ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263852-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/3/26 7:00 PM, Wei Wang wrote:
> Add a place holder function called psp_device_get_locked_unpriv() which
> will be used for commands that are unprivileged and are used for
> exisiting commands like dev-dump, dev-get, rx-assoc, tx-assoc.
> Commands including dev-add/delete/change-ntf, key-rotate would keep
> using the privileged version.

It looks to me like get-stats is a command that is still using the 
privileged version. Is that intentional?
> @@ -72,7 +73,20 @@ int psp_device_get_locked(const struct genl_split_ops *ops,
>   		return -EINVAL;
>   
>   	info->user_ptr[0] = psp_device_get_and_lock(genl_info_net(info),
> -						    info->attrs[PSP_A_DEV_ID]);
> +						    info->attrs[PSP_A_DEV_ID],
> +						    false);
> +	return PTR_ERR_OR_ZERO(info->user_ptr[0]);
> +}
> +
> +int psp_device_get_locked_unpriv(const struct genl_split_ops *ops,
> +				 struct sk_buff *skb, struct genl_info *info)
> +{
> +	if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_ID))
> +		return -EINVAL;
> +
> +	info->user_ptr[0] = psp_device_get_and_lock(genl_info_net(info),
> +						    info->attrs[PSP_A_DEV_ID],
> +						    true);
>   	return PTR_ERR_OR_ZERO(info->user_ptr[0]);
>   }

nit: psp_device_get_locked() and psp_device_get_locked_unpriv() are 
entirely identical modulo true/false. You could probably have something 
like __psp_device_get_locked() with the common code.

