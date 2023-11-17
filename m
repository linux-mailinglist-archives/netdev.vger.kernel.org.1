Return-Path: <netdev+bounces-48700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C4C7EF4C4
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817E41C20B05
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 14:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CE31947E;
	Fri, 17 Nov 2023 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="d/vZiQHj"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25447D50;
	Fri, 17 Nov 2023 06:50:25 -0800 (PST)
Received: from [192.168.12.102] (unknown [159.196.94.230])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A85A620172;
	Fri, 17 Nov 2023 22:50:21 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1700232623;
	bh=jMHZVSWO3q4VSAcpesYRAiXH3F2thoDimQFa8ds3lA4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d/vZiQHjf0lShuZqhvkwc1kq5RUWAjRHFOXSPOKUn2XqmfrfnP/3KVCinyDeXcG5P
	 P49RU+bfVRb0srvvJU4LItI26MnG+DlisnSygpCGkbb2Bu3fUGP6ZmwUwUqIRD/iIe
	 E8mLciueK8OZwm/rAUK2JvCQIPvNCAaxuNEKI6Ut1YnjMu8fNoHRwt/5mDerE8BUTV
	 OpOGO/hYTwlf5g0JcHXVBO+Cln3V0ZJQDekNG7IrVttVdn5Yo0zXYfYXJUQdupjLwh
	 z17tjTtJ9sJEurspRo55NOPrWppCaoJ9JxERjlWdPe9e6DktA4tJk8FWNTzcaV1hjY
	 VcqQogJiFsJJg==
Message-ID: <39c213c17712fdc8877b4277b430bfded71c3cca.camel@codeconstruct.com.au>
Subject: Re: [PATCH] mctp-i2c: increase the MCTP_I2C_TX_WORK_LEN to 500
From: Matt Johnston <matt@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Jinliang Wang
 <jinliangw@google.com>
Cc: William Kennington <wak@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 17 Nov 2023 08:50:18 -0600
In-Reply-To: <bd01e1544e388eb71b8713e94ea2165d1a805b54.camel@codeconstruct.com.au>
References: <20231117070457.1970786-1-jinliangw@google.com>
	 <bd01e1544e388eb71b8713e94ea2165d1a805b54.camel@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Fri, 2023-11-17 at 15:29 +0800, Jeremy Kerr wrote:
> 	spin_lock_irqsave(&midev->tx_queue.lock, flags);
> 	if (skb_queue_len(&midev->tx_queue) >=3D MCTP_I2C_TX_WORK_LEN) {
> 		netif_stop_queue(dev);
> 		spin_unlock_irqrestore(&midev->tx_queue.lock, flags);
> 		netdev_err(dev, "BUG! Tx Ring full when queue awake!\n");
> 		return NETDEV_TX_BUSY;
> 	}
>=20
> 	__skb_queue_tail(&midev->tx_queue, skb);
> 	if (skb_queue_len(&midev->tx_queue) =3D=3D MCTP_I2C_TX_WORK_LEN)  // nor=
mal stop
> 		netif_stop_queue(dev);
> 	spin_unlock_irqrestore(&midev->tx_queue.lock, flags);
>=20
> What looks like has happened here:
>=20
>  1) we have TX_WORK_LEN-1 packets queued
>  2) we release a flow, which queues the "marker" skb. the tx_queue now
>     has TX_WORK_LEN items
>  3) we queue another packet, ending up with TX_WORK_LEN+1 in the queue
>  4) the =3D=3D TX_WORK_LEN test fails, so we dont do a netif_stop_queue()
>=20
> A couple of potential fixes:
>=20
>  * We do the check and conditional netif_stop_queue() in (2)
>  * We change the check there to be `>=3D MCTP_I2C_TX_WORK_LEN`

My inclination would be to change the second comparison (the normal stop
condition) to=C2=A0

    /* -1 to allow space for an additional unlock_marker skb */
    if (skb_queue_len(&midev->tx_queue) >=3D MCTP_I2C_TX_WORK_LEN-1)

Cheers,
Matt


