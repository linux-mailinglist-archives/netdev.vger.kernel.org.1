Return-Path: <netdev+bounces-183874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00449A92635
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 20:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B244A01C2
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C362566DF;
	Thu, 17 Apr 2025 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Yho7JQOy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153B718C034;
	Thu, 17 Apr 2025 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913467; cv=none; b=Y6Z/3aUl2nTsDzA7yMqlc0vbaYxrjFjlpppF9rUZEkyd6wkfqBtaqvNk8ZkLt/ZbYO23P3y8+Mn3lmbaVf+wW7YpADqDCYVTCJ+rhePW4H3CK+hzNLTtJxwdmgh1H192JUaXZeNHA8AYiHs7ztrgkFhb7uD0Pf5YStUoQ7IbTjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913467; c=relaxed/simple;
	bh=FNJOavUKqvP5gonkka8SPdNbPtncJedVaRPBsPRzNOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ils+z1+Gq5/dH9nEvZXM07vMNUe872Douk7ADI1ARjrlIqAHYjyrasIH1GgcbGkiTREZdNb59vaBOs3CvnCSbaV4/64DLHi69iVvqGUjkAT92aR8f0BllM6u1Q2OjoqRovh1PSxCV7YC2cEaeA+kH3UVNvJRkYscIUVUyxUNhGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Yho7JQOy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rACPyzLfzjBAKxNw4xEGN0eJ6oVIpnK7ZYH00wZ3y8I=; b=Yho7JQOyU3R/liFGOVuB0Ckxom
	ANKDM1xdcYAn1/pWOkwZ/23CN/cuABVSO+zE7WJM1+D32dweyAXTgwKIP7cd1Rbnv0oEehqRLK9oC
	JVzfWq2wf79uVnlWqzKuhIaySZswb4rCraxIHXnGxDyw7SIDI+3E34/SyoYlUMSePe5M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5ThU-009of8-HT; Thu, 17 Apr 2025 20:11:00 +0200
Date: Thu, 17 Apr 2025 20:11:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thangaraj.S@microchip.com
Cc: netdev@vger.kernel.org, fiona.klute@gmx.de, andrew+netdev@lunn.ch,
	linux-usb@vger.kernel.org, davem@davemloft.net,
	Rengarajan.S@microchip.com, kernel-list@raspberrypi.com,
	linux-kernel@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v2] net: phy: microchip: force IRQ polling mode for
 lan88xx
Message-ID: <3c6abdaf-b4e4-440f-9d75-745741287007@lunn.ch>
References: <20250416102413.30654-1-fiona.klute@gmx.de>
 <fcd60fa6-4bb5-47ec-89ab-cbc94f8a62ce@gmx.de>
 <ebb1fe9a31abc4045b2f95072c6d3d94ee83239e.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebb1fe9a31abc4045b2f95072c6d3d94ee83239e.camel@microchip.com>

On Thu, Apr 17, 2025 at 02:17:20PM +0000, Thangaraj.S@microchip.com wrote:
> Hi Flona,
> We haven't observed this issue with our LAN7801 + LAN88xx setup during
> testing in our setups. Issue reported  specifically in RPI and NVidea
> with which we have not tested recently. Additionally, community
> discussions suggest that this issue may have been introduced due to
> driver updates in the LAN78xx. There's no hardware errata indicating
> any problems with the interrupts in LAN88xx.
> 
> If the issue lies in the interrupt handling within the LAN78xx, it's
> likely that similar problems could arise with other PHYs that support
> interrupt handling. This need to be debugged and addressed from LAN78xx
> driver rather than removing interrupt support in LAN88xx. 

Hi Thangaraj

It is an easily available platform. Maybe you can get one and try to
debug it?

This is a self contained simple fix. From a pragmatic standpoint, it
solves an issue which is bothering people. If you do find and fix an
issue in the LAN78xx this change can be easily reverted. So i'm
learning towards merging it.

	Andrew

