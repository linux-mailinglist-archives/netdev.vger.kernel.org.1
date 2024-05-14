Return-Path: <netdev+bounces-96436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E458C5C8A
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 22:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C944A281691
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 20:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DEF1EA74;
	Tue, 14 May 2024 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MneH25a5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46F1DFD1
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715720143; cv=none; b=oOZ5h0YLJ5a+16MZaVzw3ovsp9z3TA/cB3pIttG+lwAqihz3mbEng+IgyK9nYROqokhU3qtEhPkwkoAKRPHy1VLMcNaFaV7y9XDvRtG7uI29n+DZyH54TUvk3OwZ+Px5ph7qoLLewGLnttkbuxXX7BkRI+6BIxNEhjFLB027dNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715720143; c=relaxed/simple;
	bh=n4InXXHdmQYMUMLwSO4XU4UAA1upq1a1Vg5nKgNosTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=njnNqJVH5C96mPqDOO1knG23kMdgik2hDGDwZ/YVOQRXTqulF/jDRu4zlwYEBSQbpaA4YbBC0aaf9OMuQTW/zYWBvlYsXsQ2Md1mhUaYbuJ9PSDcQE6siZEXhki9vML/z3YqiAaBd23+GSuIvetZZOXP3UJoRqX9oMYnUVz+dTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MneH25a5; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e576057c56so40541321fa.3
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 13:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715720140; x=1716324940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q1icJc1L0oViOAqmfxOGISYM5AcGchs/ne7ovjID28I=;
        b=MneH25a5Is4U4vVCur6z77Uu18lxDo1cFFhX9+UUaanDGPH/vXhBAaNXWnDA4WZPrR
         wpDlbM4FEHWvPlNyxhfhFoMbAxUwKy6yxMj7Tp3JMH4ueW0JCTiCQxUcdeGIhxqQIlri
         bIzu93mZp80QJhHGmrEsQJ0s09fmrN8OK3nkNiu1OPZ7V3TM0i78xwkspdjf9o6kgdOh
         QQkBxij3tLiBL8EPEyZ21YN89nRr3yvj/Q5mgI/XbwluoBJUC2CZ1c3ioGwmFUs5BO0K
         mtabG3KCJzjYomPIuPL+ylicmd4ti0sPTLdre1ORaONmQ7vdCee8KpXdNpBzD83+/25S
         nddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715720140; x=1716324940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1icJc1L0oViOAqmfxOGISYM5AcGchs/ne7ovjID28I=;
        b=mmdenIai5ZJORPncBCT6mBqyJfkY0UOlpvv/VZ7ipoObIYCOre2MJz6pxO9uCKc300
         oAc2jPzAC4reCbpltL4mT+VeD9rFc33FD+vRpazsk6ZgmE/Efx7rY80rAaod1bMWiLIp
         +R6/GBAPkfdJprUUXlPSrEANAjzVLnVnJYMp277aH9E+dgDRGVHhxZFqs3v1cfjqAft7
         EYkAmCan+WJbxrWW5l2pasQwjOKTq0fWXX9fKdkLySBmUeT0zLFVMkspMVf/+B0ndb6i
         r9DVKOlNYgsYuCfU4gI0weK7yVvNrHp5IH5N2eQiwz50Z1hacfUexYqKiauWvsJbMnwJ
         2FzA==
X-Gm-Message-State: AOJu0YwcnJMRdAAoTSLP3LU/TKhcMFveWHHB6eA0VjqLWdeOdcDYu4e4
	sjyyite/abl/TT58NRqJdFWsxg7FzXXtgsMWLWwvvc7kWjzso/V8+IqqtjyQezW8+A==
X-Google-Smtp-Source: AGHT+IHByZPUIpFDZbNoXGRVAFU3jrMyj4oNs6IVqhh1GiSgrqLSB0vedSVIFLP+uNyHnYff6HDvfA==
X-Received: by 2002:a2e:8847:0:b0:2e2:2791:983e with SMTP id 38308e7fff4ca-2e51fd451femr85617861fa.13.1715720139928;
        Tue, 14 May 2024 13:55:39 -0700 (PDT)
Received: from localhost.localdomain (109-252-120-142.nat.spd-mgts.ru. [109.252.120.142])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d15155f2sm18334181fa.98.2024.05.14.13.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 13:55:39 -0700 (PDT)
From: Anton <ant.v.moryakov@gmail.com>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Anton <ant.v.moryakov@gmail.com>
Subject: [PATCH] ila_common.h: Remove redundant check for neutral-map-auto in ila_csum_name2mode function
Date: Tue, 14 May 2024 23:55:24 +0300
Message-Id: <20240514205525.28342-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The neutral-map-auto option was already handled correctly in the
switch statement of the ila_csum_name2mode function. Removing the
redundant check for neutral-map-auto simplifies the code without
changing its behavior.

Signed-off-by: Anton <ant.v.moryakov@gmail.com>
---
 ip/ila_common.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/ip/ila_common.h b/ip/ila_common.h
index f99c2672..ebc2f064 100644
--- a/ip/ila_common.h
+++ b/ip/ila_common.h
@@ -27,8 +27,6 @@ static inline int ila_csum_name2mode(char *name)
 		return ILA_CSUM_ADJUST_TRANSPORT;
 	else if (strcmp(name, "neutral-map") == 0)
 		return ILA_CSUM_NEUTRAL_MAP;
-	else if (strcmp(name, "neutral-map-auto") == 0)
-		return ILA_CSUM_NEUTRAL_MAP_AUTO;
 	else if (strcmp(name, "no-action") == 0)
 		return ILA_CSUM_NO_ACTION;
 	else if (strcmp(name, "neutral-map-auto") == 0)
-- 
2.43.0


