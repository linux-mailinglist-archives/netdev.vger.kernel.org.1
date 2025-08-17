Return-Path: <netdev+bounces-214368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69459B2927A
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 11:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B83B18830D6
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 09:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DADA217F27;
	Sun, 17 Aug 2025 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="fI+NdiQg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE1A1ADC83
	for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755423665; cv=none; b=aod13fNYT3XUhHhNlLOYr/t0ACAlzvi6dMQdV2E7x47TpNZn7WDi551JLlzD6jccsttET655yMaKiq3bL/+ig0mS99B/jEeUN6fHyY4gyYYIwghUkru8qnTzHJoplBaakgwyB1Xfm1C8H1F27hzuprn08jHQ97kbuxAHCcWr2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755423665; c=relaxed/simple;
	bh=5LD6tUnMBRUDDeNUW9C5hnH7FHJKH/LSZdjG7fi1KM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEBO6QZ5Z+k2rMxSc6JYHhv5Plr3Kp2r4Di7mfLXHkm0f6MK06xWEArdXcFRqy3HKZ0/mm4GBuHhIMbodoPAPrWCPPt30c+OhpDmAynoHwhsJo9B+QIMKYynsINLI90wf/G7urxhpDQwfpBy9E3p8wbAbim08Ja3Nu+eiaajefY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=fI+NdiQg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6197efa570eso2218009a12.1
        for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 02:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1755423660; x=1756028460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ktajYdOBczI/qieVqSlgWHXhRm0v28BeXhu0c44yne4=;
        b=fI+NdiQgP+M96TFrlWM+INqBgfbLhLNfvah2AiGEpp0IRIMS52E+TBKc1Ff+sYvMFr
         CQMYmRP/Qct9LjIjE68tHx1/kfignYs5wCLKsPLismQ7Z1ACysXxdTLmKI3lQDLiahLa
         FpHH7t5Qx6viyIk6/0A+BZrmmfg+eHmhikG39EdFIZRNzjuKmIlGeIM2QLKEC9786sBl
         vumal3A0hIbX7g3ktoInY0u9bAHHf5ooGbsNlVWSCMzsmIgyqVNrzJ1cPWByoF3VLVxG
         4uSrpSZk3FhyQE6CZrnZsOo8NIH3gs9wkI85BwlMHKOr2XsAU1boJa/5dPpppfdj8tCz
         pe1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755423660; x=1756028460;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktajYdOBczI/qieVqSlgWHXhRm0v28BeXhu0c44yne4=;
        b=gzebRzNLAKABLAgYg+9FQDUV9uBmYMYm5ruoTpy7GUYllpknJPgaFUsmXx0Oci05Tp
         B/5OD5MeEnZoKD/NxyN0cgeBIsPtG+cCW+OVof03OIkxlTE2KJokdLwDY0nSBKwUyz4+
         u06vCIVYKQzK6aCWae2GfqkAwIxdMs1Aw8JHQeA5cXpQNAZXDGDIVCfEKbaZ6Uh0PN0i
         5aTfjJ2bCvQVW01SVG/8BJEDUFX2icWE2XMRBn6e1qnulpCTJqiclIAq6ljQaqiGcvYv
         JTL0+Hax8S9SDFi76ZYjHGvt3NHtFfFtBCnrx61YrBg+2p2fSkR1A8pBvUjW1lNIGzZR
         WD/A==
X-Gm-Message-State: AOJu0Yyzx9jul5eTCywpVO1g2p9icx+MR+Rq8jcxGKWNKirr5rmvu220
	p6VUDk6TLWkKgo82K+h5bHxeY7A7TlT+EfQ7GN5SN553WGevAqBT2wG3lpM/SdNPyNk=
