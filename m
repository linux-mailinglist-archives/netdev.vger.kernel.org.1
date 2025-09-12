Return-Path: <netdev+bounces-222732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C8AB55829
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 23:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23FC37B69C2
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C132ED2D;
	Fri, 12 Sep 2025 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6VHkYe/G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58A632ED36;
	Fri, 12 Sep 2025 21:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711565; cv=none; b=rSlTsTGpCpckJGWr+joKr43y1HB7mmh9t+kTFe4AuW/UQcWN2WpYOzCcMwldBY+pucOgFAi+8PWD0zPqRfZ18PHSH5vEjfUQcm9ohmyWtxbizYB00bZHHpteS4zIJjEGS6ULDkk1mhu7McdLoaBpM0bnwimzpRrw6pdO7tXYRqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711565; c=relaxed/simple;
	bh=8jxxb85qmWzvjkyhjWnrJ+p44hlAdepIl+j8nK1q8kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ks02m0SaFhSZwkNUZrS3X9GQNmXOyiDsV+xXHmFukW7ox5xkEtNHbG/OdSPiLwA/79Oc4oCRx7oZuv6s9N2lpl3f/KemWGquH/gaZiTinkLKO7d1BSnKYi8yfIhQbs8bGA0YqUS4xhB1qd1mHVGessALsidq6a2bd7BFZUzOusw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6VHkYe/G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TfJdEgDmeeUA7mwuQnthygkn+bVIL1msXKFYrsESfP8=; b=6VHkYe/GCoc7e7EUIDpfMvO/7Z
	9sOIlLmXo0w9xUU4qPsIgcS+ZKdA7KvUn4YcVFP0B623GFQIVCpNC+doiq4PwPCrfpolT0ZwKhosJ
	Vy3Wm5f+8aC/p87emgEe8mQLfP3Z4m5bUHlxsn5d49S+m4QN7OTr0g0FRyma3DCuKHS8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxB4I-008G3r-H9; Fri, 12 Sep 2025 23:12:30 +0200
Date: Fri, 12 Sep 2025 23:12:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <uwu@dram.page>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11 5/5] riscv: dts: spacemit: Add Ethernet
 support for Jupiter
Message-ID: <12583aec-4499-4cc1-a487-9c7b8d8efb01@lunn.ch>
References: <20250912-net-k1-emac-v11-0-aa3e84f8043b@iscas.ac.cn>
 <20250912-net-k1-emac-v11-5-aa3e84f8043b@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-net-k1-emac-v11-5-aa3e84f8043b@iscas.ac.cn>

On Fri, Sep 12, 2025 at 02:13:57AM +0800, Vivian Wang wrote:
> Milk-V Jupiter uses an RGMII PHY for each port and uses GPIO for PHY
> reset.
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> Reviewed-by: Yixun Lan <dlan@gentoo.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

