Return-Path: <netdev+bounces-49828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A25F7F399E
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 23:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DA01C20E11
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 22:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8665811F;
	Tue, 21 Nov 2023 22:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePGd6Jnz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89601A3;
	Tue, 21 Nov 2023 14:57:00 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5bdf5a025c1so4041565a12.0;
        Tue, 21 Nov 2023 14:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700607420; x=1701212220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqLalMyfqwS29Jo7Kjmw4Rvhj33ZYdkwQdVPnwcenNQ=;
        b=ePGd6JnzpW3f8uRv183MWvBJkUk+RgKO2sEbagig7aE9qnKr1GcjpFNF/G1PhYY1na
         MRbyu8AynI2IB06OksyNIety/loS10aWCgYpNSBDjZNz3J8iJGC+iwXCt0TlgZd7mHKd
         s/JneKM6BHRsGHgGaRtP/aNxkcpkzj5cU6BWfXijSVyyO1LXA8ySjsLMNNZq3dVckebh
         4sPC46RxVW7dgX/IOMQTORrmmwl2SUVBrkP3ZiLPJfxOBRSt/dKYy9zdyuun21EVVEd4
         a2YUD2Zsf6F6riW9LlNPfKwXTulAOnu6mGp0CYZqOcTkNZlT7P9wskkNlJOSfqls1Occ
         lIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700607420; x=1701212220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cqLalMyfqwS29Jo7Kjmw4Rvhj33ZYdkwQdVPnwcenNQ=;
        b=T09oBqJe92K6xIzdJPZYCl+k+KwVW0cWWdok4TpBupW30eqPtF/dDYGuHKNgUfhlQq
         kSS8cKV6iLRt6Ss3nHB5erSsEaJBV/GGaPm+kxOnTZzemsUcD1h/3stoUTdo05nCIfZH
         xtJ25MK2AS+ltUSOqVT+iJ/25ftKGfQ2h/ou7+FwqWQFwSA9ttFyu6yTg2r+h2/bTPJd
         dUoTGQzk+6qqkEBTjUX5QxFaaqa7CKxTKCN9M40MtM5K+1UukJrJN+fcxFN0CnvSj4A0
         yGZ0/LvmJNJmoSzRMn6vXyCfLd+D/6EOq3SaXvXNmF0nsw7eaIuOMlRKsISi0UgJV7iZ
         YGQA==
X-Gm-Message-State: AOJu0YxggkA0J2TxgjHbbXbvO9l0dKEHro4vJYUvyMUHjsAhdH2qSLeL
	ZhJmbBfOM8b3Yhv2De6k0F4=
X-Google-Smtp-Source: AGHT+IGo6lnCKfaRn8i+090knqFd2fNc6dmrMtF/Jv8GyLdQW8Yn7o9e0cTeTmlcmLC08VGkdMcpMQ==
X-Received: by 2002:a05:6a20:e11d:b0:187:d18a:3163 with SMTP id kr29-20020a056a20e11d00b00187d18a3163mr545061pzb.48.1700607420334;
        Tue, 21 Nov 2023 14:57:00 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:7377:923f:1ff3:266d])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709026bcc00b001cc47c1c29csm8413189plt.84.2023.11.21.14.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 14:56:59 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 07/14] tools headers: Update tools's copy of socket.h header
Date: Tue, 21 Nov 2023 14:56:42 -0800
Message-ID: <20231121225650.390246-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231121225650.390246-1-namhyung@kernel.org>
References: <20231121225650.390246-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

Cc: netdev@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/include/linux/socket.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index 39b74d83c7c4..cfcb7e2c3813 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -383,6 +383,7 @@ struct ucred {
 #define SOL_MPTCP	284
 #define SOL_MCTP	285
 #define SOL_SMC		286
+#define SOL_VSOCK	287
 
 /* IPX options */
 #define IPX_TYPE	1
-- 
2.43.0.rc1.413.gea7ed67945-goog


