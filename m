Return-Path: <netdev+bounces-127898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195B6976F74
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D475F284F06
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728D81B1402;
	Thu, 12 Sep 2024 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="GYMtXO31"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769761EB2A
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161617; cv=none; b=p0kDpnbuXpblO4n4bGY0tykwgiezMPipuFRezrein+Txh3Cio6bn3tr6fZdfI0mVgFhh0y1ZI3oYpZGrob0q65ZbXCgRrJINLgFeHaq5zWPRkMXlfkuay9DZEFkw7cqgrSLXNn+vnOJtVtSP1u1NjOtpQjU+Gchmjg0YaGLAOV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161617; c=relaxed/simple;
	bh=zuxp/ffiRSeFBwa10fLp69PsdexTfFsicC9F4jcEjug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g2zDn+nYUAkjpf+tQWmc5k8q6ZGPjHXtL9trSRqj92R7FPnrNjMD2Pv9OHg8himd6pTj3rRkWCpGL7kRvr8l65uC0/1sJYZbljs/hL/95gcmOyBMIKptmdKiM/M+jqlzih/i1lgUiQrB/jau/QKCt6DNwJ7/AMo4yW3gIp+yI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=GYMtXO31; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2053525bd90so238445ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1726161614; x=1726766414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8xHZ4Uje01zsLE6BJdhmRRJqgkyFY6ipd8JgBKKHu/c=;
        b=GYMtXO31pIz7FnIS6YVpCLIQwxHS+3x0BrazywxNQ6Nv+9efVf6Cn1VS32P5zNgbjS
         dxM8TmwVfh/54xjgH7mluY1z6eyItIQuWPUqBaX+JonNqV3XNjgodPUUny4pEPwNmInv
         kJr/lkBCel3iXXCzN/QKInefj0xwJCW4vaTjRyt6M9BwG0uuhrYH8dhD6rDxnSjJPApa
         JXHrh+s9O/ukFn9qAhgT6yN/8tGAdI09Yk4fe0Qv36aTn4kgfuwNh6k38taTyRHDdo9+
         QqgGBA+1rsmZ1TY/yFcl4gJjdelmvfUtu6r+0ifvxMmtsuJoVn+R2nK30ZDLGzjNyC61
         N7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161614; x=1726766414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xHZ4Uje01zsLE6BJdhmRRJqgkyFY6ipd8JgBKKHu/c=;
        b=N+ZenWYRmpZwUhvmqRlxZ5WxeEqOAO6C7kjLr7TRqWxlYkJl8b+4+0+CR5MDCJ9otO
         hi8vP/25JugWTj7TH9BJQl2EsqToSaPKcjtsGMftDln6NmrV6BVepTWjZ6kzmDLjhiLP
         4/7zQSBeOKupavx7fU1FVfptOnyv+wGZ48lB36zbA/nekGCvABIyLxBzoNdYyl6KT07/
         1JHDF0OztJEYKtDir375IZsVkJMuTSj/AmJI0gv0HOHj4oz0Cf+TtmFwYQVsXDtu8bbZ
         Zmx6CgkHpKpgV7lndzrK2KxAbi/V5ESDTw0ZEZ0a9RblLT/HwRzz8InKXrw3bH8JTy7m
         Pu+w==
X-Gm-Message-State: AOJu0Yzp2LMN9c56mvdSlEGQi0dK+YXnGwMhWTWg2Y775CGv15hTXBLA
	k2H21N9MXBIRF9+mXX11RKB6YZrYPI8/HrMTzV1UHLzwP551bld2ZW5tMepegogqpp81sDrdAMg
	S
X-Google-Smtp-Source: AGHT+IGTjLouClY/TCV/gpWouL2gEuYXSYdFwHbfWDSxVQ7d3JK+hGrmZzsFY/xgB7vJNJypkcpTCg==
X-Received: by 2002:a17:903:41cb:b0:206:ae39:9f4 with SMTP id d9443c01a7336-2076e35ebfamr42015935ad.20.1726161614543;
        Thu, 12 Sep 2024 10:20:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b01b3fasm16385055ad.289.2024.09.12.10.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:20:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute] man: replace use of word segregate
Date: Thu, 12 Sep 2024 10:19:53 -0700
Message-ID: <20240912172003.13210-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The term segregate carries a lot of racist baggage in the US.
It is on the Inclusive Naming word list.
See: https://inclusivenaming.org/word-lists/tier-3/segregate/

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/ip-rule.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man8/ip-rule.8 b/man/man8/ip-rule.8
index d10b8b21..48f8222f 100644
--- a/man/man8/ip-rule.8
+++ b/man/man8/ip-rule.8
@@ -220,7 +220,7 @@ select the destination prefix to match.
 select the incoming device to match. If the interface is loopback,
 the rule only matches packets originating from this host. This means
 that you may create separate routing tables for forwarded and local
-packets and, hence, completely segregate them.
+packets and, hence, completely separate them.
 
 .TP
 .BI oif " NAME"
-- 
2.45.2


