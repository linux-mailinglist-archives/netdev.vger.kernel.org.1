Return-Path: <netdev+bounces-109356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 563C69281D0
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 08:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB101F2146F
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 06:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03551411FD;
	Fri,  5 Jul 2024 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="JSzythbE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F3B8565E
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160365; cv=none; b=oq7q/7AL+Xe/TgIJQzs0TgqQHlIs3tWZzPLlXUx7vvgUI91eWbcW+cR1/JXh0aCgncz2xqX8UURIkbt8ojiMrXLeykSf4tHLNmvnOBYck0P/gAs1d2wdwBTP9/KV7vU4KZnG/uSl+MIJd+qulIrDDV3F1iyLOeVl0jo6VwqwfvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160365; c=relaxed/simple;
	bh=NuBcaZBXyaib8wjHT9yk4FJ5ZvdCAVX8JNjlI0ndxKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pr2X7luscL7k08NkymHxm4XeB5svo6qVlAscone0r5Xl+EoYT3Dq7dHaCIN3knFXjpIGIfPeWifmtONKbL/60kL/kn/cWLrVVzXFh0ZhYTQoVQ+zy1mPqmfADe+5loilVxcOCXOCTJk/YZyDKFWOCJ+L5JTQbtf/xMdVk3u0fkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=JSzythbE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a724958f118so148726366b.0
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 23:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1720160362; x=1720765162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mwsffRzyhXVoC3K5uOT5OFHBsBv3WDoaAysWJVFt7KU=;
        b=JSzythbEguQefDa8i0BWeGb0shrMF1cTi4Hv6CbmBWXg7FxrV+1hrSdg5x+7AtDXl1
         UwrSduQLJ+14M/FhIun0PyYBpecpjXnPGh3/J8OL82lLy6jb9iLPW91SRcXnl08C3kzI
         VztfBPuw3hg9r0wkbAyzfpFTq4SucfO5eR4nS+/nb3RUF7a3OyZ5qWlXW44omwX3hGLV
         4PDkIQkAJ/VE+vuUlqi3J4h7CBfTpBTfquZzx9fMCoT1yNPRGtnLtt51FgVAXmLNPT+s
         kSMCoTzw1NwOQKx5uR/rewt4iRypN54XnZEibyBzPsbSES3CVDMQCVG9WtzTkcsvFGMd
         rr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720160362; x=1720765162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwsffRzyhXVoC3K5uOT5OFHBsBv3WDoaAysWJVFt7KU=;
        b=W1d5qRanIqCs/V4PBNSt0a93/0uVtUl5TaSO93h7Uf0CZkhJqk+/tOa7SzWO4cy2Nj
         7iSgoCH2qM1ZBAXX0BG9pDj6/kwgC536z0KazBna6OqYt2mpTsAijNuWyru182GtzCKC
         aw59OQjX8qYjYX01VvgtM6LgNldp3cWOHxv28DQn1myS2y4glHDw6ppitkvkm+du1Ni9
         CPFKeM8fiHGLMIzq0eSaz6mXVbC4+e0Z4Uygni5iez1Hwm7g/im2ywHXuiwNormPqTzM
         SOhCC3q0kgVWhBE5mGqO/fwXIKE+lP77dI+BVwBUyTaGalmq1ZMSouQ33M9mYSps/lcx
         hR9A==
X-Forwarded-Encrypted: i=1; AJvYcCU1WSenpZSjwpc8HJHVnTN92losEmRtztIL7mNc4dz7Pid+aSvYx8uyhN0bBVum3KMaXDB02UNXILivtRC+O3wvpUK5tj1a
X-Gm-Message-State: AOJu0YxX37fqFw3Rwiy+jt43b09ywI6i0Yin6MFHSGnBz2xoz+5XLIRz
	U0i2rYsyDajGrqQ2Pdc2V8iI49sDqspzDTBcxd6lmAQFOrNIshnKMHU9KNqwSvY=
X-Google-Smtp-Source: AGHT+IHYGWxgJcxU2JtXZe2SYuFdQkZAhNQBf2vwDFlVHIX1WeUVW/S7nDMmVDMT9pyEI4qfY0LaVw==
X-Received: by 2002:a17:907:97c8:b0:a77:b410:b1ed with SMTP id a640c23a62f3a-a77ba48325cmr317201666b.36.1720160362091;
        Thu, 04 Jul 2024 23:19:22 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf184fdsm653369866b.3.2024.07.04.23.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 23:19:21 -0700 (PDT)
Message-ID: <8f3fe53c-0bee-44d9-9c23-6fdd3362ebe4@blackwall.org>
Date: Fri, 5 Jul 2024 09:19:20 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: mst: Check vlan state for egress
 decision
To: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>, davem@davemloft.net
Cc: Roopa Prabhu <roopa@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240705030041.1248472-1-elliot.ayrey@alliedtelesis.co.nz>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240705030041.1248472-1-elliot.ayrey@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2024 06:00, Elliot Ayrey wrote:
> If a port is blocking in the common instance but forwarding in an MST
> instance, traffic egressing the bridge will be dropped because the
> state of the common instance is overriding that of the MST instance.
> 
> Fix this by temporarily forcing the port state to forwarding when in
> MST mode to allow checking the vlan state via br_allowed_egress().
> This is similar to what happens in br_handle_frame_finish() when
> checking ingress traffic, which was introduced in the change below.
> 
> Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
> Signed-off-by: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
> ---
>  net/bridge/br_forward.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index d97064d460dc..911b37a38a32 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -22,10 +22,16 @@ static inline int should_deliver(const struct net_bridge_port *p,
>  				 const struct sk_buff *skb)
>  {
>  	struct net_bridge_vlan_group *vg;
> +	u8 state;

state = p->state
...

> +
> +	if (br_mst_is_enabled(p->br))
> +		state = BR_STATE_FORWARDING;

...
and you can drop the else clause

> +	else
> +		state = p->state;
>  
>  	vg = nbp_vlan_group_rcu(p);
>  	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
> -		p->state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
> +		state == BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
>  		nbp_switchdev_allowed_egress(p, skb) &&
>  		!br_skb_isolated(p, skb);
>  }

