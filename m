Return-Path: <netdev+bounces-158489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9282A12281
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2337168D46
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA231E7C27;
	Wed, 15 Jan 2025 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NmIRVVag"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64791E98F7
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940312; cv=none; b=k9RjtS6w7JpSx3Iy3rR88Zx8u/LEAwUTNUh2TR9I4oUDMpw/qnAXBAWwql2b9Uk60tXH3+5J412i4xZlkLc9/pQASfEhMtvmy4l74NeO0fqTXn9rEnYLhEHplms6NVgCxUEA/XDJlgTYOMysv6K/67JKFzrIDAYHucBmie+cxbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940312; c=relaxed/simple;
	bh=jc9GH7iODcztLgEACa98S5q4gJs1cF3h7lsgl/BP0Hk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k1lQhy/1HR9BPrnAon6IExwbVC4FCavo4iZPMv3xxO3yZ6/tLc/bdNpPqBMuw9F2tf82aXYqeFp89wYm27GYyplsPK/nHZp5bIgSH4lVKwSlnI7aZJ7HOP3HaAnJvLKitZprmDL+mtuaWbT+f4nqtDMd7fSaUMoehWJotM9pcLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NmIRVVag; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso11359354a12.1
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 03:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1736940309; x=1737545109; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AKwBUUwE5/H+m7uR8aKHohtap5VDKMhxAfFxXDhd+Hs=;
        b=NmIRVVagWgPQ0I7oI+f2kL92fHHH+dpj8e1/GN4hEqZ3oKoMO9u2E72cj8/D2TyIkT
         Z6HNwGkD5YtEGLoLIZuz8fIoxyijJjXrvL3aS9tKP2lZfqzPKUnn3UyPzSfQfsvWNnHs
         2dNpaY9NlyOmw/vgYIKi6Ni37UYBjlYKMo93KM3tDg5rScUnlELre5Cc756FOM8aj2f+
         RM5lCOk6c2jjvr5rauLuJnvbLLVS820B7sttKhAZqYmFYxk2X+hEMfUXLMWl0lm5m+7X
         kaQ49XGaeKkjm7aTChYxKtSRma6mJ8Xwi0n0EB6UFaHTgGaVVUAVKydD9lLDmC++x7zS
         vJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736940309; x=1737545109;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKwBUUwE5/H+m7uR8aKHohtap5VDKMhxAfFxXDhd+Hs=;
        b=c67OaINQwuARrIUAa2WeIM7KBYFBh/XgjEU0PQJUqU+98905oDyxcu+gP4TVwiFgMc
         nD6ifDgu7VwMVgDrFjZX/5hmoXUeks+0HZOqNX01Z0WEbijeKWcsISi/VBIgh5X/chXh
         8jJqgWCBqpuhWowMrz1GwR5sSLO4GHv6HHgCI2opRYJYrdGHhhlMzkuAwZTutnYLtgUC
         Vf8GJIB9uuyfievuscVDu0ubmvhtPz6rQlZAHSHtBQzAA57dayAA+YRxIrwKlPiZCFcB
         zPbSqnvmJjWUlVuebpCI5a7kJT+VPl8IgfyjQYXM0g6gPW7I+/EySo2RNnjWC//edcgA
         2vng==
X-Forwarded-Encrypted: i=1; AJvYcCVn3eEQwIeQIoWqDZDr7IgNUYb/5dOkOSTomloc0ypvPi8RjotDwBcqJ4KSHSFZPmRhMPegR4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhPPsUB38ttoesd08SfyWk8K1dd5001tyaw9enkJRCGFtjbSeH
	2nbiDtywTl2P3H7viR+UpmyMbsoTmYdXkjPol1rqLU3s91/MJs8QF9mtYx+9EhUXE6L9Vuh8pRl
	r
X-Gm-Gg: ASbGncsHOEFuYb9MHqMt1TRygEG+aCaw85Dj709XZvCtzTXo7EsoWCXeWvHq7diSmzB
	an8ietfQ7JqGoa3JhlQp2JfoL+B5/S+0hwedhnyXTydz7JhZZyig/grI3S97bNM9SRNVEXZFrC1
	37QD95z0BAm1JfChtxa1J+23/h8bjeid+wqXmmIKkSs5yFgrq+orOjYx1zE9tSyRvi7y2kxhw3d
	S5s7iaH3zNcPJWFMGqcz/5wDDPs90kD/MOlgR3bh1wyg/rx
X-Google-Smtp-Source: AGHT+IFwIzJ6xTi+4605ZBbBzuzxGNwpZgaGtz8sS4Qf3KCGF55otcZgVTUAfCpbEUbuusCYgmJ/Ew==
X-Received: by 2002:a05:6402:1ed4:b0:5d0:bcdd:ff8f with SMTP id 4fb4d7f45d1cf-5d972dfbcc3mr24896880a12.4.1736940308722;
        Wed, 15 Jan 2025 03:25:08 -0800 (PST)
Received: from cloudflare.com ([2a09:bac1:5bc0:d60::38a:40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99008c371sm7400438a12.11.2025.01.15.03.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:25:08 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 15 Jan 2025 12:24:54 +0100
Subject: [PATCH] ftrace: Allow tracing rcuref_*_slowpath
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-rcuref-ftrace-v1-1-76fa408c9884@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAAWbh2cC/x2MQQqAIBAAvxJ7TlBDk74SHcTW2ovFWhGIf086D
 sNMgYxMmGHqCjA+lOlIDVTfQdh92lDQ2hi01EYqZQSHmzGKeLEPKPQwGmnROeMstOZsjt7/Ny+
 1ftIcVVpfAAAA
X-Change-ID: 20250115-rcuref-ftrace-237506e88586
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jakub Kicinski <kuba@kernel.org>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-355e8

All objects under lib/ are built as non-traceable for performance reasons
since commit 2464a609ded0 ("ftrace: do not trace library functions"):

This prevents users not only from tracing library functions with ftrace but
also from attaching kprobes to them:

  # perf probe -a rcuref_put_slowpath:32
  [   65.228593] trace_kprobe: Could not probe notrace function rcuref_put_slowpath

The available solution is to rebuild the kernel with
CONFIG_KPROBE_EVENTS_ON_NOTRACE=y. A usually disabled option because of its
potential pitfalls, intended for those debugging ftrace itself.

By default, in face of any bugs with reference counting, like the one we
are currently tracking down [1], users cannot leverage kprobes to collect
additional info like stack traces or data from the rcuref container, for
example dst_entry. Building a debug kernel is the only option.

Make it easier for users to troubleshoot reference counting issues by
making the two rcuref_*_slowpath functions traceable.

[1] https://lore.kernel.org/all/87ikxtfhky.fsf@cloudflare.com/

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 lib/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/Makefile b/lib/Makefile
index a8155c972f02856fcc61ee949ddda436cfe211ff..1f5c9557c4cb5bf2b6e4ac7e87ed30bb3c8f4664 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,6 +5,10 @@
 
 ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
 
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_rcuref.o += $(CC_FLAGS_FTRACE)
+endif
+
 # These files are disabled because they produce lots of non-interesting and/or
 # flaky coverage that is not a function of syscall inputs. For example,
 # rbtree can be global and individual rotations don't correlate with inputs.




