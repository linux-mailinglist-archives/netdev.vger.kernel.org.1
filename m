Return-Path: <netdev+bounces-43033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D617D10BA
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 15:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8059280EAC
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 13:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163B91C6A0;
	Fri, 20 Oct 2023 13:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A6C1BDDA
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 13:45:49 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B50319E
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 06:45:46 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-692-GTqKNN5rMLCOyLdXtv-uwQ-1; Fri, 20 Oct 2023 09:45:34 -0400
X-MC-Unique: GTqKNN5rMLCOyLdXtv-uwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97F11102020A;
	Fri, 20 Oct 2023 13:45:29 +0000 (UTC)
Received: from hog (unknown [10.39.192.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DEF032026D4C;
	Fri, 20 Oct 2023 13:45:27 +0000 (UTC)
Date: Fri, 20 Oct 2023 15:45:26 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, richardcochran@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	sebastian.tobuschat@oss.nxp.com
Subject: Re: [PATCH net-next v7 3/7] net: macsec: revert the MAC address if
 mdo_upd_secy fails
Message-ID: <ZTKEdvpNl-gwGpk6@hog>
References: <20231019120209.290480-1-radu-nicolae.pirea@oss.nxp.com>
 <20231019120209.290480-4-radu-nicolae.pirea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231019120209.290480-4-radu-nicolae.pirea@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

2023-10-19, 15:02:05 +0300, Radu Pirea (NXP OSS) wrote:
>  	/* If h/w offloading is available, propagate to the device */
> -	if (macsec_is_offloaded(macsec)) {
> +	if (offloaded) {
>  		const struct macsec_ops *ops;
>  		struct macsec_context ctx;
>  
>  		ops = macsec_get_ops(macsec, &ctx);
> -		if (ops) {
> -			ctx.secy = &macsec->secy;
> -			macsec_offload(ops->mdo_upd_secy, &ctx);
> +		if (!ops) {
> +			err = -EINVAL;

For consistency with other places where macsec_get_ops fails, this
should probably be -EOPNOTSUPP.

I'm not opposed to this change, but I'm not sure how it's related to
the missing rollback issue. Can you explain that a bit?

> +			goto restore_old_addr;
>  		}
> +
> +		ctx.secy = &macsec->secy;
> +		err = macsec_offload(ops->mdo_upd_secy, &ctx);
> +		if (err)
> +			goto restore_old_addr;
>  	}
>  
>  	return 0;
> +
> +restore_old_addr:
> +	if (dev->flags & IFF_UP) {
> +		int err;

[This bit confused me quite a bit, seeing the declaration and the
"return err" out of this block]

> +		err = macsec_dev_uc_update(dev, old_addr);
> +		if (err)
> +			return err;

If we can avoid it, we should try to have a rollback path without any
possible failures, otherwise we'll leave things in a broken state (in
this case, telling the user that the MAC address change failed, but
leaving the new address set on the macsec device).

Paolo suggested to postpone the dev_uc_del until after the offload
code, so we'd end up with something like this [completely untested]:


	if (dev->flags & IFF_UP) {
		err = dev_uc_add(real_dev, addr->sa_data);
		if (err < 0)
			return err;
	}

	ether_addr_copy(old_addr, dev->dev_addr);
	eth_hw_addr_set(dev, addr->sa_data);

	/* If h/w offloading is available, propagate to the device */
	if (macsec_is_offloaded(macsec)) {
		// ...
	}

	if (dev->flags & IFF_UP)
		dev_uc_del(real_dev, old_addr);

	return 0;

restore_old_addr:
	if (dev->flags & IFF_UP)
		dev_uc_del(real_dev, addr->sa_data);

	eth_hw_addr_set(dev, old_addr);

	return err;


Install both UC addresses, then remove the one we don't need.


-- 
Sabrina


