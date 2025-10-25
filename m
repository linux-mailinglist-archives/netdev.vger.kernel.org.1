Return-Path: <netdev+bounces-232746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D2DC08869
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 04:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE34189C403
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 02:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B9F23AB8D;
	Sat, 25 Oct 2025 02:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npHZ+2Qh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFEB23A98D
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 02:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761357721; cv=none; b=Dko9kL6X9vCIamwC56QrxYNoPuEelcz+UBBvxEo4rdevXLtoYpV+E+F3/QEq5R7UaQeh1HD9Efcd0I+fI2uW9N0r2J/mMdHBntUXsUT0m2g+C0t2cPanrnewIvOZWkKUwua/dTAw7YxkCDxjUU5fGgy9Mo+yO0dMarCJRPFUdG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761357721; c=relaxed/simple;
	bh=znXa4MTmgD2GT+6EgOiEt1q1x1IwgN2PdMxLNSJjMV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDKOrvJt4x3dFV92e4WSuGa1LKv2QJzE6HzR8vnY4p/IYK2it8TXiNQwuaHcLSPhXZnXFaSduMDznNNUmJeGox2yxAW8/S/AOtoqkYHm5vQ7A6Q4f2TO7oKCDI+/Fjf7R71iAgOBS/NEvPKJWsH6TCaxRrjZWHgxNbXltMiKK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npHZ+2Qh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4FCC4CEF1;
	Sat, 25 Oct 2025 02:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761357720;
	bh=znXa4MTmgD2GT+6EgOiEt1q1x1IwgN2PdMxLNSJjMV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=npHZ+2QhpzQZMTObG8byre7FkwKihYjra6KYY/j9g3Ru8obLrxwg2qn8OuY80aWmD
	 sHybgiMWxnOnhvgAOjsSC7C+ovz9IKKgoFDQYOFjseY39UonVqos0RztPHLP6AljYZ
	 S2fyn+qE7NB4qYFK7T7FRyUT4ao1BdHWBL5RqslhI8cCkJUwvSvaWHIkxIvYwzG2Fh
	 r4/1xEc0JUP2HXgf+2NODGI1Gkegf0MJhnqmeEcfziM31bV02vWrhNZS6cOBBM89qD
	 ig4OCLCwRDiZw0KEqlT3sYY65gmIknzdMiDcFeOqbbk9FivzQMqHK4hqcYaMAfeVBO
	 knmLlYvM2XpIA==
Date: Fri, 24 Oct 2025 19:01:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/2] net: stmmac: add stmmac_mac_irq_modify()
Message-ID: <20251024190159.60f897e5@kernel.org>
In-Reply-To: <E1vBrtk-0000000BMYm-3CV5@rmk-PC.armlinux.org.uk>
References: <aPn5YVeUcWo4CW3c@shell.armlinux.org.uk>
	<E1vBrtk-0000000BMYm-3CV5@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 10:46:20 +0100 Russell King (Oracle) wrote:
> Add a function to allow interrupts to be enabled and disabled in a
> core independent manner.

Sorry for a general question but I'm curious why stick to the callback
format this driver insists on. Looks like we could get away with
parameterizing the code with the register offset via the priv structure.

Is it for consistency? Do you like this code structure? Is there more
logic coming for .irq_modify variants? Or am I missing something else?

Mostly curious. Personally, I'm always annoyed having to dig thru the
indirections in this driver.

