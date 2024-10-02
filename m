Return-Path: <netdev+bounces-131128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3518B98CDA3
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4EBB20B1C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 07:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BFA44C94;
	Wed,  2 Oct 2024 07:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N0xztkUS"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325DE1754B;
	Wed,  2 Oct 2024 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727853351; cv=none; b=RxTKAAu/k2JogTeRAkVSyx1Ka7DegQSfMZS0CkWtvAwVq83AToB5Eu19ejBd21vHL4Yhu0D7tP0955UaMnLPAMW4+WFWXFPiqQCr8hl1s12P/4VfPL3T2MiA2XoL9fHyRizasOw8rWUzzdPulICEGnTC2e+F/bCleoPELJpSNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727853351; c=relaxed/simple;
	bh=wgAiDjBNhZKyiHvZDW0el42TknozZeiQFDHdDKom/Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Muonlosg1YCS+xwjxKkeWjfCUoGXLZhHovYORiRLLLCRduIlOxCiby4ntCrewxx9087L7PZQv4ieDzq+9gOEi8kN62CkRSHCDumFznF5jOY1xR1UQtGLy7cLDbKyittySBzsR9Q1BzfTWUUJRBD/dK7/WWKujCLVtaauYzScEI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N0xztkUS; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4DC711BF203;
	Wed,  2 Oct 2024 07:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727853341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ldCHVS3FEfOPPFpKf7kx2hWQN/PgnAT3J7DGkLeX0g=;
	b=N0xztkUSzyVrrTFULorUipRYEB/NL/xS46MrKZRMtnzjzNFHYO1oe35pF8WJ5yQJbckZe7
	aXiOWk4WlwlKloItYUMyJDqI4y4a/b2XfAZqTPGoaRx/saaDU73yGapduB96zF2WBIIa12
	pMvufikz+zLyxTndbM08jq6JUf99+2KyZG3XUPzF6N3WIfXtZ6ZClT5ZPY3lKG8x0FfEv2
	GU3TLSXzdV5CdnsFHJGtgsGqZoPsOg7C5JIgGzz4gUNRF0SAC0AwoCM3MhwzFhrfxMWisC
	fh0gRQCSb0mzB1KoCymz4iUuKUny5r3O9aWjvk+J93Rn+LtuOrfyJu2T2ARnBQ==
Date: Wed, 2 Oct 2024 09:15:39 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, claudiu.manoil@nxp.com
Subject: Re: [PATCH net-next 1/6] net: gianfar: use devm_alloc_etherdev_mqs
Message-ID: <20241002091539.73177c18@fedora.home>
In-Reply-To: <20241001212204.308758-2-rosenp@gmail.com>
References: <20241001212204.308758-1-rosenp@gmail.com>
	<20241001212204.308758-2-rosenp@gmail.com>
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

On Tue,  1 Oct 2024 14:21:59 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> There seems to be a mistake here. There's a num_rx_qs variable that is not
> being passed to the allocation function. The mq variant just calls mqs
> with the last parameter of the former duplicated to the last parameter
> of the latter. That's fine if they match. Not sure they do.

As far as I can tell, both queue numbers used during the netdev alloc
are always the same, so this looks good to me.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

