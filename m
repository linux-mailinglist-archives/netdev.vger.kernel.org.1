Return-Path: <netdev+bounces-169526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F0CA445EF
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 17:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E423C166661
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 16:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F3618DB17;
	Tue, 25 Feb 2025 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePltYH5g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BCA18DB11;
	Tue, 25 Feb 2025 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500588; cv=none; b=mMLgB6+y3BtMhhQovy3fw2NkRlKa7B6SrzqTiUA50FQSz8i8tvZipV1Oebpj5z3fzWvxQDGhojSdzchs5HtiN91RC2koTtONPnf1YPOV2Cx2GzfSgqJClJTQtwzWwZtrzR+PvQibEG2Gs0IeoNZlv79ykqCz6jBPG0kNLfhCac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500588; c=relaxed/simple;
	bh=8ESREboIlA7s5wzo5W17sM0xvNvEQAcEtzyF1FX9XMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvZr4L+ylypJFab6/gFi8FulqwBXY91A4sQMiLVwwwmCJhY53hFjvUivq96U+6bE+vRhgYlYo5VT5blgtfsMdbw8b0X/aOn04JdT21YOsx1BZK1j6bCOf2c6ITn2bMwEg3dR56w3Tnp509+x0bUHf8vJ4kmyAZWr/igrckjn/1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePltYH5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0E7C4CEDD;
	Tue, 25 Feb 2025 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740500588;
	bh=8ESREboIlA7s5wzo5W17sM0xvNvEQAcEtzyF1FX9XMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ePltYH5gjyzqHRdOpO+thWExIGiwE4ZZBbpqBrw5S1mKLWIHCv7tWVnI49VhLFnv3
	 +Esm0KCHIqxDZ5lCOgi6tyHxlZWluxNvz5q65i7k1M0rTJwqlii+6AlAWSkUOKjnx0
	 OpSs+beS4P6H2CtWkGY0/tNAZTWL99bEx8A3D/Hg4nJOS8F3vlH5L6tLUnFNFCnRmk
	 iarenm8vRHgZXON4+cSH6nQU1iRm6HsuATpuWHrGB/i3yzsNZsw03SayvbyPyi3khS
	 ToF07HVXZY3VKE1RoRr1+hAUTRsUz98gWtYWLynkpNAjRlkEDyvswEEq4yu6i15QYC
	 GlTvVeWr5uv5g==
Date: Tue, 25 Feb 2025 08:23:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
 <chenhao418@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH v3 net-next 2/6] net: hibmcge: Add support for rx
 checksum offload
Message-ID: <20250225082306.524e8d6a@kernel.org>
In-Reply-To: <641ddf73-3497-433b-baf4-f7189384d19b@huawei.com>
References: <20250221115526.1082660-1-shaojijie@huawei.com>
	<20250221115526.1082660-3-shaojijie@huawei.com>
	<20250224190937.05b421d0@kernel.org>
	<641ddf73-3497-433b-baf4-f7189384d19b@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 17:00:45 +0800 Jijie Shao wrote:
> >> +			     NETIF_F_RXCSUM)  
> > I don't see you setting the checksum to anything other than NONE  
> 
> When receiving packets, MAC checks the checksum by default. This behavior cannot be disabled.
> If the checksum is incorrect, the MAC notifies the driver through the descriptor.
> 
> If checksum offload is enabled, the driver drops the packet.
> Otherwise, the driver set the checksum to NONE and sends the packet to the stack.

Dropping packets with bad csum is not correct.
Packets where device validated L4 csum should have csum set
to UNNECESSARY, most likely. Please read the comment in skbuff.h

