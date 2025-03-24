Return-Path: <netdev+bounces-177067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4762A6DA1F
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 13:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435111891BFB
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 12:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BFD1D86F6;
	Mon, 24 Mar 2025 12:30:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8601CD0C;
	Mon, 24 Mar 2025 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742819443; cv=none; b=CSUy15f4hZ+sz1FR21WDuKgwaaxlh6SnE6TW3byTUsEZa64wUjoU1l6SxJICBmg0SqSVp9Ouppq2Hb/fIxexJoa7PCSV5k0I9Fppsp59RpARNyiAn7+0FzlDvQy6Cj4ATDG03UytVLr/L4RVxf40X5+tHS/1rspOgkm+satP5fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742819443; c=relaxed/simple;
	bh=9BqmxImDh5n+vN8ctC/P+gHMkS152bltAwJkPHjM1Q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NLkTCC+Wbk+viS/vvPcKPLFF4RtTxXWEeeVmu2q4bStWUbb+yfRJQoqylLyi5g3VLtybenJqH3oKulRkCS0kWg5NmRKD1ZeJYcfMly/stooep/ZQaMrMFIHY8G4F4+GkGR7a6ytfOlNrtMBlwVybBGSIlBqqOSFq4fASB4xz1vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac34257295dso902398466b.2;
        Mon, 24 Mar 2025 05:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742819440; x=1743424240;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWmjtMIH4C4Wn6tnUZWCXgU2s4Otmlhl2EC7/ukWLRk=;
        b=CPYoz3rJDsIogH3CiTCXV0BYZ86M9jmfVgYgPuESisEsQFazqd+PI1uO4Fe3BwMA3i
         0oRMGwuAIbnK5VN00fJhyJ1RElFSPlCvQfEGCon87+5hKTPTwN5pC5dNpz2tItpKZcH0
         y9BA4waGYqgNhcb9mpXiH4d9SGhEXJZuplKr+siTiKqsMNmxCD4m/KyI3h36WmjxtKh9
         JRdV4fm7EuQf5hbtHm5NInihcH74RoU+yLkE0NJERB/qhFNFDYISU6RhSbr85xgVJjZP
         CUJMrS6FoysSZQa+jOU8g/3mLOj9kcKO1O9zf4KS2gpb9R7wo9lY6Z4wfpActSQr0wvS
         Yarg==
X-Forwarded-Encrypted: i=1; AJvYcCUFZ60W2LK3Ws7le2QKV0FNvAzZgv5yPv6Do7uPZjOFl3hakx+94mTU0q5Z/JmnBbPI3IFq1Wh/Nd+b/DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxReCFpDeW1sOOACu9QHfUMeVoz0cmzLquMkktsxX+/keTNtF4F
	WHRUn9rBkORgBeS4i7zEUeJ3hhyOHxMZgNh2+8Rz5NpmuRfe7jUGNuyA0g==
X-Gm-Gg: ASbGnctNEEC7NeRBcRqrxv/4U+zhVZT0mPVyblLUkP6ZrweKPWj/NoAksEVZM1vIZQ3
	GgPEP0YUljOODFhI1RWcdtxua6S8kRk7Oo660iT3YOfGEjQT9i+jTharFDaGShi+UJnKAriT5ik
	oHJI7fZRbGoWC9jB2PAS8qOMeu6OBWETBV3D0mdy3/0WvOIl8SBrn2QqiugumkcbH19e7k3JEdK
	17zgA2oHuR87l8tWJ1qa+Zae48nxuHfd8gkQBAkZ07z3HSwMzCGhpGUKzqsBw2Oe+XYcDxolW6m
	7xsAodldX8te6DquLRPGt7FrtPb8h76C6Jbo
X-Google-Smtp-Source: AGHT+IF9Nz7U/bPn9x/81GvhUUJaG7LAHEC3eHeujyYrW8fN+VbRv87Q7UKcL43tzky2FNgKdKGopA==
X-Received: by 2002:a17:906:7952:b0:ac2:c424:c316 with SMTP id a640c23a62f3a-ac3f25836b0mr1375544766b.57.1742819439427;
        Mon, 24 Mar 2025 05:30:39 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e51c8sm680707866b.66.2025.03.24.05.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:30:38 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 24 Mar 2025 05:29:13 -0700
Subject: [PATCH net-next] netpoll: optimize struct layout for cache
 efficiency
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-netpoll_structstruct-v1-1-ff78f8a88dbb@debian.org>
X-B4-Tracking: v=1; b=H4sIABhQ4WcC/yXMQQqDMBAF0KsMf21AU5WSq5RSSjKxAzJKMhZBv
 Huhbt7yHahchCsCHSj8lSqLIlDXEOLnrRM7SQgE3/qhvfneKdu6zPOrWtmiXbox52FMXYx9uqM
 hrIWz7P/2AWVzyrvheZ4/7JB+dXAAAAA=
