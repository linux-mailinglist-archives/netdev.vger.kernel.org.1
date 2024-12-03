Return-Path: <netdev+bounces-148320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4993A9E11AE
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12022835ED
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941C3156220;
	Tue,  3 Dec 2024 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/x4l3M8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629C0150997;
	Tue,  3 Dec 2024 03:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733196246; cv=none; b=hRiuX77xEnWzh2hS/K/xT5i1xHxAt7FkMIL8OVRxpqiZWOGanqOrFaUMl4DlLiSNwQEaoU0RvRK4spVejcEZK0GdMOnErQHPvrMg2Uuw2PduZVTEKmXgxysN683f8volcfAGVnWkmnfUozMGXfeBPHXE5dUw3zpMslLvF57A4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733196246; c=relaxed/simple;
	bh=I76REB7cBnfzv1eSpISrtyMeJ3xKPmfY+ePlg4jraLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nooMXbSjsQGNl1b4aEVrVjn1t8eCY5gBURrBVNAsX+0kvMzsf2ReVy8WshsC6RW47KQ/PBH4idNLob2/90kitZgz09s+M5A4F+h0JY87CyM/k1xVPBK4KmU+WAfpzcYMJ1cNUL6S9SWWpONeyOnOYTTR/ywoQ4gVj5k5TYLIBCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/x4l3M8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C9DC4CECF;
	Tue,  3 Dec 2024 03:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733196245;
	bh=I76REB7cBnfzv1eSpISrtyMeJ3xKPmfY+ePlg4jraLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q/x4l3M8/awjpr2uBhhb6OimfxItM1TRw27n9o1pVv/FY+9AOP9QNt+wKOVqjfRqu
	 bTOfKio8yAZf+0zFf8bWhWtTDbxaJ3m28I11BNXzwx3GxBcom8UoxlZYNzT9qWMGUm
	 S3Ou941ZAe7Cq0Hdt/UtBuJYnnPJS3F5NbOkrb0W7CkxHK121EWyIEE1l6JJSS1P3z
	 KCdXPMJYnIMiJgqsC1SYM+QXo+AI8VF9GNVFS3E1YW0wZaGNLgNRk+BGVao47IKETr
	 QSQPWV99SWLJyUxnOEDUQYqZbvKIjAEgNBleIwq9HEMJ3L2NiiCJRs8bDSFzoMamso
	 E04ebI1rgqB2Q==
Date: Mon, 2 Dec 2024 19:24:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof =?UTF-8?B?SGHFgmFzYQ==?= <khalasa@piap.pl>
Cc: netdev <netdev@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric  Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jose Ignacio Tornos Martinez
 <jtornosm@redhat.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] USBNET: Fix ASIX USB Ethernet carrier problems.
Message-ID: <20241202192404.4713b1f9@kernel.org>
In-Reply-To: <m3v7w9hxp1.fsf@t19.piap.pl>
References: <m3v7w9hxp1.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Nov 2024 09:45:30 +0100 Krzysztof Ha=C5=82asa wrote:
> To: netdev <netdev@vger.kernel.org>
> Cc: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>=
, "David S. Miller" <davem@davemloft.net>, Eric  Dumazet <edumazet@google.c=
om>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, lin=
ux-usb@vger.kernel.org,  linux-kernel@vger.kernel.org, Jose Ignacio Tornos =
Martinez <jtornosm@redhat.com>, Ming Lei <ming.lei@redhat.com>

Please add to the CC list some folks who worked on phylib and phylink
support for this driver. They will be best reviewers.

> Subject: [PATCH] USBNET: Fix ASIX USB Ethernet carrier problems.

No need to spell out USBNET in all caps. I'd rename the subject to:
  usbnet: asix: leave the carrier control to phylink

If we say it's a 'fix' we should really point at the commit which broke
things with a Fixes: tag. If your device never worked it's better to act
as if it was "support for a new device". Otherwise various semi-
-automated backport bots will suck this change in, and given the general
dependability of ASIX devices... seems risky..

> Date: Wed, 27 Nov 2024 09:45:30 +0100
> Sender: khalasa@piap.pl
>=20
> Hi,

No need to say "Hi" in the commit message :)
--=20
pw-bot: cr

