Return-Path: <netdev+bounces-137583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99229A711C
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C9AB20AE3
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2C91EBA08;
	Mon, 21 Oct 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b8vcOpxU"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7651EABC4;
	Mon, 21 Oct 2024 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532037; cv=none; b=qW0EDYBRVsnPgSBeT++uyiGWXDyeyz7ON0xfb4rfzBtTTYr/5wgUrcDKfzg0h847vKa29zSjHDMUEaZiP4H9Gii/GFFo48DfcnZEqVoQ7KOuf0RgdYAlMg4OTVRa9v9RpAwSA7tAoq6AnKv8fOnav60l4zVv55zcBGyXIVY40Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532037; c=relaxed/simple;
	bh=0BX5ye4uZiCaRI8uVOg4Db78leJWxE2sRuvRzXmmbH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ged1M53ybDC4eC8BDceHnAsQDcj83mMIAwADOHFVmB8YWwaPBPOX1yA42BYe4KtO7z70eMtlHNNn2H3pIpZaNI6rsHAjOWWYDEiy777tNCX+bSv6yqD5a4VcjayJMIf8RDF7Ou4wyCdV2vx6XuNv9oiWQbfOGvuTRS9mfgr5K1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b8vcOpxU; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2514220004;
	Mon, 21 Oct 2024 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729532032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MaX199Fe4JfeRIaLriBDyMlENqkxgT9mj03plpAUcs=;
	b=b8vcOpxUOqkvXvlW4E6uo4uhuj8dmNLMYbV4ZPzueVPwRlg4uqmbdkOV15bonawranp5Q0
	j1OiENoBYDckFqlcoKsglnrPJs+ccvsnTcABD8JmpXiOmXdR/C4twSTWJL7QEOfBwliBKQ
	y1xE0r9jGrOUAuLnCE0rme9tqm+Y+Z8g5hV8QiiJ0YOQFpMP+JlLdjMiaQw87Pdq1+MObq
	ec9eDtrUavWhhsbCGG3+kc+HnzUqwV8XoRHXODoN2jz3uK5uBjGfiIM6WNwYjM1Kdv15dw
	guDNO6ORQltp9QHMDVzqEfgzG84jQuY8HAny69ux2ti1Ws+bHdhxYPllnuCg2w==
Date: Mon, 21 Oct 2024 19:33:48 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, <andrew@lunn.ch>, Lars Povlsen
 <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, <horatiu.vultur@microchip.com>,
 <jensemil.schulzostergaard@microchip.com>,
 <Parthiban.Veerasooran@microchip.com>, <Raju.Lakkaraju@microchip.com>,
 <UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, <jacob.e.keller@intel.com>,
 <ast@fiberby.net>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 05/15] net: sparx5: add registers required by
 lan969x
Message-ID: <20241021193348.7a2423db@device-21.home>
In-Reply-To: <20241021-sparx5-lan969x-switch-driver-2-v1-5-c8c49ef21e0f@microchip.com>
References: <20241021-sparx5-lan969x-switch-driver-2-v1-0-c8c49ef21e0f@microchip.com>
	<20241021-sparx5-lan969x-switch-driver-2-v1-5-c8c49ef21e0f@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Daniel,

On Mon, 21 Oct 2024 15:58:42 +0200
Daniel Machon <daniel.machon@microchip.com> wrote:

> Lan969x will require a few additional registers for certain operations.
> Some are shared, some are not. Add these.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

[...]

> +#define PTP_PTP_TWOSTEP_STAMP_SUBNS_STAMP_SUB_NSEC GENMASK(7, 0)

I understand that this is partly autogenerated, however the naming for
this register in particular seems very redundant... Is there any way
this could be improved ?

Thanks,

Maxime


