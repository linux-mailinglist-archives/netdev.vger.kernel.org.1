Return-Path: <netdev+bounces-179640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF1FA7DF6E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367833A71E5
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9698113A86C;
	Mon,  7 Apr 2025 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pzDd6IgT"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F7B86352;
	Mon,  7 Apr 2025 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032730; cv=none; b=P9kpfOv+1jP5ryBEGMINr9uslaR9zi0tZxdf05eDqnH8yCv9ZkEYBPZg4fohimbictB3o/h/aOP+phRFaQy5hR7H/6EfPeto/ZfrEF2c+emWgKZnHYXWY1fq+leUJQtpnThPx6HmpOcw8x6mVWVtCslz8KV8k4hEd0FWGXwynMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032730; c=relaxed/simple;
	bh=CV1TYOC+Hc1Y1OftiZIoW2xzm1Py+waPZZku52ovkpg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HW0vkp//rk6VygH1k9llXOAiWK4Q95nZwmQJzib6OE8eXDeO1h/wJvLBdYiR0TuzXcAEEdD7PB4Uv24qV08YNYRxWw4LZDwN+HSocyawHhc0s6YN8z8EPEsbo0GUxKU/tq2I3zYwXOSJNyBu4rdEOUUItQqnXSfFzg4YdMjaK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pzDd6IgT; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E372D4431F;
	Mon,  7 Apr 2025 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744032726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FgBkAfF7LRh3OjsY0EeWJNc7q8ieecweD7h2bVdhnwU=;
	b=pzDd6IgTeal0WpkpWTMQcRZZo0sGBgmuBkicvVFeXcclqzMuD5Bre5csabultSvIrWabAA
	4NnsU8sG7lv2IVtGJO+5Lrki7OWFbmwlg+mJUn5a+teZdvkzZMZY+fpWtN39NQxSr6TvoK
	uWKdyRgv0FzDLExNQkJpuyH9HwEEyvGuz55mrWptmxrsS0/WVxt/4HSl8NGmIRHudi7leM
	vnHx+N6Jgb7zQQHFtvuERN6irFV564ds4WLSYWxZ4luMsUiHU64P7JXj8XB4iFYhXQL6dZ
	PXxWIKszN/4ZYtF5zbi776wpIW7oMq13jSf4rw9RU9BzCz3QQz49JFbxiwJ9HA==
Date: Mon, 7 Apr 2025 15:32:03 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Marek Pazdan <mpazdan@arista.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de
 Bruijn <willemb@google.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Mina Almasry <almasrymina@google.com>,
 Edward Cree <ecree.xilinx@gmail.com>, Daniel Zahka
 <daniel.zahka@gmail.com>, Jianbo Liu <jianbol@nvidia.com>, Gal Pressman
 <gal@nvidia.com>
Subject: Re: [PATCH 1/2] ethtool: transceiver reset and presence pin control
Message-ID: <20250407153203.0a3037d7@kmaincent-XPS-13-7390>
In-Reply-To: <20250407123714.21646-1-mpazdan@arista.com>
References: <20250407123714.21646-1-mpazdan@arista.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepmhhprgiiuggrnhesrghrihhsthgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhnthgvlhdqfihirhgvugdqlhgrnhesl
 hhishhtshdrohhsuhhoshhlrdhorhhgpdhrtghpthhtoheprghnthhhohhnhidrlhdrnhhguhihvghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepphhriigvmhihshhlrgifrdhkihhtshiivghlsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
X-GND-Sasl: kory.maincent@bootlin.com

On Mon,  7 Apr 2025 12:35:37 +0000
Marek Pazdan <mpazdan@arista.com> wrote:

> Signal Definition section (Other signals) of SFF-8636 Spec mentions that
> additional signals like reset and module present may be implemented for
> a specific hardware. There is currently no user space API for control of
> those signals so user space management applications have no chance to
> perform some diagnostic or configuration operations. This patch uses
> get_phy_tunable/set_phy_tunable ioctl API to provide above control to
> user space. Despite ethtool reset option seems to be more suitable for
> transceiver module reset control, ethtool reset doesn't allow for reset
> pin assertion and deassertion. Userspace API may require control over
> when pin will be asserte and deasserted so we cannot trigger reset and
> leave it to the driver when deassert should be perfromed.

nit: performed

ETHTOOL_PHY_G/STUNABLE IOCTLs are targeting the PHY of the NIC but IIUC in =
your
case you are targeting the reset of the QSFP module. Maybe phylink API is m=
ore
appropriate for this feature.

You have to add net-next prefix in the subject like this [PATCH net-next 1/=
2]
when you add new support to net subsystem.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

