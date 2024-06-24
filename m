Return-Path: <netdev+bounces-106286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE9B915AA9
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E0E1F21131
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 23:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842071BC090;
	Mon, 24 Jun 2024 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l92GOFop"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC24B1BBBF2
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271811; cv=none; b=tqWaY0BbV/9SK6f8wpNuDvdU9UnM9uQzJ2i29TIPEpm8XtoZpu/HbgOJhKQd+OsbMrQJME1CwWhjyTkYtylr39NEIEK6axqmwqwZ/CibbOMeA+f3DSpo9Ts7ccDxtMq7q8/nl8cI49txGsQNgnzewdeyO22MeWuVKY1g9a3LiL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271811; c=relaxed/simple;
	bh=yboJ131KH75Qql/fVo88i+jFE+X+ykOpyD/H9YpbbNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fV1CLE5NM4zYaEhEr3yYUh2cWbSyQUe9AfaFNd1Gpw+OC1mi5qTzbGwdU745HMWeEGmiCBND8AyEwMkibJ77rMmZwNTgZa0e4GZAtWGjgYpHfmgJI67WP8wb8Rhd8mAP1qJceFJ9rYr681wT3iiOjHldz3loxv8CQSe3HEvdGKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l92GOFop; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-70ac9630e3aso5433128a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 16:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271808; x=1719876608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HmF+q3rwrhR8UU+6OXTpwv5GaDaD/Y47DiJtkxDn41A=;
        b=l92GOFop5wbZRIETV38d3PhakKrDT3JjgloFcdfd/RlEbh30iM6+807/E+HVEStLPl
         gQzKZO+5qMQlTxd7MmHPYEXInXMiN2RGPizyNYWfz073blTGt/jO+zO2FrRy7JVuhmEo
         sypzCoaJcyxe/H4kPJ/mk915ewHHCYDHajzhZvLEs2udjA+pnX/uDlzSmWdbD1hQB2hy
         lmElSLDbkKIZYuruwCSNdzI/Gfb+XPDj8Rojg4tBkbLmySznMSUufNh0j597Qfi/wXFZ
         cwS9jvCey6+B4I19SC4ZqLS/wUqs2V7ahEkdwA0SRp9zfYI6y/sxVAyNMGvZz5PEVhl7
         ne6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271808; x=1719876608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmF+q3rwrhR8UU+6OXTpwv5GaDaD/Y47DiJtkxDn41A=;
        b=MvXdz7w8BWt3WJxL5UpiHdRZ9jHgymdNmYDHuf4IYahfmWgtWSrPZ3emorew0669gb
         YMaHq/yEEDdlcMivZEKwuMAck29oAk+RAQ4bXp9k2QFmtFv+SxLEuxLnF2fyEhWYhmxj
         DtmDLf0fgA0t9MEizN1oFy4XtnNyZ5VBRq9vzAPRJBCVg4dt83N7ejAc7zkyocP2NKJw
         W7NOfNRhYXDmYI+q+5aTJB4wqUTB6oHvtucr9cho4PL8PJ9szpmOEbEcTpr6ryJ/cLeC
         XOQkNWa3svCRMj0kjHRka/YBPSrIoPw4oIN+XlT9X6LOWc0j7+MxvbtGO6kr0iblZVIe
         wo8g==
X-Forwarded-Encrypted: i=1; AJvYcCXnFE+V8l5Op9gUI9/p4a/t1EM0NBMlax16L8e9MjrwbNYSwnITyACanIIcLCRGVpijNWzVaRPCWlwBtszdWLEjWs5GMaWw
X-Gm-Message-State: AOJu0YwMwhH5q2+zwGYHUVY4zyUKmATBC2+ECUj0bbZlN39bw8pb/DGa
	o3xtfsPwB3DUQSMd54l5+s1gf2Of5MNw+Cwl55gSB2O+svbZWryhaHZVEeGHKgoNMaPEuHxElgn
	seA==
X-Google-Smtp-Source: AGHT+IHcaOj/Ro9h0704QE00MFW9hpEi3kDY+mehE3/RAXufwF49RwalyubuviiuKxGcrX2qWa70mRNXqFw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:9d83:0:b0:6e9:8a61:b8aa with SMTP id
 41be03b00d2f7-71ac38a3772mr20790a12.0.1719271808040; Mon, 24 Jun 2024
 16:30:08 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:22 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-14-edliaw@google.com>
Subject: [PATCH v6 13/13] selftests/sgx: Append CFLAGS from lib.mk to HOST_CFLAGS
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

lib.mk CFLAGS provides -D_GNU_SOURCE= which is needed to compile the
host files.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/sgx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 867f88ce2570..03b5e13b872b 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -12,7 +12,7 @@ OBJCOPY := $(CROSS_COMPILE)objcopy
 endif
 
 INCLUDES := -I$(top_srcdir)/tools/include
-HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC
+HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC $(CFLAGS)
 HOST_LDFLAGS := -z noexecstack -lcrypto
 ENCL_CFLAGS += -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
-- 
2.45.2.741.gdbec12cfda-goog


