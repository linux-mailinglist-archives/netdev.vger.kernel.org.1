Return-Path: <netdev+bounces-97455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4938CB7E5
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39371F29C69
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68FB154454;
	Wed, 22 May 2024 01:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRl3zY1b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D37115443B
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339711; cv=none; b=dX580pvwPFrXtlOwW1omlEu90P4agsrb9n8NNpHQ0Ca+G27C7QIr4npWpiYcJcF7YfEUw7MW07/GEAg0hAWf55PpkbsxeOHxpoe6oNtoKM+WqG+CwMBD/fgpqIr8cc97letfAPMkisZglXn54cIzxt0vmx7XnG2b2hrGtGFUvvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339711; c=relaxed/simple;
	bh=SmrocNUJvB/ITWCaF4rKnfFmHCtlMS6QocJOOBtpHOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B46IOCTKdIoZbhZTF6pyLOv8Rdn2DlBsiALNuHdTu+xPz/oRX89gmrQYm8DUkyLW9+tw1MuttEN9Fucs0zfzZWcXjWFgcZtK76964NY8MeVyHj+nS5i4phMNB/c3OV5JPkNQHtkMN1IkWOHX0KcuEnaQwN4meOIPscO2oJjkuh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRl3zY1b; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-67631fbc1d5so201323a12.2
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339710; x=1716944510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ddm347wncUXhvBA0WIqVxztes14b3U0yNoWhmDeDFY=;
        b=SRl3zY1bK8gwbkMgvl5YJOz9kp31ainmDDVq+xV30n8nNnDIfKiJ+3QM8zKosf888o
         mKbYXdGqXRic2kTxHEJPt9sRzHit2eLcjaqVtqRs1agaPVLOB5wz+tLm81dPqnFcugRv
         19k0SY3xbFB601gl2tqkQc48m3zRcsKDRobn5d26s+Y2p0nbZ7v2QgEyaszyAOoyRqk9
         GIs0rww0cdzOJTIb/xZL4kUYgcCiez/9SqSnhUEVkvUTgz6VoUy5fC/PJIPvsAXuwZnT
         0+QlBaReqtfr28VUCBkjgxR1q4oxCeb+Zg9CbwZ8yEH1SpoI/bat7Tye7Ra4m9u7R8lT
         kqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339710; x=1716944510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ddm347wncUXhvBA0WIqVxztes14b3U0yNoWhmDeDFY=;
        b=dcm10xTwKP9/LStDurG3UZjIy3Q4M1s6qlmxB6i2jnXIoP0EvxhJkFk1LNQ2iqqtvn
         ONUVRjCsGHX0zPvaIgMzf3nx81csP6fsiEd4sO/1RWyrQwiHGDrQ90VILKzmWVWrMkV+
         697jKlG6OwxA3W3z+BkVVPgeEp+aZQbl12LI1EhCdvT8vQE4gzmy3b0pRoVVOVuFbn7A
         dclZoCucpC7/9xE97P4EX18mP3JXxJ2H9rIR9lnfc05VaPRmb5NLSo3I6WXEsPUcgouU
         PZhcDO+TsunQqPH7Z2wCWu+Thj0yMoaIe+GQwPOK8cPhsAvRCQvoGFZqO2td/nmg2FH8
         Nazw==
X-Forwarded-Encrypted: i=1; AJvYcCXh3wEDeDy+/ph1NDn9BaWj690quqkW0NnwEseAC0MY34S6wRaBvvtHsxQ/eVaZXNNS6m3v3MbGwUrqpEvZdHrejrRA/IhL
X-Gm-Message-State: AOJu0YzFWkVnP8BqtbQrqhHRHgzaURhGnsHgoKe/cFatkzTRqj+YI0NY
	kkUtlRolCtNGD54UC503X+6QUs59KKznRm0JASRDAkr6cONukNP2GWcipkTdPkAY+EKy8p1jS4x
	RoQ==
X-Google-Smtp-Source: AGHT+IHViMDRF07gYGA4O1kZVdy742miSAJ5o6zH/GL3MaXuWgF70gUFd0Ml+qHdUScPYudMioDDIIFR1uM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:371c:0:b0:630:dcf6:f224 with SMTP id
 41be03b00d2f7-6763f99bfffmr1357a12.0.1716339709684; Tue, 21 May 2024 18:01:49
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:32 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-47-edliaw@google.com>
Subject: [PATCH v5 46/68] selftests/proc: Drop duplicate -D_GNU_SOURCE
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
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/proc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index cd95369254c0..25c34cc9238e 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2 -Wno-unused-function
-CFLAGS += -D_GNU_SOURCE
 LDFLAGS += -pthread
 
 TEST_GEN_PROGS :=
-- 
2.45.1.288.g0e0cd299f1-goog


