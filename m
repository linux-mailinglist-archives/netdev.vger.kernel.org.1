Return-Path: <netdev+bounces-161455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631D7A218FB
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 09:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BDCC3A3933
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 08:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B7319B3EC;
	Wed, 29 Jan 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLpupIRy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC70190072;
	Wed, 29 Jan 2025 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738139189; cv=none; b=Cv4+zi6V/6c5+ASO6aWt/4egpyr+n0BvW4nYpDYPoz3+kSuOYSNxICDSnsVFrEsYrn41u1TSGMp6xJ4+OCqlWcU4MCfHCgCq9ob3CiKFWhfUw0jaAS2JPnJkgnHfuimO6Hfr4hMfNZy1OhmpSbQXIdGuRxmHD2FQv5Q+9kueCQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738139189; c=relaxed/simple;
	bh=EB6d/lA+Vl3aW3WGzOUT/07HHxNDlt56EtRgu/2W50c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBuig0lYiJfTghihpzMfOco3iOJad7thUxaVC00FzT5QRjOuRHHlrbDsfwjXM1UQ/TJ20Il+R4zB4qDDG4iUo/miouqyfkGMNY9FT8/R6lx7hMpMDa1gl3DzcuHYB4cgNlUCcQD93Ar+d6SXyevn485x/lxxIe2KIad0x2amDE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLpupIRy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361815b96cso44234985e9.1;
        Wed, 29 Jan 2025 00:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738139185; x=1738743985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/J1Wq/AaeB7MfFnmxVQb1pQSUvq/YuhgcrUpgACBdM8=;
        b=KLpupIRypbicMR/t/2E4veFOt+7vfqYWXn6mfVhqNTfsWZLEC4aV5mu8CwhFRL30xS
         87HrUDDFJow4c46FLAIDZ1UBEJkMkrU+Xs9VxfhFREsa6fmtraslGmjHPghtsTBQCgra
         di7GzDRozgUQfQ0deDtDuhr92YaeSgfCpoL3Akrmnp+XuD5buDSiFYu99BHpratK0RZE
         4Ta/LQMAoL07s7oYshUmBRQF2NkMRI48ynVA3lDAM6KHQHQbKDy40HsGzaDffxvUFrez
         d4kljY3EBwF6ie7sHx7Sxo2PcJjXWPvxJ0ySYddx7zPnjxYcV4rBcOTqg9yg8BRy0Lk1
         QEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738139185; x=1738743985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/J1Wq/AaeB7MfFnmxVQb1pQSUvq/YuhgcrUpgACBdM8=;
        b=DznpgmbcGyiGNJFq+/14JFaKYeh3AlW5KUOGohueK4WF5icBTwNLCKLoCBgzlAdccy
         CTTxKNwWJrCKY0sCp3SSnmR9yxDuJjwAkrloXFMHomvShI9jZt2r6gkjwumVxJWD01n9
         X51Arlp4hYP26A/+OkeCBN4jhCOTEyph/FQxhAjTM8DuNmc2iz8R1Ig/w1lyv3ThWQZ0
         ZpSQHq1nfCxwQVSOTeUUdasggt59xqIg/txCZnwuz+7v+yOADBYR103I3Le/qm540WEX
         KHaMBpF9vBnwcHzbW07masxeboqonnd1+t7JkF0mozEOLsUwkELJqA4nhgZLq4k1dT0t
         cLXQ==
X-Gm-Message-State: AOJu0YwceXvNB3R0I03oLgHtMJo6JFU0rc37FtzecHUcDcVVP4mH08tf
	bqGHhf2u9GDJaa6dMfI6eMwi2R7L/aTErJXK6R4OZvqlPMcus/jJl1eTZuPtPeo=
