Return-Path: <netdev+bounces-128219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A71F9788D4
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 21:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49B41C22FCC
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1A5146593;
	Fri, 13 Sep 2024 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zBAdb5Yh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3912DD90
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255252; cv=none; b=NJ/tDvIrzRNTxZS57Mz0KW+wekRyZBmrkhoHRySRYJrDMgCZ5m58axA7SRcHMB6BcEaaDwOHBtbi8JXrFN0VkuuIfR+EyaCKe6y9dwSB24IcpXCfqfvRqyHSH7Q6w+Oa3ZiCoGMsVUypiGrpvy6/cLPsEk5QDkPN1oTDULNTojQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255252; c=relaxed/simple;
	bh=ymlhcAQNHEBbDJjwaPc7aeCQGJlzv7MIqjOWsvgbkPA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FjL8H1E1Gky6Q8WO/PwGKVU/3Qe/zNimNtCMghN+cAv2YNC5X3WwoHMfAfySi90uT+QMYrrxC7/vKKoZOVAaxbsTMFfcx+ZzaUnNwOvs1076URG+d9o2pEMln4zLkaAf2Naef7C1V20ttkbtCqV8u2FQoEzbSJiu5Mqw6JDmk00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zBAdb5Yh; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d7124939beso25149317b3.2
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726255249; x=1726860049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XyVwmJzFbJ/oT6rl4j6NoyNuLyObf2RLXKIfBjhIh5k=;
        b=zBAdb5YhPvpI1Lnmd2XkzhP52PF4x9RGuVKl5DZUwIi1dkQxzlu2amz2dAdh8Cy+EH
         +ITOfpBH223EchkFntIihO42oPzvfdD1gGGPrEsGv4WhC2DjkisxzGYoeHwZYL8yQ048
         SCEcMncePDCCI9drgggFchdfUOgqfsySKUvmfnLh5JpFJ2f1kOi1dyYAVmzkPC9YlXzb
         jJyrJqPEpLuCuNWOA8Gyf7zlkUDbKBIZlsc/3kZcY/oxn6ALUAPNBRa0AE5I0zBpnteY
         Z0PphiumZhmy8zVpFxqgdCx5v9nVzQAham+IDY4NAwPs4zsUdtdlbcy/cFIw86aZvU+q
         xJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726255249; x=1726860049;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XyVwmJzFbJ/oT6rl4j6NoyNuLyObf2RLXKIfBjhIh5k=;
        b=hi4G3XaVIiD1h5S/awrpZnMlCrRMYDre4dsBgyaDlTc6h5AXlUGJKGiCBqT4SWSZ/b
         yeJ6MSQfofp0cRFQFtU9FFjQIVtkcd+NWPzny4k5rAlYe3KkUXfoUT/PUUiAbpKeXFfm
         TOZpKa7bSEt+ymaHHM8xnJrwQFHDGwI9cD8ek3AfgQWGgSYtX0exItl3IsddR4XAdP4k
         e5NyQsWTOjE7mE+HE/K6uH3v+xIgDNWYL0ebF08p7qprWi6So4R3sb7xY2RJ2NYhSlyw
         UOBv+czpJVKoWnmCyEICHwmbr6Ild6gkjtCc5KYswPjq0P02gDjY5uSPFjD4FyYU5qt9
         Hl4g==
X-Gm-Message-State: AOJu0YzsfhVGrK6pePEKNvUaKtz1vJB/v/vqTeB2dNEWystMv5vDagcG
	iSYblyMGI4DJMJ+WjInHPZq3xmhj8dIVbsS0nv3kKsgxe4a9TgP/n64IZNlLFVt1krFGoPhVVdW
	+GApnCVedmedr4STUCAm1BQJoRiyB90zHsLNEEAj1Cx80fjX6YlUKMHyf/5c5EdJqvOUlBRXObP
	FmrI4hp5lf4JWKEkmm2SiJ9pYfaSobaHkbeyng6T43Yd1GosZm/SIxWlEfkEk=
X-Google-Smtp-Source: AGHT+IFDF32N4mQwATZNCLz25QLEOkKmOIRWCMujqX0ZzKlzsSNpONZ53k1X0A26W9ZzFOaKPw2IjNpPtPK3sfm+wg==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:7487:b0:6d5:df94:b7f2 with
 SMTP id 00721157ae682-6dbcc579a34mr1597487b3.5.1726255248865; Fri, 13 Sep
 2024 12:20:48 -0700 (PDT)
Date: Fri, 13 Sep 2024 19:20:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240913192036.3289003-1-almasrymina@google.com>
Subject: [PATCH net-next v1] mm: fix build on powerpc with GCC 14
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
	LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Content-Type: text/plain; charset="UTF-8"

Building net-next with powerpc with GCC 14 compiler results in this
build error:

/home/sfr/next/tmp/ccuSzwiR.s: Assembler messages:
/home/sfr/next/tmp/ccuSzwiR.s:2579: Error: operand out of domain (39 is
not a multiple of 4)
make[5]: *** [/home/sfr/next/next/scripts/Makefile.build:229:
net/core/page_pool.o] Error 1

Root caused in this thread:
https://lore.kernel.org/netdev/913e2fbd-d318-4c9b-aed2-4d333a1d5cf0@cs-soprasteria.com/

We try to access offset 40 in the pointer returned by this function:

static inline unsigned long _compound_head(const struct page *page)
{
	unsigned long head = READ_ONCE(page->compound_head);

	if (unlikely(head & 1))
		return head - 1;
	return (unsigned long)page_fixed_fake_head(page);
}

The GCC 14 (but not 11) compiler optimizes this by doing:

ld page + 39

Rather than:

ld (page - 1) + 40

Causing an unaligned read error. Fix this by bitwise operand instead of
an arthimetic operation to clear the pointer, which probably
communicates the intention of the code a bit better anyway.

Cc: Simon Horman <horms@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

Suggested-by: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/linux/page-flags.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5769fe6e4950..ea4005d2d1a9 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -239,8 +239,8 @@ static inline unsigned long _compound_head(const struct page *page)
 {
 	unsigned long head = READ_ONCE(page->compound_head);
 
-	if (unlikely(head & 1))
-		return head - 1;
+	if (unlikely(head & 1UL))
+		return head & ~1UL;
 	return (unsigned long)page_fixed_fake_head(page);
 }
 
-- 
2.46.0.662.g92d0881bb0-goog


