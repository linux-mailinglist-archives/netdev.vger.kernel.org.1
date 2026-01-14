Return-Path: <netdev+bounces-249677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0A0D1C1EE
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1565300E826
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7189E2F363C;
	Wed, 14 Jan 2026 02:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfSXZpoN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCFE280035;
	Wed, 14 Jan 2026 02:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768357442; cv=none; b=p5jbxFDYX9borQCt8aakJ+anQZlz635i4jlY/S1xhkJ+iXOPAfxqs8pq2E5LB5PlTc4N/3jSm3RWJL2XA+oghLGP7abYPUJ9ZyzX2FRj9lsIy5rrHaKeMHNxvwO2uks2UCYycHk3J3un4kkzIS35Ae0tRb6xmzT8DRndHQjPFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768357442; c=relaxed/simple;
	bh=EInKEyER/0G089jyq3knL1VkRB5cwyxxObwgPXmL5No=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGML/R8kFjl4oopcyyACq1KJn8iL71Qq7dDDOYHmDwbaUXULSc5MLyjSV5sB6M275o6z4AVR+wUE+wMrkqy1oLPm4uHt3HqHoQ4W9L6PQznViheCLfDerxOBOTl2+Rv1IGzJLGvvdH6w3GngmL18j9zs+ujeu4xpWbPFIVrYDro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfSXZpoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56E8C116C6;
	Wed, 14 Jan 2026 02:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768357442;
	bh=EInKEyER/0G089jyq3knL1VkRB5cwyxxObwgPXmL5No=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TfSXZpoN99f/bDBTdixQ/EUyg8MQQ3TFU5ZifGXAVYFGHmmAPefoSSM6ijbQj3qE8
	 kOQpvycOcIp00mz69Bbut8ectlIM1eSPO1eft9HpKwCXQLtLXlh30yOWP+lSWy3TIN
	 SFVvmP0ci9407DYFJNzN92lBLev2cBbJqWQMcR/Od5cWuODmF6Du4Av7ZAP9KeVObg
	 Vtfhqk7YRpOBY5bqAHax0UFZLgCrE0yrA/r0/llljry8gv6JZxIXEwQTCil5+XD1Ts
	 kmxMqooVt4vDnvYk9SuStCqd2I+snqNPYjOhKPw3US80rxshvrv4FRbtvrNJSOQsQf
	 KXSoaX1Juae4A==
Date: Tue, 13 Jan 2026 18:24:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Wenger Jeremie (EDU)" <jeremie.wenger@edu.ge.ch>,
 intel-wired-lan@lists.osuosl.org
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>
Subject: Re: [REGRESSION] e1000e: RX stops after link down/up on Intel
 8086:550a since v6.12.43 (fixed by suspend/resume)
Message-ID: <20260113182400.723e34a1@kernel.org>
In-Reply-To: <01412a4684684995ac35b4d6dba75853@edu.ge.ch>
References: <c8bd43a3053047dba7999102920d37c9@edu.ge.ch>
	<01412a4684684995ac35b4d6dba75853@edu.ge.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks for the report, I'm adding the relevant people to CC now.
Please try to consult the MAINTAINERS file next time 'cause networking
is a bit too big for the right people to always notice reports.

My best guess below..

On Fri, 9 Jan 2026 09:40:34 +0000 Wenger Jeremie (EDU) wrote:
> Hello,
>=20
> I would like to report a regression in the e1000e driver affecting an Int=
el=C2=A0integrated Ethernet controller.
>=20
> Hardware:
> Intel Ethernet controller  [8086:550a]
> Driver: e1000e
>=20
> Summary:
> - RX stops working after an Ethernet link down/up (unplug/replug cable).
> - TX still works. A system suspend/resume reliably restores RX.
>=20
> Regression range:
> - Working: v6.12.22
> - Broken: v6.12.43 .. v6.18.3 (tested on Debian 12 backports, Debian 13,=
=C2=A0Debian sid). v6.18.3 is the most recent kernel tested so far, so the=
=C2=A0regression is likely still present in newer kernels.

Judging by the range seems like it has to be efaaf344bc2917cb
Would you be able to try building a kernel with that commit reverted?

> Symptoms:
> - Link is detected (1Gbps, full duplex).
> - DHCP DISCOVER frames are transmitted (confirmed via external packet cap=
ture).
> - No packets are received (no DHCP OFFER, RX appears dead).
> - Booting with the cable plugged works.
> - The issue is triggered only after unplugging and replugging the cable.
> - A suspend/resume cycle restores RX immediately.
> - Using a USB Ethernet adapter (r8152) on the same network works correctl=
y.
> =20
> Reproduction steps:
> - Boot with Ethernet cable plugged.
> - Verify network connectivity works.
> - Unplug the Ethernet cable.
> - Plug the Ethernet cable back in.
> - Observe that RX no longer works (no DHCP OFFER).
> - Suspend/resume the system =E2=86=92 RX works again.
> =20
> This suggests that the PHY or RX path is not correctly reinitialized on=
=C2=A0link up after a link down event, while the resume path performs a mor=
e=C2=A0complete reset.
>=20
> I can provide additional logs, ethtool statistics, or test patches if nee=
ded.
>=20
>=20
> Best regards,
>=20
> J=C3=A9r=C3=A9mie Wenger

