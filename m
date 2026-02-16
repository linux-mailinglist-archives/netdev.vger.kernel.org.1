Return-Path: <netdev+bounces-258833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zhYVOH6mkmnqwAEAu9opvQ
	(envelope-from <netdev+bounces-258833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 06:09:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB51140EDE
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 06:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE34F300BCBC
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 05:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A72A2957B6;
	Mon, 16 Feb 2026 05:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=poleshift.se header.i=@poleshift.se header.b="2tlVPRf/";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="hGCgZMxw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=poleshift.se header.i=@poleshift.se header.b="LgLghBYF"
X-Original-To: netdev@vger.kernel.org
Received: from e240-2.smtp-out.eu-north-1.amazonses.com (e240-2.smtp-out.eu-north-1.amazonses.com [23.251.240.2])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37023EAA1;
	Mon, 16 Feb 2026 05:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.240.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771218554; cv=none; b=q7Z1zEgqmLrv1ioonWCwPiUl7mdTBLTjp7OlFUtdVd5cW5U7ekl9tqFYwMzbZYgl7U30fsH05cWxyQDXuebsiaPB3bwwoAodgfCtdEM9P3yUNHiDEVzSzx58DsrnsuL2klUCBPJ5tZ0J1ibj5lbe8zO21ksFTTvZSo3bfniCE8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771218554; c=relaxed/simple;
	bh=zTF0n3ZPca6HiZM8IrHdiI8Fauoz8CjcIXBDOiAT/tY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:Cc; b=MkJP/rEwODhXLHov1h9vAW/ZyC901iHQYzZ8FbeXyESHlX+cjJSEOsN5EbPj69fzfKj2YG/YF/guiuNA9UsVpy1j5w8/YpWo1zskZ4fYeQgx2YI+GV7eDb7s1IiDUa3WJXqU3r94rIYbO5YkMZd0yCc+ZEhDEdkoae4vGIX5Iww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=poleshift.se; spf=pass smtp.mailfrom=eu-north-1.amazonses.com; dkim=pass (2048-bit key) header.d=poleshift.se header.i=@poleshift.se header.b=2tlVPRf/; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=hGCgZMxw; dkim=fail (0-bit key) header.d=poleshift.se header.i=@poleshift.se header.b=LgLghBYF reason="key not found in DNS"; arc=none smtp.client-ip=23.251.240.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=poleshift.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=n6aiayff3zq3manwyovyvpolm4pou2ef; d=poleshift.se; t=1771218550;
	h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:To:Cc;
	bh=zTF0n3ZPca6HiZM8IrHdiI8Fauoz8CjcIXBDOiAT/tY=;
	b=2tlVPRf/B3sugyh2Ov95zh6IcX4/vPt/UlhFsFt3Bi7SRyvsUVqq+o68aWVaAOf4
	41HfxEjCo80mnxA0T7cBsERGhdgU3CgzIQJBqj4xxdqSIZTKJ2Tfmtn6R0iZWh8u/ii
	ZCVppHGMyvl7iQ6HsD1D8NrI5Q3rvmwfiolNtyaCj21owA6cUGoegoHLT5E4DkYOlZj
	kUNiy1Biqzj4yquBSUWkSEWosLn7RHh0I9r67I24h5+j0TgtYsMyuTtTAQwrvXDL+P2
	SvbTmnc83yxpCNt7gs+AAirDtQXXTvpskvuv03XNfRNyOnztsqmP65Ze1d1lLAUmmmf
	5ameCjNobA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=icdr7g7fbtu2nwxgaimytihkt42k3kiy; d=amazonses.com; t=1771218550;
	h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:To:Cc:Feedback-ID;
	bh=zTF0n3ZPca6HiZM8IrHdiI8Fauoz8CjcIXBDOiAT/tY=;
	b=hGCgZMxw6rviyFJGd/SgLl7Xvnpxo/QbqQXXsx0W1wFDP1qltlNNAMhMtSIQF+RX
	iLmTAvzjvu/bRmiIqzHo1F5KuLKnskl+O3bxPortzYLQM1TUeUI4MHIs4YwBQuPBuBd
	ECu0ChHUtIJsTkyQALSo47Sa6Xx00gcr/vG6qLNc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poleshift.se;
	s=20230429; t=1771218547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e8XzRtgRSeA6LjMJkop2UgCC+9WgG8clys3TIusKi84=;
	b=LgLghBYFYG2rfiSdHFvLfyUXiUYB9YejJCrL4AbvAJ/t7Yg6IUevW1TTCVpE4iXGhQ449t
	TpuppGKPSkh/sCP1dWi2UUTkdWlJ3aZFRn5ZN6g6/fhCzxOIYpWeSmUkDIOPV37cMxh+8r
	pwHYslGm0HKQXDYeBfnOxP76JbTo6ZQ=
From: =?utf-8?q?Martin_P=C3=A5lsson?= <martin@poleshift.se>
Date: Mon, 16 Feb 2026 05:09:09 +0000
Subject: [PATCH v2] net: usb: lan78xx: scan all MDIO addresses on LAN7801
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <0110019c64da3c2a-d4a4adbe-c78b-4051-a95b-e7ed5db247a1-000000@eu-north-1.amazonses.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0K6dkynViSuuIdhMcJgJyKQDiEQw
 t2tXMDlez///80oR2E192wzkWdRGfoE7pSZOlD/YpAmsXHW5dahh476W7EsMIYVPqRvaGUB8il
 tGK/ka5OqY+Skj9lHlTiITkNcj5cZf/bP4IyAcHkSobVFjuzLcehYg7TTWdlU+75/AZI5RT27A
 AAA
X-Change-ID: 20260214-lan78xx-phy-mask-fix-a4260de15a4c
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>, 
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>, 
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	=?utf-8?q?Martin_P=C3=A5lsson?= <martin@poleshift.se>
X-Mailer: b4 0.14.3
Feedback-ID: ::1.eu-north-1.nVsitYrO9p3qnPLcZXP017jV0c/PN62ZbS4lYSSQpnA=:AmazonSES
X-SES-Outgoing: 2026.02.16-23.251.240.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[poleshift.se,reject];
	R_DKIM_ALLOW(-0.20)[poleshift.se:s=n6aiayff3zq3manwyovyvpolm4pou2ef,amazonses.com:s=icdr7g7fbtu2nwxgaimytihkt42k3kiy];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258833-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_PERMFAIL(0.00)[poleshift.se:s=20230429];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[poleshift.se:+,amazonses.com:+,poleshift.se:~];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin@poleshift.se,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_MIXED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazonses.com:dkim,eu-north-1.amazonses.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,poleshift.se:email,poleshift.se:dkim]
