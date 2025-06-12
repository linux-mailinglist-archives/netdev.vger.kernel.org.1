Return-Path: <netdev+bounces-196916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46212AD6E07
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452D91BC7E43
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A60230BC2;
	Thu, 12 Jun 2025 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="NmHjfK+z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E799194A44
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724617; cv=none; b=WD1qpOZdgP4oM+hIJeh33YQqfqtBVTtODpeOzEmmLMettYptwn4t3LNqOdaZjZkeJmc9sQZbuEpQESnLNYqNRbq1ASUMXgXnipT/uPkeedgHQo4+zQQlnQub5iKPaxsOER4NoH22+2pXFdS65LUJYBua5QUxUSwfbHusKO32bdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724617; c=relaxed/simple;
	bh=lEvNORumFp/nDFmLCJEoNABtvSiKfyaVEfxv4dBDJV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X99Q2HKYXUgb0DahPJRXWSDjwnsThuKMem789/7RtD2O6hRmiB81ddRO3Bi9v1l7kx/SVztrNdwqsjoi4SZjiobhXG6t7m+5Wyd7YODZjVq9iEPcWmU98fDTFfpZyxHHpYTIcPMOJhKTKbfTvFwV8Nj4Vko82jY59WUUT6pXK/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=NmHjfK+z; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-553246e975fso851950e87.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 03:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749724613; x=1750329413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ms0uGn6eiHFGzoefuHIXZfeg92CY5ury/v7fWk59fBM=;
        b=NmHjfK+zgJvpQLbyyQQT2oB4plObjUIRlqsiZDtM6mA4t1HbFs5swjncim6B8xundJ
         JvZVY9N52qNRhxOcP0wsKyIHktJZzYuHfbcKZJpsa/9XXfVi58GxwllcHHker6dCtaTI
         SyBiv9vXQwPBkcBh+qjRaiEGp9BIAZsYzYaJ6Oy7SWWb+eukgNpGv+YaH+P8D8KN36l4
         runhFWHNFs/DrUgn7eTdyZiL+S0a7XjbTXRzwj4IZpnHRkH0C7D299eh3KPyNwzZJNgq
         Yt7vZrKDEzWdI8YYpswkIr0npi8lMSEBedIWfyIUz7dUHy9ng6JvqESfsnDyzuaZ/rEj
         Yc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724613; x=1750329413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ms0uGn6eiHFGzoefuHIXZfeg92CY5ury/v7fWk59fBM=;
        b=EOAE1pO0VSSVu4O0QJzxtF8t4NIVXKFhlLgfb8h8Z/ln8tOV+tm8iFYvO166nSkxEO
         i1jllSIQ8I9drWVojgQ9pzP0IfYTKaSrKiQNf8uA8sbLBU0I0Nvj9x8gfd89l22BrtYm
         6zbaKidO3JtnzLnKRjRDqyvlzA2QFC7epiwQL34J1L15CT7BfxpkAvYLIbJftUlfXYGN
         A86t2t/Wn4RvBkB06gTvEbJ92EYPOY818jNm0yfkSzxIcH7OxBtj0GM0L8yAcoTDDmCu
         nL3eSCdd4o0rWdYDlGmoDA07GBBUvzD1csQVWAJOzDOCm/tDhP5eXgACmVMXn1vXks1e
         L6nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwdipF9Pip+af0WF50TnK4+fPLzBo0SDAWnCxMHuLvi8u1H972umGAi4FfteXAURYVFIAc3a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKfb+4Obu2kWOpPWTtc/34V6mUqOAAGC7jpZZk/YE2NEWRlmkl
	n5LP5h24bOOrFt5YZvSI40tu9MTHRLeWwoliTb8O1U+hFFRn/w9KU5HT2YAq7kxHK7k=
X-Gm-Gg: ASbGncu97sgXFcJ3Dv7Ty11DqWdhI7OvP59GWNUDYAgHLIHVvbzFU4/TCWJn23bPFsH
	NQAdpU5NgmzVDNPOm0jo69KQt6XyMxBoWj4rXfrYOszlw8c8EU4NRkgTs3uF2hwSIr2cXIa+YDt
	hJgA6akNHUdei7kOOJwUJzMD6/RuoGJwC+vTCTayVqA9xL2noeqZ6sYGyEx4nv8MGfLEeW4UNC2
	xotyxTyDN2FFU5UgZAf4J24VC7l1Vrs6m0i1UefOn4SH2ZiBsO/6riu98EYEX9DgfkbPVPvIU4k
	23hEfkdGXIX4jeRf/BezIoGLKd3BBOzlB4p0L9R9Atguos3pC9iljhVwcK4D4pHI9oa2bt4hhMf
	H4TQc9L+Z5RiHI4KA4QHoeVrPa9UtjWeXX1dIEIcHFg==
X-Google-Smtp-Source: AGHT+IGscsFo0AQotjbu/pRvX7bGFn92Se+wyRi5aZzXRzqbrpap6ZMdtVuyV/blKkqF11iD1/feIw==
X-Received: by 2002:a05:6512:3e10:b0:553:3028:75ae with SMTP id 2adb3069b0e04-553a55783fcmr812850e87.46.1749724613384;
        Thu, 12 Jun 2025 03:36:53 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac11680fsm68538e87.5.2025.06.12.03.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:36:52 -0700 (PDT)
Message-ID: <bf706975-c716-47af-b7ab-3444a06bece2@blackwall.org>
Date: Thu, 12 Jun 2025 13:36:51 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/14] vxlan: Support MC routing in the underlay
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com
References: <cover.1749499963.git.petrm@nvidia.com>
 <534f532c0f587a7ca1e04036b7d106ad9274429e.1749499963.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <534f532c0f587a7ca1e04036b7d106ad9274429e.1749499963.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 23:50, Petr Machata wrote:
> Locally-generated MC packets have so far not been subject to MC routing.
> Instead an MC-enabled installation would maintain the MC routing tables,
> and separately from that the list of interfaces to send packets to as part
> of the VXLAN FDB and MDB.
> 
> In a previous patch, a ip_mr_output() and ip6_mr_output() routines were
> added for IPv4 and IPv6. All locally generated MC traffic is now passed
> through these functions. For reasons of backward compatibility, an SKB
> (IPCB / IP6CB) flag guards the actual MC routing.
> 
> This patch adds logic to set the flag, and the UAPI to enable the behavior.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC:Andrew Lunn <andrew+netdev@lunn.ch>
> CC:Menglong Dong <menglong8.dong@gmail.com>
> 
>   drivers/net/vxlan/vxlan_core.c | 22 ++++++++++++++++++++--
>   include/net/vxlan.h            |  5 ++++-
>   include/uapi/linux/if_link.h   |  1 +
>   3 files changed, 25 insertions(+), 3 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


