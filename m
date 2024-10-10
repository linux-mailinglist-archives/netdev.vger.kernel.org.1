Return-Path: <netdev+bounces-134386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8061599921C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 21:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29267B2F961
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF01A1C8FBC;
	Thu, 10 Oct 2024 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6KtjF6m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD719DFAB;
	Thu, 10 Oct 2024 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587141; cv=none; b=Kg47rvaFfov09WBbOwPKFIcYyNIG9c+m52FP3C0gimA6IOh6Md+3ODn8wzMgAh2XjJb2IVrZcgSk9SxJGhwdrQS3JGNrUZq8nLDrDFWLAHLDnvZfvPlKjLOu0wvWXIFOxT3c4AiawLBwP9dAGFoKAsgyuKOkSDjtqcL3HXMgq4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587141; c=relaxed/simple;
	bh=9nZKTw4aCkvD4i44ycAJVgRMQ4dQDg9MK9LwgzbylZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QC9wOtfvM1DA+A7rsGKQJnOmoiptGYp5zsizMsqNHybj13WQ8VwE03R0RWLlo/MurtljkYoG1dgcm39K9C/jqgn5Z4HW2sabRHPRa18NaD2tQo0XnVTisXrixsRc7kqlJSNy1Ib+ZWtEvNV1GchaSEI/4W+2v4qioYxXOLNa+cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6KtjF6m; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6db836c6bd7so12924517b3.3;
        Thu, 10 Oct 2024 12:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728587138; x=1729191938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MZdywbszG1pbZ42IsUss783Lv34wT7AFus2iDOuZXog=;
        b=h6KtjF6mE9jlVr4Jv+wGIT1o46i0Skf+FyQdL0HaElUB0Sld0Ek3n3B4VAPgy/xDrq
         5pJ1/sivVVQ76s4ShAYFEQI6QBZqZWazzXQ0HFFv1skAozuqLEr9wbqGnPAXkaE7Ab2X
         cWX+HNWK1a966u2ke4+Cxe7U+l7y61nWpCltty0jKTX4hY+Fj+cAHM+rHbWjhXuGrWNH
         jvKNgXCi79eQuP4Ljqt9pFIFJ5kaJXB09W/b/72FaVn6+5PSSuKqCceW8L2JT6jnf8KQ
         JyK9huL85rmRk+gWyaFmORbLmE4LkyGz6JO8PVjiau28mJsSlkMI2GF2MLHHBZHFlCaK
         oo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728587138; x=1729191938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZdywbszG1pbZ42IsUss783Lv34wT7AFus2iDOuZXog=;
        b=mjfaQAHAkX3NrrtI4MR54LmyihD3Tm6df5u56luS63UacL8ZmCC9ze9gtIj0wQtrS8
         61zfLDLuaAgE1h5nv8w4bTFl/gbsCNfM7oxhYfT6OtdWyAmjWIjfGSLh3VUNAnfWbKOc
         oll4yXjiod6gFZ1znKae+auO7Cw4ycbh4K081qMLeWR1SK4Rj0HIG8q/sY4z2krdaRA5
         wMxJqcQ7qLBJhN3+a4Nvnk5dYcgCkGF7rGNukP9azZ8OlgYXKeYq5UjX6Y/FTIeJW/fe
         SJ6IEbHFrEuYIRh3zuFTQhXGscaAckFiSL9Fze+uotfUN9ufVOKCIgcyn1MF3U/z8Jnu
         iCBg==
X-Forwarded-Encrypted: i=1; AJvYcCVA6xgMkW7Dxzz2kAWASbjwd4zbNQU2KXMcbQA1619hZkCkofh+j5kaprm6lSqmsDH8s0Ee0UBf@vger.kernel.org, AJvYcCXsmvnRlZQCA1SS3LC7+ZD9p/p7YWgs5TkTJ5Mvfgb+jdGItqzdk4X8veXDZYFWg4Q9K4uMs8LtwTsXOuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ6dVz4EZC6wiVeY2UEWTW37DWaDf+1dnwCQlSjbvftI7sl1U4
	DfV53Css0Cym6cmK1vHn+Rc3cg3ggybDylIpTU9Vy+9p3yJGikus
X-Google-Smtp-Source: AGHT+IGmzrqsm2WeIIOfbFMt2zkFaMV3uzEZvHqw/Nseaz0VNTxVD7ItQDpkh1owdugxCTKIB3Obfg==
X-Received: by 2002:a05:690c:4887:b0:6ad:deb1:c8e0 with SMTP id 00721157ae682-6e32e20a00dmr37587117b3.18.1728587138061;
        Thu, 10 Oct 2024 12:05:38 -0700 (PDT)
Received: from dove-Linux.. ([2601:586:8301:5150:f757:be8b:66fa:b754])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332c3049dsm3107287b3.90.2024.10.10.12.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 12:05:37 -0700 (PDT)
From: Iulian Gilca <igilca1980@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: igilca@outlook.com,
	Iulian Gilca <igilca1980@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] of: net: Add option for random mac address
Date: Thu, 10 Oct 2024 15:05:03 -0400
Message-ID: <20241010190508.196894-1-igilca1980@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embedded devices that may not have fixed mac address
may want to use a randomly generated one.
DSA switch ports are some of these.

Signed-off-by: Iulian Gilca <igilca1980@gmail.com>
---
 net/core/of_net.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/of_net.c b/net/core/of_net.c
index 93ea425b9248..aa4acdffc710 100644
--- a/net/core/of_net.c
+++ b/net/core/of_net.c
@@ -142,6 +142,10 @@ int of_get_mac_address(struct device_node *np, u8 *addr)
 	if (!ret)
 		return 0;
 
+	ret = of_get_mac_addr(np, "random-address", addr);
+	if (!ret)
+		return 0;
+
 	return of_get_mac_address_nvmem(np, addr);
 }
 EXPORT_SYMBOL(of_get_mac_address);
-- 
2.43.0


