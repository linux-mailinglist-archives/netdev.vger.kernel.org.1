Return-Path: <netdev+bounces-225418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49955B93941
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042DA3B5A7C
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026E72F49E3;
	Mon, 22 Sep 2025 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sYaE5XWi"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2CE2F90DE
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583613; cv=none; b=kqb7OOXSylyRgKOb+ESVAjjt6Sc6wHbn4xRhV/4YN9GWbxN0DiL/EQtd/Rkd5e1cWcc++axr63KVep1tGWs6bhr3CvsHzHjg+Me8NxxLL1FJcvNDDgsI8xagn/kbl/cdXhMrXo9RZR4f/GCfmQuOZtnA8o02TQCTYcCy14c6coM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583613; c=relaxed/simple;
	bh=Vv360yHKtDNBs8ARh+aXv/g9KbEMjOHdpX2hLhXVnSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7c+fwKUymk3449X5QTAhH8VSXgeyvqk5XPtGnS39sVx482V95vO2Z8KkYiM55Q1lqDfpkDGQZsYwYdIvyHB9/3AhDG3tf27MpowBVlKcfO0/OnfG93qKVLvFM0J8wpAFLpD3nHlw3zAJpqrqvnIDENgqtcdcuJ1X5JgFPBEOHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sYaE5XWi; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B9F5F4E40D2A;
	Mon, 22 Sep 2025 23:26:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7B19D60635;
	Mon, 22 Sep 2025 23:26:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B669F102F1877;
	Tue, 23 Sep 2025 01:26:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758583608; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Vv360yHKtDNBs8ARh+aXv/g9KbEMjOHdpX2hLhXVnSs=;
	b=sYaE5XWiSFTKFcx1Rj8DRmDAloz4D+1f5zg2mxAjVVIE+9WHzxTpdXOII6KOLoBn4YAZbB
	z97UB+P4SdKv41LJlgEJKg4Ad/fQAqFfMszqq2/LNX1yh0nEJ7uavVi/CRGQ4xp3umMhlq
	RhrB6nWDcbomSANBbQMQ0NLUD7q/FAaKpYzlZLW2tc4XyQHgUYldqllJPRxmJKV1oUjZm/
	osYm+nPzrdGVoK661yoKsgZekXvp4dWlUn1wLdt771iYv/kPTKxeo5xhZqRXEHyfG7y2Nm
	+3VzF/Lc5FWz3vGXXFMcpQ+isM+NmKA1Z3ik+F1YK4ivKwxa+1hn5942Cm5Qvg==
Date: Tue, 23 Sep 2025 01:26:44 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Richard Cochran
 <richardcochran@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net] net: ethtool: tsconfig: set command must provide a
 reply
Message-ID: <20250923012644.40df01ad@kmaincent-XPS-13-7390>
In-Reply-To: <20250922231924.2769571-1-vadfed@meta.com>
References: <20250922231924.2769571-1-vadfed@meta.com>
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

On Mon, 22 Sep 2025 16:19:24 -0700
Vadim Fedorenko <vadfed@meta.com> wrote:

> Timestamping configuration through ethtool has inconsistent behavior of
> skipping the reply for set command if configuration was not changed. Fix
> it be providing reply in any case.
>=20
> Fixes: 6e9e2eed4f39d ("net: ethtool: Add support for tsconfig command to
> get/set hwtstamp config") Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

You sent it 5min before my reviewed-by. So here it is again:
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

