Return-Path: <netdev+bounces-135824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBCB99F4BD
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 20:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C2C1F25BF1
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FE31F667F;
	Tue, 15 Oct 2024 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+8XGD9b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5E91B3951;
	Tue, 15 Oct 2024 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015316; cv=none; b=bJ6S4vwSXghYYBEy2opy4hOtxja3BCsxVmvE5FFd/1CPd9nfy1B7n2Pf2tXHFX6HwKJxeRapT2Fm4zNVlX0tCn9zf64/f9zkA34nCx51eBxJ1tk7Fcn2blu5ax9DL4Fm5jQOdatG+GXn5kq4+UIW1l4SrZuJa1LJlLEOZyOmS5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015316; c=relaxed/simple;
	bh=HA8CX7ZDuJjXJbrLWnHGcY5BUOIC9mBPvBR99OrS7hc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOCP5rC4xWhH1XuZSA5zEh5QoArBp6p6Jn9xZSt0BWBtQ6Y5tGQLMhsX9/TI4AB3xE6y+TMjoH3bYQEudYI5Zt6fXzc+pyCVhSlnhxLycO9Lbq+sb47/WRLpC1paqraIMRgiv+HM3/E7TDdEPTj4i+ao59W1TuOAiBGEoQbnoFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+8XGD9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5F0C4CEC6;
	Tue, 15 Oct 2024 18:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729015316;
	bh=HA8CX7ZDuJjXJbrLWnHGcY5BUOIC9mBPvBR99OrS7hc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z+8XGD9bWJyRfKlUy0OWXJvcLuBZEf35qUoyP/VOL6JnFJ8UuVqoEWETshnLfB+Ys
	 np00WqYiSHMVvGwKWNX/GtJfsfTOi4Ek/OpugEE+jJ3M7jCf2swW3y82r0rHd5CI1W
	 V5s32wgqCIvpKoJ8cyTp4Syb1KhPFtc6bStYVsjr+5AojkdHOpgJ1NnA/DfFSwfyhW
	 aPLTjgrKhqfV45AJTweZQOL27gr8OH8RFfJ2GsqBDai8P6dSD8Cn/k3PMiZcLYYh4C
	 zwHnBtmUQqaI2p5H+xlCLkFDnp/gytdBFUR+ztGZwXM9UV2L3i2EOaeqrT1SAA4DmU
	 McFQW8/+JkuSw==
Date: Tue, 15 Oct 2024 11:01:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Wang Hai <wanghai38@huawei.com>, bcm-kernel-feedback-list@broadcom.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 zhangxiaoxu5@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: systemport: fix potential memory leak in
 bcm_sysport_xmit()
Message-ID: <20241015110154.55c7442f@kernel.org>
In-Reply-To: <0c21ac6a-fda4-4924-9ad1-db1b549be418@broadcom.com>
References: <20241014145115.44977-1-wanghai38@huawei.com>
	<0c21ac6a-fda4-4924-9ad1-db1b549be418@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Oct 2024 09:59:27 -0700 Florian Fainelli wrote:
> > diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/e=
thernet/broadcom/bcmsysport.c
> > index c9faa8540859..0a68b526e4a8 100644
> > --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> > +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> > @@ -1359,6 +1359,7 @@ static netdev_tx_t bcm_sysport_xmit(struct sk_buf=
f *skb,
> >   		netif_err(priv, tx_err, dev, "DMA map failed at %p (len=3D%d)\n",
> >   			  skb->data, skb_len);
> >   		ret =3D NETDEV_TX_OK;
> > +		dev_kfree_skb_any(skb); =20
>=20
> Since we already have a private counter tracking DMA mapping errors, I=20
> would follow what the driver does elsewhere in the transmit path,=20
> especially what bcm_sysport_insert_tsb() does, and just use=20
> dev_consume_skb_any() here.

Are you saying that if the packet drop is accounted is some statistics
we should not inform drop monitor about it? =F0=9F=A4=94=EF=B8=8F=20
That wasn't my understanding of kfree_skb vs consume_skb..

