Return-Path: <netdev+bounces-92660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA19E8B834B
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85301C223C0
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12CA20010B;
	Tue, 30 Apr 2024 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4eHiHkw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E57A200100
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714521101; cv=none; b=qUBdBtAp2Gem6OOMHUG8tXJYWsQquOth3dpc7s2ZWZgdFV6IjDtRFscimOkZ/RR21q/6tLDPLklb7sc9um40fqegSgjw142gRtx0MbfjEtXr9lVAHzxVWW3cmsGw90KoZTQY8nexq2JUZKsbJY0pquql1AZnpw+JGwFU3Y7B5PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714521101; c=relaxed/simple;
	bh=D4RXcFdCF4K+k0y+RB2kHekGy6icDi6EgmaQjDFUewc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B71JUUdKSiR6s3BUXbEBe4QLh9sKgtOGZHMRXZ0XQiShxCeXSodVJcWEB09RCPOpfU4jZ61meUkiWglbWPXjW5j4GDNY7yfzT3aARgyj4YKcn16cI0OQAv0Qv5OCiD1aORgHfqhqKtfVSIUYU6Z+s3/TXKA7rfUqDqRQfNTMhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E4eHiHkw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5f803c1693aso6805779a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 16:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714521099; x=1715125899; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D4RXcFdCF4K+k0y+RB2kHekGy6icDi6EgmaQjDFUewc=;
        b=E4eHiHkwXmvT12PgrwpkLzPfIMhZGpB3yEvGktCAQKQH6AKioW8quzwUuhhSyDxFZR
         VmKVZInAwOBKM1K8T7euqOT7vR5Cz07O1Ni4Stl26Q7Z6PkPheNXxo599djVYQ7J78S3
         Mmn6BK8j8wTpu/+qF98hqBQEexKvH+4J+nlfVAiqjP2jLqY1lLz67BumekaGoRM7OSua
         QhuUYS/ToDjvMxZtQLppXyPRMFsqXTk/lHzIpPjSVmIJ2iQ0tkJUOpKn3A+flaE9O3/S
         TawjMnEY35uvA42rTFhhr9mlzSFyVLBsDetcwGxvUTfF6c+zL3Nf2SSTYaJ4SBoINu3q
         A1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714521099; x=1715125899;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4RXcFdCF4K+k0y+RB2kHekGy6icDi6EgmaQjDFUewc=;
        b=eFf5r23fPw3MN28gRztR8V5Ztk2F4HQKAxqU8XQGiFFRWXHJqk7wqT/MyIzyQIJJTT
         wgdzdnKmYMfWibDPK2Zf+9SImbe68r4WmCBJPzh9UHEqOn6FueOd55mnwfNDmKMi1AJA
         ZiR+xgYDNdu50u3ztGZme7tSJItVudnkcDrIKvJ43fmzLM8OePALf9UkHT6Xkl2BssU2
         O70wzBO57yHUI+SQXkUa4z+lCl+5VjRbBJvyJqWbsCI4Omt48iQBLMeRVq8Be1IH3qao
         ZzbGE24wXg3LfP9tEXudY8n6xWYMHJczVnxaV4DPKHLnYhuh1ysIhSJW0WmuWIo8K3QD
         FBkg==
X-Forwarded-Encrypted: i=1; AJvYcCXN+VdoBQyp57leMd+EM93l7N2fhDm9mqvTqaJDac6guoYtzY9yku0n8tMvnbeIkwu9iZu5Ig/aKWq/Z+f1dtSchbQmD5Gc
X-Gm-Message-State: AOJu0Yx+qIFvTlenY4wC4cyN7omiMubERRf0I3c3vxYgDCzSTmx8PHEz
	Q4ygS9AxAAKiQ9FscyifA06PgviZ7CSV8R/cQqT8FVHiQUfTA8d2nZ53b8YT2XDCjGCQ016yxQV
	I4g==
X-Google-Smtp-Source: AGHT+IHFexsRWV/l6g61+fcJ1FS4On2NzfgmRGaO6qc5XtBy09A9jgk6syIBuUu/8hQIpY0RuJdzwtz+xEQ=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:696:b0:5db:edca:d171 with SMTP id
 ca22-20020a056a02069600b005dbedcad171mr25940pgb.6.1714521098807; Tue, 30 Apr
 2024 16:51:38 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:50:14 +0000
In-Reply-To: <20240430235057.1351993-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430235057.1351993-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430235057.1351993-6-edliaw@google.com>
Subject: [PATCH v1 05/10] selftests/nci: Compile with -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Bongsu Jeon <bongsu.jeon@samsung.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Edward Liaw <edliaw@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-sound@vger.kernel.org, 
	linux-input@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
asprintf into kselftest_harness.h, which is a GNU extension and needs
_GNU_SOURCE to either be defined prior to including headers or with the
-D_GNU_SOURCE flag passed to the compiler.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/nci/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nci/Makefile b/tools/testing/selftests/nci/Makefile
index 47669a1d6a59..f615f5d71f7f 100644
--- a/tools/testing/selftests/nci/Makefile
+++ b/tools/testing/selftests/nci/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -Wl,-no-as-needed -Wall
+CFLAGS += -Wl,-no-as-needed -Wall -D_GNU_SOURCE
 LDFLAGS += -lpthread

 TEST_GEN_PROGS := nci_dev
--
2.45.0.rc0.197.gbae5840b3b-goog


