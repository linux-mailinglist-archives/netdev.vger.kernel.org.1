Return-Path: <netdev+bounces-105180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9E391000F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3791F21B26
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 09:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1104A19B3D1;
	Thu, 20 Jun 2024 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mYsFFleS"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D032A50288
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 09:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874793; cv=none; b=Un++amHJ7/kvY6/qybTUHLnaoZYRPbpuj86Uj254dcAJNhL0IBkqxD6zrzcQTNSNzzOPd0AOS0Nn1xrJNA3bP3bz6QT2V8j+z6pY/nOrXUU1zl8nd6G4cmLeSbzhFtMciq93gk728l3yPB1Ufi4gbGo2OzUoHBRaTlUfPXIivbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874793; c=relaxed/simple;
	bh=lXOPQpBk/f62CLRXkJR3Wa/hCKJD+YgsOuEegSmWFD0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5Zk0rmlv9ihMEAbJFCxKliUGUGLQhzw0QT/VgKj6Vbz6pYRZOeXV/nghTlg1rNhlV6ttx9ze3qt6TKaJXDjLHpBozY3vL+oVwxQyKQOeiBhot9a/uOlwNkjfzZmEuXtH15FdH7KBoo35nJlp5vik8yK3DyBxMPO/UCPcYplTR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mYsFFleS; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C44C560006;
	Thu, 20 Jun 2024 09:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718874783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsfVmJ5Q9dxhq88M34smdo4slbsb4YEgY+RxVLQeXDc=;
	b=mYsFFleS4FvCcX528MmYj7L95k6TzOkQwW7ZZQSpQkB1lK7WBh69N1XWD1WfFT0qk+MsRr
	Alr+r3WEaW5O+A1Vm8wk3dErb3SH9Iynq1VAmY67S/t2J63mTI2S6B+SzdkHcR5fIOgIJm
	VkoF0xHaF69f/eUDf5AjEompqsRpP7B5wBaaV+S2Huj4w7OjDLl9pYR/xvw0xT6ji9LUlN
	ChrfC0uHZ0WVFrlqhRFxKdHO2uNv7u5MYXHQVP9w18m3gkqbL0OqPvtGamatcrM1Vol2B+
	WdowgFLFzYr+QEqYVYDVpaaOFM/izvQ+LjDtDxOSzP1XB7L+BsQ9OaJPTkfGmQ==
Date: Thu, 20 Jun 2024 11:13:01 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Liang Li
 <liali@redhat.com>
Subject: Re: [PATCH net] bonding: fix incorrect software timestamping report
Message-ID: <20240620111301.4b7d10e8@kmaincent-XPS-13-7390>
In-Reply-To: <20240620085626.1123399-1-liuhangbin@gmail.com>
References: <20240620085626.1123399-1-liuhangbin@gmail.com>
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

On Thu, 20 Jun 2024 16:56:26 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> The __ethtool_get_ts_info function returns directly if the device has a
> get_ts_info() method. For bonding with an active slave, this works correc=
tly
> as we simply return the real device's timestamping information. However,
> when there is no active slave, we only check the slave's TX software
> timestamp information. We still need to set the phc index and RX timestamp
> information manually. Otherwise, the result will be look like:
>=20
>   Time stamping parameters for bond0:
>   Capabilities:
>           software-transmit
>   PTP Hardware Clock: 0
>   Hardware Transmit Timestamp Modes: none
>   Hardware Receive Filter Modes: none
>=20
> This issue does not affect VLAN or MACVLAN devices, as they only have one
> downlink and can directly use the downlink's timestamping information.

Acked-by: Kory Maincent <kory.maincent@bootlin.com>

--
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

