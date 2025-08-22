Return-Path: <netdev+bounces-216138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5542B32336
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 21:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC98A081DB
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 19:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702C02D63FC;
	Fri, 22 Aug 2025 19:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FdP8PGUG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CEC2D5C9B;
	Fri, 22 Aug 2025 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892385; cv=none; b=JTINg7S4Ak72rSUU62uG6DowEdozeL61zjg6xZQXo4FA2vXchgEi7Ddm5534JhWFiPNT/LedpFCCZhR7H/Bz/hmecs5BM6mGH4g3F82lL2/hg+RzGkUeZDPn/MD4+/TzsCbIMKlASw4AvYMDllsZSaaRmXzqoiZ65s2EzJJsUDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892385; c=relaxed/simple;
	bh=+tgHII2YdKPbcUDMlpuz2Tm/TQfTrZhtY75fIlZjeZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/fm0DolEDracBOtprBAbFpQrLGxsPbFxZE531fbA6jBhi6mZhfza6dJqWQWOSRbEuOQ4DxbaebqP5PwW0rLZyEhAG6DTOMTsYB9Pbj35YwEVZmstkHxG6u6HtF/4U164KQ+CCf+vdrO425nU6RyR6KBffVN8O6EyU+0d/Xw1GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FdP8PGUG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=2L1EmpCK+ApiBjbxlq/uIrcSIfkloaPzamvTaIKo3ZI=; b=Fd
	P8PGUGRkVDWu46BTFLj7gQKHLu9+n/JE5RBsqsd0WRxkeREUyBzFYl6/hwm2AIf6lhN3Gtxc+kVoX
	6L4RdxF1ySTDGWu33YBJPpX9WW8e/Q3tfpfItZOY2oZb4P6ngy9e4tTCOw3KI7q/+c43t0v3SucOp
	/XHTudITGTQBNxE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1upXoH-005blf-K0; Fri, 22 Aug 2025 21:52:25 +0200
Date: Fri, 22 Aug 2025 21:52:25 +0200
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
Message-ID: <d7a38afc-58c1-468a-be47-442cec6db728@lunn.ch>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-5-dong100@mucse.com>
 <39262c11-b14f-462f-b9c0-4e7bd1f32f0d@lunn.ch>
 <458C8E59A94CE79B+20250821024916.GF1742451@nic-Precision-5820-Tower>
 <47aa140e-552b-4650-9031-8931475f0719@lunn.ch>
 <7FCBCC1F18AFE0F3+20250821033253.GA1754449@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7FCBCC1F18AFE0F3+20250821033253.GA1754449@nic-Precision-5820-Tower>

> 'Update firmware operation' will take long time, maybe more than
> 10s. If user use 'ethtool -f' to update firmware, and ^C before done?
> If ^C before mucse_write_mbx, return as soon as possible. If after mucse_write_mbx,
> wait until fw true response.

And what happens if the firmware writing is interrupted? Could you end
up with a brick? This is actually one of the operations i would not
expect to be able to ^C.

You might also want consider devlink flash.

https://www.kernel.org/doc/html/latest/networking/devlink/devlink-flash.html

 It replaces the older ethtool-flash mechanism, and doesn’t require
 taking any networking locks in the kernel to perform the flash
 update.

I assume this is meaning ethtool take RTNL, and while that is held, no
other network configuration can be performed on any interface. devlink
has its own lock so avoids this.

       Andrew

