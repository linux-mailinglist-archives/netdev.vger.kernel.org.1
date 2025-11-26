Return-Path: <netdev+bounces-241757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EB5C87FC6
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93759353FE3
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3411225416;
	Wed, 26 Nov 2025 03:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="XHP2KBa8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E5A8F4A
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 03:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764128774; cv=none; b=Xu1+umeILEeYxko+al4njpdT6jRX6x3PQqsdChGdIGLtJSNKUJMy9wrSGhZQOlPC9LECOxykb0WApQyEtYTeOQlz7siBLjg3SsK6qngOkBHF4Fw+vyfxWPV3d35ZmX1kgT/dj98a7lTwoSVMJHKRTfAlKcUt5q4pREZ+6flvoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764128774; c=relaxed/simple;
	bh=YTJTsaHQmUL99NvK8+4VZBxoWMvT0DJLWraueRWowDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=etPan3e6WmIl+ZWcOTALil3yttslGJqCF7SsGCYbUT+mams7zvAdF/1IAAub3KCE97aTLgmF4rQ+Xjb8IuOKBfW5YAAqQcz6ElF4+pJ+9/dnFmo3P/PdF0A/9Xxkolp43sA6PTrIO993944rC0YR3XlUesGyEh+9u2BFqdqC/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=XHP2KBa8; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-343ee44d89aso8890068a91.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 19:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1764128771; x=1764733571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/0OQa00OisAI9Yf2BGn0QlVHZWUx/PRSa3ljqdERpcQ=;
        b=XHP2KBa8J45PHqk4TG0AZi6qTrM1tPDokkLlQWViQ0+szwHvxDwNOuJE7pPI4qIr8m
         6iRdvbfNZyo8iYTz7LQgd7k5LrB8hR/rBtUoLcG4VmRl/XsXXNeI2wpyqw1RwTyx449I
         8E/rman10kBGMCPL6SCJZ1J91v2B1NAEaT12k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764128771; x=1764733571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0OQa00OisAI9Yf2BGn0QlVHZWUx/PRSa3ljqdERpcQ=;
        b=f88IbYQsBCdLRmNoks4Emhw1kC+qsxt0FUdutSAl74AZ95vK5ZLGsfk9dv3YqyHmt5
         4E+RlPINV3/GGiFHquJluvTSoU6EEw62LQShDTTgkHxibgFMzhbTJgqYQbzkmCmWVorO
         B52byPYmfSuLQ9XZD0gcCs0Ei4BmngodvYK20tLa11PUGhaypajg2rwg5JI+tnYpydji
         xIxEs/iCrNzSaRjCfcFAYK6VcDc0xulUwFxByhrxKHGupLI0IB7nWUqg94gu3QuyzITP
         Xmq0D/S8UvEYUn2+hjhZutDA81kxyGuYXXUnPZ6K0dkpB/vTXem8y3aA1pRlRX+r79hu
         BnxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWan9o/hZQ+Mp0JqfXG3E/cWJqJPzctGT+0fe3weWkb/gLYroTIQ3hWgmb8xL0CM+0hpDkJOZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNp1hY988aAKJI9ZyeB9xoz5W8/9ZevLsfHxiXbuHsJwXygNGw
	MTHRfvBw+XxvfCDft3ge49Pa72GSIiwsn4enho1heK1+qGnCjrmL4rMpw5vO4nQqbIk=
X-Gm-Gg: ASbGncsJTAbT2RKt4bVvZ8ZW91Cyrt7h2pGUyAgmWHwEF/UDZGyKW7AU93O1JxuR5rx
	fDXO4bIool6/to/AqDHGYXUpmMk7GJnGPZ6AEhYtg4+2C7LIP5/372EC4xYh4bDzq/AScVY7lG7
	uh5EUH3m9CaUxjqfwI9NoY8zrYiOuxg/nObfQWRoaY+r/zu3tIt6r5ckLTvat5ptqNKbHBO2lIV
	GUys4PX+S9n1Z3C2jzQTWzU5jZ07UMmCQoahkdow+ENfA4yW7BdrFss2Sufg6cn72D00KlO7MrU
	0jyd+iaC9OgiMMcldadC4RW/TN+1pTqsyxiY49rY2Qcrz5UgywIRCiJQacUGP0Za5WqgMsynIkW
	9wZt0ZASViJmUXA297lldsWAuV9CSuHldwkoMDU2uco8Tj/MhQILrOIaIQGo7QfVV/22b1Kr4Vt
	65ywfoUsy3clutghhuF+sIyPzh7dmXW3jm7Q4k0WJMxigdxjwAXNf6j37A
X-Google-Smtp-Source: AGHT+IGdbZpTaNhkORvuwsJtkl/0aqTP4Z+/MfLQ2cdKMWZ8EnjRZs396Kq3PBwRLHF0A7Z5HsdZeA==
X-Received: by 2002:a17:90b:53c3:b0:33b:b020:597a with SMTP id 98e67ed59e1d1-34733d68a15mr15410786a91.0.1764128771454;
        Tue, 25 Nov 2025 19:46:11 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2405:201:31:d869:f53f:2666:7529:e5cd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475ea1b3e8sm1509638a91.5.2025.11.25.19.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 19:46:10 -0800 (PST)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: socketcan@hartkopp.net
Cc: mkl@pengutronix.de,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Subject: [PATCH net] net/sched: em_canid: add length check before reading CAN ID
Date: Wed, 26 Nov 2025 09:16:01 +0530
Message-Id: <20251126034601.236922-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

Add a check to verify that the skb has at least sizeof(canid_t) bytes
before reading the CAN ID from skb->data. This prevents reading
uninitialized memory when processing malformed packets that don't
contain a valid CAN frame.

Reported-by: syzbot+5d8269a1e099279152bc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5d8269a1e099279152bc
Fixes: f057bbb6f9ed ("net: em_canid: Ematch rule to match CAN frames according to their identifiers")
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 net/sched/em_canid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/em_canid.c b/net/sched/em_canid.c
index 5337bc462755..a9b6cab70ff1 100644
--- a/net/sched/em_canid.c
+++ b/net/sched/em_canid.c
@@ -99,6 +99,9 @@ static int em_canid_match(struct sk_buff *skb, struct tcf_ematch *m,
 	int i;
 	const struct can_filter *lp;
 
+	if (skb->len < sizeof(canid_t))
+		return 0;
+
 	can_id = em_canid_get_id(skb);
 
 	if (can_id & CAN_EFF_FLAG) {
-- 
2.34.1


