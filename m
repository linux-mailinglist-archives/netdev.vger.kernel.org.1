Return-Path: <netdev+bounces-106274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA52915A69
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66D71F213A9
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 23:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829751A2FCF;
	Mon, 24 Jun 2024 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fFnZmnvw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC341A2FBF
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 23:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271743; cv=none; b=BgEjGv2Y/1Xx9cd5YUsujkM3TaZhbBfEaE5kb6xXU32zlrddg5jtvJ31Nulg2a0H8bntRnUu4GBr7FN32ZaLhANo5SYMNoy+BlS/uOdpAzeVT6J9a5fPOFVkhIisVPNBU6d2uOjwqB6p+r25Vmq//pAyfv6MypyN6asf8GxkaEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271743; c=relaxed/simple;
	bh=NqMqA7QWqr9/+mHOdPi0hG2A/sBfX5GGxqySZ84bEFo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f45qU6+9zCWopIcTu6BNzFq2Hv2gMECBGg/5Mjv30eKySzA+xNTYs9PdIm071IRwNVLHzhvXhjYDoWkwN67YVg8vbWI2JjvnC6W8Jx8SLGB3EhwAzDurV/v927yMMy2VkqHT95WwdQG1HLVMLNup7BkXNYjxlEBNfAnnNia1SaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fFnZmnvw; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6c7e13b6a62so6217237a12.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 16:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271741; x=1719876541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FvMNQZepmevKVYCWA5Mvt/tIAvZEAV28z8ZXGZ1r5A=;
        b=fFnZmnvwS7MKFZpI2jZMbCpkc1fBRNSkoC0KwtyJ//fyUSbZ5X7qFRT22trNVHNbwH
         7hKGXsTVw8DsxkPINXp4UyNONQ0xtStZnBMMB50Qz0DqWUW4UIMVG71me7g/KZzsf1p9
         iLgKVe7bNnsQVW3vMyqwwum4CvlzWjxiFZ1HfNScTjY/HG4RO1YDuK0/fIJgQI0er74i
         YQe5HcwABIwTtd60FVLPOwNe8zOvM6GlKnmAhSomrs0eDER+eGosM9jV0exbdhtsCTYg
         fP2AaGSFbYc4PQEvAIRaVPD/220sTNF2RIhdRVfy5cFWDBz0R9+HThNNdPmt1AzPkhBU
         1dGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271741; x=1719876541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3FvMNQZepmevKVYCWA5Mvt/tIAvZEAV28z8ZXGZ1r5A=;
        b=OV90nRdWS+5RLjBaSWdEB9NGoNrMVypqzYZ4Q3N0cBbR+VcmPGSs5nXEcHSbQ3qfu6
         ZTO0t/3Jg4pOu6E4Zk0k5NT4k+9tBXsbnYqi5uiKzU4QTLPX0PSfe+NNnqW59ymcyAiI
         lFSgfQmn+gNDIqMR7lqd28dClCH5YHuB9urRaJDekwr9FnHkc5Inrj/tgIolCMktxLIn
         6t/WivV1zyEAxe+yBAhGaheZq5iqOOlpysJn0qVgy9hsf3xGCTFcwoHtM0kUAwExwlYa
         zTKU44RvRXqsHuv41xHR5kRqNqSfadg6uZnCzqnXRy52WMyeDUQmXoOjOWiHjxcNz23A
         /48g==
X-Forwarded-Encrypted: i=1; AJvYcCVJvi/+8Sj5U9Khb5I157fTxs2HkoElPYxzdLBzO503lwQ0XdwGOmMDGuU5JyIxaf8P7GIQkML17irOazLdqGCKQ7mGmdKE
X-Gm-Message-State: AOJu0YxfT2wiz1qIuG20AIC2QHac5BfYyq0Z5+JhO01oVU1sYPF8tbvo
	Mwwi4QWqiMmUeVcMd7auFeI/uj4ip5pTGNd+p0smwz6Xl6Fe5t6h+FPx1pPnQ56z9v/6BR06FNu
	kqw==
X-Google-Smtp-Source: AGHT+IEk+3lC5zdyxifyt4ii+6a16n1y8uZeO7DOAPkbXtiVBPE0qfgp7g0LpuESyv8BZuXBXF4M/RvaOF4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a02:4a7:b0:655:199c:eb1b with SMTP id
 41be03b00d2f7-71b5fe10537mr20071a12.10.1719271741168; Mon, 24 Jun 2024
 16:29:01 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:10 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-2-edliaw@google.com>
Subject: [PATCH v6 01/13] selftests/mm: Define _GNU_SOURCE to an empty string
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, usama.anjum@collabora.com, seanjc@google.com, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use the more common "#define _GNU_SOURCE" instead of defining it to 1.
This will prevent redefinition warnings when -D_GNU_SOURCE= is set.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/thuge-gen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index d50dc71cac32..e4370b79b62f 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -13,7 +13,7 @@
    sudo ipcs | awk '$1 == "0x00000000" {print $2}' | xargs -n1 sudo ipcrm -m
    (warning this will remove all if someone else uses them) */
 
-#define _GNU_SOURCE 1
+#define _GNU_SOURCE
 #include <sys/mman.h>
 #include <linux/mman.h>
 #include <stdlib.h>
-- 
2.45.2.741.gdbec12cfda-goog


