Return-Path: <netdev+bounces-95079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2D48C163C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6AA6287929
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF6A1369A1;
	Thu,  9 May 2024 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZ1i/hQ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9008A136671
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284904; cv=none; b=YDr6yCGypy9Fy9zrLz3esmKDoZm8jnwm5Nk1JnoMWTj2WW4Z2ig9xdewI+nY5iAFCDOVCFw2SYyllLuk3TU87o9CEXVMG0OC+FMbkIz0lvVoByGH9U6aVT/1gWYME3m/xj647536nKdjUnUu0pDhUnwC+LcPe1Qf6WYLPGmgg/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284904; c=relaxed/simple;
	bh=IwTjZ+QkHecjItm4ac17VTR49XMvagwZXgy5gGzNQGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oL1MaLRF24CTs3Oh6Ty4+p0BoLAbcL2D1583clhFmloSf31LeimBTHo87tX7frQKj8gu7Y58gVBWbxZRSNQiztfNSsWKpGDw+v7Fz2UlTWuN69oymNMzXkiLv5g2PWPFmLCCi9/X3Dlq1KmVENp1m/EBvBRXDoHq+VRbrMVa5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hZ1i/hQ3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de604d35ec0so2136363276.3
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284902; x=1715889702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WlZHqG8GOWNVngCs0QnGJEkofrx6wgIMd4fjiXkUQc8=;
        b=hZ1i/hQ3iQYjcf2650k3wXoi0TtKjLrsTyOhLuuTzHrQfURK5hdVS4XfEvSiLsPFpM
         g/S2AeXQFJb0jMwwhSYRy/chnRePBxIJwgDq24ueEa/o5td+sslYBrmiBahvYan0jCWH
         pZlQZwu9URZtWSSo5/pvUZ8HFU8fe9aIYDYha369Y+elTzT0h8sRzFuLO4VkYAo1j+uD
         dfqa9H3Sn+OQbmG4Knz5s+MW+0xK6k6p5B9YviwXnlun2rOaQmPtHEQSbB4UTM/TV9Om
         m4fW35iF9TUfeacThNS5809727tL6HRWPgTYIqjM8PRkssbguoXYaokaJ5lRiuEQcIo+
         vOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284902; x=1715889702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlZHqG8GOWNVngCs0QnGJEkofrx6wgIMd4fjiXkUQc8=;
        b=RsVbAxtFVIHLaCfMsxCTyLgSRUTnZhqKpCbcUQT1PbrAG2pKQoUOhcbWKJD6ZEMgKk
         EMiH036eCCccPsnxBaYO+WWeWDF+xRI4f1dH+96FQlN4SA3wUJGPdXFbMkHgeM78KWpf
         LyB9EsqfjyRqr++gaSehELDSeYY1UU4TytueUm4HX9LmSRPbStD9bcHP4xYoaPe7Kkhr
         Ak3HJqGpCXfpFWHgcem1fi9QnP9pk1SuhYbtmZLfksuGTCJmR2etfJm+nW9iTPKcfqbF
         EJIzALXIlmrDVMBxkEbTEEHvC+22iCf4aUtpvNjzhbLj+WsBoMGJKyTUOnuZqZS+m7Qk
         ryOg==
X-Forwarded-Encrypted: i=1; AJvYcCUG6f6MZyzJ4CoWHuuFAMOaphLlpBmv60RS7i8F1AMoK0qUEwGSomo1rwT2w8TOHHEq/8qxjbQkW0POvTps8bHCSnM2I9GG
X-Gm-Message-State: AOJu0YwIvbmIEOrxwRJYcPro+V7s0qAn+kPv2VObKP3aXfAA/m46oaOF
	nVC4n0FeeGC0C0x6nUGs/mxUXf8/OxZ8U6ceY/Brcof4xn9fCzeEbxEFuRcbpiK1FuxyKNoWw3i
	Eqw==
X-Google-Smtp-Source: AGHT+IHyuWY5940dXI+8MYdK3cHUYO5oPq33T22zpT2ioJu3FvZMtTFAIbDVKX9sxGXi1YbC+ZrN2B4TRNI=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a5b:182:0:b0:de5:4ed6:d3f3 with SMTP id
 3f1490d57ef6-dee4f2e03c0mr141982276.6.1715284901753; Thu, 09 May 2024
 13:01:41 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:11 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-20-edliaw@google.com>
Subject: [PATCH v3 19/68] selftests/firmware: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/firmware/fw_namespace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
index 04757dc7e546..c16c185753ad 100644
--- a/tools/testing/selftests/firmware/fw_namespace.c
+++ b/tools/testing/selftests/firmware/fw_namespace.c
@@ -2,7 +2,6 @@
 /* Test triggering of loading of firmware from different mount
  * namespaces. Expect firmware to be always loaded from the mount
  * namespace of PID 1. */
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sched.h>
-- 
2.45.0.118.g7fe29c98d7-goog


