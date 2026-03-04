Return-Path: <netdev+bounces-263620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDp0CTfcp2lnkgAAu9opvQ
	(envelope-from <netdev+bounces-263620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:16:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 931841FB747
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65471302FEA2
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 07:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3872330668;
	Wed,  4 Mar 2026 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZpsIkHn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A625833B966
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608505; cv=none; b=P/lwtuSdhycWYNcbhgmNlgbg/hxZ3PtaGvVl8Aj9Z6Slj1vAJotG3qPwn2hE2k4vtG6uyMa9JYk2uoskCZcp5rpC1eWK4hFFfUIIagTt6LhBkfyBKB7QC+U8uogU/+y51x3Hof+cc4Femq91XQcDbz3qvIaUR49uzVqBqpjpV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608505; c=relaxed/simple;
	bh=4suyWihyC1ry/HvunGlIS6YHwIWLTnzKEYrI3QwXGaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qp23N2q8wNduBlwk/ztRVzaVP7OpMNBCZV2YAlbVjjSHz9xCje/QWRkcwaRYTEiP9f6iIBKtn+vp0k9QZp8uOTlSS1VT9z78/8J0fioWcusZgDuSdanHkpOmKeRcXddurwEvFVznF1IZrYP/oqoy7TzB7qRXjRjd3cAmtkR6R0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZpsIkHn; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c7381c4345cso40539a12.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 23:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772608504; x=1773213304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pDl+XTs6aW3UhEf8SPsZqwG+HpyZqHIJ08ht/L1JbFE=;
        b=lZpsIkHn34+/vdnx7ROu3/5LFy9fyVh5CrOqbHuNddNB+G/vHk+F9jpQrFsDH4EZNy
         QE5EtuLbpBZ5wY8TdsbzypBGHvy9fBwO/CEab9AQxMndlWdEtCp//2u/rrnCy3PW986L
         VyyGD5hSIZlQuizvLIf2Eo/upLixH0CD7pb300meaYdag8vxd5rY+seeOHc37kzBbU2g
         xdj/kp0KKp6h6DlM7uNTX2OS8sBLdUjcXlo4X+mTP+eZwONllkCHYM/ws72qmXglh5SM
         yeNCHmWhloyfd6G3llpEuxgIeEkcfYD/EBAbr7OyOOvjzjdedID6cJv99xxDy3INPKdO
         0Lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608504; x=1773213304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pDl+XTs6aW3UhEf8SPsZqwG+HpyZqHIJ08ht/L1JbFE=;
        b=mBdSuMdXB4WIu2ufRL7pZGe5leimRKKkw9+1HEs1wiAwfK2yxuj5r7JDcF8aEcwbkA
         4W08xE2Y1Rtz5vgu3ctc0/GFyuJ5oZ/NhEdRpRymMsXSmIsE1TaEM64aXIPEyKX5P/ZR
         1T2Ir7rQXTPtrM2x3W0rXyDapmBVEOtRfkqPHf8M/qmNIKqba0PDSitVSjMXqyc7BaaY
         dgk1hZ7WPkoSXHC9kAd+0lfu+MiTCCKKFuP2JbMUb/6dVhuHIlFlegFakh08eXVyl/fn
         BFtpBV1AiMLYQ7O+ohSQ7T7L65enOSFdCBXLaeQiPyGPZwpaPhZhPOpJ/CBMEX7HWhfG
         lZLQ==
X-Gm-Message-State: AOJu0YwsbBCBPg0Sn9YPQU9DmuEyiOJO+UD+z0/kASbiqAIyKbTW1spV
	ih3Iqi5d6GmwATeX8hlzcOZlNvj2xId2GRDhx/DPxszJu/CNc1X5748A
X-Gm-Gg: ATEYQzyU0k/oWjV8a8FZJ/u77jmFi4Sspp6+6SmCvq9sxbxIT3InB+N46mF0sRXc5X+
	SEn5h/uZ/GK6jGjNwDMusJFrG4SCsn7v6pbZNkm7Ag+ipP1iED413yELaaPOKdR8EiC2nnFvXsA
	iVzOQh1NO07FL68MxA4e8bifSa2QIQ94oN52YoJ3T9TZcy2s2FadwKCPnBBYc5avWN7LvyiTnM6
	KX/jXfHZ4b2COvW2V9YRMWuuDbDmqbs7OHr880UXoI/Nz+XhvLxg0oVchxP6ozdh3jvEhcoqiGE
	GtRr6IssRY+CnB45wicc+zxFxIZTmNfQVvT4hwajRw2YjwBhqh4OIrb3frzQxKDrHZFfJAwReW2
	xgvV3KLPRq0tZhWMhvGTHT7WSB9luD/0vCZr0uV01gRCN/WL9/m4SkcQJneAo5S/H+AQ2oKaXcp
	IGUtWL2io76fKU/Cd9rec6tVX3+uSN765yLmQN6BvfTZFg4nGBB5gb6hilpHyfgq+ZZp2KuWskt
	IaL/jI+wX0gC0nYEpPD6v7Ib5u3sItSRcSsxKwGrHP2rhtSk7dz
X-Received: by 2002:a17:90b:2691:b0:359:84a3:1942 with SMTP id 98e67ed59e1d1-3599cecc8bamr4364578a91.13.1772608504029;
        Tue, 03 Mar 2026 23:15:04 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([240e:34c:576b:6b60:293b:552b:9870:28a3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359aa3ebb2csm85731a91.12.2026.03.03.23.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:15:03 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Wed, 04 Mar 2026 15:13:54 +0800
Subject: [PATCH net 2/2] bonding: handle BOND_LINK_FAIL, BOND_LINK_BACK as
 valid link states
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-b4-bond_updelay-v1-2-f72eb2e454d0@gmail.com>
References: <20260304-b4-bond_updelay-v1-0-f72eb2e454d0@gmail.com>
In-Reply-To: <20260304-b4-bond_updelay-v1-0-f72eb2e454d0@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tonghao Zhang <tonghao@bamaicloud.com>, Hangbin Liu <liuhangbin@gmail.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jay Vosburgh <jay.vosburgh@canonical.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 931841FB747
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263620-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bamaicloud.com,gmail.com,blackwall.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Before the fixed commit, we check slave->new_link during commit
state, which values are only BOND_LINK_{NOCHANGE, UP, DOWN}. After
the commit, we start using slave->link_new_state, which state also could
be BOND_LINK_{FAIL, BACK}.

For example, when we set updelay/downdelay, after a failover,
the slave->link_new_state could be set to BOND_LINK_{FAIL, BACK} in
bond_miimon_inspect(). And later in bond_miimon_commit(), it will treat
it as invalid and print an error, which would cause confusion for users.

[  106.440254] bond0: (slave veth2): link status down for interface, disabling it in 200 ms
[  106.440265] bond0: (slave veth2): invalid new link 1 on slave
[  106.648276] bond0: (slave veth2): link status definitely down, disabling slave
[  107.480271] bond0: (slave veth2): link status up, enabling it in 200 ms
[  107.480288] bond0: (slave veth2): invalid new link 3 on slave
[  107.688302] bond0: (slave veth2): link status definitely up, 10000 Mbps full duplex

Let's handle BOND_LINK_{FAIL, BACK} as valid link states.

Fixes: 1899bb325149 ("bonding: fix state transition issue in link monitoring")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 93a32a368d31..444519078da3 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2801,8 +2801,14 @@ static void bond_miimon_commit(struct bonding *bond)
 
 			continue;
 
+		case BOND_LINK_FAIL:
+		case BOND_LINK_BACK:
+			slave_dbg(bond->dev, slave->dev, "link_new_state %d on slave\n",
+				  slave->link_new_state);
+			continue;
+
 		default:
-			slave_err(bond->dev, slave->dev, "invalid new link %d on slave\n",
+			slave_err(bond->dev, slave->dev, "invalid link_new_state %d on slave\n",
 				  slave->link_new_state);
 			bond_propose_link_state(slave, BOND_LINK_NOCHANGE);
 

-- 
Git-155)


