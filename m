Return-Path: <netdev+bounces-164969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1EEA2FEE8
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 01:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571D01882D69
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 00:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45627635;
	Tue, 11 Feb 2025 00:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4Lq91EK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DEC5223
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 00:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232797; cv=none; b=N/F1pHfGBK25+m/cPPtnVM/DzBISd1WDB4uHXVHVszitYjj0LeWUJwycKXCZBqrY2w8kC2Jh1SUd4JlcRPhmsI8jSYOZQrpx87YLka1Ow5ANe7gGWtSf21/+Tvh8AP7skdMQ3R5WL9cADktaIMqY8/d76FRvf34D8g2fTj42ng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232797; c=relaxed/simple;
	bh=VUO/5kVNTPNLBmnlmfRqFC8g1zAK6+hLkMupNZ7qiuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8CN8XySCQuzSA+0shZ+MToHS4Yrp68uPoBDRxo+hOhwtyuaext4l22kbw9ny4yFz5WrfnY+jJdpRyrrCVoCwl53yU/zfWjUMGJG4q0t2bfdlAsmR4G3T4h+dNcukM/r53u43dkrXTdBSNg5tvNRoAGxg/xtnIrbKRSbbB7r18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4Lq91EK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A937C4CED1;
	Tue, 11 Feb 2025 00:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739232797;
	bh=VUO/5kVNTPNLBmnlmfRqFC8g1zAK6+hLkMupNZ7qiuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j4Lq91EKd4pYiC64vknEZj/BjtF8VqMW2iJSV3+m3hKLKsPRe+MXNzQ5Ql/7+M/Om
	 pxwrzK8V3EL5laIABA1Q6EoaF7UiQee2u+oUJ4AMDln2GTJGYadEAvTscxj24fgs3z
	 InOCatdk3APiamkecFvcwxTKp8jlCO1N1ss4fB3g/4gVW06kDHMt8DGBUhkBTXglkh
	 Lf0LTuFttmc6sDj7nPmzs625qGOFcSdY6WCbUS8qqqliXMYFM/vtxvcb3ok+YGzTj3
	 xoS6oOzvkjXrw4cCm2wMZbG/Sz3uRCIm/J1fp1LaWCSTW4qnAcifD1BMX5YAIOUpiq
	 1A29aQCqmMbFg==
Date: Mon, 10 Feb 2025 16:13:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <andrew+netdev@lunn.ch>, <edumazet@google.com>, <horms@kernel.org>,
 <pabeni@redhat.com>, <davem@davemloft.net>, <michael.chan@broadcom.com>,
 <tariqt@nvidia.com>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>, <jdamato@fastly.com>, <shayd@nvidia.com>,
 <akpm@linux-foundation.org>, <shayagr@amazon.com>,
 <kalesh-anakkur.purayil@broadcom.com>, David Arinzon <darinzon@amazon.com>
Subject: Re: [PATCH net-next v7 1/5] net: move ARFS rmap management to core
Message-ID: <20250210161315.51d9b2a9@kernel.org>
In-Reply-To: <760e3977-9f83-431b-b29b-f8ad1609b462@intel.com>
References: <20250204220622.156061-1-ahmed.zaki@intel.com>
	<20250204220622.156061-2-ahmed.zaki@intel.com>
	<20250206182941.12705a4d@kernel.org>
	<760e3977-9f83-431b-b29b-f8ad1609b462@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 08:04:43 -0700 Ahmed Zaki wrote:
> On 2025-02-06 7:29 p.m., Jakub Kicinski wrote:
> 
> > Speaking of which, why do the auto-removal in napi_disable()
> > rather than netif_napi_del() ? We don't reinstall on napi_enable()
> > and doing a disable() + enable() is fairly common during driver
> > reconfig.
> >   
> 
> The patch does not re-install the notifiers in napi_add either, they are 
> installed in set_irq() :
> 
> napi_add_config()  -> napi_set_irq()  -> napi_enable()
> 
> so napi_disable or napi_del seemed both OK to me.
> 
> However, I moved notifier auto-removal to npi_del() and did some testing 
> on ice but it seems the driver does not delete napi on "ip link down" 
> and that generates warnings on free_irq(). It only disables the napis.
> 
> So is this a bug? Do we need to ask drivers to disable __and__ delete 
> napis before freeing the IRQs?
> 
> If not, then we have to keep notifier aut-removal in napi_diasable().

If the driver releases the IRQ but keeps the NAPI instance I would have
expected it to call:

	napi_set_irq(napi, -1);

before freeing the IRQ. Otherwise the NAPI instance will "point" to 
a freed IRQ.

