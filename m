Return-Path: <netdev+bounces-139873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C689B4791
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 11:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C03B24246
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 10:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF13D205127;
	Tue, 29 Oct 2024 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHn7edXb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92244204F97;
	Tue, 29 Oct 2024 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199170; cv=none; b=pOyl7WgqQUh4wf8SQryQah7ymFL3Ri+0tL8vvy/nk6XjJ2cE0Abd8VVavLxZbAVH6dVhiFVIr476jZfovwYwUMruKss8/OquzV7uPOsN5Ib/5GwB9qDQZpJpyAWaSEhPySx+zsvYC2I6jPnhSuDdpkOOo8GEdLrN2ZO0Em0pX/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199170; c=relaxed/simple;
	bh=P+ZrNnYIOm5IhZQ6wC0LpnFdmcaGUFJy/rcxznr8wO0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dLn/xPBY41GneZsWAf3g0QoLdVJ63wRh4z8kuu6E8uvv4xqK+hiPOQYxidsR8NyA+gSDF+HeskrawZCjsRqcglBO1i3jror/MiGHSPyAlARu9U0cm6SEC9zU8pWmMKWE9QFYnmCMUC4Y2gemNl1z0H8yTPw0KvwCqbX6pPMID6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHn7edXb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730199169; x=1761735169;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=P+ZrNnYIOm5IhZQ6wC0LpnFdmcaGUFJy/rcxznr8wO0=;
  b=BHn7edXb7GIonuwdgsEMDWfbWyewMlSXVV4BpIW6VtWQiEM/cpdK5kqv
   sR0cOzdrisvSohO6vgQlWGHjR8wyC3hPQ7vXTGtz11Xca1A1DABY+XH/6
   TXGFHn1ShpvCDJArJxbH9WZH3NBIStaSaKqEuqCX0csLRhn825p6ySrAw
   CdPAB0EMKY30Y83bACdA88It2sbniohdK/MfK9TZ9Gb6hUMSPtA6MIMA3
   ZHqyECA89XRiGCz0sCbWW4tzlTieAELeN8Q505wcfBX351ur98upS4OJq
   efa2e8Syq8F/pTFECCw3WEJZelRIoCvCPOJTcTrDkd39dgrHDpzjhdANm
   Q==;
X-CSE-ConnectionGUID: GIbY8j1LSf2mQdcwqESNVg==
X-CSE-MsgGUID: UOMmxHF9QmKHe+oRiL0Dxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="33755560"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="33755560"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:52:48 -0700
X-CSE-ConnectionGUID: 4MIGiJTAS/S9Yipk6uZgdw==
X-CSE-MsgGUID: EpnAqbHoQz+J/WDtMe4wJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="86673783"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:52:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 29 Oct 2024 12:52:39 +0200 (EET)
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
cc: Jinjie Ruan <ruanjinjie@huawei.com>, chandrashekar.devegowda@intel.com, 
    chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com, 
    m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com, 
    loic.poulain@linaro.org, johannes@sipsolutions.net, andrew+netdev@lunn.ch, 
    davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
    pabeni@redhat.com, Netdev <netdev@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: wwan: t7xx: off-by-one error in
 t7xx_dpmaif_rx_buf_alloc()
In-Reply-To: <34589bdb-8cbd-455d-9e5b-a237d5c2cd0c@gmail.com>
Message-ID: <a628c035-641a-1c40-e4c8-c266e867718c@linux.intel.com>
References: <20241028080618.3540907-1-ruanjinjie@huawei.com> <34589bdb-8cbd-455d-9e5b-a237d5c2cd0c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 29 Oct 2024, Sergey Ryazanov wrote:

> Hello Jinjie,
> 
> On 28.10.2024 10:06, Jinjie Ruan wrote:
> > The error path in t7xx_dpmaif_rx_buf_alloc(), free and unmap the already
> > allocated and mapped skb in a loop, but the loop condition terminates when
> > the index reaches zero, which fails to free the first allocated skb at
> > index zero.
> > 
> > Check for >= 0 so that skb at index 0 is freed as well.
> 
> Nice catch! Still implementation needs some improvements, see below.
> 
> > 
> > Fixes: d642b012df70 ("net: wwan: t7xx: Add data path interface")
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > ---
> >   drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> > b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> > index 210d84c67ef9..f2298330e05b 100644
> > --- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> > +++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> > @@ -226,7 +226,7 @@ int t7xx_dpmaif_rx_buf_alloc(struct dpmaif_ctrl
> > *dpmaif_ctrl,
> >   	return 0;
> >     err_unmap_skbs:
> > -	while (--i > 0)
> > +	while (--i >= 0)
> >   		t7xx_unmap_bat_skb(dpmaif_ctrl->dev, bat_req->bat_skb, i);
> 
> The index variable declared as unsigned so changing the condition alone will
> cause the endless loop. Can you change the variable type to signed as well?

Isn't the usual pattern:

	while (i--)
		t7xx_unmap_bat_skb(dpmaif_ctrl->dev, bat_req->bat_skb, i);

?

-- 
 i.


