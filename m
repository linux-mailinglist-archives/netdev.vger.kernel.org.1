Return-Path: <netdev+bounces-120361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 082589590B2
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8C61C208EE
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E8E1C8FD7;
	Tue, 20 Aug 2024 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtxvZB3M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F81C8FD4
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724194234; cv=none; b=H14W3TXTKZWzPZ1iQ5Eokwt+1D7C4NQFoMb+fJ+wJt1iKMMMQJppm5koPkAzC2pEjBAG1QKQ4grDpSdUEoVvl0V/JciEuoQIcfX2LZWLMbmTWFVKqZZZyMlRuS9cc74xq/yGW0edXOnSE+kwIC1Qrq6xhBIXp7iGuyReJMxWZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724194234; c=relaxed/simple;
	bh=XpvPdnUwZFHnszo7SdZAbWPN07qUpA+Mhj+bDbu2mJw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rWZEUMjd0ZglalY5pqqYAgrw/PFmVgYw/5kgu7nIOFQhNNLLze7LIIR7/hFwc5wpp5gLFIrSRPlDP7iA9Otrvn22xkopO2nT1yXfH36khIvlOrAln5mGwrC6ob5VYhz9eDg2j4R1tXN48qldVU55ggKrgLlt282uoVdsIZ2TRIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtxvZB3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04526C4AF15;
	Tue, 20 Aug 2024 22:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724194234;
	bh=XpvPdnUwZFHnszo7SdZAbWPN07qUpA+Mhj+bDbu2mJw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dtxvZB3MuGMje9aSsceCxCsZV/EF3pgYTOcf9I5QIVkgmjpsa4n4AC/F+/O7/c/1p
	 J8ZCXjWWmGtJnV0eW4VHn8ROz5R1NMqPWE0hhyne1T8VdNMizYxWBT7vrSRfa5U7Pd
	 JHFwUJvDN0LUBEKAmtwU90c5ACsiJoBlPqsv2PIyLj7HhwfhBMyKCGlJv8BydL6SsX
	 Eltms7BdFUEt8TpWnlj1O71JiVsFs1lbKLi+UqM//g2952znINT1W5DvTSxvjun8Tm
	 mK6NrCAQqRLDznhRhbyD+Mes0suUq/kNJBy9D42QBRFTx/zdQkKkSm9Tw0L7sXePEf
	 eBkm2w6NO8//Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE5DA3804CAE;
	Tue, 20 Aug 2024 22:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] igb: cope with large MAX_SKB_FRAGS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172419423251.1259589.15378788577530176816.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 22:50:32 +0000
References: <20240816152034.1453285-1-vinschen@redhat.com>
In-Reply-To: <20240816152034.1453285-1-vinschen@redhat.com>
To: Corinna Vinschen <vinschen@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, maciej.fijalkowski@intel.com,
 anthony.l.nguyen@intel.com, jtluka@redhat.com, jhladky@redhat.com,
 sd@queasysnail.net, himasekharx.reddy.pucha@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Aug 2024 17:20:34 +0200 you wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> Sabrina reports that the igb driver does not cope well with large
> MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> corruption on TX.
> 
> An easy reproducer is to run ssh to connect to the machine.  With
> MAX_SKB_FRAGS=17 it works, with MAX_SKB_FRAGS=45 it fails.  This has
> been reported originally in
> https://bugzilla.redhat.com/show_bug.cgi?id=2265320
> 
> [...]

Here is the summary with links:
  - [net,v2] igb: cope with large MAX_SKB_FRAGS
    https://git.kernel.org/netdev/net/c/8aba27c4a502

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



