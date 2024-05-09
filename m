Return-Path: <netdev+bounces-95046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2E18C150E
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353C5B220B6
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 18:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0B17BAE4;
	Thu,  9 May 2024 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOMo2l91"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D0C3201
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715280695; cv=none; b=O29Codf2+Ml1KtCS5Ed+S9L6Vv0xUC2Ij83il3vMsw/e1tQ2hNKwAmUMpIyFRnCRIsqOCdIKsTmhc4Xd4vxU0Tca/0FMAavYk+4ad6s+bWSgz5TwniAdQlkl/Y39+FdcNQIsrNJyOwAN7RwPF+3mV7QZYuxb44xDhOAjkS7qEc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715280695; c=relaxed/simple;
	bh=ViziXu+8CHjGNUzoNaCgkej9c0znf+bQH8QWLoxc1hg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdKpY6wPIlTeCoL+Zp4HwbaES+M+bFMURL91e5nFIIjxtGHErCN5G0z+WLtPTxMr7UUNYE+AcEtaD/x8drsAX0AhVq4xlBXhkzipVh6Q84Xdjc2rPLnrwRYLYrifzM/bapveZqfLIgjoJxC7d093/9ZQfzrEsgwdEuhHDvzN5/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOMo2l91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DC7C116B1;
	Thu,  9 May 2024 18:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715280694;
	bh=ViziXu+8CHjGNUzoNaCgkej9c0znf+bQH8QWLoxc1hg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nOMo2l91xLhZJXocUC9h0PtJcrpXIvJRHZruv1hH1SYcBQt6AddI3DmoOyabDGaMH
	 gvuGZJMmqJtmYGN9mpM/mpzEtj9QoGljQ9Z+vG9l8pZ57P1fynwri6UE/ihARJJwS8
	 v+MD0o7/yAVa66WW9KKH6aJIms0aQNXYAicKfjSrHSu15j20haewWNd8d/2RUP9cGd
	 jKUSMe3YrjIy0E8r64X6+Jjcdh3fVxyogXckgXMdaRaZti5tUDjybbNNv5kkYfaNqh
	 n/nGTvohuZJ3n8YYVTHX2OhTI+kTqIL08433qAKyUm8Et/WeX8UNEJ9xPZ7D70w3WD
	 RVYTWVB/PlcJw==
Date: Thu, 9 May 2024 11:51:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, Erhard Furtner
 <erhard_f@mailbox.org>, "robh@kernel.org" <robh@kernel.org>,
 "elder@kernel.org" <elder@kernel.org>, "bhupesh.sharma@linaro.org"
 <bhupesh.sharma@linaro.org>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>
Subject: Re: [PATCH net] eth: sungem: remove .ndo_poll_controller to avoid
 deadlocks
Message-ID: <20240509115133.4fe77b2b@kernel.org>
In-Reply-To: <AM0PR0402MB3891AD9FB1D365D243AFFCF388E62@AM0PR0402MB3891.eurprd04.prod.outlook.com>
References: <20240508134504.3560956-1-kuba@kernel.org>
	<AM0PR0402MB3891AD9FB1D365D243AFFCF388E62@AM0PR0402MB3891.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 May 2024 11:10:46 +0000 Wei Fang wrote:
> Thanks for reminder.
> The fec driver should have the same issue, but I don't know much about netpoll,
> is ndo_poll_controller() no needed anymore? so it can be safely deleted from
> device driver?

If the driver uses NAPI for tx completions - implementing
ndo_poll_controller is not necessary.

