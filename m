Return-Path: <netdev+bounces-221255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64900B4FE7A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D019D177813
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C976341AD2;
	Tue,  9 Sep 2025 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Osbt3t+/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E57833A03C;
	Tue,  9 Sep 2025 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426325; cv=none; b=geBrPc7K45EltFz45oUt54QC+092KL4U+OV+mRYla2sZk0Igd9aWPfP5GpiNsV35ZR3DW2BGus6yLuofH7UpgA165ihTSLLZ8y08jLDestMdYHz5X9y4tTLY8SHudyqiIff9HcrHALSaL/GT+1HuNohHnAF4Pxo+wFYsk2F+UdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426325; c=relaxed/simple;
	bh=vy2q0WtlTEsHbNNB1OCP5cdUEdRjao2vbNYPMs7jNhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac+ilhUkUmeVze5P58f2xB3kBt8OeZPvkvF/RJ6accarALK2skEyo/9mroUQbsZvmsSwOzngEw5Ik6N1F8lqYYFOX63xHKjbtuWTO2B6itx5aV1mEFH/xsv3cpxBYjxoKWU7fby/CB77PrKbvKjC6nyFL/wGpjsS88yUk/9vXGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Osbt3t+/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nYWquA8EghEXnLFrYzKrD0IKG42ZHu7qiELK/AGf2ew=; b=Osbt3t+/+hCGF/MPNQ3f/+PD/g
	wnQdF8eKhZDvw/jPSSFz1TqQES7/b617RBtCzsIyVaG2lwANRNVcTMoBff35yVA5v57/FyCoO/9mC
	fxIPOFC5h0ts7BfwKz9BFauq9iSq4qT94fbL11S3i81NAlEpcjDd9ghFQ1oTt/o4Y684=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uvyrg-007nth-Ak; Tue, 09 Sep 2025 15:58:32 +0200
Date: Tue, 9 Sep 2025 15:58:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] net: phy: clear EEE runtime state in
 PHY_HALTED/PHY_ERROR
Message-ID: <5078fdbe-b8ac-430a-ab5d-9fa2d493c7da@lunn.ch>
References: <20250909131248.4148301-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909131248.4148301-1-o.rempel@pengutronix.de>

On Tue, Sep 09, 2025 at 03:12:48PM +0200, Oleksij Rempel wrote:
> Clear EEE runtime flags when the PHY transitions to HALTED or ERROR
> and the state machine drops the link. This avoids stale EEE state being
> reported via ethtool after the PHY is stopped or hits an error.

One obvious question, why is EEE special? We have other state in
phydev which is not valid when the link is down. Are we setting speed
and duplex to UNKNOWN? lp_advertising, mdix, master_slave_state?

So while i agree it is nice not to show stale EEE state, maybe we
should not be showing any stale state and this patch needs extending?

	Andrew

