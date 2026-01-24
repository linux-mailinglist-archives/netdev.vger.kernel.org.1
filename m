Return-Path: <netdev+bounces-253112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBn8HvA5dWmUCQEAu9opvQ
	(envelope-from <netdev+bounces-253112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 22:30:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A9C7F0F7
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 22:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E9D93002B76
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 21:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605701C84DC;
	Sat, 24 Jan 2026 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4KY2Zfo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA924466B
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769290220; cv=none; b=VEiGfXdJmMNSduCSPfYIlmE9oVzDEoow+oWL6sDiTJQb4F8NXSAixFVLb1gkROyDEZyancDz/5eR0bM8cFQNE+2P/QjHhDm/HM6jjMzRn7hIIU6M2YX+OnkQYtBxFx/+ma2vRWMGY112NLAzYR+a+ANCBkKKjyV3b6eZ1qxIg+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769290220; c=relaxed/simple;
	bh=J1PTT2t7uCJqoR/WF7LXcNhsf6Aeg2SJnyAfEHOE/Do=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=a+y3DLH4/VXHtntncU4LRYCc8XDwSXDF6Vb2y/Dtd8CIDBlL3pgAADHGN+ugAh9CR5lodTQYoMcX+67GgQkBvKoBliNqBAryrMyyaoIFXWlD4sgxPvZPworJq0QwK7ZQkM70phRGGTZlKGEzgVOIn9tvjVDnrVpyid8Dp5ydJ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4KY2Zfo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so24576515e9.0
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 13:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769290217; x=1769895017; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ml6zYZXWK8efK8g4w4OWzfIG+PiT8Lt3rWlShHHULUg=;
        b=F4KY2Zfobxuf0R3QMb7RR/8bm8qDNZiR4LDGr3OQ8dRzgZUg8B8SOk34nqeuA8stV2
         48cu4Wna+HMF43AwSm8OXBcupwG48nqIdRDLGajH51rXaaNEYEfNmUaegQ01dIElE2zZ
         LKHyx+y/QZ9yKytlff9Xb/X+S1ZwcekBCYSApvoF2t8/wdBSeEa8CJDzP/KEtdy9MNFk
         LimgtqUcI4fr65UFgOZXb70iuCfVb1u72UjZmSQODp3CNKsfo5c6flQAGTdBt+TIqN2d
         pCqWZzKRGIvcJ9lxfNaKV9K/0Ayi88ObxU/W8EHAZng/KQNDFL6hukvFZgVOeMKdAxMk
         Phkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769290217; x=1769895017;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ml6zYZXWK8efK8g4w4OWzfIG+PiT8Lt3rWlShHHULUg=;
        b=wrNKmFHI6Aubacou474pZO3eZih+wlw5T+wcENq33Afm+GdVgCv7PTfdiY8RIplSW/
         LkArJzayD7W9BziYp5ClBu7F9GHlNPMbt8pukwgS52350fapYbvtjCoTUFMCnqqwDHaG
         kiigXIrRnq+mREdkoK3/uQbJbZ7HQGwG1h2rKfklitZox/mVrGiyKR+Yml0+1kPI1qYZ
         qhXBr3OL1nB9BiXjjI9c0M5DucdOjrLjbxF5HkUSXbVeduerYnF3jJeh1QiGypYIoqlw
         ltwYhIFLDMrcnzE87r/gzn4jqIV9cKYvy8/rOULGSyfGNBf2RGJPepe7sHNBwm+UnR/1
         PTkw==
X-Gm-Message-State: AOJu0YzsiG8gZ8zDiXx03ccQ2yCpEiAvMLXRi7qyODDHlGja+hbYHgOs
	OvQJgLlBCXsuhviwlMJGOtramknEDgQxZaN7SveVtLWIrh39IijYoFDT
X-Gm-Gg: AZuq6aJsW05hAl2jxGb7F43g3bir38abXol3t0Zj5bin8o8bLZ4ggro9kefgGY/1gAg
	KPZTndMWat3g6c9mUBZl1Wk7ejqB4eYj13N8Q2rrKxkG5nGO7rKBzNnlG12lJ5+640V7Yw5oBwi
	5TxBt6t3aiZE1xt8VNadZbbrH5PNDmxKcZtHJfkC0C16IW60Svju89VGJhtzEgdiyk2J37eK6zc
	3k1tx8BW+NCHPiPmsU6vFsdTdoQk4nqxebSfnKB0+9BEctXk+tM5gTIZzN4bRqZn1EhgxOn0tsT
	sKECaAJ1lj1hVW087LGb08iHe/n5ksK3VbHSedvO6v0i1m1tHdMTk8dd9cCkURQkNV/5keVwIiS
	xBQmLHSWKzcis1z5LDxTsTChCtmzOzpHCUQzOLfOjZ/4kaYJ2aH3HK+pdq4KYjgovv8Xc+sgERr
	q3HXiG9vtbY+qgKf2oD4mJvv+c8xno0XXsblJdxwkspDj6e7ZoRePitCQq7TOz4Mkf47uZ0w+Wc
	BBpguH4mIwjuK3U2kxYOSt8xRcyPOrHMKE5oJFPIXyna08ScVy0PA==
X-Received: by 2002:a05:600c:6215:b0:477:5897:a0c4 with SMTP id 5b1f17b1804b1-4804c94156emr125719525e9.4.1769290216882;
        Sat, 24 Jan 2026 13:30:16 -0800 (PST)
Received: from ?IPV6:2003:ea:8f2c:b000:9cd8:dac0:8b53:119f? (p200300ea8f2cb0009cd8dac08b53119f.dip0.t-ipconnect.de. [2003:ea:8f2c:b000:9cd8:dac0:8b53:119f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48047028928sm326831725e9.2.2026.01.24.13.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 13:30:16 -0800 (PST)
Message-ID: <d560ec66-848e-4290-818a-ce28f39de493@gmail.com>
Date: Sat, 24 Jan 2026 22:30:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: remove optional size argument in calls to
 strscpy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253112-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6A9C7F0F7
X-Rspamd-Action: no action

Minor simplification of the code by removing the optional size argument.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_firmware.c | 2 +-
 drivers/net/ethernet/realtek/r8169_main.c     | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_firmware.c b/drivers/net/ethernet/realtek/r8169_firmware.c
index bf055078a85..6dff3d94793 100644
--- a/drivers/net/ethernet/realtek/r8169_firmware.c
+++ b/drivers/net/ethernet/realtek/r8169_firmware.c
@@ -68,7 +68,7 @@ static bool rtl_fw_format_ok(struct rtl_fw *rtl_fw)
 		if (size > (fw->size - start) / FW_OPCODE_SIZE)
 			return false;
 
-		strscpy(rtl_fw->version, fw_info->version, RTL_VER_SIZE);
+		strscpy(rtl_fw->version, fw_info->version);
 
 		pa->code = (__le32 *)(fw->data + start);
 		pa->size = size;
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index de5999cfadf..3075391853f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1771,12 +1771,11 @@ static void rtl8169_get_drvinfo(struct net_device *dev,
 	struct rtl8169_private *tp = netdev_priv(dev);
 	struct rtl_fw *rtl_fw = tp->rtl_fw;
 
-	strscpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
-	strscpy(info->bus_info, pci_name(tp->pci_dev), sizeof(info->bus_info));
+	strscpy(info->driver, KBUILD_MODNAME);
+	strscpy(info->bus_info, pci_name(tp->pci_dev));
 	BUILD_BUG_ON(sizeof(info->fw_version) < sizeof(rtl_fw->version));
 	if (rtl_fw)
-		strscpy(info->fw_version, rtl_fw->version,
-			sizeof(info->fw_version));
+		strscpy(info->fw_version, rtl_fw->version);
 }
 
 static int rtl8169_get_regs_len(struct net_device *dev)
-- 
2.52.0


