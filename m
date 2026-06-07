Return-Path: <netdev+bounces-296306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YnCUJvzGJWrmLgIAu9opvQ
	(envelope-from <netdev+bounces-296306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 21:31:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 089D66515C0
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 21:31:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Lh5enM3B;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296306-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296306-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4DA43006516
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 19:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71722DB798;
	Sun,  7 Jun 2026 19:31:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B291F7575
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 19:31:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780860664; cv=none; b=IhqgxHXTi2/6uWJXjNWyK6NgUiqb3jZJpbY4+QbQJpLvb4atrtQl4JS9kXrmnyNPFwml2IMg6RAD3SSqmEEMa/s4lEY2AZK9hnEuJ0M8NMsGOOybYkgb491ZDgxYq5I67mFxNuDNwIHAIvJMvUxEzSD8Uifs16uwqeHLRCb85sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780860664; c=relaxed/simple;
	bh=UqBn+YJY7M+u065RMcQHz1GgsUI7JWcXHJmj8EfdyBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AhQJUNwaDiUeiIrLJ9RXwe7s4qtdR6u3i3+jvottKzij/yXKVFnIGeWLizb78Yxc8eC+SaO/InxvlrB+KBLiDlKzsTLDGNU+1KHPGqKcfnPjS+tqIpt1JLZv7YHvCOicJL2XzMPobRhHGTd+S1vP2M9aLTe3S+mFKPMUF3/0gPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lh5enM3B; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c2c7d45eso31862645ad.1
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 12:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780860663; x=1781465463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Js68PLPyN3XjWqEU0fIOqcPtf+mTXJxmFseuifo/CDY=;
        b=Lh5enM3BZ9aNrJWeUNtyQMjlswsGR2q0v+ChADDSaNo0XB2Qbw20fhhDh5TTuvIjcA
         tUhxhmPGM9zeuk/rJzbY5bP/+BgmM+aV3moO+qLFGxgTW9/0Bb/SX0LEDLWoYj7dVphD
         2JHTv3YjLX9xqGGGP3aimhD4Q419CIvMOMKjiuvZLeURnBvxZk2O5JgNCqsG9nb2nixJ
         BGCppcSfhzdtmXOEgFWRu9iVOYPUMQKlrRqk9d9V78bBs/mKOrpe5+Euwq+/IGbMP2zm
         Q921z8jtEfpVGEbLmaHvtuGolvXT1rfCf99KR/LP36btnzm3qNa1yEG4PeeCv9E8rypx
         mPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780860663; x=1781465463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Js68PLPyN3XjWqEU0fIOqcPtf+mTXJxmFseuifo/CDY=;
        b=hDdTvd9+nTM+QhzTNwg+biYsV7jubTTt7gYn8bMFobFQkZBSnh+/MMPQkCaSCwfb2o
         oCN2qtPgn0R5cRQazpkkSbdJ/a38iOcUlQoBj0Rcciy4JP+D011JYi5VgcRTWMZV1UzK
         b9wnwWyCj6PnvzwqbiFY6PR2OFHwytJFPXO7tbrgxxNoUyH98ncokTKmR6iemGYm4Qx0
         GyBrLx4rcdJoj4AA2SVbNvn2PFoWUfaorGWJtUX9xSCqBye3x+aV7/wNQwlQtVuPqYyz
         UQNVdqT2yG0u34wzwzrmcnAwotb+y64Y1zUJIwXxUi1IQ7Uc7moJZWANiT9LBlwtSiuN
         lI6A==
X-Forwarded-Encrypted: i=1; AFNElJ884VzCPsm7D2Xq7kfddTfSW0Guv6NyYfHAVLqoDZrw3LK45Lsf2QjDC1QWWeaMsQT4zhSwsnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM3J4sWugIhOJ+YRy9xJepp/8KQZFzxdXCmyQTzxGMxX5/4Wls
	QZvEO9liYL4YQCtSAlRGsbypld7q6ZI+NDGFIucsdpBy9yi04mYGFgLM
X-Gm-Gg: Acq92OHxe/eI92fgXXBCLcrM26r87h22Os2eZNZdvo7eCUkkfpQhzASWF+rdYOAOqCQ
	mFzbIGdXq5yzoLOKdNpqgb0SUpIzgAbFS/YXzuCT7JliKVZt9xMuFC9cbuLsaxuDA0qrtlutMPa
	H5CdhTAcmtoFiEh0mAmAEfcH+dg1H+1vLX0TN0bwmV/6kg7sqldacz/Ni3mKLcFTnrGEXU40YEK
	K0OF6ya5vGrVHImvvdKxdZCK3TLeO6zOXrFVvZKJlwCUb8QXaD7TOqo+y1WS4BA+9Nz34uyM0oJ
	jzml6Q4eLz1QQvoBs2JpnM4R/xZrkp4qFQ+6C5+Ki9B4TlkdYZYPlxFIuXXLHx4xDlExIjQd/l3
	y08eWlalniv0qI1QMDfnMPR5iB3yV/L5l+/EjV0Mm1De0RcNlBratZHx3bgjzNatUgIutYG4N/R
	MFmoCJneiZuN4CLPg3XK0uGTuI5qLCxjB50uSyKwYv0eIyrC4Y0pIQ/FP3uqIGALgJhAcN9nwN
X-Received: by 2002:a17:902:c94c:b0:2c2:33a4:aa8f with SMTP id d9443c01a7336-2c233a4ade9mr63422735ad.13.1780860662802;
        Sun, 07 Jun 2026 12:31:02 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d55esm157971855ad.63.2026.06.07.12.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 12:31:02 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Wells Lu <wellslutw@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH net] net: ethernet: sunplus: spl2sw: fix phy_node refcount leak in remove
