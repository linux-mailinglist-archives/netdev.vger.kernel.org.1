Return-Path: <netdev+bounces-68417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD217846D9D
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82FE1C26118
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 10:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6897E56B;
	Fri,  2 Feb 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gvRP8dJ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681107C093
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869008; cv=none; b=fr2GSeX0dHXVK22RQkd923faTcv3nP09zcmOEhGP0z3b+SH22VO8r1vkk/6R0PeJ3PDG9tdgiHfq7FqrBefdop1T3+wjE2xUR4O8laEyMWisGmYeIW9oH/lY121LJ3n8+jY+Ih+GwqXQwVzsbSHY9gCyGb35Fb6NNl26bIUW2HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869008; c=relaxed/simple;
	bh=ZxwmE0nZsP1Nk3oxW4DdUpU7gFnVfTpHfJ1XVp+L1j0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VJtmkJheQqUucajtxygzP5z0zxSiA7yOjR0HPpb59ntUJEUR27GHo53LYdJFYzkz2i8LLZiIOUyERvfBPzEy6ePVreJ+FgaMK161+lxfV3E+y2ZwlUkE8lXSp0YWNNPnqXsgXy6xqlUchY9tZ6Ui2XwRJ3HC6sP3S0u+sJHP+XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gvRP8dJ3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d74045c463so16038675ad.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 02:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706869005; x=1707473805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huDkFM2jKbuwvr+cQsGrJ0cboThbc1r4eSZ54RE7EeI=;
        b=gvRP8dJ3KXsujD0C1Ta3pPfDymJdYPCHYsuftj1ON/YnSJA3tm2+UZn1SeXbdriLn1
         lcezB3u2mUWEC2MoVexnQ1sm9UrJqy4yfJwh7+oLWPxKtWOYoExkaMWHDzWHJnTJpRrk
         pABBhJW4wUI8AAriCqjzK41YNwsPbDVxYwhkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706869005; x=1707473805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huDkFM2jKbuwvr+cQsGrJ0cboThbc1r4eSZ54RE7EeI=;
        b=jrfUzznTFMJ0aKualvJ43dBurDBaA/4+x6cVpWvLW251xogWIhR4n7ZDqzPaczSGm/
         vbarkViTE/aVbdd/k//Iitx5OvbSrpua9jBzzAj6NT+dRDx6TGiiLjO2DFyAm7+xX9P2
         rY6+OdaIzV6a6YMGXOmM3hsjb8gMMg16F1o72lEE0BXmO/7lUa5IOvKfDrbver6h8chA
         QjgxL57t232Lh2eJTKze5KJtL8X9yawyNabYhlAyBFXflEvxiIkaVh8LF2h6ABDP9H70
         c6dDOexOO4ZPbdEf+exPfk5rDhEqs8ROekh4QFaa3+u20VX36++elf5aZTvxef/6R+67
         exHA==
X-Gm-Message-State: AOJu0Yy572fuxi4XUgwbJbSjLIo70YNY/QuGBDDkkAHknvpcUl1l70gS
	xqEgKIMpw5R8W23BSWw61W7phhA6Jha4ImSBpezPhHIlQ6/W66Hwphmzjj19vw==
