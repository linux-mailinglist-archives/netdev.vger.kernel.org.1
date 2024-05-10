Return-Path: <netdev+bounces-95199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0098C1AB5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940BE1F216EA
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DA412DDB2;
	Fri, 10 May 2024 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1AorH5/z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560112D77B
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299808; cv=none; b=jhSJ3WPJZJLbdWbCVLvJE+QZkkCd9rtmuc2LyAJyWd4auQ1/pze4D8XIPHrO1mZkuxWZz1NqKfdOLHrcSPqqCj9m02tp8TepdpWpL27bWCTw2ZpecE6suJGGU9RXDzNSDhtfyupTSU6XTTrn4xQIAMdaC9qNqZcTr2LlEz5wUGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299808; c=relaxed/simple;
	bh=lWLGmZvaxA9RBlByfmCfZky8EH90Zb+6S+z65rzDbew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eLlTACoGaPBIKA72YirHoT1cr3rJ+DfF/S3PS/YqhLtxjIGaj8NTNLCt9BQFo4Sz8ZjzTmO99m8LwiEgpw3WkwvS39fanO14ni9dOuJLseA81upsYOuQdTRVX76LgrQxGrhEeZfS6SEcAXMsSpRtRgMe2t4zvWJY/iBz31hOZuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1AorH5/z; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b62207253eso1289320a91.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299806; x=1715904606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hWPJomGop1o1vSO/WNR00I+KyAYhO7ZfPBKMyVYJ3k=;
        b=1AorH5/zfBIsl6I1W3gxKFkFvY7wyCooqJQFG6hlCV1OXwpTFu/6U09DEID98vJPma
         xU9NFXQjSxXI6WO0a1xjKM1qepoi8IXetODmqq+8sq4SprNGVeR3BoxTU8FGGSLdfyPi
         65p7WGhUSoskxbXhvab85uzZULwjqGIFgaDgMM2hE+kFm+6CKKOa41TSsv09EEhR4z5A
         i5UpGLiiGyed3smL1sKgAtMmX1EwrLu8PEYYmcTLcD9czaKhgdLiSl5uf+FMOE4dLarc
         W1JoweJKBv49t0mQ7oN4Y/2oN4liyKljZsq/HGdu1is9niStZ4nqXzy/tUlZyuwkfBlM
         2p1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299806; x=1715904606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hWPJomGop1o1vSO/WNR00I+KyAYhO7ZfPBKMyVYJ3k=;
        b=iOJ0jNYxr2/msEvsOf/2FxD55yEW5JXlPQn/+DF9ppA6mAOdxq9pQ+S7N4W9v3Hngr
         xnp8/dXKnAUaZ3FnJPWh80dJNKXSUZiRGVvyOf9eeLgk70Yaa8k0FYVIN05edACwFxIy
         T2W7ooNGKYCPdKkCOVFzf5Td/b5P1vLlKGysYLMc03VJujtuyMx4NQQ+dSgM+X7vinAf
         osg/FIFJ4DmjKuGBdeA1YPD9KuefzP9w24sHIVoN5DA5bYd5w/O2F8Z+4FM1WWP8YK8q
         fZgopoqoc2xC3bJBYwGqoBpJrUcUf6WlMPOvz5DTkqNX6G8NPLQG9EyWFqnsuhma0PAM
         K7BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc5n4ze7OK8iVC+VS4depZspS3nLG+MI79chWbc9lfd9Id3beavjdIJXoIILLeBm4bg2GgMTrmjyp/rf9LqmjC+U+lcqQV
X-Gm-Message-State: AOJu0YyOoHa4DPOjJGL6e+fkTCEpzhx3vxqHvvXa0/g/zxRYfuaUOyvI
	f56qNSXaNdSuIXuv9daOzapH+IAdaLOrOO6TffnRa826KsuKfLKG5w01KUjlAzLwbBo37D3x9M1
	Eag==
X-Google-Smtp-Source: AGHT+IEKFRA+4ILvLn3PhPjtR9sP6AseSfyhxdQaYvOqTgra5Rvh/8biTFwGx5IN/9sytyswqGFZAsbivEY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:b112:b0:2b2:7c77:ec7e with SMTP id
 98e67ed59e1d1-2b6ccedd5b5mr2880a91.7.1715299805622; Thu, 09 May 2024 17:10:05
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:39 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-23-edliaw@google.com>
Subject: [PATCH v4 22/66] selftests/iommu: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/iommu/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
index 32c5fdfd0eef..fd6477911f24 100644
--- a/tools/testing/selftests/iommu/Makefile
+++ b/tools/testing/selftests/iommu/Makefile
@@ -2,8 +2,6 @@
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += $(KHDR_INCLUDES)
 
-CFLAGS += -D_GNU_SOURCE
-
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += iommufd
 TEST_GEN_PROGS += iommufd_fail_nth
-- 
2.45.0.118.g7fe29c98d7-goog


