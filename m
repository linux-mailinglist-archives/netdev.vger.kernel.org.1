Return-Path: <netdev+bounces-166914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B50B4A37DA2
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939271896539
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 08:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3214E1AAA05;
	Mon, 17 Feb 2025 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ft5dH1vu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93A51AA1D8
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782547; cv=none; b=e7njzWoes1kNhRCaYEHElboFgSamHeBhXyBFTe2c6ftetUoAzzrWy1z6sd7/FvvSY2Tem4wQLY/0ZE5JWzoeM2/AeCvzpm0X85UvmbjGzVi496ytBudt/AEilccHHJNpWtWH9GeCK9/xFH+3JvPLfZSAJzci9Z5X3vD7rpPhbgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782547; c=relaxed/simple;
	bh=A5ofSsq12RYyhCYTtzOq8enMlcB5wn826/qkLSMeg7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRHTob/haPkLWWCJ/bDrsmg0mtErZdbIZR9X3ravUf9EeyCeZKhurV0SEA8ZHTBPulXmkKGrnM3mkl2xyb7uKMehZxepntGt2NyXvZkwOuBThrQ43rUZMbckGy3KE4YTarrF7kNPOV/axJTxQ58DmtoFZwfK0SC8TTXfpHTZ6jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ft5dH1vu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pyHh5LQvVCOrMHgBMnXMkfWb8aM0jvKrsthmJUK8x2w=; b=Ft5dH1vu+vRahSpDQOhPIkNHWH
	pQ3tZCyx8ZIayQZhJq8T0jE3+wGV9ZFtrJ9r5GmRC0kO32cMjW8Uhb31LWd5Ep2kK8I1OCcbES/+V
	2MtVSlP1jphTkVx45Fb7MIKCSYz0RSNYGi0QqC7GXqKq5XghKFgCybmxx9RJR6qeQKcQiRICldDXz
	aplZuNBbfE2r1Qmr+AMz7aWIwJGfJaz7Y2OPXnBCcHQ7DYzjXg7dw9tC+WWaMGBScI5vFvz8aGu9N
	mkEb6V2azQpi1dtXhX0yOfc8//t/t10nkO8sqAe6KCA9iptZm7vjfqrkQ4aZlmTTc+p+DDEreCYVS
	mTqXuRBw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36826)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tjwui-0005sm-27;
	Mon, 17 Feb 2025 08:55:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tjwuh-00065F-13;
	Mon, 17 Feb 2025 08:55:39 +0000
Date: Mon, 17 Feb 2025 08:55:39 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 6/6] net: phy: c45: remove local advertisement
 parameter from genphy_c45_eee_is_active
Message-ID: <Z7L5i5dFGlvIk4wQ@shell.armlinux.org.uk>
References: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
 <bd121330-9e28-4bc8-8422-794bd54d561f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd121330-9e28-4bc8-8422-794bd54d561f@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Feb 16, 2025 at 10:20:07PM +0100, Heiner Kallweit wrote:
> After the last user has gone, we can remove the local advertisement
> parameter from genphy_c45_eee_is_active.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

