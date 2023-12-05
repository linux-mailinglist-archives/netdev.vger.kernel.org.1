Return-Path: <netdev+bounces-53986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3921680584E
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F19281D43
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B8067E99;
	Tue,  5 Dec 2023 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="S+f1b+wg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CD1183
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 07:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ST7xwQ06frK1zNZ8hAvcBA13z9LtRNf0hBcM9I3b+VU=; b=S+f1b+wgIzKS0p3b0J8+dD2yHC
	4mt+dlSAi5IqHrBNa/XmZ3X8zCaAfVJivIJTKwGg50ynqgr69z/p9kik3uqb71vCP7VbhxFob4KXY
	NTmq/Zu6DFKKycmhUKDUqIrvEeHzotc64uxV5pwjsQIRnX1VYRcfxBo8MkSw15M7tdWk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rAX5b-0026ik-RJ; Tue, 05 Dec 2023 16:11:59 +0100
Date: Tue, 5 Dec 2023 16:11:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/3] net: mvmdio: Avoid excessive sleeps in
 polled mode
Message-ID: <2c385c4b-def5-4f43-a35c-68152107f19c@lunn.ch>
References: <20231204100811.2708884-1-tobias@waldekranz.com>
 <20231204100811.2708884-3-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204100811.2708884-3-tobias@waldekranz.com>

On Mon, Dec 04, 2023 at 11:08:10AM +0100, Tobias Waldekranz wrote:
> Before this change, when operating in polled mode, i.e. no IRQ is
> available, every individual C45 access would be hit with a 150us sleep
> after the bus access.
> 
> For example, on a board with a CN9130 SoC connected to an MV88X3310
> PHY, a single C45 read would take around 165us:
> 
>     root@infix:~$ mdio f212a600.mdio-mii mmd 4:1 bench 0xc003
>     Performed 1000 reads in 165ms
> 
> By replacing the long sleep with a tighter poll loop, we observe a 10x
> increase in bus throughput:
> 
>     root@infix:~$ mdio f212a600.mdio-mii mmd 4:1 bench 0xc003
>     Performed 1000 reads in 15ms
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

