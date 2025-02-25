Return-Path: <netdev+bounces-169431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016FEA43DAF
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E64719C52D3
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A10267B13;
	Tue, 25 Feb 2025 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="dzuvxmSW"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6343267AF6
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482947; cv=none; b=MWyGNFEPSPnZkQt/M5huD2c5KKW8M4Et01EAWJ0LQgqUOr0114YHlVluLqAqdXus+8VRaUAz8p8Gk2LsLkmWTO4UrF9+dY+hCp7yZKkeOBZJltn23qwDDqHYZpdtOkIJFASLscOIZZHTWgLgeSIoOIrsMnGFu69ZQJQK4HNukMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482947; c=relaxed/simple;
	bh=/O72E8x47AjuUb9N1W7uk2UusT1tLYoOmvY/hZaUf1Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZk1UaLA8GN5t0NHHPldO92EYgOJgOhyL/Xs2jIf6d7KsAdBKYdXLm8kgOaVeyuSVdOt+gbmRJqkqAZt78fbb9FgFYdQGd7H4jLdFNWsJ20BFKelnLrcGTDWgk12qhNRNHbq7jQ3xVJz1Ds2gOUSVHwVUQHU1tZ2r4lQ3vLx2wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=dzuvxmSW; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 845A9206B1;
	Tue, 25 Feb 2025 12:28:57 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s1lqCvBe6J_O; Tue, 25 Feb 2025 12:28:57 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id F122A20538;
	Tue, 25 Feb 2025 12:28:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com F122A20538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1740482937;
	bh=mCEpv5ukVe85Aw1exQWi1vhdicmZTIMjWgBE6kWTnvE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=dzuvxmSWuqjPawCPIUlhOxsSZTpQYoeeT3qB1zNYMwFkDf4bfoDsWLN16AnoZRplI
	 uQMc/AFm1PKJl5muySIO0kunWi/iX14kcXf5lBOxlJ6PEXqyWDmyK/agAjAZZxcz0h
	 MzDucvaWJgr+cykv352wBrH2Ny9swR7oYLKH0Qd6HMbgOkoJg6DhJJmjtE0CbPPokN
	 XukwDDTtct49dgZ8hOATlDLhTH8mc1ijNh0evq3S7QlIfJ3SWHypfzuZ/80a87b85d
	 k5Cu5uQaPVe8QJmwPmRh6ieUG0oVB/V8SeGkm+XwwjnsVY0wHDAkABWPbdADPCtSEp
	 QhL5J6YtDwUIw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Feb 2025 12:28:56 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 12:28:56 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id C5CA03182F84; Tue, 25 Feb 2025 12:28:55 +0100 (CET)
Date: Tue, 25 Feb 2025 12:28:55 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Alexandre Cassen <acassen@corp.free.fr>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, Jakub Kicinski <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>
Subject: Re: [PATCH ipsec-rc] xfrm: fix tunnel mode TX datapath in packet
 offload mode
Message-ID: <Z72pd+rQw7BbiQEX@gauss3.secunet.de>
References: <dd53723e4ba4dcb4efa9f731b54ebfb9ca24e049.1739959873.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dd53723e4ba4dcb4efa9f731b54ebfb9ca24e049.1739959873.git.leon@kernel.org>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Feb 19, 2025 at 12:20:37PM +0200, Leon Romanovsky wrote:
> From: Alexandre Cassen <acassen@corp.free.fr>
> 
> Packets that match the output xfrm policy are delivered to the netstack.
> In IPsec packet mode for tunnel mode, the HW is responsible for building
> the hard header and outer IP header. In such a situation, the inner
> header may refer to a network that is not directly reachable by the host,
> resulting in a failed neighbor resolution. The packet is then dropped.
> xfrm policy defines the netdevice to use for xmit so we can send packets
> directly to it.
> 
> Makes direct xmit exclusive to tunnel mode, since some rules may apply
> in transport mode.
> 
> Fixes: f8a70afafc17 ("xfrm: add TX datapath support for IPsec packet offload mode")
> Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Applied, thanks a lot!

