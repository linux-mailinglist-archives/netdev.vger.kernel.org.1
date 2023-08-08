Return-Path: <netdev+bounces-25474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C9877437E
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37E61C20E84
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628E11773F;
	Tue,  8 Aug 2023 18:02:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A596171B8
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:02:43 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35C9E58
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 10:35:13 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-5m0yJHpmNG2Itb77j3EMGw-1; Tue, 08 Aug 2023 11:22:14 -0400
X-MC-Unique: 5m0yJHpmNG2Itb77j3EMGw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EC3E3815EF1;
	Tue,  8 Aug 2023 15:22:13 +0000 (UTC)
Received: from hog (unknown [10.45.224.100])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BB9540BC780;
	Tue,  8 Aug 2023 15:22:12 +0000 (UTC)
Date: Tue, 8 Aug 2023 17:22:11 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: macsec: use TX SCI as MAC address
Message-ID: <ZNJdo6bow7uK8bTn@hog>
References: <20230808141429.220830-1-radu-nicolae.pirea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808141429.220830-1-radu-nicolae.pirea@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-08-08, 17:14:29 +0300, Radu Pirea (NXP OSS) wrote:
> According to IEEE 802.1AE the SCI comprises the MAC address and the port
> identifier.

I don't think the SCI needs to be composed of the actual device's MAC
address. 8.2.1 says that the MAC address *can* be used to compose the
SCI, but doesn't mandate it.

If you want the SCI to match the device's MAC address, why not use
IFLA_MACSEC_PORT instead?

> If a new MACsec interface is created with a specific TX SCI, use that
> SCI to set the MAC address of the new interface.
> 
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> ---
>  drivers/net/macsec.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index 984dfa5d6c11..6db69daf880d 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -4103,12 +4103,14 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
>  	/* need to be already registered so that ->init has run and
>  	 * the MAC addr is set
>  	 */
> -	if (data && data[IFLA_MACSEC_SCI])
> +	if (data && data[IFLA_MACSEC_SCI]) {
>  		sci = nla_get_sci(data[IFLA_MACSEC_SCI]);
> -	else if (data && data[IFLA_MACSEC_PORT])
> +		eth_hw_addr_set(dev, (u8 *)&sci);
> +	} else if (data && data[IFLA_MACSEC_PORT]) {
>  		sci = dev_to_sci(dev, nla_get_be16(data[IFLA_MACSEC_PORT]));
> -	else
> +	} else {
>  		sci = dev_to_sci(dev, MACSEC_PORT_ES);
> +	}
>  
>  	if (rx_handler && sci_exists(real_dev, sci)) {
>  		err = -EBUSY;
> -- 
> 2.34.1
> 

-- 
Sabrina


