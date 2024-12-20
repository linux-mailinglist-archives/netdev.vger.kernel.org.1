Return-Path: <netdev+bounces-153663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAC69F9229
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 13:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD4F1664FD
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 12:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9E720468E;
	Fri, 20 Dec 2024 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="3LJddNKS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519CA204596
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697656; cv=none; b=ZY1ocEsGl65E58ChFT8eveahTIQ4ccnMZEvBSC0jhpaxGFh8yHRPydloXzcKBTThdLkelBC4c6xRUXc8QOeV+lQWXeRMXWlqM+v/HokegBf7d7ITNK0bgGC1zG24YtWNv0zXSIKlatkbeJpAzJIPqoNk3+2cs3W55JONZEWgv3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697656; c=relaxed/simple;
	bh=zA7a4bZu48ACitHBhxc9qodT4PaQ4DeroceLOgXAYH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enZBlnTL5xbyV8FlFCmrsCCkKQ4MwnKe1+d6t1M1Hu0YPeIYHd3LWukImBt4vNigZARWE5GCEJmW1vuYMsRFMRfqsilT4iydMl4uVlBwA2uZwz0OJ2aheqHjXzkNe70ip0iHWKScvJHt40Uk7o+/Ma8AkLyhXJGiQP2QfQKXLtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=3LJddNKS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so17851205e9.1
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 04:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734697652; x=1735302452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6yxLq8x+6aHmMAIO4raWWraNl83b7b09sXoVthd5fIM=;
        b=3LJddNKSaSaDViv0aQzAWku9AZhTADfJxNrkhGUcOMKXFXqVlmy/VVfq0g0jvnIdsX
         EWtyQquEcj51Y/QRSRqimwaOo6GcyQXh2G+VUGuZrdMPQ61VFTj8bgNu2t063cMzWz8K
         FRtbCqOGEuR5N/RcpM1RcKVQcax/Voya7O2kgWWpXSMzrisAdPNwGYutwUVrFUrBRu81
         DKJx4FpysOXXeubqja9i+oApfFNe2/LnbqU4mB58azpQc+/WDytaeGpcuoYXN3xJHfk+
         eB7MFlSSRvsC9zSGBTJKhoPSVorSZ4zFL0J+yqfbg9pgNUdSnT5XKtkhX7Ab1Dn/eDsZ
         0z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734697652; x=1735302452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yxLq8x+6aHmMAIO4raWWraNl83b7b09sXoVthd5fIM=;
        b=p0m+/bedU9+WDROdToVdo+pLs8vZ7LckSZxUoryMmdoptJM7X2hSB7hKgzfD8fJs9K
         5UAW3hXBIXzHr4dVtqwOOwLtq4K+EWCHzJ7E0p1YlNTMkbgfpoTwM8qXp/kme2yNlG6N
         dpG6G56ovgbtr+EyoY+HrkZc/B/r03/MpyBmv6KjiMIV6nM3nW8gxTzbZKFz4zjWJeEL
         LHf9EQOoYV8CGQZHgUpXcg7cbNuTUjpu4PUZvZ6JQr6b3D07h8rM6a3vCK9h4XtPI4ah
         74EORGX3AvEEfO6A9ryneVAsTT7vDz68Dno/3riFHC8xGtc+M6P4p6NWkE0etwU9FNt2
         +Hcg==
X-Forwarded-Encrypted: i=1; AJvYcCVK2NSbDeCdsgKaxDaC+FMMBcTcImognl5OMEFE3lBs8WEb/GG1RlxYahhb5GmOpQJlZTuG7SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq0TIMaC1FBqb7rH28sgaXQd2eEK6RccR36XdgfUIVTEaWMB6m
	vPzViYWiVpOiTbL9ot+qgnMk9yULKGBv5THD6Qn6xBN+loKrZkYpO0hO0akdHiY=
