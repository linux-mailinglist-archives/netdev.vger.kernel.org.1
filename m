Return-Path: <netdev+bounces-275084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFwFO+nOz2m50gYAu9opvQ
	(envelope-from <netdev+bounces-275084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:30:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 533CA3953FB
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 16:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C2753075AAA
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECAD15665C;
	Fri,  3 Apr 2026 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiBgfYyP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC43C455E
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226242; cv=none; b=ZacxUckPZSP4X2ywM4BlHfMOXrdQIA+kKnktrRPiVq25OKn85C9L22M0jL2bg3oSTxdVMX+cZSn7Vwr3qJbhn9O0+1LgTVvtiANf5gS/058S+iyvtoNoL5KM5NU5jIsYwXFft8llhReUpZnYEWdW/WlL24J1DH7O9zUy3orZw40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226242; c=relaxed/simple;
	bh=/5ADB+SyJm/Q/ov4c/nKO0Wixb7suSsqOhoC0Y4PDp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DddyZfjZ/7vpquhooP1sRr9l79LvPx6jj27CgF3UjM0F180SBfQPdOhqAqv/ZF0d+nod1PAIIdgbFkvfpYhVCVgzZoHqamOFjycFkhIhvJmhN+jU1cQBxHMqBbtp8c+rFiYBeD3As9pkL/Yio1r9caKYisIkONC1YYOoxrpVzJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiBgfYyP; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cfc2d1fdbfso166790785a.3
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775226238; x=1775831038; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9jPGWry0QIQhKXZ0JMS+na4WMskAsclNVS8TD3aTHw=;
        b=AiBgfYyPyyc1LEWFwzn6gkAktvSM7AZGctZhIFiXOjFG9HMdjNcP6q1LMsJomrCSi/
         jQ/ULMCEb3v3N8gCCP8yENSLKElDjad3HdnWfYXnod5Dv/lTVErc3VbU8JKGfS0ENPN8
         P6J7yZKrvw7ukd0Rz23/yRpwPfsrz8kAbVNC90s/cdX74XIKs/L6yKTTRvHLd7fHopnC
         ipbB7FVyUhnywlslHZ36LBzMNAxdALhNgP6Bu76W4qNkv5SgN2pLgO0pscPvIoLBMtsK
         APJJzCjiwS+2M3RWnfADdMjxugVG5jJblOxM74oemsxXw9dTo6RRMGZpS27OSS3Tfhp/
         +Z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775226238; x=1775831038;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9jPGWry0QIQhKXZ0JMS+na4WMskAsclNVS8TD3aTHw=;
        b=V7yD74d4uzJt0VF5PpaDH5Xc5EhOjYA3QP8FNJSEs1YhjImGAz7Nf+xMIb5H+J/9TA
         9y71+s6JSsLwrQE/nMAznMLCXkegXGnNNiZHdvBzgsTlOIiGQX2EEYq8zZptDuzyWziw
         Viu+55tdI8yrtFjEHqJflLJwOtvZF4uKNbL1gXRdq0R00cRmSePESbmc5eVB1JA4TUFM
         Yasdc9o4B9rbqmZ0FmCRFFVFp3zx5lVXWVgdcDWSVa/i/NQcsmXyef3D+XwdxE0Znx/A
         YBS025eATUod66rAa2jy67ViCHcO4AqDxtvpD2tDy6b0E7ldEaKN6TyjVkPNMRcuYSIe
         W24Q==
X-Gm-Message-State: AOJu0YxHDxOdWA7lk1UZuU0u28hCbWFHIKXUkqwHcD/7BQTqpAwy3Lnc
	0EXAvN1AVDIrkrAHQeNQcd/MJLcmy0R0thXg/MKXHq+14OmlDlySwzHR
X-Gm-Gg: ATEYQzy2IKSVEEDabb7/j/lIJWBVEjie3sUWgfg7zjoZQbeqi7UAgFU+5LwIOwVRBmt
	6c9joXPwwEU6lw1TMFFBoPB1rbFyAXzPsP1c+2ZSn/DzjsAv5tuDRj4xelCxwYFN3+aidVowHZg
	R46VFHnC5z5z+/BjtxilYbtp17xU4FgJ6fDyNVC1It9iHZtouFOc8B2uhXaRnk4x7S0S/TA9ztk
	kY1BCoy0ugy1l7tffV5KDtEWoVE/faXJM7ci+alPDd2DXy9tkhu33Kmy7Ff/Kw/57Vm+vLV/KSH
	mSKLbK+iXVe2gxhaYFd/NmpVkMGfDYR7+N0bFMYEWh6QLWyrl1+m7K3pjiHtlXaKTo8iskXGper
	9JWanlU5ydXtv0xeYtN7qT5DCkT6y8mr9bJmgkDLIzVfPZeovmEK3bdKelfJJR+Ezv8w9NKrsvF
	LyTu2q3Y9c2Pv4pG3Ik6Co8Aa6YJPseV8Z
X-Received: by 2002:a05:620a:254d:b0:8cf:e208:eea7 with SMTP id af79cd13be357-8d4184d4c63mr435384485a.9.1775226237942;
        Fri, 03 Apr 2026 07:23:57 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a806b2b2sm450670985a.25.2026.04.03.07.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:23:57 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Fri, 03 Apr 2026 22:23:39 +0800
Subject: [PATCH net-next] net: macb: Use netif_napi_add_tx() instead of
 netif_napi_add() for TX NAPI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-macb-napi-tx-v1-1-08126a60c65e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGrNz2kC/yWMwQrCMBAFf6W8swuxaaz4K+IhTVZdwbUkUQKl/
 26qx2GYWZA5CWecugWJP5LlpQ32uw7h7vXGJLExetMfzGAsPX2YSP0sVCqN0fmjHV100aIlc+K
 r1N/uDOVCyrXg8jf5PT04lO2Gdf0ChR+B03oAAAA=
X-Change-ID: 20260403-macb-napi-tx-7d5a8375d5d3
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275084-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 533CA3953FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The TX NAPI should be registered via netif_napi_add_tx() to avoid
unnecessarily polluting the napi_hash table.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 7f061d7c95af9aec37f73d3529a8cb276b263452..6a386e5632ac48a82414c370d58ae99f40fc3727 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4770,7 +4770,7 @@ static int macb_init_dflt(struct platform_device *pdev)
 		queue->bp = bp;
 		spin_lock_init(&queue->tx_ptr_lock);
 		netif_napi_add(dev, &queue->napi_rx, macb_rx_poll);
-		netif_napi_add(dev, &queue->napi_tx, macb_tx_poll);
+		netif_napi_add_tx(dev, &queue->napi_tx, macb_tx_poll);
 		if (hw_q) {
 			queue->ISR  = GEM_ISR(hw_q - 1);
 			queue->IER  = GEM_IER(hw_q - 1);

---
base-commit: cc13002a9f984d37906e9476f3e532a8cdd126f5
change-id: 20260403-macb-napi-tx-7d5a8375d5d3

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


