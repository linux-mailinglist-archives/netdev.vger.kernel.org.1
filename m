Return-Path: <netdev+bounces-178582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031C0A77A35
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019EB169CE6
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA079202C47;
	Tue,  1 Apr 2025 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Flqb95Wh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71B202961
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508671; cv=none; b=ZrUmgo/YFgnp6urRLroMwbfcPg0RnxcQ9CWR8PXU3+4xeEKMMWQdg1FvGwFa1zAReAMFtqp943jR2pJpuGX1LF3dI9aFs5yCrQ4OUTO7/DViwULN9Ca2cBQrh38AJRP4QNwzhkrmtva2H7qYAi+p8nZNDNE+EiUIq4iZ3PKU4gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508671; c=relaxed/simple;
	bh=VK+fAhdQMlQ7VgF66YAdeZfWP2MQ7T6BVegVmMM36Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yh6yNt5j+Ef1oyy8Gna9t2Mtmm3Z6kh881XWpQOv0LFjFOexOJ0k4JQjnyHbw4t7de41Y+ukpv9mOS6gVc5CHh3AGOmfUPx+1PQSCys9WLA1rBXEQGGZ+YHG788xA7JjE4WRKeiL+UayKsW4HIoLGJBkX60FmuJvGsMq2h+x7FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Flqb95Wh; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso4821849f8f.2
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 04:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743508668; x=1744113468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JL5RckWDUXDVUtbygqah1s+l5iawSiiKQxqaHFxngI=;
        b=Flqb95Whxarxx1y2zVRSDYwRML1hN7aXeN35K4bl8fDUlJqo/VG3VJ4g5+Pmm34uDQ
         IzJbI0zMYE7CP1btv9zVFz9E2UquF9+C3vhtnGEdshBfOq7jupORYeZ3YrKvakx+0iPA
         dIq3XWbINFY4RWuJPRvmAIHVBWfP1bmr0jKp7vfDcsv1PWLIaF2wDvb4XFGYBbpTOQLB
         W1Dv7r10XCjb2IyazhBtL04RFQJNlheJNdyNZ6ZiAvqCpcc6+ebT6/qhqm2npQwqwW2u
         cVuxru68SXS7cQVDncdlwPM4K+tN7hO1V7kr4w5OMkzp4JWw/4y1lAYZ/MpwTdNAR9PR
         3e2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743508668; x=1744113468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JL5RckWDUXDVUtbygqah1s+l5iawSiiKQxqaHFxngI=;
        b=pbc0t1+X1ak2edHpGiWosW1UtNmpOZALXiaM6pqZFMMLVDbYdubyI1TsfRa3nQUsli
         AWcmnTUi06LVihUI7MGch/by210rRbrBSE18TFOqEu7heuNWILV7Yq+p+mAtihmNq7Hl
         1sKErSexwL5FqPiKPdULPtY7ujVAk4QZ32tEvSbNIdk5RWOgfAfMk2rhGtuF0D/aD8E/
         hu9OCTapx9X8txOggQTNjKfO2RJ7Twko4HTR2IZ2kIvv4talydvtRUORAM8Gf7oCAejF
         3lptI53YfbuotSzMf/zYxEQl7de0QmJDD/EvkE7/rOK+e7aAnT0Ed4r7AW5QyC6tI1KO
         DoKw==
X-Gm-Message-State: AOJu0YxNwa5h1IlV5KgWgSxkUGW9eLbsVJ4ln7Em2MTnbxR5tBCwmItg
	YkDkeYvItHAjqMl2HFEEjignUAnhvcCT4k6d+W79MojaQVXtDZuUloiwarBCa88npIHIy3+AtDS
	r
X-Gm-Gg: ASbGncuacLe93Zf63exfKpEE4cLReJ1lLuyNOwEFztawr3osGTZtjwPpVtjCEkMp2hS
	IYmM8aBh0K5agLL4VV9odkhGtJ3s1qHF54VT+zZONSxjRJZ3ER2KU2O4edJlVlbegcs5Qil126t
	ylrnxBpOUGCzTy+tHw3efshDPQnnfFWRmwU6Z4oa4mJPEhJayrZvfNvf8Fp4hsAs3nOLqUxrrU5
	Fd6WkPtKeoQc6YcwpOIl3MK/RKvi9OjkCxtjWHnnlUXSL3xEurS6ziZVPqMkKRC4mDEol5C0+nB
	3BqgZN2h1fWkcySAA5cT00S7yvGXxD+BFyzc6CnmI4RBaJk=
