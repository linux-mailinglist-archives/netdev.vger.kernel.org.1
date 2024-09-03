Return-Path: <netdev+bounces-124649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC5D96A598
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29221C20DF5
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ACA18E349;
	Tue,  3 Sep 2024 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRzlZCWg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03E018800D;
	Tue,  3 Sep 2024 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725385449; cv=none; b=cvUENEuey11Lzq4J3/0VD5oyQj+RdqiXD1AuWkCAhd0vSDauOAUiuz4EI3/YL9756oXJX344j1ProVt2TqoajgNrGPfqp8tOP4JVGqlqkjCdl5pS5M3IewnAOMvmO+AhNwa1GOtyGaSY//uXuLkYl+8kwg8OReCcrVZXqodrByM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725385449; c=relaxed/simple;
	bh=qrP3YTxX3+DN3eWRaOX1qPEv6ZRZUhQPaqdDJixhcJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asf7nHAw9b5/sLU2mJoFy99tsZbHHmjUs814ENVGFXoTlB3goZXs8Oz74Vdd50Iku/dQrBLQUh74wq/m3y/dUWF9kufY6dMwfMFU9Q2aL9w0AT52f6Zb6GsnRpZ2peASskaoxQdTml1aMoOkLeg3pE+xpRSFB/zoCH6ZXi5l8VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRzlZCWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A477C4CEC4;
	Tue,  3 Sep 2024 17:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725385449;
	bh=qrP3YTxX3+DN3eWRaOX1qPEv6ZRZUhQPaqdDJixhcJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qRzlZCWguuPgqiyUR2kymuWejuNfzgRY6zhMKDVFwhbx5IE8MQDaMGbUS8h6VOkgO
	 Z0pl043FFZlDggRsG2rUBJrR+yJx4iiGKVdXSxpYBE5ygb4IoNV52fM4KO1PO1okhR
	 ckSFCFU1AvcbhFjF/csPu18dvhcZVdjAb5CcEKvBp0/LZ3WOqRqtyk82Ri8gRMga28
	 Ak3Ulr2ZZYoe862mjxqJX5TO8pZJJONb9wOy0LD0DSSHwHDbGCNPFrJlfTjIFxfbyw
	 EjzrbCMV7yh6MI9CK8hNXwxzungXdXwFBsyKQwtwbICDC4dIUfc0b2NtwvjK4jbpBX
	 YrkNKRrZr/Qcg==
Date: Tue, 3 Sep 2024 10:44:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
 <jdamato@fastly.com>, <horms@kernel.org>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 net-next 03/11] net: hibmcge: Add mdio and hardware
 configuration supported in this module
Message-ID: <20240903104407.31a7cde6@kernel.org>
In-Reply-To: <0341f08c-fe8b-4f9c-961e-9b773d67d7bf@huawei.com>
References: <20240830121604.2250904-1-shaojijie@huawei.com>
	<20240830121604.2250904-4-shaojijie@huawei.com>
	<0ff20687-74de-4e63-90f4-57cf06795990@redhat.com>
	<0341f08c-fe8b-4f9c-961e-9b773d67d7bf@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Sep 2024 20:13:58 +0800 Jijie Shao wrote:
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 struct hbg_priv *priv =3D netdev_priv(netdev);
> >> +=C2=A0=C2=A0=C2=A0 struct phy_device *phydev =3D priv->mac.phydev; =20
> >
> > Minor nit: please respect the reverse x-mas tree order =20
>=20
> Here, I need to get the *priv first, so I'm not following the reverse x-m=
as tree order here.
> I respect the reverse x-mas tree order everywhere else.

In this case you should move the init into the body of the function.

