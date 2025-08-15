Return-Path: <netdev+bounces-213932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7606FB275FA
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 04:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6881882A7B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CF42C2AA2;
	Fri, 15 Aug 2025 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aWZUaAz3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C2E2C324C;
	Fri, 15 Aug 2025 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225005; cv=none; b=oq2tmWzev/Lz1umEh2m5/DGX1Ll8RWtlHiBozdsUefX0gEjY0eJaS9um3vZeGJU3enyp8dFvot1nbG6v34GBsopxnyBVZYG9Za+dvQhfiIn2eGk56ajo0uoOeTBxVXczA3MiBVvpGt5FoEn6CIJS5glzT2T6yms/sswDpt4UdFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225005; c=relaxed/simple;
	bh=GDv4+wAT1ks+J+vspOAASVh0ExonKSQoHfTN7jW5xy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjIq1SyMsGhbJb6Pp7pKqecUszgVuqUZv/h5ySAXMjnII4JdA/Js4VUp1xnGb8e8xMs2UrKogfOEH2mUNlBnEXiHjtoNhkqqwXv/eSsynLOCkUS0aqyyIuy52eLZJ4LVxk1Y+zOuBR0iXh3nRUGmDmjcHtwfrpEI+kPz+TbRSk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aWZUaAz3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dQECTKg5LkbqZ7b78YnQWmhvTv3ov+tmdu8q56Toycc=; b=aWZUaAz3CLQtlTXMTRqyEush3K
	S2vAaT03P1T5iQWKcsv+sQjl1PUvYw61A0o0L4ifi4NwjtV+2E/Xgc97IXuFmaH/zuoE0yLfwPbVc
	iI3mcZjkLX5FwbaM86AAc68oNT3/OYpz6G6TESZ232GOw8LXApsrih0T5NTYWP2ghf/c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umkC8-004mHH-DX; Fri, 15 Aug 2025 04:29:28 +0200
Date: Fri, 15 Aug 2025 04:29:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <edf9be27-fdbf-44c9-8ce8-86ba25147f02@lunn.ch>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-4-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814073855.1060601-4-dong100@mucse.com>

> +#define MUCSE_MAILBOX_WORDS 14
> +#define MUCSE_FW_MAILBOX_WORDS MUCSE_MAILBOX_WORDS
> +#define FW_PF_SHM(mbx) ((mbx)->fw_pf_shm_base)
> +#define FW2PF_COUNTER(mbx) (FW_PF_SHM(mbx) + 0)
> +#define PF2FW_COUNTER(mbx) (FW_PF_SHM(mbx) + 4)
> +#define FW_PF_SHM_DATA(mbx) (FW_PF_SHM(mbx) + 8)

There seems to be quite a bit of obfuscation here. Why is both
MUCSE_MAILBOX_WORDS and MUCSE_FW_MAILBOX_WORDS needed?

Why not

#define FW2PF_COUNTER(mbx) (mbx->fw_pf_shm_base + 0)

Or even better

#define MBX_FW2PF_COUNTER	0
#define MBX_W2PF_COUNTER	4
#define MBX_FW_PF_SHM_DATA	8

static u32 mbx_rd32(struct mbx *mbx, int reg) {

       return readl(mbx->hw->hw_addr + reg);
}

	u32 val = mbx_rd32(mbx, MBX_FW2PF_COUNTER);

Look at what other drivers do. They are much more likely to define a
set of offset from the base address, and let the read/write helper do
the addition to the base.

	Andrew

