Return-Path: <netdev+bounces-92329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B176A8B6A74
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 08:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D769E1C2011E
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 06:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C08114AAD;
	Tue, 30 Apr 2024 06:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="zoPrOxQ2"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33956FB1
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714458020; cv=none; b=l+Mc0mozfp0Q7m6hfyj4js22ic/l2QOh0cdviWCls17LcjXMo7MogYdH8t8YMlxmt2qa25yqr2aykdIkzOrZLHvdajXzGTBzkIYgq15T4xKHq3CRl2NwKbyiPaz/SkFtHKvkzLCsMEJjiptv3+IvW0sUKt04FCG7kHLvnE0aFV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714458020; c=relaxed/simple;
	bh=voXRMEd9HTP5///3iog9Lsf9aMTQZ10qjYFWfSiM8WM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAxrxQNjNN00PPtL7opEwTQLJZIlwuCPSJfm/DQesNG5yhqfE01QU3jLlkDEgNJKoJ2B3x7JXXa7ufaYawooeZU4S5ze9H0IxfNTO+47gDFwUpiG2pdSTzkulZFrpHdSkab+DmN3ktm/SbnAquMNtdB+lyNLQ199H7CK6RXW/Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=zoPrOxQ2; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3DBAC207BB;
	Tue, 30 Apr 2024 08:20:16 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id znmoKJcz2CHV; Tue, 30 Apr 2024 08:20:15 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id ACC30207B2;
	Tue, 30 Apr 2024 08:20:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com ACC30207B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714458015;
	bh=5k08DUPW8lDaLo1pLbi1kvrsmzn2uU/aq5iDGdLqQwc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=zoPrOxQ2PaR6O7nqO0nlpYBI1/uo0e3myQb30njZmIgnI8XvPbMy2EYFy+LPcYWt1
	 AX+si1reBJO+mqlGo+FwO1DM9RBIn+stYRiOItx6J/3GbPWTeNc+0paMFQCUpxWAxo
	 pmGhvvU5HuZPazr43j9RSMPt/L/fRSVsocXgFPS8ACD+6kbXe3Ps+ZKX5qVGwu6WOx
	 wGhaL33O9bsB2FUGRSt7LXiSk5hfy8k/OTgHQJbeBJuH5WZkCmuKxaphB4IfSiEa4G
	 W/MiLTB/3dU14N+lo3yKaZ6w5pvRBQmWHXxjGgUXRqbqBolhy7LKJ16miJ9AP+sbDV
	 fDrFPdxs7FnXA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 9F97680004A;
	Tue, 30 Apr 2024 08:20:15 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Apr 2024 08:20:15 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Apr
 2024 08:20:14 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id ACEEA3182A0F; Tue, 30 Apr 2024 08:20:14 +0200 (CEST)
Date: Tue, 30 Apr 2024 08:20:14 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony@phenome.org>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec] xfrm: Correct spelling mistake in xfrm.h comment
Message-ID: <ZjCNnmUJV0yGnuMZ@gauss3.secunet.de>
References: <Zit-sTZoYp_JnQfd@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zit-sTZoYp_JnQfd@Antony2201.local>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Apr 26, 2024 at 12:15:13PM +0200, Antony Antony wrote:
> From: Antony Antony <antony.antony@secunet.com>
> 
> A spelling error was found in the comment section of
> include/uapi/linux/xfrm.h. Since this header file is copied to many
> userspace programs and undergoes Debian spellcheck, it's preferable to
> fix it in upstream rather than downstream having exceptions.
> 
> This commit fixes the spelling mistake.
> 
> Fixes: df71837d5024 ("[LSM-IPSec]: Security association restriction.")
> Signed-off-by: Antony Antony <antony.antony@secunet.com>

Applied, thanks Antony!

