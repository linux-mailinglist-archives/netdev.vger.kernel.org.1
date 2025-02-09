Return-Path: <netdev+bounces-164390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC69A2DA4A
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 02:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE51165853
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 01:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026C54409;
	Sun,  9 Feb 2025 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmKyMwNa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B54124339B;
	Sun,  9 Feb 2025 01:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739065431; cv=none; b=UyGWvW9VZLCfQqp/0Ih8PTI0yp6q6CTVYk/DiJkuDiWe7WAnAdL+HStc4yX/EkP5WLIWhYEiYn5dxvge89I7ge+CDd0OZRdv2O+v8LbES1N7jRzUP1IIBBFA+sfoge5xOjvXI48zU+ALTbTw3b1F3SN7UHRyCPPv+nqjwi+QBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739065431; c=relaxed/simple;
	bh=v6hmjDlCyLMRg1UetyuPjiAp5m87VU1tV0Vw28F5GXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWvOSQbfmkfBFnfueMuIO7aq/fVpyiQubRBGKLc7lRvBXgLSqWm00vwcEtlHrxDFc4ujXNRMK/cO4EoDRc3fvMDRUBDXd+pr2ir826v6yl/0OBkKKlI0KgPvy8R0C49Ec+Jx4mmy2/viqkpY6e38DGIGMg6vhhVsuxhY63HCIog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmKyMwNa; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fa0f222530so5914683a91.0;
        Sat, 08 Feb 2025 17:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739065429; x=1739670229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5AWXsi+AKsTgHHtORUOGnKJ5JY/sS6Wt7Sy7YQM9hfQ=;
        b=GmKyMwNavwo3OkQ8+bK9AqlEkXjJTpSWZ9sEU/Ni/Qt3c73MwOaFcoWy/Dg0iaknle
         tSZCTuJAtmkI90eUDV1JWvRR25jjTkQ13M3YWyXVm9ThQjapZ/Z4xsAtNNlUVb4oxytd
         pvmXZnOEgo3nF910LbYDK91GesQ7LqCE/55aD0Zh1euVNfl44GBK4n6aCqzTTweFb5Ew
         1uctEDW1Pk0rHjoEp0t8R0A2lPgKrpqKiQZx6AXF5CLXaXz2qugRBjknezwD5BfhEP/X
         EId9lZvNcQ/X/lu5SQtAGfkKue8/ba+E6c3Pvxsq8h+LEJLwUY0Eu6d3jWpZxRRpeeCA
         Ek4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739065429; x=1739670229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AWXsi+AKsTgHHtORUOGnKJ5JY/sS6Wt7Sy7YQM9hfQ=;
        b=WLV8RoOnWruSR7x+io2gYxRvdLhVl75RYN+J5Zski/+P33CeOIEvD5gbWu+ngUbeqT
         gv7cRZtciR++Z1SvAz18iDN0zxyQVyFXRKieK4F6zOTIXROd6X2aWKRmMyaTakSWF0n4
         HLok08s3iAVSuf5E1bAf4JWNtovhYwuOX+FxghGmZjk5777ojtMQlXvokXmDxap+qh2C
         xZTE6pSykCTxECyPshlQIwvMpkkxepzPIjuZrvrGRHkFZ8SuiJ40AtPPCTo9pZvjJCUm
         FmkJw8lh9VR0FahzVPbdOLKXH3kOV+juOtPUak0BpQPpLYEo2C8Uib8ukRHUMHqF2FbP
         GoYA==
X-Forwarded-Encrypted: i=1; AJvYcCWas0aXjNo5ciqqZFM51g8WJSA+BhJK7Vrz5r+BcMr2jTq8G0z3KRaTcjQngIVOZf1Qk6I+qE6Rcpqjqmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7CwAkOrCF9n2Dv4pcsE+fowmZQBCFUoa1Lnx71EU0Z47HIPaY
	tuzPc4VsgsAc2xvde4JKPxDo4M6PpnbbsxaMMyVli7mHI+lTDB7iTO5n
X-Gm-Gg: ASbGncsIC5TQoNxd3Yhvzlc8zWbdvk7DigyDlWyYjEDMxWQyhrs2x90HJ2t2jjgTAh+
	AD4YCuYGc6A8naFRE/woCWpWLsYqX/LF6IvCpQi5F7uLWmcfiFs5w40hNlWsqsfjFY1y6ZmA3X4
	j4Ob60D1fogXY3EArjTxvMpwVsFtYybl+AidkP3UGshvPlpT/Z8SZBT9jyQQOFIQ286M8FPM5Vr
	r9m+cIpBBenx5CVMtWl9vzL5dJ6v7rWVAAsh4p0KoQFSsrCeqF7Lr1k9MDSJdP/QxgqSp6b9NWd
	rfu9c1MJvBzSbus=