X-Change-ID: 20250324-netpoll_structstruct-6ff56d1cc4d8
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=2423; i=leitao@debian.org;
 h=from:subject:message-id; bh=9BqmxImDh5n+vN8ctC/P+gHMkS152bltAwJkPHjM1Q0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn4VBtB38D5DMw2ug8nlCBJgsaaUXxCAIY4e3Ts
 DKWxZYEHU+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ+FQbQAKCRA1o5Of/Hh3
 bYTyD/95gVoU9RFy62tdJKpxHUCRKD965dc+RCmhQs2op0cz/Bly9lECH3BLRpSrwgny9yOmO/Q
 F57DOfrIoKQeqpFon7Hsl89I7T5yR0J0wZt6scd1Kz1apdVK8A5hxQNFFh2808W+hP+FNVYpGz+
 SuwEpXywXOzYQH9Wfy6vB92PlQDaNvZqpk+ztZV13jt14qQCypz4B2LbcKj/+i08/GePt2AW9xZ
 bfCjM/94fMqq4Dq0PQARqvc4vAKMDdvsYYCld5Qqa09AsweTBrAqx6jLWm7cwvJ57UTri1gdx+q
 CT9HR7ysf+ZWTD7aQgm4AXNXF3flTsg/dBsV/SG5/yQqp5QYTqWZuQlShqF4YHqDPqFtN3zzNi+
 iIwV/+oNXkpF6AjmI83dGknYpjCD5MmvVFht4dp/kAHHQCis6f2Qdt9S3/UiMbFPELz1T5m5Ipx
 l77x7TGRGxQMWxYpUrle7AThODl0HrkDNbjNIFpPSNs+htCC4C7BLwy5l9R8tUrCJ+45f4PpxBc
 Fnk9/cOCyRsAUMdxpQTW4AB0/1p1SldmgvMfMKYH2ojYPmG47jKmqYm3MOteeAexPwqjd5FV/lU
 1LQsp1q3UDM1d0wmhh4zp9lMHhHtgzbW+66i9TZW7JnaPpgBn8RHe0DN7FlW3NHmc5ne8xjUTOZ
 RyXJ0kibFxOuCOA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The struct netpoll serves two distinct purposes: it contains
configuration data needed only during setup (in netpoll_setup()), and
runtime data that's accessed on every packet transmission (in
netpoll_send_udp()).

Currently, this structure spans three cache lines with suboptimal
organization, where frequently accessed fields are mixed with rarely
accessed ones.

This commit reorganizes the structure to place all runtime fields used
during packet transmission together in the first cache line, while
moving the setup-only configuration fields to subsequent cache lines.
This approach follows the principle of placing hot fields together for
better cache locality during the performance-critical path.

The restructuring also eliminates structural inefficiencies, reducing
the number of holes. This provides a more compact memory layout while
maintaining the same functionality, resulting in better cache
utilization and potentially improves performance during packet
transmission operations.

  -   /* sum members: 137, holes: 3, sum holes: 7 */
  +   /* sum members: 137, holes: 1, sum holes: 3 */

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 0477208ed9ffa..a8de41d84be52 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -24,7 +24,16 @@ union inet_addr {
 
 struct netpoll {
 	struct net_device *dev;
+	u16 local_port, remote_port;
 	netdevice_tracker dev_tracker;
+	union inet_addr local_ip, remote_ip;
+	bool ipv6;
+
+	/* Hot fields above */
+
+	const char *name;
+	struct sk_buff_head skb_pool;
+	struct work_struct refill_wq;
 	/*
 	 * Either dev_name or dev_mac can be used to specify the local
 	 * interface - dev_name is used if it is a nonempty string, else
@@ -32,14 +41,7 @@ struct netpoll {
 	 */
 	char dev_name[IFNAMSIZ];
 	u8 dev_mac[ETH_ALEN];
-	const char *name;
-
-	union inet_addr local_ip, remote_ip;
-	bool ipv6;
-	u16 local_port, remote_port;
 	u8 remote_mac[ETH_ALEN];
-	struct sk_buff_head skb_pool;
-	struct work_struct refill_wq;
 };
 
 struct netpoll_info {

---
base-commit: bfc17c1658353f22843c7c13e27c2d31950f1887
change-id: 20250324-netpoll_structstruct-6ff56d1cc4d8

Best regards,
-- 
Breno Leitao <leitao@debian.org>


