Return-Path: <netdev+bounces-83830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC0E8947F1
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 01:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44B62813F9
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 23:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB0B5730C;
	Mon,  1 Apr 2024 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfaAFvG+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243C756760
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015338; cv=none; b=CT9/Pfyq/pjMWfMvwxbvy0bvW1umfD6cb+3z54ryIjFLscsnFYHNOeHrxT4qOe3Ve0G9fH7lQgqDiwAmckGaDk3Br3vjyoe9adMRrRzY5oyuLYKLZNIL6ka2H/A+TCkwKT4qf7TgIVkfk6RYTJ9NjUWLdpDFfP34SVlmIWX2/SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015338; c=relaxed/simple;
	bh=4JhNkEpOiWMttmklKDS6dB8Whz9xSe93GiSKkFueDRI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JuYF2rCwNd8c6RSi9XYfzxOm5AqLtCFetx0nedFWpoWtWEHs2nanxqYh6RinOPk7xjpHom2uuQmxwNMtc1cJWEdPwyU+z21+G6Pj0b45owUcH2p4dowfKTZytb2n+kMl9SrBNxRLceVZl4XjhYk42BChjWXH+cJ0gbjIqAQ4Rm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vfaAFvG+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-614bc5c53a1so27507887b3.1
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 16:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712015336; x=1712620136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BeCArdFCgR6hPIyqHhpmGoh9zohrxgi2vCDzv1Uvsng=;
        b=vfaAFvG+mOqrKjbH9Ge0oDljZh/cSXm67PclGL+fcN/avO/woLbSPb5FLBQg6uXzLD
         dSp0OBr2PDyfRibpQSC9Pf+upEsj7RNSFzbFreM7ZqaVhqlhTrQT1xiu2arpA14YTk/u
         B6i6l0MZe+oOAzJEVDR5uwn+9Si+qJtNHjFZADP9xSHIz8a7epD4LZxRVqqN3WQTw+hc
         jTptohz3JTm6T1N4n2nnQoH2VXzgbD5gTZmanjnieO1HNHHgLDv+dEVqaLe4025qShDl
         Fh5+f7Ib09HcHAXUA3IaZB8LaCS/nqGZwikS8+sOb2Zm1mW7SinOyKRevnhJdYOBqSP3
         S5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712015336; x=1712620136;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BeCArdFCgR6hPIyqHhpmGoh9zohrxgi2vCDzv1Uvsng=;
        b=dBdKjutSqDABMntCT5uu+aF2Jh8OvxHC2HbzVdwKPzUIX4c4PWrHDUqUONwQC9rQoW
         7rvdCsFGgHSO9tMNjT7MzvslfWAIxMz4RXgdK9RMyIDHtarRUfQvQyFoaXvIrjVla4A0
         h9D82JYFUaK4cHBYF7EXg49jB60fGw3GnEOYpU6+XFoFmBy+l82YkZv+a4MOsBwEzI20
         Dmpqy8s6q9xhWLzkoytMpaEemd5TARHSd8Za9axJRSD1Ds0+IlLQ7pcRjq/aJCyRBb4x
         e+JDGlstnJD6m0q8Qzg7oXYtWGV5TKJhLGMJc68fFichGvL1b6aRxQZGykQi92uuEpUi
         0d4Q==
X-Gm-Message-State: AOJu0YxzUQsabZlqgX63+WrKLKWasN6VUqjVE5jBrzfpR9/4/zQLJVt1
	6BQQYEu+gtCQ8JXYsVItO64cBJ7g45YWLfj372xcBC2ZQNK6KSF5/GJEQO49ECvlzy6/jKUxA9z
	dldVPS63bQjoeax8f6QSucw==
X-Google-Smtp-Source: AGHT+IENg/l0w7lJnqGpT/qHSwpQYol/8NlTdFPuRBHCAciA1BzQJQzDQqMPR1/kH8jhEkZOGWe/9UtkbBomwoKlsA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1006:b0:dcc:94b7:a7a3 with
 SMTP id w6-20020a056902100600b00dcc94b7a7a3mr769132ybt.12.1712015336258; Mon,
 01 Apr 2024 16:48:56 -0700 (PDT)
