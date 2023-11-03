Return-Path: <netdev+bounces-45837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736437DFDC9
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 02:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB15C281D85
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 01:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15E71101;
	Fri,  3 Nov 2023 01:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=selfnet.de header.i=@selfnet.de header.b="bjoNWvY1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2D910E5
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 01:47:55 +0000 (UTC)
Received: from mail-1.server.selfnet.de (mail-1.server.selfnet.de [141.70.126.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEC2198;
	Thu,  2 Nov 2023 18:47:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43838402F7;
	Fri,  3 Nov 2023 02:47:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selfnet.de; s=selfnet;
	t=1698976060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CS7Jy0RmpWKZtYX8kkokoR7rFAe5FlYr840NCfh7jGU=;
	b=bjoNWvY1keqSIO+m4yp4akMI8QlxQKPYRDoRp7Sbh27P0kcta/SNNIil/fQ05zb4hUd6Dy
	baeWW5qpvJ0PDcWeesr48kSrYdMsQbqNycpQouOLmy8WnYCRQllZkXIU8yOwBXvwnU8t6q
	7w8h1lQ+EHb9wiCkB566Giv30kjc7Mo6XkgdA1rGTgERPV51TIcxNcRaednOD80w3ApvA1
	j5npJUb2BReiEmkJod2HYzgl+XpZF/IQAy8vQvInaqld2Gnk2Xe8lSoV5VOzZNyxafEyJy
	/l3Cz+Jxz7DEEOt8JaGIrR5rkcaj1F6WLNYoVE1o/tIqttNXYNsng6ttRjl8Zg==
Authentication-Results: mail-1.server.selfnet.de;
	auth=pass smtp.auth=marcovr smtp.mailfrom=marcovr@selfnet.de
From: Marco von Rosenberg <marcovr@selfnet.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marco von Rosenberg <marcovr@selfnet.de>
Subject: Re: [PATCH] net: phy: broadcom: Wire suspend/resume for BCM54612E
Date: Fri, 03 Nov 2023 02:47:38 +0100
Message-ID: <4890615.31r3eYUQgx@5cd116mnfx>
In-Reply-To: <fe3ad92f-31d9-4509-b851-017218229e19@lunn.ch>
References:
 <20231030225446.17422-1-marcovr@selfnet.de> <5414570.Sb9uPGUboI@5cd116mnfx>
 <fe3ad92f-31d9-4509-b851-017218229e19@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, November 1, 2023 11:06:56 PM CET Andrew Lunn wrote:
> On Wed, Nov 01, 2023 at 10:42:52PM +0100, Marco von Rosenberg wrote:
> > On Tuesday, October 31, 2023 1:31:11 AM CET Andrew Lunn wrote:
> > > Are we talking about a device which as been suspended? The PHY has
> > > been left running because there is no suspend callback? Something then
> > > triggers a resume. The bootloader then suspends the active PHY? Linux
> > > then boots, detects its a resume, so does not touch the hardware
> > > because there is no resume callback? The suspended PHY is then
> > > useless.
> > 
> > Hi Andrew,
> > 
> > thanks for your feedback. I guess a bit of context is missing here. The
> > issue has nothing to do with an ordinary suspension of the OS. The main
> > point is that on initial power-up, the bootloader suspends the PHY before
> > booting Linux. With a resume callback defined, Linux would call it on
> > boot and make the PHY usable.
> 
> Ah, so you rely on phy_attach_direct() calling phy_resume(phydev).
> 
> This seems an odd way to solve the problem. It was not Linux which
> suspend the PHY, so using resume is asymmetric.
> 
> I think soft_reset() or config_init() should be taking the PHY out of
> suspend.

I agree with all of your points. This is just one way which happens to solve
this specific problem. Of course it might be asymmetric to see the patch as
a solution to my problem. However is there anything fundamentally wrong with
adding suspend/resume callbacks? I see some other drivers having these
callbacks defined and some not (it seems a bit inconsistent throughout the
drivers in broadcom.c to be honest).

I'm wondering if I should just omit this whole "motivation" paragraph in the 
commit message and just use the commit message of commit 38b6a9073007 ("net: 
phy: broadcom: Wire suspend/resume for BCM50610 and BCM50610M") as a template.
I mean, regardless of my motivation, I would say it makes sense for this PHY 
to support suspend and resume.

	Marco



