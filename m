Return-Path: <netdev+bounces-13783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B7A73CECD
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 09:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6F2280FBD
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 07:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E677FC;
	Sun, 25 Jun 2023 07:07:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB47C
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 07:07:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2118.outbound.protection.outlook.com [40.107.237.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3C8BF
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 00:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhpgTVlgpIVLHMcjmLLaSKk6fzRX9qYZbMsxO4lJS3nqw6PRw8tKttTGrMYrEtHCh84kpoo9j54AE8Kvwd8OZXRsqN4y+UCVfVaOpI2SdFAsIhoWt0CYtDcfgOIHLTVaQBD2VDqSWrmjSoNfG3NJXHJEVg81Z8V4nc1ktHPkwPQ3LflgWXBU1ZWSY0FV8MG1C9JxcCxWfOoAhwBDkvt2+VJ3piDRtrhBd0rPe3V8KslZutYBWOViIhrV6Kg0ZVJYZr/oKC7NWcLmkjRe2HbX1n8Tbx7ouk+WMXje9/F/e16KjDSfWcJ1/eoL2+Tx/JE/AmEBHy0SNUdJlnp0KeMLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ1wTzeXr4xdRcJ3n5mqYxp+5RyNy1iUsiYVG9+EuP0=;
 b=iRgQJAa0+01LmBLkpOePGKYXaXanO0mYyR39P01CSTPuYbK4JmXXx+RX7VVtxT+TfrICdsdnn1AXaG4qj0CH5LS2B16DpuV9yInUIhW64m6ANZKEldxRddsWuyMu8EJ2+Mzz7LjZH8MMvf0zDWLHpXJPkn2tyhd0o0v/JR/2c2tW8spjG79AEUSIZD0DxCs5flrXLuthNLgs07MgDHyoa0GNXxDcj3eswfrocwhQqCJwrdAQSNk/IbHe5B/ZJIm8JhKnDCgDWBWiBiEn1v1bJhAY+mqPPRyeKKIg9GWck4+GlqcsgwIcHP+YvxhJ0jvYb9Ikid0YtoenG7oFh3x8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ1wTzeXr4xdRcJ3n5mqYxp+5RyNy1iUsiYVG9+EuP0=;
 b=ka4/bwxFBxN3zaHXbGsapsPtfuP1GDMV4UqYPEgAforjvB5FPx4FD5n5kMMaGIUJFEWdKGhej6TfhKouoT/6CexMqffDAe6RvwMsI7km15wF6Tnn3dP7VWOJMCjWD8q10C8rDIB8baBLELpzsmH0Xk4b34y6HWmCfWAkghnUKtM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB6090.namprd13.prod.outlook.com (2603:10b6:510:2bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Sun, 25 Jun
 2023 07:06:55 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Sun, 25 Jun 2023
 07:06:55 +0000
Date: Sun, 25 Jun 2023 09:06:48 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Lin Ma <linma@zju.edu.cn>
Cc: krzysztof.kozlowski@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, sameo@linux.intel.com,
	thierry.escande@linux.intel.com
Subject: Re: [PATCH v4] net: nfc: Fix use-after-free caused by
 nfc_llcp_find_local
Message-ID: <ZJfniMAoum2x6ul4@corigine.com>
References: <20230625005439.8728-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625005439.8728-1-linma@zju.edu.cn>
X-ClientProxiedBy: AM4PR05CA0016.eurprd05.prod.outlook.com (2603:10a6:205::29)
 To PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: c1267337-0319-425c-24d1-08db754ac1f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7kqMsrvk+myuZfMfoQB4KFNOIaQJgRMden4dqyxaM+V4r/NkgXxU13i2EuCWK3L6MS1H5JsGn+UI3WjlYLUDp3yb12gau8qw3n/qACsLjv/H5vXLlLPdysaJpg2lcR+136m4xXVN1drsEH5j4ew/1Gz1yk6BDD2bP5/4/rmCTCGvSma8SRVm7R1uCuj74QSGmRiDif2DdpGs7JQjkGQrNFHMPa7LC/VHO1AJqRxLUV50+AY6ddCZ88TxURFR0wLDnJnLFftofTtL092BkKTNZ691nynAMxztPJYxw9zzp4tllOLkcmnA92ibD84tIYKQ0N3sEcnFVvqIg+yTsUd7CiBUCzvWNgZzo98/QXHxUKR5XCFYDbq4nZ+93U4pZjIkXXKRKChVvdFOhGHjb+puD1oS/cjyuEbiHu98vYMMMbO6g+NUC8kONw5WNPyq+F4HVwX2eMZSaaYzC38hkDzJpqOvmxXg82bPotsq5hfW4naPHiZ+UyA3I4UNspIDnZ9x2hBBR1J6F3x9+2McGCRn3fPNphQjb6I3ZOFVAS/K9ePy5kej+xb6Ew5fDPSAbzpGczDgCuQTcuxpqbWc8LzPbXXOpiS1uvf8FMb/sEMH/Yw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(396003)(376002)(346002)(366004)(136003)(451199021)(478600001)(6486002)(6666004)(6512007)(6506007)(186003)(66946007)(2906002)(41300700001)(316002)(66556008)(66476007)(6916009)(4326008)(44832011)(5660300002)(8936002)(8676002)(38100700002)(86362001)(36756003)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eBsR+uanxi2eXKAYngDkAGWRKmn80vlxMmSpHJ9G4KLnEtWRb07f785XdzNu?=
 =?us-ascii?Q?13+6kGQrNd9qDCPjeVKPdUjAxftI50+cuOZEVxNupStwCsRKugunXUXts7TF?=
 =?us-ascii?Q?8AkBBmcV6Ny8WZMUJw2XYfeCFx/groYm4sr8kplv+mQtpghaZQnfyBJ7lVLW?=
 =?us-ascii?Q?4lMBbjUBV9mgUbGzT60ivxDj6/tHni35ctsvdbGgTNOyXnNUt9Yaw6ihn7Nk?=
 =?us-ascii?Q?YAfbAKZ7uT4bT5vl3S2djJ0jUnuEs2FHTUb0eeDuFtCG5/DhejHL9lrIs8zT?=
 =?us-ascii?Q?Tlj47weY+G2pI1+N8S8pQCBrUfg6sZHYG9T7IvgOkWknzO446TvXyrdOR9s9?=
 =?us-ascii?Q?HYydzT3JUlhUfJMbyYBA2Ku79PwfBfNTzVrNaToSGHuQ/D9kmxPDF2Hbb4KP?=
 =?us-ascii?Q?pL+by2WgCVqEEZjREoo7QQiXppiFEAdIPEeYi69J3FJfbPJEjUDFRXr8cP90?=
 =?us-ascii?Q?ZsjWW2hcT2/3vTWYjiVnvzebuUGyn0DKBCjSxdtfBucsUYpvl7lXdwnVtXp6?=
 =?us-ascii?Q?z7x8KW8Xrd1Z3rj2yI31yiu74RUhn+wdq0KDT89RDiJBctME2Z0knCLd0btE?=
 =?us-ascii?Q?0nACdVkS+TkhQhF4pjAfIdL1F6WMIBm4aXZnKYZkNubidAvSdIRjmJU5rJJG?=
 =?us-ascii?Q?tuoRkNVHsWyadVRr6cyYYbSyqQ3t/1K+JAd4Ds3G4FzlIp1GD9Whhg34pUgI?=
 =?us-ascii?Q?RQpdZCRbD8fQJqjJMU+y/EOfnjxsRbUPbP11glTyxHn7X/gx8g2/qninuJJg?=
 =?us-ascii?Q?UolB9TA0ULhQqkkRQpdQY+9dcdfHMab8a97EUlF8IDFV5yvtfZj2wjqZt/gU?=
 =?us-ascii?Q?RXQP8D9dp+blKWlbW4SdX82OZaZKBPu7ea+m2//AgFyd6Y/aAD87hHFACgrF?=
 =?us-ascii?Q?Pjj+ozQX3EX8GWsbNRCybRYCDCG8lHzdRmk4YMH1e8QBA9HH67RvkAwMqK4s?=
 =?us-ascii?Q?3xGlEQC5u/L6KpxTL4Nn9FW0LpZxzch2ELZdMMKp+k6r+p5ypXZkarl2qPTX?=
 =?us-ascii?Q?rzBzyMh4HLdjRGVc4Gfbf6dJdMXDQelSE4X4GJIZkb34x56PhmBwjapJ5zkm?=
 =?us-ascii?Q?ycAw0bDCHVVervSsmuubXJU/9dhWxXKVCcGUNJmmg9J5aQ6YPJb5Dp/9wbMH?=
 =?us-ascii?Q?C/VLiBBn5rjpaBgCIwjWMQuCkLiisUnT/jSa1AuZdT19MTfGFtuzOEZImrlg?=
 =?us-ascii?Q?N1vBm2W6uo/NK6T3adsk9HuLR5cUn8t8SJgjtJkJOtYcREnxbSvYs0TM/Wav?=
 =?us-ascii?Q?q+CZpNZ5axStOXIjzHRiScIBxXK+bxEAIbOCW9K2QKyNNiqGOua+ubEfsG0J?=
 =?us-ascii?Q?Dp92JaAdkody0oL8DQTwnpPkNbCtxC9Tl1M+wNTSGYal8A5cBOJbg0nEmdZq?=
 =?us-ascii?Q?1MnjDfxqy8e767JpZShbC9WsA+tFFv2qcvz18xHO1YAUGUHbLJmjrdx/6Xfb?=
 =?us-ascii?Q?bu8QvRfMtcs20qDiQJao/D5csnHfIYP7aYoXuPUftgr1hotDsWSCcOdXi/wW?=
 =?us-ascii?Q?hmeCEYwY+gPVnQql6z/bss2iIDJ7iAdOV1lxjrvvbT/g02Il/ztT4gOahDsw?=
 =?us-ascii?Q?0eiQJpFuBFaNGNjOpwfJHuTjiySL70SD35v4kbfLt+LF34PrwKrP9dHhkjej?=
 =?us-ascii?Q?BWmQoQ+gcEtpfnn1hh14icJ3mtc4VqB59r9zSSnRmfZyKnnJR3IgvGHYdQqo?=
 =?us-ascii?Q?b55wMg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1267337-0319-425c-24d1-08db754ac1f7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 07:06:55.1175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLVmt+TUvbgEnIIBAV2eq0H1ojqcP7MwKNYEGdkFnxsAd+RMrrCFW1gYOfBMh3yrRV49VJOxUg7hibLhcjLN/oEqJ8L5GjyXm93SQbazono=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6090
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

+ Blamed authors; corected davem's email address

On Sun, Jun 25, 2023 at 08:54:39AM +0800, Lin Ma wrote:

...

> @@ -696,20 +696,22 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr *_addr,
>  	if (dev->dep_link_up == false) {
>  		ret = -ENOLINK;
>  		device_unlock(&dev->dev);
> -		goto put_dev;
> +		goto sock_llcp_put_local;
>  	}
>  	device_unlock(&dev->dev);
>  
>  	if (local->rf_mode == NFC_RF_INITIATOR &&
>  	    addr->target_idx != local->target_idx) {
>  		ret = -ENOLINK;
> -		goto put_dev;
> +		goto sock_llcp_put_local;
>  	}
>  
>  	llcp_sock->dev = dev;
> -	llcp_sock->local = nfc_llcp_local_get(local);
> +	llcp_sock->local = local;
>  	llcp_sock->ssap = nfc_llcp_get_local_ssap(local);
>  	if (llcp_sock->ssap == LLCP_SAP_MAX) {
> +		llcp_sock->local = NULL;
> +		llcp_sock->dev = NULL;
>  		ret = -ENOMEM;
>  		goto sock_llcp_put_local;
>  	}

Hi Lin Ma,

thanks for your patch.
I agree with the get/put handling in this patch.
But I have a question regarding the changes to llcp_sock_connect().

Setting of llcp_sock->local and llcp_sock->dev has been moved
from the sock_llcp_put_local label, below,
to the error handling for nfc_llcp_get_local_ssap, above.

For the case where nfc_llcp_get_local_ssap returns an error this seems
fine.  However, there are two other cases that this effects. Relevant
code, which appears between the hunk above and the one below is:

--- start ---
        llcp_sock->service_name = kmemdup(addr->service_name,
                                          llcp_sock->service_name_len,
                                          GFP_KERNEL);
        if (!llcp_sock->service_name) {
                ret = -ENOMEM;
                goto sock_llcp_release;
        }

        nfc_llcp_sock_link(&local->connecting_sockets, sk);

        ret = nfc_llcp_send_connect(llcp_sock);
        if (ret)
                goto sock_unlink;

        sk->sk_state = LLCP_CONNECTING;

        ret = sock_wait_state(sk, LLCP_CONNECTED,
                              sock_sndtimeo(sk, flags & O_NONBLOCK));
        if (ret && ret != -EINPROGRESS)
                goto sock_unlink;
--- end ---

It seems to me that in the error handling above,
where the gotos will feed into sock_llcp_put_local,
llcp_sock->local and llcp_sock->dev will not be reset to NULL
in these cases anymore.

Is that ok?

> @@ -758,9 +760,7 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr *_addr,
>  	nfc_llcp_put_ssap(local, llcp_sock->ssap);
>  
>  sock_llcp_put_local:
> -	nfc_llcp_local_put(llcp_sock->local);
> -	llcp_sock->local = NULL;
> -	llcp_sock->dev = NULL;
> +	nfc_llcp_local_put(local);
>  
>  put_dev:
>  	nfc_put_device(dev);

...

