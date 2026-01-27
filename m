Return-Path: <netdev+bounces-253961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLiBCJP7eGlfuQEAu9opvQ
	(envelope-from <netdev+bounces-253961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:53:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A255B98AB9
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 958FE303FF38
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEB1315D3B;
	Tue, 27 Jan 2026 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAeT8chr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903D42882D3
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536344; cv=none; b=YAVUt3K3t3iJNeC/0+Ik9c4zC+ocxoW+v0gYj2oG1DMl2qYuVOTZvztaO59Yhn2z8LqUL2mSbfk7gy/uT+JblEAh6CXaSZY69l3l5y5rZBk1l9R7coOXRUMtQ9b22E9PEkDtaNzxNyOwL+usKIjX40QCBjL/4ftTH07kJUJWRuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536344; c=relaxed/simple;
	bh=aYxg4Dqhn1kcwiWeltZnhxMSQ0Dfv6gmTpqrR671ztA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fWrXZAGCxN/nUjZNHqIXXYe5wLzohiNV0DIKJf8IYPS2w64i4enNUIfPNaFblUvlmQ52axlIcjRvRw1gYuBcxXf4xZy7JypeFks452Bl4d6nhNFz5/vOsoKuIXYa5dPExt+tUsEW22BcKmADCu3SXNkBlYSt7zP/zDnc1UqNqGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAeT8chr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47ee2715254so31326075e9.3
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 09:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769536341; x=1770141141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pLBYWbsui6hyfGDW2xfXsKYIZKL/TJCUBE13OJ69KBE=;
        b=eAeT8chrmITQcKg/MER9LOpziAFT3S8iD8eO44uh/zQvsOxCZN5pnE4iCnCtIGQHmb
         dCjFQv5l4IhmTg3hdL+a0aJ7VyZbfO/nnOaWdUSEFKb+5dx27jTGAoTmVTjaPqJGpxWH
         upwHjhzt8vMMqDE86iPE8SaypuouNIZpfOztaEsrWBnukpPYUsglDIX1wn8E9b6X7z4J
         9vySXtmWrCknAdYqLlENoAp1zmzVAXdWaqGNpYbnEs3gvVCd6fjpAGzwxZJnOOmRP/00
         FwEq5l8OSwhkwkKn3632556bN7yYHDKfQTD55LGBp5d9dPM0/A+hn67xe6pvDWh6232F
         zSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536341; x=1770141141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLBYWbsui6hyfGDW2xfXsKYIZKL/TJCUBE13OJ69KBE=;
        b=BxBckPo98xk9zk3Iyhb07QhWIZ8Z2DD/uGiLY3ciyRYZ0yXjpogT63VFAPSsp/9LyE
         SVt8btQCFBG7BJEDr+n0BVFdql+ecebwooqlLwrMYzQv96m84NaXsvtWLCqzcHPR6ocL
         x8pMIJ0z/0qVFgjezmLwuikk0RbVd0bc3laAWri0dD02124cSbJhc8ZOjgDVeIVSfTaA
         1CSrIGMt7nzO3kW8M0XL2v9QJI6kyVcbiZu7RmwjnQvRWWxYoJHGw6TBDjhJPmaRPihF
         kBAdwdc6zmVaurJbc2d49GNLiSdv6C7mcZ8mjrIccm0i9vXpRQ4C0nQkkXOetBhFQBT8
         ubNA==
X-Forwarded-Encrypted: i=1; AJvYcCU8ifunAY0BOAMTkAtzx2edUBl6nPnpcnZ2phpbLGYwj0QWOLJBYWFBpMj/7AI/qbqlHhBghv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmNhyvi5QduUxq3iCjk31znoBLc2GVaKvpGvsQm/VmaA0pjUlS
	iUnM7J5yw8Qg23Xj2Ni0nxECmXXg/8CgtkDSDt21fkVHh/3PNQUqzMxoI8nYsCeM
X-Gm-Gg: AZuq6aIApFZA8Jtr2JACI0i9qETfqubyAPxTKlTBfXcje7EEaplEi4NLyJsUedWWbER
	YTtxVWnrfJRn7OPGX3zFB/ik/enLUyIaiU4uf4XU9vifj5O9mRPlIp4tBBWi9BDAGo50fKMk7Qj
	vvM21kXW02AIPCsQJPwRxwhET+Fy+iai3K1lYFXf+23ePTtsZeuYHEgYFpCNGgJ9BVDiL1q+MZu
	KZ8lfymh8G5SQ9ArKwr958N/g05PvVVqYOFGIVj2rYeFzIpJbn+VsIv8LWw9wDMfO4dDw62H/m1
	qZOgpwb0PR1FljUrDXigPW+7unxUNy8r2jX23SA86wy4A28x6U4n+RrbxSl6U5/0J2Ipm95w08C
	QZihMmtXZhRyLwORT4yX5bhepuvy3qmWJLIjh4mhhGiBzIFT2XP12c9/w90mO1gMvP6RUOSt6/P
	6GIyiNyFliVJBH84AWBQbAsqMtrqUoRgLya+sUfktusXqp/gBlv3zQMRNms4dmXBkorA==
X-Received: by 2002:a05:600c:4689:b0:477:9574:d641 with SMTP id 5b1f17b1804b1-48069c5bd29mr34028795e9.22.1769536340780;
        Tue, 27 Jan 2026 09:52:20 -0800 (PST)
Received: from ?IPV6:2a02:a03f:a75e:9a00:7800:6d36:b552:d917? ([2a02:a03f:a75e:9a00:7800:6d36:b552:d917])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e132368csm337740f8f.31.2026.01.27.09.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 09:52:20 -0800 (PST)
Message-ID: <1c06b2a3-431e-4fe0-a09c-7281579167d3@gmail.com>
Date: Tue, 27 Jan 2026 18:52:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/7] ipv6: Add case for
 IPV6_TLV_TNL_ENCAP_LIMIT in EH TLV switch
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
References: <20260126194826.236075-1-tom@herbertland.com>
 <20260126194826.236075-4-tom@herbertland.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260126194826.236075-4-tom@herbertland.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253961-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A255B98AB9
X-Rspamd-Action: no action



On 1/26/26 20:48, Tom Herbert wrote:
> IPV6_TLV_TNL_ENCAP_LIMIT is a recognized Destination option that is
> processed in ip_tunnel.c. Add a case for it in the switch in
> ip6_parse_tlv so that it is recognized as a known option.
> 
> Also remove the unlikely around the check for max_count < 0 since the
> default limits for HBH and Destination options can be less than zero.
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>   net/ipv6/exthdrs.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index b9d186784b96..6925cfad94d2 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -122,7 +122,7 @@ static bool ip6_parse_tlv(bool hopbyhop,
>   	int tlv_count = 0;
>   	int padlen = 0;
>   
> -	if (unlikely(max_count < 0)) {
> +	if (max_count < 0) {
>   		disallow_unknowns = true;
>   		max_count = -max_count;
>   	}
> @@ -202,6 +202,16 @@ static bool ip6_parse_tlv(bool hopbyhop,
>   					if (!ipv6_dest_hao(skb, off))
>   						return false;
>   					break;
> +#endif
> +#if IS_ENABLED(CONFIG_IPV6_TUNNEL)
> +				case IPV6_TLV_TNL_ENCAP_LIMIT:
> +					/* The tunnel encapsulation option.
> +					 * This is handled in ip6_tunnel.c so
> +					 * we don't need to do anything here
> +					 * except to accept it as a recognized
> +					 * option
> +					 */
> +					break;
>   #endif
>   				default:
>   					if (!ip6_tlvopt_unknown(skb, off,

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

