Return-Path: <netdev+bounces-103541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0809D90884D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20DD28C0FE
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CA619ADB6;
	Fri, 14 Jun 2024 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="gcdgfUiM"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C54199E8C
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358417; cv=none; b=GIzzdcoffhnMJ/jRINBmPa0AKa0zAxFE4WsayIaZyQT4OnmggXqV8zzXketI2/1SyaN4oKh2SiaPGADDA4H1UnL1WoiHJGUPEqTBBep/ueuB9qW2fiSLZllDSolOlgovBVZbnqsOnTOnV7q0aZsJmnSB0SyEAscUeOIEnQiG0LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358417; c=relaxed/simple;
	bh=dtCrxUoBRggYTum2XgZdc6h6BZpxJXxEcYVuabREFNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZZ9L/rOGYkmu5etJQda/kgTf3LWnXeyom0I7V+p9jPLvLNTUKCEvDoqmudjYX4bI2vqZlL0HgUrlyQ/pDiU8ZYKHVDrRYtdP1kSz4MOF8SROZ6OAhDT1m/Bor+maqAhC4iaNdbFaAZ6s5sTTdrAw/gAXLaTAfz1rkcGwycYW5As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=gcdgfUiM; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 38A799C06D2;
	Fri, 14 Jun 2024 05:46:52 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id TrFG7NHj4jlJ; Fri, 14 Jun 2024 05:46:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9219D9C58EF;
	Fri, 14 Jun 2024 05:46:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 9219D9C58EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1718358411; bh=dtCrxUoBRggYTum2XgZdc6h6BZpxJXxEcYVuabREFNQ=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=gcdgfUiMAmc68im8yFMHL0rAJyee4IrkpfTG2WHbb+87lKwIAYK/xY4Eg9EFhO8kE
	 9QQGhvxhDviKsLhOySMiHPs41YXxkBPushI5JE2LzKNiPmwN0F2Lk+7r8r+94V627r
	 p5uYuXxkX+y5Jsq7RW1cjNyu8HufPb3z4Z3IRDko/Lx10Yw5F3wzpAb8S3IqJry9bn
	 kJGylAP3HR/Eq0HfkMZs+E6PIeXN0PLXBuLolKkCfrxPyyF8g4PoSg0Em6yoZeaWUV
	 rqT6rL3Gj1q84/RmajYrrS7GvRqjo8MoqEXzt1xfe338MttLDCG9UWfX4HMubWO4L0
	 dPPDg0EaKuIww==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 7n3GMCWmGc4a; Fri, 14 Jun 2024 05:46:51 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 327539C06D2;
	Fri, 14 Jun 2024 05:46:50 -0400 (EDT)
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
Subject: [PATCH net v6 0/3] Handle new Microchip KSZ 9897 Errata
Date: Fri, 14 Jun 2024 09:46:39 +0000
Message-Id: <20240614094642.122464-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
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
v6:
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



