Return-Path: <netdev+bounces-234721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A1FC26680
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF9B189AD68
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F19A2D781E;
	Fri, 31 Oct 2025 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q9YaIMCD"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ABD2638BC
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932395; cv=none; b=G77KwCpQaeJWRjLxCqG0feA/CT1CsR89cnz13cH/MDlnXvRwBwTYNJ5RF+E+JKZtOXyrufPJXYFH/hADaYZcLciRqbNIacTyO1b4xnmmqREFYNNvtbuQZuWSkwhDOoA4qwLxQpThfmsjmmreweKK/JNqOubo2rONVOXJPFhN7zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932395; c=relaxed/simple;
	bh=PHhDIiZekTEyAYDgcBX7q1siYTr1dOxWIQ4BtmseKVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLqIHzdB1hV25B1JcAYO/ZZVx/iqE1d+g7oq2iVlln07rVpt+11sEG42NQ5FCwDghnqilDHyqLGdt/L3LjzFkP2odQIQLpGsI5VUJV1YOWZzK8EDv1LQbD+qRhi5aLIXWYMlrtBH/XTEbN59oKhs2QR78Rk/rqyOpIRU30JKf0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q9YaIMCD; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3631AC0E958;
	Fri, 31 Oct 2025 17:39:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B07F260704;
	Fri, 31 Oct 2025 17:39:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 00D9311818007;
	Fri, 31 Oct 2025 18:39:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761932389; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PHhDIiZekTEyAYDgcBX7q1siYTr1dOxWIQ4BtmseKVg=;
	b=Q9YaIMCDe4UzfWR/C1Ro7yZCZVAk2YvR22FyVv+gZwDEPXE3zYwhptvcZYxOpqo0nfhXUM
	K+D7t9Lqs7mEabZT+nNz/lrUZFPqT3sy5II5H+qmMC86JnRDcUPq26J7n1Wy1RXx3kSfYS
	LwxNNNzVYs+4UceTBncb61zqjEOdQMrEQKmpHvqrXkyWfV9WAOTJmHk5gmYs0ea3zGBUuM
	zBNdCcH0ZLa1oUvz3MFn33q9wCDfBencaWR31dHZs1DU9DW2Dm8Xzank0SFd1wQaevHMZT
	7wBktRjcfnbeS3rxxwdo5EHpP1PkH+qnsl7I9adJM0s1SEXrPjMRKJmKLEKa1Q==
Date: Fri, 31 Oct 2025 18:39:44 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Marco Crivellari <marco.crivellari@suse.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Sunil Goutham <sgoutham@marvell.com>, Richard
 Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 7/7] qede: convert to use ndo_hwtstamp
 callbacks
Message-ID: <20251031183944.5e3f922b@kmaincent-XPS-13-7390>
In-Reply-To: <20251031004607.1983544-8-vadim.fedorenko@linux.dev>
References: <20251031004607.1983544-1-vadim.fedorenko@linux.dev>
	<20251031004607.1983544-8-vadim.fedorenko@linux.dev>
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

On Fri, 31 Oct 2025 00:46:07 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver implemented SIOCSHWTSTAMP ioctl cmd only, but it stores
> configuration in private structure, so it can be reported back to users.
> Implement both ndo_hwtstamp_set and ndo_hwtstamp_set callbacks.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

