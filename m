Return-Path: <netdev+bounces-81403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A7B887C4F
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 11:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EF01C20A73
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 10:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760DC1758E;
	Sun, 24 Mar 2024 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHQD8Ubd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1371168B9;
	Sun, 24 Mar 2024 10:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711277090; cv=none; b=Hw6jbgOlE7EuzcWRjrQFtDpgwU1M7tw0fV7y+IlU1l03ItjglGS0Zv1Nr0izcYD94qqQx2Endb+pMMjnSytebFRxc6+JsSTMhEFXHBjJfPLeZmBwxenxP598zLekt8VtyC0Di+vS8qLGUbNcnhyhELzbwkVsLKOvkftIlCexnr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711277090; c=relaxed/simple;
	bh=S1wpI9klpsRv3/xn9IOtLB90qUCVGwcVR9ubrbo8/5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TxO+fRMPRl+TipXEPDTTh2Gv8R8RiSG/E/XqRqQS1L/sJpDkMeeps0MBMMD41rpYkCI3u6vYr2R18+OtRpg1x+ZndXH3iHjSloS53t0KDuHubmpGi6JWGjJ7jzaJM96Ntyy/h4LyIIADUE2v/R/zsL7Q74gjjVQHTIcud74URh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHQD8Ubd; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a4f7a648dbso1910878eaf.3;
        Sun, 24 Mar 2024 03:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711277088; x=1711881888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iN15Fo9StLIXiwdIBsGn+8ehMC1YqdEwLXN2vdHz6oI=;
        b=DHQD8UbdEjeNqNPv8nuR6AaAQD8ITHxGhU6RH3pDAhJ2ZPfkNmBTpPJr4szU7jiJWL
         USPazQM87zl7cz7U6+qri4XzEgOexBm4GX7KUjbKA5ue+dZIz2W7iSbyVrPnrUTk4kpa
         CHdRAKvvHrF5PbPy30zMX9greaGAMYcl+sNzB1fZKyAdxtXl8jmf+WsXfTs1omGWALzl
         ipdL2pVZTHBiaKoTKHYa9+tIMgpnpu3Q1CZ5stF1VkxdVMNmtX2a9oTLhobDZa1+cH12
         stLjcY3COQRRULZ2mDeANjrnMve0QCj5+0ktyoz/j3nKqWRiTlMjGhmw3fa1EdvR75r7
         Oj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711277088; x=1711881888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iN15Fo9StLIXiwdIBsGn+8ehMC1YqdEwLXN2vdHz6oI=;
        b=HS9j0zwCVuQ7CFjDPK6jU5I7sP9sBqO5J2ACmXEZi+jXRaOJFCB39Rsb9dxWekTQnF
         fOISIv4ux+bTDMb5oY4bHrMY3maHXlYyk44VkoAOUxmzOrC2gP1gzk9zNKsWrdrvPA3I
         +QWApTQLDQg11n5rZFflyo3cS1v4BnBIqNtlkiOGUOZNBCz7hq1VFH2utNLgNQEswgzm
         U/UAPsAD6y+MhoDgJnLAlHgEFZV65k/opV+EBE3PBZhlwxfbXNS2Tw5qWRfttiqcjoli
         /u7Y8wQBK3qUla1QrCYg5QQk31c2mLhz3cKdcLQueje+SRb0FGfdGwyKpZO1bS5lMD/4
         xG0g==
X-Forwarded-Encrypted: i=1; AJvYcCVkpjwxtRXLaW8BZsy/6WHvTHZKg24kz0ZExu8RB2tl7avDrURXE154TehB43+l/uSStfY5dDRSvykLSYDdHvJS8TjwVBbvKWRj38JL1PSrax6ibhTOsq25yzf0f3+C/YgA
X-Gm-Message-State: AOJu0YxiDdjCYaGp0ymVfggRRWExewV5AcMv+1EWCVtq6FIUwa0FXwhM
	Rk+ucJsqpT29tiaUhKua1bSkwISnbtQktrYkINwEzeyjpoWoIdRL
X-Google-Smtp-Source: AGHT+IF4NfWcl3ZIDVk7DsBxVoJeO36pCuARlrLsKW8XAYuYMoGbOZ9pz2p7B0qDEWEvmeGzvMDxQw==
X-Received: by 2002:a05:6358:2490:b0:17f:5821:9a9c with SMTP id m16-20020a056358249000b0017f58219a9cmr5590457rwc.4.1711277087827;
        Sun, 24 Mar 2024 03:44:47 -0700 (PDT)
Received: from bharathsm-Virtual-Machine.. ([131.107.8.61])
        by smtp.googlemail.com with ESMTPSA id cv2-20020a17090afd0200b0029fe0b8859fsm5669255pjb.1.2024.03.24.03.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 03:44:47 -0700 (PDT)
From: Bharath SM <bharathsm.hsk@gmail.com>
X-Google-Original-From: Bharath SM <bharathsm@microsoft.com>
To: davem@davemloft.net,
	dhowells@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	corbet@lwn.net,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Bharath SM <bharathsm@microsoft.com>
Subject: [PATCH v2] dns_resolver: correct module name in dns resolver documentation
Date: Sun, 24 Mar 2024 16:13:38 +0530
Message-Id: <20240324104338.44083-1-bharathsm@microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240323081140.41558-1-bharathsm@microsoft.com>
References: <20240323081140.41558-1-bharathsm@microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an incorrect module name and sysfs path in dns resolver
documentation.

Signed-off-by: Bharath SM <bharathsm@microsoft.com>
---
 Documentation/networking/dns_resolver.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/dns_resolver.rst b/Documentation/networking/dns_resolver.rst
index add4d59a99a5..c0364f7070af 100644
--- a/Documentation/networking/dns_resolver.rst
+++ b/Documentation/networking/dns_resolver.rst
@@ -118,7 +118,7 @@ Keys of dns_resolver type can be read from userspace using keyctl_read() or
 Mechanism
 =========
 
-The dnsresolver module registers a key type called "dns_resolver".  Keys of
+The dns_resolver module registers a key type called "dns_resolver".  Keys of
 this type are used to transport and cache DNS lookup results from userspace.
 
 When dns_query() is invoked, it calls request_key() to search the local
@@ -152,4 +152,4 @@ Debugging
 Debugging messages can be turned on dynamically by writing a 1 into the
 following file::
 
-	/sys/module/dnsresolver/parameters/debug
+	/sys/module/dns_resolver/parameters/debug
-- 
2.34.1


