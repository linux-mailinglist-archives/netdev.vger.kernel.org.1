Return-Path: <netdev+bounces-182099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5A1A87CAC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322FC3A8B39
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0F616C850;
	Mon, 14 Apr 2025 10:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44891522F
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744624860; cv=none; b=RRNXAAJo9/dpbMPwwBCYCQgVOeHxp+QJpuoKm8FfBv/7tiMVyIyir1s+G45Js/O2aDoyeHw89bFv3Nkgzx8V/sMQ7kxMsK3uZzGxyhi7/KHhvHL/JLY+5oO5xddLN1MUmTP0ua8/qh/NVM+C3nAo/Pp900QAR4fzbUszhhXDCLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744624860; c=relaxed/simple;
	bh=Si1OcbhSKoKSU0plRUgX9qMclV48LCcsBcug7yJk6DU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUg3YQ5zrXohaEDeBtV6CkRJFFNf+0zeQszXbI6nDkUVKiHxhE+K88z5FP1K0nyLFHj55qWad5m8s41lIbk3JQGeZbYqY40YXZGM/IEZmYGu0fVz36wPUQKIns2PNUM66wviawkhAtPJZKMHcDvSvVthfIYl88TCsDET8V5HUzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 39E3120612;
	Mon, 14 Apr 2025 12:00:55 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fw1g3yHnL6Yu; Mon, 14 Apr 2025 12:00:54 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B8212201C7;
	Mon, 14 Apr 2025 12:00:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B8212201C7
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 14 Apr
 2025 12:00:54 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 12:00:54 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 1B6953182D8A; Mon, 14 Apr 2025 12:00:54 +0200 (CEST)
Date: Mon, 14 Apr 2025 12:00:54 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec 0/2] fix some leaks in espintcp
Message-ID: <Z/zc1oM8bWsQB+m9@gauss3.secunet.de>
References: <cover.1744206087.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1744206087.git.sd@queasysnail.net>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Wed, Apr 09, 2025 at 03:59:55PM +0200, Sabrina Dubroca wrote:
> kmemleak spotted a few leaks that have been here since the beginning.
> 
> Sabrina Dubroca (2):
>   espintcp: fix skb leaks
>   espintcp: remove encap socket caching to avoid reference leak

Series applied, thanks Sabrina!

