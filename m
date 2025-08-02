Return-Path: <netdev+bounces-211431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C00B189D8
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 02:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFC11886389
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 00:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93F4946A;
	Sat,  2 Aug 2025 00:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plyKdlgX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D9D1FB3
	for <netdev@vger.kernel.org>; Sat,  2 Aug 2025 00:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754093940; cv=none; b=DKtNKINYhr0ateARs1oQHmWwQVIAfbglCpLvyzkjJxk92JuL+N4NngXOwfEH9UtW7MSTdi2rUvfiI1L7N3vFIJpF9wnZu49i4pDLFPRr4cSal7dMZgCOpljQS2vTs2EQoLAKZMU2cOgOixk2CPzeamdtA2s2aileKieVVMEaKUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754093940; c=relaxed/simple;
	bh=PA6fUhJZ9BOtjFVEsnFfqjA9HGkGTN75JiI0zX4buy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H6KVbS67c905JFB+Tj8/KblJD1lDWCte+nwmRAi551KWDsB/hreZPx/8wiZvlDgvxf4jlG8DGOBf64SStA0FNJAOXc/PWgbtB5WF2QS45JoRtZI8R1btvwgkxIO1+WWAKWeR9Ett2TTcQzAQYzrjL5a5Rc1Fk8uG6kStsWqTHf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plyKdlgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0307C4CEE7;
	Sat,  2 Aug 2025 00:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754093940;
	bh=PA6fUhJZ9BOtjFVEsnFfqjA9HGkGTN75JiI0zX4buy0=;
	h=From:To:Cc:Subject:Date:From;
	b=plyKdlgX/AvQw4nOL6zomy1hoISHp3hPEYe5BN3eUN96ohCT3Ti2kgegXu/ec/X/P
	 +RBOr9CsZgPITIQR2dpYow9MVJbR8r15Dh89Fn++v6tJStaTQlrjEX57BDSlSjvrK3
	 xfc/+IgPar9IgOOUcEVTzLS2a0HwwRiAoUtEO1rtSdUTagIk80Dg6YSPCC0SeMyWQa
	 xWjBJYHRHUNZWTv4TsGABwLFlcqEz2PrXuCOG0pa7j7gRKbgAwCvEPpYAqiON9L7tr
	 DcegjTKl2s56Es8vCOSOLwCqXVFN6Fd/A1UyUWxOwBu66eSx7/Yzgknud+rDCwDg/q
	 8Lijs7R71oF3Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Maher Azzouzi <maherazz04@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	vladimir.oltean@nxp.com,
	fejes@inf.elte.hu
Subject: [PATCH net v3] net/sched: mqprio: fix stack out-of-bounds write in tc entry parsing
Date: Fri,  1 Aug 2025 17:18:57 -0700
Message-ID: <20250802001857.2702497-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Maher Azzouzi <maherazz04@gmail.com>

TCA_MQPRIO_TC_ENTRY_INDEX is validated using
NLA_POLICY_MAX(NLA_U32, TC_QOPT_MAX_QUEUE), which allows the value
TC_QOPT_MAX_QUEUE (16). This leads to a 4-byte out-of-bounds stack
write in the fp[] array, which only has room for 16 elements (0–15).

Fix this by changing the policy to allow only up to TC_QOPT_MAX_QUEUE - 1.

Fixes: f62af20bed2d ("net/sched: mqprio: allow per-TC user input of FP adminStatus")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Maher Azzouzi <maherazz04@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3: repost for Maher, email problems..
v2: https://lore.kernel.org/CAFQ-Uc-5ucm+Dyt2s4vV5AyJKjamF=7E_wCWFROYubR5E1PMUg@mail.gmail.com
v2: https://lore.kernel.org/CANn89iJNKR8uBNrRCdqs-M6RspvgSK9+vxzfvXe3xUvDT538Lw@mail.gmail.com
v1: https://lore.kernel.org/20250722155121.440969-1-maherazz04@gmail.com

CC: jhs@mojatatu.com
CC: xiyou.wangcong@gmail.com
CC: jiri@resnulli.us
CC: vladimir.oltean@nxp.com
CC: fejes@inf.elte.hu
---
 net/sched/sch_mqprio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 51d4013b6121..f3e5ef9a9592 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -152,7 +152,7 @@ static int mqprio_parse_opt(struct net_device *dev, struct tc_mqprio_qopt *qopt,
 static const struct
 nla_policy mqprio_tc_entry_policy[TCA_MQPRIO_TC_ENTRY_MAX + 1] = {
 	[TCA_MQPRIO_TC_ENTRY_INDEX]	= NLA_POLICY_MAX(NLA_U32,
-							 TC_QOPT_MAX_QUEUE),
+							 TC_QOPT_MAX_QUEUE - 1),
 	[TCA_MQPRIO_TC_ENTRY_FP]	= NLA_POLICY_RANGE(NLA_U32,
 							   TC_FP_EXPRESS,
 							   TC_FP_PREEMPTIBLE),
-- 
2.50.1


