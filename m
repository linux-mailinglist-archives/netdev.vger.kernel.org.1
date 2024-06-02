Return-Path: <netdev+bounces-99980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFED98D75CE
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 15:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A917282575
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0013B3D551;
	Sun,  2 Jun 2024 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="JvUnbe1E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A0B3BBFB
	for <netdev@vger.kernel.org>; Sun,  2 Jun 2024 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717336209; cv=none; b=S/k78wbnExjT5NqecpnBPC9xfvxg0y6upgbzxtzwuQ1qRf6E6hfG+ybCJrRFPf2LvsBs48oy5rJ7cc0puEwyFpfJ4/yCBG4byLE/LlnrnLvsCBlESprUm0eYSRGlDdJw/+2dzbtS17YlF7Mo7Fvxxyxz/8H6rkyTljJ1gugXjBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717336209; c=relaxed/simple;
	bh=RRz9TLvLdNYU9kZYBkqdH96oTN/q+RzbkWenYQGTsXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXl8/z9DVjAovvlJ4xOLjAt/lhwapOFIC4b1Jn+w5H9hkF549oEg3r/UBdaVYmj3ClApuyZ32JLJTKM6LlyA/0re8z3xikGG2Qu+cPffIGQfTtNVwGlQ6aTBfDKz44hKIEyOHWimGoGPhJ1E6uDesydMPrJEK6edzmAVl1fzQWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=JvUnbe1E; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b88335dd7so2911732e87.1
        for <netdev@vger.kernel.org>; Sun, 02 Jun 2024 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717336206; x=1717941006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgucUj/3Ko+mub3oS+UVl4puHDskyniNFtly+3QQjXA=;
        b=JvUnbe1Eq2U6oqomYG/o1Q2t7hPDz/KPP6h2wusMzdxkWifZS0ZqIPVYdcGr108bsx
         ZflyowrxPZez4GF0FSJ5YoXrfT5XWwCaYQYXKba6sel2nnAZS7QqXRdoI/cvGjLI+ZBQ
         xmUWjCUoPwdKPeOnFrIcX2iGUsmMJ3qO9EZlh1piVHczpkagtsU+e50X0vVOlZgTiaow
         1j/LGqr2dlxPw6YM5/CvvuUpdXUL0BgGhDEOcvlp1Cth/qDtWkmgmIjk3ycAqg/lqPm8
         v5/hS/HTjSNaVH6gbECR4EIJijyzT9f9WXmJCH8dBI4zJ7JsRAlobaYASznTaoYBgm5A
         LGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717336206; x=1717941006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgucUj/3Ko+mub3oS+UVl4puHDskyniNFtly+3QQjXA=;
        b=He14xOO7Lc9XlfWXsSo3QgeSnRoH+UUL+zAjLODaa2kNWryKRk5ojKTy/loRf4DN9m
         6liHe5F6qBXUcTif5SliVr0OIyIbwA/UfRnPrXPxRHS/tPR8NOYNXNhNsVKX/+ylbhZ0
         oEj3Xc/jHibFgpoEaR/fUEsb9P4Vgv12gAFEv7OjqssyK8ITElVaGBCa+LXKJqRceCUn
         g9/ffHM02hjsmxjvurlLIja3H79QXcMj0lhQM6dcnpmnxp9vcNvpMLJJXxrgQgVUUGQh
         FM3asBNkKEBqr4rFLWj9cw67fiOGOxgK242SsVf4wdiNea6zQiKMYA+eQR4vJKup/aiJ
         plVg==
X-Forwarded-Encrypted: i=1; AJvYcCWA++xJXtuaCa9ehuH59H2fiR+o/WQeHVNKf9lwWl8md5U8J/nUTIP/Mo5TJCEdNP1dPXIeIHAuWpgiLSSOKm6vBrLE2q4i
X-Gm-Message-State: AOJu0YwysNErkg1TBXd0tmzZkV3sAxGwgYBVkSM4+GWt/5KyrtefttJf
	WYKQF4sAYGRx9Fp3Xix2ynu91D0o5naAXG9d4KgKvl3K4jNKp5G6LtS2/XWk4eA=
X-Google-Smtp-Source: AGHT+IGGAzLz/AvRTfuiPc7HwIKoVr/r+Il2Nn/+u3zi39STxi1U10wu83q4W8KbUmYeBoHmwsP9Dw==
X-Received: by 2002:ac2:4d92:0:b0:52b:3f91:fa62 with SMTP id 2adb3069b0e04-52b8958c003mr4856099e87.30.1717336206067;
        Sun, 02 Jun 2024 06:50:06 -0700 (PDT)
Received: from [192.168.1.128] ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68bc97be38sm194986766b.208.2024.06.02.06.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 06:50:05 -0700 (PDT)
Message-ID: <f12dfc61-2957-479f-9237-58c8374bf42f@blackwall.org>
Date: Sun, 2 Jun 2024 16:50:04 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bridge: fix an inconsistent indentation
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>, Roopa Prabhu <roopa@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org
References: <20240531085402.1838-1-chenhx.fnst@fujitsu.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240531085402.1838-1-chenhx.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 11:54, Chen Hanxiao wrote:
> Smatch complains:
> net/bridge/br_netlink_tunnel.c:
>    318 br_process_vlan_tunnel_info() warn: inconsistent indenting
> 
> Fix it with a proper indenting
> 
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
> v2:
>     add net-next tag
>     modify subject
> 
>  net/bridge/br_netlink_tunnel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
> index 17abf092f7ca..71a12da30004 100644
> --- a/net/bridge/br_netlink_tunnel.c
> +++ b/net/bridge/br_netlink_tunnel.c
> @@ -315,8 +315,8 @@ int br_process_vlan_tunnel_info(const struct net_bridge *br,
>  
>  			if (curr_change)
>  				*changed = curr_change;
> -			 __vlan_tunnel_handle_range(p, &v_start, &v_end, v,
> -						    curr_change);
> +			__vlan_tunnel_handle_range(p, &v_start, &v_end, v,
> +						   curr_change);
>  		}
>  		if (v_start && v_end)
>  			br_vlan_notify(br, p, v_start->vid, v_end->vid,

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