X-Google-Smtp-Source: AGHT+IFLfOc6mWYMvUI2usLmBhWmFn3VeupA7JlTfwgrP5x7X9un5A68VjtyMV5CDIEoULbCkYWxhg==
X-Received: by 2002:a05:6000:4282:b0:391:1652:f0bf with SMTP id ffacd0b85a97d-39c120f741amr10153656f8f.33.1743508667931;
        Tue, 01 Apr 2025 04:57:47 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a42a3sm14130150f8f.91.2025.04.01.04.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 04:57:47 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: [PATCH v3 2/3] cgroup: Guard users of sock_cgroup_classid()
Date: Tue,  1 Apr 2025 13:57:31 +0200
Message-ID: <20250401115736.1046942-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401115736.1046942-1-mkoutny@suse.com>
References: <20250401115736.1046942-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Exclude code that relies on sock_cgroup_classid() as preparation of
removal of the function.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 net/ipv4/inet_diag.c      | 2 +-
 net/netfilter/xt_cgroup.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 321acc8abf17e..886dbe65ed9e8 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -160,7 +160,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 	    ext & (1 << (INET_DIAG_TCLASS - 1))) {
 		u32 classid = 0;
 
-#ifdef CONFIG_SOCK_CGROUP_DATA
+#ifdef CONFIG_CGROUP_NET_CLASSID
 		classid = sock_cgroup_classid(&sk->sk_cgrp_data);
 #endif
 		/* Fallback to socket priority if class id isn't set.
diff --git a/net/netfilter/xt_cgroup.c b/net/netfilter/xt_cgroup.c
index 66915bf0d89ad..c437fbd59ec13 100644
--- a/net/netfilter/xt_cgroup.c
+++ b/net/netfilter/xt_cgroup.c
@@ -117,6 +117,7 @@ static int cgroup_mt_check_v2(const struct xt_mtchk_param *par)
 static bool
 cgroup_mt_v0(const struct sk_buff *skb, struct xt_action_param *par)
 {
+#ifdef CONFIG_CGROUP_NET_CLASSID
 	const struct xt_cgroup_info_v0 *info = par->matchinfo;
 	struct sock *sk = skb->sk;
 
@@ -125,6 +126,8 @@ cgroup_mt_v0(const struct sk_buff *skb, struct xt_action_param *par)
 
 	return (info->id == sock_cgroup_classid(&skb->sk->sk_cgrp_data)) ^
 		info->invert;
+#endif
+	return false;
 }
 
 static bool cgroup_mt_v1(const struct sk_buff *skb, struct xt_action_param *par)
@@ -140,9 +143,12 @@ static bool cgroup_mt_v1(const struct sk_buff *skb, struct xt_action_param *par)
 	if (ancestor)
 		return cgroup_is_descendant(sock_cgroup_ptr(skcd), ancestor) ^
 			info->invert_path;
+#ifdef CONFIG_CGROUP_NET_CLASSID
 	else
 		return (info->classid == sock_cgroup_classid(skcd)) ^
 			info->invert_classid;
+#endif
+	return false;
 }
 
 static bool cgroup_mt_v2(const struct sk_buff *skb, struct xt_action_param *par)
@@ -158,9 +164,12 @@ static bool cgroup_mt_v2(const struct sk_buff *skb, struct xt_action_param *par)
 	if (ancestor)
 		return cgroup_is_descendant(sock_cgroup_ptr(skcd), ancestor) ^
 			info->invert_path;
+#ifdef CONFIG_CGROUP_NET_CLASSID
 	else
 		return (info->classid == sock_cgroup_classid(skcd)) ^
 			info->invert_classid;
+#endif
+	return false;
 }
 
 static void cgroup_mt_destroy_v1(const struct xt_mtdtor_param *par)
-- 
2.48.1


