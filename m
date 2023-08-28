Return-Path: <netdev+bounces-31112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A22378B87F
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 21:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69EF280EBE
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 19:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F35D1400E;
	Mon, 28 Aug 2023 19:38:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468F313AF8
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 19:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49159C433C7;
	Mon, 28 Aug 2023 19:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693251531;
	bh=L5/usRoTQkY0NoAqxhYEBU7YzcbiHRwN9h1q1YuPI1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uRgmWe/4dw2beWc7pVFw+c0KIFlChQsMUW35wruhyGQV9RuOdaP4I0p2mU8f32xUs
	 s5Jn586gfW8hgaxlFyQfbCrYxuBKLJNCCb6Nf/7bGEqNZtyfUBeR3l6sa/zfH0bUoi
	 A1XafmFpvV86FksFScJqp63/tL/4OGBNEu5j0+m/9pQYxAyn0DeRF5qUZ9NkXBnw3r
	 mkZc99nSlPdIh0lTih1NV5o0GSO3epl8KgwQ6OaxRxileksbOrrsxaUsK5d+pDdaOV
	 TNjp+8Z6qS6e9Ev/xHfzcRuQuKcP3nICPAIVvy+doX1Cnn2DbbMbGwd3UPWVQwMVno
	 8iSS5pKYfHpmg==
Date: Mon, 28 Aug 2023 12:38:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexandra Diupina <adiupina@astralinux.ru>, Zhao Qiang
 <qiang.zhao@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v3] fsl_ucc_hdlc: process the result of hold_open()
Message-ID: <20230828123849.69466f0a@kernel.org>
In-Reply-To: <20230828121235.13953-1-adiupina@astralinux.ru>
References: <896acfac-fadb-016b-20ff-a06e18edb4d9@csgroup.eu>
	<20230828121235.13953-1-adiupina@astralinux.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Aug 2023 15:12:35 +0300 Alexandra Diupina wrote:
> Process the result of hold_open() and return it from
> uhdlc_open() in case of an error
> It is necessary to pass the error code up the control flow,
> similar to a possible error in request_irq()
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
> v3: Fix the commits tree
> v2: Remove the 'rc' variable (stores the return value of the 
> hdlc_open()) as Christophe Leroy <christophe.leroy@csgroup.eu> suggested
>  drivers/net/wan/fsl_ucc_hdlc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index 47c2ad7a3e42..4164abea7725 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -731,7 +731,7 @@ static int uhdlc_open(struct net_device *dev)
>  		napi_enable(&priv->napi);
>  		netdev_reset_queue(dev);
>  		netif_start_queue(dev);
> -		hdlc_open(dev);
> +		return hdlc_open(dev);

Don't you have to undo all the things done prior to hdlc_open()?

Before you post v4 please make sure that you've read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review

Zhao, please review the next version.
-- 
pw-bot: cr

