Return-Path: <netdev+bounces-213928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB62EB27583
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 04:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A843B23E5
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CA1277C84;
	Fri, 15 Aug 2025 02:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xCnzggWm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A443147;
	Fri, 15 Aug 2025 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224067; cv=none; b=OWAqI64iVe9xFBfe/V7boo+lt1vld3HnAUoc8PM6DQF2EYwXEX8Lw0hAxEDg3zqic9DzU8FkxBU3Ge0FPUd2VZEAEqr3JKlWbMypDCyH5FH6upwvnP/EuqObp56lGqACOOlxL9ZMEq7HshtkvvPzwLSq6SufrdfAMlqHxzvJwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224067; c=relaxed/simple;
	bh=Th77REqXVBmzE4qEf1WOOV/6nUIotghbT3Hd0KGHxKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMifSZ/A6XakTrYN5odWIhPqa4cIDDZdIPZNKUfOzsXPv8U7skyXc27kH+BF5FVHbBtk3BnKKctViEdv8As+/GaEL5eaL21+uPP5fnJgP3/7kre9vBqick9soP0S4CqJCl6LVqGQPt+T8pW8/99G0hN8Js9t1okrTU6GI65XJq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xCnzggWm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7QD3hEDmIZHvSF1csNi4PMhYkkxHST540XMLEV+g+K8=; b=xCnzggWmH4BtyLsPbSkKfPV/sX
	QXJVF5/wfT6aqowPq9gfFMBFagKCObqRaR7RTO8ChKD2RgLOXLSbRye5Sy1a8q7uVqeIt4KAfoiNa
	h1n1UjwROsE+IE6HFEM4IE1UtL56w5KkUrUFj24VuJ9XFof2AG2BK2nn5muJXrzpLfRs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umjx2-004mD8-LW; Fri, 15 Aug 2025 04:13:52 +0200
Date: Fri, 15 Aug 2025 04:13:52 +0200
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
Message-ID: <fa273889-f96e-4ca8-9d19-ff3b226e2e29@lunn.ch>
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

> +const struct mucse_mbx_operations mucse_mbx_ops_generic = {
> +	.init_params = mucse_init_mbx_params_pf,
> +	.read = mucse_read_mbx_pf,
> +	.write = mucse_write_mbx_pf,
> +	.read_posted = mucse_read_posted_mbx,
> +	.write_posted = mucse_write_posted_mbx,
> +	.check_for_msg = mucse_check_for_msg_pf,
> +	.check_for_ack = mucse_check_for_ack_pf,
> +	.configure = mucse_mbx_configure_pf,
> +};

As far as i can see, this is the only instance of
mucse_mbx_operations. Will there be other instances of this structure?

	Andrew

