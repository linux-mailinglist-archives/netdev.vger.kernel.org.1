Return-Path: <netdev+bounces-48306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2EA7EDFE5
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 12:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06351C20847
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 11:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1838C2E634;
	Thu, 16 Nov 2023 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="FVPfc51v"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [IPv6:2a01:4f9:c010:a439::d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52106DA
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 03:32:12 -0800 (PST)
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10da:6900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 3AGBVmSE3632276
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 11:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1700134303; bh=x4l0ZCBUiGQBhM2oFX0ut6jp9gWfv6PJjV8vzL/P6iE=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=FVPfc51vG0i9GVNElXq73WzRhDbctfQgLVFclOrGBtvvhuCB8gC6HePDvT3TV2BUw
	 5AfnnBRcjN4njt4EBHloKcU8plzCpiIAB25syda2iNsj6HZueMva2xsFuyn7WPQxRX
	 vCq/mS5ldBx3Szs08dsLwLZd7jcUQ2srFPFd/YH4=
Received: from miraculix.mork.no ([IPv6:2a01:799:10da:690a:d43d:737:5289:b66f])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 3AGBVh4M3933896
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 12:31:43 +0100
Received: (nullmailer pid 2274955 invoked by uid 1000);
	Thu, 16 Nov 2023 11:31:43 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Oliver Neukum <oneukum@suse.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: question on random MAC in usbnet
Organization: m
References: <53b66aee-c4ad-4aec-b59f-94649323bcd6@suse.com>
Date: Thu, 16 Nov 2023 12:31:43 +0100
In-Reply-To: <53b66aee-c4ad-4aec-b59f-94649323bcd6@suse.com> (Oliver Neukum's
	message of "Thu, 16 Nov 2023 11:14:49 +0100")
Message-ID: <87zfzeexy8.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.3 at canardo
X-Virus-Status: Clean

Oliver Neukum <oneukum@suse.com> writes:

> I am wondering about the MAC address usbnet is handing
> out. In particular why that is a singular address.

This has been the case since long long before I ever looked at usbnet.c.
The variable declaration is in fact still attributed to the initial git
commit:

 ^1da177e4c3f4 drivers/usb/net/usbnet.c (Linus Torvalds              2005-0=
4-16 15:20:36 -0700   64) // randomly generated ethernet address
 ^1da177e4c3f4 drivers/usb/net/usbnet.c (Linus Torvalds              2005-0=
4-16 15:20:36 -0700   65) static u8   node_id [ETH_ALEN];

Pretty impressive given the churn we've had since then :)

If I were to guess why it ended up like that, I'd say that it probably
was because it was considered an exceptional fallback only.

If you wrote a driver with the USB-IF communication class spec in mind,
then it was reasonable to expect a functional decriptor pointing to a
string descriptor with a globally unique mac address, assigned by the
device manufacturer.

A host using more than one usbnet device was also unlikely 20 years
ago.  So host unique was good enough in any case.

These factors have change a lot since then, obviously.

> Frankly that seems plainly wrong. A MAC is supposed
> to be unique, which is just fundamentally incompatible
> to using the same MAC for multiple devices, as usbnet
> currently potentially does.

Agreed.

> Do you think that behavior should be changed to using
> a separate random MAC for each device that requires it?

I'm in favour.

I could be wrong, but I don't expect anything to break if we did that.
The current static address comes from eth_random_addr() in any case, so
the end result as seen from the mini drivers should be identical.  The
difference will be seen in userspace and surrounding equipment, And
those should be for the better.


Bj=C3=B8rn

