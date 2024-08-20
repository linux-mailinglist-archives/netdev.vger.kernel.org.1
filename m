Return-Path: <netdev+bounces-119948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E998957A9B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 02:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A011F237D0
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D283D29E;
	Tue, 20 Aug 2024 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnfQfpMG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A7017C67
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 00:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724114945; cv=none; b=lBVsyrNSnLmHlIY+Rm25I2urLz0U2yJdAHNPP16cHD7yshpJpqDg5fdY036oRTzLJCK5OdZjMKk9jaTZr+XDksHhf/ObToyxlnlpYgbBTqopH/CDNzPzw89sA3FEUnoBpjfLvdvY2fHrXGK0ZiJ9fiXbB0dWiX5yPO7MLf2k7tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724114945; c=relaxed/simple;
	bh=HhhPTqz3ORhvxNiWIIxAFLFHgn8p1aX7qXZOQ9zf1sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pq5hAT9Dr5NxnPm1Dl+gHcJSy7xtG/h7q25wmCtKuoFIleIm/Plo1jDD+2yWGkHp45hwXWvFqQ1g8w++SEnGv6vZHhSvKozAwjoq+2HbsDrCvPff/ymMS9RPvZKm+DlRCSgs2gXY1KDFqA87PJm6xDtnIAOsicEgmsuEiG5S8nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnfQfpMG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201fae21398so28160765ad.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 17:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724114942; x=1724719742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FHcP/x+78WtlB0zWFtFC85FvngH6fYB7gYdJxuvirU=;
        b=HnfQfpMGZlWWWMaMJ7ILgRKVCM9pHI9RoHH91fPcj4/rJEzV20HmUOY70zDX3uavMX
         T7y0ERwXEWBViIRTnfCCIWPC3hKnbRO4O5qtWC5Ugo9rEDkPg1K/Q9/2UrRW5sLxIc66
         Kg959mwmyzs4E9mK00TNuPgFdvBKGISlXQxUvpfdQOhDXpm2Doq3bk3ft47rewqJlAGN
         erbpKyC8CuqrO75NtPpNDgdDT2K90BJ3aUCEng/IGhwuF8mp3+wcz3Mtke2dvOnCv8tz
         UFHpoEV/BR922Yv39TnfGrnK8IqUvLbXfdlzqfxR0XkDz9IxehH3ZUCr5C7+0mfX4Puk
         HocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724114942; x=1724719742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FHcP/x+78WtlB0zWFtFC85FvngH6fYB7gYdJxuvirU=;
        b=eYeqhW56JZm4T2gU0tvDBfO78CheknmlU7e+WgJ5yQOU/kfURy0QYGAEjEXqaPQKtS
         czY7OYE4gBQo4eFTFdrqk6x2e0i21N1vrLL9+l9l5mCamYlOzeUqzsmxGwZ/D6p72Lle
         /pZMTtiEd6a0UQzcjQY6+FfPtbo/LJaptdgyOf23A2aAg2J2lZwI5SycwmQ01ndai61S
         B09bDCXR1RBbZCPGrTfOa//1AKKZ0VrrseDJYzDYXZcLGDmXTOvxnd27fQi1jEXH58NV
         0P1W6ydh8Wrv0BO8H2fAcGG7E2T15UXsZkQxFjcZZ4o7qJeSWbi6lMzMqSnA/NmDjB9R
         cUyw==
X-Gm-Message-State: AOJu0YxAPXjesjVDTPuNKNN1ICG/WOa3gcMtSzl7L2d98bXoya5V0PmM
	xl/RG/PcDIq2LdPHOZjrXlmfLVL7zqzGxLTau4UtJ5DqjeKl6awnnFF5m9zr4+4=
X-Google-Smtp-Source: AGHT+IE/A9auW9+BmtC7quRnP+cX63YcTcD7r77PedGGgrVU0IxsTD8IwlovagJIjxc6qMwCD/AVTw==
X-Received: by 2002:a17:902:e5d1:b0:202:54b8:72e5 with SMTP id d9443c01a7336-20254b87406mr39200235ad.22.1724114941598;
        Mon, 19 Aug 2024 17:49:01 -0700 (PDT)
Received: from localhost.localdomain ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0300522sm67861455ad.6.2024.08.19.17.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 17:49:01 -0700 (PDT)
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
	Simon Horman <horms@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 2/3] bonding: Add ESN support to IPSec HW offload
Date: Tue, 20 Aug 2024 08:48:39 +0800
Message-ID: <20240820004840.510412-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240820004840.510412-1-liuhangbin@gmail.com>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, users can see that bonding supports IPSec HW offload via ethtool.
However, this functionality does not work with NICs like Mellanox cards when
ESN (Extended Sequence Numbers) is enabled, as ESN functions are not yet
supported. This patch adds ESN support to the bonding IPSec device offload,
ensuring proper functionality with NICs that support ESN.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 560e3416f6f5..24747fceef66 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -651,10 +651,35 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
 	return err;
 }
 
+/**
+ * bond_advance_esn_state - ESN support for IPSec HW offload
+ * @xs: pointer to transformer state struct
+ **/
+static void bond_advance_esn_state(struct xfrm_state *xs)
+{
+	struct net_device *real_dev;
+
+	rcu_read_lock();
+	real_dev = bond_ipsec_dev(xs);
+	if (!real_dev)
+		goto out;
+
+	if (!real_dev->xfrmdev_ops ||
+	    !real_dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
+		pr_warn("%s: %s doesn't support xdo_dev_state_advance_esn\n", __func__, real_dev->name);
+		goto out;
+	}
+
+	real_dev->xfrmdev_ops->xdo_dev_state_advance_esn(xs);
+out:
+	rcu_read_unlock();
+}
+
 static const struct xfrmdev_ops bond_xfrmdev_ops = {
 	.xdo_dev_state_add = bond_ipsec_add_sa,
 	.xdo_dev_state_delete = bond_ipsec_del_sa,
 	.xdo_dev_offload_ok = bond_ipsec_offload_ok,
+	.xdo_dev_state_advance_esn = bond_advance_esn_state,
 };
 #endif /* CONFIG_XFRM_OFFLOAD */
 
-- 
2.45.0


