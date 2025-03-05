Return-Path: <netdev+bounces-172164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD375A506BB
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 18:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BA916569F
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344BC24A076;
	Wed,  5 Mar 2025 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zf3QIoQi"
X-Original-To: netdev@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0835F14884C;
	Wed,  5 Mar 2025 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196889; cv=none; b=MCZ96lIGAz5ybCqRxP0ZzrEHwpxtnPKmKY8CAxPepZpEGXmTrQUBsdRb0jzvzbWz2wT7gwhQuScgg+RK+ox1sX4Fvfqbggh4/V6cEBmYzgMUApcVXHTdd1c2mE8/xfJOP0F0leGkmkkRLiPE8y16K115FH/+t8TIaXpIHcQPzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196889; c=relaxed/simple;
	bh=hugcNLK7G+QyyTiNYXE/xDFTWLzXxYW9o4rB5vGvSBY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l2VHARkU9cN7kBt2q5aJR5hXxQhuOZrcqRNAdZ8kIRJq2IsiBhz9PzCoRv0YgYeWdVYY+Xj4RaKzoZqeGQdlI7xrxz4yFK5LrTwWOMs9j+oEPPTvgYPtDHcihZeQdovTnerLw9J7z/5h77e0TLyI/husPqoHCyREcQ7n7EqZTE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zf3QIoQi; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 8FA37581112;
	Wed,  5 Mar 2025 17:34:05 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A6DF4328F;
	Wed,  5 Mar 2025 17:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741196043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vkPL5cH1HFXSJ/uIqPW2ORRCbhxLLXcEM9s5D6RXhYM=;
	b=Zf3QIoQi22T0aYkuRUJpTDLQS0JmHx+6xyKS6WPbQaJCkchctHMOcBFhMnh/8sOfHhZzx5
	rU5dpUUrQfiH/AmDpzuFm3yyUtVCc9hce1V1dXkLMJd3n3Zc+Xpr2CRD8chQoq3YK+GVZm
	F7YapjXv6vaIIPwmqWPUB4ys2Y88FLico5STPjEFDZB5yLtm/VdIRVPYgYRri41LFpEnX/
	yS58u+04aX4PX4iXhexFzIPJ0H9JTCPEfFIHg6r2h1hz+ZEGjp5HU4iwfWWa8fcw//xhgM
	4enav7UpmWhKuhsJNGhbSnrQt8kNzDAwcfds4rOlVm0MhADgJ8CtSxxojckoyg==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH ethtool-next 0/3] Add support for hardware timestamp
 provider
Date: Wed, 05 Mar 2025 18:33:36 +0100
Message-Id: <20250305-feature_ptp-v1-0-f36f64f69aaa@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPCKyGcC/x3MQQqDMBBG4avIrA2YYCj2KiIS7R8dKElIpkUQ7
 25w+S3eO6kgMwq9m5My/lw4hgrdNrTuLmxQ/Kkm05lem84qDye/jDlJUtZrjfXl7DJYqkXK8Hw
 8t5Egu8T4VQGH0HRdN8QPVsRrAAAA
X-Change-ID: 20241205-feature_ptp-5f11ec7a5b95
To: Michal Kubecek <mkubecek@suse.cz>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Xing <kernelxing@tencent.com>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehgeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthekredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedugefgudfftefhtdeghedtieeiueevleeludeiieetjeekteehleehfeetuefggeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhigihhnghesthgvnhgtvghnthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepk
 hhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmkhhusggvtggvkhesshhushgvrdgtiidprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

Add support for reading tsinfo of a specific hardware timetstamp provider.
Enable selecting the hwtstamp provider within the network topology of a
network interface.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (3):
      update UAPI header copies
      tsinfo: Add support for hwtstamp provider
      netlink: Add support for tsconfig command

 Makefile.am                            |   1 +
 ethtool.8.in                           |  41 +-
 ethtool.c                              |  14 +-
 netlink/extapi.h                       |   4 +
 netlink/ts.h                           |  22 +
 netlink/tsconfig.c                     | 153 ++++++
 netlink/tsinfo.c                       | 110 +++-
 uapi/linux/ethtool.h                   |  31 ++
 uapi/linux/ethtool_netlink.h           | 899 +--------------------------------
 uapi/linux/ethtool_netlink_generated.h | 821 ++++++++++++++++++++++++++++++
 uapi/linux/if_link.h                   |  26 +
 uapi/linux/net_tstamp.h                |  11 +
 uapi/linux/rtnetlink.h                 |  22 +-
 uapi/linux/stddef.h                    |  13 +-
 uapi/linux/types.h                     |   1 +
 15 files changed, 1262 insertions(+), 907 deletions(-)
---
base-commit: c62310eb2999e40545d0aa6f3a7489864b633607
change-id: 20241205-feature_ptp-5f11ec7a5b95

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


