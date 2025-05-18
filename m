Return-Path: <netdev+bounces-191342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E186DABB04A
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 15:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FCD3A61E3
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 13:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666BB1E502;
	Sun, 18 May 2025 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbvOfNbQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCB4635
	for <netdev@vger.kernel.org>; Sun, 18 May 2025 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747573718; cv=none; b=XmClRzHBuTEVRBwBHTzR+vvM+GlvyIZ99uCWvCKeVYp9ALTIQ1QKcjue7KPrWMSMIVGTFQemMcUuu2v5f0DCWFx/wKZUZpbT7E/2/v45zZUq48Hyvwn+6K3dz/0s0pqlJ+qfFAScp2+v7VxwtuQ3nRnvMydD+wZYTdiS8rkDHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747573718; c=relaxed/simple;
	bh=h51j+1hvbZJh331C/zzdrO3GyrEER/O5H2kYmHFsm8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ET89tn5c4A8tH3fD7vX8SbmhxV1RwDzYWdrgBMS/Ph67C4/36DNeQd/xQkurWNfNTd9YzQZRLLa0yjk9CnCrGaouCOlvJLh5WQnb3F6X4JfKoetsFWz6uoLBMKUxkxVUQHYcnUxFDhbVUL2sWAAIN5NMPFIN3ESuZtupjN1adgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbvOfNbQ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-550ee1cb0a3so2567756e87.3
        for <netdev@vger.kernel.org>; Sun, 18 May 2025 06:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747573715; x=1748178515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4cC9rOPVAPM2zWjOKY1n4zlJe2p2cfRcSX/55/ploHI=;
        b=gbvOfNbQ9VtTu+GYnPyAYNqJjVguMpOP/ZnEWMNFzktwbTeHtKjv6aMTDyZRE/4+1T
         IqQlpmW1N/L/tTV8G8ke7+eW7AK00IGSZwVC1iKAA7j9gMUC4VBjAGQEJYRYz6NGFWGK
         Hmj+ax3pJcSLo8WotVnuzCMYz7/ztdxjKtGSI6Op8XqcN+j6+bEsKVzMiioOPAsO2YRU
         PsyQJDbgWNSqEYHrYSup4JWqeQSDLJAImzfIgKVbGBxXIVcz7iP7mKtLCAWWHM2sBLLp
         MlV2GMOk4vQ3uYDL5HaGt9YGGTWvxy3aRHgOmBUAueG6vzU1r/QezdjffBcaDIJlktfB
         VfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747573715; x=1748178515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cC9rOPVAPM2zWjOKY1n4zlJe2p2cfRcSX/55/ploHI=;
        b=EJdpVjYP5uWg2jC/1JNdL9OWQ2eiT3kL2xR9/7nSIzVKSIX+MyiCEQtlPqMyUpBEGw
         zYRl1dzhcNkVXrn3y+VxoZjVo//jjMOVbOPKRt+78nWEsslGqr6U7XuzvjkpphgYbj4q
         ESYj6dvnUsapP+sEnHyy9OMhD2Qt8cSsi7EePllneTknghWM1eik6nVmq2smD8rFlz+H
         IIym7Z3FSdtNx4Bt8rWUG9Nom+vAVK1t51iWzrB0ubh1KPE3N0zRUUnlqWYxWrwliZVd
         5DWvJ5M0h3VrR3K3w32yOVyP+nbzYHFeRsSd/ang9cJVitxzq9gDe532B03E6eoW0M6C
         SdoQ==
X-Gm-Message-State: AOJu0Yxc6PkPv3qiaa2ydgzwjEZn4/arxDhzitGuTmaLlKzNRQGOvSjs
	q3l8M1hMt80yhLtQ9MKa1qhWzlxlBZsn8cJkGZig2DilTVq7bSzQDlRv
X-Gm-Gg: ASbGncsNoM9akK+PiNJ2HjbxLTYMPNBcBVxEFsLr5fms+y46XjZFNFzzuAq/Sznp4tt
	W6CC1GwNHp8fW5aRxBg0sRsn+KTi7pHSsjqygy8zm5W9Ayb82rl5E38oU6K98az9aqPzKavH5Yj
	7ouDqbWEcNXdjENA7EHVlytvQPS0ICdCrH7nerKJnH1QUySCV1HYVyvaoYDi3ahWVOz402yzf8y
	gaoDxlUHvCCtfEh+zr4lN3cmF/oXx5PyVuwc4q+peiDKrzjcK7zKYNPygLo5OTfLr7/k6U9R0c2
	xe01sVP8FP3zfx12tPag8UH5QWnvUrifkRupIO3hkMm17UmYBR9ilbpiBkK+9RZmYNv+FQAlqH/
	Ik3dA9HMwcmUoAyb/KQ==
X-Google-Smtp-Source: AGHT+IGpy5I7Axdy7VtB6Yo7wleaI/BW1EUvI6rPK1mnt8lfc53DAJvVpqUDUkJXQSL2EgFEM8EFrQ==
X-Received: by 2002:a05:6512:3e04:b0:54f:b8a8:d660 with SMTP id 2adb3069b0e04-550e7244c1fmr2821530e87.50.1747573714460;
        Sun, 18 May 2025 06:08:34 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru. [109.252.120.31])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e703f6e0sm1415152e87.223.2025.05.18.06.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 06:08:34 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	AntonMoryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] common: fix potential NULL dereference in print_rss_hkey()
Date: Sun, 18 May 2025 16:08:28 +0300
Message-Id: <20250518130828.968381-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AntonMoryakov <ant.v.moryakov@gmail.com>


Static analyzer (Svace) reported a possible null pointer dereference
in print_rss_hkey(). Specifically, when the 'hkey' pointer is NULL,
the function continues execution after printing an error message,
leading to dereferencing hkey[i].

This patch adds an early return after the NULL check to prevent
execution from continuing in such cases.

This resolves:
DEREF_AFTER_NULL: common.c:209

Found by Svace static analysis tool.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

---
 common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/common.c b/common.c
index 1ba27e7..35ec36d 100644
--- a/common.c
+++ b/common.c
@@ -233,8 +233,10 @@ void print_rss_hkey(u8 *hkey, u32 hkey_size)
 	u32 i;
 
 	printf("RSS hash key:\n");
-	if (!hkey_size || !hkey)
+	if (!hkey_size || !hkey) {
 		printf("Operation not supported\n");
+		return;
+	}
 
 	for (i = 0; i < hkey_size; i++) {
 		if (i == (hkey_size - 1))
-- 
2.34.1


