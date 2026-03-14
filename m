Return-Path: <netdev+bounces-267651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFY9ODaptGn+rgAAu9opvQ
	(envelope-from <netdev+bounces-267651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:17:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5BD28AE0F
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FDF5300DCF9
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9F713B584;
	Sat, 14 Mar 2026 00:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXH9nnJA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D27D4A35
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773447477; cv=none; b=kDs4uFISL5kp+6QHgsHmdMHomTc0s07Dj4FT3AT2pbm31U6EMQsoQZFHyyvjWWRu8ouKeUYixVJ/kB5hAGT8mptwnqs0M1pQdUzcOwMSyAf+ULb2xN4ejUf2FWTxctHqZvyD/RFzZIKhFMCbzeBmNa1ghDCbj5BYuU7Cjc4F9xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773447477; c=relaxed/simple;
	bh=quQ2b8S01YScE2o8Nv0HiEqF8yOiNwJckB8pdpJRrys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djeNpMrGMgc1b+VQi/3hOHdHE+x5AsfxGvEK2ECHX3CvrdJ1MJ9zIUHzOJM9kfZalWQzYXmvbLzx/+zliNnTlTms4XcHU7F/5m+d34edO0tIe27NhzWSk0zbRG9pWtTLH6TxNThYFNoDGarBpzi/66j3CXl93x3H2BtMSrHSshA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXH9nnJA; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56a9a7e762bso2565224e0c.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773447475; x=1774052275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OwkP6WWMLpt4ev+jMDNRA83YAMF+ug+nhsF73l1V2E=;
        b=UXH9nnJAIs39WmtPkyCtHbVNIzBF7bNZI2HIQWThQPPjjjNonmLc9d4DQIUQ5MnBQQ
         GsMH7XzYcL5xp+HJ0cIYzbKU/D42Ydwe0/5IAvZ3iDO7clBOv5IEbsXEkMJWdxRNj3df
         kGzLIXknn+23ozQ/a2zZsMlJImSiJwF8tvWnKjmFd5PXdNIaVOjXbHrAppQUuhSehZB4
         dDdu8W5Cqyq5OJcAei0PWVeCj+cmUdH1IgRKNmj04wemztbKf3FpH76tuyDHAnE8E3g0
         RQQ2Q9vWjmZHsQIwnraI5PlRGZy3ktJVd/biegJbkUlcW5Gvp9KjI2LiHbOQS4ZnwXH3
         dXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773447475; x=1774052275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+OwkP6WWMLpt4ev+jMDNRA83YAMF+ug+nhsF73l1V2E=;
        b=tTz7nUYcQVozunu0JUvJwsIecFih9Ha92gNK1LvTLVei+11/KTr2QMONsdWL9+1RHM
         ScSNUMsPGqUlPb/nMqtr8Ep0XBBr50EBx6MwG8JqwAyR9XN91T9UH/iMkjmbkcjSzSOh
         mNqtnoaJL72euwmcGmI6YT7/bWGX6zU+8/DRwd4XKbDdsp9+aqt1o+kexunWCmVFp6OP
         s/v8w6VLt01vNQ2EmTqfqnAw3XRXmPTjNLTIXTHJ8s+LIN/wjux9WkYUKUQJiEBr+0Wf
         TvLzS4Y6oaBULxrQO9KGjAlY4QzA0mSCVx7KH3HylNbKU76qYZb1wKay70eFxQI1nfMB
         6a/A==
X-Gm-Message-State: AOJu0Yx0GY2ZwljjnOMOoaVDLoPycz1m8Ob4LQRuXDbcdG57kP6WSJEW
	rlSpTHj9k/RK05ncnFpMWuDTsvQtMnOX1gV1KRfjCTKCiMwMATQqHM7f
X-Gm-Gg: ATEYQzzDi+46Y4QyZwTyjTeDRVy5OVcmOYufha6ALj286BpbOv3KTYUi29mP4mpVDR6
	QUIoz5GyTMZONzZyoj47dgPYNN6RF9sD2NWpFctZ+2YXLQh71sGtdNMfNXcciIACzi0MfzgzpPc
	hMU/xUKK6xlaPVVr2kDGmXH8xcQO5cZV1f+GL4WQaR4xVZCGgH3BaeeO6O7mBtbgy6UELmbrPsH
	Nf4kr5lg0Pbzjl1zCVpatgWhD/xt4LI2R3dNY+DO0fiOeY02jedNLkuZoG5KFgC7Q1QaHl7Bm69
	7gISOl62D1N7/lSDC0edOINbHnvHgGbyWUfQ8DaH4ZsiokF6qTw6dvC+ylLgZDbqWQGrl/nCXbZ
	f456hxbjGv/hd7PhM/gHU9lIc/TBF0sPk8H7xo91WD4j+zDO9Xx2TrcmMibZWWSHjwDbFnaAMy2
	sCHVTAWW0HpeebqP+gDton
X-Received: by 2002:a05:6122:8b01:b0:56b:5979:34c8 with SMTP id 71dfb90a1353d-56b62a3e65dmr2145795e0c.14.1773447474896;
        Fri, 13 Mar 2026 17:17:54 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:5f::])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b4634177esm4819415e0c.6.2026.03.13.17.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 17:17:54 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	alexander.duyck@gmail.com
