Return-Path: <netdev+bounces-252971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKdEKBDmc2nRzQAAu9opvQ
	(envelope-from <netdev+bounces-252971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:20:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DE97ADB6
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A57F3053739
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 21:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F592868A9;
	Fri, 23 Jan 2026 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv801Wmh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624B0268C42
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769203169; cv=none; b=HaKLV1UZ4yYR6tTljsIhVSYfQb3p6K4f0nvof6FD/La1wc4tVXmTVk71E1y1YRn1n1l/f2y9PYJxPDV7ekfrXN7FoTHM1PRjIJ6XXdPBKjFqdl8PhTnv+O6wRhkxcghTbrkZfXwN139Q7d/kQuq4tAdhcKk9n6aogUw7Jqvvfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769203169; c=relaxed/simple;
	bh=7MPsl8wJltGQvgAYO099SuWW8yqt1rLeMM2l5uhMsfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XPPXsahMVxAg4w685AxDrqCT+LUuKXeZwuIzzs1nrc2+Z08n+ICwLGFYuuA8tMmYK1OwpiXGSn2BHxdoaHT9RMXc7/VSw7nSIMV0DSHIpH/7RwvClcEPu0mx8+7w19GLmjAd5HwxmV81GqX2d8bEuBkTbU5x9OvTAt5l0jne1Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pv801Wmh; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso1711131f8f.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 13:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769203167; x=1769807967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ii1aXpqD8k68Rtpy11c4RJPhE04I2RKFrJZZoC2MaAI=;
        b=Pv801Wmh6unPCe49bbW0xCMzsHerJKQG5X+A5fKJFM/GlHgYdhrjQoqz3pQQJ2IPF/
         Dsuc5iUsOo1pcILUf5/tj4d4X4ADWHhef0kbU5imljUEej7Gnt66Ot3Kqe2/LuCXoUoh
         cnhU+0tTjexemSXRAMDvcm3bkB7hQnlkKw/k6aaZoXEQePg5UC7lq4M5QgRWR2QHt8Dc
         MM/mzAlItPTy/HUA99Pp6GaOn5X/L+jGczGVWUyEyGw6GmxBD5rf2DZXhprY8ef8mrSn
         osmnBMxwbd1iwgPd5sbTQ9MzRj0foDfe2k59lpFAnzyipEdOu8OTjdfL7RtvcPbgR311
         Tmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769203167; x=1769807967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ii1aXpqD8k68Rtpy11c4RJPhE04I2RKFrJZZoC2MaAI=;
        b=nM31F1Z2Oew9KHEKy9zlSeXKu4Av7icvoKaucJwxuvn//RElyV4PoLTPqHP5VxuPyH
         b+RXdgwIFJEX2VpRnmJJPUjEc8qiPNz3cmJSExOv9gwFUqyI74nUFvoAd1qqRzgD/dV3
         NZjsLj+/PkxAopCKou7uQLavnfQSgL1vPOzkCHZll1a/p9tdUuchT01HyMa5z8jWAwt4
         j/XRl5WSgLj/lpYtqzu24kAIPxrmSKI9J6GBYa/l4nebOiTLX7WjVq3KoyZVI+0344RK
         IBSl1N3C5hfEWkltG4J74LOjjSeu/8NQyfdRAg6x6060qYsZP8OGw2e52F5c+9N3BGvL
         +4IA==
X-Forwarded-Encrypted: i=1; AJvYcCWBK1gfARR08K8AXURzFB5gplx9Oyd4xMC1qqeqHAG2A+itqEsF4qRL1KcvElvQaxXCO68ERSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyycMy+djFQ3KkSAkQT18OtWeZkQJZJP0aZw0AJkRbEBIe6UV2D
	9S3QTPnjy+bkedwUNTWbd10OEpSXH7h9gYFPKB6qYgpGygx4qqpaDRWF
X-Gm-Gg: AZuq6aLAYRq58X6FmcP3tFKqj0Amo6XYHgNG4Iv3K6w0lyAQSFOyIqwCqxBRsLljHds
	orwRJL5DBiGlZC8m+Dfy1LORLv5znPAEaUVRWIVnsk0fZzNJ2bxCYDROeF6a6AN5tCoHE/ay+e+
	CWRxbb1jQnsuf1W02wy+tjMIIYyRaTYycebjxPlxffXMW4QSsYbo5KNt+KJO0fWVrHOtMtM9+KW
	4DJcikuVxO6zhFfRIEPeG1I48MbFEw6Yp7214aaaa05XTh+OXmJCmyK9q2R3PTaHOnYcSU+mJ6s
	Err8cMiTgREx7w+3CtCYRtZPQMm1bMmyphdkzIZBnD8k4pabeAyOgxhh/dMbsBtVrpt0d43AIbo
	rKkLXL9oS1AoNXegqd/b1GWNw9IKs6Orpm3YvLNKh1nQA/+ujji5JGSF2C+uC9rJn1dOdmpoSSn
	R6Pq9AyHX5WztX76wjGlhn3WQNDmQa5HZbisGglVH1nIeScH43pEDAFY48h8HzSrOm4A==
X-Received: by 2002:a5d:5d0e:0:b0:432:c39d:102d with SMTP id ffacd0b85a97d-435b130e1b4mr6347821f8f.0.1769203166462;
        Fri, 23 Jan 2026 13:19:26 -0800 (PST)
Received: from ?IPV6:2a02:a03f:a75e:9a00:b377:103e:67ba:8048? ([2a02:a03f:a75e:9a00:b377:103e:67ba:8048])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e717cbsm9174427f8f.24.2026.01.23.13.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 13:19:26 -0800 (PST)
Message-ID: <3080d88c-1726-42dc-ae98-09451fb08b99@gmail.com>
Date: Fri, 23 Jan 2026 22:19:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/7] ipv6: Cleanup IPv6 TLV definitions
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
References: <20260121214925.112604-1-tom@herbertland.com>
 <20260121214925.112604-3-tom@herbertland.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260121214925.112604-3-tom@herbertland.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252971-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 29DE97ADB6
