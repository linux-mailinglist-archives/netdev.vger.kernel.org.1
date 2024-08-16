Return-Path: <netdev+bounces-119098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646C4954029
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 05:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3102866DC
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6226A8C1;
	Fri, 16 Aug 2024 03:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOD9K73N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24A854F87
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 03:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723780539; cv=none; b=dkgsjKpKuShwxaYstC1pXOdWUQJX+mKShQI0qM1TPDjt4dP+B7IRvUSghNBCpPvLtxFSxoZVUf+wAY2EHRZg7L5oQ4Pudrpr2l5dI0SjYY/EFewiCpgzlHgMqJpNsSEoBj5R2R7Mi5MVEx5/boHR62H4+FM91zujd7M85An6WPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723780539; c=relaxed/simple;
	bh=LXAZQo2Mpd4m8GHlXw7MBZ9cu3lIUt4NTOdwiXQOnNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YV1KQSI3XvGa+1wfa4CjSyrU+5YrcmxQew4tITdcrJ9E2A1TqULb5Bqlr542FJM+poYHObjUr9uYnQACNQDsg/WCT/M7Tc/7nIQXgvfuyp/RF08uh7AwW42yE2dwohpAC4UbLk3gYHdriBuoLz/IAvxMKzuaRC9lLxel/pKK6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOD9K73N; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-201f7fb09f6so9025125ad.2
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 20:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723780537; x=1724385337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEPcBqspktezhJ1h6WlEqbKQAI755uIbjlu43rGDgEA=;
        b=eOD9K73Nkv7Hv8CWhx/mao0Uf0iB9dr5pMxZZQy9kCtAVkT+UF6Z6vGy49mBZMy1UJ
         ykbyYFq/P+xaKcRrHhLE0WshGbf8WIsgJQUWg+8PnvboCSAopNCBpioij7h7N/O+LUbp
         WV1wxvoP11i54lnsnwqe0230ryn42JaCrQcg/kSSHyUNO5upwn3+njzAP31cB0RH6DG/
         A29ER2DNbCFQLZ0tSn6DuMACrsv62ns728Xtsuz5sAs0RlUkv3bRumYRNx7uTPvMXXmH
         Kdz9IB9qMtKnOAlkWa7jCLa2bup7GrIIq526MVELQUJURea/gUmmgat2eePyARdls9u+
         iJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723780537; x=1724385337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEPcBqspktezhJ1h6WlEqbKQAI755uIbjlu43rGDgEA=;
        b=KjUTnJdIX5PEmVXDRKd8YYtkwz9DJCeg9Jq01bYkWNPLt6fd8h4+VsHJkO4b7hnXLu
         or6tB5UcqEE/xkDnYPTnkKk7Y/2LD8n01VzeuEanwUsNA3/b2/nuDMim29BYm5FBalE8
         SItGYJRD9HOt8OiCpuzMeRce1yh8MFc6oYG+vLROPt/as+bOSYQBr+1jrUh7L3mMVY7b
         MItozVakrKLQG9Wfq5LDF9UWhJPkixkqGrD62wWgo/srH1UJvnXm2r8kaiazLhtis/ff
         JPgI5FQJqJX9Kboe6FJkGs6kLfr1TZ7Iwsdrp8FlvwNIjMAuljiHZv/3+z9xfyAf0QLw
         ac3A==
X-Gm-Message-State: AOJu0YzHzb/kc0zUih1PvQJLQRt633X0BlSTJ1RYu0mcJ8Y2SUdHVYYW
	CdWLaq8AoAzoktnyKgzre3vF6R/+c9zlq3EzIoxRvgfaQZMc/B+TL5MSiobW2EQ=
X-Google-Smtp-Source: AGHT+IEOurbOFyB7ZeTtD9GzuxDIERE/apYiIKxJex3pOsvSoV650qqOi1fXpq9RQWFYxFCm35KgPQ==
X-Received: by 2002:a17:902:fa03:b0:201:e49e:aaf6 with SMTP id d9443c01a7336-20203ea82fdmr15644435ad.19.1723780536876;
        Thu, 15 Aug 2024 20:55:36 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f037563dsm17112105ad.131.2024.08.15.20.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 20:55:36 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 2/2] bonding: support xfrm state update
Date: Fri, 16 Aug 2024 11:55:18 +0800
Message-ID: <20240816035518.203704-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240816035518.203704-1-liuhangbin@gmail.com>
References: <20240816035518.203704-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch add xfrm statistics update for bonding IPsec offload.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4e3d7979fe01..9a7caf677c71 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -666,11 +666,49 @@ static void bond_advance_esn_state(struct xfrm_state *xs)
 	rcu_read_unlock();
 }
 
+/**
+ * bond_xfrm_update_stats - Update xfrm state
+ * @xs: pointer to transformer state struct
+ **/
+static void bond_xfrm_update_stats(struct xfrm_state *xs)
+{
+	struct net_device *bond_dev = xs->xso.dev;
+	struct bond_ipsec *ipsec;
+	struct bonding *bond;
+	struct slave *slave;
+
+	if (!bond_dev)
+		return;
+
+	rcu_read_lock();
+	bond = netdev_priv(bond_dev);
+	slave = rcu_dereference(bond->curr_active_slave);
+
+	if (!slave)
+		goto out;
+
+	if (!xs->xso.real_dev)
+		goto out;
+
+	WARN_ON(xs->xso.real_dev != slave->dev);
+
+	if (!slave->dev->xfrmdev_ops ||
+	    !slave->dev->xfrmdev_ops->xdo_dev_state_update_stats) {
+		slave_warn(bond_dev, slave->dev, "%s: no slave xdo_dev_state_update_stats\n", __func__);
+		goto out;
+	}
+
+	slave->dev->xfrmdev_ops->xdo_dev_state_update_stats(xs);
+out:
+	rcu_read_unlock();
+}
+
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_state_add = bond_ipsec_add_sa,
 	.xdo_dev_state_delete = bond_ipsec_del_sa,
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
 	.xdo_dev_state_advance_esn = bond_advance_esn_state,
+	.xdo_dev_state_update_stats = bond_xfrm_update_stats,
 };
 #endif /* CONFIG_XFRM_OFFLOAD */
 
-- 
2.45.0


