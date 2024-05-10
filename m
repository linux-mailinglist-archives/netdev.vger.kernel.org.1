Return-Path: <netdev+bounces-95241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE988C1B8C
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A6A1F231B9
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7901411F5;
	Fri, 10 May 2024 00:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wZyOpCWS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB3514037D
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299925; cv=none; b=MwmYOwOZxAIjWjHI5nCW+3uEXv/F11fmlZy6AP2COO6VTD1p+CwEAH2QJ1pFeltQDpusQvhVccAXkWsh7xA9560mO6RGGUvTLfvwb1P0AkHQD+gOJgBnUIvTIN520LHsbPE7ufW0h8p8eJggufH2bLDF2xEdpwONZnqKayoVETc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299925; c=relaxed/simple;
	bh=3eJI5zSrDuIzjnrtml0eoF0GxHt+dGhxWnDnqgmi7+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TKaDy1OWFTw4HbTVSrngJFFR6iWx8H+QdYdYl4P2qICZIE48xyumIKomis+5DFmolPYOyp4F98pHKKt/WXhNQyPBhyuuOlOG2IBHZAXGVnN4LGyO4MBzX0tzDnzxuYd8oLUJOM6LQRtZjW84LbIfeasnV2S3RbquvSrzpaRZ/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wZyOpCWS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ee13ebef37so13984295ad.2
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 17:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299924; x=1715904724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AuBb56Ya/JVHt3ZPygn0bw49ZbbB/FQ8kpaCbLZgiyk=;
        b=wZyOpCWSM3WHSJbn8sAaw/WuEzI1DaK6M/RaXSSQroIRnVDlLc+s30ZCoxG54pylQ2
         1KI01vnfWorfbKiC5B/Tgv8/wy4mlBZ3TVVX7zR1JRDW1wC/bet3UzTOaATdd0izyZBm
         UWCH+OzypJY1oKVZZDCBO0E8rPw/1t01Bh45bQ4eezMk71syvGhh3hdvPndU7uulAyuL
         oF/cLbhEeHfjMzvL8oh0Ovij/iWJeX34AWTFz0foQG/Et7ml5UwR0pEJctwt/NgNy8MQ
         zs+9hYS7nUaYXERBR+RZDzymxmDi/iAdcArRfxbbOOM0UgmT8P4VlK31nhTbi7sf66Nr
         HwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299924; x=1715904724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuBb56Ya/JVHt3ZPygn0bw49ZbbB/FQ8kpaCbLZgiyk=;
        b=WUQMRBRlE+Jo76savp5SWadfHjLQNM3Vjy/+TY42fwuNPVplvPjZvGSp9rCPX0S7iu
         gFXLNDZE+nhP78mHBZf9/WnjDtuFdq6y5SnBuS80d9ArRW5adyA1yyiQN9/nRt9upXK6
         IcA3NAbOUqG9T8yRLvwm/yJIUCtYN8z+UWFHR3ZS5kA6zu44RKrWrwng3qHyUs6GEGYT
         wmzZwV3ustslHc5Nt3ttg0JLtrdXeLR9rzqnhHSD28BcWdZ2Mp3EZbXrvzD2E3OAqk3S
         hOASoodKCnPqQs4f4x/q/uVUQlSxEm9aLrf62PNAcpSgVEXjNbRUp7VanXE6ErqXnX/8
         5b3g==
X-Forwarded-Encrypted: i=1; AJvYcCX4K8p5T7YdCYQH9yIja1UvslNDdvyvUNZkStzLgLJlj3Nhk1UJMgGMC/T23b/vsmZZcOF4noKw308JGBGI+0sbBDgoB4Hq
X-Gm-Message-State: AOJu0YwEK3Le2SZ2niUNcajWLRLQMy/kpDdWos11ltGFTrK+YReGzFFi
	IlY8tMCr4x9R1PECsUmui0nfidmR8ugWyQDActwpDtRQnYOZ6mq/KGU6H4ZeVV+S51oMasX0ntX
	afA==
X-Google-Smtp-Source: AGHT+IGDiT6r5MtSiTKtFOeh1TnvuA8iW3sg04Hs0Mp2HYr3hoUvchEofnYDdFYeElPPK8QwfKXlxZAkHMU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:903:32d1:b0:1ea:2838:e164 with SMTP id
 d9443c01a7336-1ef43c0cafdmr333715ad.2.1715299923621; Thu, 09 May 2024
 17:12:03 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:20 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-64-edliaw@google.com>
Subject: [PATCH v4 63/66] selftests/user_events: Drop define _GNU_SOURCE
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
 tools/testing/selftests/user_events/abi_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 7288a05136ba..a1f156dbbd56 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -4,8 +4,6 @@
  *
  * Copyright (c) 2022 Beau Belgrave <beaub@linux.microsoft.com>
  */
-
-#define _GNU_SOURCE
 #include <sched.h>
 
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog


