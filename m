Return-Path: <netdev+bounces-291306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIt/NO0/FGoXLQcAu9opvQ
	(envelope-from <netdev+bounces-291306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:26:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A48745CA736
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D59D30046BE
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E4381B13;
	Mon, 25 May 2026 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="0LIozw4l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA7535F19A
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711974; cv=none; b=anGVlTpn8SZT3wEatsmth6X6Sc9S/xB+BMeEvGFWcgfddBYjtpzzfscddYyxnhXlVIIi6g9aoPHHObI5KODdjsCR8eReak58WbKLRY/ongj6F0C2M3a7SfK4UUyldgWvsC+ovKy4ddxAGSpVBE8SHtTC0EQppHmXYd2kYlYe6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711974; c=relaxed/simple;
	bh=GIqNNP2PbeDfJSOYGyEPKACjqmZ70xY+0eGPsUbFkDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=idKk+zj0rWOcdIyrEdGBQ7Z9hVxogC99FG+R6F2p3MxRbKUGsuNhQJcBClnCfZR0PK9aou1C5skfVYbGc1ex5C+HUqLbyI/OUMn6yvCLdznHJRVSDRr765SxCgtM7WQcW//QVRB81W4DNGr4rpBUVSNXGtdIEzjBPwAEFOGlJP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=0LIozw4l; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8acae26e564so124987966d6.2
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 05:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779711972; x=1780316772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EjaT7M4ZuiwZ6rGT9mnnFcdLthNWUHHKyyUhPsk+FgM=;
        b=0LIozw4lm7NTe9AjDmqfdgN87qHdTL70zrj8v+h4rpqOT3GVW2V3Dt6iD/okFKXeUo
         Q/Q/O2LiDNkhChaRTxuJKOFz9+xHrOKh7cu8RXdYELJFt2p2gi1+HzaJ/SGxUu56RXcs
         9kmLkWt8bwKZZYXg6ARiIslTnnoeZd+59SRch/U96GNdXbloGTFGW+a4JcJJvPFJ3WBo
         YFbzMy2KYnoB02KaaqyKCyr2mrhM2N0iMPoLBojL6QkUpqwQSpXwsPNhY+QoQ2roR558
         47prb+2fFb8Idbf+ArIVUoO85IA4D/xi5erd8CuFXDDQTIqstsl4OolRwqcpHSk6Xyuy
         AVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779711972; x=1780316772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjaT7M4ZuiwZ6rGT9mnnFcdLthNWUHHKyyUhPsk+FgM=;
        b=DsdNrVxxKOebSWtZ92Ux2SQxD05FFX+If5NZt5+dRVidGTuMUoLo4qxwfjseAberzq
         d5rPsPsouVqbsUtaBCYsXmodf3cYF/CJC7NCkYYiahSPpKcrQjPd7N4BDuOjOGu3SkyO
         3DUY5NyeEb1Sv6PMttakns3kajbvyHCH8TEcT07Owy9PolkUUEB8wuA96xU2wvDO/igu
         tNZnH24RvM/t+sCmKsj6pBR98No5hi3CNuija5SvvBEJp1RJJHg91q07GFrVxq5+91xe
         xs677/PRejwpqYqMZNEQHOgGSZD10s6YDKC3rLLz9Tc2Mvm8+z5nR5qxEftK9mDU10Zo
         F1pg==
X-Gm-Message-State: AOJu0Yy/80R5gNfPPxHfyssWg7xusGoPp2UH2lyoBgLBOWQUeodQyGiw
	HxLfRXPTi7yLgCx5NHjiFJr+a+CR5m5w8fRm/oZLorwr4TEKmBKHxzMvN6ulZO+wgfS6eh37pxU
	VDu8+bw==
X-Gm-Gg: Acq92OEEOfz8k3VTPxjP+cGDSypqKtwUUVVJ9uSVzSC3nA/fL1VAP9rPtb2AN0cJ9TD
	+Vs0jIbgQCfcuF9kj8c6sWTW4M4B5uWOD8JCkTtIoMr++Hl5L3wB5mRKeTINOu3fZDbzjjT5wbU
	6EteKAf3YaBH74tvRu6+9QyuWhi9OoecxB8vhdRtyTBDRg2tQZS06ir9JfH5EeTD4QWUCs6QjW2
	pL9IhDajIr/JjdciiFcqkVx5/FUBI/THtRsoOcyEZYuil0VWrheMxmoYSec387cc7gGLuxTxIXb
	7w1QdlDOaZJSEgw58+Pwib0OGCegy1rfddVXvkC6yyq7XAAY2lCnMZa+24ZheT8RdfEMoOmSvDu
	zQ1WnNK2rccAQfVewfgBObxxJtc0SwvAPR69cQlP+H1gSI2mneFgof3YekdCjXZ8hKrV/X+AMNA
	sO/5eSN7EopgOD0cPhUUZDEjdWlIM=
X-Received: by 2002:a05:622a:190d:b0:516:d955:ea2 with SMTP id d75a77b69052e-516d955144fmr169939321cf.0.1779711971596;
        Mon, 25 May 2026 05:26:11 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8cba4easm91351761cf.24.2026.05.25.05.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:26:10 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	will@willsroot.io,
	hxzene@gmail.com,
	victor@mojatatu.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v6 0/9] net/sched: Fix packet loops in mirred and netem
Date: Mon, 25 May 2026 08:25:47 -0400
Message-Id: <20260525122556.973584-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291306-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,willsroot.io,gmail.com,mojatatu.com];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url,mojatatu.com:mid]
X-Rspamd-Queue-Id: A48745CA736
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Patch 7 fixes drop stats in early return error scenarios in tcf_mirred_act
for redirect (caught by Sashiko [1]).
Patches 8-9 add mirred and netem test cases.

Changes in v6:
- Fix new issues found by sashiko in mirred
- Fix patch 7's commit message saying it doesn't fix a leak, but drop stats

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
  net/sched: act_mirred: Fix return code in early mirred redirect error
    paths
  selftests/tc-testing: Add mirred test cases exercising loops
  selftests/tc-testing: Add netem test case exercising loops

 include/linux/skbuff.h                        |   2 +
 net/sched/act_mirred.c                        |  77 ++-
 net/sched/sch_netem.c                         |  47 +-
 .../tc-testing/tc-tests/actions/mirred.json   | 616 +++++++++++++++++-
 .../tc-testing/tc-tests/infra/qdiscs.json     |   5 +-
 .../tc-testing/tc-tests/qdiscs/netem.json     |  96 +--
 6 files changed, 697 insertions(+), 146 deletions(-)

-- 
2.54.0


