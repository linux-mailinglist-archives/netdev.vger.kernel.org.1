Return-Path: <netdev+bounces-97472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476888CB840
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03178280F5D
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B2215B57A;
	Wed, 22 May 2024 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usQfgb71"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E687A15B147
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339755; cv=none; b=urt3jro0Xlf5u3vQ2AMW9wRH5P5CwGBN15KrJIfT10ldAsBqEV0HDL+qw8ufBWT1Nm47CnxVy/9npdYVl1VWN7E+qkaouC7aW9OlYsrUrPYF6nSoUDDcYYjZDpbWblb8WzvRPAq8lUByS0oVVfcEG1ORv1wasPSOADJBD2FvwfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339755; c=relaxed/simple;
	bh=RS7rPE8AKloHG6WzPsTg3jpXH0LcLyLyrga22Zx6Vcg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OGcnv4svNNJE7Q6a8y5C8D0fHc3579p4IQjDVY++ILaJyy4mzPMCYaOsMid+ZmejNybtc7IN6vEG8IL/vRB0mKISfRIFaZ7FCLK/4GUixEBrZ9Ay88FR/zK2yyBcWqkm1RaFvSSlyz4roT9j2sK8+Etixiu/LyJihFHiu+MIqqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usQfgb71; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-622ccd54631so183410237b3.0
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339753; x=1716944553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxB5Ap62KVVuT4Uqpd1hkwJ0UXOFlpsGfFy42T0fhJ4=;
        b=usQfgb71T3STK152exlBiQIZrjlwDm4bMxjED0C53hFoJg2T3WHzWrGacmP+448v+Y
         guCCYaUTPt1n67Sag+1njjqoWDWdMoMMz7F75/EF5FFOxlX5NNiYJB6W14dnuEhSXRy5
         QTPUNvsQs0rhCPD+ZMijtPakju8kGwCmhiUKrj/uFbgwHlAGYrxTz5ID5vu8eJMPB+54
         Viw3uMnm3kshVvzrMEBCwYErhsjPC00VqKQI4ESh96WxRqcu0tsT/jdQqf84ejpZNygp
         IYRX8anZENkFv+87a5UeJ+JORFYylR5vaKyHMnJCXEtTQmUZT45lwXA3/YHV1ImSstXt
         NDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339753; x=1716944553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxB5Ap62KVVuT4Uqpd1hkwJ0UXOFlpsGfFy42T0fhJ4=;
        b=pbgGFuEPFKZSBIwAHv1BiKUlZFSeMqsQYcq2wP/1MYMwqXcAln7ZRVv2Kj9LpTjD/y
         8mQBEeE6xCSd3Mil1TGCOeQbMEM5pvtrfV4j7iVAgE9FsR0xZ7/g6O8KXUqzuXOAFsJf
         rHJ+RN2CArYee6vuP0T1leAv50F3TVw+NPHIHkh6+9Kn33UTSiFLBuze99Hh7EOHeAzZ
         948voeF6EZrh4QwzeVgpGLk91I1VHf6HFLHfrp+ZT1Tvd2CIkgkXbK/LH1KuTrRQUNes
         Jkujsx47lJ0cane9zT9tkbeTNNvGj/34kDSoEGhWxqroIy1RNzScM9grhiaUid2UCTVh
         G8vg==
X-Forwarded-Encrypted: i=1; AJvYcCXBUuYLRfWbA1QWnhDo5O78viYcZy9wtjuYktB4kwa+GnSD15DIfXe0zBvVzaQWXgont3UKI7JMts/P0MViqUBaor74N5rF
X-Gm-Message-State: AOJu0YzOMI1KlXZz4FwIGEUX39wMGad9wO7kGOhdzKOaWwzWfvcXhCjH
	YjBXnF9wRqCjJiCyJu27CdFl2c9nODbuDShQzudbVUPmzB7W8zrdFUJbVqope/AChQ/A2xyYJPR
	G2Q==
X-Google-Smtp-Source: AGHT+IE6DaOUUCz74vGUOqCerBQLQc2Nz00SvVsD82xkEGEYIxXJhZ7/jUS8DPdXT3VoOulznt1IlpyCyc4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:d895:0:b0:627:a961:1b32 with SMTP id
 00721157ae682-627e4886e1cmr1667607b3.6.1716339753056; Tue, 21 May 2024
 18:02:33 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:49 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-64-edliaw@google.com>
Subject: [PATCH v5 63/68] selftests/uevent: Drop define _GNU_SOURCE
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

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/uevent/uevent_filtering.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/uevent/uevent_filtering.c b/tools/testing/selftests/uevent/uevent_filtering.c
index dbe55f3a66f4..e308eaf3fc37 100644
--- a/tools/testing/selftests/uevent/uevent_filtering.c
+++ b/tools/testing/selftests/uevent/uevent_filtering.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/netlink.h>
-- 
2.45.1.288.g0e0cd299f1-goog


