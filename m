Return-Path: <netdev+bounces-250276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CF8D273B5
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 19:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36946328D7C8
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD413C1979;
	Thu, 15 Jan 2026 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d1HRP4hZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7403AE701
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497941; cv=none; b=JbINyjbQPWkA2YSAvVtHKroJWdXrdv54UeakqF+oMoYSn8HqWOuIZkKrSXVBccgB1pOLcqTbel8LE8nWpXb6EGxA6j6V8C9psopp45aeKIdy4QKl5+TkCiLcJyMFTiu5GKm+l3SY/CyhpuDWJ9dnhoGuTe8xOyAGyS4nm8OBk8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497941; c=relaxed/simple;
	bh=HFykaYg9HPPBq15L0EONekqlq+sRptE4/ecmseqKxc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uxU0JovUQlyjRDQVo10a6fnq77INjCGXdaNEIKRTSZKmjiotG2AvTzSxci8GhDNRMxksAYZ3/hc8GGdw9vfrp/U9uDPHl+tCjvFeobnk/cJgdZ2QW0B39QngJDe/maAJAZvxkzyFNPesZhq6tbQrQmd4PxOJW7JUV8M0LrEWEho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d1HRP4hZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34ac814f308so1488594a91.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768497939; x=1769102739; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HKB2fOnTk6paVhVfZTiUwZGvtekyKtECkg71RaSKVlY=;
        b=d1HRP4hZigM6yWbnOErvSmUwCPtFHoWRyktBiOY7MPHdhWV0d6M37Sz8T57wR0kDJy
         7OvU4g1jlBf0U6Ew9wnlq9Pd37ajX06W2+u5GW5ckGp1S1QVX7WDoNKReMaxB+obqdZy
         pHVgw5BafE65mB4C/pY3fDGEuRkirkFHmWGC6F1KGGNRgFQgOcLGW+3QZghy4yupgTJ2
         jZ3KEDLwpCh7K3ZR9y6A4fFvCHYjQQ3iWiuVlr7vxcEPVIx4vwms3KCXvT930CdylRh7
         iPv/pFhlsm7dF0BLN3FiTSAZzX+w+1VaPXJTk6sjMVzGotFGO4cYqoPk8+X0rFIDcBwZ
         Z9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497939; x=1769102739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKB2fOnTk6paVhVfZTiUwZGvtekyKtECkg71RaSKVlY=;
        b=QIDdhfvrxjdrZ+1w96p7yuwarVjgXnk+95jGkQ8M+p9JmszIZMP26J0PZZLVxZURKS
         qdJi09zOOpnju7io/+ggOdY5Buo46I5BcQonq7DZFcof2d75L/3pMToOywWkMdZ1fncO
         NXI0eP+C6SsVjrlp/g8p0D62rSK4MC4wRbTyNmFxNLCzfqtxaS2h5IQsSU1kP7ZxlTZJ
         2rjJpHcbF2yqKEieeHSadqvJxIPEa3ZSD24PmkysiUjCIGGb+gwZE0WBDcGYaQicS/ol
         R2ozTr523735Tzw3TuLo5tzXp8GdyXDRBG9k3/NepnDcOdF02IUZTUSH/n5KGHJr5DFp
         MheA==
X-Forwarded-Encrypted: i=1; AJvYcCWe+FgKC1sj3EeM7dYo8kCwy59sJpbewj5D6uApg3h+KrMZlN5OLk6A2TlGvD15yJt3Tyugh8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjetDjX2DDfZdT1EMJlrFfN0FF6uV2RBlxGEP6bnwDyNKw2UqL
	kNp3Unasvz3GyaF0jRggan6vD4CR1rnJFZLT1m2BLw4FvfhdYd5Kr3DyuW7EQnn3dmHb/bpJaF5
	Tqnko3w==
X-Received: from pjzd5.prod.google.com ([2002:a17:90a:e285:b0:34a:bebf:c162])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b47:b0:339:ec9c:b275
 with SMTP id 98e67ed59e1d1-35272ec5a37mr145532a91.6.1768497939248; Thu, 15
 Jan 2026 09:25:39 -0800 (PST)
Date: Thu, 15 Jan 2026 17:24:47 +0000
In-Reply-To: <20260115172533.693652-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115172533.693652-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115172533.693652-3-kuniyu@google.com>
Subject: [PATCH v2 net 2/3] tools: ynl: Specify --no-line-number in ynl-regen.sh.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If grep.lineNumber is enabled in .gitconfig,

  [grep]
  lineNumber = true

ynl-regen.sh fails with the following error:

  $ ./tools/net/ynl/ynl-regen.sh -f
  ...
  ynl_gen_c.py: error: argument --mode: invalid choice: '4:' (choose from user, kernel, uapi)
  	GEN 4:	net/ipv4/fou_nl.c

Let's specify --no-line-number explicitly.

Fixes: be5bea1cc0bf ("net: add basic C code generators for Netlink")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/net/ynl/ynl-regen.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-regen.sh b/tools/net/ynl/ynl-regen.sh
index 81b4ecd89100..d9809276db98 100755
--- a/tools/net/ynl/ynl-regen.sh
+++ b/tools/net/ynl/ynl-regen.sh
@@ -21,7 +21,7 @@ files=$(git grep --files-with-matches '^/\* YNL-GEN \(kernel\|uapi\|user\)')
 for f in $files; do
     # params:     0       1      2     3
     #         $YAML YNL-GEN kernel $mode
-    params=( $(git grep -B1 -h '/\* YNL-GEN' $f | sed 's@/\*\(.*\)\*/@\1@') )
+    params=( $(git grep --no-line-number -B1 -h '/\* YNL-GEN' $f | sed 's@/\*\(.*\)\*/@\1@') )
     args=$(sed -n 's@/\* YNL-ARG \(.*\) \*/@\1@p' $f)
 
     if [ $f -nt ${params[0]} -a -z "$force" ]; then
-- 
2.52.0.457.g6b5491de43-goog


