Return-Path: <netdev+bounces-42945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A827D0BB2
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94C2FB213AD
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3900712E5A;
	Fri, 20 Oct 2023 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ectl4/47"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D99C12E50
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:27:35 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CEA1A4
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nHIYJRLaF3SkErQm7S9JMB2s5/+hk646RDQ05q00TSk=; b=ectl4/47sNC5gMSfXCkVu+/e5u
	RLO6QRrSow/sTNSQ0dDz/QnLx5sQIAaETC9gmLuN1qEhH7WoLaYOgjDw4rbi4O9jC2RUki+vSpoFA
	XIeJnlaZYre/KlxeqgJbUKRDxq/76cpJK5UVRpTmEmUN0XhsQYsn0R+tTxJ6Baahc5t4ozpWYR1/7
	3jmGFRsjTkIan6XD08+udiwB83VVk5DvqwWPkizPDgxo8ZdOpPgHuyNZja+j4uGNkJ9tYIb02Is7I
	JdUssGURmy9knHSu/4AvwEvPqeWs0TzZ9FZ43wEkkChfUH+aej/02oQGoK0w4y2rJsxX0ns9oGkMF
	5wbvE7zg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34256)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qtlmx-0000A0-2d;
	Fri, 20 Oct 2023 10:27:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qtlmx-0001Pr-Um; Fri, 20 Oct 2023 10:27:27 +0100
Date: Fri, 20 Oct 2023 10:27:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew@lunn.ch, paul.greenwalt@intel.com, hkallweit1@gmail.com,
	gal@nvidia.com
Subject: Re: [PATCH net-next] ethtool: untangle the linkmode and ethtool
 headers
Message-ID: <ZTJH/7wVyeOtU8sH@shell.armlinux.org.uk>
References: <20231019152815.2840783-1-kuba@kernel.org>
 <20231020092429.3pitbl3s6x6aonss@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020092429.3pitbl3s6x6aonss@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 20, 2023 at 12:24:29PM +0300, Vladimir Oltean wrote:
> On Thu, Oct 19, 2023 at 08:28:15AM -0700, Jakub Kicinski wrote:
> > +EXPORT_SYMBOL_GPL(ethtool_forced_speed_maps_init);
> 
> Is there a rule for EXPORT_SYMBOL() vs EXPORT_SYMBOL_GPL()? My rule of
> thumb was that symbols used by drivers should get EXPORT_SYMBOL() for
> maximum compatibility with their respective licenses, while symbols
> exported for other core kernel modules should get EXPORT_SYMBOL_GPL().

Author preference also comes into it - whether the author wants to
permit their code to be used by non-GPL compliant modules or not.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

