Return-Path: <netdev+bounces-95208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB658C1AE2
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B241F24EC2
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74A213440A;
	Fri, 10 May 2024 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vAdy8RqK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263BC133421
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299834; cv=none; b=s5Gb0hdyWCxklEU9wUQGKLJnTGbXQTY0WvKt1atmOlqJlUD/KgR9Gdi6VTLPVW0HtooL1CX4R3HVwYy87NxgP3OqeP+xR1GZujwAtLu3oalEjpCwtqp6YiH7CtgLC/TwBpzosQVyh6enHIQ9wDcdWqgNwX/F0kmB9r8cM/UdQQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299834; c=relaxed/simple;
	bh=CgsUAoxPLiPX8UXSGEfYBMmnWIxR3wtc1giA2eIVBK4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QRrMgZwSl/EJIjFVXcYSZvw9zlRuz6/jfpZ6rub4EQqjDrvcnInPB2ztcuwqxk4dZngP8cElEVN3HSTnXOKXzOSFCttxaGgxcii11zMqoS8b21FUDEwHrLyQQu5vsO24Xl6HImtwuRP4YtPbG0QS3iCPXttogKYRtf4DOQLHuJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vAdy8RqK; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ecd9a80d84so19380925ad.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299832; x=1715904632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YRD5r/wA6LFuHwfkjrFKP2eh4q2idhPkvQWQq1X7Wzo=;
        b=vAdy8RqKtA8cXge89/O9eEvRkV7lAN2DSHC+Ovo7RIJu7TqcajV4Ph8hYrALLfi0U3
         FolfHCtqg3ynsgB1EY59zlZIkKjYTrJS8MDH1n8fze3VLhACdXvUWhHrZIQkoFAd3Eic
         jxgl3Wq/CKMY4WdZBmcMpPqP++26e9g2d3BBbRVgmEmKtiBQBcfV0ivRVi2jcW0HvHAw
         Hqah7fKoJqPuSQbvuz6i3F/nlMB2id58nBMb86URfK9N1MTwAt7q5lYPcnN+Qe2DEmsj
         37ZPFKL1JZHnpSAgf+alogSdg2+LMu4gfGPgaD6aKRQjq1OBLZl3adiH0Z8AD5vFKMQr
         fZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299832; x=1715904632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRD5r/wA6LFuHwfkjrFKP2eh4q2idhPkvQWQq1X7Wzo=;
        b=OyK/2d/QwrRC/ElwWbxDXa9Nx87IyerN4Kz8fdSx6Dt+Su79aiYIoi/6KzTzmnGW9B
         VLbtkhmW2kxTVDRnhTC1Wa4lr4A1/EqWlFDnzOJv3zXw5NoZfbcgMpvNJM5uDFnPjdax
         DQL06HijXImPOerTUGePQ4mrTUj+TWHiMwupx4im8I1PZzXhYBidRCxE7IRDp/TrVXK8
         rco6LgnyE/N+HXZ6UuRggMB5BYoWkDWwge/pYBLkpMO6tvZ8ZnsueYXZBu9AGKi8WRvp
         jnRLzvBq78baBySwm2gpGCWHgEKnstVoTqb3TJoo/PnpLX8KTCvWKI/sG0uZBlL4uKxC
         LO+g==
X-Forwarded-Encrypted: i=1; AJvYcCXaYdaV2orTDdWSQeKUy96+tN9XC80n2/duBhzgHySC3EG024hDOz4/3zhMzQPE/FVa34qUJ+ngf/YM5CUJsD6SLw90Efi9
X-Gm-Message-State: AOJu0YzqcdSvPw/+8LG0jz8sVqZDVkVRqmuvFVcab8LJ3ySYUSVBNn58
	EgMg7vP9xPsCYltOcRONJFtaUVZWsS4LgRhTxJJL/B1EWPLmqlraPx/GTa5iQvhrMsRJzjirccr
	r8A==
X-Google-Smtp-Source: AGHT+IEDzJ9OdHaeOmAYQvvoFk5BGCHVLxfMsZPnMjHHpRLYJIvs9vIsDj5Z7+M16ZLAYicM/PHIiZdIM+s=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:854b:b0:1eb:f1fd:d481 with SMTP id
 d9443c01a7336-1eefa9e32dfmr121525ad.4.1715299832494; Thu, 09 May 2024
 17:10:32 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:48 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-32-edliaw@google.com>
Subject: [PATCH v4 31/66] selftests/mount: Drop define _GNU_SOURCE
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
 tools/testing/selftests/mount/nosymfollow-test.c          | 1 -
 tools/testing/selftests/mount/unprivileged-remount-test.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/mount/nosymfollow-test.c b/tools/testing/selftests/mount/nosymfollow-test.c
index 650d6d80a1d2..285453750ffc 100644
--- a/tools/testing/selftests/mount/nosymfollow-test.c
+++ b/tools/testing/selftests/mount/nosymfollow-test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
index d2917054fe3a..daffcf5c2f6d 100644
--- a/tools/testing/selftests/mount/unprivileged-remount-test.c
+++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog


