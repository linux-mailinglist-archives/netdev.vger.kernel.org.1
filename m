Return-Path: <netdev+bounces-283691-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fWUHEDsO+GmTpQIAu9opvQ
	(envelope-from <netdev+bounces-283691-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 05:10:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A62684B8288
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 05:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC1923005150
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 03:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC491DE4FB;
	Mon,  4 May 2026 03:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGZByPRa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2394818DB35
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 03:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777864242; cv=none; b=g61xlPZlpZ9z9dBINwR+bxOrorxWdLBbAzXcsjsHFkFcMV+RhOMzCKa+U1JCIAkWiwj+3isiyctBoYVu6cdIYlIuUKBtgRewfQ9Nl5XQqfkBOdT3UJRTTeJKNcx3Ji1jilz7cSupAGF5klEbYs188p+Myf8Ra56ZjsUcM/Img2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777864242; c=relaxed/simple;
	bh=opKx/RrOTbuyD3oZoOCJt+NiJlG4jxDpPf1fkhTsZdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nqT1l/pSnzaPYU55h9XsUuTgabrrGm1VtHL1q+wO1K8zF6L8IH1Bb+B3SiOgFT92Jsk0wduJEOAHwimeDA4cVAYkqjCCQ5H9UdKs6foA23EQ8oryt5NCgifJQTGbdMLX98B92m42LmKXd0YqsaXEJUIPH4qseFgP1VwXJAFZths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGZByPRa; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso60701946d6.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 20:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777864240; x=1778469040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bdq1ceputFrd5lb1OAnfe46lFGDJ7zZ8wPiQreEQXNE=;
        b=FGZByPRazISBnVGRt94jEJftMXJaxJf42wJJwzTzA0fi18eciJhMzXCjeOxAyjqADE
         ZofQY+kDFovAPxtxQJDaRoND7MysjBve15kRQ5UwlZXxv8/pVDRzihZrRxMhWH0WbXmS
         E1w0pFqiCGKY7YVCg3Eh/U1i4yae44NFcxO9zheZB5QJ0tJ6aJGmM2AYsfWqLPQ8L05V
         vQ8YyC9VxXIQLzpScwtIgk1U+e0Q3Vt9JKTRt0einOTKo+HGg3FxuBcSFxTBB0a2tLzS
         ULvSx6bH3nYWU29IQHpgQyYzWj5r1TxJ4NhPmHkyDEhlaEb/KsTRfSJRgY1rSbDOhmiw
         gASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777864240; x=1778469040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bdq1ceputFrd5lb1OAnfe46lFGDJ7zZ8wPiQreEQXNE=;
        b=pq83ed6SgdS7PJ+lLyeGAQkKsbO3wMPHEcvdnrAV9Unx30ES3Ay0PEvD2vzWb90eBM
         rO43F3BS+A1tfKF4u/IPKR1/d7tKPRbR/8YO0sF5/Bbx8m9OioUrsGpvFRaCzPAZogVW
         XPvG6AVBm+wJpmXE/DfCxU8Mh2TuBadamRBoNhO7IEDy3Dn0iL6aaA1/Jb+e7dt4LZj1
         qBg7Uuai+/KJSip4KnZ7+2cU7sNpvAgSBqDQsFp7DqA7KlwGwJuS2FpKqIHynrfCWT4H
         2YZV4QfLnQe9K+OzWvaAqzOIExfX6UaWsvBnrsipmmw0xbWitHIm2NSx8WhsTMT9AtMm
         4cDw==
X-Gm-Message-State: AOJu0YwJvEpvamVdrUm9ZU4cy5VOc2M3FQsMuO7rKT47uitQahBBxXqd
	31FEyVTCS9nrppwkTIvbtc/zYWyQoaJ0GFLHzofjbxU4nYri6bw5o5vZIf8CEQ==
X-Gm-Gg: AeBDieuiyg/OrUvyhsVxGgY97EPDe6VfGQ4fQAm47wBwBqT+8xkDSOJxOQnW6f/7AxK
	kKUUWV8nOUgyey8LdMOp+SHasUakJGXXUboO3e4TZC7/j8gHely304iJdpbwztUxll99+2ak89O
	/PhGyMLS9WvbqM1OfTgx4yg6C1t1ml0NAbf3019gON+ZFRtDZvCxdJz25+utPQLe/P4CZssCsMu
	2zM/nRVVEXfsZGETx5UIzn2kncfNq0d7yuT19OTQXpPl1UL30/9nIFUpAhbD2VT4N2FYmBRdTGx
	7YO4GdE2zWManwjgcUqFlA36RuyLiwDGzTapmD9OMFd06LeSHELVM2D5sxIbwc4JRkSUTnhd1fj
	MirLfCWALBJQpL9DDp9fnZazSTuyaSpzmzgOKYGINViiSxopHhjzkR3ebwSvykTL0RpVa4LAvko
	pC4JQ64+nbsXPChQFp5U/dpgo464ZMJX/eVZ4yrCIcKe/tPPDuVYbyx5M0Bxkv/JQJJI8d31f/w
	lY6ocj2gH3zdVVtv9TVV+uKg17EZ/LgcQqbfUKk6ksRxKo4L8KTkrf3
X-Received: by 2002:a0c:f10c:0:b0:89c:de0e:263b with SMTP id 6a1803df08f44-8b6694eb760mr112988026d6.42.1777864239741;
        Sun, 03 May 2026 20:10:39 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538b1d833sm119089176d6.10.2026.05.03.20.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 20:10:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH net-next] net: mtk_star_emac: use of_get_ethdev_address
Date: Sun,  3 May 2026 20:10:19 -0700
Message-ID: <20260504031019.607682-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A62684B8288
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-283691-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The platform_ variant calls arch_get_platform_mac_address which is only
implemented under SPARC.

Switch to the of variant as of functions are used in the surrounding
code and to get EPROBE_DEFER support in order to handle NVMEM MAC
address specifications.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_star_emac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c b/drivers/net/ethernet/mediatek/mtk_star_emac.c
index b83886a41121..774ecc98ebe1 100644
--- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
+++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
@@ -1640,7 +1640,9 @@ static int mtk_star_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = platform_get_ethdev_address(dev, ndev);
+	ret = of_get_ethdev_address(of_node, ndev);
+	if (ret == -EPROBE_DEFER)
+		return ret;
 	if (ret || !is_valid_ether_addr(ndev->dev_addr))
 		eth_hw_addr_random(ndev);
 
-- 
2.54.0


