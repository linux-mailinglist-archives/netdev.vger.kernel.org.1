Return-Path: <netdev+bounces-99758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABD18D646E
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 16:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177ED281062
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 14:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B21518C22;
	Fri, 31 May 2024 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="siFpLNVH"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F32F17C6D
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165485; cv=none; b=H2Tv4MTQU1Ml9/C7Erlg5s+G1flLvVSjFwqapx+L/YcKUWm8+fGNtz3iRa6bCtqjXb/AbGZBPlrKhJBa1Zh5Lsrkb4QQIoIbMOkm5+KXzEZEWnJ5lbnl2nSryYbNLqYNfiwkWjisK1NPlBanHm9BoBC9nQu5w6dHi1oHQElFtlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165485; c=relaxed/simple;
	bh=UltD4fqbL64ul6YVTNw6uYLOOrMi/v4Zd1o+VQp7yk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PKc5jVCZ8nZsU5ZqNP2A7uBEkOz9giVLj05ajAoUfKKDLkc3WTnPggSfnwc7Sv7SEBj1TM9NNIRBGrpcv3v9T8Er5NztQDGX8XNYjeoegUoS/0gvWLGDMoSkHdmEfrdwYHTA3zkxu8iyV/nIiIiOTdyIjuTJLo+aL6mUuVOcTRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=siFpLNVH; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7285C9C5985;
	Fri, 31 May 2024 10:24:40 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id H21nVq2qIuj9; Fri, 31 May 2024 10:24:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id F28039C58F5;
	Fri, 31 May 2024 10:24:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com F28039C58F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717165480; bh=UltD4fqbL64ul6YVTNw6uYLOOrMi/v4Zd1o+VQp7yk8=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=siFpLNVHeiM79Ga691/PkTAMg6xyeB5ZFiJdswqvHwYmB2mpxTeoGX0ksFQ0Y/ZXZ
	 0NBmZb/6nkaxvh+JdPLkwDRC8J0RKGkOnMOu2g5W0+kHbEVre4Uauo+WHtAcNr+fAo
	 HQ52NHAl6SpTEpnpfWQDaHu2+PKfLdVy6YP3Zvs5rqrJxZq4sVAw1XMCPUKCxLsW3O
	 H5RKNotX+6JInTHsAgQ4E4wMDgZYgC6KBd0lXWsqRjV2Khq9tzRKcg1GZwNJxZnCFH
	 AkEqZa36qx2qPBR0POzvcHao+Vktdlue3z4GTb5jYMElYcqvje0cDHl7LMqBozRyv5
	 Z4jHzMbpuYbKA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id eEGV6mXSflgB; Fri, 31 May 2024 10:24:39 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 15F869C405E;
	Fri, 31 May 2024 10:24:38 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com
Subject: [PATCH v4 0/5] Add Microchip KSZ 9897 Switch CPU PHY + Errata
Date: Fri, 31 May 2024 14:24:25 +0000
Message-Id: <20240531142430.678198-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
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
v4:
 - Rebase on net/main
 - Add Fixes: tags to the patches
 - reverse x-mas tree order
 - use pseudo phy_id instead of match_phy_device
v3: https://lore.kernel.org/all/20240530102436.226189-1-enguerrand.de-rib=
aucourt@savoirfairelinux.com/