X-Gm-Gg: ASbGncvJhsDjY0qlveZgh72cNq//SFG3JWidt+3yEjGdvEl7YTYzRaJ9x0NPQXt5Oo9
	7MBM/5Sj4Vr3alck3WTafkBV6EA4sbusT6nMAw1luYY9VqLIwsPaqbicjTP38vtja02BRriKG0o
	BfN1FC/15swru75FZUZXcuXcQ8t5hmR9gnlaYj2YplfU/jHwSiSoV8UZxPqzfaohkgOGM20LjEk
	a/tLbl0ascMQDB/3ZVqNaAj8eC+zz4n74h5JsfSv4gAuS2T+5pslYrT66JmT9YVFKqCc2PiiM+j
	qSoZ0x7KtF8CgGO4aZojrzOh+hKZIZm6rbNiCxkWwiA5Iu2re15hBoTYidaqoEtjIN7dCkHBiwQ
	k4ZXXv/W5XJbGyTG/c+7bgmpk6vSZihHrCGu9Py5Oaesfk738VcRjnPXRYKN8xJnR
X-Google-Smtp-Source: AGHT+IGDfd+DflTFOf4pxYo1ISMzYojm2miQU4pB3dGwtoEKDR6RREMCYWE4LnZ/QE554k2KX+f1Ag==
X-Received: by 2002:a05:6402:278f:b0:618:afa:70b1 with SMTP id 4fb4d7f45d1cf-619bf1e5ac5mr3823091a12.20.1755423659761;
        Sun, 17 Aug 2025 02:40:59 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618b01ae57dsm4815371a12.29.2025.08.17.02.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 02:40:59 -0700 (PDT)
Message-ID: <5cb17491-d6a8-468b-b260-1b941a7f42e5@blackwall.org>
Date: Sun, 17 Aug 2025 12:40:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: When removing nexthops, don't call
 synchronize_net if it is not necessary
To: cpaasch@openai.com, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org
References: <20250816-nexthop_dump-v2-0-491da3462118@openai.com>
 <20250816-nexthop_dump-v2-2-491da3462118@openai.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250816-nexthop_dump-v2-2-491da3462118@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/25 02:12, Christoph Paasch via B4 Relay wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> When removing a nexthop, commit
> 90f33bffa382 ("nexthops: don't modify published nexthop groups") added a
> call to synchronize_rcu() (later changed to _net()) to make sure
> everyone sees the new nexthop-group before the rtnl-lock is released.
> 
> When one wants to delete a large number of groups and nexthops, it is
> fastest to first flush the groups (ip nexthop flush groups) and then
> flush the nexthops themselves (ip -6 nexthop flush). As that way the
> groups don't need to be rebalanced.
> 
> However, `ip -6 nexthop flush` will still take a long time if there is
> a very large number of nexthops because of the call to
> synchronize_net(). Now, if there are no more groups, there is no point
> in calling synchronize_net(). So, let's skip that entirely by checking
> if nh->grp_list is empty.
> 
> This gives us a nice speedup:
> 
> BEFORE:
> =======
> 
> $ time sudo ip -6 nexthop flush
> Dump was interrupted and may be inconsistent.
> Flushed 2097152 nexthops
> 
> real	1m45.345s
> user	0m0.001s
> sys	0m0.005s
> 
> $ time sudo ip -6 nexthop flush
> Dump was interrupted and may be inconsistent.
> Flushed 4194304 nexthops
> 
> real	3m10.430s
> user	0m0.002s
> sys	0m0.004s
> 
> AFTER:
> ======
> 
> $ time sudo ip -6 nexthop flush
> Dump was interrupted and may be inconsistent.
> Flushed 2097152 nexthops
> 
> real	0m17.545s
> user	0m0.003s
> sys	0m0.003s
> 
> $ time sudo ip -6 nexthop flush
> Dump was interrupted and may be inconsistent.
> Flushed 4194304 nexthops
> 
> real	0m35.823s
> user	0m0.002s
> sys	0m0.004s
> 
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---
>  net/ipv4/nexthop.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 509004bfd08ec43de44c7ce4a540c983d0e70201..0a20625f5ffb471052d92b48802076b8295dd703 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -2087,6 +2087,12 @@ static void remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
>  {
>  	struct nh_grp_entry *nhge, *tmp;
>  
> +	/* If there is nothing to do, let's avoid the costly call to
> +	 * synchronize_net()
> +	 */
> +	if (list_empty(&nh->grp_list))
> +		return;
> +
>  	list_for_each_entry_safe(nhge, tmp, &nh->grp_list, nh_list)
>  		remove_nh_grp_entry(net, nhge, nlinfo);
>  
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


