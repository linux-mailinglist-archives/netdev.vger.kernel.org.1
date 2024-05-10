Return-Path: <netdev+bounces-95226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3928C1B44
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C06289BA3
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517BD13C9C1;
	Fri, 10 May 2024 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3FScSGlq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334813C3D9
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299889; cv=none; b=NKZik1dN3el3rEOqM5Yf50a4+tow9eSzsttLY/uT5DK/zADnAsVXj7ZZ7m79BfWy71WSr80chrvXejTNb51F63ruFua7UcmVhOg5VRPwdJ2pzr9mhDVzRrWRPMv379wx30EMG46wlM2oaRbqhBpOEehUwGdaTLa9F5i8QubOUMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299889; c=relaxed/simple;
	bh=015fKGDJxCO3CrDnV5eDhM/cvgzAQ9buUgF1iz0PEt8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hXdFlUwHTgvJhBtOjCpKsxK+a9670m1T+CzHWTh6Bh0ivWNSaIXeWxrvuFeyD79iqW6HGaHrIxv+EPoGEXaJ7GNOaDZng0Mappk0VNG3KqYHLKD9mrpTy084FkX704uuCE32wkkVXwGzQDF2Y8IMwb0EY7fpZlV4rY8jrGMxnzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3FScSGlq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b1200cc92so22804237b3.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299886; x=1715904686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3uGp0w2sme3T3nV0EQqTopwZWuCKWdcvzDVr+VeYxCU=;
        b=3FScSGlqmDGcfC8JdovJbEM9EuhrxxRbsTWucnnH3JnVcmqLWqoTGpjJUWTrCQj5pN
         dztuS4/Oeo67IjVhlqfYEmTeNIWaxy7LGvqPmZZ8Guei9EprhaBq+Dcbi8iUZaKVcBjC
         WTbJULVDyrUTKyRGaJdty9x66E4DHllvNOuXKNWvcH1lk5ZekPnz8enrJc8zKdGox/SU
         3nconxKC7RqGHpBWoi7h3uneVkAAjbf0VKq977I0OxD3aRSnalEv8GQ6S7iLtC5x4oC/
         fbXU7o9Gi8i4fQVENs159Xma+qs4ITj/qRdllxCjEg+8lAidX9yjGdprfX+1enBNv+uZ
         izLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299886; x=1715904686;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3uGp0w2sme3T3nV0EQqTopwZWuCKWdcvzDVr+VeYxCU=;
        b=VOfAzDKrooYCIvE0NEtnaZ+oGjFg3HCYl21aw/AgVPI1bxiDFJqoNJOhWMfU2hxkwS
         W9FhK3LQU5Zf7PBOwysWaB9GUok/zFAROxGoTVNhQqOCMMq6a3j1XQathKsG51D/BgzL
         I7anPxuES7nxWhR+W+b7zSDlExjAjpiZtSd0C4NhIJ/Aq6de0yAC3UklVbuih6Nnrkpi
         OPG94MKRNWmSJFtR8BY+AmVJWTr7CTPBuwO1p3K3Hwe+tp88647dy6P0dIqAw/WX6mfN
         0UG32xrCDbshlx0MKJ21vL7XDTFfNX1q7Q+mFRrXJRUtzS2Yg9WTG3zCt8YKndUKoHju
         CWaA==
X-Forwarded-Encrypted: i=1; AJvYcCW79BICvT9TcOIN7hJ37fnvNguzsrVWIU/Rq1SSpaK3FOWFRlgSA5VTtL2CAXGyJp/2H2ID1sJPqkfTbIQxkecCPsaaw7HA
X-Gm-Message-State: AOJu0Yz3K0ei1VavBXTJxF8WTw1SqS/6SPPR1yMBmdR4jWmOquERtt/A
	9V+r985KDhXKfrYriG1+/BZebAvsEk+kASA9iXXiACUTGQ31PfjgSp5STRu3rukXDg4wWA4F+g3
	Iwg==
X-Google-Smtp-Source: AGHT+IHM1dFUhZApSrq8Qk43aou/1xK0czl+ZTNebJ0VcRvNcsT7MvbAdQNPHgT1F2os/qMJBLL/r7SojXM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:d0b:b0:61b:eb95:7924 with SMTP id
 00721157ae682-622aff8202fmr3114617b3.3.1715299886235; Thu, 09 May 2024
 17:11:26 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:05 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-49-edliaw@google.com>
Subject: [PATCH v4 48/66] selftests/resctrl: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/resctrl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 021863f86053..f408bd6bfc3d 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE
+CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
 CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := resctrl_tests
-- 
2.45.0.118.g7fe29c98d7-goog


