Return-Path: <netdev+bounces-131298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA18B98E07E
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810C01F23E40
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189E81D0E29;
	Wed,  2 Oct 2024 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SL3V8SI/"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202B1D0DC3;
	Wed,  2 Oct 2024 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885839; cv=none; b=f2jMp4Eh5h3kJgnDVHw1YqFERUETUkyRcyDM0OUvC4DgnDHFDAecI0SPlqH6f4Vlr1Y0IkkodJL0r2dstT8yYzfIoCPnZro/m3yksQe4zczIO5YmbEYhkqVUk/febRLuuQt0r19gFKalgVzLNIadz8cioFUNm3t5HkEcXhkGgmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885839; c=relaxed/simple;
	bh=8lkbLe6V4g4SIWQRLmkHl2OI44P4UOgpstoIplXia/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOuuSEr4Yjbt0UB5vot9boNF0lLB9vw5VQuAJhjLJCEAbziVhd17tXcMzo96h0K99iZsMzlm25QYs9ANXePqYtX4jMlF9kpey5POkSbmoBHGvYlU+6aJLRkhogsN+kBlS4o+sFNOelGdewurPyA7jSF/FDZ6NFBKy7fJWhTtNvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SL3V8SI/; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E61F3E0008;
	Wed,  2 Oct 2024 16:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727885835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8lkbLe6V4g4SIWQRLmkHl2OI44P4UOgpstoIplXia/s=;
	b=SL3V8SI/GLOsl53laN8ZVnlZT3Azw5EmTkkcoPbIYbVv3eutPJgGobXmQu5GGZT91hQron
	MGcf461ir6gyFr3pupcLU2Zj7qofKOIMokP49VsDrvDnAG94cW2lhppnQBcPCHlT+m98ah
	CerGgzq6b/ba1X3Mxsq6OR6eLBiq9bMgw53i8da12OrGWsZNwucOdkREKhD6/XNnpEFZpG
	j6zoz7LRzJ+gnuLntAQEa+hvp9UVk88SNAwMro3CqeH5e+N78/KFb990qTqQmeQk4FKoTj
	u6HhEa3nO4/Pk1YwrChyl7Mk6ygjPXgIOwHQz5DzgZJVSMS2xWcqme8aCUiZPQ==
Date: Wed, 2 Oct 2024 18:17:13 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de
Subject: Re: [PATCH 00/12] Add support for PSE port priority
Message-ID: <20241002181713.7c773673@kmaincent-XPS-13-7390>
In-Reply-To: <20241002-feature_poe_port_prio-v1-0-eb067b78d6cf@bootlin.com>
References: <20241002-feature_poe_port_prio-v1-0-eb067b78d6cf@bootlin.com>
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
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 02 Oct 2024 18:14:11 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> This series brings support for port priority in the PSE subsystem.
> PSE controllers can set priorities to decide which ports should be
> turned off in case of special events like over-current.
>=20
> This series also adds support for the devm_pse_irq_helper() helper,
> similarly to devm_regulator_irq_helper(), to report events and errors.
> Wrappers are used to avoid regulator naming in PSE drivers to prevent
> confusion.

Dohh missing the net-next prefix. Sorry !!!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

