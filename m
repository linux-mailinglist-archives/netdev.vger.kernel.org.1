Return-Path: <netdev+bounces-124259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB8E968B55
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 17:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2C3283C52
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 15:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E2D1A2644;
	Mon,  2 Sep 2024 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BLb9kldY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B08919C56C;
	Mon,  2 Sep 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725292501; cv=none; b=XdZ5MDpACNUdhVRpW4KVjETeALqxxvgqVp9X+zpqFdLEvRq3NhRc79/gULFi+Rpb4TJw9eJAG+qa3JCZul2xkFR5jwMQmQR6yHeZani9NKvqQC2IE/78uInPjC255jr/hYa99PaGN/uRNmEZvkkqK+bBJJERX/dXH/40iZzbvUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725292501; c=relaxed/simple;
	bh=W/xuptGRbV4Sta5+zWRxtJ8HbNOrxMdE1aDntuFuW9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZmyTY08kOsLw9bbSSqL4m24nl1KBW4TDnjwqiCha2RH9G9XmHCGENQvqtGKpc3iDQoD6R1BYFp0h2Thk1WvQq5rtwqCSK33y8RvxutvvHiYy/rwWETM+G2Hc/LC7xN+D4tgoK0SyK3wRSixDt+OIxnlw3M9/rPVK57yZDduEC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BLb9kldY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=x1eoTY6nHgsVtDgloKZ7fEv9JM6K2UkHo+s4RRCHqdk=; b=BL
	b9kldYvt5PNOX53VO/yP4sIDwUtj+596XKWBEh3zLa7wiFzTHQkGkWIO6duc5Ir+xx4w/fzUho5dL
	YOC2tJnDQ05diGmuZxo6PaoTSgjEodRj4BNsD6rZBJoEJrXLVg7TmCGHdMP9I4VXpsLyArsOIE7Xt
	FSeyj2YdSG7ozQg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sl9O2-006K0u-Lc; Mon, 02 Sep 2024 17:54:38 +0200
Date: Mon, 2 Sep 2024 17:54:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wentai Deng <wtdeng24@m.fudan.edu.cn>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>,
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5p2c6Zuq55uI?= <21210240012@m.fudan.edu.cn>
Subject: Re: [BUG] Possible Use-After-Free Vulnerability in ether3 Driver Due
 to Race Condition
Message-ID: <9bf91769-2f71-495a-9095-349ec19251e7@lunn.ch>
References: <tencent_4212C4F240B0666B49355184@qq.com>
 <ZtWD+/veJzhA9WH2@shell.armlinux.org.uk>
 <tencent_50BA792913CC5DFE57798C1F@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_50BA792913CC5DFE57798C1F@qq.com>

On Mon, Sep 02, 2024 at 07:37:41PM +0800, Wentai Deng wrote:
> Apologies for sending the email in the wrong format. I'll correct it and resend it shortly.

Please don't top post.

>   ------------------ Original ------------------From:  "Russell King (Oracle)"<linux@armlinux.org.uk>;Date:  Mon, Sep 2, 2024 05:23 PMTo:  "Wentai Deng"<wtdeng24@m.fudan.edu.cn>; Cc:  "davem"<davem@davemloft.net>; "edumazet"<edumazet@google.com>; "kuba"<kuba@kernel.org>; "pabeni"<pabeni@redhat.com>; "linux-arm-kernel"<linux-arm-kernel@lists.infradead.org>; "netdev"<netdev@vger.kernel.org>; "linux-kernel"<linux-kernel@vger.kernel.org>; "杜雪盈"<21210240012@m.fudan.edu.cn>; Subject:  Re: [BUG] Possible Use-After-Free Vulnerability in ether3 Driver Due to Race Condition

You have also mangled Russels reply. Plain text only please.

	Andrew

