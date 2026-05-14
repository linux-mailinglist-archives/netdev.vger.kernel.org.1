Return-Path: <netdev+bounces-288005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JKGI4niBWqNdAIAu9opvQ
	(envelope-from <netdev+bounces-288005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:56:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CCC543923
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F0D130A8ADD
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7988540628F;
	Thu, 14 May 2026 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="mOjepNzY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083C642188D
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770086; cv=none; b=JDB940aGL6cMAx2qe6yFBQKuGTxpXMyBrmUF6eLemWJvPFV7J3l0Us1wNU3DWC7dSRD0RqYBpRYMVV9s5KA1DiE0OUwn06fbbOrk7U16biZXWemV/dtHoxQcYxjFJ4EQB8FHdcsYQ9P40onLUOovc5sw0Y3fZl0ESt4dto5+7UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770086; c=relaxed/simple;
	bh=QEQ+ldhG9cwEyKGeY3dZdBQvt3yyZvUPYGhmaL4DJes=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mT3X2Q33YTnDN29diSVLLYzhvaFaDgDHl+TJmpnn5WLMWaEyTVFTQkWy6akVHVlWKebCmYZz51d/z0ob6ykzrcoDIK+w5F6L1DvSDi3rrYCLfRNNBK7p+j+zYuU32NxZp1+ZtZ0NByUQbxr+2EVJqYihoSbdRepSyt1j5OTqmoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=mOjepNzY; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51306c36c3eso74750411cf.0
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 07:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1778770082; x=1779374882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yu5ko0rzEh2QyDr1wpj7/FqYnuAO2Q65RdyfoM5VKZE=;
        b=mOjepNzYAQuBoVNeqZDzEaSOkU4pk+4MOjqNVyD8s/cTtVU54XY7iFwGnFewFFrdKe
         OZKVqX8gTSoJqZEHekLWotaVNSqnaokL87SeXw9NKXYWsmYf8uYKDfdA/p8xiCJsX+Uz
         Xz6H3Kf484CHM6Lm9I1/hXQMYE2jMs7xoEyHfe3IMLZWItfmsNnNxU8O/+CuxqninO2B
         2pboDbdSmHuSwhhApsmjLiAu5eOrtsyEwWjzEvJYFtln6sjuRvO6ykIqLtg1lP2FLj36
         03IiaVFG9CabJeHxQfxxgtYoyh801dQT5N7A/k7aOHcx9dEGW6oQrnA1TPngI7lr8kcx
         NxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778770082; x=1779374882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yu5ko0rzEh2QyDr1wpj7/FqYnuAO2Q65RdyfoM5VKZE=;
        b=C4Nee0RXaWQHtB6Xq5kJ2+aOS5z3g47MY3yP9MsNCey17C5rryZl7YOuOwGsBOe80V
         httFbcZ8O906/mLlLhPAiBly/kmZTwL6vz+/jKG5lKOSJnBQdFd80UTsE8y8WoXx+6qD
         kjsIW8VJERE5B2Fkzlg6+5VO0GLfI79l8GRoVc9RagfjwtUNg1Jl10iaqMCe2eCGBgQg
         reU8Ljdb9DeBmgSlZ6vbSg0ZyAx57C6MxmWq34Z0NTX1bNL4PzbmuHGZ2QbETNC6jIDu
         5eb30Oa6mbhqGiGBIIvDSUX22NTmbl4Ejr+bwJ2pF46u2KKrQf4YPJjb1Fc9BWyRGVrx
         R5fQ==
X-Gm-Message-State: AOJu0Yz7rYGJJP7myU9EacAmB8afsrDa2CoztCVf0xEV80jgtkBUjQgW
	agPIBi+roU0jAWX1/MWoIKQPri1xdyrqlGRwXmqlUiZNp/fnVA7rD7y47I1mG4+A9iUA+0W9PkQ
	cKzUNeQ==
X-Gm-Gg: Acq92OHIbJWhltwzECn5dKGmpt8iI8Vi4ER2nHtG0EWCtK0e99yj6egMetHD/fm+oKq
	1PqU5ckIinwss4m+Ca8M3XJaz08cdIb3b3v2Idr3/QXRfTQaxbtzBN/uEpuOFLvessFHNuVb3Kg
	lwF2hW2zfkMB16bmH4JZ1ejNurVFmyu83/XzsCGJSmrnaF7udtT28UZqIMw4h4msMEtt9LZ5K+c
	/lXFn4EzXcTfWaLuvngnj59j4AlINvzvrdVXMSvZhSu+mIF8LcaXcc2Pe52NXL+GP2moIOMB/t4
	gYTZXcEIOYl7g/ZHglSLrgjaZRy17IXSDXsXu0+gGyNHBwBGaMY1G6L6SRfNVHzdKw9CGLbgt5A
	jMlbOtE916/IDD2Y8KUKmRaDjIUZsIG2SDUJ0SXeagf1G5/XhjS+jDcZBWPXtZUDignvT7fk1W2
	JXtT+6kfIu4eCApBrBhlCECWbJo0o=
X-Received: by 2002:ac8:5d89:0:b0:50f:c36a:3826 with SMTP id d75a77b69052e-5162f483919mr112102261cf.16.1778770082346;
        Thu, 14 May 2026 07:48:02 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456c0a42sm19125461cf.10.2026.05.14.07.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:48:01 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	victor@mojatatu.com,
	savy@syst3mfailure.io,
	will@willsroot.io,
	xmei5@asu.edu,
	pctammela@mojatatu.com,
	kuniyu@google.com,
	toke@toke.dk,
	willemdebruijnkernel@gmail.com,
	hxzene@gmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v5 0/9] net/sched: Fix packet loops in mirred and netem
