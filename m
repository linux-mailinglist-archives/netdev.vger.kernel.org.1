Return-Path: <netdev+bounces-102076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DF690158E
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 12:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16228B21248
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 10:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EDA2557F;
	Sun,  9 Jun 2024 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="YPs3nOgE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95942225AF
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717929438; cv=none; b=AQjQxH9kz5LCDeZ7H6DbYbJhblmKGk0teYMd7OlLNSUSj4wrikyn8qNIaFdN5O/kuJTPqxiRsMX/q9iNiJCjNUypol12sV25K/jDTOpXn4KaCaMzHCxhTW0CRWN+TjHD+woE39gVbJriVyDkW7qu5/QY4sOzJk2p5gGTQygYS6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717929438; c=relaxed/simple;
	bh=4TXi9SXz9OVyOJjNs/IHWB8Qsr+wbVOl7SsAVYV3TgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMVFBoG/VbTYTUAEn8uLGSfVlJAHrNeGXgu8ba277qS6z/RU96gk3EttwyGcvuDM7mmZkNGSt7nObms1a1xVadVYezSdXKQKTdq11oiIMd3Tg0+mSPyaUohNeF1tio6KHDgGAyhsNUlRQLuL7WWBrJnjvBLW9lm6YB4cPJ6loL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=YPs3nOgE; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a63359aaaa6so527071566b.2
        for <netdev@vger.kernel.org>; Sun, 09 Jun 2024 03:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717929434; x=1718534234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOj4bjY+lhbhqxjIIOB09zL/M8kVwJXeIo3CY1Bd0ew=;
        b=YPs3nOgENsarsrnlvjXhkFMoRJ4bh+5iwC4JZmiqr2YpWAcnfaUUg9ceBfbKkp7/2u
         QD//zpBNKYC/i2UXujoH1/YVpqyT9o15M1KMYkUSgWzgykx2G57r6fXkYtr+RALIaAiq
         +RZ8VuWL7ZdSZ1QfeeAZtieYsLYZVNfhETDSRQejC25FZSk+kiGbxtWjUgAzqpRdF+OA
         WyQT8EweEd4uVhaTFN5hvCx93XiBS5FJU6JibAwqkL7jVyS29QdI51jM2FK/C/K98atR
         VjpLQ523MtLgY0xwSR1/I3SN5POvwV7MWORGQmDgs+OwHwX8Nqon/eUEE9AaVTxM8P4M
         7rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717929434; x=1718534234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOj4bjY+lhbhqxjIIOB09zL/M8kVwJXeIo3CY1Bd0ew=;
        b=RH+rShL6t7GFknKPw2SUysXWFb/xzF+4VO/1U211DJ7nV3ZurXXV1MLQSYRLty+HNK
         SceoujqAzWj3dMLsI0F1ZjNPB98HYFjvgtmfNp7flpKMXWDticxtyRFt0i2pbttuZe2x
         aw6YqRRQdCAzOTgGdnB+Qb0zq67CNCazJI6FcuKZlNh+/1VMC04gBj22mQ5fPQ+C0GLE
         obyVmLJCUYxLzcCuLgTPVvVO8tvq5c9uYrG3IW2RZ9ujQxnBkCYM7V0PRUWVf1w0n23w
         dhVUROZtmKxBC59TvRlmSZ6gn4R6/x5lnrGuZ59SOn6r57VJAsVrVbLDA93cdn3rbdyJ
         VnsQ==
X-Gm-Message-State: AOJu0YyuBFO5z8+V5vGb8VkdTzOTOlFLfQAdaUBi3tknPULe/APqsCNn
	1P6TvTZul08glvSThimsXLytH9pu3pmnBpGfbMC53QV27o9yDKrfy8d9M4uN8TDT7IS4AJYFEJC
	CQE2eBg==
X-Google-Smtp-Source: AGHT+IFr3TV6EzXli/aPkOkGJCUsIaQl1kozvgBR2nlBuHzkW0c9AioUt4odRelhKTQ6w6F7ccpE9A==
X-Received: by 2002:a17:906:2b52:b0:a6f:1473:379c with SMTP id a640c23a62f3a-a6f1473387cmr98709766b.45.1717929433997;
        Sun, 09 Jun 2024 03:37:13 -0700 (PDT)
Received: from dev.. ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef8c01579sm259579966b.155.2024.06.09.03.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 03:37:12 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com,
	kuba@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	syzbot+9bbe2de1bc9d470eb5fe@syzkaller.appspotmail.com
Subject: [PATCH net 1/2] net: bridge: mst: pass vlan group directly to br_mst_vlan_set_state
Date: Sun,  9 Jun 2024 13:36:53 +0300
Message-ID: <20240609103654.914987-2-razor@blackwall.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240609103654.914987-1-razor@blackwall.org>
References: <20240609103654.914987-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass the already obtained vlan group pointer to br_mst_vlan_set_state()
instead of dereferencing it again. Each caller has already correctly
dereferenced it for their context. This change is required for the
following suspicious RCU dereference fix. No functional changes
intended.

Fixes: 3a7c1661ae13 ("net: bridge: mst: fix vlan use-after-free")
Reported-by: syzbot+9bbe2de1bc9d470eb5fe@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9bbe2de1bc9d470eb5fe
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mst.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 3c66141d34d6..1de72816b0fb 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -73,11 +73,10 @@ int br_mst_get_state(const struct net_device *dev, u16 msti, u8 *state)
 }
 EXPORT_SYMBOL_GPL(br_mst_get_state);
 
-static void br_mst_vlan_set_state(struct net_bridge_port *p, struct net_bridge_vlan *v,
+static void br_mst_vlan_set_state(struct net_bridge_vlan_group *vg,
+				  struct net_bridge_vlan *v,
 				  u8 state)
 {
-	struct net_bridge_vlan_group *vg = nbp_vlan_group(p);
-
 	if (br_vlan_get_state(v) == state)
 		return;
 
@@ -121,7 +120,7 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 		if (v->brvlan->msti != msti)
 			continue;
 
-		br_mst_vlan_set_state(p, v, state);
+		br_mst_vlan_set_state(vg, v, state);
 	}
 
 out:
@@ -140,13 +139,13 @@ static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
 		 * it.
 		 */
 		if (v != pv && v->brvlan->msti == msti) {
-			br_mst_vlan_set_state(pv->port, pv, v->state);
+			br_mst_vlan_set_state(vg, pv, v->state);
 			return;
 		}
 	}
 
 	/* Otherwise, start out in a new MSTI with all ports disabled. */
-	return br_mst_vlan_set_state(pv->port, pv, BR_STATE_DISABLED);
+	return br_mst_vlan_set_state(vg, pv, BR_STATE_DISABLED);
 }
 
 int br_mst_vlan_set_msti(struct net_bridge_vlan *mv, u16 msti)
-- 
2.45.1


