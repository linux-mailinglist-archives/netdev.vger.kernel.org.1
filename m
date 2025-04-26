Return-Path: <netdev+bounces-186192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B99A9D69F
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 02:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8089B1BC01D9
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9011DE883;
	Sat, 26 Apr 2025 00:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHn63+og"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF0F195FE8;
	Sat, 26 Apr 2025 00:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626625; cv=none; b=MfU1ATuLS5JND0Y0by1EIcV22RAlJEL86EW9rg3ZsPwDzUzMtEzGZZukadEEfivQcPp5lgXRXhJWDXRrQ8MMI+pRFQ3OFZ1t8Y1/IS9NVqTXS4rrvyOw54Ac+hjlEVh3q0pDviB0aFqO5011oF6HhnC1y8HJ32fuUQac6G+WvS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626625; c=relaxed/simple;
	bh=ywtyLVK4fpyc0Fmz0tjn1IWrxthLv2B52UL33CmcaCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqdCg0ZKNFVe74CByymgsKkYPHADN7urv9wMoeU7zM3B4RMW7Jx1EdqE3DiimdYSKBZeDJcalEWYkBRHOzh3i/tdcxnRTAiIMNNT5QlpH5Aqj4Ih+9Clcide/jdFZirEmo2KbQdttaxf/XoRcKJlWugXRTtKctv+4rX4QRr/kX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHn63+og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6822C4CEE4;
	Sat, 26 Apr 2025 00:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745626625;
	bh=ywtyLVK4fpyc0Fmz0tjn1IWrxthLv2B52UL33CmcaCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PHn63+ogcHZfcraFQIRVto/+wWjhMe0y0XvbNCWzQtyyhWrg3dYFkw5R/ybX0vIqC
	 Jx+cGVPBnKs1Q6ry3f4qtnvqcPDxgfRZdoVoPHeC4ALP4MNy7qDzKqk/Kz/RGnZQ9D
	 WmKd/YrNK8o5o2aQMQim2fM1Qnq6aPPjLWTeYVZ3c42wuFnt8N7bojXpHlhFPONAzU
	 It/SNFYXd1qn5qbwL+Lk/ZJZwUc+ZWGaIEpkmiFrXV39xl+D6oh0PW8W0gPfaW2FFK
	 9AP6aG/Nf/3/DhmR2VFhlg2FKulEk6FXVuXAWhX+hak0wO8AdmfCtIs6O18Bw9/CaP
	 u/DA38i50cW1A==
Date: Fri, 25 Apr 2025 17:17:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net 1/5] net: vertexcom: mse102x: Fix possible stuck of
 SPI interrupt
Message-ID: <20250425171703.0a6be54e@kernel.org>
In-Reply-To: <7e261db8-7b3a-4425-93ce-b7bac3746da1@gmx.net>
References: <20250423074553.8585-1-wahrenst@gmx.net>
	<20250423074553.8585-2-wahrenst@gmx.net>
	<20250424181828.5d38001f@kernel.org>
	<7e261db8-7b3a-4425-93ce-b7bac3746da1@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 09:35:04 +0200 Stefan Wahren wrote:
> Since the SPI implementation on the MSE102x MCU is in software, it 
> cannot reply to SPI commands in busy state. So drop the scaring 
> statistics about "invalid" command replies.
> 
> https://github.com/chargebyte/linux/commit/9f8a69e5c0d6c4482e89d7b86f72069b89a94547
> 
> Should I add it as a fix?

I see. I don't think we have to add that to the fixes series.
Worst case if people complain we can request a backport later.

