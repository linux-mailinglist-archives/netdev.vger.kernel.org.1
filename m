Return-Path: <netdev+bounces-143801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6C99C440C
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 18:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225C2281A77
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 17:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46311A707E;
	Mon, 11 Nov 2024 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N8lkIq2S"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B01A9B54;
	Mon, 11 Nov 2024 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347236; cv=none; b=T+gtw8NKZyLBmMCdtP8Zf/W9Cv+UV8jW8pNcOasg94uuTK+a/7A6uAoIABVikDwwQpoblYO7li+rjVC/cDuDXbXD7NFqeqkrS1l5/yjDWSs7TS/O04Iuru9eAe1S3lANbvmwohmET5LacIBK8JZuLNCVCuPFPNi8A2Xx07Qu/d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347236; c=relaxed/simple;
	bh=6o7Y6AjoEJTfB0Pt0S1MZ3TlB1oudScTrJGDdKppmRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/oVileYUtZ9rDFHsebfoTy0ExjED4u9BkbWIy7eVTkI0EImKxOEDaPHNOLBXi9FZTsbGvksjCqhVJpUSiFLaJUHD5TiXOsfwEg8ejLEhVnkxaIw1lw4nrR/Xq5J31SygKFq0ltdjCgObEVlc254ahHuN2uB3UAdmhpwsB6LztY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N8lkIq2S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gIt/WlnlFexXOHVGaOxVTI3ai2r+hICjY//L1yeJWoU=; b=N8lkIq2Sooi9cUizjghxKTkMC6
	J/h0zgIqRHH3kLAGXM7oeMpOYy6UTSaDhdF69BtBPodfPtFW4kPFJenU+KAOGr9bkPQUigHHYZZnX
	QxQg9EFvpDW2qm57sdS0ie4CnK5kiRF2B9jbUY/4igip+uxbf3gw/5VxKwGr2Xzilmb8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tAYVC-00CuxY-Sv; Mon, 11 Nov 2024 18:47:02 +0100
Date: Mon, 11 Nov 2024 18:47:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: =?utf-8?B?546L5pix5Yqb?= <wangyuli@uniontech.com>,
	hkallweit1 <hkallweit1@gmail.com>, linux <linux@armlinux.org.uk>,
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>,
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5Y2g5L+K?= <zhanjun@uniontech.com>,
	"f.fainelli" <f.fainelli@gmail.com>,
	"sebastian.hesselbarth" <sebastian.hesselbarth@gmail.com>,
	mugunthanvnm <mugunthanvnm@ti.com>,
	geert+renesas <geert+renesas@glider.be>
Subject: Re: [PATCH] net: phy: fix may not suspend when phy has WoL
Message-ID: <3e486556-e654-4b3a-82c2-602c853788f0@lunn.ch>
References: <ACDD37BE39A4EE18+20241111080627.1076283-1-wangyuli@uniontech.com>
 <tencent_6056758936AF2CEE58AEBC36@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6056758936AF2CEE58AEBC36@qq.com>

On Mon, Nov 11, 2024 at 04:24:53PM +0800, Wentao Guan wrote:
> NAK

A NACK should include an explanation why. I see you do have followup
emails, i assume you explain why there. In future, please include the
explanation with the NACK.

	Andrew

