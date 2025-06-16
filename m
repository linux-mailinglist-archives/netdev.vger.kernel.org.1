Return-Path: <netdev+bounces-198199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEB6ADB925
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD52188F4F5
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 18:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8BB289E1B;
	Mon, 16 Jun 2025 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Vy0jVt40"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E53D204C1A
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750100101; cv=none; b=rWptr0VBXaOqzvCJLItM5u+wlokcnOAuOIBLqMALpIqXx3QZ6nvsO2vgz4W+zf8EJhZnthzmO+GnZeUpvzPd90XSqyOV3g3WbijmntbYVLeOk2IObQouXNuEH+cKSgvWChzLra9D4PCrOzF/k4znfZFUhoX2gldga20fdooDgGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750100101; c=relaxed/simple;
	bh=Nu4HUb7oq+s8HlR1G0vZ31EDK8rNQ+SidlnO+WjEGyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oecxx1GdRJiFq6jU/KJfoeQKzPbYZfYEPRE/YEzZzerAB4R0OoASeew6/k7aEFlrPhLmQJstQbPybyinOJLaqziSgQbN8opoch2PrFDVBKP93hmuqrctIO3CoOMXiCzpLwqh2cXYzTLGQ/1+4RgyQ5Vs47+utj156syypPIvE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Vy0jVt40; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74264d1832eso5505116b3a.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 11:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1750100099; x=1750704899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwN9qz9sZIc3Mzo9yc0Mf9VaP+qtGxOf6Nsoprc1PVs=;
        b=Vy0jVt40YuLTbF8SNcXDK0sg3tQX/DQQxoAptWOpJaiDXxZB/riPMiQG7BEI297rY6
         er4W+M1qdJoVKQVg5I9jzxWzwivINdhh1ojerlNxuv4G0qXzGC3m0MAp2c+rlZNQBhIk
         uqdMTKmJfzX7vS0IU6kg3DY78mKp7XGXv2F8d8krSZ9WMTmz8MDEgo54e/VEPb88vdTK
         SXWOaeA88946uhCdz4f1dRAZAvAtk+dizhMlPAas1uQCW88+fip0k3KQeHUL6/VwqNW1
         C+wBDaX1TIkm+M+IcWICS7E1DKf0OXL0beefklQUr5S+mkbxv3yWAZuWnkv3M+uO8mz2
         NovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750100099; x=1750704899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwN9qz9sZIc3Mzo9yc0Mf9VaP+qtGxOf6Nsoprc1PVs=;
        b=MmD7V+nB4hq4GWOY4sA0tjByv3yLpFIHKOwHlMk/V2sjGyvzAeuq0jfgsWgzBdxC41
         RwPKNlYX+nA6jdpJoIwfGRvEUJkkleM7FEDhPlCE5j33oPUiuNGEXlCcE9xyO14yCvS9
         OAL/RQg+3fvhMWhd8Uql77JZ78w/qROYOOIeTRnQgHubooCDMB5DOBuxS/ywUNwOQ+pL
         K5j71+ubcvdp1YcjUM2smhxaZY139tSrZmK2cfE+rd85CCqvTiYq2PAaIoUl+9qfUxTd
         wYXxFx9sxizIBcuy1sk+ndbURiudZ7tJSz19tNZttsuxq6FV3xAVdkBw5SysmAm1YaWL
         G2Ug==
X-Gm-Message-State: AOJu0Yz3H6u+Wg4cZ6PPf5QOZXabsltENTw5oxSsMu2Fp9lidJrBMf1I
	Hudx2UhZx9TJJaogJsee0u3mjj/0hS+oyO1UjR3ufNm9BPK9KIcb4PXRc1XWq7LSv04IuGw0iCu
	B483F
X-Gm-Gg: ASbGncs4DV5KxseN5geXKgFAwpUpHNkUxlwoKK9ZeejQuUCE5JBS6i17vKyXGmY7CI+
	aaSVofLAlP2bKuo53kdeM8xnavkNb61igbMwXTlJyEv7dGgsMZR+1z3GSP3Lers30M8/eWlWWTq
	dIf86OXO/J6Oppm3Dx0gOhTy6zNWS+VBRLgcZW3BLU2dLAYunblTx+h5j1XttagxGkj40yyWpFR
	5ai7jGzLWWTB0oDzZCiZScFk1evQ/BASC4mc90TZL4JMK0fCAkZQO8vrGy2WQXG2PMeLoy7peon
	uX7HxbILXiT2sWtGfeJwwSapNzDRXYHKoCFqTL6Ya93n4V/e
X-Google-Smtp-Source: AGHT+IHyEhkhmxhgKdj84KEWu6KMwPImFIzX8usovR3K93p3kib6LscKM6D3f+aXtFH6xiTohzBwqA==
X-Received: by 2002:a05:6a00:1797:b0:737:678d:fb66 with SMTP id d2e1a72fcca58-7489cdfcb9bmr13370366b3a.5.1750100099559;
        Mon, 16 Jun 2025 11:54:59 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7489008301dsm7196982b3a.78.2025.06.16.11.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 11:54:59 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net v1 1/4] selftests: netdevsim: improve lib.sh include in peer.sh
Date: Mon, 16 Jun 2025 11:54:53 -0700
Message-ID: <20250616185456.2644238-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250616185456.2644238-1-dw@davidwei.uk>
References: <20250616185456.2644238-1-dw@davidwei.uk>
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


