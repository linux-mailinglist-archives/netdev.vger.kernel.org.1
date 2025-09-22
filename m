Return-Path: <netdev+bounces-225123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F018B8EB9C
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 03:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91021746B8
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 01:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAAE2EC571;
	Mon, 22 Sep 2025 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QQlSnQ5k"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DD1208AD;
	Mon, 22 Sep 2025 01:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758506275; cv=none; b=eOYn0ibxjSNFf16a9/xnv/6tUHvxzJ8/UWH0XNT8VnvThntOSPQajSqtq0KajmkbdPSNe94Pscd1R7PqgTripgkSL2rZ6WLCmFqqN0iHUY9iQV1m96Hefx3U3c962x6as9zaekK1PyljgLHD390pQuIUAgKzwXdHG48QfmuSApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758506275; c=relaxed/simple;
	bh=V70qingJdgV7VUB+BHW4xn9+IqR0FjMcf4Du5HU8h8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XujpHCXQM/q+ZE3Gkw5/+/EPSz+skYfLtRAcQ1gDHkD8HRtpE0LEH2narOld0FYUWYpZ9FZF7Py9wuHGl3N1t5WE9R0lwCSH/fNE1CaacuwEtUepth1OIAAkvVPYkI3yv8B7fJmB5svVwk5XLZjEhvx5JLQC2uPPzGkzgIiQbxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QQlSnQ5k; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fH
	MyTs/w/ZTvJwoPGVvxbzopLUnN4EQEOF9OChdeOug=; b=QQlSnQ5kHOpXbIZIGK
	uoa8WsM2JUx+UmiKD8ma63LZJu7OoLlf98yNlIsY0BsK7Ym4Fgfja2dOGh1VaIKU
	iYdmntwXFn+GLPA7YXGd+wfW009OTyBFYywlsV2rEVPCORBwG+urGqJTcbINkO9X
	8BVK+u0LFp9NVlEBfHrBNMRHc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3V5fjrNBoZ+knDA--.37351S2;
	Mon, 22 Sep 2025 09:56:51 +0800 (CST)
From: yicongsrfy@163.com
To: andrew@lunn.ch
Cc: Frank.Sae@motor-comm.com,
	davem@davemloft.net,
	edumazet@google.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: phy: avoid config_init failure on unattached PHY during resume
Date: Mon, 22 Sep 2025 09:56:51 +0800
Message-Id: <20250922015651.589429-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <df1f93ec-e360-4cb3-adf4-454f427851dc@lunn.ch>
References: <df1f93ec-e360-4cb3-adf4-454f427851dc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3V5fjrNBoZ+knDA--.37351S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw45Kr4xWFW3Ww48Cw4UArb_yoW8Jw1fp3
	WUuayjv3Z8GFW09rZ7Za1Yqa47AFWkZ3WYqr1rtwsY93s8uFyakr4xKa1xuF43XrySyw42
	vFZxAFWkGFZ8XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UcTmDUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbiUA-N22jNSgiZpwACsS

On Fri, 19 Sep 2025 14:45:12 +0200, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Since this issue cannot be fundamentally resolved within phylib,
> > we need to seek a solution within the PHY driver itself.
>
> How about this...
>
> Allow a node in DT which looks like this:
>
> mdio {
> 	phy@0 {
> 		# Broadcast address, ignore
> 		compatible = "ethernet-phy-idffff.ffff";
> 		reg = <0>;
> 	}
>
> 	phy@16 {
> 		# The real address of the PHY
> 		reg = <16>;
> 	}
> }
>
> The idea being, you can use a compatible to correct the ID of a PHY.
> The ID of mostly F is considered to mean there is no PHY there, its
> just the pull-up resistor on the data line. So the PHY is returning
> the wrong ID...
>
> of_mdiobus_child_is_phy() then needs to change from a bool to an int,
> and return -ENODEV for "ethernet-phy-idffff.ffff", and the caller
> needs to correctly handle that and not create the device.
>
> I would also suggest the PHY driver disables the broadcast address
> when it gets probed on its real address.

Thank you for your reply!

Disabling the broadcast address from ACPI or DTS is indeed a good
approach. However, should we also consider upgrade support for
existing devices? After all, modifying ACPI or DTS for already-deployed
devices is not a simple task. In cases like this, do we need to focus
solely on solutions implemented within the driver?


