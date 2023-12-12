Return-Path: <netdev+bounces-56601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA99180F958
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088541C20D49
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE17664136;
	Tue, 12 Dec 2023 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOoZS9ex"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9356765A9E
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 21:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14121C433C8;
	Tue, 12 Dec 2023 21:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702416476;
	bh=50sFTmtihceq90x+RGmpNwjBeohVEhFnNKDvNFakuCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cOoZS9exiz+criCcYP/hy4pMCbxjVobEJPVZikpnLMiLu9+LcCWBzWPi4aTIDBXgc
	 dSuTTDVXilOpc5MPdrnDKrT0+u8QHqj4d8uWVNQl/c9XwjMxtkutTKKLnnXZfAdDTU
	 bo2A7ur6ykv92o4V0uNuKAc5gyTi759qgkJdhJHffc1XdriqXESYHJ3Objhp2J6TY6
	 3EJpTob+C4Y/YOylS/2shzOmc24laqtXsrKFepI8VhrfUJUK5f8QyxnW4eCkidKqKe
	 lGmNtWKTd18InnWc19jXiik5Xtzg/VJQS+EPeW6TSrKPdzqD7qAwd+UcNiOJrHYofr
	 UdTCg89/aKllg==
Date: Tue, 12 Dec 2023 13:27:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kunwu Chan
 <kunwu.chan@hotmail.com>
Subject: Re: [PATCH] net: dsa: vsc73xx: Add null pointer check to
 vsc73xx_gpio_probe
Message-ID: <20231212132755.261ee49d@kernel.org>
In-Reply-To: <20231211024549.231417-1-chentao@kylinos.cn>
References: <20231211024549.231417-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 10:45:49 +0800 Kunwu Chan wrote:
>  	vsc->gc.label = devm_kasprintf(vsc->dev, GFP_KERNEL, "VSC%04x",
>  				       vsc->chipid);
> +	if (!vsc->gc.label) {
> +		dev_err(vsc->dev, "Fail to allocate memory\n");
> +		return -ENOMEM;
> +	}

Don't add error prints on memory allocations.
There will be an OOM splat in the logs.
-- 
pw-bot: cr

