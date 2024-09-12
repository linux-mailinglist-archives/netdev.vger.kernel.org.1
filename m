Return-Path: <netdev+bounces-127639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D966A975F03
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA6F285777
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6069F7581A;
	Thu, 12 Sep 2024 02:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PvrHir5T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744722A1D6
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726108836; cv=none; b=d1SNTrevkN5Qke3hejqjToq63HZlzmxZC2B1e9w9ThUXJxnEDxFRrrj2WfqLmifXrEp9W1z+pg3Q0OfSq2vkHYQTw5t5w9Vr9Un0ihK4g+ImmCyYh4JwBknXQJsJT15tnfRS7Pflu+2q+36ABShFpN6r+LMge37jPgnsv7ipuTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726108836; c=relaxed/simple;
	bh=ikMaM0e3Ao7ipftHTCb/8lPOjUaaOs0Rn2KOeeVjgC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W8qPVaBfnDcTpGK4zGTcmlkb6sgZiTCxUHy5UmkWsdeRDZB7Aq3LqhqlaScOUabPe6UutrTETrKqqp9UeAyDyk2yMcuouid4GVGCZKLfrGlcK7eLmkBJWhr8c6m6tcRCB09HrJ1+fG3C7F0v6hLKuWmKrL40J1ATPSZW+st53Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=PvrHir5T; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6802A3F5E4
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726108830;
	bh=9xFVQgF67aC4OrVJ8fcF8pG0+PqyehAIbGoYV6EaEXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=PvrHir5TQIGlyT73DZRu9Aqt870HO5r5PevgUhCUc8D27TWUEhL7lNkykKjI7AZGp
	 606sNUKZHn3PhmDX0b0coyiIu92iD55AGPZTWBHc22Iov0hbVF/k9XseT1UfxhmF6e
	 7wmVHQznfkeJmwIniHEk34ul1nr7Tt2IHdC99ZXMlyyLlL2oA80J9P7uhzcnAbmXZ3
	 GyzWca8r8veZlNpRVODdt/ST41ZFvkIUZ9jCPV/YPortcxo9rqpVZy+4g+35GTymCN
	 pmCnOH/rNK0Of7M0Ji+5b4lMnIXBtD8C29ravi96kiT4x3J2T60C6+FuU3lCe9RNMQ
	 SFjjtQbGptkxg==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-718f3c2fcffso601717b3a.3
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 19:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726108829; x=1726713629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xFVQgF67aC4OrVJ8fcF8pG0+PqyehAIbGoYV6EaEXc=;
        b=cRJhJMiBTP33mXyNyBjtxtPqult3FcmoUXnrFMaYG5JoKd5MNEzewLSBdDBjk5sr8t
         kd4FCOXV3m9MdbOWvhWEBBuMOBVQSiJqwGVdqcn+wkx0D84JVRdCjFQG8sUv//rdLBvw
         oCwIulG5mucGGQisAEvZ+JztTz/K4iPKDTnSYrGCOdff1GVGSnNbUtFkRdLAu8Q5+ucq
         b2FcMUC6Z12jkXGjQPEyhYRlXqeLLAveJuJVrIwxdTxCYs2AwaFKZFiWRpvYnXwYEl/J
         osKpF/DL7f+7hhDqxDUthrezEElJ8YJaQO9V1wguYXAjya7tNCmzqUSqz/kCICmK9LE0
         nHZQ==
X-Gm-Message-State: AOJu0YyjANLYxjo2x7ZM+8IHhp9H9qkOz/sLvX5sIu86jped8BULrJVG
	V/a0cxy7RtAy0Xnn8hMeoYIaFkyBy4MJbqqVD1MJUS2Svc6LdPZl6WzfxsCLdQCVlNtPTIaKY9O
	NM7HzfwKAtkOWk8wdFvJ828LhgGzJkuT2wOx2OCjb0PfDs6uR7no+bNLqZQ1pcoHwzoxRGw==
X-Received: by 2002:a05:6a00:92a0:b0:70d:2cf6:5e6 with SMTP id d2e1a72fcca58-71926088d5emr1933896b3a.15.1726108827971;
        Wed, 11 Sep 2024 19:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaviSHj/QrkbosoIlU6MgMiMW0fyAitvLrdX8wODPdF2LNcNsCgKg006w5bbU36gO297fcIA==
X-Received: by 2002:a05:6a00:92a0:b0:70d:2cf6:5e6 with SMTP id d2e1a72fcca58-71926088d5emr1933867b3a.15.1726108827544;
        Wed, 11 Sep 2024 19:40:27 -0700 (PDT)
Received: from localhost (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71908fc8d53sm3642285b3a.38.2024.09.11.19.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 19:40:27 -0700 (PDT)
From: Atlas Yu <atlas.yu@canonical.com>
To: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Atlas Yu <atlas.yu@canonical.com>
Subject: [PATCH net v1] netlink: optimize the NMLSG_OK macro
Date: Thu, 12 Sep 2024 10:40:18 +0800
Message-ID: <20240912024018.8117-1-atlas.yu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When nlmsg_len >= sizeof(hdr) and nlmsg_len <= len are true, we can set
up an inequation: len >= nlmsg_len >= sizeof(hdr), which makes checking
len >= sizeof(hdr) useless.

gcc -O3 cannot optimize ok1 to generate the same instructions as ok2 on
x86_64 (not investigated on other architectures).
  int ok1(int a, int b, int c) { return a >= b && c >= b && c <= a; }
  int ok2(int a, int b, int c) { return c >= b && c <= a; }

Signed-off-by: Atlas Yu <atlas.yu@canonical.com>
---
 include/uapi/linux/netlink.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
index f87aaf28a649..85dcfa6b33af 100644
--- a/include/uapi/linux/netlink.h
+++ b/include/uapi/linux/netlink.h
@@ -104,8 +104,7 @@ struct nlmsghdr {
 #define NLMSG_NEXT(nlh,len)	 ((len) -= NLMSG_ALIGN((nlh)->nlmsg_len), \
 				  (struct nlmsghdr *)(((char *)(nlh)) + \
 				  NLMSG_ALIGN((nlh)->nlmsg_len)))
-#define NLMSG_OK(nlh,len) ((len) >= (int)sizeof(struct nlmsghdr) && \
-			   (nlh)->nlmsg_len >= sizeof(struct nlmsghdr) && \
+#define NLMSG_OK(nlh,len) ((nlh)->nlmsg_len >= sizeof(struct nlmsghdr) && \
 			   (nlh)->nlmsg_len <= (len))
 #define NLMSG_PAYLOAD(nlh,len) ((nlh)->nlmsg_len - NLMSG_SPACE((len)))
 
-- 
2.43.0


