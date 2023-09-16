Return-Path: <netdev+bounces-34207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB567A2CB9
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 02:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BA4285D03
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 00:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378B2A44;
	Sat, 16 Sep 2023 00:49:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A968736E
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 00:49:20 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264863C19
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 17:45:17 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76f08e302a1so173788585a.1
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 17:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694825106; x=1695429906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E8My/cgpW36hTwbXw0d1QkiE0VUgauihCO6z5sxZ0/E=;
        b=eU9UpzJh8EHPY/QAtklb6SNh2AtmKcDg3kCHURwo1WIp4z5XRh8tqWfAqMTPWgITts
         /BlEb919xKc7ZVuB6mw3f4viLCdxFIDBQvy+7nATRj1ZVxRqSZ8v2aPF7DAEL9lGWRrf
         9YQWBIK29uPvgvzMcd5c9DB2M3aTgrCoH9TShkRCHSIXKlT60Wqii5oJvi984DpY3zfn
         L3LTEPS0dvoopAwxBrL2uvAdGqBU4egwqZBVeY7PxJLcmJZzbnd/iSpE5M31y0msZ9y/
         Jm5PjhG+9DQ6m2c4YsFyuokiAeUaENU6WtZeg93gKWE/+u5CO0Em17FijhKyTtbiksmC
         hmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694825106; x=1695429906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8My/cgpW36hTwbXw0d1QkiE0VUgauihCO6z5sxZ0/E=;
        b=Va4gucQSgGvqV4eF0i1e9UIfIE1XyDnMweGVstQx6dFc0u6Y0EU4eCzv2O+8/d/12K
         2mPqHjnNoLFSIDuQQ1+kJxymkETvPXeYNhrVnuxDkn4roCalaPBfUp8dgiKACoWIccFu
         EoIpvhP20jMbb8ZhhmDOtBr9RleEJUDlL5ejsuR8t/pGcfQnIoXKeGC7WzEVaSIG7Qme
         WhFD5psUzZXN0TDdh9kxFxhmlLsUMibRxtImAj4ofleYQ8YN81EVyj3z6Co3NM0/Rgbc
         vWwNI4Fv7z/aZObS0+CvizG4DApv152bc90IcFrlPTVET+McyUCPZvWF5y2JGL2QQMb7
         e6bw==
X-Gm-Message-State: AOJu0YwufQFQ9j39q6qY3DthVCCstmg4xREr/4zlzgJV0i2aJmMw2n6K
	RlDGSmnU+zBeD4gm50XzZOs=
X-Google-Smtp-Source: AGHT+IHIYwg7guqWtegkkPi2ZxYZLT3nbaiTpa0LYdYNXOZzEBmMpMCs52ANdCX6tYXVUM4uWZI1VA==
X-Received: by 2002:a05:620a:4794:b0:76f:14a9:56fe with SMTP id dt20-20020a05620a479400b0076f14a956femr3102904qkb.58.1694825106010;
        Fri, 15 Sep 2023 17:45:06 -0700 (PDT)
Received: from localhost (modemcable065.128-200-24.mc.videotron.ca. [24.200.128.65])
        by smtp.gmail.com with ESMTPSA id u19-20020ae9c013000000b0076cc0a6e127sm1565047qkk.116.2023.09.15.17.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 17:45:05 -0700 (PDT)
Date: Fri, 15 Sep 2023 20:45:04 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] pktgen: Introducing 'SHARED' flag for
 testing with non-shared skb
Message-ID: <ZQT6kI7MgLdQTfHA@d3>
References: <20230915122317.100390-1-liangchen.linux@gmail.com>
 <20230915122317.100390-2-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915122317.100390-2-liangchen.linux@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-15 20:23 +0800, Liang Chen wrote:
