Return-Path: <netdev+bounces-133145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D97FE99519F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903F61F25EE3
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4CF1E1337;
	Tue,  8 Oct 2024 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TL92Rbkz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5473C1DFD8B
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397499; cv=none; b=Cy5AaStllh0Ok8ZELUP9qc+RSwpVoi4OosaecDfw3PE35ZlabVmfSgMw4hEXfn6iWxmPNCEsnrtMzw7dRg4ZDJNNi1TM8xFjy1+daM5d1JBCVpeLi/rwu5dFQNMsMXf/DfQ7puXeQaGFxXpRxTJU2mGzktppBvRRjwLIlthPopo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397499; c=relaxed/simple;
	bh=CeuYcrwiIKUYZeW77ix04H0/vwRWNAcXQgelZ4lvjyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDFH+rr0mVHM0zfOa7UwXQezEcmUxBQf300BpFUYGbcJ+GeyKsRXxsPHtfpRKXhMyihAgqNxNkl89y3GA6gtp1QSqekeQG1ihqv1FOPmL2iJhhsaJrYUxr7x7jqpmrzH7jaq5soUB6YRii2lxnM6uOpPlWXugzNonzjNCdHmaUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TL92Rbkz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728397497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VJP4m5ak7lZaKjWX5FdevX6+OMFvcZJshMKNLgqu15M=;
	b=TL92RbkzG0s1XdXcQPdiuro7tHf7Ij/z3JHetW7q+qrMpl/FdZNO2MCutbBEYAqWOVqrtd
	KuoFTBRdYwsEW3TKNcc1ul4d/RDTnLjR+17UVn02RAApaftwNl5NqMUhven1vjTAdyG9Mm
	d5FLvjIOIaqYw9IsoOj9ctDQT3cZCmk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-9nalOYDgMKyAjql9ha84rg-1; Tue, 08 Oct 2024 10:24:56 -0400
X-MC-Unique: 9nalOYDgMKyAjql9ha84rg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7e6af43d0c5so3842299a12.3
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 07:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397495; x=1729002295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJP4m5ak7lZaKjWX5FdevX6+OMFvcZJshMKNLgqu15M=;
        b=p/X5rl4Q48wxg1hflYV6ZNu5KPu5xLsld4ssrFVOX7/LWwEr6Sza6EuSDm1VBQ41MK
         I7igVy26yntUSN6sPfwSK3A3evWo9hMghYu6GdxYJC7jGPHKG0rw5rkg2PfXb66dHh00
         rJSB38eqYi1wnLlQkXBtGMEJdAkcIfm6AFZZfTnYTpV1qn5kC++zerePFLi19YroyulK
         wFn5aZs7HaPTe+wC+g1FbNgV6meX2g2x046M1E2Gg5NpiNyUCyUe5vkn299uuwjcBSHu
         6G1KFIutv/ZNtTfbwPGfvPH1VJkgYooljSVTgJXnzSDlp/WgmZL5NN1tvZYPBUt3jDO4
         TtUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtFlciREIYwYy89EjliXdLeH0CDdXtP+wmvVwUvLzWvXgtAYUfb3YqKlQf91KBzBy9rAD4QiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7/Vee6nzALp9G7XDAQeuw/4KK00q71KB7ocfDpLATzo3aFlQP
	IzEyu84CUoZzjEF3J/Zwm4NcuB/IgbozNJxkJi29FrtswAaoI4NAIfkBr/m17oL95Tn/pwkd4tF
	2BZyg6arTWn8Tw+4LQDpeECupu5III4uoVQfjwqCAsKCMfpUdcJr+Sg==
X-Received: by 2002:a05:6a21:114f:b0:1c4:a1f4:3490 with SMTP id adf61e73a8af0-1d6dfacdc72mr25369371637.39.1728397495070;
        Tue, 08 Oct 2024 07:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaIoOJotr2X52JJ437h/ePALQVR8idKhgXka+qVOOdiin+Ay69AGt3bPhS1MWuoz1hsgLOLA==
X-Received: by 2002:a05:6a21:114f:b0:1c4:a1f4:3490 with SMTP id adf61e73a8af0-1d6dfacdc72mr25369339637.39.1728397494761;
        Tue, 08 Oct 2024 07:24:54 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:5054:ff:fe86:4eaa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4a1ffsm6182937b3a.132.2024.10.08.07.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:24:54 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: jmaloy@redhat.com,
	ying.xue@windriver.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tipc-discussion@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tung.q.nguyen@endava.com,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net-next] tipc: Return -EINVAL on error from addr2str() methods
Date: Tue,  8 Oct 2024 23:24:42 +0900
Message-ID: <20241008142442.652219-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value 1 on error of the addr2str() methods are not
descriptive. Return -EINVAL instead.

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/tipc/eth_media.c | 2 +-
 net/tipc/ib_media.c  | 2 +-
 net/tipc/udp_media.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tipc/eth_media.c b/net/tipc/eth_media.c
index cb0d185e06af..fa33b333fb0d 100644
--- a/net/tipc/eth_media.c
+++ b/net/tipc/eth_media.c
@@ -42,7 +42,7 @@ static int tipc_eth_addr2str(struct tipc_media_addr *addr,
 			     char *strbuf, int bufsz)
 {
 	if (bufsz < 18)	/* 18 = strlen("aa:bb:cc:dd:ee:ff\0") */
-		return 1;
+		return -EINVAL;
 
 	sprintf(strbuf, "%pM", addr->value);
 	return 0;
diff --git a/net/tipc/ib_media.c b/net/tipc/ib_media.c
index b9ad0434c3cd..8bda3aa78891 100644
--- a/net/tipc/ib_media.c
+++ b/net/tipc/ib_media.c
@@ -49,7 +49,7 @@ static int tipc_ib_addr2str(struct tipc_media_addr *a, char *str_buf,
 			    int str_size)
 {
 	if (str_size < 60)	/* 60 = 19 * strlen("xx:") + strlen("xx\0") */
-		return 1;
+		return -EINVAL;
 
 	sprintf(str_buf, "%20phC", a->value);
 
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 439f75539977..78fff7ad4b2f 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -137,7 +137,7 @@ static int tipc_udp_addr2str(struct tipc_media_addr *a, char *buf, int size)
 		snprintf(buf, size, "%pI6:%u", &ua->ipv6, ntohs(ua->port));
 	else {
 		pr_err("Invalid UDP media address\n");
-		return 1;
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.46.0


