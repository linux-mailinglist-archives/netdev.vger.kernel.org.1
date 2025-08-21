Return-Path: <netdev+bounces-215477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BDCB2EBB6
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 05:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31B11CC0EB6
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE53D2D8385;
	Thu, 21 Aug 2025 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JYx7OvjF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648252D4B61;
	Thu, 21 Aug 2025 03:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755746042; cv=none; b=GOuq74cmXfeiGLxeNDNWaoAI7QBY5Z/NW7pdczJjBNXhmKx/5M4dqGYYG5lfq8lcm6dWYxcKrc3Z6WsOG86VSpGZMnyN4UYr0pJ4+IkTlHYvB0crGYdqTmN8/QuCklLe0l94YNZFYnQIXSIj5dZH5x9S0R/ixfuzjbCG8A/ySQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755746042; c=relaxed/simple;
	bh=MTcHuynE5PUr7EVO99ETDpM1IwKidYRI9iQsYJYZS0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOi28OTy9AqnjVnCZyfUAGCE+zdjUJzeCI9+64+wJfCu325Zl4lV2jt14Ix0VR+fpP6w2R9hpBvluBhmxST4wk9aa8STv4TOZs0cBmFEcFukYCXrdujNM4W1pN0l5mxVd19AnrfgwhEkQdn8zE3tJLN/6KocM4WuZIZP4bzMiiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JYx7OvjF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qRKfKX+lSUvxl7Yxqj+FLTrSyKxoI3cyfdDm5HEpmBI=; b=JYx7OvjFAQ70+Gdbhrl65CIEtR
	NrxOvGTS5oD0s0fzMwgkYE6Mngaq8ZwNxymC6JlB1QSOl1ScY45IBoMy/Y8S7FOJIN0fTQRe93LNL
	RHqHGZL1i/JfTBBc6sULBcRBhtyu4H7ZnhTgPzodNaIuRh4F8aOkpj6fHYnqop+GJ8zY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uovjz-005P4E-Fq; Thu, 21 Aug 2025 05:13:27 +0200
Date: Thu, 21 Aug 2025 05:13:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yibo Dong <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <47aa140e-552b-4650-9031-8931475f0719@lunn.ch>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-5-dong100@mucse.com>
 <39262c11-b14f-462f-b9c0-4e7bd1f32f0d@lunn.ch>
 <458C8E59A94CE79B+20250821024916.GF1742451@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458C8E59A94CE79B+20250821024916.GF1742451@nic-Precision-5820-Tower>

> 'mucse_mbx_fw_post_req' is designed can be called by 'cat /sys/xxx',

It is pretty unusual for ethernet drivers to export data in /sys,
except via standard APIs, like statistics, carrier, address, opstate
etc.  I don't know how well the core will handle EINTR. It is not
something most drivers do. -ETIMEDOUT is more likely when the firmware
has crashed and does not respond in time.

Do you have any operations which take a long time when things are
working correctly?

	Andrew

