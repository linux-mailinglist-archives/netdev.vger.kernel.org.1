Return-Path: <netdev+bounces-95189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D26458C1A82
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86019281DED
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4384650289;
	Fri, 10 May 2024 00:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R16Snepy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777F50249
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299783; cv=none; b=ObNH/sMc3TwvceJS0uDakzPgANwVBEM3Sd9aWyrF10LaD4Qh+HPWCCAPDEl+Ql165gEwBFsIlrgDCvWPSwxoCedXkMH+LPrGM+w22LdwmPNoEmk3VXj+8Ke6P3CO50gkUuz1Z2YmksaVLlf0/mnBgqSt+uIYPaa8KXJ7poLKew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299783; c=relaxed/simple;
	bh=Rme/FwwRvBvdmdI/vJaUL+zeOySW/SKvYL27MC7RJ28=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YiVEIPpNl8y4OAzHg3xcWVUTG97DM9KGuJBGirI6Pp2XIUVx1pF0T9E+LJn+AYZovqJxZ8hPrdT8+pkPLGGeI+Udg8Sq0/AgvwStfH5Bim6HwZAWHZD2LXonAwWOozzAKT5LMRghtJgOH5wAuFupO87R8qgrJ6YJIwLDj33HpgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R16Snepy; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-61c6560f50bso1310222a12.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299781; x=1715904581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Foaoxt2LsqEx0FNpmHVxEqBBgl44UXJZw/CQ++lOnVY=;
        b=R16SnepyUaE21WATZg1cB08zNygA30G0PKTCqFNOFhAw+xVGCs02WC5PRmgR35+tog
         8mCWfIZLK4gDnpqDFIIkPOyS3zoQ8TQ4AAww9IVuENcLVwTfNzvyCBvDp5NXMFrTpv/S
         GSf1sWPz01zDHlQSYj70KpnCrVgvyIFVtrUyk60/t/Y5ldX7GoApn9T8+QLXvD8DkNe6
         apz7ehToHLm04w2Ik1rlzWSS59OjvYK/AhsKXkxE/sri638495sNx1OI+yYiZrKyX2gr
         eNpBUzFYhd3H/pk9NGzk7oowk4Mftm4xPRuAVk5WQMFoy8IUbXICtIyVYz+v7P3q87lv
         n9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299781; x=1715904581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Foaoxt2LsqEx0FNpmHVxEqBBgl44UXJZw/CQ++lOnVY=;
        b=ISMpbbTVPvUtmfWgIDcHQwSbD8YLy6f4QrCOmONL8oZ7dFN4Oau6cBsxpeS9vgxJao
         Y0pCV3Hmg2jEt5ojfgpa/F6p1AkT9eJxZDkLI59986SZ9tsIQHa2lRcuzXATNinKIJz8
         DzeLzmGzv0L/L3u8ETThBbwFy1M71dFs2MahbtzgcPcLpc5vlE59oZv1JHekD3ox4nWT
         dyVMqT8wDkji7RjDPNGpvNeXk8CxjV+X3JafcKoqfgTwgEMqEVhbdSXThjtNpZ/6BsH8
         Mw7xV6l0bsiOuYc+zISSxEYJDKEsuLXp/OCsHjvZ6267ClVFDxWtzFEGf6KGRETF0Xld
         hhjg==
X-Forwarded-Encrypted: i=1; AJvYcCUL8s2vNFctQmsNP0eqrsWCIzBip/Uq7FyM3RKbReAz5TriYMxqL7XWf2inVyUQ74XSeXU/2QB5fxQSW41yvi/o7XUgwjIh
X-Gm-Message-State: AOJu0Yzd6ezWIVm9bSVYr6Cx4Ls7xjbuRMqW88M/7N0xQBvo3C/4Anfn
	yNc2zT+s/fYOtk8k+hVydf9N3iq2iJ56Gcjh4MGWZAt9rVZpK5jecscoIdH0om14pifbGv/C5p5
	zDA==
X-Google-Smtp-Source: AGHT+IEm5G/jrY5wOaZzHkYpeq55oHRTRUR88LGhzE/OHI6ZzZVTBGHmSZq33Ya+XerVfw7CYTWDOUxIsn0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:f87:b0:61a:12df:f5af with SMTP id
 41be03b00d2f7-637422d6fafmr2041a12.7.1715299780987; Thu, 09 May 2024 17:09:40
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:29 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-13-edliaw@google.com>
Subject: [PATCH v4 12/66] selftests/drivers: Drop define _GNU_SOURCE
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
 tools/testing/selftests/drivers/dma-buf/udmabuf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index c812080e304e..7c8dbab8ac44 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


