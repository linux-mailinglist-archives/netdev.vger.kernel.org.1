Return-Path: <netdev+bounces-145180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D88F9CD650
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 05:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43067282EC3
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117D616D9DF;
	Fri, 15 Nov 2024 04:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuluIQug"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DE561FEB;
	Fri, 15 Nov 2024 04:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731646694; cv=none; b=P58upzTUS3wbTzh5cpaPkhFRbgG3qY7bvPUVvs66XlmjAK9mxNgfqeqRHN4B4/Bf3Il8DHH77S54VsZ49hjeKqtHeHZemNgd+JCHeTP2y1vXZBgoklA9Qo2xOmJsIdwUajBp5XG4kvKS81ekaRLV6uBujjLnTmYtfIO8EtnTHJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731646694; c=relaxed/simple;
	bh=tpPC+qMEm8Rqne+cwyfDi7DPVgfoaHrzuLLvF8D0V+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i5V+MpefLnsBprAcvfLjIS6n6DHB2KyBOPFjySLAHwnNmtlyYr8m6/0PFgthDooEPIkdA9mgIRhFpD2Ezhh2uihzgTfIqALzrGFTeEXoEs1mM/BhNFcMV+G884LDF5RyUuN11XauJGTa5knrFKFNX7jDK2QkacuiatuBGttM9lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuluIQug; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cb47387ceso16053425ad.1;
        Thu, 14 Nov 2024 20:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731646692; x=1732251492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiF3FgqNJA4tZDa0J2g8epdxrSCCmBW2k+8rzqXZnfk=;
        b=GuluIQugREHDgbaGYMz3vOd51P6OVf7pAqyd5xKV+wmeOmo9YZ7pN7oV7guUniq9sp
         G/LLKzT+0Xu0r09JMPleUv/TrPB/6JivVCN7xsSHDWaHZfCR3hZeRNn94O+K9oM+/N6l
         5wjX/+1Bjm7ih7WgtXL8QyP1QvxnZbx5wN6kuhYHztpDNuQrruWSBmmCPRDNIblOwkcG
         /6fGnEQBBt/lCYun9UML2uv3WkEyubxwckryubFso8+qMhnVFkmtXg3CxzwVPHaDovuv
         jW3D/epD+W2oTUyqwy9K05TIktEhbz3vli2XISjktuu6bj5KBBqDlYU1MdbDDzT2Hx2p
         vk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731646692; x=1732251492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZiF3FgqNJA4tZDa0J2g8epdxrSCCmBW2k+8rzqXZnfk=;
        b=SutQmhR5PWg1Ob4EbN6FuVdZ4uLln6B3BKWpvm2T0KeQ5bfbz0OpDBPQSrQpEoUv9W
         TJyIz/5PuqS+yA7noP0WKw9G6x3NiQ32MUNMRkdcIpaMzHh490gQnNmNedo0gXRJ7hWa
         LqdEao32/fB2FNXyXCD/B/owsBCbOBTyrlnOt0RmZ86YaeZO/7//GVyNQSBarK6lvDm7
         CELbrNmxQoqS5i/1AEY96U5LnSca372aCmnE6Z9OA4Hc1CkQ/y1+o2TFBdZbO9oN44eG
         ev0vlf2/IPQNMRn+12W7CVaBG0sMVbWrGnsIhw223DDEEoN6MS6o6uWilKIK4EvV45X2
         nVZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9mDs0qeoPJ/JTHYr/fOJdSwTGnQ3ZPwz1dPTqo6hrMVScWFhOVc3Wt6ErUSjAs6w0uzpPHZxkqBoJ4g8=@vger.kernel.org, AJvYcCXLNVV9IdYzJkEcvOj79fx/7TZACPktW/MmQmdiSm5WOdYmulibgWV1ojp+89gH/tvrVYxIum1B@vger.kernel.org
X-Gm-Message-State: AOJu0YxdG/1KjiqX8aaBnrpsspVnxgP+5QDnTtUOQ4s9bEelw/Uvpa+z
	HpXUuUKP2NcREkYsnndXFrT/s/wYdbEFzwMabiG7tPQh2IPJFNiNXVYfjvi9
X-Google-Smtp-Source: AGHT+IF5BHuijPtl48H//iBsTd5HSy6KmsItjpyh0p28m6AERbvt7GJ/T2MK2aMn16UtOQM0C/bEew==
X-Received: by 2002:a17:903:285:b0:20c:c1bc:2253 with SMTP id d9443c01a7336-211d0d861c9mr22855985ad.32.1731646691860;
        Thu, 14 Nov 2024 20:58:11 -0800 (PST)
Received: from HOME-PC ([223.185.134.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f47cbfsm4542935ad.217.2024.11.14.20.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 20:58:11 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: mareklindner@neomailbox.ch,
	sw@simonwunderlich.de,
	a@unstable.cc,
	sven@narfation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH-net] batman-adv: Fix "Arguments in wrong order" issue
Date: Fri, 15 Nov 2024 10:26:37 +0530
Message-Id: <20241115045637.15481-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes an "Arguments in wrong order" issue detected by
Coverity (CID 1376875).

Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 801eff8a40e5..781a5118d441 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1195,7 +1195,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 			goto out;
 		}
 
-		skb_new = batadv_dat_arp_create_reply(bat_priv, ip_dst, ip_src,
+		skb_new = batadv_dat_arp_create_reply(bat_priv, ip_src, ip_dst,
 						      dat_entry->mac_addr,
 						      hw_src, vid);
 		if (!skb_new)
-- 
2.34.1


