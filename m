Return-Path: <netdev+bounces-229580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E98BDE87E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF0A19C4C5D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E1B757EA;
	Wed, 15 Oct 2025 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uf5OI0MG"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FD017BA6
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532362; cv=none; b=QbpHM9+j1k140bknGDfa1iaL/VCIJWJDIODCMGd0VGE7bud5t2maAL3AehdIF95xs1F2tF6YfMWzgn7S42Dh2GvP8zXfNWEvqiMpR1OGh337p+uzeXPy4gAo1z1bv46t72vkq/XH+FUxo+F+whI/+j1knz/T6GIsLlKG3mMopfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532362; c=relaxed/simple;
	bh=oyluTmVOjpA44Vi8KdA6vKtr2fcyRpaqShI7dHAkNZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FvNdjl2Ja334v44vh12mxgK/2+yzoUK3R4jvtAnTDXrumf7EOjGVYg2HjDgUv9D9LRjcRXFaS8HjtNxpbYXLWfKMKSTOhiWGic7erC/r/sS8kUMKjS9UrAy5vRHS/yt7c9GwMrA0TCptDOHxDNl1izCQw91HV5RJk0Q/Z/JHAno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uf5OI0MG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7814A1A13D8;
	Wed, 15 Oct 2025 12:45:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4ADC3606F9;
	Wed, 15 Oct 2025 12:45:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88507102F2252;
	Wed, 15 Oct 2025 14:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760532352; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oyluTmVOjpA44Vi8KdA6vKtr2fcyRpaqShI7dHAkNZ0=;
	b=uf5OI0MGetOb0yLq/o0Hrj9if0UYaWuuRvl/XfHi7z1c/2zzDnOBk161QDUw362+f9uT3J
	8NmyDeF5b4hVyS0bEFjYgXbtki537VbDNz9tD8WqLTK8K7lpuI4AK7+4dCC7dWCoz+XV4R
	vi0/hrCBJsgUd3SnIEfqrFmcoh0UKLBHNxoxneuSHJCb/mNZmHeJUsKaIZ6boTu/93U6NQ
	zRQP1Dt6jYhRCY1jYZu26T3dAb34DNrYR1gfsTKuYarTxG9CaOqp2zYU9PU6BT9lSvsf4j
	6/kcn6hDYQ3BOd0xEDwlwYFGIjgv3SQenJi3iboJomEX65QA9lNjhfIJM7lSbA==
Date: Wed, 15 Oct 2025 14:45:26 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: ethtool: tsconfig: Re-configure
 hwtstamp upon provider change
Message-ID: <20251015144526.23e55ee0@kmaincent-XPS-13-7390>
In-Reply-To: <20251015102725.1297985-4-maxime.chevallier@bootlin.com>
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
	<20251015102725.1297985-4-maxime.chevallier@bootlin.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 15 Oct 2025 12:27:23 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> When a hwprov timestamping source is changed, but without updating the
> timestamping parameters, we may want to reconfigure the timestamping
> source to enable the new provider.
>=20
> This is especially important if the same HW unit implements 2 providers,
> a precise and an approx one. In this case, we need to make sure we call
> the hwtstamp_set operation for the newly selected provider.

This is a design choice.
Do we want to preserve the hwtstamp config if only the hwtstamp source is
changed from ethtool?
If we want to configure the new source to the old source config we will also
need to remove this condition:
https://elixir.bootlin.com/linux/v6.17.1/source/net/ethtool/tsconfig.c#L339=
=20

I do not really have a strong opinion on this, let's discuss which behavior=
 we
prefer.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

