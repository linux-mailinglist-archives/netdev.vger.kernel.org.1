Return-Path: <netdev+bounces-192702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 973E9AC0DA5
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC3E4E1870
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B000228DB4D;
	Thu, 22 May 2025 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="CSgWiR0H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A24728D8EF
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747922824; cv=none; b=N7Lk03QH+C4GC7p6WTOKvzYBc//kag/oMPzXOkRr070PHHZ8CApUYfJx/cze73+OMVhLoqDZZIXPBCNUTK+fZRAgL2Z+JPf452mUOJyezTjoX4wY8zmtre3kuYlb5S1xd5QOjZ6te98L5lRNoHet0aWqHBa97uipMV1bZvYkOwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747922824; c=relaxed/simple;
	bh=RoPceCT88U9UnP5VGLnqcUBCCk5LAoemdIA1BgFYcG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmnwEf8D09uXAAL/3jfO6HWKFjG/qWVSt9h8u+JhduzXkW2vsxqcswvJQtqjoQHM5Ku7Q7C+Y4RPw+WLcSW50Krw18+rmXUPQdd1RTkUgVGVXNvxv5a3Cjp84HQExjVPam1Ll7OFJdZAdeOzV6DmbdQFIvuRs2WAyDgiSRfLWvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=CSgWiR0H; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a365a68057so4925826f8f.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 07:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747922820; x=1748527620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JT37SzU2UDYv3hG1XNn8rxWE6AIau0jZtc71Lj9N8OU=;
        b=CSgWiR0HWe25oKPIJf3Sx+CYJQyfhBWd+9506HphvWdzMPMc4qnYAs/Gzb64Wiq2FF
         XMzelWZWI5vovEAoObD9t7GfI/j9HwLaRjWaxdzrCAm50Crwm+JSPrqmVxUUtrtYheAE
         5iV4d6QEyVE+5VgCLOxJepRAJmrO02w5CN2JBzY4TgtTn7ywUAUwh+SSMcIZaFHLiJZP
         glNMV2KUgKlnzXVlxtMiDvq7NurPi3BU/vNLyygZ44f7HyeIlWdLnXIHWKFgx44UQOqh
         23k7OKeH0EX7P+zzifRC/p5aem+RbSiE/ZjedlY3NTM/OzRqOU1QBMB7Bu05lyiuHOtd
         0otA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747922820; x=1748527620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JT37SzU2UDYv3hG1XNn8rxWE6AIau0jZtc71Lj9N8OU=;
        b=FNNjrgKbGjgCqtb6hus60goXXqM34P0wZtocpmEUu/b1SBJa5SmMjouzKEPsgGE9o2
         XR7N6ASDl1kSZdQBXRnnlpEk0Sqf+8OjDvLOGsCLsTIP9Eg5Bfvsa6kWLwzRBne10yO0
         Z91YRJDbVT1gC26ebWsPxAWIMk8oldiP54TV8XURWq4C+7x0XflowYPt7jt1zuj7DmZX
         wXd9DsM47351SBumyarnyVpUa/Cwbmk7qPixoylA2t4lZNF469RMOPzdaZmcgs2jzrba
         gfyCZH0Oy3+tU85Pcgbh6LjNKaZIegAsXcOWiKSglqGXmnLMkTDBdPNSCrXVoMuIdKEc
         pVwg==
X-Gm-Message-State: AOJu0YzRN4StCu6vY8K99hBD6mjciz+NZFrN/H3Nqfo3qGM6rs2gFXib
	jvYwSUi5x0pqRqFxrEhoA9+OBjedhj4buCrYMQQy+OORT/53v30EEV7ZdEB+gEzD/k5jJi76ByE
	kbdAMiCWOTBYCzGbndqae8qMZXkNDXQlFR8Y6DgJqbu6EpnkYSbBN3Vfq1iOnKB+i
X-Gm-Gg: ASbGncupoB1fvQbXi9rFGriBzfLEfeEjISJJQD6T+8QiaDXx45TOKKsPoXixitGAulx
	NUYBgJ+rv2iUJBVifXjVHcbPbh6+/GZDUC8oECLOS8whLQfE5q37lL2Hq9+AuyOx6FYg8s3VzxZ
	/6LRHgEgkIBYOk55HigaipN4Dq7gyvJxNlGwMkDNTx3HV0kwAdc/sz/FXkHQ19qcbJijn4zYvMN
	2TEyKR7ABK/G+/bnjH/JQvYd7lfk321wXzsWdH+Q+FM0fmu1rLAWXeBJaAA0vyvPqmCb319WvT1
	VNFDxml94cfNHecZr4DxwwXV9/0G0g/NMB7K8lQjuN4Rj9t5/eLkHO6TEh+F6RtC11RjTpvNpmo
	=
X-Google-Smtp-Source: AGHT+IFuklWU//vAuV9wkJYKnOwoViVvbpRb8hY4GCNxu/Qsh+rceZO892EiFL3yoIHr2jUVSwpdyw==
X-Received: by 2002:a05:6000:290c:b0:3a3:61b8:a637 with SMTP id ffacd0b85a97d-3a361b8a7a8mr21390991f8f.22.1747922820368;
        Thu, 22 May 2025 07:07:00 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:3ef2:f0df:bea2:574b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca62b1bsm23671269f8f.53.2025.05.22.07.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:06:59 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 4/4] selftest/net/ovpn: fix missing file
Date: Thu, 22 May 2025 16:06:13 +0200
Message-ID: <20250522140613.877-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522140613.877-1-antonio@openvpn.net>
References: <20250522140613.877-1-antonio@openvpn.net>
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


