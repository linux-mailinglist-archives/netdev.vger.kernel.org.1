Return-Path: <netdev+bounces-212136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D38FEB1E4A5
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 10:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2ACC7B07FF
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 08:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC2C252900;
	Fri,  8 Aug 2025 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="AT7r8TR5"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D0614885D
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642911; cv=none; b=Kx3mpW24MBvCFjpfNeBVlrD4lpIJecgHIpr/G8vkb0r2G+p6KdLpZVuSuhDwY5JbaDr2A/RMFrE3f5oyy6sq/i2nK5DCsYHAGe6lz6XP6F77h/YPQwj9esvE+CQGjtW3fJxRpw9PuO6ShKxWVfebhWyaNaqP4+Czk6cN/9WbdVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642911; c=relaxed/simple;
	bh=Mz0PghuF+ANqwt35/zGA/RG4c1NSUB2AcWBXisKGPnc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBiv1V0svnT2Bye9w+Etm0Gq65iV6fjtxsjq0HvVgeYR8smXBB+8iGGO1btf26Lukmhyj2bGsP5/AFK4mAyh3gU3F+HXX8GBFWYnQsGe+KitZ64sCPQvzT0rVViVWz6NoZUCvepwM00EMCo/rjdqn1JmSKyx2mGQXbVcKZDWyCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=AT7r8TR5; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 48E5B2087C;
	Fri,  8 Aug 2025 10:48:20 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0PL2q1hjn-jx; Fri,  8 Aug 2025 10:48:19 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id BFEAC2074F;
	Fri,  8 Aug 2025 10:48:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com BFEAC2074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1754642899;
	bh=W3qeK3IdHEozwDR7qfatYbHn4cCK1rEMt8rTSIcHzXI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=AT7r8TR5HQvKDymQ6i1w0KTUU+1lmX0wNEQoXONBV7NDSWqknIeY7DjpOxS6FApZ2
	 1s1NL+jr8h70UhiGIRUCRjrAA1oYzA8pWi3ABZBAU31NkHeSHENbGKWKH2/N5Df1Hf
	 0h7Pa9a7c2Dm1eAMXWqHkZ/JP4q6KGgfhrDzcHo7qJBddr/t6ckxQOY0CW9BoiVdSt
	 ZYVVQHMsyL8OpnW95AaNq6p6yN9zVcTRaZVkRxngTZGEXDx519EavpQ3LtNZaSa+bi
	 6qswwZzyIOTF/zqEwfelfeMN2QeOoCzReucCZWPfNEC3k+vkN+qJn8qH2Djoe1X4x7
	 rBSlzIWqsvVzg==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 8 Aug
 2025 10:48:19 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id D9AE63182B18; Fri,  8 Aug 2025 10:48:18 +0200 (CEST)
Date: Fri, 8 Aug 2025 10:48:18 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "David S. Miller"
	<davem@davemloft.net>
Subject: Re: [PATCH ipsec v2 0/3] xfrm: some fixes for GSO with SW crypto
Message-ID: <aJW50reSmi-VBNCC@gauss3.secunet.de>
References: <cover.1754297051.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1754297051.git.sd@queasysnail.net>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

On Mon, Aug 04, 2025 at 11:26:24AM +0200, Sabrina Dubroca wrote:
> This series fixes a few issues with GSO. Some recent patches made the
> incorrect assumption that GSO is only used by offload. The first two
> patches in this series restore the old behavior.
> 
> The final patch is in the UDP GSO code, but fixes an issue with IPsec
> that is currently masked by the lack of GSO for SW crypto. With GSO,
> VXLAN over IPsec doesn't get checksummed.
> 
> v2: only revert the unwanted changes from commit
> d53dda291bbd ("xfrm: Remove unneeded device check from validate_xmit_xfrm")
> 
> Sabrina Dubroca (3):
>   xfrm: restore GSO for SW crypto
>   xfrm: bring back device check in validate_xmit_xfrm
>   udp: also consider secpath when evaluating ipsec use for checksumming

Series applied, thanks Sabrina!

