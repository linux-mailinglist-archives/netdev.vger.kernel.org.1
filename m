Return-Path: <netdev+bounces-187861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CB4AA9EBE
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 00:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E143B5394
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 22:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CCB274FF8;
	Mon,  5 May 2025 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BfL3hmzp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B113AF2;
	Mon,  5 May 2025 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746482723; cv=none; b=ircdaHqaSpAGxK7me0hQnvvOLCBFER1CrQjXWKMsmRyUjhUD8scgk8CRzE/NcadEoijhN5cv16Js5Kf9IXbZxNpyv8IVB/z03ueZ0HkHWzlQLXuSZk5PVkWEN1z/QDHTzM0A12JaOURbdpMZ7uFj/PwDI5mavwFgxJOCqh6mf1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746482723; c=relaxed/simple;
	bh=IcH+kFFKNJEttIlni6BtPWD7JxTQica0GiYy4Ea2eJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkDggN5S3wZpdznM2fcqmZnvdyxwV/SyHQI1v5FSB9bB2QBJmzVD9XNWmkeuXp0xOsFT55Skx08WxCmtJNToow5BftaZhwcHP/dbtyUDD/WZ1n7TX7GrxtcAJY9r4rPQfRIVPQm6DGQHCrEX0HDJV+LVOatnjaOhaK5FIdyWkYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BfL3hmzp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Al3ttpxqk7lpqbfhltra66AcN7imVV0ima0VDtkjJdo=; b=BfL3hmzp2UtBbL3ZW7H1VVLTta
	AN+6xj8cSbSTfY3ZKH72CGcBMtnBjWXtexRrsbzbs0KmktH8UgqJSWB1PDx4u3uvXFK6RtfAwfd9y
	lvo2zBOb3wtoXZeHnS8EcbadSyRrsX34GLjQo9kMFzrnHdIvA4PJB8jmnRnUIOxW0Na8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uC3vy-00Bdn3-Nn; Tue, 06 May 2025 00:05:10 +0200
Date: Tue, 6 May 2025 00:05:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Klein <michael@fossekall.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v7 2/6] net: phy: realtek: Clean up RTL821x ExtPage
 access
Message-ID: <3b84469c-8ea3-4355-89f6-7efb90b8bc7e@lunn.ch>
References: <20250504172916.243185-1-michael@fossekall.de>
 <20250504172916.243185-3-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504172916.243185-3-michael@fossekall.de>

On Sun, May 04, 2025 at 07:29:12PM +0200, Michael Klein wrote:
> Factor out RTL8211E extension page access code to
> rtl821x_modify_ext_page() and clean up rtl8211e_config_init()
> 
> Signed-off-by: Michael Klein <michael@fossekall.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

