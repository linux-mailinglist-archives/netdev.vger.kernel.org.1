Return-Path: <netdev+bounces-95228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA8A8C1B4E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB1E289EC8
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357DF13CFB9;
	Fri, 10 May 2024 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SFWpUj6W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C16013CF81
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299893; cv=none; b=XrvAC0387FQzpAIliT2sN04V/FRvLZIi1hJLsbNk9vk17nxTnNkUL8V+YJGgUIGBIJQWvMMjm19JpnHM9vkTflJt8G3Wxv6e3S0n59G/bHa/ODwGm4Zh8RQl8XbYIKNKjpG/OuMu3L8UG53RQM2xSoFfzBBMFDMQK9A3oRLPnRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299893; c=relaxed/simple;
	bh=O9xtfbgadu/p6ddd8avwApWGZ/0YxN3sdI3PLHa2U58=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tNNI77Kz5P263+EJbqntcsdNK3JXTrA+gm1qV+OV6/FNYxlpI0Y3qbHKJazEt1tDzAJycuwHpw5/cv+kgySC58BNpTkfReDg/XcF744v7YjI1xjEFjWB1uOr8D7gooCtfL7dq1EVXz2RdcToEPdpr0LAK0HTxvrRlnz+UzoIDSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SFWpUj6W; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-61a9f6c869dso1246545a12.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299891; x=1715904691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gqJpZ06+qwlYgGDMURIHtEZ0g2cp0HVan8txW5tNeCQ=;
        b=SFWpUj6WWfbw3A8k4RFiIDVrNWTpBR2S2RTocthdnIen6kdt8R6p1w0GMqioyiOb4e
         eb0UibyhDQK9N52ncUqXHD9jeV0hvOar+jEvk8IoWHlw2tWAbN3qnT4+4FQGHfRcAC6T
         g5IwiQ9wulAz4gLRnTpkIZZj42XoNU1Ec5z1BYXOCfHeEsQq5FtJaRzXFdx9q/5Ocn/y
         ZcMDupm0AXqb2P1oYGV7xNdBAtk8CDO/fM+1w96ZN+LRliq4eVL5MAG+uGOEYsrtfEay
         XNqwr7DFfwUV2taPycuctirdq83ywE4EgfVodHP30l3j8EuORB/R9GGhVLxrL/T6y7MU
         PcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299891; x=1715904691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqJpZ06+qwlYgGDMURIHtEZ0g2cp0HVan8txW5tNeCQ=;
        b=MrnPU5XOgXU2FWcJ+HdIlvs5MlE4btOKK9+gQWD1j3euypNk/IgbL/rh1kLhG2jhAv
         ysI5Ukn2daTkcQTKM2nqZZkV6ssJBz43nlFdX0tL1/vh4NhUlGW7vbLtZuTc8EpOd346
         2pAOqDloJ+fOqDwKv33oB19/5c+FU2QVS0cO3AIoWo8bHVshhz1jx5E/D6sFBsbEXXtu
         sj6F+pzVI7znA1A8U83cRlLtZug1pKvcZI5BEEZkecT+Y41TtI0/3riOzCOkbNFmxANa
         comaNjojN2S9HgQpL3Cj1lUUmDmGVJwxJFLZPjBXsiV7nBCyjePhnxDyE9cNSHN9Us4n
         +T/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrSh1zPhqRXAEfytsrwNImGBvh6gqFdtTwdsjj3twZrRq6LPmwZT7NRe5cSo+wbmUVRhzj3uDUoVSR59OaLBOnynxfEXfU
X-Gm-Message-State: AOJu0YwNIBEtKnuO22fus4BDtyk7UMMz9UH6vkTvgeW+xI4MrFh1fz+Y
	a9wGHb6nv9UgRiSKBjp0KXRVJGRf3AOuVClSiG2b6WmkVWdRF9MWLe9qcNGtjtdCPosGjx7Iq6z
	apw==
X-Google-Smtp-Source: AGHT+IFvnYt0ucR3iNwRUDByJjohutRzVbgCY1noF4/O8GrePk6IXOBinafk3bQLpiFMVdhzNUfEhUzwTzU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:ac02:0:b0:61a:9ce7:90ea with SMTP id
 41be03b00d2f7-6373f599e9bmr2257a12.5.1715299890660; Thu, 09 May 2024 17:11:30
 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:07 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-51-edliaw@google.com>
Subject: [PATCH v4 50/66] selftests/riscv: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/riscv/mm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
index c333263f2b27..4664ed79e20b 100644
--- a/tools/testing/selftests/riscv/mm/Makefile
+++ b/tools/testing/selftests/riscv/mm/Makefile
@@ -3,7 +3,7 @@
 # Originally tools/testing/arm64/abi/Makefile
 
 # Additional include paths needed by kselftest.h and local headers
-CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+CFLAGS += -std=gnu99 -I.
 
 TEST_GEN_FILES := mmap_default mmap_bottomup
 
-- 
2.45.0.118.g7fe29c98d7-goog


