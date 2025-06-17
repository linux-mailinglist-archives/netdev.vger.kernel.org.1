Return-Path: <netdev+bounces-198798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D60DBADDDD6
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254ED189DAD4
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D37A2F0025;
	Tue, 17 Jun 2025 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="xgjgf2vy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CB22749F4
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195272; cv=none; b=tjZ4Brw33/O/sqCi/11ZZqAJzQaNfsL4CWsbjmGL8lk/O2lrgjgmqv9PsPag1JNq45wUwDLloJtNL1TD5LalWt95JgHJdKZks5C345L/ld/49Ucg89kKjGPrusbfmLclVMw5phX9yki6fTqkoaxZcskcD20Z0FQilIhMp+cWvsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195272; c=relaxed/simple;
	bh=Nu4HUb7oq+s8HlR1G0vZ31EDK8rNQ+SidlnO+WjEGyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4Vn1grqgPch5BL4EoO+qn37qeuVWeCgDVyS5ZL79acAmsWBgxkB8ruSvKuQZnEsI2/cyHa8PATqzteksLrX/hFSuswg3/WT6sRjxEQt/iUfwaUE0TjxZqwdTB32Kc3cjY9UF3NjCL1YtpppzH1xQ6aaujGKQD4ldNeKE19eBcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=xgjgf2vy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23633a6ac50so90364855ad.2
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1750195270; x=1750800070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwN9qz9sZIc3Mzo9yc0Mf9VaP+qtGxOf6Nsoprc1PVs=;
        b=xgjgf2vytL+XJfEtSIOKHNb567lp/X/GNVM99T+RtvxrlKSY3xJov+l4TZdM16FcHJ
         hJcdCXMZZs/Y3vo5okzl9Mzxu1GBl0RBQMMJjD/J06aTaT7XH0HTNgBke0cAS96riPp/
         ZMu2qGPFvPutKO2Qa1jIwk3+p2SCk9Srr8CaxztYiZV0z5JzDzvf7GLHysRAhE4mamCW
         X/A/thdBI4lOGl+hOWhKSJ1AkSrnwnuFOb4kLqu8b3Xuq9K1IgVWGvxNVMUoYbXvxles
         VxOSC4P1GkDijGEg3kkgXJQq2RCaOmAu4oOCBZKfMHQr01uFq0k0eTPmUUfQL7DGaO/g
         nF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750195270; x=1750800070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwN9qz9sZIc3Mzo9yc0Mf9VaP+qtGxOf6Nsoprc1PVs=;
        b=TH2ODVudR2kBl53rF8yBt+3U3y4frHgQrqPl6Q/5hhSPAnqxliXhEOt+1wej39vkp6
         QIusAhapIsQihPhYdeBbZqRojOT6NsUuxBluCnqNgUBKeF2lC8Xaa6zmgtOpgLJtqH1O
         nkSm94ya4zZM2gIQkWuypGObNNElkDY3rVNs79L8p2xmHFtt+rzBXVPsSQdU2/t245D0
         GEkxKVjds9UXwBFDogUBn4kqcf1EriPeQLrEFIDnJXOLnXOAPUY/fjo2G9T4yjHir9Fj
         1iGU1ueSatjgua/LZENNyDU+ewEvNdVuIBMFJJBoKppmxZXLMNSZgsG+YcBmb5NioeFT
         g9AA==
X-Gm-Message-State: AOJu0YyoWGkWVm1T6X3rivAffTaMUa7FZepVgz3l9cF7RxByAYyjYLkk
	Dm4DsbSyGUV/uvGGB4yDm4wqin1fPBkdbuiaQaW1C8CWPbVpBYhHvvUP+tGe+8j5FPOrjIscAY0
	+m3Kc
X-Gm-Gg: ASbGncvun2FrwhsXMY6LMndusNwuvXDriHn35M7D7kThSmecW3DLd2MlPcoRsd+ZRmP
	yKyeyCXWVqNp+6Z5xol2L0VUiKWUfD5vgaePRigbPkg5GAkurZDiy5vUwm1CtOaCOR4vJsj6eJY
	AkzfnIPtjv8lm11Oa029fJnX+nhlKgCxw3siCnXlI4TW0XlC4d/YWVgt+XsMCO4DJpHfrplkYgE
	Y1VY5EzjZFMNgE9nDkjR9lwRz9NFpDnLl1iMwotNUSAHhR2tbhXItD5iw/+H5ACL8haoJSHO6N2
	O+z5hXxbhrCD46o9UZBfK51WOCIcSZjEOsU6AVxYN5Ms6CZb
X-Google-Smtp-Source: AGHT+IEUONIaqxldtzsCyB8l+rv+S1TBiwsU2asSJjoz8e0GgPmFFN2ihGw6dherMROsxNW0FqgrRA==
X-Received: by 2002:a17:902:e747:b0:234:d292:be7a with SMTP id d9443c01a7336-2366b337fe8mr239760905ad.1.1750195270268;
        Tue, 17 Jun 2025 14:21:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea8d2dsm85150985ad.160.2025.06.17.14.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 14:21:10 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net v2 1/4] selftests: netdevsim: improve lib.sh include in peer.sh
Date: Tue, 17 Jun 2025 14:20:59 -0700
Message-ID: <20250617212102.175711-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250617212102.175711-1-dw@davidwei.uk>
References: <20250617212102.175711-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the peer.sh test to run from INSTALL_PATH.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/drivers/net/netdevsim/peer.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
index 1bb46ec435d4..7f32b5600925 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/peer.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
@@ -1,7 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0-only
 
-source ../../../net/lib.sh
+lib_dir=$(dirname $0)/../../../net
+source $lib_dir/lib.sh
 
 NSIM_DEV_1_ID=$((256 + RANDOM % 256))
 NSIM_DEV_1_SYS=/sys/bus/netdevsim/devices/netdevsim$NSIM_DEV_1_ID
-- 
2.47.1


