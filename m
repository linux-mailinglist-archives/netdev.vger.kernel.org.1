Return-Path: <netdev+bounces-182100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AA7A87D02
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB45174848
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B4D26563C;
	Mon, 14 Apr 2025 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="MQVQFc3d"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3031C25D906;
	Mon, 14 Apr 2025 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625190; cv=none; b=qMP5aTZoDv1fDojc7xGiRDHZW8gHrZ2j+t51kVjrjWSe37LwAj+rSPiG9CyiG8jTeqwx3puu9oMBSlkKfxH5hlQr+Yun5PWinlqrvCeWZRCJIc84dBNgo+aWbUFBNtxvHExeSsiNgPys1HlW+lPI+ZHjpmQkeAvfZVO8yle28mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625190; c=relaxed/simple;
	bh=ZNyWoh62au4hKwUORM15ujCiAze3gVDBcUmNw4dKBGs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQxxYAmOZuQifj3pHzgTjXkfLpu8uSweI4nRwFD0T+xukPn7mg++sJOr4/vMrbA165odRLizNsvWB05orwCmfI78xWYsoLyOGcewAsOAObV00q64tn2xDVlqVCkc37TLU20lojjucpeTpl5CGRkctamJHmb/PVVzuJ9g3cD1Qh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=MQVQFc3d; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1EE55201D3;
	Mon, 14 Apr 2025 11:56:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8E33jBSiOPq7; Mon, 14 Apr 2025 11:56:37 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 9917720189;
	Mon, 14 Apr 2025 11:56:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 9917720189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1744624597;
	bh=lLW1th0ueqLQqVlTjqxfT6KMgj1F2ySWK7RoNNfWyyA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=MQVQFc3doqvtbUKl1uCfUzj5zmkNRhpTXHU+LNRxYNv3Iw7DDxdjmAQgU6xdE09vS
	 /6VZ0lQf9WYljXDcTynNz5d8AuG3Pj4CeLse7WAXHx9ODi7M0KKuDTvn/gBhKZt5Qm
	 RXjHwXnn+MqW9IP+kdp7uQSrwauNUYzdySMIzeqrSNY9n84Bzy+E89v6KsA1dhi/o2
	 CYARUAkFGSNuBWdEYVhWz08SIgydoRcJWNf8P+U/dVx8fC3dhGa488hEH1LMH5wMLC
	 B11c7EaJJ10sv2bjWimpNwaZ/Hu5Zj0DovpoeHoJptjkZmiKUucE29BXgwtzlmHX85
	 CXn2tXmjRQxVQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Apr 2025 11:56:37 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 11:56:36 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 9D96F3182D8A; Mon, 14 Apr 2025 11:56:36 +0200 (CEST)
Date: Mon, 14 Apr 2025 11:56:36 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] xfrm: Remove unnecessary strscpy_pad() size
 arguments
Message-ID: <Z/zb1KBdnCgAgdYe@gauss3.secunet.de>
References: <20250320124450.32562-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320124450.32562-2-thorsten.blum@linux.dev>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Mar 20, 2025 at 01:44:51PM +0100, Thorsten Blum wrote:
> If the destination buffer has a fixed length, strscpy_pad()
> automatically determines its size using sizeof() when the argument is
> omitted. This makes the explicit sizeof() calls unnecessary - remove
> them.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied, thanks a lot!

