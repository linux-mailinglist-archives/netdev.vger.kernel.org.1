Return-Path: <netdev+bounces-284247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD/xOlmi+WnR+QIAu9opvQ
	(envelope-from <netdev+bounces-284247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 09:55:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F27C34C8561
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 09:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12D5830074F5
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 07:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B243C1985;
	Tue,  5 May 2026 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="SFRfJg7c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1EE3E3159
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967701; cv=none; b=Yzb+Oi5q60QttMZ4UbC37GETIEm09awbGtpo4uP4ZWpUref8m2RnnZDbYoNxXAbc+RFp5H+QM0rUnrxWTYbWyhghMXlI89PTeL78SYFiotHUnid7pX0gScwBH7+l/3xYf2gmWajAb7MjKPav18bnUpIR3S3VbM9TseYlmoh6wGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967701; c=relaxed/simple;
	bh=1+aO1jsqt4+7D7eVQn3EaDYl7VdHvbbO7pn/PcTHylE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjhfsKsPadEyB70t3yQGpTaO4D37OaF6KZhDSCMhFAvKWWl8YPHPx7QBrMwJsewKO+nM0FAQElb79HKQRhuJw9j/IExXhOJSnafk5IbtNJylUekfcUS51d25Qog8OVXQgVqhRezYSVRUbUblVNB98a6ohA0bObZiKqUngS9GMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=SFRfJg7c; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so47198235e9.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 00:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1777967697; x=1778572497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9GZJftakxhfNgeo2AWQ3HNwbl0xuJXtG3r/LfqS/vsU=;
        b=SFRfJg7cDwL6ILqezIGvWWELPkl/+facN02WL0YURQEF/tUZf/99AaNm/qnruInjUV
         A1sFj/H2hbvqwnlSPFJiWHB/yNL/KTLeHvoefd05pSN6znlY9BTWQ7TjshgAHsbk2kbe
         zCVt9KAkQAQa8eEtXN8z9zzTUi4KN/FKu4zW2Ozh8RL/pMl/rTDzDod/EkeDg3qtDVAD
         k4BQRITyaI6oo/dByynASxlwcp/ewxsLt6k9n6bum7Kzn975QpF5INu2hR8RqLYm3Fwc
         Ub0dsix6fv8ow3C6UDKKm+HmJkzu2VB69lh3+XZAN0PipHo7hm2or5r6jEZOzviMOatF
         /11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967697; x=1778572497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GZJftakxhfNgeo2AWQ3HNwbl0xuJXtG3r/LfqS/vsU=;
        b=nlTHiZDCwG5N4R3h7zRDyUfrAcXHAnx7Ts+tgdnGeNXc1YzkY62gU5Ma6gLubU7fOr
         byKIVqToIQMeQDpVWuY3Zzv4mxscNnXT4JKOBMxybHfX/NouhTPLtpdm98TdWY3ezPSI
         KkV9ZZygFGjfZe3ybLq0xJNrHreBvOg0HgK1uML2e6k2NJMN71veDDLmLZxeZl+hzuwK
         llLJJPlPjNPo9DxAf4z6qyrxWtuVurrueYSVU8EA3jmg5jFjfaoxykyjlRNH3ROHgzJa
         lx1qZ2Gy+yNEiniNV1ODP14c+h5f+NB0XvJ07Yyp6b+KQ13qySJnUVjQZHaw5790KBz4
         9kNg==
X-Forwarded-Encrypted: i=1; AFNElJ8gfec0AkmsRw5nblqpcJCGp/UBwJfPRpXBeKJHg/HNaCM31ncqDIxs1AhTO+yqjO18YXO5Y18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/p4tJkGWzD9iWj8zMGufgL5rI4GUVEfLMXaGENNcgFdJwXK9
	WxN7llaVTWCgfX8a05QzJTPA+OslrokdMUObP5U8aJ/1Y8bQcjik+Gr45/VBDDPsp6k=
X-Gm-Gg: AeBDiesM6OpkjHAI9UH2vQEl3ikqUS5daCLlGx6oK+kTEP+khSaqaMBEFwfysjcoSfM
	lpFGRrjcH7U5PvMf4XwuwbZe7C//x4RIHQ44xyTbwIlD5+GJQa5GXeXANLqR7rwZR5c30enVUjj
	9196YZTWXaHA//iKjXRRH1rXOk+7pa/Teh3uRqEG1sLY0FW9ychGhMbkaIBLMqBlhHbmrne3BSA
	ZCv3qAd133l72La9jI8RnI+XY4OcktHFo2a3EsFf2S/Y439G7V/FbbLtOgWxZfpN/sn7Kwwik3z
	iJDnF/hy4809ZGDu/jWZncWhgpjejvmVmFIgi6A0N+AX1nIdI8lca4c5TLEnNbRzKS5Fx1UI7xb
	WTtLJw+YrCn5smkrZrYCv7ZtwFUdvfZgo9sIMrp1T8NVVyKGuJjhyIwzOPHohJ7laX22HJ+4ah3
	8eICnkDOxNA09ebZAFabh1ELWFsbbDCxTXd0ybqGBp+FaLaKRIrlxOEF/UpCnLhYFN
X-Received: by 2002:a05:600c:811a:b0:48a:93f8:dd02 with SMTP id 5b1f17b1804b1-48d18bdc477mr28515045e9.14.1777967696952;
        Tue, 05 May 2026 00:54:56 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb3427fsm544750905e9.0.2026.05.05.00.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 00:54:56 -0700 (PDT)
Message-ID: <80a0822d-7f31-4191-b434-8c84b37b4900@blackwall.org>
Date: Tue, 5 May 2026 10:54:55 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: bridge: replace simple_strtoul with
 kstrtoul
Content-Language: en-US, bg
To: Aadarsh Chandra <aadarsh.official.xz@gmail.com>, idosch@nvidia.com
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260505074515.636244-1-aadarsh.official.xz@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260505074515.636244-1-aadarsh.official.xz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F27C34C8561
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284247-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com];
	DKIM_TRACE(0.00)[blackwall.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:email,blackwall.org:dkim,blackwall.org:mid]

