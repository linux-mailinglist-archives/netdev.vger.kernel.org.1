Return-Path: <netdev+bounces-209991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38F4B11B4E
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 11:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57CD3A6A22
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 09:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26422D3212;
	Fri, 25 Jul 2025 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsxSf6K3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3B32D1303
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437413; cv=none; b=pBlfTB1A34ev7rdnvrZrkDkkx0UdduBfjFw7Q4LieSa7jWK4rIqdwSQQWzAVEkUEE7fzpD8kX7mwvSI1AY73o0d8ki2Y6+wOM1n4tn2n6vBGCwmejtJ6HRp+nrSkxLjYILO6VGiRLSBn1mihTD9h7Qm81TDg5alf4XI9qmFuOtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437413; c=relaxed/simple;
	bh=FSe8OeoGnVvn5wWZO+5G/lUNJUFqDZw1hMe3ATj9JmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OX2NbCuIqFe4DUGN6mm16L+jSECyqfLzMKEe3EFL0+lIIANJO/dugadJPNWWzO3vbHkuvnOR9vLBSXVWHvMDIzVP5UUZmUT4YfImr/FuSJEPbnuXr2ekpf3Wg0duSUbwDG1PlgZ0Sr6zEW4n1LrLReYYxK+FjQXpbQlgHGRPzE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsxSf6K3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50EBC4CEE7;
	Fri, 25 Jul 2025 09:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753437413;
	bh=FSe8OeoGnVvn5wWZO+5G/lUNJUFqDZw1hMe3ATj9JmI=;
	h=From:Date:Subject:To:Cc:From;
	b=lsxSf6K3DJB0yd1K4pKkmJDnWRrj9DztlQE3b3vTvuFFC51vd49lgvuWRk1X9V+Pf
	 Fe7/l+o9MyhpKArOPt3VJmoTibvADVhXAkUC/OFNf7zh0RGSWnrJEdc0zHdd+kkumR
	 /Mrvr/H98FUquP3Hj5lJ8JIsoWMIf2+UiO1OR/6OBzEDPlItzUnPA8xjN48B+UnKrW
	 Sx+7/PgVbgwTegLqQ1aBk9Q9x/x8sNjiqM4aw5OrumXbRlnZrpodzJc5NSLgs8usbX
	 B61U11Lq+uJgEC3jR63YqLxZq4JH0kRbgvG6DITuTfZxDmQRawelswzXHL4WSs9dJO
	 5nNFw2FBvVrpQ==
From: Simon Horman <horms@kernel.org>
Date: Fri, 25 Jul 2025 10:56:47 +0100
Subject: [PATCH net-next] net/sched: taprio: align entry index attr
 validation with mqprio
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-taprio-idx-parse-v1-1-b582fffcde37@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN5Ug2gC/x2MQQqAMAzAviI9W5iD6fQr4qFo1V7m6IYMxL87P
 CaQPJBYhRNMzQPKtyS5QoWubWA9KRyMslUGa6wzg3WYKapc1RaMpImx924kP5LxtoeaReVdyr+
 cIXDGwCXD8r4fhFHK2mwAAAA=
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
 Jiri Pirko <jiri@resnulli.us>, Maher Azzouzi <maherazz04@gmail.com>, 
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.0

Both taprio and mqprio have code to validate respective entry index
attributes. The validation is indented to ensure that the attribute is
present, and that it's value is in range, and that each value is only
used once.

The purpose of this patch is to align the implementation of taprio with
that of mqprio as there seems to be no good reason for them to differ.
For one thing, this way, bugs will be present in both or neither.

As a follow-up some consideration could be given to a common function
used by both sch.

No functional change intended.

Except of tdc run: the results of the taprio tests

  # ok 81 ba39 - Add taprio Qdisc to multi-queue device (8 queues)
  # ok 82 9462 - Add taprio Qdisc with multiple sched-entry
  # ok 83 8d92 - Add taprio Qdisc with txtime-delay
  # ok 84 d092 - Delete taprio Qdisc with valid handle
  # ok 85 8471 - Show taprio class
  # ok 86 0a85 - Add taprio Qdisc to single-queue device
  # ok 87 6f62 - Add taprio Qdisc with too short interval
  # ok 88 831f - Add taprio Qdisc with too short cycle-time
  # ok 89 3e1e - Add taprio Qdisc with an invalid cycle-time
  # ok 90 39b4 - Reject grafting taprio as child qdisc of software taprio
  # ok 91 e8a1 - Reject grafting taprio as child qdisc of offloaded taprio
  # ok 92 a7bf - Graft cbs as child of software taprio
  # ok 93 6a83 - Graft cbs as child of offloaded taprio

Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Maher Azzouzi <maherazz04@gmail.com>
Link: https://lore.kernel.org/netdev/20250723125521.GA2459@horms.kernel.org/
Signed-off-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_taprio.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 2b14c81a87e5..e759e43ad27e 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -998,7 +998,7 @@ static const struct nla_policy entry_policy[TCA_TAPRIO_SCHED_ENTRY_MAX + 1] = {
 
 static const struct nla_policy taprio_tc_policy[TCA_TAPRIO_TC_ENTRY_MAX + 1] = {
 	[TCA_TAPRIO_TC_ENTRY_INDEX]	   = NLA_POLICY_MAX(NLA_U32,
-							    TC_QOPT_MAX_QUEUE),
+							    TC_QOPT_MAX_QUEUE - 1),
 	[TCA_TAPRIO_TC_ENTRY_MAX_SDU]	   = { .type = NLA_U32 },
 	[TCA_TAPRIO_TC_ENTRY_FP]	   = NLA_POLICY_RANGE(NLA_U32,
 							      TC_FP_EXPRESS,
@@ -1698,19 +1698,15 @@ static int taprio_parse_tc_entry(struct Qdisc *sch,
 	if (err < 0)
 		return err;
 
-	if (!tb[TCA_TAPRIO_TC_ENTRY_INDEX]) {
+	if (NL_REQ_ATTR_CHECK(extack, opt, tb, TCA_TAPRIO_TC_ENTRY_INDEX)) {
 		NL_SET_ERR_MSG_MOD(extack, "TC entry index missing");
 		return -EINVAL;
 	}
 
 	tc = nla_get_u32(tb[TCA_TAPRIO_TC_ENTRY_INDEX]);
-	if (tc >= TC_QOPT_MAX_QUEUE) {
-		NL_SET_ERR_MSG_MOD(extack, "TC entry index out of range");
-		return -ERANGE;
-	}
-
 	if (*seen_tcs & BIT(tc)) {
-		NL_SET_ERR_MSG_MOD(extack, "Duplicate TC entry");
+		NL_SET_ERR_MSG_ATTR(extack, tb[TCA_TAPRIO_TC_ENTRY_INDEX],
+				    "Duplicate tc entry");
 		return -EINVAL;
 	}
 


