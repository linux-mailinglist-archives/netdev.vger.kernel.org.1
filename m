Return-Path: <netdev+bounces-176292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0285FA69ACB
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 22:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B166189D6CE
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 21:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5033820E024;
	Wed, 19 Mar 2025 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CE/JChWs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9284A1D
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 21:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419521; cv=none; b=OG4wttKjtfofJlMLKfdCH/TO2ow7VvTB+SAkYXEmA/cDwNm9Bayo6F+mviOQ6IxONcXiRirV/ylSZcgQLb6uxv68QBk7F5v+h9KKVQGo5qujnrMoxXjCqqz+VYArJDQuCjIegJadSRt2s08rICa3cE+FqX8GjsXq8HZDMl1mPhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419521; c=relaxed/simple;
	bh=OV2Or2MRuOyczK2J99OF6kGebjbX+C764p1yBMBd3z8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NPFEFOdmZiVHC3CA14ddm0X7tBHPa4SFx+9ilYreAoISZIHmqmmAgFsU/weszes0lr7XQ108+QQeVi8KcN35vKH6aJPShJ8g5hq6a/r7cRb7SvAfz64UuJCIq/d4T542t8gw/imKJgE5c45pKFKL2qTaYA+0Ut+goHHwp9LhRkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CE/JChWs; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c548e16909so15167685a.2
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 14:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742419518; x=1743024318; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RxHpaOsvcvkOlLlrKja4PkNjzOLhmGsREHpqZ9nJpWo=;
        b=CE/JChWsfxkoHXwKdyz/o1Bt0nU0/Y/CNp4z0XStrdxmbqn0odKqdEMFl8NqPnfR3a
         1JNGm8A0Xg8UDn3n6K0txyZXKrEHwk98cozyw8y43WdFSsTKRvdwXsnzFkAmcbi+sE0I
         naV4hHoFfCA+W4oJxegoclT85mRBALXmC64NtK5hxMc7XFvFvjpuFxI/XUw/MLah8d4I
         MCHdKYipD79E/RxSaCcV+z8kRdy0c9L1hPRKaI/CLWH2tjmTc1GZXIvaIeuGe37xTwof
         Ycgg913blKhYSzgKv5JMrmKcPzVG31SE3XJ/CUWJ/s8e6+6Exstu8aJxiJM6cK/CksKM
         QxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742419518; x=1743024318;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RxHpaOsvcvkOlLlrKja4PkNjzOLhmGsREHpqZ9nJpWo=;
        b=hoDaahXMoVfUE1VADBqXGHzbLrMQW/vMJmgObCE5yJ+JAx3D1Yn+tDNNkM7zR1oYag
         NqJBMgZ5njXb55qNTtvhf5MeJGm+29hG8ZjLZ13Xy4Mo+mOy4mQsEoPjzdo6EYgpOCQY
         OviLd+Itt4KInrRpgMBXW8VbexBCYvMXDgeLQuwFqUfSKwSPqqNPCR+LAm6QMM0Pygu4
         CmZdMuS2EKHj3akZf1hxxtCbBQQCqs3+1e+OJhdw29GBxSvFA/6wYaMcOo0pjmCSVxDj
         FPosuAPfObJYZEnOq7sVNe/4aJPSzh+07AXI/DOAzV12YN+3L/JXnb8/eo+HDdooTddc
         fO4A==
X-Forwarded-Encrypted: i=1; AJvYcCWQzWcW9EC1eX9A/vxTthd54sDUL87Eblx4/5h2E8JQt4mz/Ci5KjIsRiNjBE/Pwb58+aExzVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvQMSbLpKCqob3VgbQb7t6+4jsX5Z0jU/36/wbzaerPEG10m89
	9SYw6c9XrbxlOmBVlZWGHribiZ/VWV8QWw9TrwNQombvYxUyMwK9WTClbqNhzCEmDkarRgBLHmn
	rZzVX/A/vGQ==
X-Google-Smtp-Source: AGHT+IHwmF5+ZHUO/UABocw1gn5GoH5ywswQTnigh8yOhe8KHVfNqrTePSAmWjThC+eAWAzjovZKJ4yvCpj/dg==
X-Received: from qkbdw4.prod.google.com ([2002:a05:620a:6004:b0:7c5:7199:7f0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4047:b0:7c5:4a8e:b71 with SMTP id af79cd13be357-7c5b0d2115fmr118196085a.47.1742419518612;
 Wed, 19 Mar 2025 14:25:18 -0700 (PDT)
Date: Wed, 19 Mar 2025 21:25:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319212516.2385451-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: fix _DEVADD() and _DEVUPD() macros
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ip6_rcv_core() is using:

	__IP6_ADD_STATS(net, idev,
			IPSTATS_MIB_NOECTPKTS +
				(ipv6_get_dsfield(hdr) & INET_ECN_MASK),
			max_t(unsigned short, 1, skb_shinfo(skb)->gso_segs));

This is currently evaluating both expressions twice.

Fix _DEVADD() and _DEVUPD() macros to evaluate their arguments once.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ipv6.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 9614006f483c9700168c9734f71440980c09017f..2ccdf85f34f16404157b1cd551c874fdfb20f52a 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -246,17 +246,20 @@ extern int sysctl_mld_qrv;
 #define _DEVADD(net, statname, mod, idev, field, val)			\
 ({									\
 	struct inet6_dev *_idev = (idev);				\
+	unsigned long _field = (field);					\
+	unsigned long _val = (val);					\
 	if (likely(_idev != NULL))					\
-		mod##SNMP_ADD_STATS((_idev)->stats.statname, (field), (val)); \
-	mod##SNMP_ADD_STATS((net)->mib.statname##_statistics, (field), (val));\
+		mod##SNMP_ADD_STATS((_idev)->stats.statname, _field,  _val); \
+	mod##SNMP_ADD_STATS((net)->mib.statname##_statistics, _field, _val);\
 })
 
 #define _DEVUPD(net, statname, mod, idev, field, val)			\
 ({									\
 	struct inet6_dev *_idev = (idev);				\
+	unsigned long _val = (val);					\
 	if (likely(_idev != NULL))					\
-		mod##SNMP_UPD_PO_STATS((_idev)->stats.statname, field, (val)); \
-	mod##SNMP_UPD_PO_STATS((net)->mib.statname##_statistics, field, (val));\
+		mod##SNMP_UPD_PO_STATS((_idev)->stats.statname, field, _val); \
+	mod##SNMP_UPD_PO_STATS((net)->mib.statname##_statistics, field, _val);\
 })
 
 /* MIBs */
-- 
2.49.0.rc1.451.g8f38331e32-goog