X-Rspamd-Queue-Id: 3DB51140EDE
X-Rspamd-Action: no action

The LAN7801 is designed exclusively for external PHYs (unlike the
LAN7800/LAN7850 which have internal PHYs), but lan78xx_mdio_init()
restricts PHY scanning to MDIO addresses 0-7 by setting phy_mask to
~(0xFF). This prevents discovery of external PHYs wired to addresses
outside that range.

One such case is the DP83TC814 100BASE-T1 PHY, which is typically
configured at MDIO address 10 via PHYAD bootstrap pins and goes
undetected with the current mask.

Set phy_mask to 0 for the LAN7801 so that all 32 MDIO addresses are
scanned during bus registration, allowing any external PHY to be
discovered regardless of its address.

Fixes: 02dc1f3d613d ("lan78xx: add LAN7801 MAC only support")

Signed-off-by: Martin Pålsson <martin@poleshift.se>
---
Changes in v2:
- Added Fixes: tag
- Link to v1: https://lore.kernel.org/r/20260214-lan78xx-phy-mask-fix-v1-1-3baa100861e4@poleshift.se
---
 drivers/net/usb/lan78xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 00397a807393..9d8f1ff7028d 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2094,8 +2094,8 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
 		dev->mdiobus->phy_mask = ~(1 << 1);
 		break;
 	case ID_REV_CHIP_ID_7801_:
-		/* scan thru PHYAD[2..0] */
-		dev->mdiobus->phy_mask = ~(0xFF);
+		/* scan all 32 MDIO addresses for external PHYs */
+		dev->mdiobus->phy_mask = 0;
 		break;
 	}
 

---
base-commit: ee5492fd88cfc079c19fbeac78e9e53b7f6c04f3
change-id: 20260214-lan78xx-phy-mask-fix-a4260de15a4c

Best regards,
-- 
Martin Pålsson <martin@poleshift.se>


