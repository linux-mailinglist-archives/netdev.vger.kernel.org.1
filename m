Return-Path: <netdev+bounces-194339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0BEAC8BF6
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 12:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EAA27B1DEF
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 10:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FBA225412;
	Fri, 30 May 2025 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="F+X3gTY1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5BE21B9D6
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748599991; cv=none; b=H6HN4dxlNUFAuUc5uOzJrN7e+1Cgj40PzL946JpifNUFy2GAfhos4rcRWaDbGTxV+nZwMuKjmvvsgFyUl9/hjUTfoRl+IJjQKUiTAsdRwNWLB5n80qJ6k5uZ16NaEpN3UOAjssepP+zftqmpubWdOljzSajWAvrB9GmytARcn2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748599991; c=relaxed/simple;
	bh=RoPceCT88U9UnP5VGLnqcUBCCk5LAoemdIA1BgFYcG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siY5/9DPNhHOD5cnePaw4iYVxf3mhOg/BRaRjLTd1R4btdqhWS8jbwJX0dIO1loovq6jPGWPFxb1pol2iFdAJHryib18IyODkGRaqERufBrS3g0SNcWyALfFq8nQUuiq4zWhi0Yv8+Q35fX0Ssbvx0CwM+TYAxj0cNVS8+uzp5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=F+X3gTY1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cfb6a794so10151755e9.1
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748599987; x=1749204787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JT37SzU2UDYv3hG1XNn8rxWE6AIau0jZtc71Lj9N8OU=;
        b=F+X3gTY1XYqgR4qCbZUmUinJsKIyIPbjwYFs9+fhDemHe7joY9mhpE6ysPM75PCaFH
         gmnnI5uFHY3BSty1kffG61pWRsUw6hj88MZg4UCoe+08tmn/g4IOMVhUAoHN/ZNvUbMm
         uuCaYLKxSocFbAMz57wI2S2SELISEHXWqOjF3sf2kar0L/zDgDIuryqCT57GPlK4RFsr
         WmISLJJadzQzAQmxjgD6rCIrYH3JeQ0kC7+lFFMkRHiqvcuq/uRgTsj9etF5lQzgwelf
         W3D35bOOHchkLZG18wuG56Z+SijCzSzjYai/9XmvXiaUxbemXCSs0RhPGIE9C4/n1RA5
         VwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748599987; x=1749204787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JT37SzU2UDYv3hG1XNn8rxWE6AIau0jZtc71Lj9N8OU=;
        b=MgayrOIZJP5UMYgn2LbSFkthvPswF6UmJiX3cTj5+KWGH9hjjvrDPDU3c827Jioypp
         WQ4VsGTJ9+6nZgQsyECDJd7aaWm9ddKegd1DebzU0rR8ytqnfjZBqiEVXUvIvNbjWPWK
         rHjTjU49WZehGWMZz9n8AAEnZEKKNToLCYbEygR0ZFJzivGby0djQIq2ymAgZOPrLOS9
         sCOS7rKmwKImXgGG7EdE+IklPxwIs/tklyy38Enye7u2S7F1qsfXsQcI5p/Qo36BvZlx
         CnRqI8bOWTncNTMqS3xlliBajmujFVR5qa0y3RvBubkJXrmYmixXDNZaw1IMz6VWriTa
         KTNw==
X-Gm-Message-State: AOJu0YxzioVawA/xzKLjdSPsr+X0ln924r9VW24eKbL2MbcNKnNscE7N
	4J7vMrVEYbLCQGS66aVnNiWkgFoXO/B8fSKNc06AHhLOqsoxCEN7tBHVrjmtKIeVhfxql4eJSYT
	XNTeuj3AXsChdlWAcWzXt75tL5qJzzp44p3NXjdfUP6frDRiWheg8AQZIUSbGGgdS
X-Gm-Gg: ASbGncubuBh1X0n0RbadpKXbIUarwNZJv/zVWWu6H1ZCJB87l4t6vbX9pf03zg4yfbF
	/qebr7tpvqyGKTBzyz3lsTxtzAe4bGK6Eq4ppw9bX5YJyoRc4wXv7yOa6krOZPeznUp9KEkzEmg
	+dN9+Pxht4jb+D6MJH9KeGNGU9mWCQOvpiscLDbemUcweGcH8IaPew4u/jy/+dpjrpfMW3icRnb
	yip55kNQaWjWt/VTSSmz0Kx7Z7Q4abZR3C9YpHCluvXJUfxqPEbUtcab4ZlciWQ+im4u7VnN3YU
	jnZmKyfcGcEQwIb4KBafTmp/Z03PLe1tQeHExwZR8ofLLD3+SGmxS4WsSik5gsv3cQet8QKwDK0
	cEdBXpWUJJi+I0O5gz6c=
X-Google-Smtp-Source: AGHT+IGjQ9t821hLc04mQ/wYcu/xzdYsPiK7T6dogxiymKCOq+8ED/L/Id/mNBhMYLm+CRbN+H+ORA==
X-Received: by 2002:a05:600c:8207:b0:43c:f0ae:da7 with SMTP id 5b1f17b1804b1-450d64c31b3mr25672745e9.7.1748599987359;
        Fri, 30 May 2025 03:13:07 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:cdbd:204e:842c:3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b892sm4480956f8f.17.2025.05.30.03.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 03:13:06 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 5/5] selftest/net/ovpn: fix missing file
Date: Fri, 30 May 2025 12:12:54 +0200
Message-ID: <20250530101254.24044-6-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530101254.24044-1-antonio@openvpn.net>
References: <20250530101254.24044-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test-large-mtu.sh is referenced by the Makefile
but does not exist.

Add it along the other scripts.

Fixes: 944f8b6abab6 ("selftest/net/ovpn: extend coverage with more test cases")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/test-large-mtu.sh | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100755 tools/testing/selftests/net/ovpn/test-large-mtu.sh

diff --git a/tools/testing/selftests/net/ovpn/test-large-mtu.sh b/tools/testing/selftests/net/ovpn/test-large-mtu.sh
new file mode 100755
index 000000000000..ce2a2cb64f72
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-large-mtu.sh
@@ -0,0 +1,9 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2025 OpenVPN, Inc.
+#
+#  Author:	Antonio Quartulli <antonio@openvpn.net>
+
+MTU="1500"
+
+source test.sh
-- 
2.49.0


