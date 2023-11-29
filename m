Return-Path: <netdev+bounces-51995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AF17FCDBA
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 05:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C03B2115E
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895BB63BF;
	Wed, 29 Nov 2023 04:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiWrAF9I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B8D1998
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 20:11:23 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d00689f5c8so9629925ad.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 20:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701231083; x=1701835883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yE/KAIEaLYUt9SI/QvTC1fnX1Bf7cQva+Up+58Mn5uQ=;
        b=fiWrAF9ItIZGDu2SneFjFESTMdmMvfRi8H4VX6/+R6nvY4/YwIr9WKVrixBl5ORwmR
         z67hQzgzW/HpRa5I3OstSCA/OueVvNShgVpz77aPHSnz6c+oY+StBkry3PqRKiNtuAzh
         C7plles9vyVv/2G2IgfnxQBbA+lqjsgOKstPl+w3pZGElGU30FuKMRfmLtUBGGuG9y5U
         qsf7aS1P87ESfFgcaXG+q1QtS8+VQJduyJ9+am87Q72evLNvW4/OJmNLoKoJN/3FxCyh
         +rFYaIJMv5hkeVz62fegUmY444T9qEHw9QZbHJSUzNnQzkmjuaLMwI5x6zw0D5PRfyKu
         DBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701231083; x=1701835883;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yE/KAIEaLYUt9SI/QvTC1fnX1Bf7cQva+Up+58Mn5uQ=;
        b=E046FBZa/3hCzCIFfiKWlPSXTt/umK3axIw1X3cZ50bsSO0LLVr4+2iQ0B3L5qUHi9
         1mwTvQcWxB/zPMsrViDWfKbzNw15xAH6mUF3vf0MWMa+JZ5p4OvOe+Vp5t6GFw2uDR17
         Ig0auFim5PwAWnfVo1E9N6X2mbsyNJsZGvhKrGIVzP18M7/VgjJ9jZ9IjmPTJbH7myTi
         y5Mmk79uuxQlz7RVsrGv+SJ7MDMghb/QxIjmpJ9oWp4NLpNV+My+rUKR416sMVG7w8mK
         KOD6oqtv2mQmV36IhBiuFe6k1w/Vg5DQMmrj5DOWSFeqonJ+mhME95axAAbBo9vD6NAZ
         e8rw==
X-Gm-Message-State: AOJu0YxmBCBjk8/za4D3GTNKt0r1Q9SCaMMZ31Q335QTfPfWKa4+rO0o
	Y3vP82I5Fxx6c/O3C5mun60=
X-Google-Smtp-Source: AGHT+IHwP6jidxc9aDCz4vy03jhaVLwyazR4z/sEly+Rx7Oc9TUNfNPf1SJC4hL4kDI0MB9hcw0iUg==
X-Received: by 2002:a17:902:8488:b0:1cc:5e1b:98b5 with SMTP id c8-20020a170902848800b001cc5e1b98b5mr17761343plo.66.1701231083104;
        Tue, 28 Nov 2023 20:11:23 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id je12-20020a170903264c00b001cfe2031843sm3040802plb.269.2023.11.28.20.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 20:11:20 -0800 (PST)
Message-ID: <70546e4c-aba2-4a36-a2ac-e3ae63482ce0@gmail.com>
Date: Tue, 28 Nov 2023 20:11:18 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next 04/10] docs: bridge: Add kAPI/uAPI fields
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Roopa Prabhu <roopa@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Marc Muehlfeld <mmuehlfe@redhat.com>
References: <20231128084943.637091-1-liuhangbin@gmail.com>
 <20231128084943.637091-5-liuhangbin@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20231128084943.637091-5-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/28/2023 12:49 AM, Hangbin Liu wrote:
> Add kAPI/uAPI field for bridge doc. Update struct net_bridge_vlan
> comments to fix doc build warning.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   Documentation/networking/bridge.rst | 26 ++++++++++++++++++++++++++
>   net/bridge/br_private.h             |  2 ++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
> index de112e92a305..5d6d3c0c15c1 100644
> --- a/Documentation/networking/bridge.rst
> +++ b/Documentation/networking/bridge.rst
> @@ -12,6 +12,32 @@ independent way. Packets are forwarded based on Layer 2 destination Ethernet
>   address, rather than IP address (like a router). Since forwarding is done
>   at Layer 2, all Layer 3 protocols can pass through a bridge transparently.
>   
> +Bridge kAPI
> +===========
> +
> +Here are some core structures of bridge code.
> +
> +.. kernel-doc:: net/bridge/br_private.h
> +   :identifiers: net_bridge_vlan
> +
> +Bridge uAPI
> +===========
> +
> +Modern Linux bridge uAPI is accessed via Netlink interface. You can find
> +below files where the bridge and bridge port netlink attributes are defined.

You dropped the sysfs documentation upon Nikolay's request which is 
fine, maybe a note here that sysfs is deprecated and only provided for 
backward compatibility.

Looks good otherwise:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

