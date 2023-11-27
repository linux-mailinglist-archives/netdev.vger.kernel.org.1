Return-Path: <netdev+bounces-51316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D84B97FA146
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 14:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9432D2816A6
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 13:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FEF2FE3A;
	Mon, 27 Nov 2023 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="xo0Ukb6m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF409127
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 05:47:04 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50abb83866bso5688969e87.3
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 05:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1701092823; x=1701697623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=clj5g57Zh839lEaRyt7CSabyzzls9mXT2R3ZlM98bAs=;
        b=xo0Ukb6mcbIt72ZbWZPN0LyZt9gHz3VwQlzOWW3++ch6F8x2N7Lfa9I5jT1BZ9qhzH
         1OeCID9a9+jsPIQ+4LC0W8efnRz2emEX8CWSNFO+nGHBJgRw6ueXtQnXR5EnUu7i3HvZ
         amiNo3x6SCCu93RnP+WEXFRrL5SO9aCBmtTIGpps8XjRaAHfdMzHU9o+cA6vY4c74rK0
         cencRXyVph1ABqWVI2Wrgyt2XzOmLsxC/XfkZBa0rAZjkDgdsXBR3epDERwXNv0liY2y
         AQpqccxJmGey5xMQxFzcNGPdSw8Mxtcsu1rdx6Jc30RTyN5jotBrdoPmn/0DusPPyYJk
         3YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701092823; x=1701697623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=clj5g57Zh839lEaRyt7CSabyzzls9mXT2R3ZlM98bAs=;
        b=WVipB66Hz7pyPYi/sEhChvMVZageHNgGdIc83koKGOrY7fF6tsSP0l1R/Fq6S6YlTW
         qSg3Sxc9nE+2CBCobVXdigmaCIUAVX9YYklQhGqYoTLrVXNebCzA6mTi3xssSGNoeWR4
         qgesvn/hHIRbbPzt7G0wyCj1jwntvB0UJU8vsD+WKm2yYZ3c7S6P6uoLJ1x6BJtTG1WD
         8T5C/Yid1eBpnoHelw70+cYJhIAJPUyLu4dECk+n+rsHBYc45HTYAAXv/gOZ0kS2ul60
         ol4zSvkSALkqotF2+LngfFDygx/wHVZmaOe04ZMVyKzQgShxrXhT1WpewIvFAXjU7oga
         0cZg==
X-Gm-Message-State: AOJu0YyNUeVLSRSDBUsCx5X1OWUhGdFKJL8dHVEWZ317x0v+Y/6PnREb
	xicFqz/DczwzjEXp4Gzjo2k8iw==
X-Google-Smtp-Source: AGHT+IFqvNt0P5RmKsKR61j5MRdvlT/98lInVwc932HdCIqMT7W40RWjdp/IrVy4x1gZjl8HnbqJ7g==
X-Received: by 2002:a05:6512:3c87:b0:507:a04c:76e8 with SMTP id h7-20020a0565123c8700b00507a04c76e8mr10952463lfv.46.1701092822791;
        Mon, 27 Nov 2023 05:47:02 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id g22-20020aa7c856000000b005489e55d95esm5258516edt.22.2023.11.27.05.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 05:47:02 -0800 (PST)
Message-ID: <7b0d6bbd-aed0-7321-52ee-da68dad7b811@blackwall.org>
Date: Mon, 27 Nov 2023 15:47:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH bpf] netkit: Reject IFLA_NETKIT_PEER_INFO in
 netkit_change_link
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20231127134311.30345-1-daniel@iogearbox.net>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231127134311.30345-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/23 15:43, Daniel Borkmann wrote:
> The IFLA_NETKIT_PEER_INFO attribute can only be used during device
> creation, but not via changelink callback. Hence reject it there.
> 
> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   drivers/net/netkit.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 97bd6705c241..35553b16b8e2 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -851,6 +851,12 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
>   		return -EACCES;
>   	}
>   
> +	if (data[IFLA_NETKIT_PEER_INFO]) {
> +		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_NETKIT_PEER_INFO],
> +				    "netkit peer info cannot be changed after device creation");
> +		return -EACCES;
> +	}
> +
>   	if (data[IFLA_NETKIT_POLICY]) {
>   		attr = data[IFLA_NETKIT_POLICY];
>   		policy = nla_get_u32(attr);

Good catch,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


