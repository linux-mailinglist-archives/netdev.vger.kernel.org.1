Return-Path: <netdev+bounces-209155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E281B0E811
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 03:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA7516E0DA
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 01:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664A813B7AE;
	Wed, 23 Jul 2025 01:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AViwQr7X"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A1A19047A;
	Wed, 23 Jul 2025 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234193; cv=none; b=WGE0GXsM3ZjFPJ7RMH/wwBi/Ks4bWqF4d+qOZUTo+Ka0bxPm+cfCbVnQbDJU8SFJnBbaFlb2VJV5vSJ3e/KBk1HM+AKA+jzrkDofQkOTUvGT6Gfg9J1PQj1j3IGZjAkI2ZIajPRIM1kG+UonGFHT0Ht5FdkW0H6lL3l0wIDPUDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234193; c=relaxed/simple;
	bh=xov6c2H376BrBC6gf3Ptw0bog9VVY4RDnUcfo8OGwyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxSBhjDnBCrsGz+357+XsIgFO4162K4CIo83+AsK+DKktA6cIoSnHw1oWFb2lVnveGsKzmX/SHAxcc4ExnA8xVRei4jNvNXYqdHeI9ctiGs6wIZCPfrT+UQMvUFtIiIQHsElEbjn3tppfIccMvRMrOC2f+r5vpgUD+OOEeKzUvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AViwQr7X; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=zZ9aWtY34hf59G1YvFey4Q/jV3ziIWAaQnWYuXXs1fM=;
	b=AViwQr7X5U46tBD9Zp7RDJjVjJIN7Vxc2ueut1425SKlJjyrtcPyCP2OyhFqMY
	GJNuee2kuob9s3O6oUJxlhxNRnp1JWiGRKytMgTdXTnh/L+MDMbYu+WTbolYgrvg
	dW2gzyrOgd9hSsPWk12bGHbl5HF4rcEuE6SKcTGzGyM9U=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAHGXT2OoBoHlCoAA--.23735S2;
	Wed, 23 Jul 2025 09:29:27 +0800 (CST)
From: yicongsrfy@163.com
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	oneukum@suse.com,
	yicong@kylinos.cn,
	yicongsrfy@163.com
Subject: Re: [PATCH] usbnet: Set duplex status to unknown in the absence of MII
Date: Wed, 23 Jul 2025 09:29:26 +0800
Message-Id: <20250723012926.1421513-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1c65c240-514d-461f-b81e-6a799f6ea56f@lunn.ch>
References: <1c65c240-514d-461f-b81e-6a799f6ea56f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAHGXT2OoBoHlCoAA--.23735S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1rKFyrCr1UGry3Xw17trb_yoW5Jr17pa
	9Yk3Z0ya4DWryIkrs3Zw18JFyY9F4kKFWUXFyUJ345CanIkF1kKF1Ygayjga4UGrn3urya
	qr4j9r18Ja1qkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRnjjDUUUUU=
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/1tbiLBqT22iANvxnfgAAsF

On Tue, 22 Jul 2025 15:06:37 +0200	[thread overview] Andrew <andrew@lunn.ch> wrote:
>
> On Tue, Jul 22, 2025 at 10:09:33AM +0800, yicongsrfy@163.com wrote:
> > Thanks for your reply!
> >
> > According to the "Universal Serial Bus Class Definitions for Communications Devices v1.2":
> > In Section 6.3, which describes notifications such as NetworkConnection and ConnectionSpeedChange,
> > there is no mention of duplex status.In particular, for ConnectionSpeedChange, its data payload
> > only contains two 32-bit unsigned integers, corresponding to the uplink and downlink speeds.
>
> Thanks for checking this.
>
> Just one more question. This is kind of flipping the question on its
> head. Does the standard say devices are actually allowed to support
> 1/2 duplex? Does it say they are not allowed to support 1/2 duplex?
>
> If duplex is not reported, maybe it is because 1/2 duplex is simply
> not allowed, so there is no need to report it.
>

No, the standard does not mention anything about duplex at all.

However, Chapter 2 of the standard describes the scope of devices
covered by CDC, including wired and wireless network adapters,
among others.

We know that wireless communication is inherently half-duplex;
for wired network adapters, the duplex status depends on the
capabilities of both communication ends.

One of the USB network adapters I have (AX88179) supports both
the vendor-specific driver and the cdc_ncm driver.

When using the vendor-specific driver, all operational states
function normally, and the information reported by ethtool
matches the actual hardware behavior — which means the hardware
definitely supports both full-duplex and half-duplex modes.

The issue we are discussing only occurs when using the cdc_ncm driver.

To further investigate, I conducted the following tests using
the cdc_ncm driver:

1. I set the peer network adapter (r8169) to auto-negotiation
and connected it to the device under test. On the peer adapter,
I was able to observe that the link was operating in full-duplex mode.

2. I disabled auto-negotiation on the peer adapter and manually
set it to half-duplex. The setting was successfully applied,
and communication remained functional.

From these two tests, we can conclude that both full-duplex
and half-duplex modes are supported — the problem is simply
that the duplex status cannot be retrieved in the absence of
MII support.