Date: Mon, 01 Apr 2024 23:48:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAONHC2YC/x3NwQrCMAyA4VcZORvoaq3iq4iHro0uoNlI6nCMv
 bvF43f5/w2MlMng2m2gtLDxJA39oYM8JnkScmkG73xwwfVoVSXPK7Lk16cQVk2ZkBaSavguPOG ILh39KZ7jEOIFWmlWevD3f7nd9/0HcnYlG3UAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712015335; l=3378;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=4JhNkEpOiWMttmklKDS6dB8Whz9xSe93GiSKkFueDRI=; b=NKg6XG8BN99gUBI3M2EOxgxK+kUU1xCXzro+M6vtMFE/7+A6dbh9K6zgb0yyqbNaih+k6ztsO
 bX+IDfR2tSbBc3Hz4yHOB8t7lA0pR91YNefcOSR+Ppvq3Y+FZM5/PuR
X-Mailer: b4 0.12.3
Message-ID: <20240401-strncpy-include-trace-events-mdio-h-v1-1-9cb5a4cda116@google.com>
Subject: [PATCH] trace: events: cleanup deprecated strncpy uses
From: Justin Stitt <justinstitt@google.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

For 2 out of 3 of these changes we can simply swap in strscpy() as it
guarantess NUL-termination which is needed for the following trace
print.

trace_rpcgss_context() should use memcpy as its format specifier %.*s
allows for the length to be specifier (__entry->len). Due to this,
acceptor does not technically need to be NUL-terminated. Moreover,
swapping in strscpy() and keeping everything else the same could result
in truncation of the source string by one byte. To remedy this, we could
use `len + 1` but I am unsure of the size of the destination buffer so a
simple memcpy should suffice.
|	TP_printk("win_size=%u expiry=%lu now=%lu timeout=%u acceptor=%.*s",
|		__entry->window_size, __entry->expiry, __entry->now,
|		__entry->timeout, __entry->len, __get_str(acceptor))

I suspect acceptor not to naturally be a NUL-terminated string due to
the presence of some stringify methods.
|	.crstringify_acceptor	= gss_stringify_acceptor,

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 include/trace/events/mdio.h   | 2 +-
 include/trace/events/rpcgss.h | 2 +-
 include/trace/events/sock.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/mdio.h b/include/trace/events/mdio.h
index 0f241cbe00ab..285b3e4f83ba 100644
--- a/include/trace/events/mdio.h
+++ b/include/trace/events/mdio.h
@@ -25,7 +25,7 @@ TRACE_EVENT_CONDITION(mdio_access,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->busid, bus->id, MII_BUS_ID_SIZE);
+		strscpy(__entry->busid, bus->id, MII_BUS_ID_SIZE);
 		__entry->read = read;
 		__entry->addr = addr;
 		__entry->regnum = regnum;
diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index ba2d96a1bc2f..274c297f1b15 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -618,7 +618,7 @@ TRACE_EVENT(rpcgss_context,
 		__entry->timeout = timeout;
 		__entry->window_size = window_size;
 		__entry->len = len;
-		strncpy(__get_str(acceptor), data, len);
+		memcpy(__get_str(acceptor), data, len);
 	),
 
 	TP_printk("win_size=%u expiry=%lu now=%lu timeout=%u acceptor=%.*s",
diff --git a/include/trace/events/sock.h b/include/trace/events/sock.h
index fd206a6ab5b8..1d0b98e6b2cc 100644
--- a/include/trace/events/sock.h
+++ b/include/trace/events/sock.h
@@ -109,7 +109,7 @@ TRACE_EVENT(sock_exceed_buf_limit,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name, prot->name, 32);
+		strscpy(__entry->name, prot->name, 32);
 		__entry->sysctl_mem[0] = READ_ONCE(prot->sysctl_mem[0]);
 		__entry->sysctl_mem[1] = READ_ONCE(prot->sysctl_mem[1]);
 		__entry->sysctl_mem[2] = READ_ONCE(prot->sysctl_mem[2]);

---
base-commit: 928a87efa42302a23bb9554be081a28058495f22
change-id: 20240401-strncpy-include-trace-events-mdio-h-0a325676b468

Best regards,
--
Justin Stitt <justinstitt@google.com>


