Return-Path: <netdev+bounces-142204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051C19BDCFC
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFF21F23DED
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380D11B7914;
	Wed,  6 Nov 2024 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF/7FHeX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10804190462;
	Wed,  6 Nov 2024 02:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859652; cv=none; b=KDsckUtuAV97hnVnGaP8KIDSi3cJKEHOv+zciHnSbgiPSrKRIT7Egz1LhdCcc7X8Sz92iEb/MbkSSZrY8oqcjijFapFUYaXHYE8V5cCxfWCFOEpH0ELnPT2Q9ebL5JU1S5rln17wEUeXseJ9ifqiWNXLxcHcPJQnwy2WJXcHrcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859652; c=relaxed/simple;
	bh=JQwZWqay0fD/RVvSUq/M7j+EthA8PgKPkA3/ngbOuF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFcXgWxLaexUVqwRkIjA/CS/SAMzCnemAb+z6Qn6vKj/5UbQGZqQ0Ayg6I3nMLgN27T9hdd/INEYyNelFM1O2TMSSbRyF+eRqHW90jrGX2ELtIZrdCv7rb1Y6yhMsmxTCNLHVE63LTPu05sosxQ98tN53uGDjeveLMlHb9ETeaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF/7FHeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF43C4CECF;
	Wed,  6 Nov 2024 02:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859651;
	bh=JQwZWqay0fD/RVvSUq/M7j+EthA8PgKPkA3/ngbOuF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KF/7FHeXI9aKLJBwKxLnNY6wq54eyINIDMfExomu8YLPUTv+YYLNMj7o7ajtMMxqn
	 PMAPN6PxUti4+6ybZwg4Fs4UgKJhld9T0g17Em38dezveqmQQC1+YymOrTSPJaX+h/
	 0Z7BMzz1yoEQaIrquQwaiGB/xs3U/thQ4yYD6TxPwtlCcaqls5rO3M2oPGJUUcrNQx
	 j5qTGOiUo5tVq58m1/pRnBRwS6aK1LVivF9YFqxx+VfieFeHytAEBXDtFkEo34v+V7
	 9zNNA75klioy00Xrw4vX5B2KCkHwgp8rbEGR/3LlJxtbww3I6jICHoMT4TDXU6MkvT
	 khDR9erObcLrg==
Date: Tue, 5 Nov 2024 18:20:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Richard
 Cochran <richardcochran@gmail.com>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/9] Support external snapshots on dwmac1000
Message-ID: <20241105182050.2839f1e7@kernel.org>
In-Reply-To: <20241104170251.2202270-1-maxime.chevallier@bootlin.com>
References: <20241104170251.2202270-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Nov 2024 18:02:40 +0100 Maxime Chevallier wrote:
>   net: stmmac: Only update the auto-discovered PTP clock features

Minor conflict in the context on this one, please respin.
-- 
pw-bot: cr

