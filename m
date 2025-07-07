Return-Path: <netdev+bounces-204513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1475DAFAF65
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 11:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB193B69F2
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 09:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BA128C5B3;
	Mon,  7 Jul 2025 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AToOLn2z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14305278E63;
	Mon,  7 Jul 2025 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751879765; cv=none; b=kRiBrDXwCqKyf0lxe2Pc5WqIuqGtNQe1qFtlW+YCaBLLoAc1bmTB3n4XZ2EzWQ9hZUMexkc1B4PGvwuYYgS7gd4l+cpEvJutEIukNM7MCUjh0Xfq7YvqkPI9W/hALx7LlFeVVo3IxXyVVOcJWiJ2dFWydS+H3tAOzsEhlpz7oOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751879765; c=relaxed/simple;
	bh=nC/FN3mVc3JR6bvleCxCfZLUGui1eUBpnn9Za7enxOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MbmMj1tZ7TLTnk8ToXP8759s2XwzrW/x4fal81imlyXS1Czgll+Z6I5n1Y439l+QiVIyJL1TluDNr3wfbphG3YtaT4HtqoabELSD7PaqgHjdwP2TuBz61nbOHP9nYH6erRAdC551q5El4OUB86pF59WgeR9e6cgaqxA2xskBwpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AToOLn2z; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23dc5bcf49eso8485455ad.2;
        Mon, 07 Jul 2025 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751879763; x=1752484563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H49/LGg+ueza8NJPHkaX8FcXqxyrWqBzkoXkHIKDikc=;
        b=AToOLn2zYocmagtWP0dw3IO5XaW3lLODKacNsyOrvc0NkDlz+FdkJlNuuJmRl7Hbcc
         Qvc1EIs9MSreWwMNYc64EkdmOXz+coHtw/exXFwD4UrFW64POzKGHv/qChTzlCWvZS9g
         c6JsA7vG2q0q+o3IQPG+zwHUXhyi1ozbiwMAq/u0rmtidi3dPf4xQty7aimnuARPNrUW
         uI8/Dyws5TLcTMBKt2QnoDvVqc4dPXws+j7bwTXJmKb/cIv+I0TtoX4JW1VgogvJhnob
         JjHLXyOsuy53YrMY3TTXlrBCQpa/ItA+GLl7/bd0qAX+gqMHnXwhflyojaPMa7YFHNZ0
         dwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751879763; x=1752484563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H49/LGg+ueza8NJPHkaX8FcXqxyrWqBzkoXkHIKDikc=;
        b=XHoB6JM05ILcU7Qo2ZaUMQseZNxgTAeFoRdf2yFmZVrtIqF3QgtfIC3g2rhTZ4miLS
         rJIbciGciMJ05W9DhJa0P/RFE+49U+u7Y1JPgSq4bYlQueAHQyBLZqu3DWh3y8Bn0FLl
         OjO0PKvs2DLKe0s9qdFyJBHZ169Xn3+7WJL+AVG8BpErTTxTYwgEv2tfeiRwDjaeIDzZ
         rNSGjuCz57UFVPqUO+DYPXsZxkrTlhBk5XbkQNo9/i0mRPij+gWDorBmVxTLAmeOmdBq
         L8LEjHDV11IKPfUJQRjtPoIVK0DSDNeUCmip92eaHbiVTSQm50NeN60hMgyuSyLXhg+4
         fxBw==
X-Forwarded-Encrypted: i=1; AJvYcCXE31+tOI2XBL24A3Mgl9h+BxDYmEh7Ui7iHOiA/SRmUDx9UOl9vqU+fK98EThCmAn+pPgpFE7S@vger.kernel.org, AJvYcCXe91KbBP4PaEJzgLaNz6KYYcPX6qNN3BA24U2MqhAR79oclz6vUVW512cTAA+vo3HNMWwhEXyUOZx3buM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPjw5FkWsI8HyUjV78VpObuH/B6Ts1YGNzo0LdrmQA+r2bX46W
	n5KkDTQku1k9h+vgqulixt28Va5icfDrUsLnuCTxvJohYRFGS+OQHRMG5f/RtWl2fuU=
X-Gm-Gg: ASbGncvwLuaNvq1nWWVvxjjc2C170gOt7fO7ZbG8PXswoylkH5wO+LFWwBmw4uOegFm
	HipISve8CUwuxThobeuYPdNempGJYF7j5ram/WuheETglinJW1XYCn+iXLdF44fqCL17+OYsLTM
	G9kyEtubHbRmSnPR2i78orf3CH9N0VOGN6r2qURjBC9nvNXm6XOrChquIgp2KNjLKKz/X1pJBDO
	cAwqWmMeOBK2csG/eTqhebGYxi+418D2gCVnCWqOL5J5yeDKR7cmeinGbLVBYU9/1Y7Vl7miVKu
	wrRbNLN6of3ZZmOS5W9xBkz8w/4XTIMjBlOi/Z/8kUzG2PyNV0orohbcMNj1EGZ0fU1hSb4t4fd
	LnhuOPcNjzoVE
X-Google-Smtp-Source: AGHT+IHuXjsRlCQg+cucVpZNwGxpgWu/tfCTLLvISb1DtSgYBy8ob4eM1nBJcpN/cMBbOa4daU9mRA==
X-Received: by 2002:a17:902:d2cf:b0:236:363e:55d with SMTP id d9443c01a7336-23c90fc7ad0mr142454125ad.28.1751879763290;
        Mon, 07 Jul 2025 02:16:03 -0700 (PDT)
Received: from localhost.localdomain ([43.224.245.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845bdb15sm80504165ad.243.2025.07.07.02.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 02:16:03 -0700 (PDT)
From: Wanchuan Li <gnblao@gmail.com>
X-Google-Original-From: Wanchuan Li <liwanchuan@xiaomi.com>
To: jv@jvosburgh.net
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wanchuan Li <liwanchuan@xiaomi.com>
Subject: [PATCH 1/2] bonding: exposure option coupled_control via sysfs
Date: Mon,  7 Jul 2025 17:15:48 +0800
Message-ID: <20250707091549.3995140-1-liwanchuan@xiaomi.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow get/set of bonding parameter coupled_control
via sysfs.

Signed-off-by: Wanchuan Li <liwanchuan@xiaomi.com>
---
 drivers/net/bonding/bond_sysfs.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index 1e13bb170515..5a8450b2269d 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -479,6 +479,18 @@ static ssize_t bonding_show_carrier(struct device *d,
 static DEVICE_ATTR(use_carrier, 0644,
 		   bonding_show_carrier, bonding_sysfs_store_option);
 
+/* Show the coupled_control flag. */
+static ssize_t bonding_show_coupled_control(struct device *d,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct bonding *bond = to_bond(d);
+
+	return sysfs_emit(buf, "%d\n", bond->params.coupled_control);
+}
+static DEVICE_ATTR(coupled_control, 0644,
+		   bonding_show_coupled_control, bonding_sysfs_store_option);
+
 
 /* Show currently active_slave. */
 static ssize_t bonding_show_active_slave(struct device *d,
@@ -791,6 +803,7 @@ static struct attribute *per_bond_attrs[] = {
 	&dev_attr_ad_actor_system.attr,
 	&dev_attr_ad_user_port_key.attr,
 	&dev_attr_arp_missed_max.attr,
+	&dev_attr_coupled_control.attr,
 	NULL,
 };
 
-- 
2.49.0


