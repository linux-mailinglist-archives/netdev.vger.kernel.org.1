Return-Path: <netdev+bounces-179770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90921A7E7E8
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4781777F0
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF88E2153D5;
	Mon,  7 Apr 2025 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDeNdcJH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859082AE66;
	Mon,  7 Apr 2025 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744045891; cv=none; b=pS64U0m1MPwe3gneRMq640S7DU2FzJPasQKMEaunzMfY4Q1rHZgLTnRevSo5UCbFY0WgUGFI0+VG3/ps2slr2Tnt29V/p8u418ZMxHjE5RxbfVTyJhqleVm0kw8vL5k43Xx0qeFyKDtDnPvcV+QdqLbUnJc/vVMtSyGP4jbh3tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744045891; c=relaxed/simple;
	bh=riuZ6x2rGa6sl3Sz9lE+F9EUmDPIZ6lCGXSnz7vsiWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPxcZD+PT3h1+0srTeZa2VtNp04m+3lSbMqGPZxqQ2hPjRzztUHgasrauTeesUSaUJjPJuFzo+hYkUWPTu4wpAgrB7AQde4yWVpYkTY3qKMu9LCB/kFSAUKK2VBza3RN4R4EltQoq2dDcqHFIFVhWevu7FpmvNNC1sZMm9kVu4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDeNdcJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB3EC4CEDD;
	Mon,  7 Apr 2025 17:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744045891;
	bh=riuZ6x2rGa6sl3Sz9lE+F9EUmDPIZ6lCGXSnz7vsiWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pDeNdcJHjdS4bw93/5bpU2eyOVdXjkKunpCRxL0dL46P94/MieUS9zCS3+sLYUWJV
	 zwJAECL/dZmIezOTqTiTKoHrlLJmjPKu+R/+KLD7MS+M8K6/0/+CKNKM054+1yhNBm
	 Uw0UcgjQ18iAkrQQA0vsMxusUUnNsefpmIXn84nwXlcO0D6EVFlwJ7jHKOz01j51ZS
	 oiFAlzbxU4QDYpC5qb201Sv3CGCOemvQVdIC73D6E/cncULM6VZtlgCjN2Ki6Bk36Y
	 +/xi0dqI9X6JvUGPVHH1G/WCCYVMQvaCR9hKgXzijLScHp3CT7DcGg47sp1aWjPxFl
	 4qhSh8/k6/kAA==
Date: Mon, 7 Apr 2025 10:11:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
 <chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 6/7] net: hibmcge: fix not restore rx pause mac
 addr after reset issue
Message-ID: <20250407101129.48048623@kernel.org>
In-Reply-To: <b3aafd85-cb58-4046-88df-2b3566e2497d@huawei.com>
References: <20250403135311.545633-1-shaojijie@huawei.com>
	<20250403135311.545633-7-shaojijie@huawei.com>
	<20250404075804.42ccf6f0@kernel.org>
	<b3aafd85-cb58-4046-88df-2b3566e2497d@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2025 09:06:42 +0800 Jijie Shao wrote:
> on 2025/4/4 22:58, Jakub Kicinski wrote:
> > On Thu, 3 Apr 2025 21:53:10 +0800 Jijie Shao wrote:  
> >> In normal cases, the driver must ensure that the value
> >> of rx pause mac addr is the same as the MAC address of
> >> the network port. This ensures that the driver can
> >> receive pause frames whose destination address is
> >> the MAC address of the network port.  
> > I thought "in normal cases" pause frames use 01:80:C2:00:00:01
> > as the destination address!?  
> 
> No, the address set in .ndo_set_mac_address() is used.
> 01:80:C2:00:00:01 is supported by default. No additional configuration is required.

Are you talking about source or destination?
How does the sender learn the receiver's address? Via LLDP?
You need to explain all this much better in the commit message.
It is not "normal" for a switched Ethernet network.

