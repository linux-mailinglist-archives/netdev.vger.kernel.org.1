Return-Path: <netdev+bounces-218756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85679B3E4EF
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 15:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A271A8485D
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2284030BF7B;
	Mon,  1 Sep 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OsEF+cf3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F29F27467B
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733283; cv=none; b=L8UTa1+9wQHsmoX4gpwOhQiXwvY/9sehg78Llr3FfiPLw3vdlKiCWm8UYygAJ8DufyieqiKObuD0cr1zgTaEEEANBTYHRwHLOducgnQF0J+FgDRAMOr60/MuKRnMGZKRAoaKWNOzxrBMpwuMd5XHdVMIL/lZpWhBU69JzfVkqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733283; c=relaxed/simple;
	bh=6O9zYzknF1XakScCV4bBbfOhUs+802B4MkwhMeX25CQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OSyMIYcOH5DFdqwOmUJHv+EcEikH92M38GSRzG20YV60W4njru8kOHdg2nyday8BTfn0SQX0dANFnAggP/tq/y1T8Mzx72C3SZwTyGGxFc16FXPhuVf8TgOSfcrGuh4jMb3bw9I/zeesWEfNHEZZAbLOcgI9/cJLbZF1Tf8FE+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OsEF+cf3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afebb6d4093so724219666b.1
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 06:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1756733279; x=1757338079; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SvkpV4Bq+rj+YuFtB7kDJzqT2KzLsgVk2R2l+HFV7nw=;
        b=OsEF+cf3p0AJ11lNHUNClDHP6nWkirEYx9oIikOVDY4YGzA3MKCWDPWrbV40SJUkKa
         iiPOttNGWEBdUIVFu0y+7ab8zJ9HFToySbXdcF8YYOvpinQ9vdretF9rQ1+4+onGg9iW
         SwUKXzC4mShTE88Ry/eEiUGH+zh6sYsNhDb7T3HnKKvnLhCl5xgu2TtLJ+g1jCBhC+zd
         3apYAQlu3RdYzm3Kn/fV5zWJqx1yZ0zgoUVeA/ALH+or7I4ZgAT+SbnniQQguDtcBkJA
         ZuZaYXpGlC46S35fp4+QPin5lw+vWHGd4eJMgKN3HirunSnPJSvYw6ADqm2NI8fvc6sZ
         salw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733279; x=1757338079;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SvkpV4Bq+rj+YuFtB7kDJzqT2KzLsgVk2R2l+HFV7nw=;
        b=UazrOGGLY2oXKM2hNXA9HKfG8r53meCw2kvuo/1yEFhu+Ary9GknSx8Hjk7cPpFc9k
         AE66sX1sW7Uzpu+hD7AXMVyCV+ixUFckHOekuoY3LLU5F17X0O+m+39JfbcKrEsl///G
         /OdePQa1tPWaOofawMFaSDlPcGJXyEnZee2wTY3hTgpjqE1bQa4iGWW2j4SGDfLtBB+l
         lwve8CNNrLcDqNBOPkqL4Rh3wYu5FMoyIxK2k9DQszWoQyf/za0xYqlzd1ikyW+CJ35u
         R6K8Ky0DyMxGVcvtZ3AZPAsHJKrBbc8zOjuucIYk8jex0+LOJB+NSWwAZcqFL3RhZnin
         IeTw==
X-Forwarded-Encrypted: i=1; AJvYcCVMBgfsFRAMmyzAuTHv2b2BvBqHab/1MctrOsdtYKPd6RUggBDOhWFsjeWOZNYEVAITzHY2ldc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySTHT9xXPd/JDb4Gf1wWnssgkUsMnL/IePNOpX8uI7GRvpYpfW
	w12zFOH7XFXD8SJLESBVPWknuonJ4t60tPsCEiz7NApWF4siauzt0Q+nCTBDJdQc8zI=
X-Gm-Gg: ASbGncsigwzONHzcOtisKY5Cv6uhG8a4d+OumCKUGWmmZfZR2jeQxPGdDpWK8HQqDMg
	A27nVGeP2dsPQwPK6gzrZ4U8Zl6WIUDXbXGi1MHzzJ06yT7+xL9bQZHx0oSkgRHHUCjmMN3PjYf
	JsENjY5sgJ1hVzLbRuBt4kCEVQxDFeragNAwkQgnEqVAMerVD5JH/kg0UxAlyRkteeQxK+jr+k+
	mVpNqOIdzlOf4Ha2n1wYCRF8049TX7WQxCDVMZWQquwUIuhV+VkrquPiIrnXqV+pMs8J9r+kOOM
	uXxunOMnKGQZ+ABpHSptYeCvXC9rSsfyxVR/jZGKYWj+07bMBVI1GfgGLVzLdB0rss/MsGXmGKJ
	e/orwAAo9l3Ozl8JYOXHoxbO/qw==
X-Google-Smtp-Source: AGHT+IEh3AaonZ5QJBkOf1S6UvYDoHMiIZHdv/ST35c9pqz9MF0Ajnr6x/W5jLydJXe0NqvFsZyLHA==
X-Received: by 2002:a17:906:f5a2:b0:b04:3955:10e2 with SMTP id a640c23a62f3a-b0439551a93mr223405766b.25.1756733279510;
        Mon, 01 Sep 2025 06:27:59 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:295f::41f:42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc5315c7sm7074508a12.46.2025.09.01.06.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:27:58 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 01 Sep 2025 15:27:43 +0200
Subject: [PATCH bpf-next v2] bpf: Return an error pointer for skb metadata
 when CONFIG_NET=n
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-dynptr-skb-meta-no-net-v2-1-ce607fcb6091@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAE6ftWgC/4WNSw6DMAxEr4K8riti8e2q96hYQGJKVEiiJEUgx
 N0bcYEuR2/mzQGBveYAj+wAz6sO2poU6JaBnHrzZtQqZaCcyryhGtVuXPQYPgMuHHs0Fg1HlDV
 JklXTqJYhjZ3nUW+X+AWDG1Npi9AlMukQrd+vx1Vc/J98FSiwoKotZZHTIKqnnO1XjXPv+S7tA
 t15nj93RkZZywAAAA==
X-Change-ID: 20250827-dynptr-skb-meta-no-net-c72c2c688d9e
To: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 kernel-team@cloudflare.com, netdev@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.15-dev-07fe9

Kernel Test Robot reported a compiler warning - a null pointer may be
passed to memmove in __bpf_dynptr_{read,write} when building without
networking support.

The warning is correct from a static analysis standpoint, but not actually
reachable. Without CONFIG_NET, creating dynptrs to skb metadata is
impossible since the constructor kfunc is missing.

Silence the false-postive diagnostic message by returning an error pointer
from bpf_skb_meta_pointer stub when CONFIG_NET=n.

Fixes: 6877cd392bae ("bpf: Enable read/write access to skb metadata through a dynptr")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508212031.ir9b3B6Q-lkp@intel.com/
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v2:
- Switch to an error pointer (Alexei)
- Link to v1: https://lore.kernel.org/r/20250827-dynptr-skb-meta-no-net-v1-1-42695c402b16@cloudflare.com
---
 include/linux/filter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 9092d8ea95c8..4241a885975f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1816,7 +1816,7 @@ static inline void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off, voi
 
 static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
 {
-	return NULL;
+	return ERR_PTR(-EOPNOTSUPP);
 }
 #endif /* CONFIG_NET */
 




