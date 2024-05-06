Return-Path: <netdev+bounces-93729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA56F8BCFC1
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C6F1F222EE
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185F313BC22;
	Mon,  6 May 2024 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fk7zn5N3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819B5137927
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004702; cv=none; b=UW3Duis7AFZJz1TOwgY2KFfJFQYRe6GfCUsVAdokGKKrji314Q52xotdHnye2U34IXFoapuX2/PHIDvif0w4rVgzdch1GRzdlgjbZ5ibr7qS0k5sRi4hJA4McXemZiyG3vrHVtAM3qRUyIHndhIOAPmtlSxxcjAL2JSyfkEbFSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004702; c=relaxed/simple;
	bh=297vEo8nyC1s/ltFlb73Hmw1Xp0B0/3D3O9My7miovA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AGA1uErB0SLt0/9EDfVuPne+2+YIXSUgAmNjlbsfjSqGC6J8jQ4q3exzNO8Yjva/DLW+WUvLaSRF0PlEEpaBnk9F11W3czUwX/PlPMm7/vM6iey42O6CSYs4Id2C+CWTVez4Cv109272BfLArZDyalf7BdYv4BC8qXz93A5Z2aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fk7zn5N3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715004699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qK13xhGx+xh+kDbLKKe1iKuSXlAdZD7q6eOoabHwsw4=;
	b=fk7zn5N3SU59PlCvpXom1WypG+mTxYJxZKjrl4fdQu/F3bpUv3t9k2dnJNWVXnk3hRfFdL
	ZzTRhAv+SwyX68yuGR1wjWo3ktRhLBOE3JVzjs0BMbMws4cdewOMEO+oRiXUTfUr8080nK
	2t6Pebi4vd6p80dt1siYoB9DZESCJZc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-zq60ZSCIPp24exIAslHmTQ-1; Mon, 06 May 2024 10:11:37 -0400
X-MC-Unique: zq60ZSCIPp24exIAslHmTQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1ec4c65a091so14937245ad.3
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 07:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715004697; x=1715609497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qK13xhGx+xh+kDbLKKe1iKuSXlAdZD7q6eOoabHwsw4=;
        b=fhIvq6Wc77yN0N0o940y9VF98bm0fXe1dRHiG7BwWdgTCci1rLP3SgsgdQz7+izGaC
         rnYe8UbqDK/P2NGxkQtg2KawHZn2abMS/1CGq2dMJNL0gAIlzbq5A+fGCpHipuwkJBSr
         asjK9a6R0D6DThlYVvBNi6VYeqakNjERTQrKsh3X+s9UBMTc6zyjNqBqNYTXgsh6loQj
         MDah9XoMW9hgQwgbhoiunxJCWrgjW6ktziXHm0RkPQZ2kwXvsRjBZVnEzeso+m2qGXDt
         dYhYzjL/nka8YFzu4vxIf0ieLC3iH4SsDAUZf16KPccTXnm1Bfke/bSuPLp98ba8ZhCt
         PPHA==
X-Gm-Message-State: AOJu0Yx/1SeDNkrlATs/7lNFEm6ATJYdh6rFQK9frZJU2EJlGPF7xVzl
	EcvpIUHcjXY5cw5EIpVGJ3y49bah2P9rD7KBcnzaVpK3qdIUYhossmqk4mXbyqo3ldotW3ycDaK
	gAl3sf/sT6CccSRTWxqL/0+LE2PaQswHvqj6BAMsJmI499ItJe9WZCw==
X-Received: by 2002:a17:903:40c2:b0:1eb:3df4:c31d with SMTP id t2-20020a17090340c200b001eb3df4c31dmr11946809pld.42.1715004696154;
        Mon, 06 May 2024 07:11:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH57Xka6hZHeOhrbJPj5cOqPBmd/uf5rYBBniQCsXw95IuMnWV2Gj4zSFUlXjb8VQo5dpsWjw==
X-Received: by 2002:a17:903:40c2:b0:1eb:3df4:c31d with SMTP id t2-20020a17090340c200b001eb3df4c31dmr11946755pld.42.1715004695399;
        Mon, 06 May 2024 07:11:35 -0700 (PDT)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:6883:65ff:fe1c:cf69])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b001ed9fed6f61sm4398721plb.268.2024.05.06.07.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 07:11:35 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net] ipv6: Fix potential uninit-value access in __ip6_make_skb()
Date: Mon,  6 May 2024 23:11:29 +0900
Message-ID: <20240506141129.2434319-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As it was done in commit fc1092f51567 ("ipv4: Fix uninit-value access in
__ip_make_skb()") for IPv4, check FLOWI_FLAG_KNOWN_NH on fl6->flowi6_flags
instead of testing HDRINCL on the socket to avoid a race condition which
causes uninit-value access.

Fixes: ea30388baebc ("ipv6: Fix an uninit variable access bug in __ip6_make_skb()")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/ipv6/ip6_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index b9dd3a66e423..fa2937732665 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1933,7 +1933,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 		u8 icmp6_type;
 
 		if (sk->sk_socket->type == SOCK_RAW &&
-		   !inet_test_bit(HDRINCL, sk))
+		   !(fl6->flowi6_flags & FLOWI_FLAG_KNOWN_NH))
 			icmp6_type = fl6->fl6_icmp_type;
 		else
 			icmp6_type = icmp6_hdr(skb)->icmp6_type;
-- 
2.44.0


