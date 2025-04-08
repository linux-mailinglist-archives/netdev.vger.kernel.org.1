Return-Path: <netdev+bounces-180104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0211A7F944
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D5B16F9F3
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A74264A90;
	Tue,  8 Apr 2025 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="Uym02xd3";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="okpd5tum"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC432641C0;
	Tue,  8 Apr 2025 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104005; cv=pass; b=NK8jy2gbp+Mw71Df9N4T4lF6556YwlRD/R0wqxEhjFEutEQtBnlTmxTwsF15rJNCMFlmceWKMV22bN8R4ps8FCe2cuipkfovVc2cNuRJFqXklh5ffdZxk27TF97mEU8ybvTtPc4IvM05qMods0x+odJQuGlpQ2B/5XdKMaij2f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104005; c=relaxed/simple;
	bh=e2gPr6MiECXyJe/SmVpOUVDcZR2UTM66yOOf0w6g9LU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=k36IikbCO9n0soxYpuFSLc2p+bZQrlBArRgu/SIAdDIh368NQYdiNVryF6dnirHquwaKsDV6ZjfXBWr5ozQFEC9Ylc6lRRs0IBni+WUlKAgxOun7es04sK4AqMQx2bViunoXuTLFaSbEi9VCL55KTodV50viMOz6iPOu5RR1Lc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=Uym02xd3; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=okpd5tum; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
ARC-Seal: i=1; a=rsa-sha256; t=1744103994; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TbWc5BC21rJRcIZSSRiyIEVZhiD40LlCC1V/+kvX67kYNzYld3C6Tka/6mCjYGsRDD
    zBdk/mq5KxAUQQ05gjwftScORfYB/jBJRI3+QpIhA/QNOvlGFkdx1ddbo5Bz3v6m/ikk
    2LvFPopctBU5Qd6DJreXwjZ5bwDVib2CZUTgI1beHS8Pl2WKuZQo71ifrwKBAlKt5SyK
    5TbE3sYRhxP4gyHUaaBbmo/WmMi9IEjYb1hjzh7m7ZhgnjNEUaKfEwTke3QP88Mtnrgv
    /Y/9yd3bC1XALNdTlBI8YRaUj2u7iCqVg1lja7nLSrEOXT1GVKk1NCgIbVgDaVq1qrbK
    v0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744103994;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xc/XoPImOuzC0siJVvkk5j/5irT3nJLsjEZdGp+le1s=;
    b=a1GK1ClTWT5IcmjLr1r4PolyEVPqbGMbvjD0bv2a0Alj29TUnsMyOCq+/s8e0B8iqZ
    x9WF6bhN/3PAjknTleVDTySAZy+KTeB0h4ad+cTvt6N+nn21GUGqmxUUUlOWrEeOpP30
    rBd1LrSDRz/9uKCK96kk9yL7scfMtd73Mq5Bm4ZTQFiOZEE29iUBKY7TCYHOGDxDYPTs
    +YsjDZzaxm74ag2JvbPHllvKAa9FDexS9N2X3Xs0OdpOuFad7fK6i1dU5ybW68AbrIkr
    iY2rdM/azTruXlhFOp4wiS7eqvoPOi9a15nMFJ/A7KUdLMJFCuU/dHxBgGwJtz165/LY
    c0+Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744103994;
    s=strato-dkim-0002; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xc/XoPImOuzC0siJVvkk5j/5irT3nJLsjEZdGp+le1s=;
    b=Uym02xd3bcg42Lj1X0V5+fSgIxtI6OlDaJKRKjbdRWDZwPoiRGua3v3sTyxa1KP6Ud
    LeHtECNqiDJigBV+ORAvwIiwoLaaMMPEGSNbGp/eOXttdit87on/86bCOQ8nuQn9jO3y
    rRpYWo6A7Qb+qMtkr7v9Vid7SLTkQB4iKNBxSQ3G4oJI2+tey8zUjld5MudLwwV7wVmp
    ae7cbSgiRhr8CD7BwOhcCbk7leykBWsx7tet2Y91o6Xhl+34vW3Gr2jhUB9ZPc5f7IpO
    OxZUhjx90WciyrtpQ2BpkSJPImwr7+1Nd/Sev5wzOQAsmnL9Po5xVDQ6lPDps8NyJzLf
    Rb5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744103994;
    s=strato-dkim-0003; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=xc/XoPImOuzC0siJVvkk5j/5irT3nJLsjEZdGp+le1s=;
    b=okpd5tum1sdCZ6nXBWTwpOv2fXLo0tX1UK6Kr+eYSsTHhxvea1wnHcivtJxpf+ZBms
    u1CCPxXR2AKq+7m9gOBQ==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id J2b1101389JrXB5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 8 Apr 2025 11:19:53 +0200 (CEST)
From: Julian Vetter <julian@outer-limits.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Yue Haibing <yuehaibing@huawei.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Vetter <julian@outer-limits.org>
Subject: [PATCH] net: ipvlan: remove __get_unaligned_cpu32 from ipvlan driver
Date: Tue,  8 Apr 2025 11:19:46 +0200
Message-Id: <20250408091946.2266271-1-julian@outer-limits.org>
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
 drivers/net/ipvlan/ipvlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index ca62188a317a..8ccbde16ddfa 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -219,7 +219,7 @@ void *ipvlan_get_L3_hdr(struct ipvl_port *port, struct sk_buff *skb, int *type)
 
 unsigned int ipvlan_mac_hash(const unsigned char *addr)
 {
-	u32 hash = jhash_1word(__get_unaligned_cpu32(addr+2),
+	u32 hash = jhash_1word(get_unaligned((u32 *)(addr + 2)),
 			       ipvlan_jhash_secret);
 
 	return hash & IPVLAN_MAC_FILTER_MASK;
-- 
2.34.1


