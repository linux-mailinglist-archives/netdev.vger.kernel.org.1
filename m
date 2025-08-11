Return-Path: <netdev+bounces-212533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 590CCB211E9
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F3307A2884
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6275117B50F;
	Mon, 11 Aug 2025 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlRRa0AG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98397311C24
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 16:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929712; cv=none; b=FiO0wDoIy/a2Xsm1mqxCgeb0dOfFc2Z7Unrn4kyrOCWVRMmRg3qpn/yUhfMUuUonl/EHVzZjhH6g6L7Unw21bmfeFWbrHGOtQAFCg1wkcbkBZQ7Ng7c+FNtimoK7z29HDBq3F2IaS2efjuFzgHohr3wm+BBM6hvQ8TqA/Qq8EkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929712; c=relaxed/simple;
	bh=OthZYmVjAQXZSU8tdPAh/aIimrhk4lm9FU6WQYMA+WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=au6nDP1zsrJHxw2OEkzt4yu/eX/CnAByMxGfGjUJtWoeZ+fc/sod1QHkQjo1D9tQrF7UNZwcFBioUsyftKT2HGh3+9lTppJH2ru6D3YK+AikPQaD4JHykSH0bvtXT9a4QL0TMpxI4aMTOhcFhAoJgbLPh5gT220eK/byJM9GhIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlRRa0AG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-459e1338565so42936265e9.2
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754929708; x=1755534508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cj8UJ5Kho5dtyMmT2Wiw/Wf6VOq6939AtFX2Hk0IXRE=;
        b=WlRRa0AGuaaEjlNML62juFRZK4mYT8pbx8/Xi7eEL4qxDVnCiiZsirPaRJVoNKd2Ll
         iUcCKIls1yc2ZsN1p///Lw9KDwFzGmhgnF4p2YqH3nm6BS4ocXWx9cdnjQ5fSt9U0gSQ
         DR0D641xhIGoumgbu3f9iooBcNGmqgf28IqayipDRGl8MEbHOuLlFgpSjrb1S707q473
         IEM4y6sUllXunRISd4Lt0bSsxJhHnjjyOSQKn4+VBhSc5uT1lov/SJPkXn1oVPb3ASiz
         t/MWebKjtx+R6XHUA+nbsO6G5TBI3ohoMCp9m3x/wJrZa8nfeFcF1vKKljtXiiyhw11h
         MiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754929708; x=1755534508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cj8UJ5Kho5dtyMmT2Wiw/Wf6VOq6939AtFX2Hk0IXRE=;
        b=xOFKyeoS4O9thKXE/ZZ2rb6ih4ySxuQxWsawz/h3X5xnXZtJEs01DO45ffnLoiwbjM
         V6X91v5xGgtiKIAZ517qcGQipE7cd9qFknF72ZYujH3l8xH4XT7VaJLddF11DwES4fWL
         4ayIvF4/T4M1mGQ0R5no9BSEq7Milkf2FWWxcj1++8Yu0Wx+YdDr0jood9/bq0FmLHhg
         a+i0OOpgAKmPWrKKtUBrPBgGh+M3Dwlz8PickiaPW95tqxO9w8fWejx4fgC3Bj6ccD1X
         Rwo3o+61CQ5QrfF3mBgsvHUkIE5SmdXaYnTZ4/4FSUoOkHCnRcnxUWIyYwBc9kZl51vs
         cjuA==
X-Gm-Message-State: AOJu0YwZRkWi1SP0amK/+IGWKxLQTqh3OBE/XjlOUa2XWIWWxhv9gpV1
	U7JdnnBpIqhwoyZ8w3MSCc6lMXIQU0c/HtgRnBFTpPUAVtyFMlS27e5i4voD/A==
X-Gm-Gg: ASbGncutnMllaVsyUTWArwYfcXWwa1IZ4WD67lm9slyTCfIvHVfHk8usHULJ/b9q7Ou
	95cL0MF7oBYe6qpGhFIlMkCVzaJtkkoM7bM7XQFkaV5u3Pnc84ZBw6xSvrjPsj51l2U1BzHqUJV
	mNl8JuNvDL+Ugcn1m38lA9MvXNt9pa35slMRm9EGjStoKDAoe5Hst0S28CpOSassk3iODCksojZ
	ZwrhcTvAoeTkDRGlqnXIMj5gkN+ZYeFCF6biq6KpAo718hh64NJ29NyhH25KQe/wIjrzaLnaFB6
	q2FGzybagaNW8nsCR8Bi79BjPQBw9W8EVxvVOsq3DsndRY1Wq4rkUJE6W4LLMlEgkQS1OJorxyb
	b8T9jRg==
X-Google-Smtp-Source: AGHT+IH2A8t0e+thsg4QiC+1SnAaw1gGgqeg89O3wcKaQoPj6Ehev3IIVzhyWvLCwjd/0y0XUHyzpw==
X-Received: by 2002:a05:600c:4e91:b0:453:6ca:16b1 with SMTP id 5b1f17b1804b1-459f4f144e5mr114233465e9.26.1754929708395;
        Mon, 11 Aug 2025 09:28:28 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:628b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58554f2sm260267515e9.12.2025.08.11.09.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:28:27 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Byungchul Park <byungchul@sk.com>,
	asml.silence@gmail.com
Subject: [RFC net-next v1 1/6] net: move pp_page_to_nmdesc()
Date: Mon, 11 Aug 2025 17:29:38 +0100
Message-ID: <a85b5aeab5f011742657a9caae22da5bcdcf91b1.1754929026.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754929026.git.asml.silence@gmail.com>
References: <cover.1754929026.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A preparation patch moving pp_page_to_nmdesc() up in the header file and
no other changes otherwise. It reduces cluttering from the following
patch.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/net/netmem.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index f7dacc9e75fd..8b639e45cfe2 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -217,6 +217,23 @@ static inline netmem_ref net_iov_to_netmem(struct net_iov *niov)
 	const struct page * :	(__force const netmem_ref)(p),	\
 	struct page * :		(__force netmem_ref)(p)))
 
+/* XXX: How to extract netmem_desc from page must be changed, once
+ * netmem_desc no longer overlays on page and will be allocated through
+ * slab.
+ */
+#define __pp_page_to_nmdesc(p)	(_Generic((p),				\
+	const struct page * :	(const struct netmem_desc *)(p),	\
+	struct page * :		(struct netmem_desc *)(p)))
+
+/* CAUTION: Check if the page is a pp page before calling this helper or
+ * know it's a pp page.
+ */
+#define pp_page_to_nmdesc(p)						\
+({									\
+	DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));		\
+	__pp_page_to_nmdesc(p);						\
+})
+
 /**
  * virt_to_netmem - convert virtual memory pointer to a netmem reference
  * @data: host memory pointer to convert
@@ -285,23 +302,6 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
 	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
 }
 
-/* XXX: How to extract netmem_desc from page must be changed, once
- * netmem_desc no longer overlays on page and will be allocated through
- * slab.
- */
-#define __pp_page_to_nmdesc(p)	(_Generic((p),				\
-	const struct page * :	(const struct netmem_desc *)(p),	\
-	struct page * :		(struct netmem_desc *)(p)))
-
-/* CAUTION: Check if the page is a pp page before calling this helper or
- * know it's a pp page.
- */
-#define pp_page_to_nmdesc(p)						\
-({									\
-	DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));		\
-	__pp_page_to_nmdesc(p);						\
-})
-
 /**
  * __netmem_get_pp - unsafely get pointer to the &page_pool backing @netmem
  * @netmem: netmem reference to get the pointer from
-- 
2.49.0


