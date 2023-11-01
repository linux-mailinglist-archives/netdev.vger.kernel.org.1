Return-Path: <netdev+bounces-45589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3277DE77A
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 22:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB77B20DFC
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 21:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C381B290;
	Wed,  1 Nov 2023 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selfnet.de header.i=@selfnet.de header.b="sDticAD4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E36847A
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 21:43:04 +0000 (UTC)
Received: from mail-1.server.selfnet.de (mail-1.server.selfnet.de [141.70.126.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B938C2;
	Wed,  1 Nov 2023 14:43:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 414A640B22;
	Wed,  1 Nov 2023 22:42:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selfnet.de; s=selfnet;
	t=1698874975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=va3XCjklqhVnk8nRt7rwHJhvzQs626rlhIiOy82dkiU=;
	b=sDticAD4B4yy/EtzxiuuGt8WH1tpeIDa7IMcixC4f82xDYP85913Nbpoy8hbt6CiBI+JSg
	fwMeQCB/No5AW7/bTUHgwF+2vOnA1KB8zqebeCMD81EzpxQEOZtUsHw5sm9i3lirC+ct1u
	dw+Hiati+o1Mgu+23rIhLXTvw0mGFmIOfH6NC8TCns3sHrMmCq2ZxXyGHsuWotJ9pDVXFZ
	6xLxlfZQaLXhjnhJphd1M8rQa11F1yR4H0j10O1iYox1zD4qUxlsY6VXNV5Vp5lFXswwDo
	Drz0CzhjjFi88WbtqT9izTsDql7hICRHd8GIH13WAg1uX02F1wbkdguNIayRfg==
Authentication-Results: mail-1.server.selfnet.de;
	auth=pass smtp.auth=marcovr smtp.mailfrom=marcovr@selfnet.de
From: Marco von Rosenberg <marcovr@selfnet.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: broadcom: Wire suspend/resume for BCM54612E
Date: Wed, 01 Nov 2023 22:42:52 +0100
Message-ID: <5414570.Sb9uPGUboI@5cd116mnfx>
In-Reply-To: <9cb4f059-edea-4c81-9ee4-e6020cccb8a5@lunn.ch>
References:
 <20231030225446.17422-1-marcovr@selfnet.de>
 <9cb4f059-edea-4c81-9ee4-e6020cccb8a5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, October 31, 2023 1:31:11 AM CET Andrew Lunn wrote:
> Are we talking about a device which as been suspended? The PHY has
> been left running because there is no suspend callback? Something then
> triggers a resume. The bootloader then suspends the active PHY? Linux
> then boots, detects its a resume, so does not touch the hardware
> because there is no resume callback? The suspended PHY is then
> useless.

Hi Andrew,

thanks for your feedback. I guess a bit of context is missing here. The issue 
has nothing to do with an ordinary suspension of the OS. The main point is 
that on initial power-up, the bootloader suspends the PHY before booting 
Linux. With a resume callback defined, Linux would call it on boot and make the 
PHY usable. However, since there is no resume callback defined for this PHY, 
Linux doesn't touch the hardware and thus the PHY is not usable.
So this specific issue is primarily solved by adding the resume callback. The 
suspend callback is just added for completeness.

Does this clarify the issue? If so, I'll adjust the commit message and submit
an updated patch.

	Marco



