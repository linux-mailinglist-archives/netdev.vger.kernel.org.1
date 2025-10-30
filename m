Return-Path: <netdev+bounces-234483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5E1C2160E
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 18:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B21CA4EE842
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 17:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2759D27A907;
	Thu, 30 Oct 2025 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eLjWif+0"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A31365D37
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843900; cv=none; b=ulOFFgmlhgqVYjxE4nyjuhBt6uRj0kCFd90HHMPomErryRcscA9krqOQpuX4ZyTjBtnPsp4v3P/PX/dOtLPwzIY+uRy43OXbnxGCAyQKLL38jBNjx+XfF94O6GhN2SBKzMNDdvwqHjH2GQABfPjyPbQaEnWjSeGkXOTtkyzTX0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843900; c=relaxed/simple;
	bh=lkTfPVu3cLhAO5i5CvwhITWaFpZMHJ5+UWSxkZ5OVuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtJS5AXCBtI72VwJrWrqWSFMrQyd8wPBT2HKhn6NhM//4bRd1KZykNlFzQ4aybj/sWB3LULAghA08lFthUPehiyc4W9lngvg58izvnmziG4QBMzGIxzw7grTBskfgJbcoUGqpAW3yhCFkDQfq0x8VXqcuy90gsE7SQp7teeP+qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eLjWif+0; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1B715C0DABA;
	Thu, 30 Oct 2025 17:04:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7060760331;
	Thu, 30 Oct 2025 17:04:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41E0711808BCB;
	Thu, 30 Oct 2025 18:04:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761843890; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lkTfPVu3cLhAO5i5CvwhITWaFpZMHJ5+UWSxkZ5OVuI=;
	b=eLjWif+0NASONlfTg38MomtvHr2hJFUpA5ptsj0FS1ruQSvzLZyUTOPEWI0Uc1GZArt1lA
	8r+j/p+eWfcu1X1EC2fWSOl60cxC/HsXaYuXjEkhD64S5U7vtj9t9priavyeluBi7MFmCC
	TVrLMdw0AnLtPLA5m81ILxON7HzbCF1i5edTgyzfrEsSWoI7J60iEQe6lQcrKOpDUfEmvM
	jKW2zGPDGNDlUq2ZIgEDaH/aHFyTMQQI7pTgTqH7yS4CSF0wAc3ZA5l+u849dcSk6U69R9
	Dm0Npeyosm3chEjlzyWg5iN7YezwB8q4Aczyyxs9W2Tu3lcyRY1l/UPOeNUyhg==
Date: Thu, 30 Oct 2025 18:04:47 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Stefan =?UTF-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
 socketcan@esd.eu, Manivannan Sadhasivam <mani@kernel.org>, Thomas Kopp
 <thomas.kopp@microchip.com>, Oliver Hartkopp <socketcan@hartkopp.net>,
 Jimmy Assarsson <extja@kvaser.com>, Axel Forsman <axfo@kvaser.com>,
 linux-can@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Jacob Keller
 <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 2/3] can: peak_canfd: convert to use
 ndo_hwtstamp callbacks
Message-ID: <20251030180447.26048ef5@kmaincent-XPS-13-7390>
In-Reply-To: <20251029231620.1135640-3-vadim.fedorenko@linux.dev>
References: <20251029231620.1135640-1-vadim.fedorenko@linux.dev>
	<20251029231620.1135640-3-vadim.fedorenko@linux.dev>
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

On Wed, 29 Oct 2025 23:16:19 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> Convert driver to use ndo_hwtstamp_set()/ndo_hwtstamp_get() callbacks.
> ndo_eth_ioctl handler does nothing after conversion - remove it.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

