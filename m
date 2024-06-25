Return-Path: <netdev+bounces-106570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88940916DBD
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D311C22C9E
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19E017082D;
	Tue, 25 Jun 2024 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="L/sr8IJO"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5712614C59C
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331620; cv=none; b=pBaOBmHInnuX0XZFjPlvYo7qQvmWyZv42jMhoPgCrPLaajyUJNoYpSTALwZTcvAZealzXFM6qzTilfetwwwjaKZ6yuZ3D9En6DlV2gfKi/RUJ5lT64pf49YPTpvkO/yNLEjK4xQi+n50c00iPXzlhXEme/vIcciBCix3SXFDDmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331620; c=relaxed/simple;
	bh=dZ2uE05uHAVQOEUn8hGjYOZSVq30WDBnsYrUNfbPpR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b289y/0Um4/6LcSyJe1ToHUQIj8uAXtZRSF6vRh316gx1HFrQsvRptIPdjOMNPA/wFVLDV2icGLytqrcwPeJ2UsuVbEo04Dc9MHkVPpt6Ol7k01MOiu1hNDDVfmWBaDkwNg+fLHG5r060c2+WXPbLKyEkzKMEtRtpGwpOSl/D30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=L/sr8IJO; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 430789C57BD;
	Tue, 25 Jun 2024 12:06:51 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id MVKp1bS9hbx8; Tue, 25 Jun 2024 12:06:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 81C219C59F2;
	Tue, 25 Jun 2024 12:06:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 81C219C59F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1719331610; bh=dZ2uE05uHAVQOEUn8hGjYOZSVq30WDBnsYrUNfbPpR8=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=L/sr8IJOo6MkaHo3pCBWhwjOCXMkn2I+fjOpg7x7nuCbZyHgN/fuR0c49lZ5XtlUo
	 lk6jd7C4QjJynBrfgNoILUaXEir+k6hcWWiS43bXtOhP31w4OTYpoeXQo+5aOlVjfK
	 9gqksuiJsvuCB0En+M2zyvA6xz8zUAhPvO4HQ4s1NH2E5xuG21NuibPPGpXfkNC0ZD
	 V9/EcSo3ozHjQZW7D5zrV3Ne9btdSlFM4B5NY59CrZPA8WDhgQqVH4BJr8ZRbMbhXP
	 1m0g/AFNC0LiD+bbAZu/7Fiyb7LMkC2nFOkmFZvepILAams1fiRxWqu1ADr8lyyAz/
	 beJ3JBotps2MQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id EYM5afakkMP2; Tue, 25 Jun 2024 12:06:50 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 4BBC49C57BD;
	Tue, 25 Jun 2024 12:06:49 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	horms@kernel.org,
	Tristram.Ha@microchip.com,
	Arun.Ramadoss@microchip.com
Subject: [PATCH net v8 0/3] Handle new Microchip KSZ 9897 Errata
Date: Tue, 25 Jun 2024 16:05:17 +0000
Message-Id: <20240625160520.358945-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches implement some suggested workarounds from the Microchip KSZ=
 9897
Errata [1].

[1] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Produc=
tDocuments/Errata/KSZ9897R-Errata-DS80000758.pdf

---
v8:
 - split monitoring function in two to fit into 80 columns
v7: https://lore.kernel.org/netdev/20240621144322.545908-1-enguerrand.de-=
ribaucourt@savoirfairelinux.com/
 - use dev_crit_once instead of dev_crit_ratelimited
 - add a comment to help users understand the consequences of half-duplex=
 errors
v6: https://lore.kernel.org/netdev/20240614094642.122464-1-enguerrand.de-=
ribaucourt@savoirfairelinux.com/
 - remove KSZ9897 phy_id workaround (was a configuration issue)
 - use macros for checking link down in monitoring function
 - check if VLAN is enabled before monitoring resources
v5: https://lore.kernel.org/all/20240604092304.314636-1-enguerrand.de-rib=
aucourt@savoirfairelinux.com/
 - use macros for bitfields
 - rewrap comments
 - check ksz_pread* return values
 - fix spelling mistakes
 - remove KSZ9477 suspend/resume deletion patch
v4: https://lore.kernel.org/all/20240531142430.678198-1-enguerrand.de-rib=
aucourt@savoirfairelinux.com/
 - Rebase on net/main
 - Add Fixes: tags to the patches
 - reverse x-mas tree order
 - use pseudo phy_id instead of match_phy_device
v3: https://lore.kernel.org/all/20240530102436.226189-1-enguerrand.de-rib=
aucourt@savoirfairelinux.com/


