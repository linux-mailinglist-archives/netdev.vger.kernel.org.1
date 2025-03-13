Return-Path: <netdev+bounces-174581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F22A5F623
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F5D189D429
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF801267737;
	Thu, 13 Mar 2025 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eanflfkx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA75FB95
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873311; cv=none; b=gBVNlWvjw4cCPg9R2aDAicPsaMkBn9DTe3igMHXrpJCBYZ16uiX6Ad5CNZo68QtPIGwbC/0EeuJsEglXJ25Tgv+C1msrJM+raulIRqSfLBqN9dfeGk6jRFT6o0sQM9cVT9bdpFNdbF5h6gDSF6l1w6sLpLOWCcihuNJlNe8Cd5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873311; c=relaxed/simple;
	bh=49mlU3jlfQ+OJB24CLy6u/b1ijnUebR7yH2k5sje1WM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CEXFiWJPGoPPGtKVwyCTih+JR7OwWSpSP+UavY5fTRyVXImtEwgWQjo/P5YeOPO26jk8he79l+LgY68g/Hk2AnL+dZtLuqMhBxrOSA11Pf565RzloFIHQN89qJgNFxRTYpuPIPbVFC2k1Spns5pNEQcBW887RK9Agx7pjWr2Al4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eanflfkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363E1C4CEDD;
	Thu, 13 Mar 2025 13:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873311;
	bh=49mlU3jlfQ+OJB24CLy6u/b1ijnUebR7yH2k5sje1WM=;
	h=From:To:Cc:Subject:Date:From;
	b=EanflfkxMrG8jYCwEkdAX631UsF4dSbAJOxrPQnEhTjdjcg+IQQrvKSZBa/Dl4JVY
	 izEpVnKQQvJntU7EHbUzhJ6Rfr1N3crSuB8/HQWiTrh2bHhLoKC83plY+OMlw1JTak
	 a9iFmBr3p1WnGffilhlmkyQaOnjXT9NTebD+oDxWiqbmckJeG1N7TGzn89O4u/qi4O
	 AD4Bc+2mkaDKesdrgMt3SrR4yLmBM/zKkiB/zjzi5LQuLL1rT84IoSwTAwxWvNTDO5
	 L8wCtlLJ5VYnwSCpdP0hgE4C5sbJA6jEQILQbg1eUwIVraORtMBLg3a/XiW69oTyGl
	 p036eMbzYZpCg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net 00/13] Fixes for mv88e6xxx (mainly 6320 family)
Date: Thu, 13 Mar 2025 14:41:33 +0100
Message-ID: <20250313134146.27087-1-kabel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Andrew et al.,

This is a series of fixes for the mv88e6xxx driver:
- one change removes an unused method
- one fix for 6341 family
- eleven fixes for 6320 family

Marek

Marek Behún (13):
  net: dsa: mv88e6xxx: remove unused .port_max_speed_mode()
  net: dsa: mv88e6xxx: fix VTU methods for 6320 family
  net: dsa: mv88e6xxx: fix number of g1 interrupts for 6320 family
  net: dsa: mv88e6xxx: allow SPEED_200 for 6320 family on supported
    ports
  net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
  net: dsa: mv88e6xxx: enable PVT for 6321 switch
  net: dsa: mv88e6xxx: define .pot_clear() for 6321
  net: dsa: mv88e6xxx: enable .rmu_disable() for 6320 family
  net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
  net: dsa: mv88e6xxx: enable devlink ATU hash param for 6320 family
  net: dsa: mv88e6xxx: enable STU methods for 6320 family
  net: dsa: mv88e6xxx: fix internal PHYs for 6320 family
  net: dsa: mv88e6xxx: workaround RGMII transmit delay erratum for 6320
    family

 drivers/net/dsa/mv88e6xxx/chip.c | 68 ++++++++++++++++++++++----------
 drivers/net/dsa/mv88e6xxx/chip.h |  4 --
 drivers/net/dsa/mv88e6xxx/port.c | 55 +++++++-------------------
 drivers/net/dsa/mv88e6xxx/port.h | 11 +-----
 4 files changed, 64 insertions(+), 74 deletions(-)

-- 
2.48.1