On 05/05/2026 10:45, Aadarsh Chandra wrote:
> The simple_strtoul() function is deprecated. It does not handle
> errors or overflows correctly. Replace it with kstrtoul() in
> brport_store() to ensure that invalid user input is caught and
> returned as an error.
> 
> v2: target net-next and simplify by reusing the ret variable as
>      suggested by Nikolay Aleksandrov.
> 

Nice that you've given us the changes, but it should be below...


> Signed-off-by: Aadarsh Chandra <aadarsh.official.xz@gmail.com>
> ---

... here, so it's not included in the commit message.

>   net/bridge/br_sysfs_if.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
> index 1f57c36a7fc0..cdecc7d1260c 100644
> --- a/net/bridge/br_sysfs_if.c
> +++ b/net/bridge/br_sysfs_if.c
> @@ -318,7 +318,6 @@ static ssize_t brport_store(struct kobject *kobj,
>   	struct net_bridge_port *p = kobj_to_brport(kobj);
>   	ssize_t ret = -EINVAL;
>   	unsigned long val;
> -	char *endp;
>   
>   	if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
>   		return -EPERM;
> @@ -339,8 +338,8 @@ static ssize_t brport_store(struct kobject *kobj,
>   		spin_unlock_bh(&p->br->lock);
>   		kfree(buf_copy);
>   	} else if (brport_attr->store) {
> -		val = simple_strtoul(buf, &endp, 0);
> -		if (endp == buf)
> +		ret = kstrtoul(buf, 0, &val);
> +		if (ret)
>   			goto out_unlock;
>   		spin_lock_bh(&p->br->lock);
>   		ret = brport_attr->store(p, val);

You should wait 24 hours before posting a new version.
The patch looks good to me, if there's a need for v3
please add my:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

Cheers,
  Nik




