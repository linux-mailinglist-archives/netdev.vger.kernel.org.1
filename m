Return-Path: <netdev+bounces-208968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F322B0DC3B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFC75676BA
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9852EA498;
	Tue, 22 Jul 2025 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ag3Qpvua"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D962EA46C;
	Tue, 22 Jul 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192596; cv=none; b=iP53RyksTUtW/zahWG63epSfMeQzFdCGEpcgvJfGmJADPTuL5DL1+DOh7JinciGba29Io+f+2CJ4OwRdOMOj6AhCbrOih+CVJcJlLohMFN1kS1FV4KWb+4B5WtJCwX1Ob22Q0jL286lF50Ae8t/eO8eR8KEiIqxNX3BWysREG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192596; c=relaxed/simple;
	bh=3K9T2kyn3bASHMxtwsh2/AzdiKDc1GfcfXy1hitJjZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvuGao9j2d+WYAr7IVEKDXmD9WpkovIY7vmKo9BwmgoeY6TXz20Hwj/vHNvxyStuBO/PmNXPe90rO7E5dYjrAg+cb+R62SG84UTEoQT34BPIDDZyh/CzeheSsRkKJhGFTkvvWqzdzxf4TrN4pJoaD4/JKO6wMtVkHFotTw0kG44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ag3Qpvua; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gUdkJH/TIEzuP3/jJRSgayjomDT2mnDPVBrl1QqSpXA=; b=Ag3QpvuaDgGv1nk9QH+7ud4H2V
	257T3cymOX6iJl+PpwW0dSxGGDJZ1X+PaGZteJOgkvqCvF8ub3ctWoTb5J9kttt3OUH5Wo6WprYIH
	uNCdRSWTNYBplTNMV1LbfR+jQwyQ7Kk0mburSYS8ota4VsyKyP+3559PukG2R64N32I0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ueDTO-002TJR-Tc; Tue, 22 Jul 2025 15:56:02 +0200
Date: Tue, 22 Jul 2025 15:56:02 +0200
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
Subject: Re: [PATCH v2 02/15] net: rnpgbe: Add n500/n210 chip support
Message-ID: <21ee0d49-8cfd-4046-a07c-c920a74e549c@lunn.ch>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-3-dong100@mucse.com>
 <4dea5acc-dd7d-463c-b099-53713dd3d7ee@lunn.ch>
 <8E12C5B26514F60A+20250722062120.GB99399@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8E12C5B26514F60A+20250722062120.GB99399@nic-Precision-5820-Tower>

> Yes, I got it before, and I really tried to improve my code.
> But this is really hard to avoid here.

Agreed. When writing the driver, you need to write it in such a way it
can be reviewed. And that is a skill in its own.

Sometimes, you end up writing the driver twice. First time you just
concentrate on getting it working. The second time you write the
driver, you break it up into smaller, self contained chunks, which are
easy to review.

	Andrew

