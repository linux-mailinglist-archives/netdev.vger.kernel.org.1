Return-Path: <netdev+bounces-160310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E473A193AE
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 15:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFC316C48B
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579F1211A3D;
	Wed, 22 Jan 2025 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="UD0mCDRe"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF222116FF
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555423; cv=none; b=uR9TjHQQv7Sgw+fWzQGnrjm+exiiasUbJd1L4nh+P6KcnzGxM33i3LahnAYY2pck3EA1hdL19Eo/AiVbvFvu8qvXF3CxTmCoiMKvN8+4D964NKYRty+maiQXO4Z0LH1Yyf3DzA0u/gPEYBoCdQDSE4soBDoGhcv0ERUk6HFek44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555423; c=relaxed/simple;
	bh=IAdHMYY3cvATLhzLd5yyApbk/zE28a5JZUTjGlYRz6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wl92sghnzBPcWsIqy/ADjo3P0+FV4gkTGPate+B0SMsXjx1z0YkXu8R/x9+GALvaSQkOOFwpB9OxqT+ygciUPPDWAYS9Q0xaVElihVHgFRzG0Rxq9HLEfzbxaaVSiU++9Tji/aPQSpjX4bIQb/TbgD0HJwkFbh2DPsa1i7RFUds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=UD0mCDRe; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tabXC-003ZV0-Og; Wed, 22 Jan 2025 15:16:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=qUqJs8Bi8Lz2jv+AqBEM77qqbdqIBiLuqlLpGBMbdDQ=; b=UD0mCDRe9JX4t3fapni9H4r3N7
	ZedTBL659K2NFgu5WmLv9Bfr0zPyVIAWs5DAwVEeheLCeoaK4LWBjugTm3zQxY/EEvyIVQwH04xGB
	Ab9OGQjdh8CXwS+xJwTeG0yO/sN8zyO0cKioxyh05+vbvwNJl8Hp3otkHICBinEYDQai4lk5O94vF
	yGiOHwA21NOnaaocwWCGS2ArITr8KJPxBZwqhutgA5aLGRHULnFwt3yMSIsF+AOZqN19kMx1+T3hq
	Z7nV9hm+RcKM68quW1qXn11uHDMRTbSujaGzmgQM8AtJ/tChSJEMQlnDmPEU2MbfeU+0uK2mFFoLM
	jtPB5U4g==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tabXB-0004aB-WD; Wed, 22 Jan 2025 15:16:46 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tabWw-00BlkM-Ln; Wed, 22 Jan 2025 15:16:30 +0100
Message-ID: <282fbb3c-97d6-4835-86d3-97eb14ff74ea@rbox.co>
Date: Wed, 22 Jan 2025 15:16:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/6] vsock: Transport reassignment and error
 handling issues
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>,
 Andy King <acking@vmware.com>, netdev@vger.kernel.org
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
 <kxipc432xhur74ygdjw3ybcmg7amg6mnt2k4op3d4cb5d3com6@jsv3jzic5nrw>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <kxipc432xhur74ygdjw3ybcmg7amg6mnt2k4op3d4cb5d3com6@jsv3jzic5nrw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/25 12:45, Stefano Garzarella wrote:
> On Tue, Jan 21, 2025 at 03:44:01PM +0100, Michal Luczaj wrote:
>> Series deals with two issues:
>> - socket reference count imbalance due to an unforgiving transport release
>>  (triggered by transport reassignment);
>> - unintentional API feature, a failing connect() making the socket
>>  impossible to use for any subsequent connect() attempts.
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> Changes in v2:
>> - Introduce vsock_connect_fd(), simplify the tests, stick to SOCK_STREAM,
>>  collect Reviewed-by (Stefano)
>> - Link to v1: https://lore.kernel.org/r/20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co
> 
> Thanks for sorting out my comments, I've reviewed it all and got it
> running, it seems to be going well!

Great! I was worried that I might have oversimplified the UAF selftest
(won't trigger the splat if second transport == NULL), so please let me
know if it starts acting strangely (quietly passes the test on an unpatched
system), and for what combination of enabled transports.

Thanks,
Michal