X-Google-Smtp-Source: AGHT+IHjZ/RlOFhGarz6cIg2WBEenEsLGnouU4y+LgMxrAEpF+gSHjnEyIr3C9MYyj8jvC/08bJKHQ==
X-Received: by 2002:a17:903:94d:b0:1d8:b6c8:d9e0 with SMTP id ma13-20020a170903094d00b001d8b6c8d9e0mr1942830plb.68.1706869004906;
        Fri, 02 Feb 2024 02:16:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXm2ltGXSQ3/dMDFTJd44WjKZdXshEPXPWN2y6WE7E3b+jubgNaOYkuw5VnqA4S9HtLo7qrYKsGKPoYxH5O74AVwvWb9iE10rFYm3n026lPQhoITT6P5EG3S6E0ARfoiPiilFHc1P170f3L7IIRjKqdWIGevmKqtcYBEq7HSe5RdITj0U96a6pTvHsJ0MsK89PKSs0ECjcxeR0yzhKvgzBGQqSm8nHFrtSeBcJzXXMaebLLOFOmheGxxf2ic7AR58qnNPxprUyVeY6wzFzi0cNWRnRpzjgIFyrNRmmyNKPD3NRk/rVYnE+xKRRmrDd7B9gCDwG/+ve4xCBvu8plPkZxiwuj9XZhaBIbvySbpOS8aXTc+kkoQ0Qr2U1llnNgaFQ1nY7H3f/ojjTTW/r7ggMMWTwS5GebQqKR5ZQk4UXJjEiv18IkKd03pIO+QQHhwRvi75ST2re8QSg/NZZvCu22i34f/ZfVkuhFBAKeP0EdJTIi3pDLw2DCTd0qk2OzZQ3esIyeHUi4SbRQEhDRzSl/EdxhSOD37RLyKKeZsvcQw/KOdAqAawSDSPy0Zwzh0G32VHyd7skIHFuGmVRga32CpsILSaLLA4ITFo88rafydugjzXu00x+4wzcP6wX8+lbazQTj
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jv5-20020a170903058500b001d8fb2591a6sm1262459plb.171.2024.02.02.02.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:16:42 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Fangrui Song <maskray@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/6] ubsan: Use Clang's -fsanitize-trap=undefined option
Date: Fri,  2 Feb 2024 02:16:34 -0800
Message-Id: <20240202101642.156588-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202101311.it.893-kees@kernel.org>
References: <20240202101311.it.893-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=keescook@chromium.org;
 h=from:subject; bh=ZxwmE0nZsP1Nk3oxW4DdUpU7gFnVfTpHfJ1XVp+L1j0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlvMEHvUSDUiKlA+mbRPre0Ef3vI3/FZn+MH1H0
 nTpBmdXXdWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbzBBwAKCRCJcvTf3G3A
 JpS9D/0Q6QBoQC8jBK/SWwnCyPlA7roqa2Ww1Yr5HWnO8NGYyqLoAR/MLiePscunq9kQo7XF14S
 P8vBlWa3w59PmmPOE6/K+Yo4XhNmZJHNn57MFcpldH9PXBny2KEOQhIlpz0+Qq7zhOLddFXdahg
 miGo2qdGlfIpjGAwlRLZVr4XDKEdKus3gLReWRkeV1eaUGK+SU4BE0S9e5Ucv2MjqDKeYkX5U8P
 qcJlKCdupyTdD22vLQjZ4hg0UIOxJJ0JvKAgP5koezT5XzlYxQPfD+lFdixQeprPlZX44YEoD1u
 2gFGFM/Q8utBzYdgJDHKWh8ZFe9OdEKUCuYvCh/uj3WvrNcdeiAwxXTFx+YFw7lp/nUQ9zNbifH
 i0lKwy9Brl+6w2SYcs69qdsxG5hhti2yLUQW5qr1cxQetC9HV+eqLTMxbCd+Gm8bec7x5A7gPkl
 z9qKNMgq9aRbauhd0kdkjl+d6TuQcysN/udCqYNxsTkdS7yBgm/IdQ7OZjnlsgDA30jgME0SH/I
 ACfSg1lLhSUiA5YoWC7kX0F96o0tirE4vqzxv/Puh7Cw53eqsLhs+IiSDSXdodWu7vsBW7YDlsh
 iWO7s+1g4L7hMvsHJrbpcnHePzJ54JOQLt5okcZPy+IE+zSi6oA38qRXNbFz3mjkKY40YEX37q4 8g1LnhWR9uKDhnA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Clang changed the way it enables UBSan trapping mode. Update the Makefile
logic to discover it.

Suggested-by: Fangrui Song <maskray@google.com>
Link: https://lore.kernel.org/lkml/CAFP8O3JivZh+AAV7N90Nk7U2BHRNST6MRP0zHtfQ-Vj0m4+pDA@mail.gmail.com/
Reviewed-by: Fangrui Song <maskray@google.com>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: linux-kbuild@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/Makefile.ubsan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 4749865c1b2c..7cf42231042b 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -10,6 +10,6 @@ ubsan-cflags-$(CONFIG_UBSAN_DIV_ZERO)		+= -fsanitize=integer-divide-by-zero
 ubsan-cflags-$(CONFIG_UBSAN_UNREACHABLE)	+= -fsanitize=unreachable
 ubsan-cflags-$(CONFIG_UBSAN_BOOL)		+= -fsanitize=bool
 ubsan-cflags-$(CONFIG_UBSAN_ENUM)		+= -fsanitize=enum
-ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= -fsanitize-undefined-trap-on-error
+ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= $(call cc-option,-fsanitize-trap=undefined,-fsanitize-undefined-trap-on-error)
 
 export CFLAGS_UBSAN := $(ubsan-cflags-y)
-- 
2.34.1


