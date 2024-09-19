Return-Path: <netdev+bounces-128941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E2097C854
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 13:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89AF81C25073
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7F619C54A;
	Thu, 19 Sep 2024 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY1Qt6y1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F64E198E93;
	Thu, 19 Sep 2024 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726744231; cv=none; b=fsHmgNorpi0dRyb/OEtQTyuj3QWHzz5p4jmNZvKGJEmfo3wklJX6BNIMSdbc3m1gt4lXt4a6aRKa04WvZUT9VHzwmX5cpQLLCAdZ8s5xRBYntSqKZ6KHlHxrvD2nAZH4+wKtNs6wmmKBi6tg+TdSMpQwZQHGQiA5wFkrcMIGHqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726744231; c=relaxed/simple;
	bh=lUS6jub6SYk7XF6Pwfa5cPwXHtlVrvZ/xDHRvc92Si8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GqFIEAqDAyMuNlUm3VwckgccKn2kSbg//uRqgjFmB+NXT5BPCmVB3a4kLD3MXOhDojz/NImfMFFwLLT5wIDZG2GdDu3VVi5nMSirn5qfvU/SfDTqxRCYyKauDRohIZnQMnwKpi8r5dUEx7tIvShmi9dX8NmkSzx7Q6DSm4lDD/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY1Qt6y1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDACC4CEC4;
	Thu, 19 Sep 2024 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726744230;
	bh=lUS6jub6SYk7XF6Pwfa5cPwXHtlVrvZ/xDHRvc92Si8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LY1Qt6y1Tqwq5U0NvAyl3Ww1I4tw8uJIuSqSQRmgdspVBTMfdcreAXsjNWnhJTAzl
	 eY6rqazeVGqdWMTP/5RHlH3MVNXWCFehiST2xS9ENQ59DIJ3uVMahIFBe0/bEg/dwH
	 QQOUN6oGpYPL4Qrl8hkrZqISe2mMrgxPivo6VqZvBLgA/EchoDNjnIeHawzLZXfnEH
	 dBaWOZypCnG8dtNa3Ii+lnTFu8SoCN0EQ/8a6yf9mkFzjMLebBkpdG7BJrK/uWiaJG
	 A7JtCcl98gpypsjAAMWuQ3cwRd2Cx6XJP3MvAVwA56U5qOPmi8rRo9BE3iKvXTN3L9
	 kFu3v+iaHzTgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEC03809A80;
	Thu, 19 Sep 2024 11:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: xilinx: axienet: Fix packet counting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172674423252.1512499.8344281762968477248.git-patchwork-notify@kernel.org>
Date: Thu, 19 Sep 2024 11:10:32 +0000
References: <20240913145156.2283067-1-sean.anderson@linux.dev>
In-Reply-To: <20240913145156.2283067-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: radhey.shyam.pandey@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 daniel@iogearbox.net, michal.simek@amd.com, Suraj.Gupta2@amd.com,
 harini.katakam@amd.com, andy.chiu@sifive.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Sep 2024 10:51:56 -0400 you wrote:
> axienet_free_tx_chain returns the number of DMA descriptors it's
> handled. However, axienet_tx_poll treats the return as the number of
> packets. When scatter-gather SKBs are enabled, a single packet may use
> multiple DMA descriptors, which causes incorrect packet counts. Fix this
> by explicitly keepting track of the number of packets processed as
> separate from the DMA descriptors.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: xilinx: axienet: Fix packet counting
    https://git.kernel.org/netdev/net/c/5a6caa2cfabb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



