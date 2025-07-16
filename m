Return-Path: <netdev+bounces-207514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4523AB07A23
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 17:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92107B09A9
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 15:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF1F273D72;
	Wed, 16 Jul 2025 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="i1kO+21c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECD321C19E
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680572; cv=none; b=bmT9CW1iI+vLNPk3lgrjlZnvO/CMa3YJ1BbSL8vH7vX/Ys2/+B55U1WSduuhZebztteoQxUHWDXa351fPCT54WSbkjpmq306G5PsvqNG0JVMaXSbTLEIjPfgmZ55zGAXeBeE/scN4YaKyI/gHQt59htjMqjmIwznB8hpqxTPP4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680572; c=relaxed/simple;
	bh=LkfYF7pYFAHo2uQSC7pPYzH3bZTmHka3sLvqjeIRpbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkF9e/orq9rCdPlkEddzL5/zibOfuI7RcJZK4v7DgT9iVijBisSBvhoTFUigoqhLvMBlf9JsiLBCz1W82Q0PqtVnab9ptgZrWxyW80gnhe03lLzaYZ1v+TwXfAdNHOAU/IB/VaofGPazkG6b/vwz/ZUcopT9z4IxXnp/jIoZmQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=i1kO+21c; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60cc11b34f6so1943655a12.0
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 08:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1752680569; x=1753285369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxjVPc9lLv7029fkYsxMY5nTf0b4uYTpgTGxXCLpHBQ=;
        b=i1kO+21cCeo7W1/aDgEkRR9vtxOOMn9LoyV1Esz8w26gSg6bCy+sqxAvxnfBwc6IQm
         GlslMeGi8Vx4CHnp4R5BuaeS8JAudfGweM7G+TCTxmyACQJGGft4xlI6ifHsmOeTq0dV
         NC292onhmtdzfCQwJqZX/+YjzcGIKjHrsaRYDkP+/uuOPN5buq2j+NNKHmyXJOU4OKoM
         J9EpoT9b6XrXDS9r0gnnv267tm+fYCnRRekcm59QOQNZVQMD+zwmnHp5rFFn4kAGP1qS
         tAwHDU80L3vUHbHa9zjlVjxWVGCLMGSnRUIfPIygmX473WJZFglkmTdRPahBV/NIl9eJ
         QofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680569; x=1753285369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxjVPc9lLv7029fkYsxMY5nTf0b4uYTpgTGxXCLpHBQ=;
        b=DkLc3eHYTAbcEhv2tstgHiaXuC9qTjroOgqD8aPBikJhfOa166lw5IFGCSBVPEaS2F
         BqJuZp76FZFrVDeZVzi1rGCYLMaNndG6EVLaaC+V44cmND6YI8B0ne0bwn9bRNZOVBmL
         cS3g67cIAOU4ru7W06HsBItnrmIEq2JXYJ8MlweT1EIgTbd6nWTh5RjxfS/NLnlpfHdU
         JvL+MdPdvlT6jld8BSMjequcD2mdB1WLVu+r9zmvWQeBeHgigvk8yVvL9XHhOjr3dnQy
         b101M7TtIaBd0Jul1cvOK/tCu96CrBQSS7o69HxNBkS3f2DxlABUeAtKjdt5ZEzJtqxr
         2mAw==
X-Forwarded-Encrypted: i=1; AJvYcCU81ewdnQWHqqsl5ygn5rlmCxU1Q679jKxnu9dLCj6FwXJriYW9ZVDPxd3vwRaL0bAdIlAWBOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPCjSh/nGvtQCEveLe8L/wFASW+/5EREACBT77dpHXw56VZd/b
	u/mOAEXcN79WmcnKn8xi7TzGe+5eFpBMkF+mfCkW+6mf1S5Hb7QxuTmElIbtIaloETZREp+Wum/
	XjADj
X-Gm-Gg: ASbGnctVFJjjGzg/CMer5zfhNnxJpdWLBXqHEIM5L/Pe3ue92hDNVc56gHMlQA+8Iw6
	vr0TsybwzdpdM9huLHN1m5WY6DHCH5gg5rEztu5k0UjHsRSm7Rl1fAiXE3eyjBOWDChWL6MH5Q8
	zWSyrOtAkRZA26bYHUv1+S8dwugib0G90ZGPdxCzSlsUplTZEUpQ6TNjGlVj7C+9kRxeSwgZ8iC
	nWmMFPT/14QT9Jpyy6FXhuctA6YKrYJ10BndO9Q4xyuEJXe+el4lb+sdgfCQd5JIE+0Cqlpt6El
	IWpwE0eSh2gt4C0KE9E4iVIPBH2gLF21DMJbOEvtv2VPFp8I4ZEiNm1TKUacEBVkocOtYmGZU1o
	+hz4QMrFg7cPCLpWOKwKTOgDedm4Vbjfcge1SHAgHIm/zprRo7L/Aiw==
X-Google-Smtp-Source: AGHT+IEXxAmRZhBfXJJ6RXAaXnDHc3IiJuVLZMZWlWOmL9qwv0jbe41xNN9dmF6K4gloyVg6nJBmJw==
X-Received: by 2002:a17:907:3f94:b0:ae6:d51a:4ca3 with SMTP id a640c23a62f3a-aec4cff8016mr2809166b.25.1752680568653;
        Wed, 16 Jul 2025 08:42:48 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df2efsm1217605566b.151.2025.07.16.08.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:42:48 -0700 (PDT)
Message-ID: <1757a42e-573c-41ab-b2c4-b8e1f2c8f46b@blackwall.org>
Date: Wed, 16 Jul 2025 18:42:46 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net] net: bridge: Do not offload IGMP/MLD messages
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250716153551.1830255-1-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250716153551.1830255-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/25 18:35, Joseph Huang wrote:
> Do not offload IGMP/MLD messages as it could lead to IGMP/MLD Reports
> being unintentionally flooded to Hosts. Instead, let the bridge decide
> where to send these IGMP/MLD messages.
> 
> Consider the case where the local host is sending out reports in response
> to a remote querier like the following:
> 
>        mcast-listener-process (IP_ADD_MEMBERSHIP)
>           \
>           br0
>          /   \
>       swp1   swp2
>         |     |
>   QUERIER     SOME-OTHER-HOST
> 
> In the above setup, br0 will want to br_forward() reports for
> mcast-listener-process's group(s) via swp1 to QUERIER; but since the
> source hwdom is 0, the report is eligible for tx offloading, and is
> flooded by hardware to both swp1 and swp2, reaching SOME-OTHER-HOST as
> well. (Example and illustration provided by Tobias.)
> 
> Fixes: 472111920f1c ("net: bridge: switchdev: allow the TX data plane forwarding to be offloaded")
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
> v1: https://lore.kernel.org/netdev/20250701193639.836027-1-Joseph.Huang@garmin.com/
> v2: https://lore.kernel.org/netdev/20250714150101.1168368-1-Joseph.Huang@garmin.com/
>     Updated commit message.
> v3: Return early if it's an IGMP/MLD packet.
> ---
>  net/bridge/br_switchdev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 95d7355a0407..9a910cf0256e 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -17,6 +17,9 @@ static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
>  	if (!static_branch_unlikely(&br_switchdev_tx_fwd_offload))
>  		return false;
>  
> +	if (br_multicast_igmp_type(skb))
> +		return false;
> +
>  	return (p->flags & BR_TX_FWD_OFFLOAD) &&
>  	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
>  }

LGTM,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