> Currently, skbs generated by pktgen always have their reference count
> incremented before transmission, causing their reference count to be
> always greater than 1, leading to two issues:
>   1. Only the code paths for shared skbs can be tested.
>   2. In certain situations, skbs can only be released by pktgen.
> To enhance testing comprehensiveness, we are introducing the "SHARED"
> flag to indicate whether an SKB is shared. This flag is enabled by
> default, aligning with the current behavior. However, disabling this
> flag allows skbs with a reference count of 1 to be transmitted.
> So we can test non-shared skbs and code paths where skbs are released
> within the stack.
> 
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> 
> ---
>  Changes from v2:
> - Lifted the check on 'count' when 'not shared' is configured.
> - Fixed a use-after-free problem when sending failed
> ---
>  Documentation/networking/pktgen.rst | 12 ++++++++
>  net/core/pktgen.c                   | 47 ++++++++++++++++++++++++-----
>  2 files changed, 51 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/networking/pktgen.rst b/Documentation/networking/pktgen.rst
> index 1225f0f63ff0..c945218946e1 100644
> --- a/Documentation/networking/pktgen.rst
> +++ b/Documentation/networking/pktgen.rst
> @@ -178,6 +178,7 @@ Examples::
>  			      IPSEC # IPsec encapsulation (needs CONFIG_XFRM)
>  			      NODE_ALLOC # node specific memory allocation
>  			      NO_TIMESTAMP # disable timestamping
> +			      SHARED # enable shared SKB
>   pgset 'flag ![name]'    Clear a flag to determine behaviour.
>  			 Note that you might need to use single quote in
>  			 interactive mode, so that your shell wouldn't expand
> @@ -288,6 +289,16 @@ To avoid breaking existing testbed scripts for using AH type and tunnel mode,
>  you can use "pgset spi SPI_VALUE" to specify which transformation mode
>  to employ.
>  
> +Disable shared SKB
> +==================
> +By default, SKBs sent by pktgen are shared (user count > 1).
> +To test with non-shared SKBs, remove the "SHARED" flag by simply setting::
> +
> +	pg_set "flag !SHARED"
> +
> +However, if the "clone_skb" or "burst" parameters are configured, the skb
> +still needs to be held by pktgen for further access. Hence the skb must be
> +shared.
>  
>  Current commands and configuration options
>  ==========================================
> @@ -357,6 +368,7 @@ Current commands and configuration options
>      IPSEC
>      NODE_ALLOC
>      NO_TIMESTAMP
> +    SHARED
>  
>      spi (ipsec)
>  
> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index ffd659dbd6c3..5cc69feec7d7 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -200,6 +200,7 @@
>  	pf(VID_RND)		/* Random VLAN ID */			\
>  	pf(SVID_RND)		/* Random SVLAN ID */			\
>  	pf(NODE)		/* Node memory alloc*/			\
> +	pf(SHARED)		/* Shared SKB */			\
>  
>  #define pf(flag)		flag##_SHIFT,
>  enum pkt_flags {
> @@ -1198,7 +1199,8 @@ static ssize_t pktgen_if_write(struct file *file,
>  		    ((pkt_dev->xmit_mode == M_NETIF_RECEIVE) ||
>  		     !(pkt_dev->odev->priv_flags & IFF_TX_SKB_SHARING)))
>  			return -ENOTSUPP;
> -		if (value > 0 && pkt_dev->n_imix_entries > 0)
> +		if (value > 0 && (pkt_dev->n_imix_entries > 0 ||
> +				  !(pkt_dev->flags & F_SHARED)))
>  			return -EINVAL;
>  
>  		i += len;
> @@ -1257,6 +1259,10 @@ static ssize_t pktgen_if_write(struct file *file,
>  		     ((pkt_dev->xmit_mode == M_START_XMIT) &&
>  		     (!(pkt_dev->odev->priv_flags & IFF_TX_SKB_SHARING)))))
>  			return -ENOTSUPP;
> +
> +		if ((value > 1) && !(pkt_dev->flags & F_SHARED))
> +			return -EINVAL;
> +

Make sure to run checkpatch and check the patchwork results. There are
some points to correct:
https://patchwork.kernel.org/project/netdevbpf/patch/20230915122317.100390-2-liangchen.linux@gmail.com/

