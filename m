Return-Path: <netdev+bounces-97450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4AF8CB7CA
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC63F28500F
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A16152DEB;
	Wed, 22 May 2024 01:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="saqV4sGy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A6715279C
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339693; cv=none; b=pAr+HEKs2SXey4TuOgRBFS0qmkN+qaxPTbmMKzYpbw+qSRwQKaoM0SJp2nrJixcOjHkEa96MoSS3OACAL5YSoHXlD/znfdsB6TtsLenVKGJ2nIh7zpgoEF1qvhYahquQ13kHFWzyMN4Owjwa7ouhT9/SDL5ScRFsegN2uInI+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339693; c=relaxed/simple;
	bh=fc5ZN12L8t4dHv2f+/to/VuuP376ryg7cLyfhK3bSMw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=euN1Jim4DImR2i996BD4FVNxyltMB3iyi6cXiP4DZMoImLy3wVWbzQYclwBzaDinY5u9d9B/c2ps+iVnTXaJB7y7Dq8okNNGSghjp7IgYaJa+pz6IiXvRD70O/rGFAcihVpL1JynIjwO/2AuvsjkeGGmZN3SRLUwQcEPA18k4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=saqV4sGy; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6716094a865so1695489a12.0
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339691; x=1716944491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hKqcMH+cHcivjSlV0iWazZDih52rI3iEBn71iAK9Nco=;
        b=saqV4sGypCV8ublpIPHkIG39GZA4akHNhGTwMOOcDiOZe7VsIlzmtg2mm1ewUNoNuk
         JAmUxeIcEtO93j9bd89eddfUzpgBZ93uylk9lk9zC6kPb65L+egjsNwMMmIrfIPIaH2E
         5XgBVoQwq9+KvLD+ykMHbOXoyq3bAnu/X+eG86AQ5Qf5hv1egS3jDwrTI+CGn+2m7EVn
         5Me8ZBIZJ+HkXLrS2KXkzziPPqwxAJ4z2S5GMrJi/463/urNB5Fy9eEstouzY4EcT6An
         9q0LB05OrReP9MobEelgEnnYjJVcQ7uczcYL0MCVzih9ya38p3Iu6NTYNNlHOFUxVimx
         tmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339691; x=1716944491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKqcMH+cHcivjSlV0iWazZDih52rI3iEBn71iAK9Nco=;
        b=lsRW61KMsL2SmsT0xz6kmG9fV2LKiTqgRFWCRPZFZex21VJRMfsl0fTvgKIgptNsJL
         GaYSlmYwTJYfIAV2oTxZubQ/RWtzJiqiyNy9WGXo1YgQp+7pne3gNyp4aLoPpPxO99RY
         cMt6ffE15SNDNuywIFqJNUgvRO7v7C3y7gzmylP3OKELSqoXO6oYvuHwFTCp0KzHFSS1
         jCmXPZfKzH+cwQkWS+dsuPKSf+IPxKzhL7wCyPqLs2ZWsWnj0rf6xLhF4cFXoh/ljyjF
         mphCb6y9cXunQ4wDF49IodZcCPbWB8CUVPLA43LpsMY8gLNq9XLqPAO2urN3agnUmzsY
         Vr4A==
X-Forwarded-Encrypted: i=1; AJvYcCUbAqVlmO5AQj8GHLFtsA63NZNS3bglMNKRNcYoM4TkimImxihYdj6XmIl/Gbctte7CkXA/ACYhBpceMydalfCVn9mionzc
X-Gm-Message-State: AOJu0YyxxnDQFYg8qG1ej3oS3Hb1B8Ds0BKUcZoiMnRQUC1gs6Pmpv4i
	FDa8fXoAnWGUvFWwDZRze48t1KdYnQ5G47qiaCyZhTWOxRDlxddBS4p9dOHciEp00fpojZKY6WC
	q7A==
X-Google-Smtp-Source: AGHT+IHEdlPEV5C7CUmVhgzYSyvdP68FXeZPwJi2pFA4aRhZIMBKvPNDfPXTnCO1F52hvMs38tuZRBZ9qyk=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:3715:0:b0:623:2c3c:ab09 with SMTP id
 41be03b00d2f7-67640145dbemr1343a12.0.1716339690894; Tue, 21 May 2024 18:01:30
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:27 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-42-edliaw@google.com>
Subject: [PATCH v5 41/68] selftests/pid_namespace: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/pid_namespace/regression_enomem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/pid_namespace/regression_enomem.c b/tools/testing/selftests/pid_namespace/regression_enomem.c
index 7d84097ad45c..54dc8f16d92a 100644
--- a/tools/testing/selftests/pid_namespace/regression_enomem.c
+++ b/tools/testing/selftests/pid_namespace/regression_enomem.c
@@ -1,4 +1,3 @@
-#define _GNU_SOURCE
 #include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
-- 
2.45.1.288.g0e0cd299f1-goog


