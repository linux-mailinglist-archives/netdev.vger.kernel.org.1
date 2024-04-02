Return-Path: <netdev+bounces-84159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A84895C88
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 21:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD3BAB21810
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 19:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4DD15B575;
	Tue,  2 Apr 2024 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MKbPucJ3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DB715B55A
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086116; cv=none; b=Y738WS9v0urEoNzPJsFv738fH1npaUws0HyOSahxHK3Fkt/7Rfjc/Y6rA620Oey3C6+rwPZwpdbr0aqjZWkCEZexT/frulWbyxTRb9lKAO3B9QYLTKJ3DWxmO+bgTwA7WcvJUPrk6kTNwvPk6WqTNhca4/OVDPLnZq/nRaq0qes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086116; c=relaxed/simple;
	bh=jNwBnIRrZahAF59ZgJRCtrqIfItH9Qvkhuur1b5OAlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADicN+YQVQ7hJq9ajeoBzl2MUnLRss7cXLXjVY2huVnPr3ygw26HVWFUR4JwRKof/2xzRVb9Su/nwSllGbmJFWGOJ8c2CqokBGV+AtreZcsqYwcn2PZkhbEwaa5jvg1t/nCfGPHsNAmodLdVf0BkIbio5FcPz4N+oHlI0ZPFTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MKbPucJ3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yR5Oa2LGEkDJsAn2yzygaS+yrdRhC3SU0ZfOKdi7RUg=; b=MKbPucJ3ryZDYZYOE3U7dT8PSY
	QEGF+3cQYn7EZgGeqBTY1Q540BkNg8kiQsLS5sQaKBr4ruzHHBCXhMol1he+TP4W+h48irke+JsgN
	+lVl44pi6J1ZSGTjvFEvieEMfPqEJzLJU3oRYwt0PJ4RgbVhZOIKB/K3ySnE7sonQ18VvLQLY2gSr
	REAGTiv+0zhPDJJLhxeqTyeZzi/CKq4aYfH/fBeh83mrb/Vlcpqzwz908ONu828lJG1+9e5RQGnAw
	8fV+sSGlSeFVr+Vw1A0Mn/tWsh1jp0l0HB7pBXdXx7cKI1RjPqvwkCmC3eMGclKu5kosRQo2KfJf7
	u5gvQifQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57212)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rrjo1-0007Gh-1a;
	Tue, 02 Apr 2024 20:28:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rrjo1-0007CU-NZ; Tue, 02 Apr 2024 20:28:25 +0100
Date: Tue, 2 Apr 2024 20:28:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 6/6] net: sfp: add quirk for another multigig
 RollBall transceiver
Message-ID: <ZgxcWTjONJgnOuyB@shell.armlinux.org.uk>
References: <20240402055848.177580-1-ericwouds@gmail.com>
 <20240402055848.177580-7-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402055848.177580-7-ericwouds@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 02, 2024 at 07:58:48AM +0200, Eric Woudstra wrote:
> From: Marek Behún <kabel@kernel.org>
> 
> Add quirk for another RollBall copper transceiver: Turris RTSFP-2.5G,
> containing 2.5g capable RTL8221B PHY.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

