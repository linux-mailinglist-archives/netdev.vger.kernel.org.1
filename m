Return-Path: <netdev+bounces-159029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB11CA1428C
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19E697A4748
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 19:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AECB242260;
	Thu, 16 Jan 2025 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fgnloXH1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC46223F263;
	Thu, 16 Jan 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056701; cv=none; b=VgW2iWuM0JGU5XHbAZfw5tKXn1WVnhXazn38SBHBlfzWZXdg+milLdsu4AdAndBNkMluxrYYlLYznx6sqYPtMPO0bSJbhDDSy5m1ZVWmyaeoyXSSMNDSirlwdngYxq/VuY6DSA+f7hDa+4XDlQxYZDVjxPXbKANDwiXghVE+SAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056701; c=relaxed/simple;
	bh=CHXs2a319T9S8wfPr+ChJn+bi8CKOamBa3nNZ8hEMk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMcHOI/kGSJf2wvFr8zwe6e2qBdaMkwmgvBgIMRp2zy6lty1rQbBiHlxGa3zVbJDw5DDm2imaKBa2dn0C/cbjhd6mBH0DWMRN/2rxXiZ/ZBCeWutZMnEejXva+FqXg801SErIwtVE+auwbZeQO57D+HplVfL+nt0kgj8GmwpuTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fgnloXH1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1cYWpom0frT7y5jZNhepp5o3LLlvwLInEYlCHmmJrCw=; b=fgnloXH10/DGfsLyWI+qNa0joF
	R7+iRIko4EnI6anPep3emo236RHBsD82Wfy4IDwpcNKbGfMlOv0UYCT4tVBlgeZtsgGX6Fdrthl4E
	POj1+pO8xjq6eHktQlk4N5Mtl32uEYcInt+UrMjTW6Ss3eacNRBXdSTK1DdonRDFH+2k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tYVnK-005Dfn-PC; Thu, 16 Jan 2025 20:44:46 +0100
Date: Thu, 16 Jan 2025 20:44:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Xiangqian Zhang <zhangxiangqian@kylinos.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] net: mii: Fix the Speed display when the
 network cable is not connected
Message-ID: <98ab660d-c034-4be9-a229-f761ef5cf09c@lunn.ch>
References: <20250115112157.3894984-1-zhangxiangqian@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115112157.3894984-1-zhangxiangqian@kylinos.cn>

On Wed, Jan 15, 2025 at 07:21:57PM +0800, Xiangqian Zhang wrote:
> Two different models of usb card, the drivers are r8152 and asix. If no
> network cable is connected, Speed = 10Mb/s. This problem is repeated in
> linux 3.10, 4.19, and 5.4. Both drivers call
> mii_ethtool_get_link_ksettings, but the value of cmd->base.speed in this
> function can only be SPEED_1000 or SPEED_100 or SPEED_10.
> When the network cable is not connected, set cmd->base.speed
> =SPEED_UNKNOWN.
> 
> v2:
> https://lore.kernel.org/20250111132242.3327654-1-zhangxiangqian@kylinos.cn
> 
> Signed-off-by: Xiangqian Zhang <zhangxiangqian@kylinos.cn>

You say this problem occurs in some older kernels, so ideally we want
this patch backported. Please could you add a Fixes: tag for when the
problem first appeared.

Please also read at least section 1.4 of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr

