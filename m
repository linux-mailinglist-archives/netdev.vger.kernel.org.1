Return-Path: <netdev+bounces-97436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7868CB782
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B2D283356
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170662594;
	Wed, 22 May 2024 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQ0ZI31+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481EC14A093
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339648; cv=none; b=cD3AZZ1/g+x0WI1r8kI7Qwg2prsJuwTp28097ngoz+FAoxYC8iV9CukdVxR9NP9gCc7EabWo1dmXRVmsivQSU8XPdnFeMRur98muk6DBCLneuvUd7I3rhkLfP49ClemQx2zy+AUk8H4C66ylglcT8mYkK8Q4vihSVVYuxViUiwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339648; c=relaxed/simple;
	bh=oZHnJqF/9E2YIXhg1q+wA7AGZkR9jjztSz586c2e7v8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Czj8RxOexgh8ZrQ82gLPjQvpCKO6i7NiXVXnprgCbQvZdQwXsk2S/VipEj5lOIKm2B1Z520j8/TNuIJjnjqyPLLujyuoOYyxz4ky1emrxZwompkyDf7DuW6H8aQod74LREA02Ps/d90aoBF6fqoTlKE9ViZbOmtxPeqv4o1srZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQ0ZI31+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de0b4063e59so11933031276.3
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339645; x=1716944445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXwO0L9UP+8QZMVBOIJm+VyqQgH3dRfMq6r9an6EFTA=;
        b=hQ0ZI31+PI92Wa16vTGi4Z6AmTRZGh22mi3WSbUCq/zybAnHu+iZ7VaKwAufsHWghw
         bb46FOzo2TGGucsuxtAljSeGj0/GCmu9vnOlW7+FHAL6Epw4vx3UN+uh8DcUCYvkCxMs
         fcyqk/r951weiedysZUn0GeXkphXWJFri773ocZL2cBrsmpSGLeh6JfbgvxomqHFxTbK
         vfGGhRPt4klpAigLPUnzyC7ePmJE8FjmGKYqBMvotsP3+ReEkgNXAqL4i46ePBSq+sf0
         9mUM50fDQhW5qg9g7iWFzdF1rrP/iWsw6E//SPuHsCbRBwrDLTIY7E+KnEmJRjlt/big
         cJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339645; x=1716944445;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KXwO0L9UP+8QZMVBOIJm+VyqQgH3dRfMq6r9an6EFTA=;
        b=hmX7mSnmkS7UIhnTTmexaz41Gjjp/F+TY/Dkk2duwh+R8OH9AvGCXwy8bL7ZJtPvVj
         IltXg302qyZcZ16s+TJ5pEjniN8LWTzaWrckDgN8aNKREv4P1fDLStMOZgSOPUVpcn1l
         2nrBWTUq4C4paZHQ/UcJSJePch1e/t7I8g7mnGxMWh3u+b9JMB9byYVgV/KSKwsPegAj
         3P5YjqQ7NcYt2JIEWBIxH6EJnI43gDFckzgarCXKJgpC/WnfbWFydXJHp1uxpopKaCFj
         aEAw1/FXmD/9lZ7jBChK8zbIhlLuACUooAwRvzpYjFeQizNW1PWCKn4wGRgcX4EZur2I
         wOZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE6RaC0kT2asK2Z4nJRM+nyiSLpZ3Illu6cwu8AvYtJWaVI7bI6pqfvHfe+oqCRhtKsLy9VDJE062FmbkPCOFZmwP4+MJO
X-Gm-Message-State: AOJu0Ywn00wrNb+uCP5S5lt28K5Gbt2Paa7lhaq9fHvJSDPPvZw0k5Ds
	2Ae0SHv4oU3YgD3tdTAfLKWvPkLCc19CP2klPjjTprEAkH6Ao4Gze5T9OPNWshkTVZk4g8CP1M4
	ykA==
X-Google-Smtp-Source: AGHT+IGq5EkCYZMZ8kSZUDy4QXD5Fy/Txkil5cxAziOoCq+wpprVpOx9voNzKq36ByPvzM1vyjQE12KOztw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1143:b0:dc6:e5d3:5f03 with SMTP id
 3f1490d57ef6-df4e0ab187fmr228918276.4.1716339645152; Tue, 21 May 2024
 18:00:45 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:13 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-28-edliaw@google.com>
Subject: [PATCH v5 27/68] selftests/lsm: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/lsm/common.c                 | 2 --
 tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 2 --
 tools/testing/selftests/lsm/lsm_list_modules_test.c  | 2 --
 tools/testing/selftests/lsm/lsm_set_self_attr_test.c | 2 --
 4 files changed, 8 deletions(-)

diff --git a/tools/testing/selftests/lsm/common.c b/tools/testing/selftests=
/lsm/common.c
index 9ad258912646..1b18aac570f1 100644
--- a/tools/testing/selftests/lsm/common.c
+++ b/tools/testing/selftests/lsm/common.c
@@ -4,8 +4,6 @@
  *
  * Copyright =C2=A9 2023 Casey Schaufler <casey@schaufler-ca.com>
  */
-
-#define _GNU_SOURCE
 #include <linux/lsm.h>
 #include <fcntl.h>
 #include <string.h>
diff --git a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c b/tools/t=
esting/selftests/lsm/lsm_get_self_attr_test.c
index df215e4aa63f..7465bde3f922 100644
--- a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
+++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
@@ -5,8 +5,6 @@
  *
  * Copyright =C2=A9 2022 Casey Schaufler <casey@schaufler-ca.com>
  */
-
-#define _GNU_SOURCE
 #include <linux/lsm.h>
 #include <fcntl.h>
 #include <string.h>
diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/te=
sting/selftests/lsm/lsm_list_modules_test.c
index 06d24d4679a6..a6b44e25c21f 100644
--- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
+++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
@@ -5,8 +5,6 @@
  *
  * Copyright =C2=A9 2022 Casey Schaufler <casey@schaufler-ca.com>
  */
-
-#define _GNU_SOURCE
 #include <linux/lsm.h>
 #include <string.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/t=
esting/selftests/lsm/lsm_set_self_attr_test.c
index 66dec47e3ca3..110c6a07e74c 100644
--- a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
+++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
@@ -5,8 +5,6 @@
  *
  * Copyright =C2=A9 2022 Casey Schaufler <casey@schaufler-ca.com>
  */
-
-#define _GNU_SOURCE
 #include <linux/lsm.h>
 #include <string.h>
 #include <stdio.h>
--=20
2.45.1.288.g0e0cd299f1-goog


