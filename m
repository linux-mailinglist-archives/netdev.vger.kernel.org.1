Return-Path: <netdev+bounces-152992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2879F6897
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDE116CE64
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572DB1C5CD2;
	Wed, 18 Dec 2024 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MveLz4zd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF51B0408
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532425; cv=none; b=MsN9tODqjVmylvfMkKUnnhP3YVE5YY6OPcMBGgiRO5k64AoliMIhAncKpzEd8zx+vkiJI6DNTRbLkfWmcuQzXrEy2K9PSoCXIWu72PgHjvFG+D1Vsjcao7zAg4ASqh63qDt9MNdT/Sek6IOlE+sifmaEiJHnYcNJ5+jqdig+LLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532425; c=relaxed/simple;
	bh=I6sMgpSIbuoJgMruTv0D/eB9H9usJakuNH+cIDpJmG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YdO0mPyUMuROSkFf4D8di1aQDxT8YR33quWsTHqiy8G3ypCBf035LqA9gYWtCG+wzbk7pUrmYUxlqxK9ii6Sfmnu2X8NoYQlKZC6o6VJDVWwUQi4zTWpE+NYXSXXFVeZ2CzPOIShVoHWjNgXZ4YDZieqsWvylvqOLWKh8FyzEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MveLz4zd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-436203f1203so5956065e9.2
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 06:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734532421; x=1735137221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/6gQ9eYwKvtfY37kCvqsh+D1rqnOtVNpwd5npaMbTg=;
        b=MveLz4zdNXPKwdzfVrbXg5o9WEBdiKePSZKfDopHXse6nvi0asZ5J3Oa8cKukOcYex
         lB+FdAZXIR6qNhlpsUuw7W6Hihj5WfTbwQKyphwjhaI1c97q66skhFyDQNUvcNK2ZR+s
         Iv2sFJpmc8Rveap/dcmh02uFS6h67T0xD0WOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734532421; x=1735137221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/6gQ9eYwKvtfY37kCvqsh+D1rqnOtVNpwd5npaMbTg=;
        b=mA0p0SAh8MuiF+59+DRW6mnH6VQyxAcFgEnQvSrf+Hb2dpGz71cmxyJwHFMD6Jc+4Y
         lsF/3UJy0rtFdXLTUlWuU5mmjLNufRyWzPPvdoa/CVHOJNcjMdZBSWrs09soSgQLQoHY
         5Q8JusNyBln4hRYXfSjsX3sXKG1BTC4fFWizALCtvW7CCsrQ3bwzOTGRgPPtGIwm5xtR
         rl12vFfpkXXXoQgIrynbd+vMF9hjSMwYF8HKx6ejLOdvvAuI/xMrSdhKcxRuYCUV07N2
         6dOOw7JuxbESbCdu0uZoRfDRQd79RxC7GqJyjgvGidFVLFwmexAurNhaRjuO9Cy5d6pF
         x6dw==
X-Gm-Message-State: AOJu0YyXlAEmJNX2t4O2asBhz5WyHI5JSxbdkq3lwBXAiA//GGAHopUC
	0FiyXqFhzuNdUoFGiEh8eUEReiS6iCzAQ4wco7qXRyBJjdEwPlsz3sRDEOEz5+5GrMyGnj+CfjE
	=
X-Gm-Gg: ASbGnctbNIncx+QX0EZWm9QJcc+KbMdXNSRn11xLUO3Ulek5dVg2o40OjxAHKsSdhze
	SOyQLp5GuYMZV2hP+bfC5K22uFH/OCk0l2+Pa9QH3Gb3ekuAGS3u/odYcuO4sN/JBSp234o6QlU
	84NZuHQVkV/MSNxrnpvfggXjsepD7lN+zyh2aTg/qW7Zra5TVpcMV8rhdkqcebc2m/A539nqLMX
	x3uCGVYxnbPzx54eq/8QGpGaQ/3F0dQg61rsLZSHqvTinsPHRdVh5J+6kTJigdzlmWFDpl6
X-Google-Smtp-Source: AGHT+IGGPRCJdWV53mqhJOMB8s5ih2sGtwEblpI26YxbPSheMfBs9kn94lS444i776WgijEWAi8uQA==
X-Received: by 2002:a05:6000:18a3:b0:374:ca43:ac00 with SMTP id ffacd0b85a97d-388e4d4b5f3mr1071325f8f.4.1734532421472;
        Wed, 18 Dec 2024 06:33:41 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:5f2e:327d:b9f0:a387])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8016678sm14188770f8f.27.2024.12.18.06.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:33:40 -0800 (PST)
From: Florent Revest <revest@chromium.org>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@amazon.com,
	rao.shoaib@oracle.com,
	Florent Revest <revest@chromium.org>
Subject: [PATCH net] af_unix: Add a prompt to CONFIG_AF_UNIX_OOB
Date: Wed, 18 Dec 2024 15:33:34 +0100
Message-ID: <20241218143334.1507465-1-revest@chromium.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes it possible to disable the MSG_OOB support in .config.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 net/unix/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/unix/Kconfig b/net/unix/Kconfig
index 8b5d04210d7cf..6f1783c1659b8 100644
--- a/net/unix/Kconfig
+++ b/net/unix/Kconfig
@@ -17,9 +17,11 @@ config UNIX
 	  Say Y unless you know what you are doing.
 
 config	AF_UNIX_OOB
-	bool
+	bool "UNIX: out-of-bound messages"
 	depends on UNIX
 	default y
+	help
+	  Support for MSG_OOB in UNIX domain sockets. If unsure, say Y.
 
 config UNIX_DIAG
 	tristate "UNIX: socket monitoring interface"
-- 
2.47.1.613.gc27f4b7a9f-goog


