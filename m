Return-Path: <netdev+bounces-34300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29977A30F0
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 16:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B621C20B27
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153F7134DE;
	Sat, 16 Sep 2023 14:39:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3456134
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 14:39:42 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87369114
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b/wh+9ZWZ5yWt0/liWIQXEZ459a98e/Pi4RAQCMmF18=; b=hLt8plyokgSX4e84no0aCSrLM4
	Sbyt+eP+jh89S8q8Fq7T2NG2l6E4NR+ruXozsFNK5ic9KLNg6W1Pl1ZI8F2+xc07KQd9p6kUenGyE
	t1rQhvZ0fDx/zXsaCH0NUmajS+M3GiJHIIxCbiGuai1A8eepNe7jQTBnyGmqmAEABaAY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qhWSO-006dqe-UK; Sat, 16 Sep 2023 16:39:36 +0200
Date: Sat, 16 Sep 2023 16:39:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Mubashir Adnan Qureshi <mubashirq@google.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>
Subject: Re: [PATCH v1 net-next 2/5] net-smnp: reorganize SNMP fast path
 variables
Message-ID: <2367db17-c5e9-4853-b607-8e84d90044b4@lunn.ch>
References: <20230916010625.2771731-1-lixiaoyan@google.com>
 <20230916010625.2771731-3-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916010625.2771731-3-lixiaoyan@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
> index 26f33a4c253d7..a414985c68bf9 100644
> --- a/include/uapi/linux/snmp.h
> +++ b/include/uapi/linux/snmp.h

UAPI. Warning bells are ringing.

> @@ -170,6 +170,22 @@ enum
>  enum
>  {
>  	LINUX_MIB_NUM = 0,
> +	/* TX hotpath */
> +	LINUX_MIB_TCPAUTOCORKING,		/* TCPAutoCorking */
> +	LINUX_MIB_TCPFROMZEROWINDOWADV,		/* TCPFromZeroWindowAdv */
> +	LINUX_MIB_TCPTOZEROWINDOWADV,		/* TCPToZeroWindowAdv */
> +	LINUX_MIB_TCPWANTZEROWINDOWADV,		/* TCPWantZeroWindowAdv */
> +	LINUX_MIB_TCPORIGDATASENT,		/* TCPOrigDataSent */
> +	LINUX_MIB_TCPPUREACKS,			/* TCPPureAcks */
> +	LINUX_MIB_TCPHPACKS,			/* TCPHPAcks */
> +	LINUX_MIB_TCPDELIVERED,			/* TCPDelivered */
> +	/* RX hotpath */
> +	LINUX_MIB_TCPHPHITS,			/* TCPHPHits */
> +	LINUX_MIB_TCPRCVCOALESCE,		/* TCPRcvCoalesce */
> +	LINUX_MIB_TCPKEEPALIVE,			/* TCPKeepAlive */
> +	LINUX_MIB_DELAYEDACKS,			/* DelayedACKs */
> +	LINUX_MIB_DELAYEDACKLOCKED,		/* DelayedACKLocked */
> +	/* End of hotpath variables */

At a first glance, this appears to change the kernel ABI?

Or am i wrong?

	Andrew

