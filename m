Return-Path: <netdev+bounces-209865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429C6B111D6
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 21:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A799AE76A1
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 19:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C652ED848;
	Thu, 24 Jul 2025 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l1N7PnLR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E562EA462
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753386005; cv=none; b=J8Sq74OGoLWxfEw+Pt2X/alXrsQ09yrT2bA4Q0tWpU9V1Y7s+rZVON1ANV3GGsYaXREgyqJsoFjLiW4eO/g7ms0GAvrzzWB6hIyY3HEW0v5muYh1aShSuHt95FeScYbS6rjmfjzROfT32Z7blwB+ZvM5yY90o9ydP2tcJ0KkLfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753386005; c=relaxed/simple;
	bh=n+VnwJnyhr06eEF9YeKG/lQVmaosrJ28cWF8TH17r7s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aJ9xY66s9IkxD2IPPjHlLdITGJd/qd6QJavk10OSdSLE81SiUu2cSHIW2N6EgnLpRFADcBhOyQyPE8H+TAzSVk5Dw8fvSPtwzN/T3i9JYJOa1WZoRz/EH0xMGzQHjAj7jisAug5Y7rX5LmdFn9ZnDuWccc8q+r5c1NpDa0HbRZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l1N7PnLR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313fab41f4bso2061501a91.0
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 12:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753386003; x=1753990803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MT3US+bSsiRPpBfgacosyMnvRd6+ev4eL6XBjJ43g54=;
        b=l1N7PnLRChjEHgaG/5vx1du3E/utMcHFl5RDMws3cYn5t/qqwkMykNvaGRpMpxRZvi
         /SUDVbKp8Laa7fiQ9JUg1ACGS2aRpWrzOGZCS3FtRdF2l5JSBLd7XG5pnSoDrNkINv60
         UaiSAw5uLdahVnGZ/UQp2b5kfLhfkoQifSlRja+v3AZSWj8SGBZpJ2/WGIraxSjPFJsD
         /jbYR7KmKIcWlRImbZpZM3LGJkqNwJA3CcZwqgfJL534sIpSCfLFG6x2OEmFDgK4PQAU
         oKEcL3JaTN2czxarOwaS4WeClgcvyPxJOdYeuZj3S7JzjQcpD0MVs+C9MYvXwnKacyEC
         j6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753386003; x=1753990803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MT3US+bSsiRPpBfgacosyMnvRd6+ev4eL6XBjJ43g54=;
        b=M08VHrcch7w8EDx5BIOHWdni3UySPjnS8QVikcQ4+gPJ/NcaSrS4tuJfNLxo6V4E2Q
         oezRomG37UfZtdOEwEwVRlXxJKVnISZuu/544fldNOyHWU0pAOFUymAt6u5ubcSPt2xM
         pWnmHdRWapmWTGlLASLcz6hByd8HYqrd77SJgdhr3/zmttgdPaQvjvk6YRqOUVbQWjAt
         yVV2T9lPTTOsroduDtHrtyQPfd4+qGivDXA+/XeS9LXrETvDGjjbGet0Ade4uxkviKV6
         hwMM/gn9Ci5rAn9QLzjxfOWep4hea3YbqY6LndhTAo4GKT47QkDgPPHC3ni2Yc14ASN2
         b4/A==
X-Forwarded-Encrypted: i=1; AJvYcCW3VR7C7ooJRK86ljXCbOzfCJJlSq3mHnaV6EZqK5WyeJ8S0DyNteSsjT/8mzCXWRrl+Bgnhds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO6/C1dYzjNQmac97W89egv/Dr7B/X9VLzDrF6j3ueaqTOnScl
	skhh1hzrptxwLzr8rl2e8UrPfKrXZyHGXNSDsZegYUFHaVcSGd/n8qPNiYQCXmgbdvwI/gPwITk
	s38bwxQ==
X-Google-Smtp-Source: AGHT+IEt4cWZEBwF3nwLnebBhOCNAoJqHTWbMAwCsGmdP0mt84Z8oNC+l7KSBI1MUHxQBJzvHx0NAjX7rvM=
X-Received: from pjzz6.prod.google.com ([2002:a17:90b:58e6:b0:313:274d:3007])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:588b:b0:311:fde5:e224
 with SMTP id 98e67ed59e1d1-31e5078f4ecmr12925337a91.6.1753386003226; Thu, 24
 Jul 2025 12:40:03 -0700 (PDT)
Date: Thu, 24 Jul 2025 19:38:58 +0000
In-Reply-To: <20250724184050.3130-15-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724184050.3130-15-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250724194001.1623075-1-kuniyu@google.com>
Subject: Re: [PATCH net-next v12 14/15] net: homa: create homa_plumbing.c
From: Kuniyuki Iwashima <kuniyu@google.com>
To: ouster@cs.stanford.edu
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

From: John Ousterhout <ouster@cs.stanford.edu>
Date: Thu, 24 Jul 2025 11:40:47 -0700
> diff --git a/net/homa/homa_plumbing.c b/net/homa/homa_plumbing.c
> new file mode 100644
> index 000000000000..694eb18cde00
> --- /dev/null
> +++ b/net/homa/homa_plumbing.c
> @@ -0,0 +1,1115 @@
> +// SPDX-License-Identifier: BSD-2-Clause

IANAL, but I think this file is also licensed under GPL-2.0 from
the doc below (and as you state by MODULE_LICENSE()), so you
may want to follow other similar files throughout this series.

  $ grep -rnI SPDX net | grep GPL | grep BSD


Documentation/process/license-rules.rst
---8<---
The license described in the COPYING file applies to the kernel source
as a whole, though individual source files can have a different license
which is required to be compatible with the GPL-2.0::

    GPL-1.0+  :  GNU General Public License v1.0 or later
    GPL-2.0+  :  GNU General Public License v2.0 or later
    LGPL-2.0  :  GNU Library General Public License v2 only
    LGPL-2.0+ :  GNU Library General Public License v2 or later
    LGPL-2.1  :  GNU Lesser General Public License v2.1 only
    LGPL-2.1+ :  GNU Lesser General Public License v2.1 or later

Aside from that, individual files can be provided under a dual license,
e.g. one of the compatible GPL variants and alternatively under a
permissive license like BSD, MIT etc
---8<---


> 
> +MODULE_LICENSE("Dual BSD/GPL");


