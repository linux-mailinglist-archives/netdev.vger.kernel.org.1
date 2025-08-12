Return-Path: <netdev+bounces-212783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CD8B21F52
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A6F1AA496B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 07:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2885821C167;
	Tue, 12 Aug 2025 07:18:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737E81F37D3
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983085; cv=none; b=eKMoO8Z82uLdUdB+YBP1Zw6pEYvoim7v8So6ErvK53R4IbmJoeKebjZ+sdZzb+DK+Je7SmyK+lOtt9sG8/w/Po06D+VhbOtbAGDljzwtbc/msCz3RFtKjsSha9rmvc1EFuKLIJMhUhStuDnDcp5wtgt8BUqkFtmIqyScsLUCW/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983085; c=relaxed/simple;
	bh=ND7HxAFoOGRHa8yLuPWqJhRHg+jAcdrzr06JvaxbnXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4qFzT5nfHV1rfA48zMnp3xe1Fc6O0sk81VrGcK/ZeYrkXEge0c/MPO637Yc/WwBjazaa4o1W8LNQhKYFFvGFxT5aRnkgaF5ZCnPsleWGVu0iFVbP/N+2x3IDpGr2YsmnuVGH/wXc8cM1knc+I3dqGiaCCNBcAbcwDJx1QEST6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF78A443E5;
	Tue, 12 Aug 2025 07:17:58 +0000 (UTC)
Message-ID: <b497e639-7a5c-4bb5-8e5c-54c4aa79fd95@ghiti.fr>
Date: Tue, 12 Aug 2025 09:17:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: mctp: Fix bad kfree_skb in bind lookup test
To: Matt Johnston <matt@codeconstruct.com.au>,
 Jeremy Kerr <jk@codeconstruct.com.au>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
References: <20250812-fix-mctp-bind-test-v1-1-5e2128664eb3@codeconstruct.com.au>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250812-fix-mctp-bind-test-v1-1-5e2128664eb3@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeegjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpefhhfdutdevgeelgeegfeeltdduhfduledvteduhfegffffiefggfektefhjedujeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemjedtudgumeekugguugemsgekrgdtmedvjehfsgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemjedtudgumeekugguugemsgekrgdtmedvjehfsgdphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemjedtudgumeekugguugemsgekrgdtmedvjehfsggnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehmrghtthestghouggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthhtohepjhhksegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtp
 hhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Matt,

On 8/12/25 07:08, Matt Johnston wrote:
> The kunit test's skb_pkt is consumed by mctp_dst_input() so shouldn't be
> freed separately.
>
> Fixes: e6d8e7dbc5a3 ("net: mctp: Add bind lookup test")
> Reported-by: Alexandre Ghiti <alex@ghiti.fr>
> Closes: https://lore.kernel.org/all/734b02a3-1941-49df-a0da-ec14310d41e4@ghiti.fr/
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
> ---
>   net/mctp/test/route-test.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
> index fb6b46a952cb432163f6adb40bb395d658745efd..69a3ccfc6310cd78d4138f56609f1d83d4082bd1 100644
> --- a/net/mctp/test/route-test.c
> +++ b/net/mctp/test/route-test.c
> @@ -1586,7 +1586,6 @@ static void mctp_test_bind_lookup(struct kunit *test)
>   
>   cleanup:
>   	kfree_skb(skb_sock);
> -	kfree_skb(skb_pkt);
>   
>   	/* Drop all binds */
>   	for (size_t i = 0; i < ARRAY_SIZE(lookup_binds); i++)
>
> ---
> base-commit: 89886abd073489e26614e4d80fb8eb70d3938a0b
> change-id: 20250812-fix-mctp-bind-test-5a3582643ae4
>
> Best regards,


Can't see any warning/oops anymore this morning with this patch, thanks!

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks for the quick fix,

Alex


