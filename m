Return-Path: <netdev+bounces-299983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wS32JNnQMWrPqgUAu9opvQ
	(envelope-from <netdev+bounces-299983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:40:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DDD695A07
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:40:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VoMomymS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299983-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299983-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A53C13100799
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3D73E5A0B;
	Tue, 16 Jun 2026 22:39:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09B039768C
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 22:39:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649554; cv=none; b=CiEXmL8yw9gCpKisaHKQaOM7XqI5vNT4AEhemt9SlFuyW0h0xxcYDmbMCOCNLSxK6GnzBL9jd/fHHFK6W8ExBaYjXnPRgtqT7VvpqTZABsdALtUqrw+bXm+uFclLRgPGV7OG+bfhhW89wfMgRuHb6pR5cLBNwv82Ouhg4Zb/uT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649554; c=relaxed/simple;
	bh=SZge3+wENcu5w1P1BVM627D1qeRTJqud1ZjCOFFrjto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EjJiLTTnW3ONZ4wXSvI+WDv86qWFPL1Hdm9mRxf8J1QwLNQ/vVH3woKIcdEauxZxfgQbxsOV8WKUxCK4DDh/clTnIg4c/HcJY4hqzcc5QW0rqnn8McMBTe6zJq1xbck3Z7Bu9TY0RGlWP/yPIRjTfsc2Y7oqhM93QlQ7qSrJnnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoMomymS; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso45750915ad.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 15:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781649553; x=1782254353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqf3MKkeefxf95U2zVNMolrJWHRRcuWWVaIRUGiTD6g=;
        b=VoMomymSItxXX/yYRHXUy7HFs8VXoKKqAZBI6M20rlWwu+/ImhzCRTboHaCbZfDPiK
         PLPR1OlSUxvtZMOTqz4Fz7LRL8uYS/rFA7+D69iiMQUm3THpCSxJM+JgCpyg5KzAGNwT
         eflJcqNJGItC18PXmYjiMEnqdCJ0EUwV9fMDArCSfLud8ZXXjC4TnH/s7ugGJB4/1IlQ
         rmiTuBp+1O4NCsyjuhnSe6OJ5VBI5Y5IMCPUFFKcikwy+OcDdUmqvFQQ80e84GLkJWj8
         KmMxeKJRbaG0UIpFzDRio6h2DTNoVm3Y2U7koeLn39LB2gVkaMinQ9d+JZEaFFHUqvSy
         E0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781649553; x=1782254353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uqf3MKkeefxf95U2zVNMolrJWHRRcuWWVaIRUGiTD6g=;
        b=BtPfAY9kQ1tjlOeL+8iW83bCzDmtvV/UtRAhSk+HdO8D2WDUOWBjEw0mKmVlxBKCDL
         8j03D4ps5wuxUAeN5/hz0oLE/3zxozrRI3PW7g9cQggHMI+K3lBjSST/yVmx3bSJFtoI
         hhuCDlUurwUDN/9K3XenZpOiSTPqUltXvWFs9bJABXXMgiXCOftk+vIjZE9DvFzKt91N
         47+6BGsyjgcrimavCo4I/AlctKH01hzXbqD9x8NJysNhO/affpG5hOkwbJHUVr3LvTEu
         HvBbJM3Rsib0fSt8sbUv9yfJTymynQv5o+hngQqxMlgaGZbJuN/YxksYO8OtOAUZz0Si
         sVQA==
X-Forwarded-Encrypted: i=1; AFNElJ/G9xc0aJ/IqJgcn8wwUNXwldqrF5QEjZ3+1GLffpBQv6QuMMp56pWiup3UxTmWbiciJyTRsiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD7zwNJRHFSUMmU4ERJX3J6qib5s7b7SRKeFewICmFbrvLH1jg
	vflwyvZht8QiuHYdYXzktDojf/Nj9HH3oAFZKm6W2hhOm8QjoQ5+i4Du
X-Gm-Gg: AfdE7cljAEvTHYYPeEjtZZsdss8HbfT3oCOAo3i+DsNDvdQ7Azfj18wHYGqlz+EKZcX
	DhEE3M+NaGQsfIjqQn1tGVpMcWzFyNSAxTDlhrjOj/s+PYOjtUnmATNBeJQJj1oatkrl3W8xK9E
	wYU/Cfy1kTey+MK5gCA4/benLQ/vGsX5aTbkEE4D6RH+NUmicL7HJEiUvxgM8/9a/QRxJlOZ0vN
	7dy8YzodpAZW13rMsjAORGO9Ljf1cMeEfFD+FQfX382xrAOenrmWunnUPKG+29xgOXQ7iM2POoB
	Xy0MFj4oYzZsZqfBqcoLCZlXiIxMOMCSQeZGqhW+oedHjDfWTdtcYxPZt33IaZTxygpp5w9ad6m
	2vpN3F25zwwWt8ahRsUpmo06UxyanFzvoCMDBDjNXqx1X0hfTSiubqzvhMSEQYwTRFnlQ4lXZJ0
	2++TXhkCDDmK45+2rqlLFgt1SYf6ReKpT6fCMkKaCeNHTwkVauoUmJI6NrTuj/J6uxqWFk6xiIq
	atiYp2VRSy8qkg=
X-Received: by 2002:a17:903:b86:b0:2c6:ab89:4ff1 with SMTP id d9443c01a7336-2c6bc0ab228mr8552345ad.12.1781649552968;
        Tue, 16 Jun 2026 15:39:12 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([203.192.239.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f2e535csm137073595ad.6.2026.06.16.15.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 15:39:12 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	xujiakai24@mails.ucas.ac.cn,
	Moksh Panicker <mokshpanicker.7@gmail.com>,
	syzbot+1cf303af03cf30b1275a@syzkaller.appspot.com
Subject: [PATCH v2] netdevsim: Fix deadlock in del_device_store() and nsim_bus_exit()
Date: Tue, 16 Jun 2026 22:39:04 +0000
Message-Id: <20260616223904.42509-1-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509092837.3432281-1-xujiakai24@mails.ucas.ac.cn>
References: <20260509092837.3432281-1-xujiakai24@mails.ucas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,linuxfoundation.org,mails.ucas.ac.cn,gmail.com,syzkaller.appspot.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-299983-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:skhan@linuxfoundation.org,m:xujiakai24@mails.ucas.ac.cn,m:mokshpanicker.7@gmail.com,m:syzbot+1cf303af03cf30b1275a@syzkaller.appspot.com,m:andrew@lunn.ch,m:mokshpanicker7@gmail.com,m:syzbot@syzkaller.appspot.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mokshpanicker7@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mokshpanicker7@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1cf303af03cf30b1275a];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,syzkaller.appspot.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6DDD695A07

del_device_store() holds nsim_bus_dev_list_lock while calling
nsim_bus_dev_del(), which calls device_unregister() which internally
acquires the device lock. Similarly, nsim_bus_exit() holds the same
lock while calling nsim_bus_dev_del(). If another thread already holds
the device lock and tries to acquire nsim_bus_dev_list_lock, a deadlock
occurs:

  INFO: task hung in nsim_bus_dev_del

Fix this by releasing nsim_bus_dev_list_lock before calling
nsim_bus_dev_del() in both locations, after the devices have already
been removed from the list with list_del().

A similar issue exists in new_device_store() which can be addressed
separately.

Reported-by: syzbot+1cf303af03cf30b1275a@syzkaller.appspot.com
Closes: https://syzkaller.appspot.com/bug?extid=1cf303af03cf30b1275a
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
 drivers/net/netdevsim/bus.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 41483e371..0f02ff8ad 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -241,11 +241,12 @@ del_device_store(const struct bus_type *bus, const char *buf, size_t count)
 		if (nsim_bus_dev->dev.id != id)
 			continue;
 		list_del(&nsim_bus_dev->list);
-		nsim_bus_dev_del(nsim_bus_dev);
 		err = 0;
 		break;
 	}
 	mutex_unlock(&nsim_bus_dev_list_lock);
+	if (!err)
+		nsim_bus_dev_del(nsim_bus_dev);
 	return !err ? count : err;
 }
 static BUS_ATTR_WO(del_device);
@@ -527,11 +528,11 @@ void nsim_bus_exit(void)
 		complete(&nsim_bus_devs_released);
 
 	mutex_lock(&nsim_bus_dev_list_lock);
-	list_for_each_entry_safe(nsim_bus_dev, tmp, &nsim_bus_dev_list, list) {
+	list_for_each_entry_safe(nsim_bus_dev, tmp, &nsim_bus_dev_list, list)
 		list_del(&nsim_bus_dev->list);
-		nsim_bus_dev_del(nsim_bus_dev);
-	}
 	mutex_unlock(&nsim_bus_dev_list_lock);
+	list_for_each_entry_safe(nsim_bus_dev, tmp, &nsim_bus_dev_list, list)
+		nsim_bus_dev_del(nsim_bus_dev);
 
 	wait_for_completion(&nsim_bus_devs_released);
 
-- 
2.34.1