X-Gm-Gg: ASbGncvh90namWuV+EzbQsB1+FPp5HDfLcmHjn5n1bq6OYUGTXiYOjIHBrfs+FyekNZ
	eKT587ajtf3aOmHYagVHTRfRVrLMbgr4Wr9TLnQawLtFnClQwRKkxnrnS5VkZCsNjrMvruFQ9cb
	f2xtvybVcUsN45Aj56UW4n/bh7JNOJN30tuG+bQYOd2dRFLMDx6J6lyjcDGwhTsjaB8gbAyFSdU
	zpu2fF9dUa460PkdRlJg+rW6+fD9dY0ZYFD88bLmcIUBGCWbc2FB9wDzhSiXCPJUP5YWIcIWhbW
	OWAVgSbc1ZZFiQ5fSaSYPc6FWMM=
X-Google-Smtp-Source: AGHT+IEKFf0cWAtmojQHgawLYlEVoJi8yhwRGtVDv41XXb3FAD/RISvBuvIANzyQpL2XWLeahT5R7Q==
X-Received: by 2002:a05:600c:a44:b0:436:488f:50a with SMTP id 5b1f17b1804b1-438dc3c877cmr16546845e9.17.1738139185116;
        Wed, 29 Jan 2025 00:26:25 -0800 (PST)
Received: from localhost.localdomain ([37.41.15.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc8a59dsm14120685e9.40.2025.01.29.00.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 00:26:24 -0800 (PST)
From: Abdullah <asharji1828@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	Abdullah <asharji1828@gmail.com>
Subject: [PATCH] net: ipmr: Fix out-of-bounds access in mr_mfc_uses_dev()
Date: Wed, 29 Jan 2025 12:26:01 +0400
Message-ID: <20250129082601.51019-1-asharji1828@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <678fe2d1.050a0220.15cac.00b3.GAE@google.com>
References: <678fe2d1.050a0220.15cac.00b3.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Abdullah <asharji1828@gmail.com>
---
 net/ipv4/ipmr_base.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 03b6eee407a2..7c38d0cf41fc 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -280,9 +280,31 @@ static bool mr_mfc_uses_dev(const struct mr_table *mrt,
 			    const struct mr_mfc *c,
 			    const struct net_device *dev)
 {
+	/**
+	* Helper function that checks if *dev is part of the OIL (Outgoing Interfaces List).
+	* @mrt: Is the multi-routing table.
+	* @c: Is the Multicast Forwarding Cache.
+	* @dev: The net device being checked.
+	*
+	* vif_dev: Pointer to the net device's struct.
+	* vif: Pointer to the actual device.
+	*
+	* OIL is a subset of mrt->vif_table[].
+	* minvif: Start index of OIL in vif_table[].
+	* maxvif: End index of OIL in vif_table[].
+	*
+	* Returns:
+	* - true if `dev` is part of the OIL.
+	* - false otherwise.
+	*/
+
 	int ct;
+	
+	int minvif = c->mfc_un.res.minvif, maxvif = c->mfc_un.res.maxvif;
+	if (minvif < 0 || maxvif > 32)
+		return false;
 
-	for (ct = c->mfc_un.res.minvif; ct < c->mfc_un.res.maxvif; ct++) {
+	for (ct = minvif; ct < maxvif; ct++) {
 		const struct net_device *vif_dev;
 		const struct vif_device *vif;
 
@@ -309,7 +331,8 @@ int mr_table_dump(struct mr_table *mrt, struct sk_buff *skb,
 
 	if (filter->filter_set)
 		flags |= NLM_F_DUMP_FILTERED;
-
+	
+	rcu_read_lock();
 	list_for_each_entry_rcu(mfc, &mrt->mfc_cache_list, list,
 				lockdep_rtnl_is_held()) {
 		if (e < s_e)
@@ -325,7 +348,8 @@ int mr_table_dump(struct mr_table *mrt, struct sk_buff *skb,
 next_entry:
 		e++;
 	}
-
+	rcu_read_unlock();
+	
 	spin_lock_bh(lock);
 	list_for_each_entry(mfc, &mrt->mfc_unres_queue, list) {
 		if (e < s_e)
-- 
2.43.0


