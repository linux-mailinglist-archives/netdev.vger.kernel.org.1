Return-Path: <netdev+bounces-172745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78733A55E18
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A5E18921E5
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7485A189B91;
	Fri,  7 Mar 2025 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+L28eEE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0E15E5AE
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 03:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317243; cv=none; b=GL8LprDCwoD8Ym5tyTiHKqGMZd8PtTwBIA19ewLW7IulKhF+It09jkhCQxIdeNXWvzevPs5KWNyR606gQxXceTxntzq5rZnpz9QU0xSJjbg1tz+/WvhYmN6HhM1RuUG/Us7JfdONmDK2wQYHzMpMh0VSRmkS+7kd2xrv83U5uKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317243; c=relaxed/simple;
	bh=A4Qw8++ZUIYhLp05JsaRB0sP3n3pjfoeU1bX9uU4Rrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JyZRhvLZTEOZM+ST83lPEza2Kd/LZqvXIL7Sc1gM543h7X2hcIPgK1fcZbiUU4YYd0c0CrhERmCOL71fbZSo50yNRT0gQmewNq4L+11VzD6xjNEUsTMvQjembz0H1NxUQZQgQtMTmeJu7O+vnFdRtAnuZVpArl55FTWRwU69rng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+L28eEE; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c04df48a5bso131985685a.2
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 19:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741317241; x=1741922041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uU7zuvOu57kB6Fj9/Ow558oQ9haQMR7CYqLZhedrYC0=;
        b=O+L28eEEPZVmsmyA0GLB1IwDs0PsYSBbHaqwSNHfgqpeNvzIK3kRz49QTxuFYIVvUu
         MB9OjcaT8GjF+zm52q0+3wzPsTPTHm78IWsM40hwA30GPryY7MP60GFo7TIF6EhfnjgU
         G+tsZI/49tw4wj0VxuEDiTf3IJglwHE4QvwGhR1R/spr2eVfieGeHrHNOXMxiw2N0FIx
         fT3CWHHH6VOwYCnJ9wz+FD/WQ8Crl1hjD3aP+zRkO/xkIjFG+RE+nJS+pIBkUWwujlOm
         7TwHGy3L3EPFvToX245qqjyN4Mxddp5mHqGZ7PfU0dkB/O0QvOki8QuYqODbMwMwpLn1
         bUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741317241; x=1741922041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uU7zuvOu57kB6Fj9/Ow558oQ9haQMR7CYqLZhedrYC0=;
        b=NNmPsVDrjpT0cWg8FhfZrIhbwaugFD+Ru49d9u6E5A5Dr1UdxKTsyTXU91YgeoravN
         9LL3SwQIMdiFPt5W20/D919nGoQQ/DO8QyoPNGYtsRzqZlh/SYFmreh6zrU3zm7q8Uc9
         fAvYwmQb8ovwINI207nUUWPRgDFIy3vsKWEULm6vOjndZnt7SzwwljRTtSo4+M/XN7lu
         goHGqiZB28C42PMVz0MW57BikozK7RhdmWnSiwyME7bJgdp8gcy5lYEtChiQDZPYs3Ak
         We/HHUKqxrTCc2m+Z2H9yMjaCbpYxy1erPH049v8NqUM3jbsBiInpoE1KBQ5mKdzkD+r
         V3Cg==
X-Gm-Message-State: AOJu0YxrM6hSm7RjF+lpD6AVzCWW5WTtD8amI1qTbQla/1DkC0swQPLm
	UOyrd5ZW3r3bb7bPs6fq4VZOxQgHrKIUsPgpOdxM5h0mj2SvYP9QY1eKTQ==
X-Gm-Gg: ASbGncu+qyCYcBm/z/RqkIBUeexRvNRO5F6sSeTtJKC3+LH+nqVfP0kKIbMe3XPxQqF
	3Unz7KiYuGIDrktor7LHAd/SuUzBd8bZ/vdGf2rqHm+1Fd9BhiL5xLpXQDnQ0Ur868WAckl2JCe
	bjEjkznwmc8kIyHOqk7FzxiuDTfY+JXtE/08sqX2WXSoUvtSS5EDKAa+UxtzGbOkmsMBgubsVc1
	118keV+xkXMfxt7y8UDUydo+1jlJYWNRHYDtzhgzIYvngb3C+nicDPiWRqD77wc9HCtK3YZiIwt
	QPVByryN3lQIrx3cZpjoRMMxq/0z2xhopQF+77EbvIuQS1ksik5umNEtoygtWtEwqIVdXBLTPRV
	k1/f6q1snIzWL3kAcmq71FAvEt8fMZIa72snGIDUu7InO
X-Google-Smtp-Source: AGHT+IEqTzCnnEK2htvvkMAI5e2xxonTR9qjUIFvWVbY4t93OUDKrfGWONJLri/yh13RvGv2ETe8Cw==
X-Received: by 2002:a05:620a:27cc:b0:7c3:d5bc:b76b with SMTP id af79cd13be357-7c4e6107c65mr279536585a.32.1741317240612;
        Thu, 06 Mar 2025 19:14:00 -0800 (PST)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a474sm178564385a.20.2025.03.06.19.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 19:13:59 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ps.report@gmx.net,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] selftests/net: add proc_net_pktgen to .gitignore
Date: Thu,  6 Mar 2025 22:13:44 -0500
Message-ID: <20250307031356.368350-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Ensure git doesn't pick up this new target.

Fixes: 03544faad761 ("selftest: net: add proc_net_pktgen")
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 80dcae53ef55..679542f565a4 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -21,6 +21,7 @@ msg_oob
 msg_zerocopy
 netlink-dumps
 nettest
+proc_net_pktgen
 psock_fanout
 psock_snd
 psock_tpacket
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


