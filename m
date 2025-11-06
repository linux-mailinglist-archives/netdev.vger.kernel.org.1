Return-Path: <netdev+bounces-236511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE27C3D6F1
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 21:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8E194E252A
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 20:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F3C2FD7B9;
	Thu,  6 Nov 2025 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="TmI5SPPT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F62FBE1C
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 20:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462595; cv=none; b=O1UCE7bjqm6BnBrva1TaVeUCe9C+SeYtyMMWMguhiYVmIcF51m4t2zFxaxRBQv5wBd/BvTP/cN01hK0smHPykYn2YOFycXl/DjPYWkS2nXbNMPsmaahUaX9EsLgXCj84mw3K1TWVJwYUlEJJd/YYZRmVtQZ4c2iKPgMHhU7A+CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462595; c=relaxed/simple;
	bh=gMQRGS+SVO2vzWuCmGVEhwaKIbNBPIet3g2zgJw9+eY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUul4yqaSI7/5A9sryvD5/5FZKqzsUEbtkSHHFg3omvNX/MMiJSJLZCqDk2Vm65s46Hnq9nhFDfaDzfv/GPiayWlrMtq4EwuuE3Xj7l0SY+NDtT8aP1Vz1cJZtKBNKTdeFzhI21q5spCV5Z/MkyP6PMAFTgxr2oVYB7PedQqWTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=TmI5SPPT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so57257b3a.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 12:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1762462593; x=1763067393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h2ElzyRzn0v6hWuArud5/e2HaWvEtDNww/kv3MdDcSY=;
        b=TmI5SPPTMD6C8K/uS3Jqmaj5aylbZFuBS9sWnrYfbdLvUSxXTMZpaEMLiWwXmeHpV1
         +1BB30X7RoDtsGeE/uPHww81ZjcExRioSzcO3Ml7UTkXBPGVUIctAxZEPRYTQSPx0sn1
         DpAxWFlJLygtCRYpR526OQ9RiA9sC/YagZpHKMoGJAPjIw4AtnBXV9kthvLFz9Se5fZ9
         XIB3+hyf39ECr/axeZZD8+e8+6YuYMEzS2mPxLszoHISrLKiAtCW5top17CfgSpsdsWr
         itruDQ1s72mO7J32zp+BSH6Bc20sj77RcWsbggQDa+M7mdCNB854+EHDiPmUizjO8J9T
         PKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762462593; x=1763067393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2ElzyRzn0v6hWuArud5/e2HaWvEtDNww/kv3MdDcSY=;
        b=VDEMTMDnPLPmvsnrIv9szN9f2mVKaiQ7fG15pmw3aMxPasWOR8kv9g4n0Uz6yJiWCr
         DeIuPmGtgs3GC0yyVIAIyQFvQNc9KdBAtk46DvOW6b2+A0HayfVnlzkflJiT/XYzveOF
         O5tpvT/VvmDgAt6EJfWNT9XEPnuMxx9ehXC+BXITqwWe3L56i3j7G1OpYNOlChEClzjc
         BEOun1pDv7MbT5WXSPO7xX+IgQ4VY/2cFAGNIy0YLgI1C4Enq0riZFILEkCSFzssmCt8
         acg0ynlMIPtCosrMXWwgNpVZe82qCtg5I1kP2NAt2Du9hMANXnATp6AhhzNeg9bNFnLF
         UO7Q==
X-Gm-Message-State: AOJu0YyOAOR+rc/PGqjwrKUx71SnDAK00o2vneprG4Ntlnfgeyr5WnZN
	4LW7ukyojJ5v7/GVGKaPaloUNjsoWVQdpU8Uzbn6rCylh0NVz14tdDboQaOPVxfJNw==
X-Gm-Gg: ASbGncu9lFEGD5NQhVkf64QPjdwyBTfhxQEohH6CYf5BGCKPGeuhDsQoHJQDguYF1Qp
	iNef+7zPhCXrSIp7ta7PtHBGzf+ux8mqJo4WcPgZeKUxu1QGVaHJKNOeEfOb4HXg/lwPIPHmx9/
	wP1QHaiAfVXjiePTvn3yvwpOk92cZOWlasmebT1QC31zR7AKA4Za5RQiK4LDtrjQfpDdlTxnF9w
	ZUCcL+sx3lCNU91/mZ6K9KgnZBZ3w7yZzG+7/7nI52ksi9FipE72hsimbtbwOZO5JM+cPz5VNDO
	L7VdWo+IpgivRbm3BUF10ZBkfh9fLvWwL4ZZaPd1K+/I1fFEPasAH+Z+9UPKCZ1lDOeBsFO+2Yz
	6M9oh7S8SK1KMJo7d79iCf6FOEcZ2lPi83aLSybSs0uejYSOU9lQHvdkqiassv/LFUg4XqUk3a8
	Uq1V5b6UAkFZI7lsumPw==
X-Google-Smtp-Source: AGHT+IHHp6C7UFUAgPnX40glg739Y1jd2XmO+rYUlvuYf58IqghAwt6xdbMgJEwKDokGrSx856CutA==
X-Received: by 2002:a05:6a20:6a13:b0:34f:a16f:15a6 with SMTP id adf61e73a8af0-3522ad7858dmr1364041637.57.1762462592770;
        Thu, 06 Nov 2025 12:56:32 -0800 (PST)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4efb::1c9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953cf79sm490735b3a.3.2025.11.06.12.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 12:56:32 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	wangliang74@huawei.com,
	pctammela@mojatatu.ai
Subject: [PATCH net 1/2] net/sched: Abort __tc_modify_qdisc if parent is a clsact/ingress qdisc
Date: Thu,  6 Nov 2025 17:56:20 -0300
Message-ID: <20251106205621.3307639-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wang reported an illegal configuration [1] where the user attempts to add a
child qdisc to the ingress qdisc as follows:

tc qdisc add dev eth0 handle ffff:0 ingress
tc qdisc add dev eth0 handle ffe0:0 parent ffff:a fq

To solve this, we reject any configuration attempt to add a child qdisc to
ingress or clsact.

[1] https://lore.kernel.org/netdev/20251105022213.1981982-1-wangliang74@huawei.com/

Fixes: 5e50da01d0ce ("[NET_SCHED]: Fix endless loops (part 2): "simple" qdiscs")
Reported-by: Wang Liang <wangliang74@huawei.com>
Closes: https://lore.kernel.org/netdev/20251105022213.1981982-1-wangliang74@huawei.com/
Reviewed-by: Pedro Tammela <pctammela@mojatatu.ai>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_api.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 1e058b46d3e1..f56b18c8aebf 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1599,6 +1599,11 @@ static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 					NL_SET_ERR_MSG(extack, "Failed to find specified qdisc");
 					return -ENOENT;
 				}
+				if (p->flags & TCQ_F_INGRESS) {
+					NL_SET_ERR_MSG(extack,
+						       "Cannot add children to ingress/clsact qdisc");
+					return -EOPNOTSUPP;
+				}
 				q = qdisc_leaf(p, clid, extack);
 				if (IS_ERR(q))
 					return PTR_ERR(q);
-- 
2.51.0


