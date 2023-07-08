Return-Path: <netdev+bounces-16230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ACC74BF4B
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 23:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56291C20902
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 21:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CF2C126;
	Sat,  8 Jul 2023 21:31:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4566E10E3
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 21:31:13 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164381BC
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 14:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ggO8L1SifCe+XRN5jHnP7YK+zgnYTgcGXOxBRe2wIK8=; b=MIdFnjq/6gLUHPrSvofGFdZSMN
	ZlqSrgv/llMbM/48CPdgj4ieRXz2TO7d48qa3ipsjjpxmoUlJsD6ynCNOfuqFGUAi18XeL1hbCCj+
	jGXWNm+jEyXTHk3odWf8lyLRzezBfJuWAeypEvETyAjfGZ08MdONUia5UQuLpYJYJCWI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qIFWE-000pmL-A0; Sat, 08 Jul 2023 23:31:06 +0200
Date: Sat, 8 Jul 2023 23:31:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vivien Didelot <vivien.didelot@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH net] dsa: mv88e6xxx: Do a few more tries before timing out
Message-ID: <80ab086d-3e6c-4a69-a7ca-82acaf37ad25@lunn.ch>
References: <20230708212030.528783-1-linus.walleij@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230708212030.528783-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 08, 2023 at 11:20:30PM +0200, Linus Walleij wrote:
> I get sporadic timeouts from the driver when using the
> MV88E6352. Increasing the timeout rounds solves the problem.
> Some added prints show things like this:
> 
> [   58.356209] mv88e6085 mdio_mux-0.1:00: Timeout while waiting
>     for switch, addr 1b reg 0b, mask 8000, val 0000, data c000
> [   58.367487] mv88e6085 mdio_mux-0.1:00: Timeout waiting for
>     ATU op 4000, fid 0001
> (...)
> [   61.826293] mv88e6085 mdio_mux-0.1:00: Timeout while waiting
>     for switch, addr 1c reg 18, mask 8000, val 0000, data 9860
> [   61.837560] mv88e6085 mdio_mux-0.1:00: Timeout waiting
>     for PHY command 1860 to complete
> 
> The reason is probably not the commands: I think those are
> mostly fine with the 50+50ms timeout, but the problem
> appears when OpenWrt brings up several interfaces in
> parallel on a system with 7 populated ports: if one of
> them take more than 50 ms and waits one or more of the
> others can get stuck on the mutex for the switch and then
> this can easily multiply.

This is one of the classic bugs i keep an eye out for, and point
developers to iopoll.h to avoid it.

As you say, sleep() or a mutex can take a lot longer than expected, so
the loop exits with ETIMEDOUT, but in fact the operation is
successful, but not noticed.

The correct fix for this is after the loop, there should be one more
read of the register and a test on the condition. Only if that fails
then return -ETIMEDOUT.

	Andrew

