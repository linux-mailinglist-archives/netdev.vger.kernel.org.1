Return-Path: <netdev+bounces-106984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDBB9185AD
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EE6284346
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B156F18A943;
	Wed, 26 Jun 2024 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kLSOeu/8"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0BC18A932;
	Wed, 26 Jun 2024 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415553; cv=none; b=aGSjtRMlNXKPzuXLGmFr3kOxrN6Q2oBRXMyFCvF4FUJupqokWUl9gMypIx1jPX+XYUjxnKXqcAAJIgwVmPTkmFimD+9mON0aTYcT+jcZNsn+/H62rUbM4VqBUYAGjKQtxyQCKlBqnojGRyPm09eaNaNFG4wm7+ftVXUpmWINbZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415553; c=relaxed/simple;
	bh=umQXEjb2PL2e6U2B+fVH2n32pkx0la3uAx1khMFgVWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6d+I/3hI5PojaXS2XEUHeJ8Xfb6ueuSX6YL7HNaivbd8G4tRfRaWQ6DeVJD/sWoEnNF/rAGkVPKRVJtd9txHZlWz/J3PLVN+HEXrIL6NFsoGjas/tKih1ihY+H6QAp1Fzc2VNDxzpSn25OcVEyoZrjSdHA6p3R/yq4tfbMCgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kLSOeu/8; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17CEB1C0003;
	Wed, 26 Jun 2024 15:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719415549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KzWNL/B1WPRI1LHle3EgQV0Lb6TkftrlmClTLMWSPBs=;
	b=kLSOeu/8phqJ9r0wDZzEov/Ok8bEN9tgl6yPtsL1phpTujYSra21gKL1mch4AuK8gt3hP7
	fqlCL96/h5S4xaylSaX/SKQCIz8YOcSxWseLcQX1KnRNqzqSI67r/ahBO6HSnFzryYGyyu
	YC6PSrIijhS0RVFMzzjkMkHTuBnMMnlV0HwA4AMn9TJ0Mn/j3O2hjef8SlqZktcs15Omx+
	QbUtaN6EEv5dfGC40hmBcT8RKTIxPI24BeQ4hBZVCrsuNG0afPIShQx1VC1aNgG4lvbkON
	xbJ4wSQVUpkBVijbpT2DXM8BjCQlAiJLWXsDBqtCNWtddehbimNkJapETsSP3Q==
Date: Wed, 26 Jun 2024 17:25:47 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald Hunter
 <donald.hunter@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/7] net: pse-pd: Add new PSE c33 features
Message-ID: <20240626172547.115e95cc@kmaincent-XPS-13-7390>
In-Reply-To: <20240626062711.499695c5@kernel.org>
References: <20240625-feature_poe_power_cap-v4-0-b0813aad57d5@bootlin.com>
	<20240625184144.49328de3@kernel.org>
	<20240626095211.00956faa@kmaincent-XPS-13-7390>
	<20240626062711.499695c5@kernel.org>
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

On Wed, 26 Jun 2024 06:27:11 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 26 Jun 2024 09:52:11 +0200 Kory Maincent wrote:
>  [...] =20
>=20
> Every Thursday, usually around noon PST but exact timing depends on when
> Linus pulls and how quickly I notice that he did :)

Ok, thanks for the information!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

