Return-Path: <netdev+bounces-232240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4310EC03149
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 20:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE04B4F6B96
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ECF29B20A;
	Thu, 23 Oct 2025 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o6QP+zM1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C255303A2E
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245496; cv=none; b=qcywVDJmaCtKEP3uJaezrGp/FpJwat0mfKggk1jLtU43bQkkgOW/8yY1EbKwj1zN3GGbpLkJA/wPuK3+zcU8uHWbO5rhOyv6qttn4xrgAhn8bpuSonjKGbjYJEOdXbd8lN4iTETaI8JIPuVZdERgpwbnIGzT9cu3sYT/4N5fOWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245496; c=relaxed/simple;
	bh=An70VySsU8bumz/771ObvXggjhBHfLQh64qc1u+VqU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XL4GL5SJkwevXb86C4libyansUw+FpM2V7/PcTWucbWO4Al5bAy4lhOs96JvaP/4AcVv74VTKLZnTQisQ2pMcdrVv3xeMSDGHc/FWCFzSsxdqoA8Db4O9UEAPEKEhILXnEeHJ6gjt4YMRx13QuuCR2PMpnMWRaQqrZuPDQJAi34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o6QP+zM1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Fck8LKgCheBTtzhirGZSgVYji9+4kt2G7PypWCpeZQ8=; b=o6QP+zM11VgjiUYwb3dDbDDxhB
	itSVZWwvgs9DXykbevr1fDvhfNdpr7f4ev7J8vRWhAq35HLERa05sbIcrY2V8AgDHp7xzt3uQHxw8
	03eN04bzBr4VbJkBKHOmVBLLLq0HOJc98EPj1sEQmJiMVQuv1Hemka56vt1skkpQcRyk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vC0PH-00Budg-KO; Thu, 23 Oct 2025 20:51:27 +0200
Date: Thu, 23 Oct 2025 20:51:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net-next 7/8] net: stmmac: use != rather than ^ for
 comparing dev_id
Message-ID: <4dbb99c6-77da-49f3-bce3-5bfc297f2c21@lunn.ch>
References: <aPn3MSQvjUWBb92P@shell.armlinux.org.uk>
 <E1vBrla-0000000BMQM-462M@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vBrla-0000000BMQM-462M@rmk-PC.armlinux.org.uk>

On Thu, Oct 23, 2025 at 10:37:54AM +0100, Russell King (Oracle) wrote:
> Use the more usual not-equals rather than exclusive-or operator when
> comparing the dev_id in stmmac_hwif_find().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

