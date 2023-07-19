Return-Path: <netdev+bounces-18800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACF2758B0F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 03:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCF3281798
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 01:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB4917D0;
	Wed, 19 Jul 2023 01:54:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4700817C8
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 01:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAA9C433C9;
	Wed, 19 Jul 2023 01:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689731681;
	bh=8sE14OUhtH4JOmQnCC2xfg2OxZeca1/kLCPdJ09/ejU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ggTEOfCOol+PJCMwddN+Ggr/ke8bz3Gr5H/6HfDliS4zQXi3QgKRAtqtRl+XmmEPq
	 HsGpj0wMzoEoN1rfR2Z352UgOwRmM/mwM2QD2OPk7FJ0MOoBMzEFDv7cOvtBEpkRr/
	 Ar733fq1bL6FAEUfDqGvlRlh+msgjqMjzpKmeZhx0u0/ehaen9IDv0k0r0kcAFBMuV
	 CuMnDcsRnjsl6QRS+2x7ZI0eDLgom3NVVbOciRQ907WA+Prmkw39BIJI3RXHx/b5LD
	 s8CNKiFM2uaHXpB/SbxrrO5YWjunPkq8t3oE3N+nAnmNlRt6YAUGJF+83JbcdgLx0Z
	 V5wKeEb1iYg0w==
Date: Tue, 18 Jul 2023 18:54:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: linux-i3c@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Jeremy Kerr <jk@codeconstruct.com.au>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH net-next v2 3/3] mctp i3c: MCTP I3C driver
Message-ID: <20230718185439.05304395@kernel.org>
In-Reply-To: <20230717040638.1292536-4-matt@codeconstruct.com.au>
References: <20230717040638.1292536-1-matt@codeconstruct.com.au>
	<20230717040638.1292536-4-matt@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jul 2023 12:06:38 +0800 Matt Johnston wrote:
> +	dev_net_set(ndev, current->nsproxy->net_ns);

This is a bit odd, we may have missed similar code in earlier mctp
drivers. Are you actually making use of auto-assigning netns?

> +	mbus->tx_thread = kthread_create(mctp_i3c_tx_thread, mbus,
> +					 "%s/tx", ndev->name);
> +	if (IS_ERR(mbus->tx_thread)) {
> +		dev_warn(&ndev->dev, "Error creating thread: %pe\n",
> +			mbus->tx_thread);
> +		rc = PTR_ERR(mbus->tx_thread);
> +		mbus->tx_thread = NULL;
> +		goto err;
> +	}
> +	wake_up_process(mbus->tx_thread);

kthread_run()

