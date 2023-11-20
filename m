Return-Path: <netdev+bounces-49283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9CE7F17EB
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 16:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA40F2826C0
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD5B1DA30;
	Mon, 20 Nov 2023 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yjvQIh0F"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA521A7
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 07:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xG7MmkhhfDASThdLFI7jdgsl+nkmbg8g3VVsC+Rw/3A=; b=yjvQIh0FOXAmL5mMJvOy7gZm6G
	bvm/LnwnGmMMyADy8vrtmVZrblKwp3Ho7/MXqX8/g+/kfv+eR5ogoBUNSzoj8Sbq+8S7692v6indO
	ZxdUndnuBntK7ImW1yvqYNHaq0f1U+tmuZgOhd7wQ12EyrblNy4AHlCJDFv+/hPWLmq4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r56bo-000f3Z-Rm; Mon, 20 Nov 2023 16:54:48 +0100
Date: Mon, 20 Nov 2023 16:54:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: HeinerKallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S.Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor.dooley@microchip.com>, netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [RFC] support built-in ethernet phy which needs some mmio
 accesses
Message-ID: <e3337e9e-a53d-4480-9a99-4594625450a1@lunn.ch>
References: <ZVoUPW8pJmv5AT10@xhacker>
 <b8c29d27-e0a2-4378-ba5f-6d95a438c023@lunn.ch>
 <ZVtnRHsnDd+ZdZpq@xhacker>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVtnRHsnDd+ZdZpq@xhacker>

> Per my understanding of the vendor code, it reads calibration data from
> efuse

Linux should have an API for accessing efuse data. So please make use
of that.

What address space is

#define REG_EPHY_TOP_WRAP 0x03009800
#define REG_EPHY_BASE 0x03009000

in? Is this range dedicated to the PHY? Is it within the MAC address
space?

Does the datasheet describe the PHY pages? I'm wondering if you can
access the same registers via MDIO?

Where is the MDIO driver? Since this is integrated into the silicon,
it could be MDIO is not actually MDIO and is much faster. If you can
access the same registers via MIDO, that would be the cleaner way to
do it.

   Andrew

