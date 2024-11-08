Return-Path: <netdev+bounces-143401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 271FC9C2479
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 19:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3FAB1F23587
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 18:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2182B13B29F;
	Fri,  8 Nov 2024 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iBVVfNxq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A12B233D6D
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088432; cv=none; b=TJSWYp2JZghgjT/3iA8RPiZSnAUaRzAPXfte1Dt9FxsPOU16cWz0I7DvVndxHno9SmxMYXxM1J7iYFATUitpjog0oI24CcPUHk3BvrUjZ4e0vGV5Tw8QYzkWJmaTinlKJX5MCnZG//7cYGBy6ey01ytiZLhd71aD3P5bMlJNIpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088432; c=relaxed/simple;
	bh=3xuelmDrjbLP3Sn+bfiUR/xzHvYFFS5oJpFv97j/f2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2UAyCqrBbgpqJpZv3LVEOLR5gWR4vYJGZMIfe0qK0yLP1jMirUJ5WhC/gcxDCpot3rWEpwo82thvLDvghSiKL7rPiqNceaoOg4BohyR62whFOcRUsaeS8c/mHXlgUHrQ37+rkCeJfKkKgxEUnitCIBKU4grYYK/xUJOVx7kFSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iBVVfNxq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FassuGwphdaH0W8v9rg9WUGPvPYgXhfB/qu0Po4RMt0=; b=iBVVfNxqvZgUTsNgVZLmFbTy1H
	D/9VbCkyYpnkVc04nu3JYYowgh4l746HThcn19ObnR7KpZAu6RKfzHXeUXgKlK08yoUGsIiQMixBA
	Vqy7EkbInRHYD2S4qXqLY3bXjoTNhy/zWhbxpZPowQb39U5SgZRir93VpnGcq+SQxZpGMV3lFpwNz
	1Nebrxt2DaQLiKWv+IF+D7RsSWBXILClDW90bLGFlBsJKhHhTPDo22/WbiTWtiOQg1NdEmaO403kB
	d3tN3WQTYTUzcTINaeRY+SM2uotSmoSrjudDSku+g+Odqkl6kako+5kn0SawDkMt2s+oq9VuVs9sG
	jflS7Nrw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51132)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t9TAu-0005mf-0D;
	Fri, 08 Nov 2024 17:53:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t9TAr-0002T4-24;
	Fri, 08 Nov 2024 17:53:33 +0000
Date: Fri, 8 Nov 2024 17:53:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: phylink: move manual flow control
 setting
Message-ID: <Zy5QHQMyZOuOZQ7t@shell.armlinux.org.uk>
References: <Zy411lVWe2SikuOs@shell.armlinux.org.uk>
 <E1t9RQe-002Feh-T1@rmk-PC.armlinux.org.uk>
 <a31b965a-c9cd-4695-a7f1-9201a00e2dd4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a31b965a-c9cd-4695-a7f1-9201a00e2dd4@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Nov 08, 2024 at 06:34:04PM +0100, Andrew Lunn wrote:
> On Fri, Nov 08, 2024 at 04:01:44PM +0000, Russell King (Oracle) wrote:
> > Move the handling of manual flow control configuration to a common
> > location during resolve. We currently evaluate this for all but
> > fixed links.
> 
> I could be mis-remembering, but i thought somebody recently mentioned
> they wanted manual control for flow control for fixed links.

I haven't seen that request, but I do have a patch prepared in case
someone does want it.

> Am i missing something? Other than you want to keep the current
> behaviour.

Indeed - this is a cleanup series, not a functional change series.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

