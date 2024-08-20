Return-Path: <netdev+bounces-120220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7849589A0
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6D41F22EA5
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D327190058;
	Tue, 20 Aug 2024 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R2Bb2H5g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C0E1917C2
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164581; cv=none; b=o/H30Sf8P7DIxpRhL6QKEwtJnKpbQ6Pll5UpjWdUHQ3hL7KGKvVwEw9thXaYLqEdoix/9iJEL62ggeq64n86UZt2XoSauljSsW0IDlQxfCzskycWytT+i9CUaaEILKQiy4fVp29wZggqn80egaBFB8DvaEdquyljBcK+Br2FdDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164581; c=relaxed/simple;
	bh=5S2rS93fK6yMvjrCCxzHJ+5LjG17CGjTYW//cVGBTKI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SB0mlErMHZzrj/Z1q1VqF4eb0rEaygFrhrbSdsyY8JQmnGv9vVjkx+BeOdA5phCK6LkDpIWcXowqc27v2uEa4yVwIm0nrpRUJB1ix7f8sLOgp8VBValE8csN2qRJrHjsYmXe+8zuXkkFv32S2heTqax1ToM0PvnggJ6Z3N93VAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R2Bb2H5g; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso749004766b.0
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724164577; x=1724769377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rh2Q70Yw8J0M3uUvlLdvsQJ7GpaTom9Aupmo76o5wP8=;
        b=R2Bb2H5gXS+3BDftGOGlZCQ+Wyo82Qnw9HqTASkf2sDMPnuFWG0xuyUgR/syYMrosP
         pwO//CoCHBjRUsreF885hRlCpEvIpc/fm7whEAEprK6EFXrB0SgnU2lDVY8d7JE54aCO
         ncF9+z3rq97EY5v2DK5N9SeyDjpVysq+sXsCeeUIHjsXaPzeTdxjhR2hoqYS3oce4wJK
         qXq+YaaY0HsVqMr/yC+C6ZM6Q/Qa+vyIJg+zxq5VirqAmvILbfUvQQfgBZvTstj9yKz5
         dO05yQIytoyHtAVx191MkqyQDjCsIuToqWyKZZkjwoGmlBjKlMBfqFjsOTVwwHbppGZW
         rqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164577; x=1724769377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rh2Q70Yw8J0M3uUvlLdvsQJ7GpaTom9Aupmo76o5wP8=;
        b=PJyBZqknVC0tGhaMrWaxELH7txbxIXK9SNDv+T36o9YnXV2xA6gvSQfoPuef/A/AEM
         1ntQ8PXZc0i4LvAYnvRalZhm4Ce7XHVoaUaUnL1o7KFScX8Kxr19hWSvn5ECBNxOA/kj
         ClRGe3l1cGcuc3eqd3foXwSPxRpVOf3PewJSI152F9wCdGLPikbErWNO90hNNn39hHup
         qEVcr6IfxUS6PSQSaMY9dUIyKduPcay/K09WQLsQl6/4M7kEuz2I6yhayLiqh0rvtdTZ
         t50qlq69e0eIn5GJnzO+x6Q8ldCgIDFbkHHX8UPJujlJyu78mKy3Conj6uVflaTekt/8
         SkAg==
X-Forwarded-Encrypted: i=1; AJvYcCXSc8Ny+rnwssxpUGYZXoqPsC7X5V8s/AEhVD/vFY0HJIgqSASwlxzrywnHVABx7ACDA8HwCcgt4y57OSJ18GV6Ih5OBPXO
X-Gm-Message-State: AOJu0YzKgHhSTidCfLnEe0hmC0uY6jXE2prtOKBKtVE9QbbVqh4dGxvc
	v+VUbledzWKk1sxjgLUoFjHdr4HL9HZA+q7yyMnXQFZaCea5x7m3B2eUmojfAh4=
X-Google-Smtp-Source: AGHT+IEGycq7Zes7rT7OOvl2flOQqrkeiAZAc96Hg1g64tQ+uh8+RnXT78ievbR0WEcFfugVqWJabQ==
X-Received: by 2002:a17:906:d7cb:b0:a7a:c256:3cf with SMTP id a640c23a62f3a-a839292f3fdmr1084910466b.24.1724164576436;
        Tue, 20 Aug 2024 07:36:16 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839355f5sm766076166b.106.2024.08.20.07.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:36:16 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 05/11] vmlinux.lds.h: Preserve DTB sections from being discarded after init
Date: Tue, 20 Aug 2024 16:36:07 +0200
Message-ID: <12d0909b1612fb6d2caa42b4fda5e5ae63d623a3.1724159867.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724159867.git.andrea.porta@suse.com>
References: <cover.1724159867.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The special section .dtb.init.rodata contains dtb and dtbo compiled
as objects inside the kernel and ends up in .init.data sectiion that
will be discarded early after the init phase. This is a problem for
builtin drivers that apply dtb overlay at runtime since this happens
later (e.g. during bus enumeration) and also for modules that should
be able to do it dynamically during runtime.
Move the dtb section to .data.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ad6afc5c4918..3ae9097774b0 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -365,6 +365,7 @@
 	TRACE_PRINTKS()							\
 	BPF_RAW_TP()							\
 	TRACEPOINT_STR()						\
+	KERNEL_DTB()							\
 	KUNIT_TABLE()
 
 /*
@@ -683,7 +684,6 @@
 	TIMER_OF_TABLES()						\
 	CPU_METHOD_OF_TABLES()						\
 	CPUIDLE_METHOD_OF_TABLES()					\
-	KERNEL_DTB()							\
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(timer)						\
-- 
2.35.3


