Return-Path: <netdev+bounces-180821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7467A82979
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6405F9A15C5
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550D418A6A5;
	Wed,  9 Apr 2025 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8GmzoLk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EE2262801
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210535; cv=none; b=EvKmQ5OhS2UTZqH0ZsvVadgOwBOxRSrP07jVFLNJb3XFEjKJ1QT2OhSxfhARFvKsJ68rLs1WjcjgX0N2UkDRAdlvDCYkE1PwKC9POMBCoPcz2DCfDiUG6QLnYOKmV81wzFDD0p4hnun7P+/6cgYw8q8iuSJM1R9dnjGCNtdIWBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210535; c=relaxed/simple;
	bh=Le42i0f9ri0OTkgnI+o5y8rBvy/0/K5o9eeKOO0dHFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sUnhiAVBIlfQsOTG/BpDTUcX4EaCrytpy6pIWoRfNnCVGDirIL+OuyBZkszGFv37cZYnVL5UfniE+Ygn2scfQ+pegPpmBFOy9OSJWSGMhVeoMpYyRYKY9V9bPLNDAZDTLPAUwbiOE6i1Ba8+p1oAM4/PjH6Kkkoz1aUxUgh1uFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8GmzoLk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744210532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m76p578lQmATrS7N9RNgIuSei90CjOqaYzI8tK7znzQ=;
	b=O8GmzoLkEaKpd0jglPQaJY3xFjNXpE3OjctlIBhIskYwv56AZf9BF3nEUxZe1Z0EMUCwHD
	8SEfq3WTDh1g8wDGdSQupNJUeEX5fux5Z7Et0AJS+nxCrmP56DNPCe9altlXnpChapgATw
	4eVe3qOtnlGwKQ2j3yURsRzy67kc8Yk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-AMd2vXNuNG210DKBgChdPQ-1; Wed, 09 Apr 2025 10:55:31 -0400
X-MC-Unique: AMd2vXNuNG210DKBgChdPQ-1
X-Mimecast-MFC-AGG-ID: AMd2vXNuNG210DKBgChdPQ_1744210530
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac293748694so158742166b.0
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 07:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210530; x=1744815330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m76p578lQmATrS7N9RNgIuSei90CjOqaYzI8tK7znzQ=;
        b=wHsV70oysK4H25uPHCl0iAMwU9j5SwsfvBjBTs2UWmhPaBqQpKSBY4hGGOLVdEkqSL
         1Oj9zqc87uFFCZ1IikPdCVP4vINt8Ay5xWcd/8lUahBdWShh1OXzPI5vI0tNKV7ITQ6G
         MRS6fBye/hFtSs3qkHzxkitbsSrFQvptNBvkI+YJOFRdp69OLJngestgLA92DckLDEgG
         eVZt7FGcPdTVj+RiBvbs5obPSqjbWKrQGJuBNOwNVsVyFk72VDnbIxtkt0uU96PXUJYg
         nq9rq5h9otbl02Hw7W47MjaUGO5DyX9s/dhumssYNms9fgfQu8kMUHnWWguXJXVdO5X8
         ogVw==
X-Forwarded-Encrypted: i=1; AJvYcCWrkT3qoycTzNmMBATjZVUCRjyCMPYuiUyY/zw3FyUCxJnYoU4sr3K7giCLeK3LSfoZ5nImAU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg4hN+3nxHi0I5Wfwqnv0ZwhQnTQZ87ugABkQzZRDYsfOFaLuL
	AFLy4Yeytsr+mPI7H82U/p8Oge3Cq9Q5gr2TRKo5pUwOezVU9AzRSlTQt08DH0itvs+feKsFNnQ
	DppCFj0TXfG35pxggPz/pHNyTc6BFsJ8SeszX0uTBcySlv6NpC3Umng==
