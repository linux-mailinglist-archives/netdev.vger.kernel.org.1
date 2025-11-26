Return-Path: <netdev+bounces-241802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C0509C885A0
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 08:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6EC6B347097
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3064D270ED7;
	Wed, 26 Nov 2025 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="JQ7SWZ8v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE1C22FDFF
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 07:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764140832; cv=none; b=Op3V8BZyNM1IxtZ+zii9mwMXp/q0Q4pXv4M876ssZ/+dG22D32xWCb8DoHRzMruvpFvj8DG4bRTYgJ9Tfh0KkvtQmrC1Vv4VBZLJcRpTxbzk++3WYZHTvovKXvD+Kg4s0pkKsQmZa+o7fiueP9XNfBBqqfE+8XDKqHtFKHQexhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764140832; c=relaxed/simple;
	bh=VB4nQunFf+O3DmYPGWwxjYu5Lg4IWPHg/FOy86FFr0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BwsqZIvT4TWJW+ExNRtC38PZJk4PQdzpkkgeYbnKBCYextBxRWtKtiJB6EPMNGYmVrZjhy+HGCBu1bC1wAjGgRjgEEQOhg1DSonvx+SRnGX6LMkpLPtJnuZFTnhoYPG9LdyPdc87to6atdCtb8EKFr+gdFeI6kPsLKF3ynrVRAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=JQ7SWZ8v; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-298145fe27eso99565085ad.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 23:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1764140830; x=1764745630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kXm+TGMia1g3kmuDV/aF57ZmqWwNOjaNm4FLB34Qkxc=;
        b=JQ7SWZ8va3yOG83pZgWPCtQoST0TmPwJka/mUlaX09ebW/KU5viLIYQoDWdDNMtPXC
         zO6/7qjqDanY3+m6VJ2jPLaZI5WgqgKurhpKX4EUXxyqwbTurZNVO1zSW8jqNki7Qfut
         4N+ynQI5lEvv3GhonqK+kXdK9H9KLIXcEC4ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764140830; x=1764745630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXm+TGMia1g3kmuDV/aF57ZmqWwNOjaNm4FLB34Qkxc=;
        b=J4fx7Ja1gU/lr49ttdrGFBSypgpM1qL+RNNgPFgCfBqPqdkyNhli5LRKW0ZefxlJgt
         eLd2MftB6wTrn7O5tWDDrJHckTQMFCxnVTn0fjH+XrENHXhoyKtneBXe5WMrTuPd8ccl
         1Y/oJgivC98RPoKrndIpsPn4OE/grwRcgkzO6oArm9u8GC7Qpr80LDtu6QZBpJCjWtQi
         UMdiM3LlQ41/LAmVi5u3Mn+7EuimCl+Y1mXBsSmv9opZPP11Figh/EZ+x4+NFC9wbxhq
         PBU5Ht9PNyg9LTC0L3pt3xdn8SjMowG573yoemK2492AQND2ZRYSWJaTE0ncTFZmUG4V
         4+dA==
X-Forwarded-Encrypted: i=1; AJvYcCUrx9WfPxA2hOx8JsZUJhy7CZ/yc6ecp6NG8jcjb4SDGpKhNW1z+LRC9bEnQTCj3IAwJisbvSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybYhAL0u2A7p9VGJdmUkYrRxqVms6aZ07C2pEboa75PAaptgSA
	Qu39S+e2YLgyzGT/9q6bbTIz54FeNGeXYsE2W8nrcNhurrYIwzgK4rFRN5ki6rc+8AQ=
X-Gm-Gg: ASbGncuw4rarGuMjIcB7ehAt77RsJ6ZK4MCkgkSCY7P0HQbtIK/Uz7kkTpeJO5gA0/B
	BrjlS3p55pwiQcHHXWXjzC8rGe6RS3DGZ6FYsbPFksauZWWDta1nFG8G7ECxbVopjbT8msnoYpx
	KMCnXojV08zyx9SmcNjtD4bDNq/KXAKb7ac5RFVTgehDdoIyEnTm3ERUyR7kYD49GsfCMR2XAKe
	9+XCbQ3exBUHiqhgwqWGEJGqtmH9nXnNY2YZz2isB6Yr+RCGrGS5apVZe304X0r9HvkJrJnVq3M
	VFaLqbA7EJJM6qlvuq5kfARFntCFhmK9Ql4ZepXcbB6L1oFHR787UZVcc7vmHPnG3YtzF5maNuV
	n3UsD47MRv3baL4rR2jzxuyfPchfqC7F6UaEt31ToCBMs9QC+K9X+BPzO8QDuZzLXo8dh1P3hBJ
	jSdp14tfObQSJyUt7/XeG2pJKRrLUptIH1SZbOUUvDXxTnjyMGua2vIgD0dN4lvj8PLbk=
X-Google-Smtp-Source: AGHT+IGkJkFFiIZ7CfI+PiIjFnbPp5NR5QiZ9xPjeb3SVz81eUnXoOljRms9fCxUpzbe+iXyOsOtgw==
X-Received: by 2002:a17:902:f70c:b0:298:6a9b:238b with SMTP id d9443c01a7336-29bab1d74ddmr58569865ad.51.1764140829664;
        Tue, 25 Nov 2025 23:07:09 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d869:7ab4:fdd5:842b:6bfe])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b105e4csm183853715ad.2.2025.11.25.23.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 23:07:09 -0800 (PST)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Rostislav Lisovy <lisovy@gmail.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Subject: [PATCH v2] net/sched: em_canid: fix uninit-value in em_canid_match
Date: Wed, 26 Nov 2025 12:36:41 +0530
Message-Id: <20251126070641.39532-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

Use pskb_may_pull() to ensure the CAN ID is accessible in the linear
data buffer before reading it. A simple skb->len check is insufficient
because it only verifies the total data length but does not guarantee
the data is present in skb->data (it could be in fragments).

pskb_may_pull() both validates the length and pulls fragmented data
into the linear buffer if necessary, making it safe to directly
access skb->data.

Reported-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5d8269a1e099279152bc
Fixes: f057bbb6f9ed ("net: em_canid: Ematch rule to match CAN frames according to their identifiers")
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
v2: Use pskb_may_pull() instead of skb->len check to properly
    handle fragmented skbs (Eric Dumazet)
---
 net/sched/em_canid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/em_canid.c b/net/sched/em_canid.c
index 5337bc462755..2214b548fab8 100644
--- a/net/sched/em_canid.c
+++ b/net/sched/em_canid.c
@@ -99,6 +99,9 @@ static int em_canid_match(struct sk_buff *skb, struct tcf_ematch *m,
 	int i;
 	const struct can_filter *lp;
 
+	if (!pskb_may_pull(skb, sizeof(canid_t)))
+		return 0;
+
 	can_id = em_canid_get_id(skb);
 
 	if (can_id & CAN_EFF_FLAG) {
-- 
2.34.1


