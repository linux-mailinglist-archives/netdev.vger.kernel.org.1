Return-Path: <netdev+bounces-103281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C166C9075DA
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758E71F22A02
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01229146A6F;
	Thu, 13 Jun 2024 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubimet.com header.i=@ubimet.com header.b="WZGBza/v"
X-Original-To: netdev@vger.kernel.org
Received: from mx2-at.ubimet.com (mx2-at.ubimet.com [141.98.226.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749122AEFE;
	Thu, 13 Jun 2024 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.98.226.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290744; cv=none; b=CM8PgE/jM9f65dbyQZDfglXGwRxOe33xnnY1sjVRDCJWyff+GZW7X/hmIp/FhnzNdcqOjEyCH+/t9tc5awDkDeSuIpYwkvFzwPuh1tzI81Kp3xly682ePnLKL3DXO4tJw8NfGBMjZeUzmtYTl2J/uzmm+sPr0oCljq5ON+o6XyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290744; c=relaxed/simple;
	bh=PkwrnxW49KXKombbCY1USp7kfKxbA1A4Nxf0R8gfIwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rUKrco1NV2UDI75RlqZQRnSTMBh7m9FMk9PyX5mnbgRdQgbTgePgH2lvSUkAktYogYo0nt9oA2zsGq2mYYW9c3dKFuwJYmGLb44J9BmxXLFseCTEj2+n9Z+FVaGBdZ0CyLOoezAU+P1SjX9dB9XNrzqVdgyrxcdkTrm7u01i3Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ubimet.com; spf=pass smtp.mailfrom=ubimet.com; dkim=pass (2048-bit key) header.d=ubimet.com header.i=@ubimet.com header.b=WZGBza/v; arc=none smtp.client-ip=141.98.226.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ubimet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ubimet.com
Received: from localhost (localhost [127.0.0.1])
	by mx2-at.ubimet.com (Postfix) with ESMTP id C44B481186;
	Thu, 13 Jun 2024 14:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ubimet.com;
	s=20200131mdel; t=1718290299;
	bh=PkwrnxW49KXKombbCY1USp7kfKxbA1A4Nxf0R8gfIwo=;
	h=From:To:Cc:Subject:Date:From;
	b=WZGBza/vR1BVuAri/u2N54duL+y8duDubz4EbM9DsDI9P4j3hPMe43QbdFOsL38/4
	 cLptxKndvu2vcCAEj4isopnHxeQe4lCsPg/ggqHS2tV5aBOszZtEyM6GnN0VWuQo+g
	 0aa2kKnPXVxztjMt/R0MAefJceEZkzdyh7/6fqTWqsJcc0n7kTjV4os//ZovOr+54L
	 gBft2rFd7cTRcCCIzji6cJ77fSBE+mF6q6pTBOpAQcfjR67oZyfKQwzscIoWbQ0ixj
	 5u24Ref3Up6u/+zN5WvhghGUmg1zfeve/bUY3iydHn19dqNvKAbu7kdoBCsWwfQM1F
	 Zqg249FAnq6fA==
Received: from mx2-at.ubimet.com ([127.0.0.1])
	by localhost (mx02.dmz.dc.at.ubimet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WwTyPJ8Qhyk8; Thu, 13 Jun 2024 14:51:39 +0000 (UTC)
Received: from zimbra-mta01.ext.dc.at.ubimet.com (zimbra-mta01.ext.dc.at.ubimet.com [10.1.18.22])
	by mx2-at.ubimet.com (Postfix) with ESMTPS id A425B81110;
	Thu, 13 Jun 2024 14:51:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTP id 91C3080771;
	Thu, 13 Jun 2024 14:51:39 +0000 (UTC)
Received: from zimbra-mta01.ext.dc.at.ubimet.com ([127.0.0.1])
 by localhost (zimbra-mta01.ext.dc.at.ubimet.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id VXqqTe2gBYSc; Thu, 13 Jun 2024 14:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTP id BD03380782;
	Thu, 13 Jun 2024 14:51:38 +0000 (UTC)
X-Virus-Scanned: amavis at zimbra-mta01.ext.dc.at.ubimet.com
Received: from zimbra-mta01.ext.dc.at.ubimet.com ([127.0.0.1])
 by localhost (zimbra-mta01.ext.dc.at.ubimet.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id hVaxFwn5rYsh; Thu, 13 Jun 2024 14:51:38 +0000 (UTC)
Received: from pcn112.wl97.hub.at.ubimet.com (pcn112.it.hub.at.ubimet.com [10.15.66.143])
	by zimbra-mta01.ext.dc.at.ubimet.com (Postfix) with ESMTPSA id 7210A80771;
	Thu, 13 Jun 2024 14:51:38 +0000 (UTC)
From: =?UTF-8?q?Jo=C3=A3o=20Rodrigues?= <jrodrigues@ubimet.com>
To: 
Cc: jrodrigues@ubimet.com,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:ETHERNET PHY LIBRARY),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 0/3] net: phy: dp83867: add cable diag support
Date: Thu, 13 Jun 2024 16:51:50 +0200
Message-Id: <20240613145153.2345826-1-jrodrigues@ubimet.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This series adds more diagnostics of the physical medium to the DP83867.
The TDR reporting is similar to DP83869, so there might be some interest
in porting this changes to that driver.
The TDR reporting in PD83867 is divided into segments (from which a
cable length can be extracted). Because the reported lengths do not come
in regular intervals, when doing cable-test-tdr from ethtool, the value
of the reflection is reported, but not the length at which occurred
(even though the PHY reports it).
Likewise, the configuration of measurement lengths is also not
supported in this series, for the same reason (it is theoretically
possible to do it, with more complex configuration)

Jo=C3=A3o Rodrigues (3):
  net: phy: dp83867: Add SQI support
  net: phy: dp83867: add cable test support
  net: phy: dp83867: Add support for amplitude graph

 drivers/net/phy/dp83867.c | 353 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 353 insertions(+)

--=20
2.25.1


