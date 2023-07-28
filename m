Return-Path: <netdev+bounces-22462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 589B07678F6
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 01:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABF1281C1C
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 23:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8071FB5F;
	Fri, 28 Jul 2023 23:26:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE9D525C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 23:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC87DC433C7;
	Fri, 28 Jul 2023 23:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690586800;
	bh=GZpQDatrHyHSHEx0WoW5JjEisl5j9lFK+dhjrkL1L9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VC5MBJlyYccS4f8TnsCQuggX6ya7usNUhkzlMKAg+yXOvsChK5rlQJnkrg33FF0FE
	 cNVQFrzSrfTnMhSBNEWMxt1iWK079GhdUKh+Q63Q3Ne2PwLjuIhnUcrf+MeAMOvaRr
	 0lSNDXc84PAN03FiFn9SxQ+MiV0klgkOKpfS8zSJvOfexfxSERneF0MCDO2OkfLwzs
	 0bbMfm0K/84ON7T/A7421MX4s4i40MvQh4ghRxI3wPVN7j3uXJSUzGbzyTIzSEL+xw
	 2D7G3SWmGuZFDVQcLgIfxBHnacO6aG9tezN+BSs0JCyQ+XQqnz6HkKxk8AiWraLTnc
	 ojjnPiZua2j5Q==
Date: Fri, 28 Jul 2023 16:26:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] net: korina: fix value check in korina_probe()
Message-ID: <20230728162639.1c08f645@kernel.org>
In-Reply-To: <20230726132943.20318-1-ruc_gongyuanjun@163.com>
References: <20230726132943.20318-1-ruc_gongyuanjun@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 21:29:43 +0800 Yuanjun Gong wrote:
>	clk = devm_clk_get_optional(&pdev->dev, "mdioclk");

Why not switch this to devm_clk_get_optional_enabled() instead?
Error already handled, makes the code shorter..

>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
>  	if (clk) {
> -		clk_prepare_enable(clk);
> +		rc = clk_prepare_enable(clk);
> +		if (rc)
> +			return rc;
-- 
pw-bot: cr

