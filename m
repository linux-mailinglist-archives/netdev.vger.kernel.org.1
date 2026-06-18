Return-Path: <netdev+bounces-300457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SLOCGLX6M2pWKAYAu9opvQ
	(envelope-from <netdev+bounces-300457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 16:03:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D0E6A0C7E
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 16:03:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="V8/+z8To";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300457-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300457-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDEDC300999A
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115293FBB5F;
	Thu, 18 Jun 2026 14:02:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9881DF980
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 14:02:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791334; cv=none; b=jzBsES0RbSNyldSAKMx/Gnc663+x2h9mOoVzWtFVnLr5zSOZqMbsPjpStMmXTHbVFlAIBARs90SOP84rvWq+ve8vtx4z8Q1AUx3qrOdBrMZ1gaQarCESTLig/oZsNOGcDdmvOsikOhHqDOE5/7FP8pLWekd8lz6BWehdI/CI9u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791334; c=relaxed/simple;
	bh=qQxmqb9PnlMG1Fap8IEAL+WwML0IMJMAnH9L4tjYi4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YZFG27S11U1qP1B0m5YiBZazD+qEpGmco2blRJp3fgNzkieTh7th/sCaWtR53eX3G60YdpHKG+A8OpoKqSLxNUc+dlRenw+4D2fbttzPexKOyF2z7gFL+MZ4E9vVR68PhqBzzB/+YJZOxeJB0IW0hFWQwsbHcxi4ujK1AYfgomc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8/+z8To; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c6ab886da6so6328155ad.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 07:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781791332; x=1782396132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XS4R+w0KJN00IzEVRV2kKHMy345QBzFIS6oLc6bdXzg=;
        b=V8/+z8ToF29pmuT7D8XblJJc8hJrvZ9WJJK+ey/yYvqDlUgd/NS2HImR0umN3Wgx6U
         KZpG/OtOPe0fMrZ52udDRdJSJy2184IeD8ujHWLP+S+i0rmGf75uVzcDYol17osXkMmR
         BYV4zFzAzb16pCgw0bUmOBkQ5AyKMCIPKyq5679m942TTxc0Xw4RWkPQjCPCmILkhL6k
         I7UOsqNX15AiprXxljEMYUmWmKCbfH2cVsiNmKffI8sj/pPFg9W3LIp0pEW0DiAUiQme
         gzkqmcJiqAqn2xEmQAol0R3pgTLdJcherdjG5QQE7oTKlv74smZTw0cFb3jlJXdjJMac
         sKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781791332; x=1782396132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XS4R+w0KJN00IzEVRV2kKHMy345QBzFIS6oLc6bdXzg=;
        b=A87YPyX0nAVrSG9PXt9fpQwqh/uIrb5vg01mpiMNYD2K01GMcbG9ohMvbb1VHi2EBw
         /flX7+vz957D7ww/WjkgmX5jK2AqCEC5OQ5ZjTSafe2v3Ggy3OlnMOsUvt8VkBITOYR+
         3jBkhz3buZqifd/L13QNggm2PHOfvXTwI4dtSPdyIlRRxT56o/jrKMwoeD5/4MqqBqrP
         2YNAXEM6ZMtvkizetpGolaK9SMn4i0InQ4yAgcADTNLSYtOL21H9YGF3OSYP/TtE1xRj
         KRVKKMM1IzCwaFhDzYSJZL0rHVWOW/xcIo3NooTvUSarCsqmmq2PMK/dJ0u2kGypl0Wt
         nyxg==
X-Gm-Message-State: AOJu0Yyc/Z/IPa2kfbcug2vRD7CwTk0nqjUPXVnQBZOULbwOH45AR6zD
	+bQSIjQDhGrHTkNZS4dS5uxuZOWecDWuE7m7u31NsRR+kNmP7zvEGbI/oQPT2+wH
X-Gm-Gg: AfdE7cmDDtTCM6VQ6Lxbj4DgVBGTwEmtQbRtmx0ljL27i0R7VlEHAOtqsZMpbkhQQXZ
	ljilf9Nbt3mYmfGX+sAPI/mhDrZjL27mq5Xg/ac9CU0XG7/sEOgugEX7SFMqTjuIeaJUnFY9vlc
	IOXhSQSw9CsbjAvjOdATCpwp7YnShvxOohjA0XAeg6PfDDgUauNIYcfGWwW0qJuqhi0mpSiVBFS
	H5ju0eKHcz4QFeIB7NSk7XGPg3Bx6rXUNE3JYXbFqQGcygvLlMe2M1jNODGDB71y+9ye3smNUHb
	B+R9S6E3Dq5YvOI0MbZJHOM/3nsweHXIu1bOOfVOyqlAeddMo3AZigh25lmxqF3K8XPEHPH5ewj
	RDElG2g4g4XaUQwE3cPvJG8lCQmJm4OuUfvCBR5VTwNj47iJRsi0H/nyqJou4V8TJnQ0Vqx/QX4
	qDeSmk/qERHkpc66Sa7wZgiry4xpvdhjNczAQiiQ==
X-Received: by 2002:a17:903:384d:b0:2bf:2114:ecc2 with SMTP id d9443c01a7336-2c6bc27dfcamr107563505ad.35.1781791329953;
        Thu, 18 Jun 2026 07:02:09 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4cf:38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6f9aec764sm21525825ad.2.2026.06.18.07.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 07:02:08 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: realtek: fix memory leak in rtl8366rb_setup_led()
Date: Thu, 18 Jun 2026 22:01:55 +0800
Message-ID: <20260618140200.1888707-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,bang-olufsen.dk,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-300457-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:luizluca@gmail.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9D0E6A0C7E

led_classdev_register_ext() only reads init_data.devicename - it never
stores the pointer. However, the caller allocated devicename with
kasprintf() but never freed it, leaking the string memory.

Fix it with a stack buffer to avoid dynamic buffers completely.

Fixes: 32d617005475 ("net: dsa: realtek: add LED drivers for rtl8366rb")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/realtek/rtl8366rb-leds.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8366rb-leds.c b/drivers/net/dsa/realtek/rtl8366rb-leds.c
index 509ffd3f8db5..ba50d311cb15 100644
--- a/drivers/net/dsa/realtek/rtl8366rb-leds.c
+++ b/drivers/net/dsa/realtek/rtl8366rb-leds.c
@@ -89,6 +89,7 @@ static int rtl8366rb_setup_led(struct realtek_priv *priv, struct dsa_port *dp,
 	struct led_init_data init_data = { };
 	enum led_default_state state;
 	struct rtl8366rb_led *led;
+	char name[64];
 	u32 led_group;
 	int ret;
 
@@ -129,10 +130,9 @@ static int rtl8366rb_setup_led(struct realtek_priv *priv, struct dsa_port *dp,
 	init_data.fwnode = led_fwnode;
 	init_data.devname_mandatory = true;
 
-	init_data.devicename = kasprintf(GFP_KERNEL, "Realtek-%d:0%d:%d",
-					 dp->ds->index, dp->index, led_group);
-	if (!init_data.devicename)
-		return -ENOMEM;
+	snprintf(name, sizeof(name), "Realtek-%d:0%d:%d",
+		 dp->ds->index, dp->index, led_group);
+	init_data.devicename = name;
 
 	ret = devm_led_classdev_register_ext(priv->dev, &led->cdev, &init_data);
 	if (ret) {
-- 
2.53.0


