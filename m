Return-Path: <netdev+bounces-179534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AA3A7D81D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3C8188935D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 08:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A1E2253EF;
	Mon,  7 Apr 2025 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="syv7AMso";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="PWbDy5LH"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD1E225388;
	Mon,  7 Apr 2025 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014985; cv=pass; b=AzMyFpr7+0LuPi1mOdah880hb0RaacKnAYZQYO7Mb7RLyosczwxRgp+6onAg6H310r9IdK503HwQApXBSjivDY8q6lr7aibZZTLgKAqeOxnul8uY++9QM0o7CjyidNs23unBeZ+6amfVVZKps6iDHQqzxzXQNhmKJuyBenqDuVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014985; c=relaxed/simple;
	bh=kromgZXIv13kuVYm/VYq9Vqu5/atevF4A48Q60kqXWo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dCT/7FUECIIleWbyd3JijusIglARKYUvgJdIt6aBlWGi+llia3MiqDl/dS9wZMtE4KAxqpuy2KHCsBuQoCDL1UxzrOG1Zr2RAk1zkTj5o0LaSdi7c+7/cnCWcnjIC9wbR9CW/hHU7B6nDvwJEz98GIwH0EiABXr2OtmBrtID9CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=syv7AMso; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=PWbDy5LH; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
ARC-Seal: i=1; a=rsa-sha256; t=1744014802; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ar/samsZZ9TJLPgT2eaggsLuoFDEY8sucy5XZhtj4ykVNPFL8v3mTq7MtIq6BizGYI
    mm0HvsKeaGhFbhcOzkSjXbN/h1lT0Ygc4JAt34w39HeJsyThSB7Q/RVQ9QN6C36WiRdK
    n+ss8sUg3YMIPGIpMUEOscYmucSKadPwMFGwKe9lsgXRrldF+nkooVRzILgyg53c+Gaz
    5sLbZorSDHRvTlpSdNvQwpj3Q1TNMMXcCkBxA7NI9KZRpv0pW+g/boFUjDW0H7UNywFT
    VcHRDyymH/jQO8kdC0Mk9Ow1A4Ytqe5cCkUTdF4LRWo8lYXaljstbWu/ASrU8IMSVBxl
    2oFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744014802;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Loa+HXQddwUp8ekjKdhDfBU3F6SSrLNWEPxiN6o32Mk=;
    b=sxZJ0QnUpW5ROFW3a3Fo+E5vsG8L0Qq4O1JGsRT+LYPQGYnzLtcDTp6pT+9R0IPBxj
    LEV5uzwibn73Qkd2tkB5Wl90DaP8PrfZ50ykCM97rnWEjJ2/ClgC32ch2x9NhqXwY44r
    ON7ZRkvWTvIy24WHq3E0Alz4NR5Ynyj69mqRv4TbQ/fHuHczLLD7RgktyZDopkr4l6Ul
    spFrSHl3zIisCGfj7ug0itrIhDuHsGFcpqy+PLeR+I5Pc9/gw+XG+NXFav/zfgnYW3uk
    wxdXgGPjhFjSsrkga0DbGA94w/3Sx0pv5ZEuHYR+2Vhn31uvwOEsHyxwGuWq/k78g2HI
    C/tA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744014802;
    s=strato-dkim-0002; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Loa+HXQddwUp8ekjKdhDfBU3F6SSrLNWEPxiN6o32Mk=;
    b=syv7AMso8I3WJrb2Q7eJX1DJHV+DHZeijOR5kI3keqLzbsEPX4iL5aS+rRRw2SH99l
    ntZhieKXa7W6T9QZJ+2rLfZPdobdhEOzMuK0+uk8uStQWr+7yDzdwIMhjg0UcrKoY0ik
    JGpH/JBPdJN3WSZVDy9d0c04ZeNYq/inKZUOldjadqS8kHg764UhIBbC81nDpqtmXbJo
    1RQwb5UeG9LwYI9NWIpUbMV1JcUc4nKpoPtgPQX+55swIJRn7FC6zEhCMQEJ6dzu1NRv
    0awzaiOWsfgfnEBlh8CDiW1ht61OpLgP9FeShkJJ/Mcl+HsDOLQAnH+zMzCCa4M8sk5k
    /t3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744014802;
    s=strato-dkim-0003; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Loa+HXQddwUp8ekjKdhDfBU3F6SSrLNWEPxiN6o32Mk=;
    b=PWbDy5LHEYN0+YxRVU2VwcIj5wnZHhlMeHUu7f/Z8f6piinZTmSjDbEcqzedfxM28S
    lMrahhtzIY69RlNo7vBA==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id J2b1101378XLK0t
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 7 Apr 2025 10:33:21 +0200 (CEST)
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
Subject: [PATCH] eth: nfp: remove __get_unaligned_cpu32 from netronome drivers
Date: Mon,  7 Apr 2025 10:33:06 +0200
Message-Id: <20250407083306.1553921-1-julian@outer-limits.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The __get_unaligned_cpu32 function is deprecated. So, replace it with
the more generic get_unaligned and just cast the input parameter.

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


