Return-Path: <netdev+bounces-126323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00402970B8B
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 03:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7621E28220A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 01:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498FC11712;
	Mon,  9 Sep 2024 01:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcTn8CyC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E7D1862A;
	Mon,  9 Sep 2024 01:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725846997; cv=none; b=nMTMIH+knGbYETfVYhUDL1BrJ0murGih4/4htrPDS8pYvjsbth57YUboyaXZXITMTB4V2adbfgEDc5ViiylaYv83SojY2YJbrHHPNvGtgY90o2dKyaGgwNRhSmmCM/hTp69eM8b7TG46z+xJ4jNZQsMKdFvtFQae30OnO8x3ssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725846997; c=relaxed/simple;
	bh=BpEiNhhqCugbye/etwvt04BgHZOhdH6jShAP/zMKlAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qC/sk/mytd+QKUWdRUYf7a7Ng1pRhkzvFILuuFSOUMtWlb9iw6XCyhiPMftyOWVkj3tyMrAO82NzAhq6BnPjjYf1DFCpisSlGxNboDZSx7bEJ2l5gYdU0PGk60JHqgUp7FYzCCV/vg9YLOkMiXq1X9ynUMbOq2LK/vFv01vFvLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcTn8CyC; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-277e4327c99so2337859fac.0;
        Sun, 08 Sep 2024 18:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725846995; x=1726451795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hUADkHrGp8GIn5B85+puRiM4QHvo2cWkC0rNrhRG5pw=;
        b=HcTn8CyCffwzYE8PqWdUwRWmIe3dYFTI90ecm5TSMa0QMSE+uU3AEczvEtSOmKapWn
         yK2Hegp5l2Mop2UysNnoTlMsWLxFZITyQbGzK+dyThyC7nT1AB5pimE2hjzLhkvpWWaW
         t9pXzda03D1bAqvVH2y7xuh/AMOjFgnTJu7KwsFyiYQNVa9aNIgNl6uegOyZq5LShCxn
         Fj1mjDmU08VOQbpDCAHHlqVwrNKNsl7qCFlMtgaQXg321tliFISAzrTuP/M6KFcrtFWy
         F96EdzamyrO01K4j6IPSFhLNY1ZZ2DPysMVWr9v/tPXx0HbITvTp/TQtA81MDlw4OqT8
         V02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725846995; x=1726451795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUADkHrGp8GIn5B85+puRiM4QHvo2cWkC0rNrhRG5pw=;
        b=gv54fGXP81QPyub/OxWmXNcQW5MpztgdZ9tMIKZn29horz4mEHlsROiq06MOiIfOFO
         AcAkmLjo/IcRLUkxgtR6eoEXvW/H+TOTiBZgxoNqyP98KuBJlRsz7uXpSOveJFzVaZoJ
         fOrVUagA9DkCYpygc0mDcJ+h6oQGB8zqQJiUVql+bpcVkkZwqRH5FnffLtooTqj7nnqX
         7ynUkMfRaoomdxqwCG4SqTfqwAolcBuaQ8JHP0wJgcVrtuZtHotwg+HE9rnp0TXT3wTQ
         O1h7nKJGRwvX7E4qVFUhioPJWLS/PIHebCo7LznK3DeUQ1eILBh+q/G3PkltajmOKfET
         EZFw==
X-Forwarded-Encrypted: i=1; AJvYcCVMqCjfhLfxXnAJMHBWqqxkVkWiYMQ82mUIaAkqXP6XLS0LsPOocFG7J7HKFA68fmm54YSYQ8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNG5eY69zxnzxn6465wJQQVf3AAJG9wPQJprUy3t3zlkzc5dN+
	XQ5HJJGrp3tIYGXVRjTL3dQYsgzqNdLa3/JtwIwfBaAPRG8+2rTM
X-Google-Smtp-Source: AGHT+IEn/jfDqMQDsK7q7/qwfV5WKnIMOMxYMjBePg4Wr+Rzhm5+yl620tYgy5ugCg+IK7ADXMBhLQ==
X-Received: by 2002:a05:6870:8181:b0:25e:1f67:b3bb with SMTP id 586e51a60fabf-27b82dcaf52mr10929771fac.10.1725846994635;
        Sun, 08 Sep 2024 18:56:34 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5982f09sm2645616b3a.149.2024.09.08.18.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 18:56:34 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v6 0/2] net-timestamp: introduce a flag to filter out rx software and hardware report
Date: Mon,  9 Sep 2024 09:56:10 +0800
Message-Id: <20240909015612.3856-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When one socket is set SOF_TIMESTAMPING_RX_SOFTWARE which means the
whole system turns on the netstamp_needed_key button, other sockets
that only have SOF_TIMESTAMPING_SOFTWARE will be affected and then
print the rx timestamp information even without setting
SOF_TIMESTAMPING_RX_SOFTWARE generation flag.

How to solve it without breaking users?
We introduce a new flag named SOF_TIMESTAMPING_OPT_RX_FILTER. Using
it together with SOF_TIMESTAMPING_SOFTWARE can stop reporting the
rx software timestamp.

Similarly, we also filter out the hardware case where one process
enables the rx hardware generation flag, then another process only
passing SOF_TIMESTAMPING_RAW_HARDWARE gets the timestamp. So we can set
both SOF_TIMESTAMPING_RAW_HARDWARE and SOF_TIMESTAMPING_OPT_RX_FILTER
to stop reporting rx hardware timestamp after this patch applied.

v6
Link: https://lore.kernel.org/all/20240906095640.77533-1-kerneljasonxing@gmail.com/
1. add the description in doc provided by Willem
2. align the if statements (Willem)

v5
Link: https://lore.kernel.org/all/20240905071738.3725-1-kerneljasonxing@gmail.com/
1. squash the hardware case patch into this one (Willem)
2. update corresponding commit message and doc (Willem)
3. remove the limitation in sock_set_timestamping() and restore the
simplification branches. (Willem)
4. add missing type and another test in selftests

v4
Link: https://lore.kernel.org/all/20240830153751.86895-1-kerneljasonxing@gmail.com/
1. revise the doc and commit message (Willem)
2. add patch [2/4] to make the doc right (Willem)
3. add patch [3/4] to cover the hardware use (Willem)
4. add testcase for hardware use.
Note: the reason why I split into 4 patches is try to make each commit
clean, atomic, easy to review.

v3
Link: https://lore.kernel.org/all/20240828160145.68805-1-kerneljasonxing@gmail.com/
1. introduce a new flag to avoid application breakage, suggested by
Willem.
2. add it into the selftests.

v2
Link: https://lore.kernel.org/all/20240825152440.93054-1-kerneljasonxing@gmail.com/
Discussed with Willem
1. update the documentation accordingly
2. add more comments in each patch
3. remove the previous test statements in __sock_recv_timestamp()


Jason Xing (2):
  net-timestamp: introduce SOF_TIMESTAMPING_OPT_RX_FILTER flag
  net-timestamp: add selftests for SOF_TIMESTAMPING_OPT_RX_FILTER

 Documentation/networking/timestamping.rst | 17 +++++++++++++++++
 include/uapi/linux/net_tstamp.h           |  3 ++-
 net/ethtool/common.c                      |  1 +
 net/ipv4/tcp.c                            |  9 +++++++--
 net/socket.c                              | 10 ++++++++--
 tools/testing/selftests/net/rxtimestamp.c | 18 ++++++++++++++++++
 6 files changed, 53 insertions(+), 5 deletions(-)

-- 
2.37.3


