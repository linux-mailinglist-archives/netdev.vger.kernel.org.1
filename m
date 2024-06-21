Return-Path: <netdev+bounces-105729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C684491283A
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051D21C250B7
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7F928DD1;
	Fri, 21 Jun 2024 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="jbBF76ew"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400A23765
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981020; cv=none; b=KLSbwQP7CPqnYBJZVaFb7OgpzJRSRwl/QdRRhBGimNaMIO+0L9BytzGZvr5tS/BOK6eS2jslZbG/T9KAO4OIsTc3pg1Vx5GPawTSTc3mp6x9Vb8iBMB2UzISGeFX04g/agxMJ9p4vfndUoPJV6/j7M1hS2P8JKlSIc+WkvA1bF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981020; c=relaxed/simple;
	bh=nrHtvVtg1VqB/zCZfx5txx+IqMCYu+1OKngLJ/UqrRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A1ax4YfdwdTFqBxyoW23OqiFMvz1YSEbeq7shHZpwosAIwUc5iorY7f0Uysiw05FCPYFlVobsO+Jb3rBznVe+H6YxYF57HK2SaMtLr/MZ4TOKGZ+kgSQZQHFAL3vCF/TeVtxcMnQ9q24XZQGCZZEDUN/OHWM/x5dmJCkKnd+xN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=jbBF76ew; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F3FE69C5A74;
	Fri, 21 Jun 2024 10:43:30 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id WkKgccRoDH6H; Fri, 21 Jun 2024 10:43:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3BACD9C5A85;
	Fri, 21 Jun 2024 10:43:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 3BACD9C5A85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1718981010; bh=nrHtvVtg1VqB/zCZfx5txx+IqMCYu+1OKngLJ/UqrRQ=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=jbBF76ewyHEZNRrU3AjtiAzhxMhgpkXumsPBss8fvE35eXvvr3PallrlXLfrFOYmG
	 mi5Dpjg6t7PQ/P5M6VAgFQ7lCBw3S0UIdJv/b0rnXXGSal3kilHn17kJzgYV/+2fTJ
	 fkGRdp7RMfgMu2TT8S/hJYrGq3srd4LGAwI1ZWRf+pUFzkpTZf+0tNzwQpp3hhO9vr
	 b9gGKE+sZ2/ttYKb1IP052oc4po+vBbiA29zsXhI1w1rfx63adxqEl9nKC2xFzxA7R
	 H2h4zK8PoPw2xEi6NlWWRBP28hJ/84P/n23LoderEOAQIF/IeQWCAQmATaBkJbalQQ
	 +PcajFkf9PyoA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id So7-OphWWoeD; Fri, 21 Jun 2024 10:43:30 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 034E99C5A74;
	Fri, 21 Jun 2024 10:43:28 -0400 (EDT)
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
Subject: [PATCH net v7 0/3] Handle new Microchip KSZ 9897 Errata
Date: Fri, 21 Jun 2024 16:43:19 +0200
Message-Id: <20240621144322.545908-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
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
v7:
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


