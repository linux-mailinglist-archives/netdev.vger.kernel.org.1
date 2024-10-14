Return-Path: <netdev+bounces-135307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3821099D817
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3A61C23919
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6151D0946;
	Mon, 14 Oct 2024 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IUEuhh+V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225CF1D07B5
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937279; cv=none; b=PSWwUxH7eGozxNdFQBYaYpA2UpkpgK7clcBGfh5RAVxiY/oHkIvThX4+/hxgavzkX6ahh0NtqUgqeF9JyslnhDy9zEsgUb/2lIxvG+CrpmJ4e+QfqTUAJBsJ9lzK0LsV84wyZ6uVpC4XcCSUQ+Z2l+VuUAHsoWYpGGbr8kUHByw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937279; c=relaxed/simple;
	bh=7pq2JBwSbvwoKPC4gsLZcKVV9o4qGr2Fwj+RKLZ8SQI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T4doWEozXTehamUeTUjg1++za0ViwWnyNVV15hamEeuOoYnHBUgE2yzhIZs0chm0fwcs2+f++nJaBHYAHQOg1iGkklMXEmRQXblOW2zH6nrOfY6iPtPifrRFlfJA5wAsR0aGO7XjQOzs3MXIfHUG1oEtRX1SMksS7fckDPmpVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IUEuhh+V; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e32f43c797so40598887b3.1
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728937277; x=1729542077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MzBqN10vY8VhhlLnz9keyKFPDgMJzudnjn+Da5q0lh8=;
        b=IUEuhh+VMKW4TGHiXYHL2uXCw3b9N7PLner2IjqH8Jz+SiuqRqmhfyMbTWJLUEO73t
         uLxCJIKhT64XBcOlTvmNRbwxrFhvef/IZ6wiAXUspXsXRE7/zG6YOJimt25nI7+aIGsj
         tSo50LE/wMr6bsY2ad3kiltvM38ZLreiIos9pgNHWgklHk+6rACK5ceo3SvTmvtp/lAl
         l+aRIkFkxG2zwVyJYkChCxFeRi1qx221/erTg4DNmMV/36f0NdPRXfQpJ+0CCryoqaXt
         xdJrw7Ia9Pcolk6hmMJCen6wDxRR7WDZAu2m2u7rKvrWlDXfm+eNuIqXopYNq20kkoVI
         J1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728937277; x=1729542077;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MzBqN10vY8VhhlLnz9keyKFPDgMJzudnjn+Da5q0lh8=;
        b=kgg80SoK+8HV1z62uuPUkmu/TMpOyqavd2iWz6aks9xMi8M0/1fbuYV349mbb+KCXy
         cZZ4wFGbm60kBA94CeFud3HWytp+Jr54ZayilSUTi/9ONVqhv56dQMSJe2eDMX6cnnQF
         VmyQY6aot7uKNQLnphlzzedVdmuMYCg2zjNDubjQ0evGH2Kg98Y3TR6TBmkQduZtu1Bg
         FRtZ2vYck5OXksEPddWxN9B1seJ8TP59RLyCEzrHZai9C9+qGKKmL2XwhPDgus4UI+zf
         Lp/hXQ9t049IuKTnFhgW420Kgr4UjtzdveMXOh3o4r4ljLilHA7JoUAX4lfUMROyn9du
         0uvQ==
X-Gm-Message-State: AOJu0YxMlHsSoYOZtffr+ylsNrgsGgtdwAojLtEQeFI6+4zg2KorvATH
	/9VS65xEoQa6lYEqBb3uIo+Ym3Qb7wbglJtv8WpV9OX0ptfeJbhnz8oyI+CJqY7PSbbUrd66KO1
	g25wN6BIpbPQ3ORzCM/Gvuqe0qHpQPxgPqZb5/Fivm6lI0LaojzAkW2e0xQWFkeSWB/mZtGqkuX
	MUe468PjS6fID/MR2mKUNX5fMzOk/yFW3wN6m6w4PyUd9LjWfgtNyea6MRGALCGbKk
X-Google-Smtp-Source: AGHT+IGaSKteCozD1AxZXpokOKHf/LDP3W2fZEOHTURVIIwxARIQJHIRZqPV5Dhnly9+nXUcCT77HZWJSrxifqpXJO8=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:1ab8:7f2d:7123:f4fc])
 (user=pkaligineedi job=sendgmr) by 2002:a05:690c:2f01:b0:6d9:d865:46c7 with
 SMTP id 00721157ae682-6e32f2576a3mr1586797b3.2.1728937276609; Mon, 14 Oct
 2024 13:21:16 -0700 (PDT)
Date: Mon, 14 Oct 2024 13:21:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014202108.1051963-1-pkaligineedi@google.com>
Subject: [PATCH net-next v3 0/3] gve: adopt page pool
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemb@google.com, jeroendb@google.com, 
	shailend@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	shannon.nelson@amd.com, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"

From: Harshitha Ramamurthy <hramamurthy@google.com>

This patchset implements page pool support for gve.
The first patch deals with movement of code to make
page pool adoption easier in the next patch. The
second patch adopts the page pool API. The third patch
adds basic per queue stats which includes page pool
allocation failures as well.

Changes in v3:
-Add patch 3 for per queue stats to track page pool alloc
failures (Jakub Kicinski)
-Remove ethtool stat for page pool alloc failures in patch 2
(Jakub Kicinski)

Changes in v2:
-Set allow_direct parameter to true in napi context and false
in others (Shannon Nelson)
-Set the napi pointer in page pool params (Jakub Kicinski)
-Track page pool alloc failures per ring (Jakub Kicinski)
-Don't exceed 80 char limit (Jakub Kicinski)

Harshitha Ramamurthy (3):
  gve: move DQO rx buffer management related code to a new file
  gve: adopt page pool for DQ RDA mode
  gve: add support for basic queue stats

 drivers/net/ethernet/google/Kconfig           |   1 +
 drivers/net/ethernet/google/gve/Makefile      |   3 +-
 drivers/net/ethernet/google/gve/gve.h         |  36 ++
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c | 312 +++++++++++++++++
 drivers/net/ethernet/google/gve/gve_main.c    |  49 +++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 314 +++---------------
 6 files changed, 446 insertions(+), 269 deletions(-)
 create mode 100644 drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c

-- 
2.47.0.rc1.288.g06298d1525-goog


