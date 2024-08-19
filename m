Return-Path: <netdev+bounces-119608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F0B95650B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053951F22B7C
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9287915AD95;
	Mon, 19 Aug 2024 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwPsD/6J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B88615A87F
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054040; cv=none; b=STVdtKTJCjer2xWQMwf7nR9LAQM1S9AIn2ePkWEcTuUN6KQi5Iwv8GrUBdWJq+3gU1CScAcadRa2sCGqJ9RTduoNw6t0FWgqd9FIntLW5wvZdgctfOWYgR94HNvWB+x2qf/1UrSgapSmbc5VOtnXHmbFlFVUZdfgRSR+aNIozHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054040; c=relaxed/simple;
	bh=rAI4sBFmFhIN8hsDwrCQPROz67K5IinmRRmNqQ7WOkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goQkdBuxnGX16IATzZ20LT4AhxDDx3L3Xr2n7ADqzNA+nimlyBWlfAa8eSXR4FgU3PYdxvqFgj/KWUJEbFk66jrFTPO2tfhNGEk5LkP7jYqbZfV5Oqo3GZghEPektUz+ooC5gaIAKrst7ZB9FG2nExyWcvyQphUte/BvItUfml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwPsD/6J; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db1e21b0e4so2662930b6e.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 00:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724054038; x=1724658838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxUSDe4f7kyANQUlrf0A9ELfzzzlQRcsUZJvA0kRCuU=;
        b=LwPsD/6J5kvMHBqloLKdq9J84dZ6IpcBpo2mX7TW/PS0I1cSXAhmXFkSS3goQtBG5v
         WKOeSBwytR9d6U9WqR2QUWUh7NvHiU05VB9M4hX+lLjdImVBFQHJPGAMumcJ3XXF4fSw
         FOq0Ys65EsDj1Wz/KT4V7fnCVg9gdkFmQt4I2Vd+8Ks2oP11yITy8edlHwz6MhnPJrlX
         Cr8xnrjkR7X/8Tbkm4oEl0sdhnKJRungxBTbVdKFkLR6dyr16sHzmMRdFaMSFubzfiLH
         yCmO7DgYuyhWQfGKQJIyulZ19+euFjVEYaIeqUgAZR4r6lWAAt/+fLu7OSyubX6xJMG2
         PLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724054038; x=1724658838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxUSDe4f7kyANQUlrf0A9ELfzzzlQRcsUZJvA0kRCuU=;
        b=UOowL949PydUZVYu+3RRMsUemoFY9gBckzxgxDOQRI1ek1zVUTPH+0J6Lc+PDF5yez
         x3b+yMnyDy0KA1J8f1eGDHgdTJ/sl/HEBUhDwYhlbbCe8e4VAgZEcpuw29BrpOZPj0XE
         akV11F6D3C7sEsW1CNSt1peAHwIK9zOJYeY70gEnDVuYAmk2kvzhrAI6n3H8zhs3wjjH
         XcEBlT9OIFFYKCGmw1BogFo8WX6+SVC51CtF9egBfKIad5piTBitgKypqifyIhKE/1vk
         mlQg9wa6/MUcvH4u/7QLRyR8BNqLtBpbPTpw4sX2vN53sXegWYybb44xa0GcP8HdKRjU
         PDJA==
X-Gm-Message-State: AOJu0YxCnIMXzypuC5pKyfKZJEJni4RV4/mUIdThSFYiyNosWgt4SMT/
	aExersa2xiIt/8gStR4txU3UPe2mQEGD0G8rvDvJDjRAJxM+2MCC25dlQY/ER6r8zQ==
X-Google-Smtp-Source: AGHT+IG8FkFmG7JysN4OGI6fibUqjbraRks4NUatB9mI7lvWqMvZB87RbpTClZ1jJqDFDAuGGgUaug==
X-Received: by 2002:a05:6871:b0f:b0:270:2063:f166 with SMTP id 586e51a60fabf-2702063f600mr9964005fac.23.1724054037838;
        Mon, 19 Aug 2024 00:53:57 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef6eeesm6147151b3a.118.2024.08.19.00.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 00:53:57 -0700 (PDT)
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
Subject: [PATCHv2 net-next 3/3] bonding: support xfrm state update
Date: Mon, 19 Aug 2024 15:53:33 +0800
Message-ID: <20240819075334.236334-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240819075334.236334-1-liuhangbin@gmail.com>
References: <20240819075334.236334-1-liuhangbin@gmail.com>
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
 drivers/net/bonding/bond_main.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 3c04bdba17d4..9e41e34e9039 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -670,11 +670,36 @@ static void bond_advance_esn_state(struct xfrm_state *xs)
 	rcu_read_unlock();
 }
 
+/**
+ * bond_xfrm_update_stats - Update xfrm state
+ * @xs: pointer to transformer state struct
+ **/
+static void bond_xfrm_update_stats(struct xfrm_state *xs)
+{
+	struct net_device *real_dev;
+
+	rcu_read_lock();
+	real_dev = bond_ipsec_dev(xs);
+	if (!real_dev)
+		goto out;
+
+	if (!real_dev->xfrmdev_ops ||
+	    !real_dev->xfrmdev_ops->xdo_dev_state_update_stats) {
+		pr_warn("%s: %s doesn't support xdo_dev_state_update_stats\n", __func__, real_dev->name);
+		goto out;
+	}
+
+	real_dev->xfrmdev_ops->xdo_dev_state_update_stats(xs);
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


