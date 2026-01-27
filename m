Return-Path: <netdev+bounces-253968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHY2Fo79eGmOuQEAu9opvQ
	(envelope-from <netdev+bounces-253968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:01:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC76898BBC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 19:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B23C303C605
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF1D3242D4;
	Tue, 27 Jan 2026 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUWKmjLN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240AF2264AB
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536864; cv=none; b=jz3/5GZXVm0beW2HvZIQaI6jfb3PXcD/U9FGVVr+q6D1vV3kXgQLEL8Hfuc9BN8dFDuO52M3j2+Epk+Gbap/xMzK/F8uYJbBHb7CljjgxJ+VLjypXxtDM8X/Uy9LVrvcOaNt6pfVTzJnVHnAr4+4+IZW3Y5zaUbq0z17teatETs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536864; c=relaxed/simple;
	bh=rYPaCm+c4Ka/zd87e5yKTsUdun6FPkSI2nLcgM/zwx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eXZirtAQYKxEB0NPd60p5FbFkKo/ZgFzMMKwaWdD3lFUei7aIoPdiipISrs9yz5S8cNgm/ru65etW/BoGZeqPgQPsCihTNA3Pb1yEH+T72oFoxT+GU6gYykFVkOAkkawWvryaFu8ym7vmhGHa/oRrpzK4dMjEtDmkhXNgK7n3pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUWKmjLN; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4801d98cf39so45661315e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 10:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769536860; x=1770141660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FdIMuKrca0OMsXlKKw+mCgfZrpL7ruk2ZVGqQSIGBkg=;
        b=YUWKmjLNFv0gnEftxmoDnUTUU46TNOmAbiQ+WgFBELb9t0pFJmuYKjjBweOBg6zGjr
         Na8PAB8sh3mBxnALPp4qUfRDPhZ1cpCu8+oUMziSPd/Imll0CRDkO+AEgkuvUjnEt2ni
         oadi4d6gjE0wvp+GEDPV3WbxaM4YFg+NUYYceFxIBTouhtVjpi9HFu0cAmKGWBoc7Ly1
         Dq7ziIZIdEKCPNLPYdCTtZ+O0RKsNlhbHI3HvfnZe9lhRFcxAGC+By5tB9afbrizVpET
         cDtTAVhy2SXkaibxNuKbouIXbDzMO8bbXAUGdSGR3zayV46Ahq6lmSV3h4tgV0oK2D7a
         lUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536860; x=1770141660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdIMuKrca0OMsXlKKw+mCgfZrpL7ruk2ZVGqQSIGBkg=;
        b=LkEbOIzvR6YELCaF4C8yfElyplNqjIasbKvr911KuGWFMI2Rzh4j6ZvP5qfpzzX2QR
         Z0jcZP17TZzCXnSeR0gH234YqSBhEZ2uuJto12pLX6BEbH1QIus281oHmoPokaWW9/PX
         yCMt6uEf0cgxawanM9BsQjQXideeYJN1f/aosI9iDUqU2ikA+jnsNe+/h8O7eCFU67Wa
         5GO31e4LX6rr3u8UyoW8Nsdg7tEp70gXIXLcCTwZturBZDFWEfBX/2YYlDvc2Q/hMFen
         IM9IXwGnoGuLTMLu2RF/cnTXtUs3P/Kb0CusZE08kzDswhBYJixX2qR7BTIy7V8WSfL8
         IEbw==
X-Forwarded-Encrypted: i=1; AJvYcCU/mikJG0idorqx/G+koApt3gdnEqVm4Djp9PLtWcvNF6RYnOEYK3LkbVsd+CTtkTGcZWhaxDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/6ochrQYAecxyiZykI4dncgY4oJa0mjiZXOQ96c+hw2TBVVHk
	i9T2GCQhESDMY2bnWbXc1b15iaMmob1gOu9CP/Dg1LmosnelwKcze6vccmr6UFaXUhw=
X-Gm-Gg: AZuq6aLhHFiLgWU/1YXplkGZ5idyuaKsAB6chAzWiASPko1IN2EqFsR+WLJ88L7cDMq
	I0j0YHorvX0VfQUR2hbxHcNsHd9IgHY3HwE64jjiYqcapBBHWJU3EYnCj5AUQs8bwGusDUUfFUd
	DGEQBjZpWXD6KRkyJb1mkj9ZKpvVGn74eHx+FXWjL30kXJ86uthDHVbl/n1m6ahkPNzUA1Yrb2N
	I4dFi1eE/VRJpSauny/cubN4M103B3yX3l44+zp3cR7vxzbgPmXy/pmpmemNXaRckH9Lryf7Xmo
	d0i3gkdK9LAniA5nkvScjs8FpBhfl/r1hDVs8tSjQS6/aOvfNLc8pxjhNXvzpGzommpvp88hH+I
	1nboM34WIiIxGiuGCtX1BqWH3P92p1xvBgW3ROOWxs9p/V0Bt0J4oDucsi1295bdQMTMQypRhlX
	OIsKbS/zCU643qKcQgwVuRiqhgGXApWBOcqZepxbV2kkbLDQL3Y20XIZsyAu4E3eiVsw==
X-Received: by 2002:a05:600c:450b:b0:480:426e:9d38 with SMTP id 5b1f17b1804b1-48069c96b8amr28115845e9.27.1769536859577;
        Tue, 27 Jan 2026 10:00:59 -0800 (PST)
Received: from ?IPV6:2a02:a03f:a75e:9a00:7800:6d36:b552:d917? ([2a02:a03f:a75e:9a00:7800:6d36:b552:d917])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806d99cf6asm386315e9.13.2026.01.27.10.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 10:00:59 -0800 (PST)
Message-ID: <b39454ab-3a4c-4dca-8446-c80afff18f41@gmail.com>
Date: Tue, 27 Jan 2026 19:00:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 7/7] ipv6: Document enforce_ext_hdr_order
 sysctl
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
References: <20260126194826.236075-1-tom@herbertland.com>
 <20260126194826.236075-8-tom@herbertland.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260126194826.236075-8-tom@herbertland.com>
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
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253968-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC76898BBC
X-Rspamd-Action: no action

