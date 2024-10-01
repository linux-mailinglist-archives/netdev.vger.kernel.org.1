Return-Path: <netdev+bounces-130762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090B298B675
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A6B1F23075
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4521C243A;
	Tue,  1 Oct 2024 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFIyGyQ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EAD1BF33C;
	Tue,  1 Oct 2024 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769638; cv=none; b=pVudCHgQW21OT7z0imqU4Qv8TqGOuKjkTbjRh28qtxj+tcy2niQ/uAkxc04CR4aWtz08iHfn6iWS5NwF2tDq52T0wYGczcOX0qt3Kq8KVqYkIxMe4dzRKg3hXe9BYkDLhoyKmM8gUaQU1rIM0P/za6w4FhPxl84u2+B6klQqJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769638; c=relaxed/simple;
	bh=iLDhrZd6nqm8fibuYV3aF+o5WHXEJKdLMLwqzDI28AU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qp9EmXuYWRCRY9+APquZkan7l8DnCXjIxq4QV7ZwQAZfBX7elb+9u8iBBYlpJDL0etDQB+Yc/yaD2CLkOtZ1mrzsDFYfWySVPixuwZG+PjNjgY8/yhHajHyoNQwGQFN3152+7yvfLJ0HggZAOH3sOoRK4Ob1gEON3W1MPrdRlhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFIyGyQ5; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7db90a28cf6so4436626a12.0;
        Tue, 01 Oct 2024 01:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727769636; x=1728374436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58g1IecKWl1H+iaQbjvUK7bF9Ui/htls5xzmgF1E8ZI=;
        b=TFIyGyQ5aK4UbFAYjE/IieN+ic4FG95jBQONHlD4MA6Yez7g/jjG0YEToDY20Jb+3T
         JKpfoYz3DnEuXnSmzw9hlMVgERRZzRdrx/AH8XzB374FFqMdSlnlrL3vLGYgHRHZHMQJ
         VaWILIcuFQXJOUQ5emr7qpNiBzMEkAj7Y2Gr94vPVs7GDN0b+8b+csdbY7OuRuhkEODi
         Ful7jZUNBfxbPtgC1icJyKDMIoAdv16T4vtCqjuzCGkmtFcxp/HnE2Uwgl98+6trhIwM
         Qu8NyYsPp8ueL43sHIPipOMtYs74AeHW4Oi7d4iaIiCJ3amx6qhCn20GEIN+aMeAmbQm
         2mzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727769636; x=1728374436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58g1IecKWl1H+iaQbjvUK7bF9Ui/htls5xzmgF1E8ZI=;
        b=KQKR4uSsfQ0XWfqGgWRhrvQ9m+aIWcWS0aHjsb3NzZk+UCk1pow7jjFQbPEJ5owkKD
         fUeYzbpH9x+kAsZY8ufWgEGsmWZ2YxFPFpDDb+/yzZJtkZdJBTFS0i3xzvlqEt/196rS
         OpFfViDiZrrGt7e4pUUPqgQJ0PsmvR187ITezCRk+wZWUNEYk92Z/wFRTF+dltzsOsD5
         mSoSY04hZ/CcLmekujuF29OIm64ibqzT/nBaPyryQp+vqKHxEz41SpZYALTrWvCDg/tz
         0jmzORXnPU3+nolQ0SDWDf+59o4FTuDkbWciVJNqbI8Xrx00xmUyXPbXziJZbTKcCFLg
         BK1w==
X-Forwarded-Encrypted: i=1; AJvYcCXCTU7jWGUwTLcySuGOJ+tg7UJWhPDz9clywkRCfMkDM4pCdOnNVszUE+0BBwZDsJORVURsgZfvV7ReczI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDnH+xQ90bX4VBU0O+E4VxTJ+52UHI3PluPdoOA6BJWNACBnnh
	ObDi7I+K2MvmuHsy2ST/LwS3T69LvDn8Eq/VTKfkzMHF1jXdUvuC
X-Google-Smtp-Source: AGHT+IFkOrisr6bJa2UOCN3zarGX2rCOWIi7W7XMuVBjqkfitwZ6FuLO7hnxX6vN3kxpJR3e+Jpj5Q==
X-Received: by 2002:a17:90a:6f82:b0:2e0:6c66:8aa0 with SMTP id 98e67ed59e1d1-2e15a3442c0mr3491904a91.17.1727769635957;
        Tue, 01 Oct 2024 01:00:35 -0700 (PDT)
Received: from yunshenglin-MS-7549.. ([2409:8a55:301b:e120:88bd:a0fb:c6d6:c4a2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e16d6d2sm13168168a91.2.2024.10.01.01.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 01:00:35 -0700 (PDT)
From: Yunsheng Lin <yunshenglin0825@gmail.com>
X-Google-Original-From: Yunsheng Lin <linyunsheng@huawei.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Subject: [PATCH net-next v19 14/14] mm: page_frag: add an entry in MAINTAINERS for page_frag
Date: Tue,  1 Oct 2024 15:58:57 +0800
Message-Id: <20241001075858.48936-15-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001075858.48936-1-linyunsheng@huawei.com>
References: <20241001075858.48936-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After this patchset, page_frag is a small subsystem/library
on its own, so add an entry in MAINTAINERS to indicate the
new subsystem/library's maintainer, maillist, status and file
lists of page_frag.

Alexander is the original author of page_frag, add him in the
MAINTAINERS too.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e71d066dc919..6d8e0c4c4780 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17492,6 +17492,18 @@ F:	mm/page-writeback.c
 F:	mm/readahead.c
 F:	mm/truncate.c
 
+PAGE FRAG
+M:	Alexander Duyck <alexander.duyck@gmail.com>
+M:	Yunsheng Lin <linyunsheng@huawei.com>
+L:	linux-mm@kvack.org
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	Documentation/mm/page_frags.rst
+F:	include/linux/page_frag_cache.h
+F:	mm/page_frag_cache.c
+F:	tools/testing/selftests/mm/page_frag/
+F:	tools/testing/selftests/mm/test_page_frag.sh
+
 PAGE POOL
 M:	Jesper Dangaard Brouer <hawk@kernel.org>
 M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
-- 
2.34.1


