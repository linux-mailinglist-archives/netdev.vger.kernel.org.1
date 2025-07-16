Return-Path: <netdev+bounces-207377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD51B06EE5
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112051A65EC5
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C965228A1DD;
	Wed, 16 Jul 2025 07:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NMckRudW"
X-Original-To: netdev@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7FD28751D
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650769; cv=none; b=bLck+PJFv9vstuDa1ikXIzXJblfbX9c9Esa6GYq/Py6EzdjD1UJqpsuQ4EZBgzt5dRSrU2JF1uo+tXJJEB4aAA5rEwgiT+3wALplptWZ73ehvKrJ0ZfBtAj/pm6DBT6Qo4Nyo2FudBzf2B++ndBdtaxFt2LzTlkF2CgkZF2QeYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650769; c=relaxed/simple;
	bh=sAycwssUPp6qdBMnJNLVjwhs/goAFY21oqlFroIZZZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cip1LhI2bRh9mLD9INOsrdVQfe3fFnmm+lCkx+RHOnHfzd7SoVGpSqOoFcn65kH0bsd/2f62lgvSExRmajdMmDw9EDJj1iU7h55kyi+Iy4T18UnSHtVTG6De3+YEiX9en3ANHbk1rHTW27XKV5vdLLxiVDanUOtcnm8M5tbco/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NMckRudW; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E53AA442AB;
	Wed, 16 Jul 2025 07:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752650759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DiiXnkuJtQ8VDaCurAgF8ESO9npD6vbbxWPC/5BE7K8=;
	b=NMckRudWQnSiLp5fox7XBfPyLf3OK6W1/qemLR4oYt5GRqqZv4oW0vfkhSkfp1+ujGlWnm
	GmlcPR1KGtF5Q2oYgKzxNRkdajp5gMeL0XrF1ltqgiL0KFX014EvcqaORxehDgQt1zzBK4
	kvymlZrKWVWYt22I1XiqiXQlWGBUNU1geyTZzvpSMvOsZgRXoRj1qFl9WbSm1PAZaSVqVd
	KI94c3LxRyXZU7SmBHWGh6/PRFtrFe49z9uVJUYhC7GzHxCcxBZhZM6YhLk7Trj6A2DAdQ
	xqN4JaExdBtp2xROrwSq49nDvE+iL6tq83lYT+KPKyPW3zP15pbQwfj0wRPMrQ==
Date: Wed, 16 Jul 2025 09:25:57 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jack Ping CHNG <jchng@maxlinear.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>,
 <fancer.lancer@gmail.com>, <yzhu@maxlinear.com>,
 <sureshnagaraj@maxlinear.com>
Subject: Re: [PATCH net-next] net: pcs: xpcs: mask readl() return value to
 16 bits
Message-ID: <20250716092557.09bc8781@fedora.home>
In-Reply-To: <20250716030349.3796806-1-jchng@maxlinear.com>
References: <20250716030349.3796806-1-jchng@maxlinear.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjedutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepjhgthhhnghesmhgrgihlihhnvggrrhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtp
 dhrtghpthhtohepfhgrnhgtvghrrdhlrghntggvrhesghhmrghilhdrtghomhdprhgtphhtthhopeihiihhuhesmhgrgihlihhnvggrrhdrtghomhdprhgtphhtthhopehsuhhrvghshhhnrghgrghrrghjsehmrgiglhhinhgvrghrrdgtohhm

Hi Jack,

On Wed, 16 Jul 2025 11:03:49 +0800
Jack Ping CHNG <jchng@maxlinear.com> wrote:

> readl() returns 32-bit value but Clause 22/45 registers are 16-bit wide.
> Masking with 0xFFFF avoids using garbage upper bits.
> 
> Signed-off-by: Jack Ping CHNG <jchng@maxlinear.com>

I'm OK with the patch, but is it fixing an issue you've seen in real
life ? If so, you should make this a fix, sent to -net with a Fixes
tag. If not,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


