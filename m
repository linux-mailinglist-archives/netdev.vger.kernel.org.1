Return-Path: <netdev+bounces-245772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5892CCD75F0
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 23:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9E323096163
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 22:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AB734403D;
	Mon, 22 Dec 2025 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="I3caB1Ys"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313F1343D6F;
	Mon, 22 Dec 2025 22:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442166; cv=none; b=WWuLWiKGXLabH9/OSdp0gW+6fyHjPogd/kMO4+yAcOnYCvW9P7VMdrGSBDKXO8eHYefRhZtShcFMOLQrum01/WzpecdDbea62WKW3xaexQDwyrq9XguHDM/DooLdDG3TwXO5GH7QOQo7P1kMGZTKqVSFjUoYXMbJK7bkBqIVpFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442166; c=relaxed/simple;
	bh=em6AuAjkhg0Miv5zFCn7aoCFEFKmUyO0s6Axg8mdbhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sYwKWKzzQxEuCK8LHMbZ8GIVIk8gCJlovJFO87Rfr1snGDL8oDEzxrveRovQb90AI0N1Utjf3Bjuyu2Cmip75LCyZwF0zU7FgIAhySsAzo9xagdCG6IR9M7jtMBJCjWGbzjze2nW0zBbD8bRk0AQRTTYyXl0YcFPOw6DqN1uAyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=I3caB1Ys; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 827F43D85112;
	Mon, 22 Dec 2025 17:22:36 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id mlXR9Zo6Iy6V; Mon, 22 Dec 2025 17:22:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BE5393D854B3;
	Mon, 22 Dec 2025 17:22:35 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com BE5393D854B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1766442155; bh=4sm3FPJlwRzqq+O5mhWZ8WmmFjK5dUSbglYFTFSLABE=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=I3caB1Ys33euK/mUJfaY+sppLAdch+HK8rJ8Srbv/IsyPZF7JA7zArbK0dX5KdAMK
	 R0RVJky5t70lgTbrNLFrb5v5gIuNaGGz42UQHlahEtMLZtuyg8OhdGLUT4OByB3B3Y
	 YwAthmj9koz+OQNWO+Qz6Qz8wtTb1KmTZH6wNq43XjexLhpRy8r0JdFH3V8ihZgDxW
	 JXrDNBKH7Z5qq/LOZ0mRE7ZjfrnvajLHiHCuVy08TjPukXOmrH7xMrjy7Ad3qFtFCY
	 bYJ8F5rW7gnkskHPxKb8pgKzaU0ab8bJMAk79A72QGfdc2qnNDACAIyxejZlGF5ZGd
	 cPrAj94VCRRvg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id P4Bla7W1GYSP; Mon, 22 Dec 2025 17:22:35 -0500 (EST)
Received: from oitua-pc.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 904713D85112;
	Mon, 22 Dec 2025 17:22:35 -0500 (EST)
From: Osose Itua <osose.itua@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com,
	jerome.oufella@savoirfairelinux.com,
	Osose Itua <osose.itua@savoirfairelinux.com>
Subject: [PATCH v2 0/2] net: phy: adin: enable configuration of the LP Termination Register
Date: Mon, 22 Dec 2025 17:21:03 -0500
Message-ID: <20251222222210.3651577-1-osose.itua@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changes since v1:
- rework phy_read_mmd() error handling

Osose Itua (2):
  net: phy: adin: enable configuration of the LP Termination Register
  dt-bindings: net: adi,adin: document LP Termination property

 .../devicetree/bindings/net/adi,adin.yaml     |  6 ++++
 drivers/net/phy/adin.c                        | 34 +++++++++++++++++++
 2 files changed, 40 insertions(+)


