Return-Path: <netdev+bounces-192162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A575ABEB97
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 08:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C2D3A969A
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 06:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820DF22FAD3;
	Wed, 21 May 2025 06:00:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF29322FAC3;
	Wed, 21 May 2025 06:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747807230; cv=none; b=NI49xvm3vBp1Ur2ekvm3sTOecKFKuDkEjwmuxkr2+9pOgAcxFQ/mWv4KbrgOwELH2Q6vLYMflF5r7qiG107TdUPiTdxFVhDiyml0oNVrRSuuYIxi9EwlZsZzrm1JkhxWceyAJ7K2gKRLhTflLjM3XnwqhICXIzfYCAzyYSK9ons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747807230; c=relaxed/simple;
	bh=Puw9eObSSFZml7T71b0gkd42kuY0wzIYP+VmxijMKFc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B83SaFXhitpsBD226wrk//ZArlVJmqhQajE93JyYKgUmCffAkuDbo2zRdHxlEDzdiKqK46Md4hRo8XZW1ud3cEdT+LtgQ8Z0AqIo7u+4GQx1vppNG5GfGfRBNZP+hur6Te0z0qiqIju/r8YaC6qNN/qeValoY23/W+3hjAEHxes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D37BD205E3;
	Wed, 21 May 2025 08:00:20 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HQvOyeSAjrmO; Wed, 21 May 2025 08:00:18 +0200 (CEST)
Received: from EXCH-03.secunet.de (unknown [10.32.0.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5208920520;
	Wed, 21 May 2025 08:00:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5208920520
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-03.secunet.de
 (10.32.0.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 21 May
 2025 08:00:17 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 08:00:17 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 479C73183065; Wed, 21 May 2025 08:00:17 +0200 (CEST)
Date: Wed, 21 May 2025 08:00:17 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Zilin Guan <zilin@seu.edu.cn>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v2] xfrm: use kfree_sensitive() for SA secret zeroization
Message-ID: <aC1r8VfDy2/mlpwf@gauss3.secunet.de>
References: <20250514084839.118825-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514084839.118825-1-zilin@seu.edu.cn>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Wed, May 14, 2025 at 08:48:39AM +0000, Zilin Guan wrote:
> High-level copy_to_user_* APIs already redact SA secret fields when
> redaction is enabled, but the state teardown path still freed aead,
> aalg and ealg structs with plain kfree(), which does not clear memory
> before deallocation. This can leave SA keys and other confidential
> data in memory, risking exposure via post-free vulnerabilities.
> 
> Since this path is outside the packet fast path, the cost of zeroization
> is acceptable and prevents any residual key material. This patch
> replaces those kfree() calls unconditionally with kfree_sensitive(),
> which zeroizes the entire buffer before freeing.
> 
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Applied to ipsec-next, thanks!

