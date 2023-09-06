Return-Path: <netdev+bounces-32286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC6E793E6D
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 16:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A270F1C20B5D
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 14:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CFA10796;
	Wed,  6 Sep 2023 14:12:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D81613D
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 14:12:30 +0000 (UTC)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E72E4C;
	Wed,  6 Sep 2023 07:12:24 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34e2be5679dso12618565ab.1;
        Wed, 06 Sep 2023 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694009544; x=1694614344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E88Kne0Q5T1jKsknm9/oaNAHcgaUsB/igz0cwVMhvJQ=;
        b=imMRWXIB9PwGYgw2j2e/JCXgb8es1YVM5gw03kD+E24rPEYqEkgAJV/50FSksLO52H
         tuHgThuxS4KuIbvr0bg1MvZsLaMQItF2vdMoIMbPFL5jlvLEtvoQiZEFmh4q/SRU/QCa
         jTQGdSZ4Q04dQgFI9GtM8MmOZ+C6VUReQz8uYbNKA29aTm0VZCWZCUqfXYZ4NYJxj7il
         HwtoS2/Q0PhlOmqvl1HB+WeT5hefx+JyDX3u0973fg6IhGwqOsxtZWRcuLTpqKI4isRl
         i+quGgTNephbMUTq1mqqidIyIAZjLi+MQEQXbcse/iFztqcjO7S+160ioQpITknT1H4c
         lVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694009544; x=1694614344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E88Kne0Q5T1jKsknm9/oaNAHcgaUsB/igz0cwVMhvJQ=;
        b=GE5IQD7UlNHsPTLc7Ph0xWJR0Il479l7bDDEL78USKUCIjPpWxKjxUD7glXaJkITSD
         orcncdzJ0d8a2neq3h9+DA5O9Wqp3O82cgQ1THlCPD0FibSJRJIRTJYvq14iejl7ZvON
         bK8ebfuWEhySslGJ5C+G8EiizkB7XjE7iZbfIF4UMjQw3UJyINk99x+iAK8xyQwVQHBg
         rHqzEv5JPlAwLwKykdX9DL9yH+IwFo+RgHYi9WM47f4TXUhthInp+iEYkMBO5dAfTR6p
         mOTkQcE7ISPZzD6xrSdyyF3OmeeQOF1TeqPorQpFzyi+RcMfdvs8MXT7XgfhUXJrJ+w/
         1YUA==
X-Gm-Message-State: AOJu0Yz20SQLtReopd35RCKsdsj74bM2IlkwVBhA/xBy5eOUSOX3HwTt
	q+RfI64VaCvfo9qNEWIkD6Q=
X-Google-Smtp-Source: AGHT+IEfDR7qDd6fFD0sYtFXrp+w2sHhZKM6vgkvCwKx2RlcHYu8LPBhShjreX3dfCSGtFDg1V8Yjw==
X-Received: by 2002:a92:c74f:0:b0:34f:2484:64ce with SMTP id y15-20020a92c74f000000b0034f248464cemr5063515ilp.23.1694009544213;
        Wed, 06 Sep 2023 07:12:24 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t20-20020a17090b019400b002682392506bsm10992274pjs.50.2023.09.06.07.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 07:12:22 -0700 (PDT)
Date: Wed, 6 Sep 2023 22:12:18 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ziyang Xuan <william.xuanziyang@huawei.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] team: fix null-ptr-deref when team device type is
 changed
Message-ID: <ZPiIwruO1vgw4RfH@Laptop-X1>
References: <20230905081056.3365013-1-william.xuanziyang@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905081056.3365013-1-william.xuanziyang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 04:10:56PM +0800, Ziyang Xuan wrote:
> ---
>  drivers/net/team/team.c | 5 ++++-
>  net/ethernet/eth.c      | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> index d3dc22509ea5..12fb5f4cff06 100644
> --- a/drivers/net/team/team.c
> +++ b/drivers/net/team/team.c
> @@ -2127,7 +2127,10 @@ static const struct ethtool_ops team_ethtool_ops = {
>  static void team_setup_by_port(struct net_device *dev,
>  			       struct net_device *port_dev)
>  {
> -	dev->header_ops	= port_dev->header_ops;
> +	if (port_dev->type == ARPHRD_ETHER)
> +		dev->header_ops	= &eth_header_ops;
> +	else
> +		dev->header_ops	= port_dev->header_ops;
>  	dev->type = port_dev->type;
>  	dev->hard_header_len = port_dev->hard_header_len;
>  	dev->needed_headroom = port_dev->needed_headroom;
> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> index 2edc8b796a4e..157833509adb 100644
> --- a/net/ethernet/eth.c
> +++ b/net/ethernet/eth.c
> @@ -347,6 +347,7 @@ const struct header_ops eth_header_ops ____cacheline_aligned = {
>  	.cache_update	= eth_header_cache_update,
>  	.parse_protocol	= eth_header_parse_protocol,
>  };
> +EXPORT_SYMBOL(eth_header_ops);
>  
>  /**
>   * ether_setup - setup Ethernet network device
> -- 
> 2.25.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