>  		pkt_dev->burst = value < 1 ? 1 : value;
>  		sprintf(pg_result, "OK: burst=%u", pkt_dev->burst);
>  		return count;
> @@ -1335,10 +1341,18 @@ static ssize_t pktgen_if_write(struct file *file,
>  		flag = pktgen_read_flag(f, &disable);
>  
>  		if (flag) {
> -			if (disable)
> +			if (disable) {
> +				/* If "clone_skb", or "burst" parameters are
> +				 * configured, it means that the skb still needs to be
> +				 * referenced by the pktgen, so the skb must be shared.
> +				 */
> +				if (flag == F_SHARED && (pkt_dev->clone_skb ||
> +							 pkt_dev->burst > 1))
> +					return -EINVAL;
>  				pkt_dev->flags &= ~flag;
> -			else
> +			} else {
>  				pkt_dev->flags |= flag;
> +			}
>  		} else {
>  			pg_result += sprintf(pg_result,
>  				"Flag -:%s:- unknown\n%s", f,
> @@ -3485,7 +3499,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
>  	if (pkt_dev->xmit_mode == M_NETIF_RECEIVE) {
>  		skb = pkt_dev->skb;
>  		skb->protocol = eth_type_trans(skb, skb->dev);
> -		refcount_add(burst, &skb->users);
> +		if (pkt_dev->flags & F_SHARED)
> +			refcount_add(burst, &skb->users);
>  		local_bh_disable();
>  		do {
>  			ret = netif_receive_skb(skb);
> @@ -3493,6 +3508,10 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
>  				pkt_dev->errors++;
>  			pkt_dev->sofar++;
>  			pkt_dev->seq_num++;
> +			if (unlikely(!(pkt_dev->flags & F_SHARED))) {
> +				pkt_dev->skb = NULL;
> +				break;
> +			}
>  			if (refcount_read(&skb->users) != burst) {
>  				/* skb was queued by rps/rfs or taps,
>  				 * so cannot reuse this skb
> @@ -3511,9 +3530,14 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
>  		goto out; /* Skips xmit_mode M_START_XMIT */
>  	} else if (pkt_dev->xmit_mode == M_QUEUE_XMIT) {
>  		local_bh_disable();
> -		refcount_inc(&pkt_dev->skb->users);
> +		if (pkt_dev->flags & F_SHARED)
> +			refcount_inc(&pkt_dev->skb->users);
>  
>  		ret = dev_queue_xmit(pkt_dev->skb);
> +
> +		if (!(pkt_dev->flags & F_SHARED) && dev_xmit_complete(ret))
> +			pkt_dev->skb = NULL;
> +
>  		switch (ret) {
>  		case NET_XMIT_SUCCESS:
>  			pkt_dev->sofar++;
> @@ -3551,11 +3575,15 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
>  		pkt_dev->last_ok = 0;
>  		goto unlock;
>  	}
> -	refcount_add(burst, &pkt_dev->skb->users);
> +	if (pkt_dev->flags & F_SHARED)
> +		refcount_add(burst, &pkt_dev->skb->users);
>  
>  xmit_more:
>  	ret = netdev_start_xmit(pkt_dev->skb, odev, txq, --burst > 0);
>  
> +	if (!(pkt_dev->flags & F_SHARED) && dev_xmit_complete(ret))
> +		pkt_dev->skb = NULL;
> +
>  	switch (ret) {
>  	case NETDEV_TX_OK:
>  		pkt_dev->last_ok = 1;
> @@ -3577,7 +3605,8 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
>  		fallthrough;
>  	case NETDEV_TX_BUSY:
>  		/* Retry it next time */
> -		refcount_dec(&(pkt_dev->skb->users));
> +		if (!(pkt_dev->flags & F_SHARED))
> +			refcount_dec(&(pkt_dev->skb->users));

With "flag !SHARED", this leads to a refcount underflow if the driver
returns NETDEV_TX_BUSY.

It looks like the condition is inverted, no?

I tested it by hacking e1000_xmit_frame() to return NETDEV_TX_BUSY right
at the beginning.

