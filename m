Return-Path: <netdev+bounces-176647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A708A6B311
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 03:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E37519C0B8A
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 02:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B291E5B9B;
	Fri, 21 Mar 2025 02:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="e0AOYVyK"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B4B2C181;
	Fri, 21 Mar 2025 02:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742525197; cv=none; b=qmXAt5bx33iCFrrEvGEx0ZcAL89CPGMTiZgBapUKq9nMPBsXYnoqPI7IKCh1oNzCl8YtAl6f0HXTe4nxBBtRRvqPmnvbtE7GIyHQinC6dpP4AqW3RUKsjMgy5IR8afZjTo4ia+FKgv/IkbauTGAz0XbQJtxeXRDipGDyyciZYyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742525197; c=relaxed/simple;
	bh=5YFJ4sppFasaMWh5wwmJ+8tCZ1UMVZfTqS2zO2n+C7U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHhU5WP3xsx8aEj9p6LZpwPMoTgvkbZ7A4xWfaHtkj69o1v3062aYDnblRJZ5fZT0afNsMXeqEn+qpw/M/5RLQnhV00ziMZbhCZI+NZ4neQlr7ocpbexMtygeRoqegdrFYJSEBlLUWjb5RrGiz5a+9nmymVeeBqwT7T7DPgPNaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=e0AOYVyK; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 46ABC2080B;
	Fri, 21 Mar 2025 03:46:26 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s33V_ZTdOBfI; Fri, 21 Mar 2025 03:46:22 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id F258A206BC;
	Fri, 21 Mar 2025 03:46:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com F258A206BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1742525182;
	bh=B5J9/6SKPE0aNLeeNrIjy//GiyE0yPhks94Qv1Dw1fI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=e0AOYVyKCVjeFxSit+/Dta/0OqbwtDrLGopMxtLH86E9GsYj2L+4hg15zw5VrNHIx
	 T7QMhZdLb8IRHbg7XnAuL+Q1jy0PKLVfH/nPEPCw9h9CafWGXzIQtN4KWZvVH4BgVv
	 0A+41B92txTHi0NeT+fDsU1jabdQM35A22nSixxlpS1TZ6WikJRa3EYzToGiqpUuxf
	 e0g4vyz3J0RdAFfbP3xdn/WhUiLNexPvDhdJG/94TEd28UUEkw1SDzLfoBuUrKoQi+
	 nQg7pYJT71/1wSMsM7s9olVB2czTxYlo6r5U0ASD/cDw88YXW/4xmuXPS7OK5g5Oas
	 7TuQVL+HPi53A==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Mar 2025 03:46:21 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 03:46:21 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 99DDD3180202; Fri, 21 Mar 2025 03:46:20 +0100 (CET)
Date: Fri, 21 Mar 2025 03:46:20 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH net-next] xfrm: Remove unnecessary NULL check in
 xfrm_lookup_with_ifid()
Message-ID: <Z9zS/HL/5o+Yd7t3@gauss3.secunet.de>
References: <2eebea1e-5258-4bcb-9127-ca4d7c59e0e2@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2eebea1e-5258-4bcb-9127-ca4d7c59e0e2@stanley.mountain>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Mar 12, 2025 at 08:21:13PM +0300, Dan Carpenter wrote:
> This NULL check is unnecessary and can be removed.  It confuses
> Smatch static analysis tool because it makes Smatch think that
> xfrm_lookup_with_ifid() can return a mix of NULL pointers and errors so
> it creates a lot of false positives.  Remove it.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied, thanks a lot Dan!

