Return-Path: <netdev+bounces-277730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPF3FIv42mnH7ggAu9opvQ
	(envelope-from <netdev+bounces-277730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 03:42:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A36443E2676
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 03:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05849300EF9F
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 01:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE732C0F69;
	Sun, 12 Apr 2026 01:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSStc1H2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB513D994
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775958152; cv=none; b=grG3f1n8wKs0J4WcAQiRwJhQ/yk35wDiauFmxiU9si4spPMJQ/bJVUA21jUqXziHxREiNXkjcpZABRf1o579Lk7OsFbJvoG+uT1EiDIZzRYQicf94b6Iwi1EpKwBEPeKwUtvYlAkL0NVbif1Tpza7Qlh8d84rZ3UDpHZoRyVdco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775958152; c=relaxed/simple;
	bh=xNnLgRiPvkD3GsmTYquWgy/dOF3XFi0LNntWColAaQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YIkHQrrgHbvfh9D/pi3vWgMfJaPYm++TNpYNHH4x8LZfPydsHdsU6r9qB3X7qpiCTr1HmDvFxgfsIrDF1LxgxcS5ALodGQFNY40WZvXAEQ7yRGKgRmJiDV6JPgIXt1IjejQ1DtYKMe0X4RrSkPcR/gEWZrCpe32sM5nOAzB44Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSStc1H2; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79a2ee65171so33763497b3.2
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 18:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775958149; x=1776562949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j0Pg4WAlFuYg9PEeCLBIArMJ2oXuf6TAJHZzZ95skOE=;
        b=PSStc1H2H/839Yh3Ky5lDIK/mB4mSZbt6mG3n26LgP1hSkbnBoWyTaYXiB5+3A+r5u
         JiG8ivknVsQoGbazJPELYQQD9LNsC1Fl3kGWUygll42zZZ4S9J4mov2xvxiV6wWOsK4L
         QDoHJVZ5GtfErHbw+kmEsb//vYyOI2rkEqtIWK4CRLqHYzGbOI4XD+vTA8xAiuDGpRPx
         iCkaDcHj2doZNEqXu74Tb3n3KLWg7vjBkE1HaGXKSt+7UvnNYmcGsSYfORfU5/uIpk5E
         Lm63b1RcqNC63wHBY9rg7r1UKAlEcDya7LtTG/xuqE7pbeitAoUPG3eztVQS/VCOO8dU
         04Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775958149; x=1776562949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0Pg4WAlFuYg9PEeCLBIArMJ2oXuf6TAJHZzZ95skOE=;
        b=hOAtfOgUCCOFoTdKurnvYbiQ4CBEvWh3h12TecI3ckLoFfYWoqnY2XU3kmSgFk/Qau
         pTTzCMqPVMAdxM58EoMyI4pgji87TO1LQrZXuwQhZ+1b2lPUecTsgNzLXOhy9eFP6veL
         McunI2iBejGJnbLcW795Gl1enGgPWrA2HCyxYUv537MeakCikCfx24o2yAOGm9Ok52m3
         V421vPMD3s6iCfjagRRDMJeGuDjXSoiGtJY5ir9RYw0DfYYpEdnLwgc2m5v27GLTf7W2
         9/CQFQ3nzpW9ZkyijSjAt6EzgiYmZ61UBUCUH+AJRsO3URI/vbpBQQjEizuX23sjOwq6
         5h0g==
X-Gm-Message-State: AOJu0Yw1fLcjlaRjE9GESmvIufB1dB7KmI5aRHLJxmEY9wDgP5DZh4t0
	KSPRZTxFUyxbnv9fFkZNBf0cp89FO9mX2Y9XSOXYDTr2vmNTxF0XZWtSTsdOcoD1O/w=
X-Gm-Gg: AeBDievQGF1JwkAAJPmWmgg2s6/ZYCR5wFZX0oJNlAUTUhj2KX8FzcE5S5q4t9mtG+K
	AwLMrUgZxBC4JwwN14f3+K2qS6ou7aTImAvnep+cxugbDNyFPfK8Gi1g8C734iMQDpyc2Ga/01Z
	6rU6wO6OCF7MN5+BbkG2hEUhMTdWusb/s8J8MumYnMXIMwrj4B8CSMDaJ8pVsM7xjI/zuhitynD
	GjN5ALvdp0Oh4NUDrgZppRIfK755ZmVQmTJqN7BR85+20T9s5zGLkf/J09SUIKXYi2WGNVLItK0
	b3p2+xmtbhht87VBK/nM1tgYJ819aljFlUUHbTiZjyJyKzBvRDCc8AD25bUSIVOpgI7CyOjXKma
	7AwuXY2VLc8Z+jepsG3j1AGAwJsM/1wCeRPCGaGbPXQ1jxb2dyxGW3yrhvXWiHCzLWHjKMu5j/l
	p0gbM=
X-Received: by 2002:a05:690c:90:b0:7af:6904:3f47 with SMTP id 00721157ae682-7af71476e91mr96691927b3.29.1775958149383;
        Sat, 11 Apr 2026 18:42:29 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:ba4::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3d3c1aa6sm34213127b3.20.2026.04.11.18.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 18:42:28 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: netdev@vger.kernel.org
Cc: Matt Vollrath <tactii@gmail.com>,
	edumazet@google.com,
	pabeni@redhat.com,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	nic_swsd@realtek.com
Subject: [PATCH net-next v2] r8169: Use napi_schedule_irqoff()
Date: Sat, 11 Apr 2026 21:40:31 -0400
Message-ID: <20260412014031.525061-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,kernel.org,lunn.ch,realtek.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277730-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tactii@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A36443E2676
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

napi_schedule() masks hard interrupts while doing its work, which is
redundant when called from an interrupt handler where hard interrupts
are already masked. Use napi_schedule_irqoff() instead to bypass this
redundant masking. This is an optimization.

Tested on a Lenovo RTL8168h/8111h.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 791277e750ba..4c0ad0de3410 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4873,7 +4873,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 		phy_mac_interrupt(tp->phydev);
 
 	rtl_irq_disable(tp);
-	napi_schedule(&tp->napi);
+	napi_schedule_irqoff(&tp->napi);
 out:
 	rtl_ack_events(tp, status);
 
-- 
2.43.0

Changes:
v2:
* CC the maintainers, make the CI board green