X-Gm-Gg: ASbGnctOYJjA1dXjt5dR/Cnw1HJ9uS0xA4tF8FLLbJ+SKfgz06QdX3UB+cjNeDEoAMA
	2P1BMPhVl8+9aVCPhfH6yrMtR6v9q7aMw9xhLKv9UF/03/TNgN/8vC2ia7EEqwYf8WaxHzgSyq1
	MXbKRaFcb9Ya08PJWX5qNL2YxNv9ZkSNIaM/rNfISdrIhMXh0DgZLHFDP7MvVnwCa9/+CVYkPbd
	D6sclkeIIXejUqoEMQxr1ehn8adkY3jiuMAGM/SLnGLq7aeEy9DF49KUtC7Un/hPQlU507kCcXO
	Bd0xm6mV
X-Received: by 2002:a17:907:2d20:b0:ac7:7f14:f31b with SMTP id a640c23a62f3a-aca9b64d7a3mr300943966b.3.1744210529878;
        Wed, 09 Apr 2025 07:55:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/zURxGPfd0Yl1XD9idcXRTI7MKb7xPhWFNGbImVZpZ3AvB5dKEKj0WPEKQNwn4qLT4WaLuA==
X-Received: by 2002:a17:907:2d20:b0:ac7:7f14:f31b with SMTP id a640c23a62f3a-aca9b64d7a3mr300941966b.3.1744210529414;
        Wed, 09 Apr 2025 07:55:29 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb422asm107541766b.115.2025.04.09.07.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:55:28 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B6E0819920EE; Wed, 09 Apr 2025 16:55:27 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] tc: Return an error if filters try to attach too many actions
Date: Wed,  9 Apr 2025 16:55:23 +0200
Message-ID: <20250409145523.164506-1-toke@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While developing the fix for the buffer sizing issue in [0], I noticed
that the kernel will happily accept a long list of actions for a filter,
and then just silently truncate that list down to a maximum of 32
actions.

That seems less than ideal, so this patch changes the action parsing to
return an error message and refuse to create the filter in this case.
This results in an error like:

 # ip link add type veth
 # tc qdisc replace dev veth0 root handle 1: fq_codel
 # tc -echo filter add dev veth0 parent 1: u32 match u32 0 0 $(for i in $(seq 33); do echo action pedit munge ip dport set 22; done)
Error: Only 32 actions supported per filter.
We have an error talking to the kernel

Instead of just creating a filter with 32 actions and dropping the last
one.

This is obviously a change in UAPI. But seeing as creating more than 32
filters has never actually *worked*, it seems that returning an explicit
error is better, and any use cases that get broken by this were already
broken just in more subtle ways.

[0] https://lore.kernel.org/r/20250407105542.16601-1-toke@redhat.com

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/act_api.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 839790043256..057e20cef375 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1461,17 +1461,29 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 		    struct netlink_ext_ack *extack)
 {
 	struct tc_action_ops *ops[TCA_ACT_MAX_PRIO] = {};
-	struct nlattr *tb[TCA_ACT_MAX_PRIO + 1];
+	struct nlattr *tb[TCA_ACT_MAX_PRIO + 2];
 	struct tc_action *act;
 	size_t sz = 0;
 	int err;
 	int i;
 
-	err = nla_parse_nested_deprecated(tb, TCA_ACT_MAX_PRIO, nla, NULL,
+	err = nla_parse_nested_deprecated(tb, TCA_ACT_MAX_PRIO + 1, nla, NULL,
 					  extack);
 	if (err < 0)
 		return err;
 
+	/* The nested attributes are parsed as types, but they are really an
+	 * array of actions. So we parse one more than we can handle, and return
+	 * an error if the last one is set (as that indicates that the request
+	 * contained more than the maximum number of actions).
+	 */
+	if (tb[TCA_ACT_MAX_PRIO + 1]) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "Only %d actions supported per filter",
+				   TCA_ACT_MAX_PRIO);
+		return -EINVAL;
+	}
+
 	for (i = 1; i <= TCA_ACT_MAX_PRIO && tb[i]; i++) {
 		struct tc_action_ops *a_o;
 
-- 
2.49.0


