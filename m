Return-Path: <netdev+bounces-250015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDA8D22C93
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 08:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C54E1309620C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 07:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0422A31354C;
	Thu, 15 Jan 2026 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=horizon.auto header.i=@horizon.auto header.b="A3bXMdjd"
X-Original-To: netdev@vger.kernel.org
Received: from mailgw03.horizon.ai (mailgw03.horizon.ai [42.62.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1D018D658
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.62.85.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768461604; cv=none; b=UoDyNAi9tozZONlSa361mCmmt74L1w9qPxNWu6SLqny95UzkkPhOTkA0YNT8NWkNUbYCc+/fh2GgTRaEv5Ow9QQaoteOM0Az2GzB7MYx8yFvvBXmJj45VpuxBOWCcBYPB5Czd/BFlf+g2Go696CDl9v04WgsaukOjQYd1MNCDAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768461604; c=relaxed/simple;
	bh=qlcDgNGG2656bF5uh/RNu7eudkJOmvbjlqIJXlTkkWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=njdIqR9qbUpFcNxM4UbECOMXCFmQy/k2ZP6x41hAw5Vt/94mk6bSU1nHKYL3hEFz42lzyiES5+r6hAvFvi/Mn2d6XBv+MMJ0zJ6sDHfWbh7ECsQN96F12K/5qbPmxvhIo2sUkMZBi3Jcp8JH1lJD8Y65luLwV9ZSbc7SlGsQ6Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto; spf=pass smtp.mailfrom=horizon.auto; dkim=pass (1024-bit key) header.d=horizon.auto header.i=@horizon.auto header.b=A3bXMdjd; arc=none smtp.client-ip=42.62.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.auto
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horizon.auto
DKIM-Signature: v=1; a=rsa-sha256; d=horizon.auto; s=horizonauto; c=relaxed/simple;
	q=dns/txt; i=@horizon.auto; t=1768461591; x=2632375191;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qlcDgNGG2656bF5uh/RNu7eudkJOmvbjlqIJXlTkkWc=;
	b=A3bXMdjdeMr84nPHcqcDWBbxG7JYyYC0y6wlXnxcAjtwXu3eguLg7k4m8D/dt26o
	v+LO1QajvKcXlPTwK3bWNwfv9VwbWFHn6GRcm5bT2+tWmIwONnKTcdS3h+AW1gS8
	halF6Mr6wY9o/gvsSJ2qIUmsWBGK43o5gsa9OYIkX2o=;
X-AuditID: 0a0901b2-df5da70000001406-e3-69689516a14b
Received: from mailgw03.horizon.ai ( [10.9.15.111])
	by mailgw03.horizon.ai (Anti-spam for msg) with SMTP id FD.D2.05126.61598696; Thu, 15 Jan 2026 15:19:50 +0800 (HKT)
Received: from wangtao-VirtualBox.hobot.cc (10.9.0.252) by
 exchange002.hobot.cc (10.9.15.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.27;
 Thu, 15 Jan 2026 15:19:49 +0800
From: Tao Wang <tao03.wang@horizon.auto>
To: <kuba@kernel.org>
CC: <alexandre.torgue@foss.st.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<maxime.chevallier@bootlin.com>, <mcoquelin.stm32@gmail.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <rmk+kernel@armlinux.org.uk>,
	<tao03.wang@horizon.auto>
Subject: Re: Re: [PATCH net v2] net: stmmac: fix transmit queue timed out after resume
Date: Thu, 15 Jan 2026 15:19:38 +0800
Message-ID: <20260115071938.116336-1-tao03.wang@horizon.auto>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114191645.03ed8d67@kernel.org>
References: <20260114191645.03ed8d67@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exchange001.hobot.cc (10.9.15.110) To exchange002.hobot.cc
 (10.9.15.111)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42Lh4uTP1xWbmpFpsOuCjcXPl9MYLZY/2MFq
	Med8C4vFo/4TbBYXtvWxWixsW8JicXnXHDaLl6+3MVscWyBm8e30G0aLS/0TmRy4PS5fu8js
	MW9NtceWlTeZPJ72b2X32LSqk81j547PTB7v911l8/i8SS6AI4rLJiU1J7MstUjfLoEr4+Xv
	j6wFfRwVK1+1MTYw7mfrYuTgkBAwkbjTVdnFyMUhJLCSUWLuvQmsEM4LRonZPzYydjFycrAJ
	aEjcnXqNBcQWERCV2L5hHTtIEbPAKyaJ3hvTWUESwgJhEpdP/GADsVkEVCUunz7HDGLzCthK
	rH00H8yWEJCXuD7lANhQTgFDia03F4MNFRIwkHja18wCUS8ocXLmEzCbGai+eetsZghbQuLg
	ixfMEPUqEs0n57NDzJSTeL0B5ptYiRM/PCYwCs1CMmkWkkmzkExawMi8ilE4NzEzJ73cwFgv
	I78osyo/Ty8xcxMjOKYYN+1gXLLgo94hRiYOxkOMEhzMSiK8vL/TMoV4UxIrq1KL8uOLSnNS
	iw8xSnOwKInzaivGZQoJpCeWpGanphakFsFkmTg4pRqYTpQwn3hrUNw3/69f9OKrnDd13xq+
	O3v48Y3fH17yLctw1dx5tGz+9A8Xm2ULhcTjF2/qWLck78Dm6ZNf3FT8Y3X2g1OYz8bZKzfy
	cGXde5S1b+u5G7/cin3v3OfK1LgzrSThxsZn3RFXnnTqBGeu4jZnv2Gy/jTP23eBtXrJqi+c
	H+Y+SargNZnzkWfTuoL70p82le9j5Lq0M1N79Yx3IfsfHAnImb0xa8/MNEnHqg375wRMv7Sq
	hqnD8PvSRPP0dwphVZar7ocIpMfKdPd2v3rMnshRkPNofsJL382tcrY6Gz4Htgh/nnH3c792
	JcemBe3L5m2Y5vJkuqzjxzIpk1M79vcvP/j5IPdD9S52lrVKLMUZiYZazEXFiQA5irVgGAMA
	AA==

> > To solve the issue, set last_segment to false in stmmac_free_tx_buffer:
> > tx_q->tx_skbuff_dma[i].last_segment = false.  Do not use the last_segment
> >  default value and set last_segment to false in stmmac_tso_xmit. This
> > will prevent similar issues from occurring in the future.
> > 
> > Fixes: c2837423cb54 ("net: stmmac: Rework TX Coalesce logic")
> > 
> > changelog:
> > v1 -> v2:
> > 	- Modify commit message, del empty line, add fixed commit
> > 	 information.
> > 
> > Signed-off-by: Tao Wang <tao03.wang@horizon.auto>
> 
> When you repost to address Russell's feedback in the commit
> message please:
>  - follow the recommended format (changelog placement and no empty
>    lines between Fixes and SoB):
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#changes-requested
>  - do not send new version in reply to the old one, start a new thread

Understood, I will correct the commit message format and post the next
 version of the patch as a new thread.

Thanks
Tao Wang

