Return-Path: <netdev+bounces-131276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD9298DFDA
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C611628783F
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6AB1D0E04;
	Wed,  2 Oct 2024 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Wpth8qxL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF1742AA2;
	Wed,  2 Oct 2024 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884449; cv=none; b=KDseMeUG/37v/1PA6gdTMrANc4+wuayYID5HgYvqP0GVkIexGefO9I6rEytqlza3QbrnAmVSVNy5uFEN+GkU8FVOn+Zce5MQKa2klZ/o648zqYDBxAj4odsvsOoDVlFqEZsIHzitKvL2QDVk9FHiUXlAR7ejNsm/ytgHtSrC2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884449; c=relaxed/simple;
	bh=vQVcZK1Av8yiZ4qC+q+ZlYOJgDwOgnPlSY5RQ1bQaiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAShT6jeH0tGxR6ykJvLQWAmdwq0hcq1Yej7oDWZqaKSL8A66km1sw4KOGNtJhoNlNtES0ubimpL6izhCDE63+PZM13mJxPQGStX3bA+h2tg1aXzReT4tPqxyLA2PKV85flinx2opMjEHEmclMOwAROEvMsgwu7atx4M/5YRtxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Wpth8qxL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oJP2Imcv5aMIXQ+KgAdnXlZEHbtqAUOCWAjBy2NQI5k=; b=Wpth8qxLecrOvSIzMGv2RSBbLZ
	rIN65BakXHmJdVZcwxva6MD8KVMsiD6raw1JBNDMfBMdM/wwjANgo3uJDUbOzebOCyC1+9b+xz0PE
	Geso08Ixuope6He4VCVW7bdJvv3aKpVpnZhbSttXFBwpYx/xSvOLAQA0Eqc+ew78S+1U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sw1fx-008sJV-Kz; Wed, 02 Oct 2024 17:54:05 +0200
Date: Wed, 2 Oct 2024 17:54:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ingo van Lil <inguin@gmx.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] net: phy: dp83869: fix memory corruption when enabling
 fiber
Message-ID: <5a7f9c77-9f46-486f-82e9-ab9fbc5c8f43@lunn.ch>
References: <20241001075733.10986-1-inguin@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001075733.10986-1-inguin@gmx.de>

On Tue, Oct 01, 2024 at 09:57:33AM +0200, Ingo van Lil wrote:
> When configuring the fiber port, the DP83869 PHY driver incorrectly
> calls linkmode_set_bit() with a bit mask (1 << 10) rather than a bit
> number (10). This corrupts some other memory location -- in case of
> arm64 the priv pointer in the same structure.

Please add a Fixes: tag, and base on net.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html


    Andrew

---
pw-bot: cr

