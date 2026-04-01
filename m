Return-Path: <netdev+bounces-274105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP6bBCIgzWnOaAYAu9opvQ
	(envelope-from <netdev+bounces-274105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:39:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6386937B5DD
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A7E0301DCDD
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 13:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DBA2D877B;
	Wed,  1 Apr 2026 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3yhoKAc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460EB3FA5ED
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048561; cv=none; b=ZYwUkY52Jg6Z5KakVI8w1UGOatQtIo/ZUluXuXgO+MwfBPgIjPOupWNQNXTeEoVbxSmG9zHljyO1nUGY0rNWQi15/EqoFDU97M9Owo8968BH6mzd1T+VVRThWQyk58xIE0wEp6jYMt2jgHAfGbjb9QEfXFbZk9QMKEMkI4O1ErQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048561; c=relaxed/simple;
	bh=TdoZAx6NHzJTQTX8z6h1aWvO3GZEkza8AhbjDZbChaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6FtKHc2g9n/TP5ll67gesIcszY+0RmBaiwNBzmRnROHcQXqwDSUWjMDnNdjefK60kEQkGPlU937ka0gKd7wZfNRJZ4HTIqjcGLy+zy91IulyJfWdmS+71+MuUIab76ABVkB002nPINV+1tYF3uS5jXDB6nZFs+Nt2SWkIiJDY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3yhoKAc; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-602b7085a52so4257340137.3
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 06:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775048558; x=1775653358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VvXeNfJpmwqJzzeStLLM74ONDGrU8OkMNY/rSfA+Ulo=;
        b=L3yhoKAcKR/EAAET3dBfZc3TsppGUEj0dDKbJ5doctPgcsKwIqbII9woNhBozGtWFs
         3p/+5eSEsTCrNeGPBuBgpWWHNzUJfUkhiElFyuYdGCjH2SkkdVHT+n//YkgNtwfAqUql
         6IBpAbgKr9Krl4gliKBy2bF4vXNR7SMxmyCoMWjviNMLuwRir9M0PbFuZ4zDHsQzCGAL
         5De6OzwBMI2fTlFD4hdlCi/75jrmh4iv+ASeJh01vieRLesewJfQ+ZzzrP34aCBjVCVN
         ufF9PLKs4l8KQnn2ijqTpluEyQrNS57R7l79iBJPn7L+5cHlB+Ik/Dga+4NrXbnu0ES4
         G0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775048558; x=1775653358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VvXeNfJpmwqJzzeStLLM74ONDGrU8OkMNY/rSfA+Ulo=;
        b=HrLLkKfQK51f+wMw7Fqh/vTRk3aLEoMu8hYgWR6jwNlxE9EKGj8/KtRJumn58YCAT9
         P1HBN9R6GyVPhHneZq04FswzCTV+3oq8rpBk9CpkS6MsOZzrp4x2a6tdthbrWecTM0FG
         BXscniNBqle4WHAFzdsPTUR+Bmji1mCquuSV9PacUpNXsWMDim28mBGKpvV+0BMKXnRi
         l6EyDLbHT2NqP8A2RMgBLnQBcBTgZV0+CQbNcao3XxAUZgX6+i9EC+Fi4/Pa/ktYBb0c
         bNZmmviachefMMyWvv57jNCARKniLPNDmAd31XQRAI1h9+W6t+XXpFO1xamU8tHLAc7Z
         AgqQ==
X-Gm-Message-State: AOJu0Yw5JEMC1NqZx3FKVNBR5YubpmihoOY3WxlcfYN4Uk14+Gzuue7R
	rf0M4hdx7ROTBoMlv3IW02v9s5yWevEM+bVxKnbXydFYyDLFSjuo2s5E
X-Gm-Gg: ATEYQzwWKiBJbysAZmKYGTA6U8NCkT+eD0/K4+iWkG/9BavZqIj9WinFXBHbQJJKbJV
	b045qQjqHPhhZ3ijgJ7rT5xuHAD6JGoauIkUa5U+lQK5VeERR6Yo1/3qbginIz0JFukwwv1YlqN
	yv1eNyVRXN5c/aWczyarNZ0thAnLxvBasSrc/OSROmXtty0uBJ0zp+IaXMXYtAcrhX07gnZjMmt
	bXqnm6fRGrY8laeQoNbAScg2vsIf07xImrd4wXlQSk6FQkBK5S4UUVoZCxbc9yOgXpNAI6PSwtH
	Srcy6E+6AcwzZBC+hhnj0pa9cH11zvP+5O3q7tDKMfHJ3XDQM3xGBGpToVFitPE/sd5LibgEf8R
	6c3dvzd0qFe2rX8+O3FcnhT3D9YQdTdZZMSVIq5lMhcmBp7mbuQRDQfYmug7M7bFDrPX1A0T/Oi
	6u/mSEitk8RgAuPrLUMQghhjNh5dFDyCpUYHc8ahg/vEcDymqIT8K8hOUWfB2a4mbUtFp6mRNEd
	k+RzWb5sqgkzPjW6uqpTOdW8Bo=
X-Received: by 2002:a05:6102:a49:b0:5ff:dcb9:9222 with SMTP id ada2fe7eead31-60567d42552mr1316794137.7.1775048557623;
        Wed, 01 Apr 2026 06:02:37 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:e986:b7e3:22ac:30c3? ([2620:10d:c091:500::1:d15c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecc091f14sm118065586d6.16.2026.04.01.06.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 06:02:36 -0700 (PDT)
Message-ID: <1ec0c6e5-4c5a-436f-8d43-6f6e31e66b02@gmail.com>
Date: Wed, 1 Apr 2026 09:02:35 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 net-next 3/5] psp: add a new netdev event for dev
 unregister
To: Wei Wang <weibunny.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Wei Wang <weibunny@fb.com>
References: <20260330223143.2394706-1-weibunny.kernel@gmail.com>
 <20260330223143.2394706-4-weibunny.kernel@gmail.com>
 <1d013236-e945-46fc-8acb-c7ab9ac32a1f@gmail.com>
 <CAGqc4nX096xJKyxdXrpXkHert6uCqHLKo3Z2idw4UXSdKw0O0g@mail.gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <CAGqc4nX096xJKyxdXrpXkHert6uCqHLKo3Z2idw4UXSdKw0O0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274105-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 6386937B5DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/31/26 5:51 PM, Wei Wang wrote:
> On Tue, Mar 31, 2026 at 6:30 AM Daniel Zahka <daniel.zahka@gmail.com> wrote:
>>
>> On 3/30/26 6:31 PM, Wei Wang wrote:
>>> +static bool psp_notifier_registered;
>>> +
>>> +/**
>>> + * psp_attach_netdev_notifier() - register netdev notifier on first use
>>> + *
>>> + * Register the netdevice notifier when the first device association
>>> + * is created. In many installations no associations will be created and
>>> + * the notifier won't be needed.
>>> + *
>>> + * Must be called without psd->lock held, due to lock ordering:
>>> + * rtnl_lock -> psd->lock (the notifier callback runs under rtnl_lock
>>> + * and takes psd->lock).
>>> + */
>>> +void psp_attach_netdev_notifier(void)
>>> +{
>>> +     if (READ_ONCE(psp_notifier_registered))
>>> +             return;
>>> +
>>> +     mutex_lock(&psp_devs_lock);
>>> +     if (!psp_notifier_registered) {
>>> +             if (!register_netdevice_notifier(&psp_netdev_notifier))
>>> +                     WRITE_ONCE(psp_notifier_registered, true);
>>> +     }
>>> +     mutex_unlock(&psp_devs_lock);
>>> +}
>> ...
>>> +int psp_device_get_locked_dev_assoc(const struct genl_split_ops *ops,
>>> +                                 struct sk_buff *skb, struct genl_info *info)
>>> +{
>>> +     psp_attach_netdev_notifier();
>>> +
>>> +     return __psp_device_get_locked(ops, skb, info, false);
>>> +}
>>
>>   From an AI review, but seems plausible to me:
>>
>> psp_device_get_locked_dev_assoc() will proceed even in the path where
>> register_netdevice_notifier() and psp_notifier_registered stays false.
>>
> This behavior is intended. In case register_netdevice_notifier() fails
> for some reason, this current dev_assoc will proceed but the next
> dev_assoc operation will try to register_netdevice_notifier() again.


That doesn't sound correct to me. If the notifier is not registered, but 
the dev-assoc command succeeds, then an entry can leak in the 
psd->assoc_dev_list during a NETDEV_UNREGISTER.


