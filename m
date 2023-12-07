Return-Path: <netdev+bounces-54902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145EA808E7E
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C416B209F3
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 17:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6E6495CF;
	Thu,  7 Dec 2023 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="nx++SQsC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391491709
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 09:21:31 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-286d701cabeso1153363a91.3
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 09:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1701969690; x=1702574490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l7PKKnQAo+O5VfKxYcWMt1GuL35++NrWKFyJq+n/Luo=;
        b=nx++SQsCXuXli0xWMCiaib2HNKeY6INBowV6WrOtUT4GwvRRmw8qmnnXy30NmfLW+D
         L30Zi/Lu+8Fj9Bu/aQbZda7TEI/SjY34d9xnUz81rz5Rv2RwYHXdLLqDj2oxv72wZtCo
         B+jsw/IXQPboVDVI7xr5SaTlXGEt6tENd2CnHXWgEE1cbeyQHIqT6iyf6WHv2hXBlN+n
         6PUzv9pzwWnWw2H3otcSgiE6KLlUYm298oD6R9PCjzHTCmT5uovxuqGNKWYnMoQl4f3o
         yl2w12tHEewUGSVvkosaUNeQU0JrZURLJiIS5YDN5tkhRsrcdevLwiry9SQG1pnHehM+
         8WbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701969690; x=1702574490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7PKKnQAo+O5VfKxYcWMt1GuL35++NrWKFyJq+n/Luo=;
        b=C64YYobXNdQtW79FSvAue+gFzCorBDqtz3DyrHmFrNCcNyUmd4436HwTJ1UwfboiAC
         g5aedZPR6whxTe2DvPWbXLRi9/V94PVZeHEZaI2oR42VAq6DpFQYAG/pKD9OPvL4LH4f
         cqWfqMG4FntOqgLgstdIC7vW055DDoT5kuQJ262o29NytF4hDW4qNY+4jRlNedEQeMJ4
         2yP/ZvUMmnGMzgZOACBZKRNFE01yP3XxRaizrEoxxl77Dv3spYBSJIFUgSijVfse7rO4
         pX4VT4A50ENz0JbYY8GfeLbqjHLsvNVp8RxjPVAQwCxz6ROaJAhztOmo5vhc3gfX/hwB
         cCqQ==
X-Gm-Message-State: AOJu0YycFHISBszRM7RHgUSe8WJVMSyKojCyN7+qnquB8MjfMTaCumPQ
	UiRMTM7UoDTLWaylgvohEdxm8w==
X-Google-Smtp-Source: AGHT+IEEeNUSouVasCkesfqX1CbVKV6NgQ9SDcehgwSpY7xjHFAPIE9OeXfz96rWBOgU0pY2WenmKA==
X-Received: by 2002:a17:90a:19c5:b0:285:81a9:4fb4 with SMTP id 5-20020a17090a19c500b0028581a94fb4mr2922210pjj.28.1701969690617;
        Thu, 07 Dec 2023 09:21:30 -0800 (PST)
Received: from localhost (fwdproxy-prn-117.fbsv.net. [2a03:2880:ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id nb11-20020a17090b35cb00b0028017a2a8fasm160696pjb.3.2023.12.07.09.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 09:21:30 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/3] netdevsim: link and forward skbs between
Date: Thu,  7 Dec 2023 09:21:14 -0800
Message-Id: <20231207172117.3671183-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds the ability to link two netdevsim ports together and
forward skbs between them, similar to veth. The goal is to use netdevsim
for testing features e.g. zero copy Rx using io_uring.

This feature was tested locally on QEMU, and a selftest is included.

David Wei (3):
  netdevsim: allow two netdevsim ports to be connected
  netdevsim: forward skbs from one connected port to another
  netdevsim: add selftest for forwarding skb between connected ports

 drivers/net/netdevsim/bus.c                   |  10 ++
 drivers/net/netdevsim/dev.c                   |  97 +++++++++++++++
 drivers/net/netdevsim/netdev.c                |  25 +++-
 drivers/net/netdevsim/netdevsim.h             |   3 +
 .../drivers/net/netdevsim/forward.sh          | 111 ++++++++++++++++++
 5 files changed, 241 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/forward.sh

-- 
2.39.3


