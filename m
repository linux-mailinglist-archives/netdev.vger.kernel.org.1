Return-Path: <netdev+bounces-139790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3C99B4195
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 05:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBD61F231C5
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 04:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DC81DD543;
	Tue, 29 Oct 2024 04:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="fO+CRw0Q"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8263318858E
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 04:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730176380; cv=none; b=VxZSxTTd0hTJ/MbULLxiDMWevBL0atEfPac97BfRB6UmMWNe9Mg3ClTqp7Ign62fMnJdDWIMqqs1i7s0e9+IarbgF86aDkXihegtMzbAhXCKfeRuh8A6g0waHg3RIIISyi5Q8smtAtats045KFZ5BXcOurH+H21UzPK+420AkGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730176380; c=relaxed/simple;
	bh=poOTCUivigF50jqbopcJXDEKN8X5s7ZuPuEzNsjLh3M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ehPBr6jpx0g0K0LkEONbv0zZQrgQVfT/GADUCSUd20Lbl0JSL50hU6VhWg6lH1ZvcMtXAclXkNzmDyfVc2mfgszbQQIshFVycyv0DbBWu5kdIOA+n+BW75C5nmXY+3xd3xBOGzo9hpMZC3ZmWwDBRzKy6BgxxKepYN10NTlTgNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=fO+CRw0Q; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730176376;
	bh=CkbOaBpG+n/JS/De+uKLd80f3DjSVfzcm2VivVzM4Dk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fO+CRw0Qtn1jDH5rCvhc3qJOwSQRzsstuv5qlhAPvIKBlgNsOBgWxLpyle70CPtOI
	 ek3DZrbS0numpPfaumDvGah76+KMohX/7IUHlng6MnvLFelLXwcaxuIOqHjbzyglJf
	 jxAyxXgisgzIByjIJgrOMw9E7oE0BCVP9fmowXXIghcmBo0Ta3w/99v8E6PhkOKLd/
	 rl/lg1SwhrNwEtdDdc9XF2IUXtZCEu6ytUPWOcmfGNRIPAclpj2pgfK4cmigUf3md4
	 e2p1mn5dsyZg3nMOyV+WBhXUW+K5qIbsF8TTMCJtQApzRbBPKFzaqGR7AmFttsoMrt
	 6zRFGNysgAfLQ==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5A66E6A1AA;
	Tue, 29 Oct 2024 12:32:53 +0800 (AWST)
Message-ID: <0123d308bb8577e7ccb5d99c504cec389ba8fe15.camel@codeconstruct.com.au>
Subject: Re: [PATCH net 1/2] net: ethernet: ftgmac100: prevent use after
 free on unregister when using NCSI
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Joel Stanley
 <joel@jms.id.au>, Jacky Chou <jacky_chou@aspeedtech.com>, Jacob Keller
 <jacob.e.keller@intel.com>,  netdev@vger.kernel.org
Date: Tue, 29 Oct 2024 12:32:53 +0800
In-Reply-To: <fe5630d4-1502-45eb-a6fb-6b5bc33506a9@lunn.ch>
References: <20241028-ftgmac-fixes-v1-0-b334a507be6c@codeconstruct.com.au>
	 <20241028-ftgmac-fixes-v1-1-b334a507be6c@codeconstruct.com.au>
	 <fe5630d4-1502-45eb-a6fb-6b5bc33506a9@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Andrew,

> ftgmac100_remove() should be a mirror of ftgmac100_probe() which does
> not register the ncsi device....

Sure it does:

    static int ftgmac100_probe(struct platform_device *pdev)
    {

        /* ... */

        if (np && of_get_property(np, "use-ncsi", NULL)) {
                if (!IS_ENABLED(CONFIG_NET_NCSI)) {
                        dev_err(&pdev->dev, "NCSI stack not enabled\n");
                        err =3D -EINVAL;
                        goto err_phy_connect;
                }

                dev_info(&pdev->dev, "Using NCSI interface\n");
                priv->use_ncsi =3D true;
 =3D>             priv->ndev =3D ncsi_register_dev(netdev, ftgmac100_ncsi_h=
andler);
                if (!priv->ndev) {
                        err =3D -EINVAL;
                        goto err_phy_connect;
                }
- so we're symmetrical in that regard.

On unbind, ->remove is called before ->ndo_stop, as the latter is
invoked through the unregister_netdev():

    [   62.869014] Call trace:=20
    [   62.869079]  unwind_backtrace from show_stack+0x18/0x1c
    [   62.869386]  show_stack from dump_stack_lvl+0x68/0x74
    [   62.869575]  dump_stack_lvl from print_report+0x130/0x4d8
    [   62.869771]  print_report from kasan_report+0xa8/0xe8
    [   62.869956]  kasan_report from detach_if_pending+0x49c/0x518
    [   62.870156]  detach_if_pending from timer_delete+0xc4/0x124
    [   62.870350]  timer_delete from work_grab_pending+0x8c/0x8e4
    [   62.870543]  work_grab_pending from __cancel_work+0x84/0x25c
    [   62.870744]  __cancel_work from __cancel_work_sync+0x1c/0x130
    [   62.870930]  __cancel_work_sync from phy_stop+0x118/0x268
    [   62.871114]  phy_stop from ftgmac100_stop+0x160/0x2dc
    [   62.871289]  ftgmac100_stop from __dev_close_many+0x1c8/0x300
    [   62.871481]  __dev_close_many from dev_close_many+0x238/0x578
    [   62.871674]  dev_close_many from unregister_netdevice_many_notify+0x=
460/0x2368
    [   62.871900]  unregister_netdevice_many_notify from unregister_netdev=
ice_queue+0x27c/0x32c
    [   62.872144]  unregister_netdevice_queue from unregister_netdev+0x20/=
0x28
    [   62.872348]  unregister_netdev from ftgmac100_remove+0x8c/0x24c
    [   62.872542]  ftgmac100_remove from platform_remove+0x84/0xa4
    [   62.872730]  platform_remove from device_release_driver_internal+0x4=
28/0x5e4
    [   62.872952]  device_release_driver_internal from unbind_store+0xb8/0=
x108
    [   62.873163]  unbind_store from kernfs_fop_write_iter+0x3a4/0x590
    [   62.873364]  kernfs_fop_write_iter from vfs_write+0x65c/0xec8
    [   62.873567]  vfs_write from ksys_write+0xec/0x1d4
    [   62.873735]  ksys_write from ret_fast_syscall+0x0/0x54

As the ordering in ftgmac100_remove() is:


        if (priv->ndev)
                ncsi_unregister_dev(priv->ndev);
        unregister_netdev(netdev);

which, is (I assume intentionally) symmetric with the _probe, which
does:

                priv->ndev =3D ncsi_register_dev(netdev, ftgmac100_ncsi_han=
dler);

        /* ... */

        register_netdev(netdev)

So we would either re-order _remove() to do the ncsi_unregister() after
the unregister_netdev(), breaking the symmetry there, or we check for a
valid ncsi device in ->ndo_stop. I have chosen the latter for this
change.

Cheers,


Jeremy

