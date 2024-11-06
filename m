Return-Path: <netdev+bounces-142323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8B59BE462
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BFE51C21409
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D3B1DDC02;
	Wed,  6 Nov 2024 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Cf/5WV1t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181081D358B
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889462; cv=none; b=O+/Jx9fQ5f7T2Eh35FYJBhwUQK7VsPPD5dg67rUwLyaIGJUODtdrGA8L3PWE5lBAdXBE4yym9y5OMKiLXfRbtR7JJ2/3B9DumuQjys6oKeutHOSwdYivey5HDkIaXRWC8SgRbHmtABNgSpD4vw8Avcs45gEYY96HDwO2zZAF5xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889462; c=relaxed/simple;
	bh=jOif8FQadUnuye8Ttl77FAlnz6vhVb7oEXscNsHm4h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=danzV+xumWVYvuHjDK4IqLhzAf6VKakUiaNgAnO1cbP2yyyAHXjMkmOplHJdwlqxmh2X/RetEp4MuBR/9W0eDSSYVivcFdIMljx23VQCV91jl9iSSikGlTlqo6lbOEop9AnMePJ/Dxe53dHmDZT+oRu+4PUjEYzfHd0i2shAfrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Cf/5WV1t; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e13375d3so6757842e87.3
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 02:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1730889459; x=1731494259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cmU3fqmWGasDeNpK28/g1uERN4rq63zbFv2lUm4yeEM=;
        b=Cf/5WV1t2VAMFn5yNX+8gZOwucbmAI3yASlpNtMk2wqYKYRygYxNew2sdjkSbW9UDf
         /ent9fNgtVuDh+3npcCVAYqWOGfCQxIzJuZF6/xCq+7EhWYusmF67hfmxYbXDzFMpcdk
         GpiQ7bVVlPeqisFe9bDZwy51FT0FFAaLbNZQCc+NCTYcFr21PLMmxRWC+vJFEfymGFme
         LDeFxD+me3sjPx9x/BmSE3UqYlXzgCKelpsevqN2JFLTjnRjjirWRNQMaoM/qtp0jlm0
         GHGcH1K211u9GUg2Om62dp2hvAKMW+nusAjUraz7b946d7GnL+QH0vdlYzEgaW0O+NI+
         mGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730889459; x=1731494259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmU3fqmWGasDeNpK28/g1uERN4rq63zbFv2lUm4yeEM=;
        b=gBP5xgzxtALtQr3rx9Vb/4m4RNPSrS4qxZ2+xZ0zIh9tNMT5XvQ/SdcZimylotfdEF
         Zr7IUzv8XrydRi8j04u3a5NwyPAHIROuTKeTmUSsiH39cZhyhhusc8+1qH6b5tBnpyHG
         YGOeEMyx+5EBuoreOwBPLVMYOCYVJKpvM1L5IKLVd1kHetuAa7l2rhnwqHrJkA3oiU0k
         TDTy6+CF0SwOBt0dQJiLGmbnwznHmZsTqakhXVG7VcSpmynGoaMkrTXCNIgTmMQ+EG/k
         5bQw7HF0X4xWTf9+hFWoudl0IbVw6OQXFC55ENy2EtyLbvMhXEVP4WZ7CZA7kt/rS2FD
         IW3A==
X-Forwarded-Encrypted: i=1; AJvYcCXAI9IUMHEbsntsZuecpDX0IbYZ+kqBi9O19qLOIaEZilecnwge+gS9N+LbfBw1ozdyCC/HIPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydnc+D19Wm2hDxEgEeAwa6M4hc7Nq6buFjP7walvp1YTSCOy0H
	cvl8GbzqASX5RB1GmW4ElT3bDocKzMBkv6rKi33A5wIYNQa7xaU6S2AItdpFQbA=
X-Google-Smtp-Source: AGHT+IG7+2i40UepHv81AZKJ6FFmxffjZlbx8EqJ+qWihoFOP9elPkzb0OR/5ZJP1q96NpfUS0YdlQ==
X-Received: by 2002:ac2:4c4b:0:b0:53a:bb9:b54a with SMTP id 2adb3069b0e04-53c79e8ed05mr10223072e87.48.1730889459118;
        Wed, 06 Nov 2024 02:37:39 -0800 (PST)
Received: from localhost ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc96186sm2456362e87.30.2024.11.06.02.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 02:37:38 -0800 (PST)
Date: Wed, 6 Nov 2024 12:37:36 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/7] rtnetlink: Add peer_type in struct
 rtnl_link_ops.
Message-ID: <ZytG8LySPklk4ZOW@penguin>
References: <20241106022432.13065-1-kuniyu@amazon.com>
 <20241106022432.13065-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106022432.13065-3-kuniyu@amazon.com>

On Tue, Nov 05, 2024 at 06:24:27PM -0800, Kuniyuki Iwashima wrote:
> In ops->newlink(), veth, vxcan, and netkit call rtnl_link_get_net() with
> a net pointer, which is the first argument of ->newlink().
> 
> rtnl_link_get_net() could return another netns based on IFLA_NET_NS_PID
> and IFLA_NET_NS_FD in the peer device's attributes.
> 
> We want to get it and fill rtnl_nets->nets[] in advance in rtnl_newlink()
> for per-netns RTNL.
> 
> All of the three get the peer netns in the same way:
> 
>   1. Call rtnl_nla_parse_ifinfomsg()
>   2. Call ops->validate() (vxcan doesn't have)
>   3. Call rtnl_link_get_net()
> 
> Let's add a new field peer_type to struct rtnl_link_ops and prefetch
> netns in the peer ifla to add it to rtnl_nets in rtnl_newlink().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> ---
> v2:
>   * Rename the helper to rtnl_link_get_net_ifla()
>   * Unexport rtnl_link_get_net_ifla() and made it static
>   * Change peer_type to u16
>   * squash patch 2 & 3 (due to static requires a user)
> ---
>  include/net/rtnetlink.h |  2 ++
>  net/core/rtnetlink.c    | 55 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 53 insertions(+), 4 deletions(-)
> 
 
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


