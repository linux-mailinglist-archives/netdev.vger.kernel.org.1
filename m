Return-Path: <netdev+bounces-143375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E049C236B
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 18:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF621F25351
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 17:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD7E2123C8;
	Fri,  8 Nov 2024 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Yi9WEWRK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40E821F4A6
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087255; cv=none; b=k7Wlw+S9W4SkbwCyuA2WTl3BkZfsa9Z2qLKtGglAlsrCqg12OsNtMZFz0DWTlv3PW+h1J2BzXNSdfd6EimJ9zcwAudsueW77X0qkyiOpjOlllXLR7RVrbGT/WQC2tzixzJybWpFcHF8xyWz8kg3AtmUYTMruFmbs7G2aYOgLxFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087255; c=relaxed/simple;
	bh=dqK4MwWjAWyW2zbY3K9d5ITYDz5Sbxg4AB8gEu02CUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3tsbX+sUII1vPaKCF5L/VvW8NA4h3iRtHf1yDNK7fmhIz4d6kdhY4VLJGHtAmCN+R9bKh6h4RQbuJvRR6GT6TfJOxPIegIU5fLvOXC2VztBH1vNh8l9d2ZtrNZj6aBrpZVz/dGKYYM3nmLP8neLh30WO+tI6e2quZT8Kck+g3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Yi9WEWRK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ID41ZcOX+zuIPoibJWQpMg8uqVaFplLeSyRJl+K5Lvg=; b=Yi9WEWRKcT69s1dxB7Zmsmjxol
	Pmp+C+WFAQNOUtu7WbeDTxYLCITmCMnKb4wUD61BWb4AZ2OawM7bTKCZNGSEYakeaGq99RgZfmp8d
	RnTqLcRv03Adara4EYLhGIjm2ae8I2yRWoiR9TVsA9P5FfwsowmfT8lesHZDzzk2VpLc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t9Ss0-00Ccxi-0t; Fri, 08 Nov 2024 18:34:04 +0100
Date: Fri, 8 Nov 2024 18:34:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: phylink: move manual flow control
 setting
Message-ID: <a31b965a-c9cd-4695-a7f1-9201a00e2dd4@lunn.ch>
References: <Zy411lVWe2SikuOs@shell.armlinux.org.uk>
 <E1t9RQe-002Feh-T1@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1t9RQe-002Feh-T1@rmk-PC.armlinux.org.uk>

On Fri, Nov 08, 2024 at 04:01:44PM +0000, Russell King (Oracle) wrote:
> Move the handling of manual flow control configuration to a common
> location during resolve. We currently evaluate this for all but
> fixed links.

I could be mis-remembering, but i thought somebody recently mentioned
they wanted manual control for flow control for fixed links.

Nothing comes to mind why it should not work. With manual control, it
is purely a MAC problem. There is no negotiation involved which would
require a PHY, which is missing in the case of fixed links.

Am i missing something? Other than you want to keep the current
behaviour.

	Andrew

