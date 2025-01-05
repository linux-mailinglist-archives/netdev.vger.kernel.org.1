Return-Path: <netdev+bounces-155217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38860A01787
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7823E7A13F0
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 00:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A6A4C6D;
	Sun,  5 Jan 2025 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3sLApVB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69CB320B
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736037823; cv=none; b=hcOiHO7yiLwK7OD40ZrlhdbmuY2lSb1hnPnm1dAw6f1uY6egjOccbIr4BVuH35F6NuJDmCmKyL/kat4yRixBTsfkz+nqkKbhAEGoBiqlhaHiAaNPsYmHvz2lLwCuU2USB/pRejTVQxB5tmln4EVD+dyGjPkGPGWjn2jIwGzPVFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736037823; c=relaxed/simple;
	bh=1CvGJBdfsQrSZP0bq41YTjTW80fDNBCU6ihC5Tvay2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AVrKEDnzXkM58KjQsxUY3RXiYHKkX29e4yCW/cQhC7as9fz7Iuu02WT2qkK0snAdG/Nh7xXr8TzN9mOG5pGzEB7zj5aLYcL6k+w6zMAP1eLJZuVZyJHgwqbZ0F40tsSfolnDtRHzf4yf4xd7Oo6D0KGO/+318xyMtFNdKCfxWC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3sLApVB; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b9bc648736so1093192385a.1
        for <netdev@vger.kernel.org>; Sat, 04 Jan 2025 16:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736037820; x=1736642620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jXzhdavCNuMsnLueA0771kqTUjEAV7QKi1FIGuZMdYk=;
        b=Q3sLApVBSJ864/XJIJ74jNLQHzS+R9PwgNDtjskvu4MrotnUUsDTxExozqmG9a/pI1
         045tnx9KoKwQbvFsTdTscGGVt6YsEpN5cDGBUtuJ6SzzhJvOFHU9qlpS2l3Js1Wsc/0C
         f5Fi9lkMyJQXXqo4IZPvO4tieYQvM9YZq7NZDWOxKztzpz33PWoItkmpYO/DExnLPVQd
         Kg4p6+wYDfEUv89yrojULjtda6lZnf41SLY6uwXkszgee0YCR/elliY12FBvk0RSDqlB
         LA603i8UOtWwvYOqxXXWC0YoIz2n9nzWjysZQ042yEn8vcDCg2QaNeRvNBImRLfVf/CZ
         +VTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736037820; x=1736642620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXzhdavCNuMsnLueA0771kqTUjEAV7QKi1FIGuZMdYk=;
        b=R1udF+xcOUZCpMmj/YrwySb7MG1374GOIqoByXHITxzgqoBS5Nbk2XQaT22QV/rr8t
         ukzi0kQAYAHU2UgfOKIlUo04iQYsW47v+5zLZIZukRISaiftJNa1FX7xKCxX6330qwGY
         RkaFVCmePqFi7rOqjAYEAtGX8Lpt+bvAv/1+29DeABPRoZEOY4XxiEvhpARBORiDzIxj
         /r1COxjjIP5ksQ72yuy1QzkmVyRAxJUXkVGY9Q+NmuusPqMkNMWr6pPnFhHViNwz2k1r
         k5QH41O+7MnS+/s9D6NPm+u4aCE5m+Ca/0Bc5XHUUf4e9iWjjmqIGxQ66m2UyMwdkU/f
         5H5g==
X-Forwarded-Encrypted: i=1; AJvYcCXTiBH7fFEyU45nB/yVyhxnYtQqbNKxfoktQoB7bBtN87AM0/n0QTTI02CmNjQgHncWRnKk5sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8qPi3R/X3bhK3HQoivwFbxm4dzjT3zH6WrCKG1MNPU7zcKgja
	Fgq/g75IWgWL7sTNEDmLRzzig4uRExN+4coXCKFZB+KC4ku9PR98
X-Gm-Gg: ASbGncs1320Fs8CURUFFYcRu09AQqHYjSfrYPpxpis9ACn2MWaOrtB+FZHzwT1KEpnn
	SoOWAkgKM34+IxkTHAXw2CVjaYoNDf2PWAep1rGbIeAAkO65iAkMiG3jyH78A2oN0jYOA1fWlbf
	IlrayNWqPzTpwHzDx/SI4Z+xZKCRT7y/fONg8LebEGcMYdQnmMcAf2Rq69u700n8K/2p2gSwoDg
	P8EFKdXLM8ZVIxS+wVShj0toiCGBJ/TwH+CVuceYSTdVTeHNLMfA3cmuw==
X-Google-Smtp-Source: AGHT+IEcxJWl2wjr7Id04LiuND3cEErMf6d3XzvYGaToZw8fdUG64cKqpBg0mtrwSY0BwA6gNoW8qQ==
X-Received: by 2002:a05:620a:4805:b0:7b6:6701:7a4a with SMTP id af79cd13be357-7b9ba82198fmr8616113885a.53.1736037820477;
        Sat, 04 Jan 2025 16:43:40 -0800 (PST)
Received: from echampetier.lan ([2607:fea8:1b9f:c5b0::4c4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e653f52sm160765281cf.16.2025.01.04.16.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 16:43:40 -0800 (PST)
From: Etienne Champetier <champetier.etienne@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Etienne Champetier <champetier.etienne@gmail.com>
Subject: [PATCH] ipvlan: Support bonding events
Date: Sat,  4 Jan 2025 19:36:19 -0500
Message-ID: <20250105003813.1222118-1-champetier.etienne@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows ipvlan to function properly on top of
bonds using active-backup mode.
This was implemented for macvlan in 2014 in commit
4c9912556867 ("macvlan: Support bonding events").

Signed-off-by: Etienne Champetier <champetier.etienne@gmail.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index ee2c3cf4df36..da3a97a65507 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -799,6 +799,12 @@ static int ipvlan_device_event(struct notifier_block *unused,
 	case NETDEV_PRE_TYPE_CHANGE:
 		/* Forbid underlying device to change its type. */
 		return NOTIFY_BAD;
+
+	case NETDEV_NOTIFY_PEERS:
+	case NETDEV_BONDING_FAILOVER:
+	case NETDEV_RESEND_IGMP:
+		list_for_each_entry(ipvlan, &port->ipvlans, pnode)
+			call_netdevice_notifiers(event, ipvlan->dev);
 	}
 	return NOTIFY_DONE;
 }
-- 
2.47.1


