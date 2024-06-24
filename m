Return-Path: <netdev+bounces-106278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75347915A81
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9CA286080
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 23:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91BB1AC42F;
	Mon, 24 Jun 2024 23:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JsmpU7pO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C051AB35E
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271766; cv=none; b=lpCsL3TFv6v+Le6hXlG/CsZZd9Jlmvu1RjUhNHgJ6UNCCKP4e1K29jYMvDQ4cVwfn1myU9sshMketOKgpZm1pIObI0BKpz4s5veg6t/Jyy3kY+SBB8gwsIiodlQyEuOtCSsbpzaK0eQ6wA9Blb8y0bHAgCyB6LGeo4JR8FkYJAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271766; c=relaxed/simple;
	bh=J8ziRZLZ6OEx+woE/eS0qKgArMtBUzmObf9KlKhPFtM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=je6YuAv14Two59ZIeBmAHrZAYHciEuktZzghGWTP0uetHnWGHAqjDPDMTaad1DMzsvrKEeZhOXfzDi9NFX3by8n5RXuT8bNipRt1RaO8NIIKZtj4u6TajXLnf3beSaqY2QtptCkZFjRGIQZivw6eqpDT5h3HkSHO+FfkrAAgLLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JsmpU7pO; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7065ba27265so5056427b3a.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 16:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271763; x=1719876563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fldosNIASu5foth+y++2astaddaovQjRCjbJvozT8Ew=;
        b=JsmpU7pOJgpB/KfAdoRKL4BbFDqPuXOVMZBwyLMRyfDB3ZXsc9vBQ8eONaGJ1PVSry
         OCJwDri/iU1QRSFh691va+oP61gM42lTsVyn/wbzlO86MjID74C1OZBta7UwnVuvjf6e
         cannbyUjoe74qL1F09QpxaeN71twaQN0hBlId5iEVxqPzPCb4nID+XKydr9Ym7niRFnY
         mUJ9KHgO8+CHFAIZN0gnCUNNIMq5dapBdXbl+RVnlcQwgfaNLnU4uyPWRFNjVbdCK7xM
         dzW4FeiSY5/srawBlx3/SDtuj6l8qTtN0nCdCZkJk76k1xUjtN3kiIdSD+bXCA5tB6y1
         fLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271763; x=1719876563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fldosNIASu5foth+y++2astaddaovQjRCjbJvozT8Ew=;
        b=B34aeThg1rmnwgmj3BiH6mUXkm7e+LzGvMEK6n+3Nw6CJOvePkx3xSMexUCGITKDou
         FZGq9JXaEHY8JAGzw9u6mJSwPdGJ2R3JSQ12gO/n2Jf11QpHwMxVfX+w+sg//XfpIbeK
         LcxJvaRStDYHQWCwXhMNVcbZmextJw2cYvgV9/c81O/LUZPjkmx03Eud0gBHavv46rsW
         jeWCFwGnUy83+vtTMA6dpdDYRPGOPAOSiTAVOwCD+s3ZCGdGFeUC+sCpLkSWO9fM4/Ql
         NhkJCSiaK1URZCCC7Zb/c/882QOL7vqLGXcwezSqLEbPSFxg5wBq7HqbICgcB6uZ0ZyW
         i1mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoWW2ybE1aMNSBHstajUQyk+OTSv2JdPEv6+8sSwefpR9GLINcj4jZvjV1kJ6xQWhwnrafw/2Agrs9Uzusn1hd1Ark8Y6F
X-Gm-Message-State: AOJu0YxjOd15zcWPkKNFPoR9T0smne/tbv7AKZvUXLkUpnkqnQs/+nhB
	K9SggPZxUovL5Cd5pBGtqgUTLgOTyJOtqzaL//0PxhsIsk+yLDZVLBvmaOTR1YG5NQHnrP9wcRo
	s9g==
X-Google-Smtp-Source: AGHT+IHgIjs0ZNjmgMymaYfJ8/9bZ93vYmLowFGFa4rCwsJRE0/Jc/du7SfPX0zd6RD0YkkBKKfvO6Hly8E=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:908c:b0:706:3421:7406 with SMTP id
 d2e1a72fcca58-7067454bf95mr299109b3a.1.1719271763360; Mon, 24 Jun 2024
 16:29:23 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:14 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-6-edliaw@google.com>
Subject: [PATCH v6 05/13] selftests/futex: Drop redundant -D_GNU_SOURCE CFLAGS
 in Makefile
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

-D_GNU_SOURCE= will be provided by lib.mk CFLAGS, so -D_GNU_SOURCE
should be dropped to prevent redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/futex/functional/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 994fa3468f17..f79f9bac7918 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE= -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS := -lpthread -lrt
 
 LOCAL_HDRS := \
-- 
2.45.2.741.gdbec12cfda-goog


