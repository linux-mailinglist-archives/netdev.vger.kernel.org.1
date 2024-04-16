Return-Path: <netdev+bounces-88383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6143A8A6F1B
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 16:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926E81C20B17
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD7F12F392;
	Tue, 16 Apr 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Zw/ZIfle"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E9E12DDAE
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279377; cv=none; b=SLp+6A4+C/XzBZmji3I3ShfGrY5xVF1nQjgIXSjw3cJJaCypS2b7J+6Gx6lkQlKtQDs9l/0hzlXIYhV9NeWrJMnU54yvV4X0w4xeesvTym+L+dp9GaYZLNDNNOPuQMxDXIUI/fXglCGEy7DR05gkhj+qdjPU8viatsel0zDcgWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279377; c=relaxed/simple;
	bh=JeZDI1y36soG59ZqVMDmUzwbuSq8jAAbqPfCeszK8js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXZrbRsJKnN9ZzZOM/g+RHeBSsRXuJGGj9A5R0AapKk1TtQbb24YxiCE7hlBPqFv347HWsy5ETVgADiKECDRfS5E2PvTPoZGdmwbsk0yqUNrtBjzLU/Y7I1PCNcpzgXCI4BV4i2izYn01J4jhiZ/8FGwdno3WkjflcoDSMMdJiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Zw/ZIfle; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vD5lTVMA6gl8qzn9v2O3mG7Am9SGY88LNVmjlHSAEWY=; b=Zw/ZIfleqhe9yjL92xVZpZwAeF
	4SHHw905agjc0foq3gE1i4SIeqkCE1xDQBcEAtlaWoM/8wplQXC9qNLi3OaWwZoJW+4ry9fy+rGn+
	w4yuim6P+eK4Z7cXyofaB6wvy4k2yLBwQRgXArWOE932MgrtNuAsIDqYYi3OwdVMXTQI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwkE7-00D98Q-Rs; Tue, 16 Apr 2024 16:56:03 +0200
Date: Tue, 16 Apr 2024 16:56:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net 2/5] net: wangxun: fix error statistics when the
 device is reset
Message-ID: <ff606ace-1128-4d16-8192-7ff1a40301af@lunn.ch>
References: <20240416062952.14196-1-jiawenwu@trustnetic.com>
 <20240416062952.14196-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416062952.14196-3-jiawenwu@trustnetic.com>

On Tue, Apr 16, 2024 at 02:29:49PM +0800, Jiawen Wu wrote:
> Add flag for reset state to avoid reading statistics when hardware
> is reset.

This explains the what, which you can also get by reading the code
change. The commit message should also explain the why? What goes
wrong if you read the statistics when the hardware is in reset? Do you
get 42 for every statistic? Does the hardware lockup and the reset
never completes?

      Andrew

