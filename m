Return-Path: <netdev+bounces-166245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221DBA35278
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 01:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924CE3A773F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 00:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF48080B;
	Fri, 14 Feb 2025 00:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LLfcA2mG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B70173;
	Fri, 14 Feb 2025 00:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739491903; cv=none; b=gWQlzrktQKJ/8RlixTBemBXAyafJiYG+LbwKCd8CvoqAtWuMZmBhtHzbc+36wBqAwVjx06vNOqPSHJAOu3DFnz7JGgop9a0cRAEHwZjOAzBsTRp5GkdIgY4dI6CEnLHvlNThDVY6zHkW1wh11VO6RoUiEAdDVsLXVm0iShfO944=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739491903; c=relaxed/simple;
	bh=kFxL9+jcg0pyXdkmB5v5jKk4ItAik5h+mETF+2ErMYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kT850uFumW5wEnOTt9DZHSgRyKZytXWK2tKRYFKT/cSOgjeND4ni5mfwjC0AjrlRhm/1lV6KYNgO5Rt++qzCRcs755eGkEYkop5DdX53HO/mBFzeN5E0CoH3Pp15j5mJheFtTu7cGaLRKFDZWku3y7g51kv+ObW6GVnPc7uqbYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LLfcA2mG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PTH5ubBaFvtiOuCzoEHsnbFqUHpQlK62t51BmbJr9DA=; b=LLfcA2mGWS0v3jbNQghx4fyU9d
	pV/tBQz/TBVmwzS/2Sa/YLtrAPEBLXhB8cDtEqs1ZbsS6eaLdMRn0S/thXSBxwC5a+jy3/nQt3RF4
	YB7e356r9ydi2QZ/DLHLOyAtifoOu5spI33rkGRI9rTy7bVHXLfvJozkDSJ+bL28DJUk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tijIP-00Dthp-81; Fri, 14 Feb 2025 01:11:05 +0100
Date: Fri, 14 Feb 2025 01:11:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Swathi K S <swathi.ks@samsung.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	fancer.lancer@gmail.com, krzk@kernel.org, Joao.Pinto@synopsys.com,
	treding@nvidia.com, ajayg@nvidia.com, Jisheng.Zhang@synaptics.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: stmmac: refactor clock management in
 EQoS driver
Message-ID: <00be469f-1363-4305-a631-0281c42c282c@lunn.ch>
References: <CGME20250213041925epcas5p4d37d50047359b923efd9fdcaf4b2f6d2@epcas5p4.samsung.com>
 <20250213041559.106111-1-swathi.ks@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213041559.106111-1-swathi.ks@samsung.com>

On Thu, Feb 13, 2025 at 09:45:59AM +0530, Swathi K S wrote:
> Refactor clock management in EQoS driver for code reuse and to avoid
> redundancy. This way, only minimal changes are required when a new platform
> is added.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Swathi K S <swathi.ks@samsung.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

