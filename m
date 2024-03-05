Return-Path: <netdev+bounces-77402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B826787191C
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 10:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E051C224D0
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 09:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2960E50A69;
	Tue,  5 Mar 2024 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ZVqPsqtt"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C6E524B1;
	Tue,  5 Mar 2024 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629744; cv=none; b=IfsQeKDIk5kCb+fFLWvrnKKbVGzTIGL2Wu1xWmdkIRPco1lEksDmKs0H7XD3e4y8B6TH8QaHVM2JyFYQIjtJDf/8WGmDKvOgoqvFjiFqM2j9E9dw3o/souUH2Bk1/6hmBpYltpCzCBekirAD1Ozr9ENpQmTM/Mzaya9dPqflCCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629744; c=relaxed/simple;
	bh=out086WSrvstHEIMu8QqH01kC8zEAyaQBd3Jmjvo8Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=D/+iHgFpnuSnNgWQii3eZWgApOVluNu3Yc/Xt4E3MfTSBZG8TJH6XHnq+aEA783uXp1/yuBQWwLb5hEzNa+WtngjtGi1Z/e6CLYhxHxfGFav7E5kXFyAfizU4dn31Jmsgods+9vS6yoRhzdxOO+lcaeyOfdM0ImGd+ieaQ/B53w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ZVqPsqtt; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=SfymB13QiR2O8kiRFaHChQYzzDdWtutw0JvQgASC+8E=; b=ZVqPsqttdp4qx5xUVaxs/reaja
	4oeWRQJASWcs0maQ7OFkrIvmul4b0HUwIMNqXXLgfAvh/eVKMaHsv9OhRo1iQS6tzbNlxFD2uJKPy
	BTF/Z/v78bVuANFKOjozy96ZTkl5ZLeH9GgHR2XmYpDDjgximEAFJA5tXwnFIs78FdiB/fOqyxJIJ
	xpd2eqwhOxMOV+JEQ98bcyiCPE+neny9Qsw2f8jw/4Zra0oNO2JPUS3WjpnOwhIox9uQDaLiasDkE
	4+PImH1iLvYpYzkSGtPN/WnfF1xgQk6XQRPGOqdiinNHVeVCGcI4PQu5vgkWimU5tEQZ/JrYkuWDg
	8cB70EuQ==;
Received: from 38.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.38] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rhQn1-000Dfy-TK; Tue, 05 Mar 2024 10:08:47 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Prashant Batra <prbatra.mail@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf 1/2] xdp, bonding: Fix feature flags when there are no slave devs anymore
Date: Tue,  5 Mar 2024 10:08:28 +0100
Message-Id: <20240305090829.17131-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27204/Mon Mar  4 10:25:09 2024)

Commit 9b0ed890ac2a ("bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY")
changed the driver from reporting everything as supported before a device
was bonded into having the driver report that no XDP feature is supported
until a real device is bonded as it seems to be more truthful given
eventually real underlying devices decide what XDP features are supported.

The change however did not take into account when all slave devices get
removed from the bond device. In this case after 9b0ed890ac2a, the driver
keeps reporting a feature mask of 0x77, that is, NETDEV_XDP_ACT_MASK &
~NETDEV_XDP_ACT_XSK_ZEROCOPY whereas it should have reported a feature
mask of 0.

Fix it by resetting XDP feature flags in the same way as if no XDP program
is attached to the bond device. This was uncovered by the XDP bond selftest
which let BPF CI fail. After adjusting the starting masks on the latter
to 0 instead of NETDEV_XDP_ACT_MASK the test passes again together with
this fix.

Fixes: 9b0ed890ac2a ("bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Cc: Prashant Batra <prbatra.mail@gmail.com>
Cc: Toke Høiland-Jørgensen <toke@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a11748b8d69b..cd0683bcca03 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1811,7 +1811,7 @@ void bond_xdp_set_features(struct net_device *bond_dev)
 
 	ASSERT_RTNL();
 
-	if (!bond_xdp_check(bond)) {
+	if (!bond_xdp_check(bond) || !bond_has_slaves(bond)) {
 		xdp_clear_features_flag(bond_dev);
 		return;
 	}
-- 
2.34.1


