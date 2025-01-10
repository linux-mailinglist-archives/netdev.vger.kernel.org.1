Return-Path: <netdev+bounces-157223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 651CEA097D8
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 17:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F0717A33B3
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21472212D6E;
	Fri, 10 Jan 2025 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="018NUieo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84875212D71;
	Fri, 10 Jan 2025 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527836; cv=none; b=po04qLX9BGTZiWiKcJ02zKQ8ZrzYSqYKPNYF5MVHI6A9vDDihyeCuSgAeSJFPpomQGBL8HDaP42zLS5LZ5g2AkLqtD4N3fnOSTCGTeMulNo6xEYTJ70Km6yYrZp1nRmwabucvRBiypxxF5AEprPpCMgl9GTVDrF81xci23V+OjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527836; c=relaxed/simple;
	bh=VW19Ukcfi8DdlvR2Va18dTjYRCJhQh2I8OvhcKN/YZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wgp9wLkmZLLDkO2Nr4SX6LwHq/XS2zB9j/drc407SIqC65+7E9bTsod7ExLrhNaOBNkWjhOX7ou3CUd4vBguSoTL72m4dO6Wq+FFjPskuIymdB/1fKFfr22CMcfAxiv49pp54xPxtLd62IreYhmXJWNTLufA0M8DQCEhRfS61as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=018NUieo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XOMXxniFu4gUDozNNwxOxjsn1q3ijRVKWGVVwdFZszc=; b=018NUieoxXIUiP1LSQIFIwiWLX
	iSTdvRvVEN+CZxBU7cN6F7IjDN1gdkOWX5fnZQKTVMqNSQVGm7G36h9NJTxugVsXjY87xjoLPhW6S
	xGRFPV8gGH7v/4pSC2Yp6MQycIwWUmxP4Xxl4jsoQnryWdoqdsL6KggRnxWlNH3vAPbo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tWIDE-003IL6-Cs; Fri, 10 Jan 2025 17:50:20 +0100
Date: Fri, 10 Jan 2025 17:50:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Xiangqian Zhang <zhangxiangqian@kylinos.cn>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: motorcomm: Fix yt8521 Speed issue
Message-ID: <96c446f0-3134-4e91-871b-3a9b4c02738a@lunn.ch>
References: <20250110093358.2718748-1-zhangxiangqian@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110093358.2718748-1-zhangxiangqian@kylinos.cn>

On Fri, Jan 10, 2025 at 05:33:58PM +0800, Xiangqian Zhang wrote:
> yt8521 is 1000Mb/s after connecting to the network cable, but it is
> still 1000Mb/s after unplugging the network cable.

If you look at genphy_read_status() it does:

        phydev->master_slave_get = MASTER_SLAVE_CFG_UNSUPPORTED;
        phydev->master_slave_state = MASTER_SLAVE_STATE_UNSUPPORTED;
        phydev->speed = SPEED_UNKNOWN;
        phydev->duplex = DUPLEX_UNKNOWN;
        phydev->pause = 0;
        phydev->asym_pause = 0;

and then reads the status from the hardware and sets all these. You
might want to make yt8521_read_status() more like
genphy_read_status().

	Andrew

