Return-Path: <netdev+bounces-194770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07353ACC518
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA3887A91A9
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDAE23024D;
	Tue,  3 Jun 2025 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="N00VvR46"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9090231848
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949098; cv=none; b=NagxQF54mup9G7qW1D4wjTqXI/EH2YnTJgRbbTpIFj8C1MUkKnSAHUKIm85cf8P18Ng+B8Hqs6Ka6fvQ/5VvdXOCSJeryeHgEzuSeQchAuM/IvO7IOicSnE2X/pcoiJoQVieRuagwhfQSK46pWcsMjhIoKM9Nj5E2ioc9c7eoj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949098; c=relaxed/simple;
	bh=RoPceCT88U9UnP5VGLnqcUBCCk5LAoemdIA1BgFYcG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7Rxo3UTcf15RiimWF0YiaEo5CEJqMv80oEXazxKHMCJSbVmGa1iDGa0p2l25Q/oPYskwLZsC/AOKvdpXdHQSAnaE+i5M2cZw23e7UNRztniVLWYhOawTELeIB010okQcZhPKhlnhkU0gubfvKFKD9K/g3QlyHtGKR2KWecu7eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=N00VvR46; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so21827105e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 04:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748949093; x=1749553893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JT37SzU2UDYv3hG1XNn8rxWE6AIau0jZtc71Lj9N8OU=;
        b=N00VvR46VIkJTiLVT8nOgKK+ttWin08fgokm5N3pj0ctQwizo0hoFudYw+8ctR9d/P
         NGJhSEWNMbcUTjsTYMkCYYBGNwJQ98H8+54saCHf/u87V669GLJ3IjK9hr/ywCrDzgdx
         8OVeSGWzZB7Fn8VGf2YJgCRaIZ+pOPOhP2dPwV4UgUgCBivdho7xM57hKAJUp1M1++b2
         fPHoYQTjD8hh/cfKk0vPz0XmYyMiqQvThvVmNlM+98Loxb6Sg0/3QN9vyAQYnqGrfuCL
         ncz7Eo8gGx/dLeUknl1Sd0RuOMicx5c8h+DHKg1YLQanVaaLApyUFj/o1ASsxOOyOdl1
         6Ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748949093; x=1749553893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JT37SzU2UDYv3hG1XNn8rxWE6AIau0jZtc71Lj9N8OU=;
        b=nCT4G93L2Loog3CvM9FxGnbNIJnXSlBWAhvQEr953LE1uT2aFZQSLtcKHxoGbI2UfR
         zw6Z0dY95gHRN3xDjvwwdTXJt0rEH5Uajct26xbMjSdmqE07zIeDn4DQDhGBQSz6FZ/A
         3kno10p1UAf70ZoMVaTOX1mIOJAE2j0K3nkflc05NlLowzp1BoUn+hO90LG1chph2c0m
         w8qU0EcQPw+bYh4phSLoLSlpCOKdB1OBQeIaFEhCdbaaC7HsrblTQfeul/iRfYjDC2TH
         EOve8CMf+tbYbkp3NkPCYYV5DfNokF3k+NgdQH8qT/Nko9kAQef1ZX/zygyf8kW4zPkn
         BHIQ==
X-Gm-Message-State: AOJu0YyLQ/rI7rGZOq61G6Flj8iAXMTqvcsXJgO0eNj/4Rxg9Y3rdyq7
	YKbRPnzEMIqyxU7YQtlxxFojQHqFDKEt1PIdfcoB3siJSrLTWVehWF/sx77rzXki9cS9Z4cTFUC
	3YLaxI1SVuk0LXgiJelAFkVFyrvzfLLMpAtvVNDIcsF4OBC5xvjuSkYwV6OQjcO9L
X-Gm-Gg: ASbGncsT9spOJAsrrhYC+fYl6IUjtlK7RgqwLrK3nxGMafsjQlQ3ggtTakx/4CE0rEe
	suhFfFlQjtLJbWbC2Tz/zkUigWCiqp5Raakn1x4aP+jy4M4w4arNZW+OFZpjJxrFgxPEh8sYR6N
	AsCCaYdUzsvzRMj5PszVl2NPl3Uv5vrPSKvlPAxCISDGK7qhdA7Sjg8tux6clfzcLZp8+Cnekf4
	rW+ZA/O+Z1sbXLy+h5RXc566CRFpM95sZmm3KGLL+9E4j99x3iZ0bWzX+NnUse6FSDVJyS1UIU4
	H6BxfxXqtzL8103qpVyK2wefmGY58FWO5BFui4Ninn91gDEdALVjhxvcsp3wrTLE1JqEIZ2rwPx
	1Cwi/FexBvw==
X-Google-Smtp-Source: AGHT+IEcy/aTGb788aV8gOWbxW6nvzF7pHQFBbOdgy8bW2N9BrBp/RcIWhYap6u7zoHnVwlmZeEPMQ==
X-Received: by 2002:a05:600c:1914:b0:450:cf42:7565 with SMTP id 5b1f17b1804b1-45121fb93a2mr96330335e9.23.1748949093525;
        Tue, 03 Jun 2025 04:11:33 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:32cb:f052:3c80:d7a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa249esm163244525e9.13.2025.06.03.04.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 04:11:32 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 5/5] selftest/net/ovpn: fix missing file
Date: Tue,  3 Jun 2025 13:11:10 +0200
Message-ID: <20250603111110.4575-6-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603111110.4575-1-antonio@openvpn.net>
References: <20250603111110.4575-1-antonio@openvpn.net>
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


