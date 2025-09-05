Return-Path: <netdev+bounces-220423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C096CB45F7B
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111F3A07EB3
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517CA313287;
	Fri,  5 Sep 2025 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FcEYqJHb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F5931329E
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091510; cv=none; b=loncSInNbkQrbRIoHgVLSDj9ZmiXflRWHyvT9Ko4LGsfXItMKic6odCFtspZST+85VQlkYDzg92uu8gscD7c7cRTa8Lpq54tBBkhW8Ay8nTsOqvHqTrDDuTuWwcmTYc5X134LRLZoDnbF+kMXAnS/HaZwTub4ic0k6UnvRDUqh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091510; c=relaxed/simple;
	bh=bMX1T0hAmqDQQeGFXhFBPAsii5kYhQEsDhs0cSPQsx4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L1W156QQC7U3UGXV5Jo2BY0/p0rzpXBnMIj5P66rvdGpVTqTdfmejPrn42Ot4I/AI3PC2SNkglJaeOCN3Ihbl7T5BOhgK5XZeQcf6nU8VkE20t/vPESmTVnpINC3t3Ghtuw896gcsy0Wcdj80FA3Z9YZBM7K9dQaPDyHK98MA4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FcEYqJHb; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-80acebb7cb7so562605885a.3
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 09:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757091508; x=1757696308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dgk5ygaadk5u7SyByUrWe/7zDxjoOS5DC1A0XG9VqHA=;
        b=FcEYqJHbckL5tDFHj83KwlDX9aHBLxp6KiB6QIWhRq46P16SSyow3fcegual+DyXZn
         ud+CpxLMkHQNelaZFwJvUKvm743ppn9mmxyRXfIzR9sVOJkrAsZnDLT0bIBbGwZUzaEa
         +Z8u6GozVTenIL94qsegz/B8wLBCkJFHm7/fK1nRGCdRX+/bi/tBvzW+RmFzX1TxxWGH
         K1xItAy2J2ZAXx2E8qqb+ii6n2yRN0j3RaXxGBIMVkM5MRn6Ol9MWvc5okROZkayDtxQ
         u6vKHiLCyGDKMdka+rS4ZqZHBjFMchAI+n0QES48P9U7+/vEUk7Kxr4AHFRaUWyHTdEy
         +bRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757091508; x=1757696308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dgk5ygaadk5u7SyByUrWe/7zDxjoOS5DC1A0XG9VqHA=;
        b=twfcamQKJM1POQm9B0tcgyvA/bTtiuHks+QSWV639h8eESXcRtna9dqj/IDRzgLHqq
         nrEzL8KdghyxHiQ047kRzwIf7o0k0MfbgYDExL6YI+/4eXqjngwvOPJbSYdlkIrvjSx2
         gJYVbxUZG98upHKFfe13L03v4PZvI5y6m/DKwVToHJ9sZRwiEFoR/6NpQYOCwE4/4ZMb
         edN8kJc5qjQbgrs3jMfvlBmEE1kjyIlsO4byIofMszKwC44YMumsx9lkFlX3Qmme3axl
         68lJPjAjWxdZJWhuuSjA6G/zYAb3Zjgojm++Y1qDVfy0WUHLMhZ7GW7xfk+H0TmAhJRD
         vvtg==
X-Forwarded-Encrypted: i=1; AJvYcCVQNVbuqQB4J3UURGVKeXaFV2pFoprxaQFsKgwaAko5rEG4shJr172lfbZv+vpLmiEMcm74KJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5/5qdFRx7KA08UQTY4nvtsHH6VFODxRRJdFzdFd+kmvzwjxzr
	Oa+8iLQcAFuXIrt1fpPtIjcXYhaUatJOvj8Wd+VJxXoMRAtB1m+mgqSI1PTblku7SanubrW5HDE
	uAUT9+pbKZ/d6eg==
X-Google-Smtp-Source: AGHT+IFpy9Ne5Jw1gLSuMnEpC9+Gg3wY+gO2rpU1xvy5VOMl2SiAd0zYTOR4bHdsaSw/QGJ89xJBTCZQtMjasQ==
X-Received: from qknpw4.prod.google.com ([2002:a05:620a:63c4:b0:7fb:26b3:c4a7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:18a6:b0:4b5:ece8:8707 with SMTP id d75a77b69052e-4b5ece887b4mr27000511cf.15.1757091507610;
 Fri, 05 Sep 2025 09:58:27 -0700 (PDT)
Date: Fri,  5 Sep 2025 16:58:12 +0000
In-Reply-To: <20250905165813.1470708-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905165813.1470708-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905165813.1470708-9-edumazet@google.com>
Subject: [PATCH v2 net-next 8/9] xfrm: snmp: do not use SNMP_MIB_SENTINEL anymore
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamie Bainbridge <jamie.bainbridge@gmail.com>, Abhishek Rawal <rawal.abhishek92@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"

Use ARRAY_SIZE(), so that we know the limit at compile time.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_proc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_proc.c b/net/xfrm/xfrm_proc.c
index 8e07dd614b0b..5e1fd6b1d503 100644
--- a/net/xfrm/xfrm_proc.c
+++ b/net/xfrm/xfrm_proc.c
@@ -45,21 +45,21 @@ static const struct snmp_mib xfrm_mib_list[] = {
 	SNMP_MIB_ITEM("XfrmInStateDirError", LINUX_MIB_XFRMINSTATEDIRERROR),
 	SNMP_MIB_ITEM("XfrmInIptfsError", LINUX_MIB_XFRMINIPTFSERROR),
 	SNMP_MIB_ITEM("XfrmOutNoQueueSpace", LINUX_MIB_XFRMOUTNOQSPACE),
-	SNMP_MIB_SENTINEL
 };
 
 static int xfrm_statistics_seq_show(struct seq_file *seq, void *v)
 {
-	unsigned long buff[LINUX_MIB_XFRMMAX];
+	unsigned long buff[ARRAY_SIZE(xfrm_mib_list)];
+	const int cnt = ARRAY_SIZE(xfrm_mib_list);
 	struct net *net = seq->private;
 	int i;
 
-	memset(buff, 0, sizeof(unsigned long) * LINUX_MIB_XFRMMAX);
+	memset(buff, 0, sizeof(buff));
 
 	xfrm_state_update_stats(net);
-	snmp_get_cpu_field_batch(buff, xfrm_mib_list,
-				 net->mib.xfrm_statistics);
-	for (i = 0; xfrm_mib_list[i].name; i++)
+	snmp_get_cpu_field_batch_cnt(buff, xfrm_mib_list, cnt,
+				     net->mib.xfrm_statistics);
+	for (i = 0; i < cnt; i++)
 		seq_printf(seq, "%-24s\t%lu\n", xfrm_mib_list[i].name,
 						buff[i]);
 
-- 
2.51.0.355.g5224444f11-goog