X-Rspamd-Action: no action

On 1/21/26 22:49, Tom Herbert wrote:
> Move IPV6_TLV_TNL_ENCAP_LIMIT to uapi/linux/in6.h to be with the rest
> of the TLV definitions. Label each of the TLV definitions as to whether
> they are a Hop-by-Hop option, Destination option, or both.
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>   include/uapi/linux/in6.h        | 21 ++++++++++++++-------
>   include/uapi/linux/ip6_tunnel.h |  1 -
>   2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
> index 5a47339ef7d7..c2f873c98d20 100644
> --- a/include/uapi/linux/in6.h
> +++ b/include/uapi/linux/in6.h
> @@ -140,14 +140,21 @@ struct in6_flowlabel_req {
>   
>   /*
>    *	IPv6 TLV options.
> + *
> + *	Hop-by-Hop and Destination options share the same number space.
> + *	For each option below whether it is a Hop-by-Hop option or
> + *	a Destination option is indicated by HBH or DestOpt.
>    */
> -#define IPV6_TLV_PAD1		0
> -#define IPV6_TLV_PADN		1
> -#define IPV6_TLV_ROUTERALERT	5
> -#define IPV6_TLV_CALIPSO	7	/* RFC 5570 */
> -#define IPV6_TLV_IOAM		49	/* RFC 9486 */
> -#define IPV6_TLV_JUMBO		194
> -#define IPV6_TLV_HAO		201	/* home address option */
> +#define IPV6_TLV_PAD1		0	/* HBH or DestOpt */
> +#define IPV6_TLV_PADN		1	/* HBH or DestOpt */
> +#define IPV6_TLV_ROUTERALERT	5	/* HBH */
> +#define IPV6_TLV_TNL_ENCAP_LIMIT 4	/* RFC 2473, DestOpt */

Would make sense to have IPV6_TLV_TNL_ENCAP_LIMIT (4) before 
IPV6_TLV_ROUTERALERT (5).

> +#define IPV6_TLV_CALIPSO	7	/* RFC 5570, HBH */
> +#define IPV6_TLV_IOAM		49	/* RFC 9486, HBH or Destopt
> +					 * IOAM sent and rcvd as HBH
> +					 */
> +#define IPV6_TLV_JUMBO		194	/* HBH */
> +#define IPV6_TLV_HAO		201	/* home address option, DestOpt */
>   
>   /*
>    *	IPV6 socket options
> diff --git a/include/uapi/linux/ip6_tunnel.h b/include/uapi/linux/ip6_tunnel.h
> index 85182a839d42..35af4d9c35fb 100644
> --- a/include/uapi/linux/ip6_tunnel.h
> +++ b/include/uapi/linux/ip6_tunnel.h
> @@ -6,7 +6,6 @@
>   #include <linux/if.h>		/* For IFNAMSIZ. */
>   #include <linux/in6.h>		/* For struct in6_addr. */
>   
> -#define IPV6_TLV_TNL_ENCAP_LIMIT 4
>   #define IPV6_DEFAULT_TNL_ENCAP_LIMIT 4
>   
>   /* don't add encapsulation limit if one isn't present in inner packet */


