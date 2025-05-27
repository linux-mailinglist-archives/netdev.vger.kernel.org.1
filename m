Return-Path: <netdev+bounces-193649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EF8AC4F6C
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611301899FB8
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0603E25487B;
	Tue, 27 May 2025 13:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AFuyeuTy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF53FC7;
	Tue, 27 May 2025 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748351722; cv=none; b=TnT+P7PCVDIFoxV5En54ab9aSE7OvmjVrfsbYejUNa+1W+UJ7uX0XTXrOyLe6T7nL1EIi+aN12b0ImcRJ0+0RFFIM4MJN4KcP39Ye/njtSaSfjqNZ8DAxbgdyAxIDgk3g58BhZDCzGVqnybv6SQklWymPBMSzMAaosX5t08giE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748351722; c=relaxed/simple;
	bh=R0zE+Cjv+JdwWsupUxUqiApp26pIfmEG8hAk/G7uZ3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcrYF5NQX162Mycq8Vz5sXBZWDrgVMLRLvMx1wb3XysHUhb6ajTn3F8+EKQkovDYJB7XnEvhEfKFKWScR3uH01iYrnrWOjbfpbOUjma+DPulmiH6Y3WCvClyIiKGCe85o1dtMa1CWG178e6UGT1lMlZ/P5J/8ckprJ9FMJESTjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AFuyeuTy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=JprIsYNIPoxyHns3ZiuAwn+9eyHxv4Lgti7x5LNjShc=; b=AF
	uyeuTyib24Ok9CdkIeRRn5HV0GkV8OSq1pHQwE4IYQ/1T77StuvLRzK0xL6saABwYOq1/invOrr6w
	JkSMrI+UIJGylzyvyvztiUG2E4YKbkQnWL+uoAjE9+XYPk7eHZ4y1B1ZIrNa5ZL0y53W5rYGZarIK
	rWstZv6hJ1yQVQ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uJu8u-00E4ti-AJ; Tue, 27 May 2025 15:14:56 +0200
Date: Tue, 27 May 2025 15:14:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: =?utf-8?B?5p2O5ZOy?= <sensor1010@163.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, jonas@kwiboo.se,
	rmk+kernel@armlinux.org.uk, david.wu@rock-chips.com, wens@csie.org,
	jan.petrous@oss.nxp.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dwmac-rk: No need to check the return value of the
 phy_power_on()
Message-ID: <7bde400c-add3-47c7-bbbf-311aa8270ccf@lunn.ch>
References: <20250526161621.3549-1-sensor1010@163.com>
 <be687d2d-4c16-46d6-8828-b0e4866d91de@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be687d2d-4c16-46d6-8828-b0e4866d91de@wanadoo.fr>

On Tue, May 27, 2025 at 07:43:57AM +0200, Christophe JAILLET wrote:
> Le 26/05/2025 à 18:16, 李哲 a écrit :
> > since the return value of the phy_power_on() function is always 0,
> > checking its return value is redundant.
> 
> Can you elaborate why?
> 
> Looking at  (1], I think that it is obvious that non-0 values can be
> returned.

Wrong phy_power_on(). There is a local scope one within the driver.

	Andrew

