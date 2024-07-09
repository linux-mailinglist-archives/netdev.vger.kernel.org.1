Return-Path: <netdev+bounces-110282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EED92BB6A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F891F27693
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2574617C9EB;
	Tue,  9 Jul 2024 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2f+Eujxf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931817C7DB;
	Tue,  9 Jul 2024 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531900; cv=none; b=NfaCEztK65MyaJOzy2EIYemObm6DyLSi+TN8zv4rjp2hkpiei76jbr5ddR3ArYMks+K4YNFEsG+d72BWRKs+eQ5CH3n8UL3s8SA1vhruGVxY+urMN3jcbhbE6otZwKuFodcJ3u4L7d2q6sPtcCiCls3OkKc6RWCNkjG98VySqNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531900; c=relaxed/simple;
	bh=4WP+WQ9nQvGm3F9qQzb3JcVtkEtMk1y8Lok9QkQkdaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqufbVOOumHFYxEHgZZ5oT7z8GV2mYlB3rIdiWcr+RkzF/ggvXJC7luBmUvLafZjOxxRwM5pJ7TbTXi+K7oYzOUZOEPGo3dQObRFMhNufe0H9ApOtnmbkOo7zafvEwv9kA3qFrlToYJABOAlDohjb/DZhtH8Jw4NV9Cz5fU1mtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2f+Eujxf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Zre5YSHteeLdEYtuTx/X+RGnWx775ASLQOdTxRDdE1M=; b=2f+Eujxf0jG9ADlgV4JEjThm70
	ijEtLEUs5PC2z37RnVaF0M08Hvl0ZPDHZ7WYUK7azsyd9E/0uohZwhiEnMtmvjay5hIurMagJv5ZG
	BcvftJrTYNWO2BWi3y5juufyiUQ/mBqiSNv4FVLHqS/qv0gY5OurErVfDUE9+ixx5QjY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sRAwD-002945-K6; Tue, 09 Jul 2024 15:31:21 +0200
Date: Tue, 9 Jul 2024 15:31:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1 7/7] net: stmmac: xgmac: enable Frame
 Preemption Interrupt by default
Message-ID: <28ddf3e2-be4e-437a-b872-5ba07659e40e@lunn.ch>
References: <cover.1720512888.git.0x1207@gmail.com>
 <fc69b94aad4bbe568dcf9ef7aa73f9bac685142c.1720512888.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc69b94aad4bbe568dcf9ef7aa73f9bac685142c.1720512888.git.0x1207@gmail.com>

On Tue, Jul 09, 2024 at 04:21:25PM +0800, Furong Xu wrote:
> Frame Preemption Interrupt is required to finish FPE handshake.
> 
> XGMAC_FPEIE is read-only reserved if FPE is not supported by HW.
> There is no harm that we always set XGMAC_FPEIE bit.

This is better, it explains what is going on, why the change is being
made. But when i see this, i think about the interrupt handler. You
don't just enable a new interrupt, you also need to handle the
interrupt. Where is that handler code?

The commit message is the place you try to answer the questions
reviewers are going to ask. So if the interrupt handler already looks
for this interrupt cause and handles it, add a statement to the commit
message explaining it.

	Andrew