Date: Mon,  8 Jun 2026 01:00:29 +0530
Message-Id: <20260607193029.589736-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:wellslutw@gmail.com,m:andrew@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:stable@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shitalkumar.gandhi@cambiumnetworks.com,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296306-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cambiumnetworks.com:mid,cambiumnetworks.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 089D66515C0

mac->phy_node is acquired via of_parse_phandle() in spl2sw_probe() and
stored in the mac private data, transferring ownership of the
device_node reference to mac. On driver removal, spl2sw_phy_remove()
disconnects the PHY but never drops that reference, so each
probe-then-remove cycle leaks one of_node refcount per port permanently.

Drop the reference after phy_disconnect(). While at it, remove the
redundant inner "if (ndev)" check; comm->ndev[i] was just verified
non-NULL on the line above.

Fixes: fd3040b9394c ("net: ethernet: Add driver for Sunplus SP7021")
Cc: stable@vger.kernel.org
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/net/ethernet/sunplus/spl2sw_phy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sunplus/spl2sw_phy.c b/drivers/net/ethernet/sunplus/spl2sw_phy.c
index 6f899e48f51d..a4889c52e00e 100644
--- a/drivers/net/ethernet/sunplus/spl2sw_phy.c
+++ b/drivers/net/ethernet/sunplus/spl2sw_phy.c
@@ -79,12 +79,14 @@ int spl2sw_phy_connect(struct spl2sw_common *comm)
 void spl2sw_phy_remove(struct spl2sw_common *comm)
 {
 	struct net_device *ndev;
+	struct spl2sw_mac *mac;
 	int i;
 
 	for (i = 0; i < MAX_NETDEV_NUM; i++)
 		if (comm->ndev[i]) {
 			ndev = comm->ndev[i];
-			if (ndev)
-				phy_disconnect(ndev->phydev);
+			mac = netdev_priv(ndev);
+			phy_disconnect(ndev->phydev);
+			of_node_put(mac->phy_node);
 		}
 }
-- 
2.25.1