Date: Thu, 14 May 2026 10:47:38 -0400
Message-Id: <20260514144747.527175-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 00CCC543923
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288005-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,mojatatu.com:mid,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

This patchset adds a 2-bit per-skb tc_depth counter that travels with
the packet. The existing per-CPU mirred nest tracking loses state
when a packet is deferred through the backlog or moves between CPUs
via XPS/RPS. A per-skb field covers both cases.

Patch 1 adds the tc_depth field in a padding hole in sk_buff.
Patches 2-3 revert the check_netem_in_tree() fix and its tests,
which broke legitimate multi-netem configurations.
Patch 4 uses tc_depth to stop netem duplicate recursion.
Patch 5 uses tc_depth to catch mirred ingress redirect loops.
Patch 6 fixes the infinite loop in the mirred egress blockcast case.
Patch 7 fixes an skb leak in early return error scenarios in tcf_mirred_act
for redirect (caught by Sashiko [1]).
Patches 8-9 add mirred and netem test cases.

Changes in v5:
- Fix issues in patches 6 and 7 found by Sashiko
- Set limit (1000) in root qdisc in test 8c17 to avoid flakiness (Paolo)

Changes in v4:
- Fix the infinite loop for the mirred egress blockcast case
- Fix skb leak in tcf_mirred_act caught by Sashiko

Changes in v3:
- Renamed skb->ttl to skb->tc_depth to avoid confusion with IP TTL
- Expanded commit messages
- Split mirred and netem test cases into separate patches
- No code changes from v2

Changes in v2:
- Do not reuse skb->from_ingress (which was moved to skb->cb)

[1] https://sashiko.dev/#/patchset/20260413082027.2244884-1-hxzene%40gmail.com

Jamal Hadi Salim (5):
  net: Introduce skb tc depth field to track packet loops
  net/sched: Revert "net/sched: Restrict conditions for adding
    duplicating netems to qdisc tree"
  Revert "selftests/tc-testing: Add tests for restrictions on netem
    duplication"
  net/sched: fix packet loop on netem when duplicate is on
  net/sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop

Kito Xu (veritas501) (1):
  net/sched: act_mirred: Fix blockcast recursion bypass leading to stack
    overflow

Victor Nogueira (3):
  net/sched: act_mirred: Fix skb leak in early mirred redirect returns
  selftests/tc-testing: Add mirred test cases exercising loops
  selftests/tc-testing: Add netem test case exercising loops

 include/linux/skbuff.h                        |   2 +
 net/sched/act_mirred.c                        |  73 ++-
 net/sched/sch_netem.c                         |  47 +-
 .../tc-testing/tc-tests/actions/mirred.json   | 616 +++++++++++++++++-
 .../tc-testing/tc-tests/infra/qdiscs.json     |   5 +-
 .../tc-testing/tc-tests/qdiscs/netem.json     |  96 +--
 6 files changed, 696 insertions(+), 143 deletions(-)

-- 
2.53.0


