Return-Path: <netdev+bounces-117815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A778A94F711
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 21:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B0F280E29
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 19:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B90F1547D6;
	Mon, 12 Aug 2024 19:01:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518CC156
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489276; cv=none; b=OYiGKiIZZKw4uXe7Jy70X2/hU4EAjollxAho4HdAK3GpzBRk4T0GohP5maum2Te9yBsyJoOIAWVZXb/LFtomeOzikbmpQINJTNjYsrY3heb9oezn3PR6A6G2o7QaRQrVVI1rYj7NtxgrNLzphaWGvVNB2bH+6skTfiw9POAui0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489276; c=relaxed/simple;
	bh=YgLQLWYY3bURxJ7q+E6T2fBOEjtpH0eoF3GNmEW8pI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvBayZDut1DKs79glEGeQgKxS9fFjboTrSBfLYjkWSASBWqNP1oSjD7LzOffYTeNeeGecYfiN1r/dFybFWHGDmJrj4QPKgpHc08NANL+8HyTLKwDFT3pdtBb0kcGLeC7/v10vQx/CxQI+CAVvmVKTtTGrSoNF+hmNPFmhHHixGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sdaHp-0000DB-Mq; Mon, 12 Aug 2024 21:00:57 +0200
Date: Mon, 12 Aug 2024 21:00:57 +0200
From: Florian Westphal <fw@strlen.de>
To: wkx <13514081436@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	21210240012@m.fudan.edu.cn
Subject: Re: [BUG net] possible use after free bugs due to race condition
Message-ID: <20240812190057.GB21559@breakpoint.cc>
References: <49ee57f2.9a9d.191465ab362.Coremail.13514081436@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49ee57f2.9a9d.191465ab362.Coremail.13514081436@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

wkx <13514081436@163.com> wrote:
> 
> 
> Our team recently developed a vulnerability detection tool, and we have employed it to scan the Linux Kernel (version 6.9.6). After manual review, we found some potentially vulnerable code snippets, which may have use-after-free bugs due to race conditions. Therefore, we would appreciate your expert insight to confirm whether these vulnerabilities could indeed pose a risk to the system.
> 
> 1. /drivers/net/ethernet/broadcom/bcm63xx_enet.c
> 
> In bcm_enet_probe, &priv->mib_update_task is bounded with bcm_enet_update_mib_counters_defer. bcm_enet_isr_mac will be called to start the work.
> If we remove the driver which will call bcm_enet_remove to make a cleanup, there may be unfinished work.
> The possible sequence is as follows:
> CPU0                                             CPU1
>  
>                                       | bcm_enet_update_mib_counters_defer
> bcm_enet_remove        |

  unregister_netdev(dev);

... which should end up calling bcm_enet_stop() (via ops->ndo_stop in
__dev_close_many()).  This calls cancel_work_sync().

Did not look at the others.

