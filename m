Return-Path: <netdev+bounces-213953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F78B27765
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 05:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D424B17EA98
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FC929CB45;
	Fri, 15 Aug 2025 03:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tL3PdVMZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A3F1A9F8D;
	Fri, 15 Aug 2025 03:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755230244; cv=none; b=u+1WzAhxQ3DwQ2c1ZDtbmY6POWdeAiTktNPbINIgpemI8wlHauO5vwqf5MvU9KTegDPB+kSxbmP9PxjBo96WbwrmHHd+/nA3t3BIqGVXkGqB8UdpLCedtf0jHf9cKMg7ObuKimOD13De5Mzs4Kabl5jjnkWU41PoK4QX8rV6tpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755230244; c=relaxed/simple;
	bh=G7/WeGxOfBAGyQn+G8KhVdg4gU93Eb1cfwADSc3J8dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxBuE9ZPnR2tNeeNpvmnly6pJbtTcdSag5xPwYVzU6DG+YFxswWcEy4oRM1Xox9ISu3qDCfPyIlQyt6yEM6TfcuZiTMJjDbb++48ca/UjknO7RDUaYbH7Wh9t5hGK1dKY/4Qpc/FBkeXuZlpl8sohgvC5J+x2QV+8ts2Z0uMynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tL3PdVMZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WO6HGod3bQhOV63FBzwDHUbuudCY7Dy+11AD/GUUbVI=; b=tL3PdVMZ+TiIPnnhhng5wWGBFc
	13Sd77Pelo+EFcoxePucsv/y1rEaXocolRstiIqIA0RcVUnua4E6Jf0OzCahevkSrIWOQAp8J0uX+
	yYPt8RrCF4EQFjQsYIuSFAIsCfzH1lK57Q8ZkSShGa/dA3u3lIvf9/5mSsZ0m+CwUUsc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umlYM-004mdr-H2; Fri, 15 Aug 2025 05:56:30 +0200
Date: Fri, 15 Aug 2025 05:56:30 +0200
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
Subject: Re: [PATCH v4 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <63af9ff7-0008-4795-a78b-9bed84d75ae0@lunn.ch>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-3-dong100@mucse.com>
 <a0553f1d-46dd-470c-aabf-163442449e19@lunn.ch>
 <F74E98A5E4BF5DA4+20250815023836.GB1137415@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F74E98A5E4BF5DA4+20250815023836.GB1137415@nic-Precision-5820-Tower>

> It means driver version 0.2.4.16.

And what does that mean?

> I used it in 'mucse_mbx_ifinsmod'(patch4, I will move this to that patch),
> to echo 'driver version' to FW. FW reply different command for different driver.

There only is one driver. This driver.

This all sounds backwards around. Normally the driver asks the
firmware what version it is. From that, it knows what operations the
firmware supports, and hence what it can offer to user space.

So what is your long terms plan? How do you keep backwards
compatibility between the driver and the firmware?

	Andrew

