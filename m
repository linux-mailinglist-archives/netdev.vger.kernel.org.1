Return-Path: <netdev+bounces-179010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0262A79FFF
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 11:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A931892BE7
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 09:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93474224891;
	Thu,  3 Apr 2025 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="DG+lbhQB";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="HNXU8utf"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A134E2CA6;
	Thu,  3 Apr 2025 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743672358; cv=pass; b=qGgfeS39uCV62hakTjoSqgMw0PfbcGfuyKDr2yjSpjz3zn+ybfFavAoJbYIc04lgawZP9Qd2dlQkQysgJO1+TFpbfiEmIETokulPWmytp5TRld77oJavYT2Mg7CqW7T7KRq+OyuUxHcEL2+QpAZILgSgd27wsqrcrNuwKU3tE7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743672358; c=relaxed/simple;
	bh=ZaU3J1fmHydhssquNZyjdSb0tPHJaEyQq/qJztBvzzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Lz/ioZP7ZRZQlncrxd7IfE5kH91vLx4ppdU1Wzo9vPU72PCyj8IfQsyllAys/Ok/DeGyD7f1T22qibsxuIFlgA4CSnKo+C+0NeBYGawnjMdRAT8Bz8QvFci+XrtKT/cG9A14RExezzd7rzYt/jJoJxcdmVxjRFh6XG0gjyaGKR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=DG+lbhQB; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=HNXU8utf; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
ARC-Seal: i=1; a=rsa-sha256; t=1743671270; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aSU0BnEGRHh1YGEkj1AcjBGVdUqYvhvRj9zM1Z8YE9rblhYlGD/f1357z/5Uad1U/j
    bPIXBNh+La7kf//NVMs8oEBn0st8PmlNl1cslIUHI/aWekWN6RFeP9CZASzrcg7Ayv6R
    jJ9bopWzoGKFyLUxPcxRyfYhxbm1PWO8ZDLrlh2oL8ZRDgZBgc3OGxjuIhwJo4puxhWw
    cGMrakGvvzqTrlv/p/UgJ/kK/eOn4OlpRAyH8JJRXE1IFAiE6tiqQTp2bN75ux4WUocH
    b0R97GIUU6eXo+SQXGV6dlC9ebi6luzL77v0T8byENZSymiBxid4n2LSXPuaoIj3yqOK
    E7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1743671270;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=QK5fQh3feLuhI4LW5vvRHPmtihZ/zFwSfYaWfAjF9UQ=;
    b=DKmvOOJ5aR905E699cu+3w7CV+DzRrdxqTb0+Jp5GQ1TGnqMjpqHpx2FSEziVx/vJ4
    xZlYi4QyIOT9jVl+Cdb8fUsbkoIluBDOPluaFvM2rzI0m7tqdwV0RW2FjbK6eLpdy5pl
    e6w1kNmksUB9k7P681faJbKmPoHHFqW3pR2MmObKp/F1HewivKA0URPTpc/VXagnf6YW
    qru/fpgAhE2SUiMQfZHD8WgkGMVQyGkRkbK0sIlfg2PqqNwwL7jFh3DzfBJ0VEpHzcQ9
    0mYJW4+ix9TSBlEZPUD8W8ldVqCpoOLg4qpE0r2tjN4bsbet+wLwI5TzpTE7U8BVxEH/
    390Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1743671270;
    s=strato-dkim-0002; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=QK5fQh3feLuhI4LW5vvRHPmtihZ/zFwSfYaWfAjF9UQ=;
    b=DG+lbhQBjeBZzuVRTuy2Z9sF/fVlfTby5jb9JmHNzvPZn+OgBchpyXAfAcanlg0pxa
    NASM48wp+33BvP/bwScPNJMSoCm/UEzyujeY2B6bWz4mQuzXWKx14j1tmaszOPk4qHsE
    bG0ErNZZg5F9w7qsZ+4FdXrL1ZGyfg8PQ1MAVMdkD6kL880gHrcQlceJZqO551iTtye2
    5btormhFEwKlJXQzcCHfl6/qOusM+1MqHpFblsO7A/061DfcJUG51aGAp1e2IQDZrYsd
    pZLdbZXFwH5KyWFlMWy5qLIJOfpuQpMIKrvQvVMueJ6d/4w0Yvxyfsvtngrp78i7peLd
    RAJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1743671270;
    s=strato-dkim-0003; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=QK5fQh3feLuhI4LW5vvRHPmtihZ/zFwSfYaWfAjF9UQ=;
    b=HNXU8utfTU1nNRhqRN8h2j2qVMY+dd9Cbtl1j8OKhxYyPWoWO7ce6V9yQijOmZSBhY
    1bADIml/aZMWJj2vWsAg==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id J2b11013397ndSj
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 3 Apr 2025 11:07:49 +0200 (CEST)
From: Julian Vetter <julian@outer-limits.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Vetter <julian@outer-limits.org>
Subject: [PATCH] Remove __get_unaligned_cpu32 from netronome drivers
Date: Thu,  3 Apr 2025 11:07:43 +0200
Message-Id: <20250403090743.3878309-1-julian@outer-limits.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The __{get,put}_unaligned_cpu{16,32,64} functions are deprecated, and
only a small number of drivers still use them. So, replace it here with
the more generic get_unaligned() function and just cast the input
parameter.

Signed-off-by: Julian Vetter <julian@outer-limits.org>
---
 drivers/net/ethernet/netronome/nfp/nfd3/dp.c | 2 +-
 drivers/net/ethernet/netronome/nfp/nfdk/dp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfd3/dp.c b/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
index f1c6c47564b1..08086eb76996 100644
--- a/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfd3/dp.c
@@ -779,7 +779,7 @@ nfp_nfd3_parse_meta(struct net_device *netdev, struct nfp_meta_parsed *meta,
 		case NFP_NET_META_CSUM:
 			meta->csum_type = CHECKSUM_COMPLETE;
 			meta->csum =
-				(__force __wsum)__get_unaligned_cpu32(data);
+				(__force __wsum)get_unaligned((u32 *)data);
 			data += 4;
 			break;
 		case NFP_NET_META_RESYNC_INFO:
diff --git a/drivers/net/ethernet/netronome/nfp/nfdk/dp.c b/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
index ebeb6ab4465c..ab3cd06ed63e 100644
--- a/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfdk/dp.c
@@ -779,7 +779,7 @@ nfp_nfdk_parse_meta(struct net_device *netdev, struct nfp_meta_parsed *meta,
 		case NFP_NET_META_CSUM:
 			meta->csum_type = CHECKSUM_COMPLETE;
 			meta->csum =
-				(__force __wsum)__get_unaligned_cpu32(data);
+				(__force __wsum)get_unaligned((u32 *)data);
 			data += 4;
 			break;
 		case NFP_NET_META_RESYNC_INFO:
-- 
2.34.1


