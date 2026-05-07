Return-Path: <netdev+bounces-285350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPfVDBGg/GksSAAAu9opvQ
	(envelope-from <netdev+bounces-285350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:22:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A04484EA0DD
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A91283019CBD
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 14:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E7F3FD124;
	Thu,  7 May 2026 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDuow9cz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B3B3FCB03
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163682; cv=none; b=UK7pzklrNxjBVCeULNwjENBou1/F2U5IKIzuIxgOrkbGMVSvRYNyb6YVka/mWFaCpkWj5jo+R2JjpATXqoendawFnO26RsBj3cc/JTyMUbUQxocfp+/dt+DUVpy+hSWLh7Bm1fzsMMlLV/vwfK8MTOUqhL580em/VzV7Wh+/pck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163682; c=relaxed/simple;
	bh=GeHKdCuPV+j+ya9Fs/27FFqPHYGSVwYqSLAztQD/KXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nY4tbkLYchq9XBG2YMYjFzHQb+RiKYe7DJrYeFEkEvtjoA6p02fYTo7fSORNOdymTYUN8uALXTX3vXhuvnlbMwKLELYd/444UrmWfUNxRffJy2jhTfPA8yBUdqNESxjgvw9HcxYv1Ih7w+IqZ/JE/mQFIrZ6Hek83Nzt2UiS0hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDuow9cz; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36505450d0dso930606a91.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778163680; x=1778768480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zrll4EjFpU0rjKpK7Ga8XWmdCr69vI0TNhXGsMRdfyc=;
        b=oDuow9czFL7U6DTMAS+HSIe0Y01wzOD+RwP0w4jkxuasPYKJzXMrt6GFFi+7M78JCV
         fLnjOjr+zbBEWimF2mzg96Mzw2RVaD00FvFw23wEJe03XBSgU2WjFqiLN5x99PqlOkU3
         NAw3Ms+NELB/EPH8xuNdZxemKuy/WEKU1eW3C1QwSBEm+Qlmf+1aZZdqxGKnQpfaodyn
         TsN9ujLiVyGaTQnz4es/d/FcojTzCcrKrdj5TUoRD/6kH3rK4wpfDsanIscU40GH5T47
         lAdL0vE8C+CPrwbj5A25cEeqSIR97LF5QZifJcjpkAvHv04umL9WvlnHNLQRKmRgsXgU
         xVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778163680; x=1778768480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zrll4EjFpU0rjKpK7Ga8XWmdCr69vI0TNhXGsMRdfyc=;
        b=A7txQiYUgcHtdBgSVqaVNYyaMqegs8l+JdOgQyOc/p14L6+mgDH1I1WlFquEHCq3KG
         +Vcw+APAO2yM4D//Ufc8ArhJWsGPHBT2NrQnGf5UHGP4QKeb0YGN+6Eo+B4XWzfZv0fj
         qbHQjQjR8bzjS4qLtmpCm9LBkUA+68H1GObKvUYCi7IeA2Y3JtfA7D3KxOzXyw4QsJoT
         OV3iumHZEXrF+hOkFuwNrW+ICiFthWXvqKyJPfba7haqf+khgY5HUsUZ7JvdhUA50V6w
         wQPtKWRQhve1T9Admz0drVheSQ/PjAa2BJ9k6tFpHLofCRZ/nGic/Qqtk88BJF73KDPf
         TgdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mRJMBQ/Bd+6RKx/oasal3RM8NHqZhUuEh/WS9uEcgKkAo4d2TnsCqAf6+C3OpflXifN4E+G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ6wXHM9eWXm+4OCsuGML9tusNJ0Zi1+yV8pE66cOqHQfRwK+/
	BN6ylY+CR8rWfg8SXI/FC+149x2iwJdtuChToCx3sgkGWvEi5Fn3Motz
X-Gm-Gg: AeBDieu6UnRZibIao/mEOZmJwu1ppYrRmjNnBuSEFwVhVG9lYYjuqlcHLtfkkAgAVEe
	Trb0Q0o6RjLkIOC3hhb+k8OIOuRZOin8KTMsVKdcGy4pIy1GDkdSqeNOloD38Ot1iHSsn74k8L/
	guGZ/F5mFAYAhvHQk7tYwTtlDoJ+ajH9qrOxUhor0BzTAPhg58f5BMlO6RKUzW/gJshXv4RhT0L
	guvUCd2uD55qL/PCqSVpbUwmj7GngqIr6Is2wJd7e0YOreQFx02x6Tn0IQS2p8CyScBPeJS4x7U
	CrnUP9vyg7/A09wNzewhTknA21EgrCzUTo30x35C0FX34TOwIoa92mbGp14HBBnnII8Q/gdqhJJ
	rRQQOrxAGq5G3ybE7qCNOFGBXb7J0hr5meNzf2ygd/NU7SacIoHs6RGDKoEga+GLpvsQmfeE2g2
	O7QX7dDIA376ghQ5n6CohFwSo6CYNHol5gu2TxueA7E1obic7LM90+bXGVQ63NzZdnYkLa+vkzA
	XwKphGBbc8=
X-Received: by 2002:a17:90b:278c:b0:364:7467:53e5 with SMTP id 98e67ed59e1d1-365ab9af866mr8900338a91.2.1778163680386;
        Thu, 07 May 2026 07:21:20 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4c12d30sm7637822a91.5.2026.05.07.07.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 07:21:19 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH net] net: xgene: fix mdio_np leak in xgene_mdiobus_register()
Date: Thu,  7 May 2026 19:50:24 +0530
Message-Id: <20260507142024.811543-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A04484EA0DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-285350-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The for_each_child_of_node() loop captures mdio_np via break,
holding the refcount. of_mdiobus_register() does not consume the
reference, so it leaks on success.

Put it after registration.

Fixes: e6ad767305eb ("drivers: net: Add APM X-Gene SoC ethernet driver support.")
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
index b854b6b42d77..2926e1e59941 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_hw.c
@@ -910,7 +910,9 @@ static int xgene_mdiobus_register(struct xgene_enet_pdata *pdata,
 			return -ENXIO;
 		}
 
-		return of_mdiobus_register(mdio, mdio_np);
+		ret = of_mdiobus_register(mdio, mdio_np);
+		of_node_put(mdio_np);
+		return ret;
 	}
 
 	/* Mask out all PHYs from auto probing. */
-- 
2.25.1


