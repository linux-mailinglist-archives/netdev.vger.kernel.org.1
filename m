Return-Path: <netdev+bounces-243934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 382E2CAB151
	for <lists+netdev@lfdr.de>; Sun, 07 Dec 2025 05:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5303530071B5
	for <lists+netdev@lfdr.de>; Sun,  7 Dec 2025 04:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BB0299AAB;
	Sun,  7 Dec 2025 04:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8dk0uBZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642B92264C8
	for <netdev@vger.kernel.org>; Sun,  7 Dec 2025 04:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765080950; cv=none; b=dY9s1iVvjlnwxghXYsVampnUdlz+rJgobMRz75mhNjnz039OMdqErzVzU7IOr3YL0Kuwt4mJxSN3X9zgyCtJssZ4AmeK5oYmH1xzZwOTVyIbhnb20aDOg3qJ7+3U82hcrl9QjeEZuF6pPAHWYoC1/GtAWihchhUXKXyKUpbTvuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765080950; c=relaxed/simple;
	bh=CH0JCg+x6ZCxO03Ve8BazGG2PmwRtVIYlG+VZQ+/Sn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIjeMQWZGVW16fTYo7dfx0pf3XyAIRhbw2ntYlZ24ciukglXYBq4PU0cuzMlPcrLgSjCF0RGFyg1iYnlCbSuvJcqErD8TXXeIMwjD/muocIYWVFSHSVWfHPKpi/wNN96praZ87/Yml3C7MBhzereass7uNThyo6wDksFHMYQnn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8dk0uBZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7ba49f92362so1915611b3a.1
        for <netdev@vger.kernel.org>; Sat, 06 Dec 2025 20:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765080947; x=1765685747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8L/Ed6NRxGimROsWFuBthfoaWOcKruElucJM5+XHkQ=;
        b=V8dk0uBZDpZuRxD0XIha1aZz/H6rqQSnv8dtkB5sgh1dMqhoR2xxH/yd4sINSyphjr
         M/AOEzlBa7hVAw63mhkTvlQwmj6Zu1B3Xw9hwLAgJ/QImVRAWfc2Z28Mft6zTaFa6LIU
         4X27OTt06MieMqEyn7LvPKzAVifpI8xu/RQQyON4jzsfgSL3eaq2poE5w9V6Zap59unA
         Ecf0ZOOjltknS6Fr6l07YvySanSdqZlV7Y418hoglBBPqYpKmHE3y8rxUa3INxUwzv4e
         8tZDvwqToQrdlkXU3A2GjqYDgj4SKvYoJs2C4mK4NszUmlcyFGNqwBXbRR7eMuLXokOA
         73Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765080947; x=1765685747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v8L/Ed6NRxGimROsWFuBthfoaWOcKruElucJM5+XHkQ=;
        b=KTjCUyc5oLrURL1EgoTXSnUAyR2ew7POHqhNFjcIXwzEAm8/gl2FUGZoaMrP5rlYcY
         UUnQqE9O2gPQVOHKfZs1TaT6QBwN11TERX0Kq94oEvyuXS7JzrmkUpGWggfupqrfEFFb
         OvNufYBfp80yq7LarN9bGoUNkIxIbtwQCRtTQ7HRnyWAGrxN9LV/o699qK/bY3xXTW3w
         M6MXrSTiymzsU36giX12Ja7b6sXWltCbta1Ms93F2x5OmKFty/g7r4xF84+B95AcRkOD
         KfHe6QPothkX6rjOHnYk6njLF5SbJEX3g7w00dGtWCpz2LOkNLavSBTMqstTb8bE9ZVR
         voOg==
X-Gm-Message-State: AOJu0YxA8K5j7A7wJB+B7Y2JxIkPS0EJptYIkp4zcoocDrCY2+Dwlq44
	jQ2QSFrLKS7ZsHAR7dxr9qvuaQtUkoRAbPkekRcM/z51zYhVj3Xe3eNY