Subject: [PATCH ethtool-next 2/2] ethtool: Update doc for tunable
Date: Fri, 13 Mar 2026 17:17:37 -0700
Message-ID: <20260314001737.494082-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260314001737.494082-1-mohsin.bashr@gmail.com>
References: <20260314001737.494082-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267651-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[8.in:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC5BD28AE0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ETHTOOL_PFC_PREVENTION_TOUT enables the configuration of timeout value
for PFC storm prevention. This can also be used to configure storm
detection timeout for global pause settings. In fact some existing
drivers are already using it for the said purpose.
Update the documentation to formalizes the use of this knob to
configure timeout value for pause storm prevention mechanism

Kernel commit: 817de93c348a ("net: ethtool: Update doc for tunable")

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 ethtool.8.in         | 19 +++++++++++++++++--
 uapi/linux/ethtool.h |  2 +-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index e10a252..daac5a2 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -1550,7 +1550,13 @@ Get the current tx copybreak value in bytes.
 Get the current tx copybreak buffer size in bytes.
 .TP
 .B pfc\-prevention\-tout
-Get the current pfc prevention timeout value in msecs.
+Get the PFC storm prevention timeout value in milliseconds.
+This timeout value applies to both PFC (Priority Flow Control) and standard
+link-level pause storms (IEEE 802.3x). A pause storm occurs when a device
+continously sends TX pause frames to the switch, resulting in persistent
+backpressure. When enabled, if the NIC detects that pause assertion has
+exceeded the configured timeout, the device takes protective action (stops
+sending pause frames) to prevent a complete traffic stall.
 .RE
 .TP
 .B \-\-set\-tunable
@@ -1567,7 +1573,16 @@ Set the tx copybreak value in bytes.
 Set the tx copybreak buffer size in bytes.
 .TP
 .BI pfc\-prevention\-tout \ N
-Set pfc prevention timeout in msecs. Value of 0 means disable and 65535 means auto.
+Set the PFC storm prevention timeout in milliseconds. The range of valid
+values is device specific. Special values:
+.RS 4
+.TP
+.B 0
+Disable storm prevention.
+.TP
+.B 65535
+Use device-local default timeout (auto).
+.RE
 .RE
 .TP
 .B \-\-reset
diff --git a/uapi/linux/ethtool.h b/uapi/linux/ethtool.h
index 7a13192..a5d7d24 100644
--- a/uapi/linux/ethtool.h
+++ b/uapi/linux/ethtool.h
@@ -225,7 +225,7 @@ enum tunable_id {
 	ETHTOOL_ID_UNSPEC,
 	ETHTOOL_RX_COPYBREAK,
 	ETHTOOL_TX_COPYBREAK,
-	ETHTOOL_PFC_PREVENTION_TOUT, /* timeout in msecs */
+	ETHTOOL_PFC_PREVENTION_TOUT, /* both pause and pfc, see man ethtool */
 	ETHTOOL_TX_COPYBREAK_BUF_SIZE,
 	/*
 	 * Add your fresh new tunable attribute above and remember to update
-- 
2.52.0