On 1/26/26 20:48, Tom Herbert wrote:
> Document the enforce_ext_hdr_order sysctl that controls whether
> Extension Header order is enforced on receive.
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>
> ---
>   Documentation/networking/ip-sysctl.rst | 28 ++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 4f568b0e39d2..1b12b955fa34 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -2581,6 +2581,34 @@ ioam6_id_wide - LONG INTEGER
>   
>           Default: 0xFFFFFFFFFFFFFF
>   
> +enforce_ext_hdr_order - BOOLEAN
> +	Enforce recommended Extension Header ordering in RFC8200.
> +	If the sysctl is set to 1 then the ordering the ordering is

Reported by AI:
s/the ordering the ordering/the ordering

> +	enforced in received packets and each Extension Header
> +	may be present at most once per packet. If the sysctl is
> +	set to 0 then ordering is not enforced and Extension Headers
> +	may be present in any order and have any number of
> +	occurences per packet (except for Hop-by-Hop Options).


Reported by AI:
s/occurences/occurrences

> +
> +	The Extension Header order is:
> +
> +	    IPv6 header
> +	    Hop-by-Hop Options header
> +	    Destination Options before the Routing header
> +	    Routing header
> +	    Fragment header
> +	    Authentication header
> +	    Encapsulating Security Payload header
> +	    Destination Options header
> +	    Upper-Layer header
> +
> +	Possible values:
> +
> +	- 0 (disabled)
> +	- 1 (enabled)
> +
> +	Default: 1 (enabled)
> +
>   IPv6 Fragmentation:
>   
>   ip6frag_high_thresh - INTEGER

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

