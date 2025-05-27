Return-Path: <netdev+bounces-193665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03377AC5042
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBB417935A
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137DC2777F1;
	Tue, 27 May 2025 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cbmUE12y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7F027603C
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353980; cv=none; b=F73cjEisZQqaKuZmEzWF6e+TxMaDMIm2zEAmgvD28T3AH573vZEImZKXWoCPwhL2MbMgCb/o5XCWqG5AEi+KJ+AwimbgXdF2LXu0sFlDFqJJlsHBVjlw5MSfJl4tzNv87DgmKpZKyJNzYE/2ehNOlQWZn8mpuB+ZzMUkJj3+fGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353980; c=relaxed/simple;
	bh=RoPceCT88U9UnP5VGLnqcUBCCk5LAoemdIA1BgFYcG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jA/q6WXkzwQtcJTAmnOZGLEeNoK0tJT7b8VLVpoYo2/qRddMuyW/i1gJ7YtrEcBTdyzE9f+MZy92jSCLH19ANZDzIcJppWz4jPkX4M4GtVU+ThWRe+1Uy7NQ5UF/p4GBg6sFYnFmM0SPMbIvUxs3xpOlVJD0OwkGeUrifsEiPE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cbmUE12y; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a375e72473so2194079f8f.0
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748353976; x=1748958776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JT37SzU2UDYv3hG1XNn8rxWE6AIau0jZtc71Lj9N8OU=;
        b=cbmUE12yhp0c8sV3rw+QyFLQ7SoYZDLz9IeHKNmKsmH/VGiWm7VOuef1Zv9k9J1dKC
         h3/GPmLDF9JO0j8GAo7/l3iy5g37iXbJjOWuu2ViyWRqC6CqteLihd7AO9EGmlm4TCcM
         ksdAfc1EvfMAIOoTTgLKYFjECTMrq6Wuqhbl+dj1kpA/9Ilhi+kPNkdrIphvuGSGQq3D
         gyZpEMJepH0GYNrh6kmVVuT4ZRMq6xUSEsfd0/ojFRzQq37gMhcP2zEKATbCa3Rdz+om
         Xwdp7LLGaFxStr35xHwfvt3Wz4mT/SqNypEVX2yz74UIp/HhMmPCO4zQtmItQWbIzrT+
         hKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748353976; x=1748958776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JT37SzU2UDYv3hG1XNn8rxWE6AIau0jZtc71Lj9N8OU=;
        b=tCVADkvBLCQTc3wXcvbOdOiQLCnRyvtHdR3gZbA1ZcYS9JZVq4EbwayZ9hxk15ZPB9
         3sUADK3UmsjEXHlCUqZeL7hmnjEZOks+ntsx8fNnpbqgHZtWdbnaczz+uiP7WRW3uwNQ
         6Fm1MK0Xkku0QnP2TQOUkGtsDrZ2PI2KhmuFcldlWIgL0KwWV7SRY61R6Glz+GTZUCbT
         PFn2737+jRTE2+4TE/Zi+VoCMI5z+mNP3OHeDzUzn3RvfhClKYNR+wwE6WITpftb8HSI
         +9Td1TOd2OKkxK3fPnUI6BINSv9zhKMidKrz7Guxdo1FJGt38t+5Vvdicaoo+JB9+xX+
         79+g==
X-Gm-Message-State: AOJu0YydfmDOjXQRyX/aArYtT71o5KAasR8jstkzVzLgNByH/AmP8I1b
	7+zQPdUdNxYgbTHhNOc3oiU1LBluScD7BCUER7CNm8PWO+U/SSdZbhSUEteT1Smcw1vsMK6RMPK
	DGQk4KdSCv9kr/F8rR3FdrddZrtHJYTsrZCLGwvF8gjXAoADFUQvaGaMmWH9suQdg
X-Gm-Gg: ASbGncvVNqjcbnCnjeTBsXz8dGnC06iG6eASnIOZPmoDtYuHFGdQWtEW4xM+n72UVo2
	+6+SuJQFRIVHGxZfqgrilLMNX9tEMFrjKTdT8SNCu4H4Dyp1CAwC7aKFjVb10gEo+k123Mf+wIE
	7OmneOZF9Z7IZed+ucEZLXD1fy8avwdNbP/oeUvTOCzyYcOAgGRssnhlrpaTLOMeGuJM/RhjxEQ
	NbR22AYZPXiXq0AVbOYFvHnLTlvhtJknZNiccELj2LBJkp8kqHDp2HZ7sU6v+IVfNc0eAfazFfK
	gZEPHrtFpyfjtZIkJurQcnqhW24ohaE6aS/6yjk8+EdL78Dw9SxoOLJZE44WpFUJnKGAd1gt0Xo
	=
X-Google-Smtp-Source: AGHT+IGW99Yp9ii5uqH0zYi0v3/swv+jSt/XF3mJXGGUkO3nrO0WqU7XsAl/jBO+WGPyHnK6E+DfRw==
X-Received: by 2002:a05:6000:3104:b0:3a4:e393:11e2 with SMTP id ffacd0b85a97d-3a4e39314a8mr1938487f8f.34.1748353975973;
        Tue, 27 May 2025 06:52:55 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:5803:da07:1aab:70cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4db284261sm5387719f8f.67.2025.05.27.06.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 06:52:55 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 4/4] selftest/net/ovpn: fix missing file
Date: Tue, 27 May 2025 15:46:20 +0200
Message-ID: <20250527134625.15216-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527134625.15216-1-antonio@openvpn.net>
References: <20250527134625.15216-1-antonio@openvpn.net>
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


