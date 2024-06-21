Return-Path: <netdev+bounces-105751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 072FE912A49
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 17:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE10E1F2827B
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115107BAF7;
	Fri, 21 Jun 2024 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwSAHeL4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3D8C122;
	Fri, 21 Jun 2024 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718984087; cv=none; b=h583fQruxD1JtCpEO3+YGWMzgF+lYDE3dWGT+m6RAw6IT2cXklzhxPCeJ/sN0VaPFu4tzrwkDOexVY1m1Aercjk6KfXokyKL/zg93SzeUEsMynjEBJ7u4UtnAE4EGFQEhXOmS70oCn1nlHcGGMba2OpPE31y//+kJJ8EIhk/ZMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718984087; c=relaxed/simple;
	bh=nANfWiueD/Itjl7rh+lhEuAxaRNh1SANMp+CpGnt9nU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkGa/09028Y/G6y4VHXPEI4SbptijU2yBprfvo+iNUd6HDZ+WDDb7eA1T+YKjIS4ICk6a4eP4kF1xmYPI/KFhp1IljvvMSaa/m50RRcuVBl4m+ikLHCef7PSvq40U23LKGsZA4SSOZveJTQOuChMboZ4kIvXZoWnRvuOhM0DjJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwSAHeL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270A9C4DDF1;
	Fri, 21 Jun 2024 15:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718984086;
	bh=nANfWiueD/Itjl7rh+lhEuAxaRNh1SANMp+CpGnt9nU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dwSAHeL4okZuG/sNbIPMk+LMxabfp3vZSQDKSYhh/1l3uVHvZ256sxGqlsDDzH/ys
	 AweZPMAPO/yMUa84lmTNM6K8RW7VxLmDHIfEtHyl8NikzHF/Id5dyLuIt1fE9Vaehm
	 ClwVeEMxcGU3PfP4LbcWaZj5/TjtAfuMDTL2uKelZ2NdVpYUkFXLb5GQZkQO0hd6vs
	 2vr9o8BVe7qGQopQedvQAwRNd/tcdSeSrvYcqR6eaBlvGZQ+pQp7bvZnDIfuj0GIoK
	 Nbj7J6uNPRro5QRNCM9073CTIZz2idQt4ri9QYJUM0MEnkauW4LwMQThWO8lbWd80x
	 tVUhR8bN6kxVg==
Date: Fri, 21 Jun 2024 08:34:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Cc: Huai-Yuan Liu <qq810974084@gmail.com>, "jes@trained-monkey.org"
 <jes@trained-monkey.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "linux-hippi@sunsite.dk" <linux-hippi@sunsite.dk>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>
Subject: Re: [PATCH V2] hippi: fix possible buffer overflow caused by bad
 DMA value in rr_start_xmit()
Message-ID: <20240621083445.34d805d2@kernel.org>
In-Reply-To: <BY3PR18MB47379D136DE21EDB8C1741CAC6C92@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240620122311.424811-1-qq810974084@gmail.com>
	<BY3PR18MB47379D136DE21EDB8C1741CAC6C92@BY3PR18MB4737.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 05:11:41 +0000 Sunil Kovvuri Goutham wrote:
> >+	if (index >= TX_RING_ENTRIES) {
> >+		netdev_err(dev, "invalid index value %02x\n", index);  
> 
> Much better would be to use netif_msg_tx_err which can be
> enabled/disabled instead of dumping on console, which would be
> annoying if there are many errors.

Doesn't it require ethtool to be changed tho? This driver doesn't have
any ethtool ops AFAICT. I'd go for netdev_err_once().

But more importantly, I think you should stop the queue before
returning BUSY.

