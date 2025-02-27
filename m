Return-Path: <netdev+bounces-170184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B345A47A5B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457011892503
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884DB22A1F1;
	Thu, 27 Feb 2025 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="QvqOYXWc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702E0227EA3
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 10:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652435; cv=none; b=i4OHYlXAzpPx6x9sn9cMzhqWhTrgbwhpyETg55Z1QSzwgVokErNaOc/nss4aUvIoz0wCS1SCcpzeqh3JXhR+/uIzvWPWW56eADTLXNjshHz3CqJPHbXY0Cgod9RCyFyxCf9JA9lwSfMMqGG4GKAd92S9GPTrheCFLN6dut3IADU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652435; c=relaxed/simple;
	bh=D08w2GFQZ1BiQj7xvD6wMYcyKe/SgPRJmQZd7yMRnD8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VH4nMR8oXPj+Xus4gY+N+txouAQ95oSC3uMtOyi7AwgcVzvkEthRRXHMqlraBCH5YXeddmD+a1YdRJARqzpV/Bf0MwIVA5MIppXvhnTmCN4CGtWUTGphZ0gns+ZL8Cvy82XqN66Us6K5Epy0VfVKXPNDaCrueDr0kBH6noB7nWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=QvqOYXWc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4399a1eada3so6941085e9.2
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 02:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1740652431; x=1741257231; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pG66JypK8Sv4IBGijDRJFxew9/nK3QBCJcHrVxMM5vM=;
        b=QvqOYXWchcZJThBppJ+w04KNtq4rYL1i33+ydwjJYkROspNc8/W4R2+q22LXIzboEY
         eolJtOpvDHBPc2zHo9FMRBv04B3etg0+De5xEbPGSLJ06qogcYHrVFvN++xuz/EsgG2p
         ODmZp6S9skS7xbqtLAL34h+8i6pOqQ+n77tINekcZBAEPi/iriPz5dJoyagZfg53rSp1
         1d5MAx344HDRSkTROXtHKQdVantJN4/7RhJqtnGldguA5HHZTqs+MLrZHQ7WYjXnA4WR
         f2Bgw0QVm6gfgGfmwD+MZzLIl986qUPPqIUuJxjxe63/3qU97p1DNZ0ihvaE+wW5B8h1
         JRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740652431; x=1741257231;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pG66JypK8Sv4IBGijDRJFxew9/nK3QBCJcHrVxMM5vM=;
        b=EGRwnvxQim6WCFQNMKFL6HxoMjso8RT4WuGB8KIaCfMhMlEIezns3g2M5AxKxXBoHw
         UEFlsEOOBobt2iQwV7+l4aK3eRnMvKuICL1N2JpyXkxV5HOXviLycuDAWGjaa0nIj+pb
         rih36e3nEXsllqeO1PU5+WbifoFBWLV8tgt4e0/dXQYJtbCymMxlKivkugeP2vAHCFZg
         6U7xzg83mBhNrz7x6DGRcA1SKrxvL26EO4KwEuqCZuOkTzHEuPyW5TJtPkyoOLEO+R0v
         5+gBA/6B1fvCoYpb1JnFQZqjv4PtCaYiHpJIbFf+OjWW8z3FjeDxHf91Ya3uKMmCi5Ak
         9SAg==
X-Forwarded-Encrypted: i=1; AJvYcCUydqknxetVCPvVNHXkV47pX3uor0r1tGrBo1lsX87nzmECOIXkqRxsIVRTSFIOeZEvoIsylis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvqPAtnsdG+qjnw+nu99BgfQ0o98xxv6x/TM46sROSgU8PWuLx
	jhSNsyM541V3f3HDySoTPLBYGpcHo/bOk5uhA8PZA9PiVI8KqWe6G9qThBSXa3o=
X-Gm-Gg: ASbGncvnFBTgKCU1n15xYR/ukW1gnfwBbe7rEcEcvGS17dhOI8S3lu3j36F0CsFdWeR
	HqkE7F87pMOXnMouWZWg8v7c5WLTxKXdOsOpss576x5lrJl8YWax+RZ9QUvHltMTGDzZuQT8For
	rwZk9NjvZGozvtFmy+Nhv4oOv5WMV376go0G3VvThW508D9k6tUSR277EfFmSU8FJ1lE3Hn7YNe
	4KARuTMhSmNOVgghmD/N6oX+7sZ/mOQLXtzTktbZZ9pt8C4tYLf+tbIZtlXR9njzwl90ff04AuZ
	CERS9lG41n5L6+sFF7OqFPcpsc/R74ZVtTzzytAMP94D3pE8L0FA0ABgWegx65pID6TowVI9f0Y
	=
X-Google-Smtp-Source: AGHT+IEP6Sbdbfhvd8vO4gpa9I69K6X8v6/tBdDfJi+QpqKJM7u9uroZK3LI7N0QUexUDaQvcg9V2w==
X-Received: by 2002:a05:600c:4e8b:b0:439:9206:86d6 with SMTP id 5b1f17b1804b1-43ab8fd7344mr59171245e9.7.1740652430706;
        Thu, 27 Feb 2025 02:33:50 -0800 (PST)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27ab2asm17854305e9.32.2025.02.27.02.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 02:33:50 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/3] Fixes for IPA v4.7
Date: Thu, 27 Feb 2025 11:33:39 +0100
Message-Id: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIM/wGcC/x3LQQqAIBBA0avIrBuwoZC6SrSQGms2JgoSiHdva
 Pn4/AaFs3CB1TTIXKXIExXjYOC4fbwY5VQDWZotkUNJHuuEDoO8XJBsIB8WZ4kn0Cll/oM+297
 7B/jLTWdgAAAA
X-Change-ID: 20250227-ipa-v4-7-fixes-20f2af9702e4
To: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

During bringup of IPA v4.7 unfortunately some bits were missed, and it
couldn't be tested much back then due to missing features in tqftpserv
which caused the modem to not enable correctly.

Especially the last commit is important since it makes mobile data
actually functional on SoCs with IPA v4.7 like SM6350 - used on the
Fairphone 4. Before that, you'd get an IP address on the interface but
then e.g. ping never got any response back.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (3):
      net: ipa: Fix v4.7 resource group names
      net: ipa: Fix QSB data for v4.7
      net: ipa: Enable checksum for IPA_ENDPOINT_AP_MODEM_{RX,TX} for v4.7

 drivers/net/ipa/data/ipa_data-v4.7.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)
---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250227-ipa-v4-7-fixes-20f2af9702e4

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


