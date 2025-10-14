Return-Path: <netdev+bounces-229147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F079BD899A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642173A7212
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D72C2E7BC0;
	Tue, 14 Oct 2025 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UhMYHZK0"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE612E8DF6;
	Tue, 14 Oct 2025 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435834; cv=none; b=Rsb5tliP+cDt7DI8JghnuR8wpy0f2hFhbl7/FlzZfZfN0U805943f6E3EaV50p4q95ytsfMtyal4ARdF8UVd34L6eACABMe9add15tMdr5v61XVvCLqKrZ6RnHphlbThH9fJxh4sME/tOiO9JC2tsyuyBTW58WbIv/htd02hhmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435834; c=relaxed/simple;
	bh=PSxhzlfYJchGE7++P9YV8xhmL/vMOKoa8VkZCCAAhmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ce9eYlGLnk+O+PL8ObcaSgkd5jU0FlhiBV/gv/qzc53wWLtKiVsAjHxzhkle1zQ3j0NZH1DREzCrHXq3InDccmBwR4a0lI1KgK4yETmMbHAmpCfvqpzop3pNebUeE/VyNpsma5r2/Fc1LmSKQdFEHKiPf5/srfAKhHxUmOUdprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UhMYHZK0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1894A1A1378;
	Tue, 14 Oct 2025 09:57:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E2331606EC;
	Tue, 14 Oct 2025 09:57:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AEE62102F2298;
	Tue, 14 Oct 2025 11:57:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760435829; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CCxEg1933Mu/rtrIAyhW9gFkerKbyouvT8otO1paF3E=;
	b=UhMYHZK045eQW4odGcFdLardF6thaeclqfI9pOGJE8Y+D2Akbs6PCOFPE67gGhvh614/8R
	BkdJ4fSMpc3Ow/qN2twzeylgemTd612xFDF3cBJf0vQsV7/kEJB0jIjvSkLJgj6+LZSl51
	ijuI6GEmY1cVdvbkjPFXC1do095elko0YkmNR0XMKW6LwmBIonik8o0c8rZcMd5eusn+cW
	pi76Qekteo83yDsB1CbRR0mSrrWtZMcnT8aB6uLO6jigmgKXjH8/4jhq4lR6ts5qH+9TcW
	OWIcNAkWidxhUieVDOnpwTeMBuuD6my0FE3z6cOQnzci5QR15DZjAfz5FqO0Gg==
Date: Tue, 14 Oct 2025 11:56:59 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 kernel@pengutronix.de, Dent Project <dentproject@linuxfoundation.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: pse-pd: pd692x0: Preserve PSE
 configuration across reboots
Message-ID: <20251014115659.0e6fd10c@kmaincent-XPS-13-7390>
In-Reply-To: <aO4Q0HIZ_72fwRI2@horms.kernel.org>
References: <20251013-feature_pd692x0_reboot_keep_conf-v2-0-68ab082a93dd@bootlin.com>
	<20251013-feature_pd692x0_reboot_keep_conf-v2-3-68ab082a93dd@bootlin.com>
	<aO4Q0HIZ_72fwRI2@horms.kernel.org>
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

On Tue, 14 Oct 2025 09:58:56 +0100
Simon Horman <horms@kernel.org> wrote:

> On Mon, Oct 13, 2025 at 04:05:33PM +0200, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > Detect when PSE hardware is already configured (user byte =3D=3D 42) and
> > skip hardware initialization to prevent power interruption to connected
> > devices during system reboots.
> >=20
> > Previously, the driver would always reconfigure the PSE hardware on
> > probe, causing a port matrix reflash that resulted in temporary power
> > loss to all connected devices. This change maintains power continuity
> > by preserving existing configuration when the PSE has been previously
> > initialized.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> Hi Kory,
>=20
> Perhaps I'm over thinking things here. But I'm wondering
> what provision there is for a situation whereby:
>=20
> 1. The driver configures the device
> 2. A reboot occurs
> 2. The (updated) driver wants to (re)configure the device
>    with a different configuration, say because it turns
>    out there was a bug in or enhancement to the procedure at 1.
>=20
> ...

You have to find a way to turn off the power supply of the PSE controller.
As adding a devlink uAPI for this was not accepted, a hard reset for the
PSE controller is the only way to clean the user byte register and (re)conf=
igure
the controller at boot time.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

