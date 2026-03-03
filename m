Return-Path: <netdev+bounces-263409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPbWAS9Ep2kNgAAAu9opvQ
	(envelope-from <netdev+bounces-263409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 21:27:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEF11F6C60
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 21:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 770BE302573E
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 20:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1B53845B2;
	Tue,  3 Mar 2026 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNE/Qw6i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DF2386450
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569381; cv=none; b=QMw2rGQFbBwQj16UW6nVn22q5WgOdf4AqHZkE8mCjbcvCf9urcXVeZMVFALCAHkx2E4jCyLmSQc1xECy7uDyI9dCV9AKAQmW5E23U9LWP3CtGccqCLFg1ydO2KY2HB1+EzLbx8c9b9COhk6EpNqaI22QuxmuzbUl0FN/KwQEdRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569381; c=relaxed/simple;
	bh=ZlkAHRongZW7MFNkY97hZ1B7jfOQGw7I4BaMQXtR3VE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jq+6VeLjWdD3OH/ORj7TAVpeoAW0SIQw0VnYiLZJnCH21VEezlgBN6goTM/4DQASKY9ArsOmfn1oaBakfTw31Ux6xIHsZSogLLbkRR6nnOISDhXdWhJzWAAwLfFuYXfuZWnAysF85b/BQOeAQP9RlWrkOoonDHV4YD28tuiZSwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNE/Qw6i; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-463a0e14b4dso2160840b6e.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 12:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772569379; x=1773174179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yEdszIU/63CHIO1XYZ9+oYkvoNvBVjVhAjHwY5bSphA=;
        b=fNE/Qw6iXwv11x5pQMhHnMOMO026BQq0DRI2s/ipH0cfTtUdcNeVkJJZZJxhfxy0L8
         unPtuMRg2wwgqHWKjfI3zwpVNwvIgQg5zPszQ7iAhkNMI8BvvCyXmknehZY+sAOnR3TH
         Iq7lNjTpGLTRARHDXsxR453ozjfPQXI+z/7CuiEor2RSpsFGFQR5SHYwEnurshDjz4jU
         nWcSGeIJIbAv0bTg3xhMrwzEIG1yusQazgh7DhjVDsm+o/4YYLoifFGsZCzbHvTUJNVn
         QBFj89iDQqksblAFCrtdIrNtVe5YwXbr7dlDEPnhNc8Cm1ii20Sj99N+20vUdsuvSEkk
         BTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772569379; x=1773174179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEdszIU/63CHIO1XYZ9+oYkvoNvBVjVhAjHwY5bSphA=;
        b=LMKx/8/roxT0qNPz948GbR17lKPnSefm57/zmdbzlzMukMp9VtT9F5RDHCW4v1/FsX
         WbrPVNms0BmtQQwVP2SMhZg74sO24aZxAiBEuwTf+HwI9cJ2hZcbzKFM/uoXYGZZfUFu
         tsnFHiYnu9xko44n3RHlF8rYQvPY8jxIuUYD9OPhnEDOMLanlaIqnyQk/08vs1c559Mw
         erhFxuEnLJpeeZKZkORiVOz2tPmz2LoH9OFX8iIVQA7ve/Jf2KbB+DN5iucaL+6JNW2O
         oJbXwdBpcfflVMNSjHq5Uazh7gn6V7MDzNW89OghImPlwdfQh9vSJ1f9MhWzpxzug+WZ
         OPJw==
X-Forwarded-Encrypted: i=1; AJvYcCXg/YewYGEy0A/k3yAF+v3/vfpB5Ix14djEEnkdwDxc5A3CtIBr187MiH+NqwqEiXqLgBHMfjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynng9TMNDhKSt0SrWMOjGH/lKDd2nykvgzPbH5nPLdOjzejLqE
	ULCIXZFp7LtL457t4Iol2wG2pihRq0rEoGRWC632wH5GhjAF2LcDYend
X-Gm-Gg: ATEYQzzn8cCyXdrKdDGrI/5OGmGAwl9fN2RzW6vegU7H560MkZ8wmJM0NHM3MgtNnB1
	NB3CriP3sIpS2anzf7Mj3mfgi16pGNJwEQBO7rf8Toy173dyKBvY6m+8PlauLTtV37QPFDFFqyf
	Um8gThLDE+W1ZcQt2l64VbZ8tOdMNyFWV3PEmmkYw7FnVJXAp+kTd8eejxAw8YURt55FWvo8YL+
	4TCi/qaUw5w9RJ9d0+ju/8KvmbLRhTRu/1z72YH/owrm9aUBXuBwnIGDqMjpTG1n6XyxXleQ8vs
	ab9WdwEb5aNQFuMk1WNR9hpXya6tdhnu+U6p6EcaLSVTAxrmZmgYwaGeaZSjt+hSA/MNGMXxzrF
	mRq/+1BdG4FhllfXqh09BCeYekBqNvgcjVoBM36pMeB2igWeFMWUJ2YMG+WKrK5ITtgOiLBfsyk
	EjoMEL+1pVnLG08PR2h+A+ZUXjLsDp6Q==
X-Received: by 2002:a05:6808:1491:b0:45e:e07c:3fd8 with SMTP id 5614622812f47-464bec61c64mr8375764b6e.43.1772569379579;
        Tue, 03 Mar 2026 12:22:59 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:70::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf23977sm15103082fac.4.2026.03.03.12.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:22:59 -0800 (PST)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: rss: Fix error calculation in test_hitless_key_update
Date: Tue,  3 Mar 2026 12:22:58 -0800
Message-ID: <20260303202258.1595661-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5CEF11F6C60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263409-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This test verifies there are no errors when a devices RSS key is updated
while traffic is flowing. The current check is a no-op since the last
sample was subtracted from itself.

Fixes: 933048fec4dd ("selftests: drv-net: rss_ctx: test flow rehashing without impacting traffic")
Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
---
 tools/testing/selftests/drivers/net/hw/rss_ctx.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 97246eab863a..d7cb30306368 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -357,7 +357,7 @@ def test_hitless_key_update(cfg):
         tgen.wait_pkts_and_stop(5000)
 
     ksft_lt((t1 - t0).total_seconds(), 0.15)
-    ksft_eq(errors1 - errors1, 0)
+    ksft_eq(errors1 - errors0, 0)
     ksft_eq(carrier1 - carrier0, 0)
 
 
-- 
2.47.3


