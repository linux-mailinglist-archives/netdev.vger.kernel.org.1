Return-Path: <netdev+bounces-224607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3080FB86DD8
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC391CC28F7
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 20:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E10031A7E8;
	Thu, 18 Sep 2025 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KVGljP+9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE52BDC3F
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226426; cv=none; b=mThpnMGH8hDWqkCU8W2F9oX6Ub+lOncY1LV9jezu+fbE0KcaSk4Vqk8xptIO7kLZBzqXlkHro3KXZfZMIfbnES/fqJiaPUut/Zb8RyQjC+vIn01Pr8k3BW+J28z1d6+dCXsfsh9GYSxkvjEobVoPsvqSRIskUtfIKcHGSrKct4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226426; c=relaxed/simple;
	bh=zbIz5gnIoUj4OtoSTbqUOLuWpYPvLphdyaTZeNgl30c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7Ng8wkpyJyFAogG9sFFq9ulYJ/plgosKIGGwS4/OLUlHbTPGZ8tQHtotxIlgyLms4yJdQuR1rN62C7rRmWdKU3u0OCXXBwIECk2ltXZ9ovWOjA84eBVM+ocA0VsDMf/RF4ZIe0V9ZY/pHTGsz6ihV+BqSOz65bUxio0IkXd2ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KVGljP+9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CfYz9PLrEredOmyMWxGHR02Oxg5nIZN5VK21cNqn2+o=; b=KVGljP+9ad/owgfoJOFryrZ+oc
	ajHuFKRTLMjkKHa/+AhoRer/DOUy3rWC6qdWQb9OVTMaXwDnOUUnbYDIldkQ8ElXXKMUG0bgASuUm
	hgq6J6Tb8zlPYm/2LYVW2SvcRYdAOiXgOh+t2U+VPfyYYMYDQF7vaUiYgQ09TfmXqfdU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzL0g-008sBv-RT; Thu, 18 Sep 2025 22:13:42 +0200
Date: Thu, 18 Sep 2025 22:13:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH RFC net-next 05/20] net: dsa: mv88e6xxx: convert PTP
 clock_read() method to take chip
Message-ID: <a285aeb3-66d6-43c9-994a-d6593b09265e@lunn.ch>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
 <E1uzIbF-00000006mzW-1gww@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uzIbF-00000006mzW-1gww@rmk-PC.armlinux.org.uk>

On Thu, Sep 18, 2025 at 06:39:17PM +0100, Russell King (Oracle) wrote:
> The various clock_read() method implementations do not make use of the
> passed struct cycle_counter except to convert to the parent struct
> mv88e6xxx_chip. The caller of these methods has already done this.
> 
> Pass a pointer to struct mv88e6xxx_chip instead.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

