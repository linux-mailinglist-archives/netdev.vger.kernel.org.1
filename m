Return-Path: <netdev+bounces-95084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888838C1652
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C2B1C22CE7
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571E71386AF;
	Thu,  9 May 2024 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMGqhXRp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27141384A9
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284917; cv=none; b=BhZm2XQSjFzeyJQ6BjDoUe56zND4gecZfWKEx2R/IFaLb8YEEntpJAMMcPBVPn4dw58opd94n6l/L1KmdKhKJ6g8D23hoVVgvmR59q7bwMPaBO2fogssSMmTkZpvFaFwIcecZop7AKJAWSmaR4XNA+w6b91vJBOaNcx32Gd6GDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284917; c=relaxed/simple;
	bh=lWLGmZvaxA9RBlByfmCfZky8EH90Zb+6S+z65rzDbew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NcQo8RI6hBEsJ8Q1uKq27Z1b02oYbav/wYfi25EDH4eH4Ezdm3kEH7tYgtl9kG0QMDH881qqaOj27oRNJOJq347CLI1HF0nZcp4thzTnj5PLndWiUdLlkOZdlwgGYtlNm9DtXrwh1n1rSxdjEOF0Oiq7f1aSGmssg/K1qtFkrvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bMGqhXRp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be5d44307so19671697b3.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 13:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284915; x=1715889715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hWPJomGop1o1vSO/WNR00I+KyAYhO7ZfPBKMyVYJ3k=;
        b=bMGqhXRpecO3D6FFX7NPimCA4hS/TN+qWy7xAikSq6ZRHE19E5VcBjnz+yzGuSl/le
         7MaEqbZ+5oZ35HepiEKUenSkM/r5QwdhkiJhUIpEjeSwN73VS6y/fav1H5Fh8szqveBn
         TwvX1RDXjXFpop/kFj1xttSlxffHOdXQj6sEwomFN9o6wsP+LU+ayufYHIdYGW/gW/4F
         +chjslXanSEOIOkmcZ6EGXNuvMsay5GuLaIc1nrF2fJhtHLuWvyvg/yLTL4cwKpPb/ea
         2VIo/NvmlG4ZJ1J3VAwR9DAin1cZM59CxD1i3ZDc1N2HgFQebiqFp+j4PESz3+kN6VMe
         hIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284915; x=1715889715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hWPJomGop1o1vSO/WNR00I+KyAYhO7ZfPBKMyVYJ3k=;
        b=LgutQSJCcPSTwHmT+PhVsH7aKkeGc+IPpgctj2pvz09asBHcZyGmsEa/DUFtcAiFGA
         sQrgyxh6jj001K953oL5zJdONlljsGh9UzH1hOSobCQ+9+Y/0RO2yKxylRjchokF9I4+
         RkbGek2MNwsF7f0eXF9epStYFCjbJWsa8UsORhH/mbCPBHUfQZ8StjTvsvggOGWVC5/K
         LzAkpUV1omerOY2QVLTJ5V296TIi6AvqQf5VSa7bdKu32I3LRXXZKsHmYrA6unxp9gOr
         3ly/tQkv+N2vOpclU7USh9uzi/Gz/dQNcjMU9Vu8vkAxPzstpVefZJzhSWYfn3eee4yr
         /rcw==
X-Forwarded-Encrypted: i=1; AJvYcCUlI5fh3Y0KybLzVAtT28vvn0K8iqgpMlCdc3S/LUoPh/YcbGdYA+7p1TbIvn974jcfEZwzbTSdiC3Pr4KX91eWL5SHS9sd
X-Gm-Message-State: AOJu0YzoWMYAPx1jY9ANEQg7BemPCSYBvy0dIyosZ5xAlUu5qUDf9g/6
	hYnyn005YT1KGLd/RLymp7Q5cNz4VVyd3x8tfJgJAJWK70TfAfBMO/RAAz9Jmn0Fuxb+ruSMrT8
	BZw==
X-Google-Smtp-Source: AGHT+IHpbKZq4QkjTflQ8ArARtMBvh0PZ9C9VKKW9QcnoVDxM8W2W8fLFQ/oTQAQRdxFasvDcO10UKeRsB8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:490d:b0:611:2c40:e8d0 with SMTP id
 00721157ae682-622affa3fadmr1378917b3.3.1715284914803; Thu, 09 May 2024
 13:01:54 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:16 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-25-edliaw@google.com>
Subject: [PATCH v3 24/68] selftests/iommu: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/iommu/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
index 32c5fdfd0eef..fd6477911f24 100644
--- a/tools/testing/selftests/iommu/Makefile
+++ b/tools/testing/selftests/iommu/Makefile
@@ -2,8 +2,6 @@
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += $(KHDR_INCLUDES)
 
-CFLAGS += -D_GNU_SOURCE
-
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += iommufd
 TEST_GEN_PROGS += iommufd_fail_nth
-- 
2.45.0.118.g7fe29c98d7-goog


