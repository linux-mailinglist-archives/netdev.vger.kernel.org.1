Return-Path: <netdev+bounces-257276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AJXA7HXhGlo5gMAu9opvQ
	(envelope-from <netdev+bounces-257276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:47:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC58F6269
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F068300DF6B
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 17:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B9A302140;
	Thu,  5 Feb 2026 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeMkSvW9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8563301001
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313623; cv=none; b=mFqJQFQopROAhacD6nhTUYDYV2lS4046GeuGIWnh/ATfHfDHKLt1klnF/cp0NOgNUXNQqtzCcMuYd9S/oTUVy7LCswiTp2Tlrv+84iCjpSS/ZcDCu8UfuuxBe267Z2cDG/XC2ckjk6Hc1pH/qXRUz6m45kff0BoWrUDCxySqSjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313623; c=relaxed/simple;
	bh=jiUemKPKlmRMVN2/Lj60IZso0aiEzOeF5BiA1KJE6b0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xi9qpgy+YmAjNf52poAQDReBRKInnoX6zgq61w724gb6Kr6MEI37AobTmK968MXfmy7jkmbQZuJWcv0nmgB15ErMJ02mmLXTlgWU7xjTtpojUi1lF2BVGivm3ajUEslgNLxdc1ThkUCPnU/8C5Dtj/zVP7urHKIEiwimCd8sbXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeMkSvW9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81f5381d168so1386703b3a.2
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 09:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770313623; x=1770918423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EWxi5x9NQqhptmr8FMyD2h3Sur2tKgh7uRV919QBxv0=;
        b=IeMkSvW9u61F3jTO+5Dp9dJuNMcsorVhUyt/EpdX5NGbW9gYJ912doXkqrwxVNhab2
         3ihKgd0GB10vydyQjOJg9dSOu6Y9k3rzxknUHjjbfQBN6KTnMvRyeGuU8d8AQS8/qZ/M
         U8HWpAQUXGehq1RxhgLFwpyYs1eEbJb4UimckgOFaeeJs0zSrgMj6+6EFM8t75xY/gZS
         0+Wrqne4geXH9TZjbzFBeXuaO9Adqw/7VVFUlo4jFFzUDlh9jm5NWnqLAEa+q5jeTU21
         T0AEYsBVJdhgzDkuB9oM2QS48g6tUzsy1E8o+Y8sfJs8+BO03mLJ4ZsLnJwS09ffUz3M
         E5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770313623; x=1770918423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWxi5x9NQqhptmr8FMyD2h3Sur2tKgh7uRV919QBxv0=;
        b=FJ+gcrfBiudil6mAPMP9oY+ucYpoBUHp3kzx3vyV5MVeJbBXC1e0bwnWWjm+6PchQk
         pGrDvJGVXpntsI82RyxAQHxdicLw+HemQOxa5R+Nn/oTsu7NiOY1iAHGUHu1Zw0BkpmX
         F/Waz4iE+pKtBvXbtHNH6faA1GN7Skve7qApd9YG6F0ASiSC3cDfPk4ESkx5+s6bRhsz
         QTec8WvgAEk5dacmn6t52KU5MxWrowcsNgED+VricC3G6AWLt3E4+U/zZ+Jul/YG94YG
         MDdn1jdYLXINDNQa9M3D0uiaNaLkia59myZRH5ZThx+uYFhtlN9jDWQUkiyxqeDFQmEo
         HfGg==
X-Forwarded-Encrypted: i=1; AJvYcCXOVsX25W8Y/fL8LQYyapg7GonUSJnqh4U604Jv9DPL39XICOCDF6wFYWkX33vNvTioYnd+w84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn2Wj0ZPm8f40Z0xrxZTC84SY3VkwF+sic5a/YxQhCrUg2+KLW
	XEwryV71Sy7y6FvUNocDXel4ulEvwjzQTrP6Ti9spP2Da4tDdgs9ABMa
X-Gm-Gg: AZuq6aIFxkrucsUkj0m2RQTHDwZiGKwBN8tIHswdh0Y3oev2y13SKJjRPmspA75k1Hm
	V1vUnEy0tq9V2Xmodgx22WsWzOiY7w0LO/OwBo0ZBjP1sOGxduQI22TrYl8jGzo+K4nxZOqrYh6
	cslNTRUgg/N1ZIcAGsKPQsBF3BpKm2wWw/GXLu5FAvYMIKfcDcAdXtTWTsVJMaFr+EvAfTMYYEA
	iCQgfGUbP0Q1MRZkiLMKrC2WIF89XdTX93EjPxPpaPuC57OB7+VXQiMqYOQRvwCWleN2SCe6XJu
	qB3bYkkys+f5fbMPU54rXPz+fIwrTG0sy6Jhu8GeB15EdcB/gpEsG0bUrohBlVpWtRciHnHFD/2
	tpAYzNJ0kS461WVsXFzz06xi0JyRg358xtuZtj+TuHnPVnOzy33QhEIjbmISGqeSy+wiurhbTFr
	zDa0Dmx6nfPH0v
X-Received: by 2002:a05:6a20:d504:b0:38f:df47:87ae with SMTP id adf61e73a8af0-393ad4630damr136816637.79.1770313623221;
        Thu, 05 Feb 2026 09:47:03 -0800 (PST)
Received: from mint.. ([2401:4900:53f5:8722:5847:8ba8:5649:5c92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b1e3ca08sm96940a91.4.2026.02.05.09.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 09:47:02 -0800 (PST)
From: Dhyan K Prajapati <dhyan19022009@gmail.com>
X-Google-Original-From: Dhyan K Prajapati <dhyaan19022009@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	dhyaan19022009-hue <dhyaan19022009@gmail.com>
Subject: [PATCH v5 wireless] mac80211: fix NULL pointer dereference in monitor mode
Date: Thu,  5 Feb 2026 23:16:50 +0530
Message-ID: <20260205174650.4575-1-dhyaan19022009@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257276-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhyan19022009@gmail.com,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sipsolutions.net:email]
X-Rspamd-Queue-Id: ACC58F6269
X-Rspamd-Action: no action

From: dhyaan19022009-hue <dhyaan19022009@gmail.com>

Crash trace:
  RIP: iwlagn_bss_info_changed+0x19d/0x640 [iwldvm]
  Code: 49 8b 46 10 <8b> 10
  RAX: 0000000000000000 (NULL link->conf->bss)
wifi: mac80211: fix NULL pointer deref regression in link notify
Commit c57e5b974514 ("wifi: mac80211: fix WARN_ON for monitor mode on
some devices") reorganized link change notifications. This caused a
regression for hardware using IEEE80211_HW_WANT_MONITOR_VIF. In monitor
mode, link->conf->bss is uninitialized, but current logic allows these
notifications to reach driver callbacks, causing a deterministic NULL
dereference in drivers like iwldvm. Fix this by validating the BSS
context before driver notification.
Device: Intel Centrino Advanced-n 6205
Fixes: c57e5b974514 ("wifi: mac80211: fix WARN_ON for monitor mode on some devices")
Cc: stable@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Dhyan K Prajapati <dhyaan19022009@gmail.com>
---
 net/mac80211/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index b05e313c7..190222c26 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -416,6 +416,8 @@ void ieee80211_link_info_change_notify(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_MONITOR:
 		if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
 			return;
+		if (!link->conf->bss)
+			return;
 		break;
 	default:
 		break;
-- 
2.43.0


