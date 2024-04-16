Return-Path: <netdev+bounces-88394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDA78A6FCC
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 17:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D82C1C21453
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 15:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CBB130AE5;
	Tue, 16 Apr 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boNFkvFx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE1C130AC3
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281367; cv=none; b=TVsHiTw/ntiqRIL9Gc9s3FgsM6BLnHcC+UFxNGyRzaBnFGjCSHjwykB389ZZGSzGWcH3QCzFmJyk1avyog0dpxNsBF84o+9JHuBb9y/OMReTs6mTXeQUlbzk8c8ezFdcc4QffDqSq+XMKkXFGSkeUlx5ajH4L9639/bJWZtVOAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281367; c=relaxed/simple;
	bh=QVMyCi85OBTLwvKYhGqmV8c15nSsfnt8Qk+CafeDfY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiOqqa1y/zzgVu+cVkQlwi8/EOaay6QipcLCtg0iyez9X3k1iFrPfe6qmn2SqfMJN1FRR01UautHgdxcuPc9BV8Rjrkf9Zy6sxfep+d2pwo2gngH9cT42KHNDJ4WLMfp/FqxFzJFPKjo6ut3tN1otra2kzs7t8aWfFShrmTBnB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=boNFkvFx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713281365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6P0LUfI2AvXIK+dBsLwCwt18efQKG/JZH1UkFxx8/Z0=;
	b=boNFkvFxXovJbV0gWSBoA8Nu1QFe7DAFjsQ2i3FxLgY+DABpHQex3qpnAfH9FV8mWth5lc
	GQZxTBEw1Pd9csH8NdV2ZnaRlQ24oZis+K6NN7LqaZEBj+EpI74mOILCRmRrPWaNZ9KegM
	JQyDWG+1zjpxiq/30gIULHlJp482wj4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-vBWE3_6nMqWjV_uK4uxM0w-1; Tue, 16 Apr 2024 11:29:23 -0400
X-MC-Unique: vBWE3_6nMqWjV_uK4uxM0w-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d9ebfd9170so41237941fa.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 08:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713281362; x=1713886162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6P0LUfI2AvXIK+dBsLwCwt18efQKG/JZH1UkFxx8/Z0=;
        b=eOM4fvOInOV2ONMEZGlYA6lQJ8nnYeEI8kvA2AmbVinmg9I+5SsuXfFb/BO17l1i+J
         0iIEp5VxRRhjPUx0/eOX1HfyAg8N8/30xMF0XX18MhrhtMbevj9t++yf6gMbfNGeUETu
         NvNOQxoUkpFkbHaHZh1RNbMVaaH3pQ/YM/Hup8Qg+waIMj0FvbhZOK6w9TA3jBMKC1fz
         NSZW09Pxit4rB1/wJrHXd6WS+P4BrncbTE85JTy+dEPYP2IbNzSG9FbLwakwc8DX8APb
         kGnvnUZjOv6AYcMBODJumlm7/rbbrZ3sUEzo65LKWx7ZlYWqZyYsZFlj9zoSHEmHfoii
         1TvQ==
X-Gm-Message-State: AOJu0YxdibO4z8tz+6mjJEjYNNudHFIkH6J0qxwAMw+8XuSH4WWcITbi
	NPwW7bSx0JrIfkKzLDrZ1YtfHl0PJc2bW2T42TwF7jrqvUfBatWUUG5VjFUicSjYV6BNHo6WVUj
	PixVlaYpzXszVPHWqo/yzX76zxBqoNvkPBfYk8HN3xd+D1GIhNJ37fQ==
X-Received: by 2002:a2e:97d4:0:b0:2d8:41c5:ad64 with SMTP id m20-20020a2e97d4000000b002d841c5ad64mr9406573ljj.13.1713281361924;
        Tue, 16 Apr 2024 08:29:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDl2Y27sra8V2YK8ZMhrGngTVobwwtW2ufTsiynugk1zfPTqIBdnQGj7iThjBSBtPGRZSZyQ==
X-Received: by 2002:a2e:97d4:0:b0:2d8:41c5:ad64 with SMTP id m20-20020a2e97d4000000b002d841c5ad64mr9406558ljj.13.1713281361472;
        Tue, 16 Apr 2024 08:29:21 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id m11-20020a05600c4f4b00b0041816c3049csm14695155wmq.11.2024.04.16.08.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:29:16 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 1/2] cipso: fix total option length computation
Date: Tue, 16 Apr 2024 17:29:12 +0200
Message-ID: <20240416152913.1527166-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416152913.1527166-1-omosnace@redhat.com>
References: <20240416152913.1527166-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As evident from the definition of ip_options_get(), the IP option
IPOPT_END is used to pad the IP option data array, not IPOPT_NOP. Yet
the loop that walks the IP options to determine the total IP options
length in cipso_v4_delopt() doesn't take it into account.

Fix it by recognizing the IPOPT_END value as the end of actual options.
Also add safety checks in case the options are invalid/corrupted.

Fixes: 014ab19a69c3 ("selinux: Set socket NetLabel based on connection endpoint")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 net/ipv4/cipso_ipv4.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 8b17d83e5fde4..75b5e3c35f9bf 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -2012,12 +2012,21 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
 		 * from there we can determine the new total option length */
 		iter = 0;
 		optlen_new = 0;
-		while (iter < opt->opt.optlen)
-			if (opt->opt.__data[iter] != IPOPT_NOP) {
-				iter += opt->opt.__data[iter + 1];
-				optlen_new = iter;
-			} else
+		while (iter < opt->opt.optlen) {
+			if (opt->opt.__data[iter] == IPOPT_END) {
+				break;
+			} else if (opt->opt.__data[iter] == IPOPT_NOP) {
 				iter++;
+			} else {
+				if (WARN_ON(opt->opt.__data[iter + 1] < 2))
+					iter += 2;
+				else
+					iter += opt->opt.__data[iter + 1];
+				optlen_new = iter;
+			}
+		}
+		if (WARN_ON(optlen_new > opt->opt.optlen))
+			optlen_new = opt->opt.optlen;
 		hdr_delta = opt->opt.optlen;
 		opt->opt.optlen = (optlen_new + 3) & ~3;
 		hdr_delta -= opt->opt.optlen;
-- 
2.44.0


