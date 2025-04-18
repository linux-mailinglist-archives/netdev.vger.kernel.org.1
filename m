Return-Path: <netdev+bounces-184095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2D4A93513
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C091B60BEF
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E333526E15F;
	Fri, 18 Apr 2025 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="lUucERbH"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F7155389
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744967101; cv=none; b=Tn1ZTRYRFPYSfYjtGmup/hTwzK5Jn9eeopSdqqe68ghVKbDLl925p8MUrNxN0V/Z7ziwI21+3uH7eD5+B/xCrH6QoJO0vM2qlAA9cK4CRHZH62NRx2XEY+fcaWt+/bacm8h7Fpby+5VYdYJyFmAr7QrBOKOgs7ST0r1Ze84/Cck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744967101; c=relaxed/simple;
	bh=OugHiv/cUWmuoEDCaBP3ROhqBuxFUtX4MQKC74vpLVc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHvbCV9Kc+suTa1ERIKF6ja74txzWzJJTvYQNTOn3waivDNYM3aXzCyIxsv/qmoaAiFN7MLjq2nHYE2Yl47iMYcu7oWqHnh62SQiVaqFiSiGyF7hxMAYuW1RWffUoC022i7swa0Rbw1esmwnkoNKIAZH1mRz4UlXqwHGlTzoafc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=lUucERbH; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 4E07820868;
	Fri, 18 Apr 2025 11:04:56 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Pgxkf6qAI7K; Fri, 18 Apr 2025 11:04:55 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B45E920704;
	Fri, 18 Apr 2025 11:04:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B45E920704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1744967095;
	bh=Bcf/LO6zKyLY8ETV9A9TCNxiT4HYRSs0Ay0XHZg+GzM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=lUucERbHDawj4gj3X6GhqhheGiGbqzs8zPy7YupNm5/V5Nx26EcuSSXNlHwEmhzoN
	 U8HqefhPHGSzutEeSEOsugHAI1mPdhVGbWNpK4cgZQFaMI/TPDFFiqmBtp7MG5EV3c
	 DFvXxYeMONOV1LvZ64wL422GqWOEMI3VOmOpxllAnm+0jAoU+kdeLA54wsmimK7JBD
	 ABV5P+zd6/fs/x70L/ggZ2io8TWr0cKnlkfDEJ818pwqNb0GLI0PdCt9SEG+QYmbvI
	 Sz7Fa0VGhBsh1mlp4tAQrWBSS9vz1ItA1jxsddootOwVskbUKdS7dxZMJ6Gff9VxMX
	 8XuD2LRysvS5Q==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Apr 2025 11:04:55 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Apr
 2025 11:04:55 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id CF16A3182C91; Fri, 18 Apr 2025 11:04:54 +0200 (CEST)
Date: Fri, 18 Apr 2025 11:04:54 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Tobias Brunner <tobias@strongswan.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
	=?utf-8?B?4oCcRGF2aWQgUy4gTWlsbGVy4oCd?= <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <devel@linux-ipsec.org>
Subject: Re: [PATCH ipsec] xfrm: Fix UDP GRO handling for some corner cases
Message-ID: <aAIVth5vo7BLv99f@gauss3.secunet.de>
References: <c08a77a7-dac9-424d-8dcd-7207a1191e9b@strongswan.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c08a77a7-dac9-424d-8dcd-7207a1191e9b@strongswan.org>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Apr 15, 2025 at 01:13:18PM +0200, Tobias Brunner wrote:
> This fixes an issue that's caused if there is a mismatch between the data
> offset in the GRO header and the length fields in the regular sk_buff due
> to the pskb_pull()/skb_push() calls.  That's because the UDP GRO layer
> stripped off the UDP header via skb_gro_pull() already while the UDP
> header was explicitly not pulled/pushed in this function.
> 
> For example, an IKE packet that triggered this had len=data_len=1268 and
> the data_offset in the GRO header was 28 (IPv4 + UDP).  So pskb_pull()
> was called with an offset of 28-8=20, which reduced len to 1248 and via
> pskb_may_pull() and __pskb_pull_tail() it also set data_len to 1248.
> As the ESP offload module was not loaded, the function bailed out and
> called skb_push(), which restored len to 1268, however, data_len remained
> at 1248.
> 
> So while skb_headlen() was 0 before, it was now 20.  The latter caused a
> difference of 8 instead of 28 (or 0 if pskb_pull()/skb_push() was called
> with the complete GRO data_offset) in gro_try_pull_from_frag0() that
> triggered a call to gro_pull_from_frag0() that corrupted the packet.
> 
> This change uses a more GRO-like approach seen in other GRO receivers
> via skb_gro_header() to just read the actual data we are interested in
> and does not try to "restore" the UDP header at this point to call the
> existing function.  If the offload module is not loaded, it immediately
> bails out, otherwise, it only does a quick check to see if the packet
> is an IKE or keepalive packet instead of calling the existing function.
> 
> Fixes: 172bf009c18d ("xfrm: Support GRO for IPv4 ESP in UDP encapsulation")
> Fixes: 221ddb723d90 ("xfrm: Support GRO for IPv6 ESP in UDP encapsulation")
> Signed-off-by: Tobias Brunner <tobias@strongswan.org>

Applied, thanks Tobias!