X-Google-Smtp-Source: AGHT+IFmFJAmh1tWNvRFjQSGVwYYSKdDOMdzkY+wVKFb14shO0sampmYnW0/uF7Hk7Eoq04gZJc1Ww==
X-Received: by 2002:a05:6a00:1821:b0:729:49a:2da6 with SMTP id d2e1a72fcca58-7305d43a913mr15025099b3a.3.1739065429428;
        Sat, 08 Feb 2025 17:43:49 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73048ad28bfsm5392358b3a.51.2025.02.08.17.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 17:43:48 -0800 (PST)
Date: Sat, 8 Feb 2025 17:43:47 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	David Wei <dw@davidwei.uk>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 2/3] netdev-genl: Add an XSK attribute to
 queues
Message-ID: <Z6gIU3bsIjsYqCN_@mini-arch>
References: <20250208041248.111118-1-jdamato@fastly.com>
 <20250208041248.111118-3-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250208041248.111118-3-jdamato@fastly.com>

On 02/08, Joe Damato wrote:
> Expose a new per-queue nest attribute, xsk, which will be present for
> queues that are being used for AF_XDP. If the queue is not being used for
> AF_XDP, the nest will not be present.
> 
> In the future, this attribute can be extended to include more data about
> XSK as it is needed.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  v5:
>    - Removed unused variable, ret, from netdev_nl_queue_fill_one.
> 
>  v4:
>    - Updated netdev_nl_queue_fill_one to use the empty nest helper added
>      in patch 1.
> 
>  v2:
>    - Patch adjusted to include an attribute, xsk, which is an empty nest
>      and exposed for queues which have a pool.
> 
>  Documentation/netlink/specs/netdev.yaml | 13 ++++++++++++-
>  include/uapi/linux/netdev.h             |  6 ++++++
>  net/core/netdev-genl.c                  | 11 +++++++++++
>  tools/include/uapi/linux/netdev.h       |  6 ++++++
>  4 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 288923e965ae..85402a2e289c 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -276,6 +276,9 @@ attribute-sets:
>          doc: The timeout, in nanoseconds, of how long to suspend irq
>               processing, if event polling finds events
>          type: uint
> +  -
> +    name: xsk-info
> +    attributes: []
>    -
>      name: queue
>      attributes:
> @@ -294,6 +297,9 @@ attribute-sets:
>        -
>          name: type
>          doc: Queue type as rx, tx. Each queue type defines a separate ID space.
> +             XDP TX queues allocated in the kernel are not linked to NAPIs and
> +             thus not listed. AF_XDP queues will have more information set in
> +             the xsk attribute.
>          type: u32
>          enum: queue-type
>        -
> @@ -309,7 +315,11 @@ attribute-sets:
>          doc: io_uring memory provider information.
>          type: nest
>          nested-attributes: io-uring-provider-info
> -
> +      -
> +        name: xsk
> +        doc: XSK information for this queue, if any.
> +        type: nest
> +        nested-attributes: xsk-info
>    -
>      name: qstats
>      doc: |
> @@ -652,6 +662,7 @@ operations:
>              - ifindex
>              - dmabuf
>              - io-uring
> +            - xsk
>        dump:
>          request:
>            attributes:
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index 6c6ee183802d..4e82f3871473 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -136,6 +136,11 @@ enum {
>  	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
>  };
>  
> +enum {
> +	__NETDEV_A_XSK_INFO_MAX,
> +	NETDEV_A_XSK_INFO_MAX = (__NETDEV_A_XSK_INFO_MAX - 1)
> +};
> +
>  enum {
>  	NETDEV_A_QUEUE_ID = 1,
>  	NETDEV_A_QUEUE_IFINDEX,
> @@ -143,6 +148,7 @@ enum {
>  	NETDEV_A_QUEUE_NAPI_ID,
>  	NETDEV_A_QUEUE_DMABUF,
>  	NETDEV_A_QUEUE_IO_URING,
> +	NETDEV_A_QUEUE_XSK,
>  
>  	__NETDEV_A_QUEUE_MAX,
>  	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 0dcd4faefd8d..b5a93a449af9 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -400,11 +400,22 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
>  		if (params->mp_ops &&
>  		    params->mp_ops->nl_fill(params->mp_priv, rsp, rxq))
>  			goto nla_put_failure;
> +
> +		if (rxq->pool)
> +			if (nla_put_empty_nest(rsp, NETDEV_A_QUEUE_XSK))
> +				goto nla_put_failure;

Needs to be guarded by ifdef CONFIG_XDP_SOCKETS?


net/core/netdev-genl.c: In function ‘netdev_nl_queue_fill_one’:
net/core/netdev-genl.c:404:24: error: ‘struct netdev_rx_queue’ has no member named ‘pool’
  404 |                 if (rxq->pool)
      |                        ^~
net/core/netdev-genl.c:414:24: error: ‘struct netdev_queue’ has no member named ‘pool’
  414 |                 if (txq->pool)
      |                        ^~


---
pw-bot: cr