X-Gm-Gg: ASbGncsOzFrKauWhUnwZpJISKwiS2YjcJ09QLUafvOd0NeD9R8+IQPol0GyWSkmbS1a
	tUppFI/IwUicVlwLZ1PFcYgM70xQ7xK7XVoxOr56NNCesv83w9Y7TPv7zAFc/dmeM4tH3tz4XRx
	VbXYQNM3cHrV4nJ/RhR9llcalRhvmnNAQvUET405KqNWBYU2pTQl73W/lRwNm9MwKpc9jbsiZ05
	YR4ehlrHcMoVRpED/OmXljaGXYgXjeb3OLDVrK5xb+vrKMPhnPG5v6MCPfz6nuYapnilGvyxzjV
	CxQY4jFAaXH7R05LsmNK/Oe5Cj7+dMJaJ0tDkKLGBbVwQlPRr8IVPTHd6PTBZqrP24oW/nb3GgP
	t2DsyZeKJzOIs28k0hbsFleNaKIoQD2t+ZOrFwNTx76lfexs+Z0yDi/WfxQE1xhi3jtIR3xMgXT
	NDZ4pcolHwgn9t+lFNuOW3IhSFRCS+enee
X-Google-Smtp-Source: AGHT+IGnXWxNMpWxh0zg6NWrjsV0g2I/T8+cYXEqWP0QPajgzsYIK+iQ3cZg9Hr+NOOkPN3lmWpLDg==
X-Received: by 2002:a05:6a00:4a12:b0:7e8:3fcb:9b02 with SMTP id d2e1a72fcca58-7e83fcbbce6mr2876107b3a.24.1765080946862;
        Sat, 06 Dec 2025 20:15:46 -0800 (PST)
Received: from localhost.localdomain ([38.224.232.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2a062ac40sm9175318b3a.25.2025.12.06.20.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 20:15:46 -0800 (PST)
From: Dharanitharan R <dharanitharan725@gmail.com>
To: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dharanitharan R <dharanitharan725@gmail.com>
Subject: [PATCH] net: atm: lec: add pre_send validation to avoid uninitialized
Date: Sun,  7 Dec 2025 04:14:53 +0000
Message-ID: <20251207041453.8302-1-dharanitharan725@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202511281159.5dd615f890ddada54057@syzkaller.appspotmail.com>
References: <202511281159.5dd615f890ddada54057@syzkaller.appspotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a KMSAN uninitialized-value crash caused by reading
fields from struct atmlec_msg before validating that the skb contains
enough linear data. A malformed short skb can cause lec_arp_update()
and other handlers to access uninitialized memory.

Add a pre_send() validator that ensures the message header and optional
TLVs are fully present. This prevents all lec message types from reading
beyond initialized skb data.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com
Tested-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com

Closes: https://syzkaller.appspot.com/bug?extid=5dd615f890ddada54057

Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>
---
 net/atm/lec.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index afb8d3eb2185..c893781a490a 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -489,8 +489,33 @@ static void lec_atm_close(struct atm_vcc *vcc)
 	module_put(THIS_MODULE);
 }
 
+static int lec_atm_pre_send(struct atm_vcc *vcc, struct sk_buff *skb)
+{
+	struct atmlec_msg *mesg;
+	u32 sizeoftlvs;
+	unsigned int msg_size = sizeof(struct atmlec_msg);
+
+	/* Must contain the base message */
+	if (skb->len < msg_size)
+		return -EINVAL;
+
+   /* Must have at least msg_size bytes in linear data */
+   if (!pskb_may_pull(skb, msg_size))
+   	return -EINVAL;
+
+	mesg = (struct atmlec_msg *)skb->data;
+   sizeoftlvs = mesg->sizeoftlvs;
+
+   /* Validate TLVs if present */
+   if (sizeoftlvs && !pskb_may_pull(skb, msg_size + sizeoftlvs))
+       return -EINVAL;
+
+   return 0;
+}
+
 static const struct atmdev_ops lecdev_ops = {
 	.close = lec_atm_close,
+	.pre_send = lec_atm_pre_send, 
 	.send = lec_atm_send
 };
 
-- 
2.43.0


