Return-Path: <netdev+bounces-179596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A79A7DC47
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937683AF29B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD599228CA3;
	Mon,  7 Apr 2025 11:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNB4tcL7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4F23C8C8
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025390; cv=none; b=qtGRw4O+aOYgUI6kw1s+4VqZi7Tu6bY+jxFguLEvR6AwA7Sc+Jvl+pRAMQp7xq7jZ9GeLzJe+fNzWZyKk7rs6pmiATkb85dsg4uaThuACzBFIc9SJPbb3IVZUKFvra1d+w4Eq5KcmrpyqAXaHn+eDilnuJxwz3+YKvFIjbXRkno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025390; c=relaxed/simple;
	bh=2jWtLUj/ovkSW6SE8BdRexouF1Lh1m6+gWggFThLjb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eIL1k5+FkC0iwjz2M9jyvjSAIQMQcIKplTxf8e3BLoTyWDnrrbLZIAxInGMEbYpkaqXD3KfkVlVDfmd2rzoiGBMvAltUgvvLUDto0LOU6SEzLsPSXTuWMU6uXYApa0vy0ceK7YBU99LUiAdFRaFHE6hcV/0Ijuf4PSKbSF7izkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CNB4tcL7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744025387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S47uxvMBsLxSdhSuqk28KOUPEUMIfPAKz3tmaljnDSI=;
	b=CNB4tcL7IbqgXafoFv+m2oA6GxbyQVDXaU6vCy/GYJedQHEsV9+bXdb47kwI6mI4BknEJH
	ukiwRBaaGqddDOCO9FohoAkBdXeWApXpyMFlnkdabgauAZtXsOandittSkUOOWD6tCtNzJ
	jQ87gfjjYefNsTMIDTb75NMnawtBRbE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-N_b808kqNauv2wvlPCyvPQ-1; Mon, 07 Apr 2025 07:29:46 -0400
X-MC-Unique: N_b808kqNauv2wvlPCyvPQ-1
X-Mimecast-MFC-AGG-ID: N_b808kqNauv2wvlPCyvPQ_1744025385
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac3df3f1193so336156266b.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 04:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744025385; x=1744630185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S47uxvMBsLxSdhSuqk28KOUPEUMIfPAKz3tmaljnDSI=;
        b=T7w24sBPP6x5yKN7trGAdeK8T66ci0bxEh1vh8DrjBNw6wFR8YYyFxsC99SqI5mAM0
         hl20d7hMjvE9XRRCeMNsgmvrI7ODOlTIPpwfjqur21Od8QYn7rRiDf2edt5SOXtG8Hu7
         VaPC5rwvk+AVpsuKa/zQiFfrtFEXtn9TVPNPKbKKEdqmM0U92WQId7mb2kMHCWrYWB6M
         BldmZi8fLTA07inhf8DpLyFDJXSZU97q/kLKkzLXy83G+dyHXIC/aPt10inMOJhearpV
         Ji5b+4BBKL6Jk0r9WdFTQVfIBL6kpMmRq499rhPtyjGZ7lqYFXFcsU5sFhmoEbBD6wz9
         2VdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh7ScbVC6HvE52rwLDS6mgSzX5BjwiQ3UNaaqhVozsh51X/Kx2+OxpVoxYsK38HqT2grY8t9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc0u05C4EamzD+JjuJ+PTTAOODi9znV+kW596JKf3zdOSKOc/D
	ByPyQNOxtMKGiAXpI3HTEzT+X/YRCyVDkzdcLz1QxiN6L7SyMKjrA/hoXK9SZy7ZbvTsDm9TByl
	4WDXDenL+3rKm7iBahympYSfW54lLZZYAWQwiiWF9OiwfhyQgwHSAYQ==
X-Gm-Gg: ASbGncte0uOBeujkoF4prB7+n7AOHhDZxkNGdLuMX5Aq2LTYv7rijdPnb367BRJvzl4
	ICmeRkNRmKI+MIwLeBGa9pgTcPkMs1aULJEjtSJQuLSwwZ5V6v4yNtciZMi2m7HyaI+2uT3XWDO
	W8sl4PW+vLQ9NyZImcbnPCGY+wcBpxKUxLqU4BcH3+WqdAh0LpyjeV2SMAj/KjP3JqbXFRBUEFE
	JrdXzlH0j9l4ByGZUKtsKMYlbA7cufTOqEWag2fXoInFatHkUXCkC5EqdQJYp9iRSy7TkQoc41l
	yhrZfshLyWiuDx3hzp7M7TlWh5kkxvw0I1aRWCel
X-Received: by 2002:a17:907:2cc2:b0:ac3:898a:f36d with SMTP id a640c23a62f3a-ac7d6d598d8mr1023232766b.30.1744025384866;
        Mon, 07 Apr 2025 04:29:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbTDXIwypIOOYSjOxLORhnbWyUEOHrZ4qkpaCB7MbMb2+Pzvk97ne8tm+FeRkc8RZ8qOhO+Q==
X-Received: by 2002:a17:907:2cc2:b0:ac3:898a:f36d with SMTP id a640c23a62f3a-ac7d6d598d8mr1023230366b.30.1744025384376;
        Mon, 07 Apr 2025 04:29:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c0186a03sm728372466b.125.2025.04.07.04.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:29:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C26C91991884; Mon, 07 Apr 2025 13:29:42 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: Ilya Maximets <i.maximets@redhat.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [RFC PATCH net] tc: Return an error if filters try to attach too many actions
Date: Mon,  7 Apr 2025 13:29:23 +0200
Message-ID: <20250407112923.20029-1-toke@redhat.com>
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

Sending as an RFC as this is obviously a change in UAPI. But seeing as
creating more than 32 filters has never actually *worked*, it could be
argued that the change is not likely to break any existing workflows.
But, well, OTOH: https://xkcd.com/1172/

So what do people think? Worth the risk for saner behaviour?

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


