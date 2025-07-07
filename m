Return-Path: <netdev+bounces-204508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF34FAFAF0A
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB69E1AA034A
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 08:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74D5286D49;
	Mon,  7 Jul 2025 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="KCcn12zV"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC688199934
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751878633; cv=none; b=q4eyIzeBXquCbvrFk9RWxRbktBREY+M6FtmxVEtjB19CcFkOdf5apZ4EMPyWtTgh+MqAwwHSLrO0Toi6ih8n7fl6gdRCAtawLiPTLWI6A7e2Xs1nuU9Lpex999RChrMm8cYxhvH3srU4Vb6GstmTBFh2WxvUcHfZHH/8CFlIVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751878633; c=relaxed/simple;
	bh=/S/SBpIcZK/dP+ifoH/vLTNDLlgzkijFUkOoCkc7ews=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riErmtuBrE2lgdqAY097LWNC7q29PidN2TwsjhxPL8DfFLnC7Vl2lgqEFl/n7l4zHI6MhatBiHELKvnJzId9ksh+J67xgK38hqDAwFpptHGk6xeyuyE6PpKglMKpHXEGG+m3mOj6gaXRVJfngCdK+pLBYYk78KLtxSkcwbKOMNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=KCcn12zV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id BD5FC20189;
	Mon,  7 Jul 2025 10:57:01 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aoKzdQ4V2ESS; Mon,  7 Jul 2025 10:57:01 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 3C8EA207B0;
	Mon,  7 Jul 2025 10:57:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 3C8EA207B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1751878621;
	bh=bftrzlw8hEvW16PFn/qee4TnloIKFTcG7QZoa6kCz3Q=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=KCcn12zVDW69ZABYmgdrirFXlqlyMkJTyPlDUfiEcKuNI/V9LJ2rYOgFwNSArORPN
	 aEWUvwvQnD/jk1ew9Q9iHIfj7EYsBtlQ4igI+MGG7wXURJQxkzTcDv83eWBVf4tB7K
	 S+wj2DgY6D+YIY3LeSFCqcyy1qNMW7uIIP9OxIG2rVstZRypDQvfn8O9Al/m4okl/l
	 GCov1v8U0NBIyETr0fYyGZ3O2Qx20ob9/1BKl3Cw1ub5tlFbfsiFHAUPTy+YXl+rUN
	 Rn0PSeyfDuKjij6+E9lTLnE/4luHR1YJwVvri5Dx3VkYOVo8oeWRNeqYpuLUasVL/A
	 D6R4Sw1H4GqwA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 7 Jul
 2025 10:57:00 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 10:57:00 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 625DC3182BBE; Mon,  7 Jul 2025 10:57:00 +0200 (CEST)
Date: Mon, 7 Jul 2025 10:57:00 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jianbo Liu <jianbol@nvidia.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>, "Leon
 Romanovsky" <leonro@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>
Subject: Re: [PATCH net-next] xfrm: Skip redundant statistics update for
 crypto offload
Message-ID: <aGuL3BikwqfsOKb7@gauss3.secunet.de>
References: <20250703084528.9517-1-jianbol@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250703084528.9517-1-jianbol@nvidia.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Thu, Jul 03, 2025 at 11:45:27AM +0300, Jianbo Liu wrote:
> In the crypto offload path, every packet is still processed by the
> software stack. The state's statistics required for the expiration
> check are being updated in software.
> 
> However, the code also calls xfrm_dev_state_update_stats(), which
> triggers a query to the hardware device to fetch statistics. This
> hardware query is redundant and introduces unnecessary performance
> overhead.
> 
> Skip this call when it's crypto offload (not packet offload) to avoid
> the unnecessary hardware access, thereby improving performance.
> 
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Applied, thanks a lot Jianbo!

