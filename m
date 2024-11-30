Return-Path: <netdev+bounces-147927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E24A9DF2B7
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 20:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C95C28133D
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 19:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2386919E960;
	Sat, 30 Nov 2024 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlb/w5LM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED021132103;
	Sat, 30 Nov 2024 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732993306; cv=none; b=r+kuXY8oF5bYHcNB3MbsRdJCPL0AVtTzH7geZO1GhZ41ldxPx6Kd+D7kFomiiMLUBeXD1vVLTXncjxlKoQXrQDX8YUxIX7sdWUQJM5MHWnxN04jh7Pnc3NSRjiWTPSvxX8FFZPttIhdxEy+lFo/RWUF/fCui0n3nsvNwLXFS1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732993306; c=relaxed/simple;
	bh=3A60e3W+4OkhfqEw38ZztwLq1R7igR13Ocf40ndNyBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTvL+QOYPGpcFXmWW5tuuPymUGnLVQJoYKNGDxEfXoqL1QtpOkWxY15envC+CM/M9a8NTD8kR4qRp0Ua/DHiohsi+Wlk2d9LdxtLluMNz9cGP6CwP0ZKd2oDtp6GxyYnr0n3F6K01/8H+K6iH+kF7JeOz42dWpx9m5air0aZP3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlb/w5LM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BAFC4CECC;
	Sat, 30 Nov 2024 19:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732993305;
	bh=3A60e3W+4OkhfqEw38ZztwLq1R7igR13Ocf40ndNyBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hlb/w5LMbPiCZ1rVtv2QDGXyhdXltZ2JAz1apEFBIxdFKGvVF1Zc+vvynJ+nCUDiI
	 q0W+1xSjgdm3AQHU+DCsS6sMHeYWLXuwsKgYnw4gJMN+icVJQ284Rp81k8qNlgzHES
	 oEObVSVZb0sOKqZJCWOdRJKhGKb/Xe3NiiGMf7fbswSHbREy8topTKftyVMrcSS+/t
	 DlZo2tDbccIqS5CG7bl2jpiwMGAqDtI2TSMae3ELl8/pUjr770KIKx0Nj3m8habKAh
	 aSfeOMuWtxh9Wbgv4H2gRu0s/M/p5FtvJ9wSM6A+hZEVfvYtnly4ApijnE21flK589
	 socNGdRTfF9mA==
Date: Sat, 30 Nov 2024 11:01:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Richard Cochran <richardcochran@gmail.com>, Yangbo Lu
 <yangbo.lu@nxp.com>, David Woodhouse <dwmw2@infradead.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: Switch back to struct platform_driver::remove()
Message-ID: <20241130110144.1a845780@kernel.org>
In-Reply-To: <lchtswwdxq7uwjfg2e46k2jyzpr43jk5hxvwoode7cc56wuthw@l2feh4c2yu7a>
References: <20241130145349.899477-2-u.kleine-koenig@baylibre.com>
	<Z0soVfzwOT2IHunn@hoboy.vegasvil.org>
	<lchtswwdxq7uwjfg2e46k2jyzpr43jk5hxvwoode7cc56wuthw@l2feh4c2yu7a>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Nov 2024 18:34:48 +0100 Uwe Kleine-K=C3=B6nig wrote:
> I somehow expected that it's you who will pick up this patch? Does your
> ack mean that someone from the netdev people will pick it up

Yes, we pick up PTP patches with Richard's ack. I wonder if we should
adjust MAINTAINERS like this:

diff --git a/MAINTAINERS b/MAINTAINERS
index b878ddc99f94..0ae7ac36612e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16051,6 +16051,7 @@ F:	Documentation/devicetree/bindings/net/
 F:	Documentation/networking/net_cachelines/net_device.rst
 F:	drivers/connector/
 F:	drivers/net/
+F:	drivers/ptp/
 F:	include/dt-bindings/net/
 F:	include/linux/cn_proc.h
 F:	include/linux/etherdevice.h
@@ -18606,13 +18607,12 @@ F:	drivers/hwmon/pt5161l.c
=20
 PTP HARDWARE CLOCK SUPPORT
 M:	Richard Cochran <richardcochran@gmail.com>
-L:	netdev@vger.kernel.org
 S:	Maintained
 W:	http://linuxptp.sourceforge.net/
 F:	Documentation/ABI/testing/sysfs-ptp
 F:	Documentation/driver-api/ptp.rst
 F:	drivers/net/phy/dp83640*
-F:	drivers/ptp/*
+F:	drivers/ptp/
 F:	include/linux/ptp_cl*
 K:	(?:\b|_)ptp(?:\b|_)
=20

so that get_maintainers --scm can find the right tree?

> (and that I
> should have added net-next to the subject prefix and should have waited
> until -rc1)?

The wait would be nice but we'll live :)
The subject prefix is not a big deal.

