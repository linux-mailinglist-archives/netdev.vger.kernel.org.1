Return-Path: <netdev+bounces-253960-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCtVJ177eGlfuQEAu9opvQ
	(envelope-from <netdev+bounces-253960-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:52:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F29FB98A95
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94D7D30071F1
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091663043BE;
	Tue, 27 Jan 2026 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHMTQhy0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7158B15530C
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536277; cv=none; b=EoweLRs9ZxFwqLmHMVeqA+oQ+gIYofYyt8RuYLFLHh4ZmAvD20ow+/JrC6+UEqgrP9lf7mV70clpaKv1vjXnHjUa41jJsJCtQbgt+ifdT3XTBeaoYA9LQBHn3Y2gBKuaQe7T/5+Pn5Hjk8dxpnuE25aymZgSAg7VK98LcgYwmnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536277; c=relaxed/simple;
	bh=q++qkU5xLVmyuAgL7JTGYJkeqZ+7Sje4I9WFNT5WygU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GcyuTGNfX8xwgU9+pugwrN+ZJAAWUPkT1aCJ2vPYZjMvlxEyCzN3Jq//lai/HLv7NzCj3mL/T9tWJWh1ccIcSYyXYidAMGYn1RIA505hemU0H5q5L3EWll2O1vfVrC3HLRBgTopg4Y1HEvV9B7+9HE5Xct/+IWGJTcAQz7KLgq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHMTQhy0; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43591b55727so5700135f8f.3
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 09:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769536275; x=1770141075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4pbYj0t5Ybp3yXqaLvlj76RT8jshwZLa17QFkdQQFgM=;
        b=SHMTQhy0smfp/8kisIuzjeYa5OKsySK7legDLacZBbRqmnt+Dmp6dB/Ehx5xOjjxi1
         U4uCAr+ipfBLxHTX2W041oKtaSuwFJhXYUmXV//dzGdJyVeR11/n9hGXPNMIn5vDkRLh
         xpe1+fwDE85q8APT8JCWGpwZU5pr+J0J/xsk1qb5MghUeVdVEPFCY4AtoKaSTaxjEtaB
         o8Z10Ifln5JZcn1dQSstMDTvyKOxV/GQptY/kFiws4vQyVxTFKQG3tlCl3LVtYdAeRSN
         5j6Yj0aD0LBRCFjc1Mo7l/K260Cbd6TgPD2iCv/s3ARbpLDdht6V0AkKLvPifYKQ3TvQ
         1UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536275; x=1770141075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pbYj0t5Ybp3yXqaLvlj76RT8jshwZLa17QFkdQQFgM=;
        b=fuN052xIRMuh/s4vhrkjYqsPnS0LSfYmLw6u1WQ47h7zpNJG3QYwxp4Hprl/OMyAsU
         fXBvwL56kPq8LibJ5DPDCQcwoW+CtD8Kjr26MIjeIBuq57E3+YBlruBpSAlnKG50bn9f
         snlgfmzxVL9skkYx/2ZK4DRJQncB4nqREkmuvWSGCXTy/ZPoj2czSOvHWSC7ntMYpsRe
         EvgPpwrlGd7l9jWl9o0JWqlarqsj1KH7yzdSFBJ4wqzzeHhxugYNElFnz27okcS2Pn3/
         W/w1jZbiup41v9c48WTpHAbmatWjI247Dqhlbn+Ld1rHMoth5Q04DUemz3WP/bZFTox2
         lH9g==
X-Forwarded-Encrypted: i=1; AJvYcCXzbSr/VDPu72hPn3R412SUaLsfhQaX77u/L85X4aU10QU4sY4GBAyqywK5qK/N68WaLgPvX70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0rJ0yYV6rE9K2JMiRrfLn6W6o2FJJa4NQ3gYlUa5OzdaBkT2g
	RpsCKhCwe+qVL57hUEYPiyYVONTA33WTItDI5bOkU5IKWkXTcx8rE42R
X-Gm-Gg: AZuq6aJLBI3vyyG2cxmJ5L6y9HlNmPDShB1ZLWroSJFQDnnASDmSoWruoguE6SY/6O7
	BUUb24LEmMK+eRRPwYGoX/MLqflI/Jn24kRhx6G4uYNEQuRdmkUjGIFN95BD7SnB34DTZfj0ntb
	Ab4AW8b48AE3olcrdyyKhOUmrBnDTYd3P2lBRxfMBwIEj9hi8Zb/m3VCqBG1ezp1oVnY8J4sZwk
	u01bfXrspBI43XvxhStuNbefJEykcGr99TCTSKh/MNKxv9Z0zzxCl0+KhulYWCuhv7kXZXxoJKI
	syNktDkK2lOCW2EJJ+eCKtnogEe69g6loS+3V6UtRAqk0IACNrKqSejueYiDYj+/xvOsHk2LunV
	XRpzuFMII1c0rih+WzC1TyzJTSCO9LyZZLSc96grfZkj6Ja6BRvpiAULC/PiCWNxxiNB8IE4tth
	DqQex0Y2Sb/KmMPAlxtiUOxSkHra0AfyuQmjkk1ibhjY9zvKJZ4jvp5+kxrYcyReSLMQ==
X-Received: by 2002:a05:6000:2312:b0:430:ff81:2961 with SMTP id ffacd0b85a97d-435dd1c8f14mr3622447f8f.51.1769536274512;
        Tue, 27 Jan 2026 09:51:14 -0800 (PST)
Received: from ?IPV6:2a02:a03f:a75e:9a00:7800:6d36:b552:d917? ([2a02:a03f:a75e:9a00:7800:6d36:b552:d917])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cf16sm344646f8f.22.2026.01.27.09.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 09:51:14 -0800 (PST)
Message-ID: <53fac2b0-91de-47e0-849d-4f6952bc0eec@gmail.com>
Date: Tue, 27 Jan 2026 18:51:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/7] ipv6: Cleanup IPv6 TLV definitions
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
References: <20260126194826.236075-1-tom@herbertland.com>
 <20260126194826.236075-3-tom@herbertland.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260126194826.236075-3-tom@herbertland.com>
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
	TAGGED_FROM(0.00)[bounces-253960-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: F29FB98A95
X-Rspamd-Action: no action

On 1/26/26 20:48, Tom Herbert wrote:
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
> index 5a47339ef7d7..438283dc5fde 100644
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
> +#define IPV6_TLV_TNL_ENCAP_LIMIT 4	/* RFC 2473, DestOpt */
> +#define IPV6_TLV_ROUTERALERT	5	/* HBH */
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

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

