Return-Path: <netdev+bounces-220724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA5AB48602
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EDD53C54E7
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 07:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158B8293C4E;
	Mon,  8 Sep 2025 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SJ1yZtde"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AF127AC41
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 07:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317462; cv=none; b=mmVm/cRtHs2VZ3lB/UbUk7KV3RSw5aAs2odRk9PEDvbHlyNGDcm4oHphSVQ4NFn+yjy3jLavKW57inmeLCmffMk5LGN7ieB5ysCHiCUdppoLdUO1AxtFv/W6lZpCYFu4dWGY7LAOZZcscrZn+3r2pAKORtEqJzXzJXujOGkOM1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317462; c=relaxed/simple;
	bh=akTNLpbkdPJvdrgThACV85zDyNgz8o1xD4KEWNXeD2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHzPzZhGnEtbsi9QwPJo3ibGsYDn3Cj0aFsAfXmCBrfwFO9rULPmR6qkgammcfm4TPnis8AxIX1j72TOHbnP+LhnlID4HP5nKW/J6ucxxMLjzBhcgpIVUw7YriH/dMjPgo2zvJs2tbErzmggECp1socFVS6YpCEc2terIxPCS5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SJ1yZtde; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2F/7UgYWbSc33HP4imUY8mEzyNcN9plc1WDu7JCz+a4=; b=SJ1yZtdeM5FyVsQxdFqVSWuXBx
	SqOGKA9hQfjk8rDJipPrfyK09pdLK8OlmVMJEHgqhx6dB4FLbdccMHGqroiGcOxT/JC+oqhHp+VGk
	O6vlx3LK25bSfcdOXoks1xFXZo3o/FLO2unJtS1X4tWuMrCKAPWZ8mLntBXitTXU22xqBQNVkRqCi
	fBC2mi3ksCOyT1X8kRYd5Lyzm8oG+d+ZwbRktVz2qF2imSp6ytelZn03DkHjU9aOTIWWPRnXi54ef
	03IISpHko3dbHqWb+bqufIkbmm+xqd2B26LmxFeNOBkWh9wzDhOceFNuCgyiJryeWG2/H1tTTTRuU
	JPS4gGmQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34328)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uvWXs-0000000068T-3WCX;
	Mon, 08 Sep 2025 08:44:12 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uvWXp-000000007jn-0fhl;
	Mon, 08 Sep 2025 08:44:09 +0100
Date: Mon, 8 Sep 2025 08:44:08 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ilya K <me@0upti.me>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	hkallweit1@gmail.com, kuba@kernel.org, matt@traverse.com.au,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net 3/3] net: phylink: disable autoneg for interfaces
 that have no inband
Message-ID: <aL6JSEhTRh2q_Jxe@shell.armlinux.org.uk>
References: <E1uslwx-00000001SPB-2kiM@rmk-PC.armlinux.org.uk>
 <7e463b05-ae28-4a98-b8fa-bdff266aa62f@0upti.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e463b05-ae28-4a98-b8fa-bdff266aa62f@0upti.me>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 08, 2025 at 10:38:59AM +0300, Ilya K wrote:
> Hey folks, this seems to have regressed a different setup: I have a Banana Pi BPi-R4 connected to a dumb unmanaged switch with a 10GbaseCR cable, and it fails to negotiate a link with a21202743f9c applied. Reverting it makes things work again. It seems like phylink_get_inband_type doesn't handle base-R modes at all? I'll maybe have some more time to poke this myself later this week, but throwing it out there in case anyone more experienced has ideas.

10GBASE-CR (based upon BASE-R) has no inband signalling for
autonegotiation.

Please enable debugging in phylink and include this is any bug report.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

