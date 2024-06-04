Return-Path: <netdev+bounces-100495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1961A8FAEA9
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C698A287ABA
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B213143C74;
	Tue,  4 Jun 2024 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="nuRBnMo+"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F67C143C59
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493035; cv=none; b=pnAgLG98H/BDdJvXb9dizbRLmy9VlfacJsY+vEuZ9B4mYXCVub8wq295J9pFnCQ1bc0Hke3iekbTIGBI14f6lITCp1JQyxzRQ5VbpEeBKoRGzb6KrPCWaAltWEQKjFgBhvtrnfFYOpw2J2W+ONz2fcjJi2+qW1dGo105/WroWII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493035; c=relaxed/simple;
	bh=a4iphWaccw/q2HUMvJWpz0NeEO8dRPnowHlnUZq4sIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jwmZtSxFwpLi7E5qgkLxvLat832sfJGLwlsSdx1Zixw07lRFx7p8I+uasbKMMHL0y2Yul3rydg8wB4KXXt3UUioz+bUnI6v9oTLRWZHvUKkLDGO6QQUcbAuECGOXpbpouIOctETkkEXoaAaUrzJ1EHjsg8TBfmnUdtnq9k1ui4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=nuRBnMo+; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 452E09C5442;
	Tue,  4 Jun 2024 05:23:45 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id fcz5WnUWzGOr; Tue,  4 Jun 2024 05:23:44 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7F9ED9C56AC;
	Tue,  4 Jun 2024 05:23:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 7F9ED9C56AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717493024; bh=a4iphWaccw/q2HUMvJWpz0NeEO8dRPnowHlnUZq4sIY=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=nuRBnMo+yPqA0Em9C5o68QlVgbhaXUQEoOIVCYxDM0OSpV9fMySPbQNNnzb7CGxsc
	 yr7qynnUMrqHPDNglCXvsq6hwv39iLuYcVByCU87FVef+Tt2FsAUe1i/IQFp5rtX8h
	 C/BngxFLcuh9TU8eG1XMv1dWw5tu1dLurua0zvKu5nFQ66w1rBtDNFGZ1EIng3V7Y6
	 ikDm7bk8OVyFsMFnXlMvB7utwmVIq8TogGz32eAK+yPw8cEW/trn4KSDLUPFiNePZG
	 OHu4AHyoR3tbWhTIx/T4q/0MEu3RvM07qQkRaVFeRNDRpanKl2xLgksZ3TGk4APCY1
	 MWvVElh/qDSiw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id MTdrFwc50d0X; Tue,  4 Jun 2024 05:23:44 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 4477A9C5442;
	Tue,  4 Jun 2024 05:23:43 -0400 (EDT)
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
Subject: [PATCH net v5 0/5] Add Microchip KSZ 9897 Switch CPU PHY + Errata
Date: Tue,  4 Jun 2024 09:23:01 +0000
Message-Id: <20240604092304.314636-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Back in 2022, I had posted a series of patches to support the KSZ9897
switch's CPU PHY ports but some discussions had not been concluded with
Microchip. I've been maintaining the patches since and I'm now
resubmitting them with some improvements to handle new KSZ9897 errata
sheets (also concerning the whole KSZ9477 family).

I'm very much listening for feedback on these patches. Please let me know=
 if you
have any suggestions or concerns. Thank you.

---
v5:
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



