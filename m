Return-Path: <netdev+bounces-272974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDRYJ6d1yWnHyAUAu9opvQ
	(envelope-from <netdev+bounces-272974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:55:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F12D8353B04
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13F1830037FE
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F7737CD53;
	Sun, 29 Mar 2026 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCWhw0Za"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6E8257845
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774810437; cv=none; b=cWacDtYbWDnvG3LxneJiMHhE/zQ7IUJ9oVYFDN5PuNLW9DStNjCrYFCP6QhjiDScVoMpdHp4xriEOcFox9hK3HvfU5mFqr5PXyKtYXFc4WzqzgZGyGU7q0bFIVLo7Q8EiJcP1JnHKjHCIgJeVLLNTK0eC9ij4zuBtax+nmY3fjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774810437; c=relaxed/simple;
	bh=WokI/CyCjO/nMysUwA032oZykRm0bTt3eYR25Bdp3XU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r62wO81CJLiuMiJNZPU5gP1fw93gUaMfXROrlfO9cZ86PPZY8efGoGSnkl/2M3gyd+KiS86kPRW+kTiqX4h9xZMet3FUwjA6M2AxSvIcRq2jWiwBwkG7DcRAd4cTYcLMs5DbaQX4Cv5vRTKUdgnyiK40kauOp+rezAoExiH08Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCWhw0Za; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486b9675d36so30948145e9.0
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774810435; x=1775415235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JX7kq9B3rsWfS/+MaXznl5402MWL0xlkc4MHgICNJPg=;
        b=OCWhw0ZauHJggt9WqopKDzxIRfhmSkoo9hOef32wgYdGw+yzDvQvM568j+AD33uic1
         abIG9GHUSYE3xVyG5QjFE8ShlgE3ZVjHQSngbsAwJWjUnTNAm2dTPiVOjwlxfw5bun/4
         N+gxzo0kbAw8ZlR9s21HgwPPsaNSlNpiQzYqANa4ZRu5wNtI2rjxGM4SP0WHCGH7LIJd
         bgecWOaezgGUJPy2KoWLxD72nQUwreNAiMYY4AvahiOXeJxuqQiXHX27Y4QpPq4qTjzO
         wgqvLzpM9qMPh3Yv/WKYoaT0kUPALgQVRXYmlX0syB/dcCfEdmsI9QeDtgbJjQKS4Bww
         BsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774810435; x=1775415235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JX7kq9B3rsWfS/+MaXznl5402MWL0xlkc4MHgICNJPg=;
        b=k7WmJgw7uWQbWycEcugkTTKPQC6gB7raLD9j+WCgBCgecLtngrhoWGKWjZd6B/yXz5
         684AnySNtgvPHOZfvuTdlB5eTA4X4fG8dx/om42znRQHLGlfkLPA1uY/IMw4SoDUI+VK
         FSIORgbGCE6URSp3XdG15UnKMer33s2NgQevAsbaFXnmTC3zSkt0h0CkALX2+d/cYEGZ
         I6Zea4QuPPQm+l2zr+wUES6cq42vzs99GlN6IgE8aYHWDusYI377aESKq2XV75zkRIod
         9xSJ3UDdnAmFefbw6EJPpT5L47QbfrEBv34b4C4BGkMsh70u8ny1/ekd10pmnTFuvegJ
         6yVg==
X-Forwarded-Encrypted: i=1; AJvYcCV1amZPHlTPwPA81Tlg4Lg3Q4XT4ePiha4rvvhZTaDYZb1Fp0ekfIxMTR+DPV3epZdVz6c0gZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXbkRBnFpcjgZ25/+aHG2eeGFAwDT636jo0NZvgDeucY1eFBnC
	u984TEeLViQIX+FXiW8Mvd0v0xhnPDdwsab7S5JvUQtlEWAdhLouMOec1YmbGAx0k7ajng==
X-Gm-Gg: ATEYQzwwJIdyc6fzEqnTL2xNwWPoShLi1Gi/DiqZAuhuA2TGminIwlVWUqGgKQOVI7n
	2kiWPNr7M9d2k1ZqXKpjMDSFhVfmHhloVGNX5OycK4TncyDzgH+xieHd1UrdBdZZmd/F9G6xCVD
	agPwN+7OjRH3aJjN2L57N449AXIRIEwVDjvYROfgZYUKVjLTl8JohG1VN82EE39avUv7BA7WtHo
	rH3fdcVKY+0JaJ8vf8anrbMR1l1S2YlKDTOVki6z19RRYG6vvKI7edAHXmKGoa4GImeMQMSF8+h
	NTdN8DsUGGmZ6GUDCcniKef+1nJIWYBbOj4CKjjLn3vSZpZAHslyG7PNkI4jQyvgVJg42tsMCHq
	h0W4+TA2nOPXP4A8Evbjp8pD+/nsatMOqUCzxly4VGEZPefQGMcNYfo22FH8PuBWaFnRegeUIQS
	qQejyeufW2kKDi1pMWFbmMqAEELoNyT21pT9alN5ohVRaYFmnB66DGe6I=
X-Received: by 2002:a05:600c:3592:b0:485:3949:e5c6 with SMTP id 5b1f17b1804b1-48727d5943dmr182473475e9.3.1774810434364;
        Sun, 29 Mar 2026 11:53:54 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21f173dsm15201205f8f.15.2026.03.29.11.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 11:53:53 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: pabeni@redhat.com,
	davem@davemloft.net,
	daniel.machon@microchip.com
Cc: andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] net: microchip: dead code cleanup in kconfig for FDMA
Date: Sun, 29 Mar 2026 19:53:48 +0100
Message-ID: <20260329185348.526893-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.51.2
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,google.com,kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272974-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[julianbraha@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F12D8353B04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Kconfig in the parent directory already has the first 'if NET_VENDOR_MICROCHIP'
gating the inclusion of this Kconfig, meaning that the second
'if NET_VENDOR_MICROCHIP' condition is effectively dead code.

I propose removing the second 'if NET_VENDOR_MICROCHIP' in
drivers/net/ethernet/microchip/fdma/Kconfig

This dead code was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/net/ethernet/microchip/fdma/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/fdma/Kconfig b/drivers/net/ethernet/microchip/fdma/Kconfig
index ec228c061351..57a54e7167d3 100644
--- a/drivers/net/ethernet/microchip/fdma/Kconfig
+++ b/drivers/net/ethernet/microchip/fdma/Kconfig
@@ -3,8 +3,6 @@
 # Microchip FDMA API configuration
 #
 
-if NET_VENDOR_MICROCHIP
-
 config FDMA
 	bool "FDMA API" if COMPILE_TEST
 	help
@@ -14,5 +12,3 @@ config FDMA
 	  Say Y here if you want to build the FDMA API that provides a common
 	  set of functions and data structures for interacting with the Frame
 	  DMA engine in multiple microchip switchcores.
-
-endif # NET_VENDOR_MICROCHIP
-- 
2.51.2


