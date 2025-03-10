Return-Path: <netdev+bounces-173706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26306A5A71B
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 23:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8823AEC15
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4AB202979;
	Mon, 10 Mar 2025 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dR3+7L9W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC71EB5EA;
	Mon, 10 Mar 2025 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645460; cv=none; b=Y2HzNZXwww5Nkl3qEJrGnsHMUbzGjpNSTT5pb89q0FLOLVi1PgSUGGXRitmKzyTXrGdlGQmPleQwDpODzHjNJxgYK2NDOri7cUo1tiERJWSBVXaxrN8iGxRQzeMaqGuZKGq/fsPhP0rmoIZl1FaERvVfcS4WTR/KYPy0PMPJIwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645460; c=relaxed/simple;
	bh=ZZPKfTff+4XkuWzowbB6+5yPpDikqeZUD868ViPhT+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=if6K76XqTYkfUvV1ogeDnMG/IwQ9UMx3ZQqNxiZlDed/4vneQvgY2/82nQX+56M9JegbVF1TnM9x7fXDj0tKLSmwU0NxJfuvZJOdNg5ipPyQU2A5eZTobUgou6Lh7ok30YHhtOtAd/3IgbIXKg7ChGBOhoc3ZPOz8BOP6xooX1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dR3+7L9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5A9C4CEE5;
	Mon, 10 Mar 2025 22:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741645460;
	bh=ZZPKfTff+4XkuWzowbB6+5yPpDikqeZUD868ViPhT+E=;
	h=From:To:Cc:Subject:Date:From;
	b=dR3+7L9WthtQJP4qMydaejDUY+OiFFgQL3U2Wbfyek52ZuVOIgzCQcxoZADvP2Cl/
	 WlKD1gcK9ZMCJm8vw9Adcicbwfp0jS9FO+d1ZUd0x4TCmt3s/Af08/D1MO7ZCQAHCr
	 MEFVQqYd0YOjjzwH2+8891ejkIGgyil6sEbxrkTvXy5fexL+JpTgE3NvVhJK4/gEmt
	 VK9+jnsLuX2tFPflgnQkoPZKRtmwGmGDlEalVlfhAM4vNqKDYbM5JpJ5nGVWaoJ2mf
	 zHOVGdRcMWCp7mZvhGuPIIPUKeewSUK8I/HIQR5Uex+dvsVQ+FdDvYhM6vKRHXHWBo
	 7jfoj+8dZg/wQ==
From: Kees Cook <kees@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Kees Cook <kees@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] net: macb: Truncate TX1519CNT for trailing NUL
Date: Mon, 10 Mar 2025 15:24:16 -0700
Message-Id: <20250310222415.work.815-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420; i=kees@kernel.org; h=from:subject:message-id; bh=ZZPKfTff+4XkuWzowbB6+5yPpDikqeZUD868ViPhT+E=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnn0yZIsjVuWrednc9NPYRbZMdRxZcL+C4LsBqVmc7oe GxjsJOxo5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCKHvzH8DyuoS7U9cLuslTU1 YOLdTZV9m77LRM+x3NcQX7uw8L3oFYZ/eh1sxw6Ib/63dP+XSqVTavXP6idNs//imb8/aHaLqU0 ZMwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

GCC 15's -Wunterminated-string-initialization saw that this string was
being truncated. Adjust the initializer so that the needed final NUL
character will be present.

Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
 drivers/net/ethernet/cadence/macb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 2847278d9cd4..9a6acb97c82d 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1067,7 +1067,8 @@ static const struct gem_statistic gem_statistics[] = {
 	GEM_STAT_TITLE(TX256CNT, "tx_256_511_byte_frames"),
 	GEM_STAT_TITLE(TX512CNT, "tx_512_1023_byte_frames"),
 	GEM_STAT_TITLE(TX1024CNT, "tx_1024_1518_byte_frames"),
-	GEM_STAT_TITLE(TX1519CNT, "tx_greater_than_1518_byte_frames"),
+	GEM_STAT_TITLE(TX1519CNT, "tx_greater_than_1518_byte_frame"),
+
 	GEM_STAT_TITLE_BITS(TXURUNCNT, "tx_underrun",
 			    GEM_BIT(NDS_TXERR)|GEM_BIT(NDS_TXFIFOERR)),
 	GEM_STAT_TITLE_BITS(SNGLCOLLCNT, "tx_single_collision_frames",
-- 
2.34.1


