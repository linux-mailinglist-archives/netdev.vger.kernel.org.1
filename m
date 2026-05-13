Return-Path: <netdev+bounces-287625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iO17HQ6NBGqvLQIAu9opvQ
	(envelope-from <netdev+bounces-287625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:39:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 183515353F8
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9FB4306BC8C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621F5436358;
	Wed, 13 May 2026 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVBAHBb8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DD63101A6
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682752; cv=none; b=C5/GI/K6ekrndVOb2Fk5Lzuk27YBBYOlQHNEaO8PNaZX13TBsMmkNR/SZbEkXNIaoh8MFNou8Lw4TNIinxDzDz4U6x7dOUYw4kBJvabtKzr6Uz3CVixw40erebZajZ0BTDdq4UKL+taIdDzfnJOrN/AnzVLkiTRIHKwT9nv/aQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682752; c=relaxed/simple;
	bh=1+vAKBVtXcaNthQ3BbrUqQGvvY0RZp5zXAGRoxCke2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YCSVfwIwIJMvYws5oEup8Z663Wnrbb88niUTAMb/yc11zOoh48eUWi9wGnOqQS4IhFW6LqKtT6bQtIVmycnYUAEEX+VzT7SIMlAWeE9n3Ot7MooMd2e0utHKFyrn8kPTTJBuvla79A3EeULsU9xQPmNTIHu8+oGSD1AOXOCoO3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVBAHBb8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-366be8040a9so2684563a91.3
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778682750; x=1779287550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+2Yo6pvV+6RRiXip16OBoqYDsQD7nOYrmB1z5LJLuDw=;
        b=JVBAHBb8FTBV0GvsMcSVrZzA4/6mJQeP+kQyb1VkTgtEJpUVwPuvTcBiWK7OunCPnw
         Z7amHCr1tv5gzWnld87SHBjH8ZWs+fIfp2m4PjLAPi+u1jyxFW16F+qGAgnOz+am+96R
         MTDLZbTNh0LfoP+6iW6G2D41pbj5J5Ga3tYa+sdq2Z9Hlz/ZA7YTOcO7uVh46z8KiQHN
         qLslJ41xWmiaxcDY8vCGWng6/zh8VAPu543kJByRVpDyFeYr6M1bLQ/x4PDQVmIxTkUX
         8wcNfKM5YNnlbktx9lNWxru9aPCsrsWvbsgHizY+u5C1hFxPa0+ZiXBQlTyqpACFgRXI
         jwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778682750; x=1779287550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2Yo6pvV+6RRiXip16OBoqYDsQD7nOYrmB1z5LJLuDw=;
        b=lMrsueWkahYKq3FS3nA/jJdc1qmnlgVys2/640LYdBQKs9Qzs2tqMslpNc2Fdr9fH9
         2zlZCzRe0LdmKxipsyq2+UIry5umjj9lHVRRpnpFQeyyD5ukzYnn4mxltoC+PMKFQqGs
         E6ElzbL2XjJOSNJNs90iFI8yL6gwXQkbGozoFB4Ib5dTUHba6mYPTGP6t5XWjLLtKp6V
         +pHw0Igtz5if0bXWqEznJSCQWlQm/78BUXQWZ5WwIK0WYiQ9BAvsd+VFCrGI1+f4KW2J
         A1vaLfkaJ6t8Y3mJOtHydwarj9WBcwB2R5/0LCGCBw0Oeo2XbhzwvgHsbbHkFCRS/BMm
         4t7w==
X-Gm-Message-State: AOJu0YypgYN6Vy5ZklFxs8I39r6AQo8BJEPc03H1MVqjc2e7n+HL3R0n
	bdaIHD+xM0XrFCql/tVOLzowMc6foZ4dj92TIpz/WGjyuVAGI2+qjF0jt549DqN2
X-Gm-Gg: Acq92OEFF6V6E0XKDtuPvIxI54Ft0kgOPsYm1uRD26Ly1kb2NI/1gkY7mTHo+6iB7vF
	Rdvq/JN7SvQTCY7PPeTijBKVig0sF0uTEFEYnDU+0x7n97jqCwO7R8rucgf6KaHkMqGvZ83cf9g
	S6YRnjcjhnS1etr3rU5jgg68aGRwnS7jpa8hlgA7aShjiZZQDLKeBQNTw0ejDeB2RzsZv5FhmKT
	d7P4ziav6biYxGCIYBNfTWieLVTlG0MGGpVuAiwCnge3lZaogRQPPu5NFBGrqGk9m0bvxXQP7QI
	qJCy31/kWzt+wNlHZQNkLNirvc2LD5YIK1387pcPG+ozjijCSeW1me2LBtqOpeURGJFj93v/hwT
	Dw/AUpDuXn7QR0ElB58LgCA3BeZkwiJMUMFkV4A7Fxzj57FuprA5aIuOEeMr/j0YZRilSNuCEVx
	sO2sW5KkjHKIxxQa06FIMXtXRVyjMb2yK0UWppyziKIord3k1j
X-Received: by 2002:a17:90b:1f8b:b0:364:a497:dc45 with SMTP id 98e67ed59e1d1-368f2e5218bmr4338658a91.0.1778682750092;
        Wed, 13 May 2026 07:32:30 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::1d0:c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ee32728fsm4167184a91.10.2026.05.13.07.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 07:32:29 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: netlink: warn on overwriting extack message
Date: Wed, 13 May 2026 22:32:16 +0800
Message-ID: <20260513143219.3327287-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 183515353F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-287625-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When NL_SET_ERR_MSG is called more than once on the same extack, the
existing message is silently overwritten. This is hard to detect via
static analysis. Emit a rate-limited warning so these cases become
visible.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/linux/netlink.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index 882e9c1b6c1d..f6538304745f 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -90,6 +90,13 @@ struct netlink_ext_ack {
 	char _msg_buf[NETLINK_MAX_FMTMSG_LEN];
 };
 
+#define __NL_SET_MSG(__extack, __msg) do {			\
+	if (__extack->_msg)					\
+		net_warn_ratelimited("overriding extack: %s",	\
+				     __extack->_msg);		\
+	__extack->_msg = __msg;					\
+} while (0)
+
 /* Always use this macro, this allows later putting the
  * message into a separate section or such for things
  * like translation or listing all possible messages.
@@ -102,7 +109,7 @@ struct netlink_ext_ack {
 	do_trace_netlink_extack(__msg);			\
 							\
 	if (__extack)					\
-		__extack->_msg = __msg;			\
+		__NL_SET_MSG(__extack, __msg);		\
 } while (0)
 
 /* We splice fmt with %s at each end even in the snprintf so that both calls
@@ -121,7 +128,7 @@ struct netlink_ext_ack {
 									       \
 	do_trace_netlink_extack(__extack->_msg_buf);			       \
 									       \
-	__extack->_msg = __extack->_msg_buf;				       \
+	__NL_SET_MSG(__extack, __extack->_msg_buf);			       \
 } while (0)
 
 #define NL_SET_ERR_MSG_MOD(extack, msg)			\
@@ -156,7 +163,7 @@ struct netlink_ext_ack {
 	do_trace_netlink_extack(__msg);				\
 								\
 	if (__extack) {						\
-		__extack->_msg = __msg;				\
+		__NL_SET_MSG(__extack, __msg);			\
 		__extack->bad_attr = (attr);			\
 		__extack->policy = (pol);			\
 	}							\
@@ -176,7 +183,7 @@ struct netlink_ext_ack {
 										\
 	do_trace_netlink_extack(__extack->_msg_buf);				\
 										\
-	__extack->_msg = __extack->_msg_buf;					\
+	__NL_SET_MSG(__extack, __extack->_msg_buf);				\
 	__extack->bad_attr = (attr);						\
 	__extack->policy = (pol);						\
 } while (0)
-- 
2.53.0


