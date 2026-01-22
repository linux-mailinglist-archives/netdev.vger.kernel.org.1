Return-Path: <netdev+bounces-252520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL4nENl+cmmklQAAu9opvQ
	(envelope-from <netdev+bounces-252520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:47:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBA66D38E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 079583014844
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBE63876BB;
	Thu, 22 Jan 2026 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLGJQwiu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F64389440
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111160; cv=none; b=iqHKG3SzcDulBLUpo+y+zoty+712NzfPczUXnRgWT9jKvBaWGdwmWwM9jWyPsz1vAJDu57jM+ehLFlQzxf2GWPjqylLhtNqSPGAKhTA0g4Yl2Mu26Jvluhvj9sEeAnqoUvrj10Sohj1NqgUS2draV4Vt0nfhvYo6Fj4rhaF6MM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111160; c=relaxed/simple;
	bh=qLMIT8Ws33pYlSoHCrt/RVncgm7aYhmOwxAU9uVlwHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDqZNOVtYo0LJiAPRHJdodVRYKdigSn7+THEB9e7cYeFsYyxGhHbX7XqUE5IdIR0GS35tGtvYHoOZM/B0cYbuW3WmsFlpTFngMmmz0oPZy7VP4RHn9N7lvhW4vmv/hofrI1MnFIdaSRbCLK1TqA2w8iSe5Cxu+4JtDckhZS6Mg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLGJQwiu; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7f89d0b37f0so1318256b3a.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769111141; x=1769715941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7W4ETZqG8skHoTE538RFRAe6Lb7JM/auRjP6xeCdlU=;
        b=OLGJQwiuwjtqA4L1o4PqCprASVac7a7gwkFqZofJAxRy16JaHKOaPk8YoWvEVCuQuh
         HYqlyjvjDZmPc0GH3Rslb7DNCIKcjRtTy76cQg7vuQX9GG3svJDQTqyRRWuaJe/WVba4
         WWjK8Q6gc2M13p29OFjzVup+BH/E+TCcxXrw7MiuU8CEDjlU5mcYmXntbLc/xZyYXdRt
         zmCU1RqfdnEs02edkNdDjPYsgUpIpi7X+3sgSvJNdqE/t1r2+vUUDBcJv7Uak5eQAIOt
         fN9J0yYSMjw7V4lyocpseVdi/RTtr5TR+s05TM/ljrfKp9Ib+FMx1q/sNUd50WuNSxCZ
         qRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769111141; x=1769715941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h7W4ETZqG8skHoTE538RFRAe6Lb7JM/auRjP6xeCdlU=;
        b=sl9sNjM1OBZisY0y69bQy4x7vBGMoqSl3F13L+hq1/J1pt0Yoa/IIizqUKHXmyouDX
         YseXcS1+wwdXnAamOh3YqEz7Q5kph6eCRPRWorSMsKYMUcpJQjeRtPsNeCvRjT11KARg
         KlZqDXNzCc/3OLvmThu1PjBTOW40Cped2TINqgwc4zu9+4LEtESIPp0fLRfo9cq18oce
         /GSF35jmerkn+p6dRqT0cDpk2bcCZQv3YnRQAtHvFRN7jdmrewqY0Jh6dILnpUQf76K2
         07ha6OnYK7eub/eRH7dU/kHvEqlWdrvN9nOOdgw2SrfB9cmJNtC8jNV75w+MMX+RLFCE
         UlhQ==
X-Gm-Message-State: AOJu0YysQUTSnpEKsPsX724gdz+PvvWqxlflJUOsGb6TQjDgSO/YXsDD
	05mYDMUdl1+5G3i/TatSRVjchfvX4i3oEDqBcxCuKMV8nYzz72tRHPzmB7SL8g==
X-Gm-Gg: AZuq6aI6vHEdeTmzBwBD+d1emrs/+zity30HuorsjRMggXHFqZiK9cpMO9WxSAFXece
	5lUICp8US9y3cKyVHLfEZJV8xhYzr86EzK7I0ZvRGzvGHme/JJLNfkfQUg9DI4D7zU21m6T78/9
	mHOQFHxoRx9/5w3Mn0LLFNcTwsOqGPvLPRGA3MX2+Rr2dZD6Z5h1WJSvPkJXeIjfaP3Vml5E4Jz
	P/YsVr1J6g0LVIbG2uGYFyUC5HbQY5S8PdrShZEeqwxIaREOiLg4vJaWOdwI9rl0vN48D0QbcpN
	BWk9+kjKA3/CWamrKUQrRQOOAVIQcpD/t5OkVWwrlDZVjuJ9gJOZErZXunh7mgsHTjqJb4XhdCB
	A/CBAR16Vm9lZJG02QJfN14ar0SRMqCyIxstGD+Af0CRchvnTbSaKUAZ2bJyad0Aed9/KP2hbAo
	USlK7oIe9iRVgvLuY5SdbBqikXPYzk2+RZ0TeeCGf4GT1Oj5ugnx32Ww==
X-Received: by 2002:a05:6a20:12c3:b0:342:2a1b:870f with SMTP id adf61e73a8af0-38e7005bcbdmr433235637.20.1769111140956;
        Thu, 22 Jan 2026 11:45:40 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a425254sm110441a12.29.2026.01.22.11.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:45:40 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] net: dsa: tag_yt921x: fix priority support
Date: Fri, 23 Jan 2026 03:42:29 +0800
Message-ID: <20260122194233.2777550-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122194233.2777550-1-mmyangfl@gmail.com>
References: <20260122194233.2777550-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-252520-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AFBA66D38E
X-Rspamd-Action: no action

The packet priority is embedded in the rx tag. It defaults to 0, but
adding DCB support to the switch driver will break the tag driver by
setting it to non-zero.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/dsa/tag_yt921x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
index 6bbfd42dc5df..b93715a057c7 100644
--- a/net/dsa/tag_yt921x.c
+++ b/net/dsa/tag_yt921x.c
@@ -17,7 +17,8 @@
  *   2: Rx Port
  *     15b: Rx Port Valid
  *     14b-11b: Rx Port
- *     10b-0b: Cmd?
+ *     10b-8b: Priority
+ *     7b-0b: Cmd
  *   2: Tx Port(s)
  *     15b: Tx Port(s) Valid
  *     10b-0b: Tx Port(s) Mask
@@ -33,7 +34,8 @@
 
 #define YT921X_TAG_PORT_EN		BIT(15)
 #define YT921X_TAG_RX_PORT_M		GENMASK(14, 11)
-#define YT921X_TAG_RX_CMD_M		GENMASK(10, 0)
+#define YT921X_TAG_RX_PRIO_M		GENMASK(10, 8)
+#define YT921X_TAG_RX_CMD_M		GENMASK(7, 0)
 #define  YT921X_TAG_RX_CMD(x)			FIELD_PREP(YT921X_TAG_RX_CMD_M, (x))
 #define  YT921X_TAG_RX_CMD_FORWARDED		0x80
 #define  YT921X_TAG_RX_CMD_UNK_UCAST		0xb2
@@ -98,6 +100,8 @@ yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
 		return NULL;
 	}
 
+	skb->priority = FIELD_GET(YT921X_TAG_RX_PRIO_M, rx);
+
 	cmd = FIELD_GET(YT921X_TAG_RX_CMD_M, rx);
 	switch (cmd) {
 	case YT921X_TAG_RX_CMD_FORWARDED:
-- 
2.51.0


