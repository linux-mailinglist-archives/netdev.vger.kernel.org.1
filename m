Return-Path: <netdev+bounces-210889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C91FB154C9
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 23:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C08716E065
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 21:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C33B2288EE;
	Tue, 29 Jul 2025 21:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Yk5kOHIl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5CD21E0B2;
	Tue, 29 Jul 2025 21:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753825518; cv=none; b=WAklpPMgDcvHPJJS1RbgyTapPcQkVM9ZdtwxszE/sByG+4579A/rC5EE2nVrPJYVl2Ai68T9HYmmnxDYpu8xHGHsbTwJoCPI0DupyOUMCX3CWPgcZgxDOnOYxmyZVx3dj/8BWPCMvD/15PruMvIinkzUQQSX/iyekmm6eBBhx7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753825518; c=relaxed/simple;
	bh=0eTWygk7sJUGmlzICVrrEKhs549JkRr4pu1uxSB1WmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CL1g+/+idVWajA9BArTe2F0QCbbQxwvuGPeCR1+yj3TNg/ql++zZYO5yOAHmVibl2fJWrbZ+xF5EBP09z7THViMLM1nG6ILifjSd5Bl/xBlT5crOTZixTYrbY+ylOLzB+ysot3zth++UU1IPowA0PtelWT/FpUQjsdI5e95wDNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Yk5kOHIl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Wf/0uZWB4TN7Fbn1MCE47FdY12dXgDlIhEUAvFCkfX8=; b=Yk5kOHIl0CLrboS9EJbYvPpeSc
	k6mNYiPGw10mcTYl2R0LlVmtxGn6x5Ib1V3bCdw6TsAlDfC4vlv30lP1XUPv5+IrbZSfm14BCVv0b
	TsgH1A5agj+hZV6Oymoe5FrNPRb1l0UkIbuoCJKR5oDNaOWZl0YLLio6sfkxKRAyJ1YY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugs82-003EPg-Ro; Tue, 29 Jul 2025 23:44:58 +0200
Date: Tue, 29 Jul 2025 23:44:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Chukun Pan <amadeus@jmu.edu.cn>,
	"alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"heiko@sntech.de" <heiko@sntech.de>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"ziyao@disroot.org" <ziyao@disroot.org>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add RTL8367RB-VB switch to
 Radxa E24C
Message-ID: <fdb2e6f0-3732-49ee-b11d-e82f9a9cb2e9@lunn.ch>
References: <5bdd0009-589f-49bc-914f-62e5dc4469e9@kwiboo.se>
 <20250729115009.2158019-1-amadeus@jmu.edu.cn>
 <db1f42c3-c8bb-43ef-a605-12bfc8cd0d46@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db1f42c3-c8bb-43ef-a605-12bfc8cd0d46@kwiboo.se>

> > I did a test today and the same problem occurred when running the new
> > kernel on my rk3568 + rtl8367s board. This problem does not exist on
> > older kernels (6.1 and 6.6). Not sure where the problem is.
> 
> I had only tested on a next-20250722 based kernel and on a vendor 6.1
> based kernel. And similar to your findings, on 6.1 based kernel there
> was no issue only on the newer kernel.
> 
> I will probably drop the use of "/delete-property/ snps,tso" and include
> a note in commit message about the TSO and RX checksum issue for v2.

You are submitting a patch for todays kernel, not a historic
kernel. If todays kernel needs this property to work, please include
it.

You can always remove it when you have done a git bisect and find what
changed, and submit a fix.

	Andrew