X-Gm-Gg: ASbGncs41nECj4IFu/kQc+AT1HkEuZo9y85GH7hIZYJXwU1Cgb1bPGGQKqF3sFNc/Vq
	lD+9XXGzUlQjL8YGzyO+BHDBEe+hHVlPCaJrl4o3O5Ef33dJ8dgSiMyWdYMikgKyl6hlFh/yPCI
	ypFJ2t3oa05YnRHHqXwZnXHR5pWd74ZhHGsHmhu36Bkyb/75q8aldgQZmnVanxpv0Vq5BIzXF5r
	0PT/JzkimL9Iu7SSKOnZGwupR/nfzMLx20qyMMJPY062yC/bcJ/B1rdT3Rk/SldQ9v3idfx0n93
	2FdAnz+Q2pJk
X-Google-Smtp-Source: AGHT+IF0nXfFMV2mR1adR3X1lrTPlRuKqMQUEP6YuFL1k1v8N1A4WExmKhshpLKhwZ4tokJIrcSxnQ==
X-Received: by 2002:a05:600c:358d:b0:435:fa90:f19f with SMTP id 5b1f17b1804b1-436686425eamr24106235e9.12.1734697652460;
        Fri, 20 Dec 2024 04:27:32 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8a8d32sm3964112f8f.99.2024.12.20.04.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 04:27:31 -0800 (PST)
Message-ID: <d23db9cd-d9ec-4697-a851-3b395c6afae9@blackwall.org>
Date: Fri, 20 Dec 2024 14:27:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: bridge: Extract a helper to handle
 bridge_binding toggles
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Roopa Prabhu <roopa@nvidia.com>,
 bridge@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com
References: <cover.1734540770.git.petrm@nvidia.com>
 <a7455f6fe1dfa7b13126ed8a7fb33d3b611eecb8.1734540770.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <a7455f6fe1dfa7b13126ed8a7fb33d3b611eecb8.1734540770.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 19:15, Petr Machata wrote:
> Currently, the BROPT_VLAN_BRIDGE_BINDING bridge option is only toggled when
> VLAN devices are added on top of a bridge or removed from it. Extract the
> toggling of the option to a function so that it could be invoked by a
> subsequent patch when the state of an upper VLAN device changes.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br_vlan.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
> index 89f51ea4cabe..b728b71e693f 100644
> --- a/net/bridge/br_vlan.c
> +++ b/net/bridge/br_vlan.c
> @@ -1664,6 +1664,18 @@ static void br_vlan_set_all_vlan_dev_state(struct net_bridge_port *p)
>  	}
>  }
>  
> +static void br_vlan_toggle_bridge_binding(struct net_device *br_dev,
> +					  bool enable)
> +{
> +	struct net_bridge *br = netdev_priv(br_dev);
> +
> +	if (enable)
> +		br_opt_toggle(br, BROPT_VLAN_BRIDGE_BINDING, true);
> +	else
> +		br_opt_toggle(br, BROPT_VLAN_BRIDGE_BINDING,
> +			      br_vlan_has_upper_bind_vlan_dev(br_dev));
> +}
> +
>  static void br_vlan_upper_change(struct net_device *dev,
>  				 struct net_device *upper_dev,
>  				 bool linking)
> @@ -1673,13 +1685,9 @@ static void br_vlan_upper_change(struct net_device *dev,
>  	if (!br_vlan_is_bind_vlan_dev(upper_dev))
>  		return;
>  
> -	if (linking) {
> +	br_vlan_toggle_bridge_binding(dev, linking);
> +	if (linking)
>  		br_vlan_set_vlan_dev_state(br, upper_dev);
> -		br_opt_toggle(br, BROPT_VLAN_BRIDGE_BINDING, true);
> -	} else {
> -		br_opt_toggle(br, BROPT_VLAN_BRIDGE_BINDING,
> -			      br_vlan_has_upper_bind_vlan_dev(dev));
> -	}
>  }
>  
>  struct br_vlan_link_state_walk_data {

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


