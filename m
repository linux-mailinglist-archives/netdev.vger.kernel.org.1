Return-Path: <netdev+bounces-279112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANU2OqIw4WlGqQAAu9opvQ
	(envelope-from <netdev+bounces-279112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:55:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88501413E53
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EC0B304A9E2
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AB7342507;
	Thu, 16 Apr 2026 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKw1n2ic"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104B133FE15
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365718; cv=none; b=Wk9DtKaMvQ3pdSK3xNwk1bo8J4s6drLeLwc1LCZlsNAGBv86jKHl2QqEshMADmndm06oe/SSLZr7TZmOJo1b6lzkfg9kpu9xnkPCgT6DQS/yyexgxVRqVX7edtGNV/hV8cZsvNhBUxidgitfgbCf5N6j6uq4gPrE7BtphV7scIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365718; c=relaxed/simple;
	bh=MoPwoKNMJXoJl7pQQMFCQ7qn+Gq+6mglDf/4ddqb7wU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mO2mknR5MSBB3Ax652EK8xu+eX6P2eItTN6Ecb3LvxRclL1SpP3LzmrbCDMR324XSwW6N9NNSSfZ0pzCZccEG3mnrcvD2tqAkP7+IrG8IdzZq5WQHiMuOwhXMNcQDj6nJNTcP/pv/s5EfHqtx7NSp/21xsxLnfhxCohdwihswuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKw1n2ic; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82ce2e2880cso5352577b3a.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365716; x=1776970516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=krdyOM9ukFLYYn2YIwb972SKISC7V1uF7ZqrEut126w=;
        b=JKw1n2ic3dAL93rH1J9U9mcaoY7HC8S2PvRcRt0A/5mJrdyaMeovQQkkByixV+XDID
         v7ssfJU9fY2Y4O68O1fcxUuC0M6OSnZOfmT8O+Z/wvYOZohnp4s7KMEoU+wRyVKD5BH3
         wezdoEHVlNFH5oV27dnb83kCxnUopRN4IFjyNoyP41/VebAr/otMEDbRHbpU7rbjOYpF
         jdqNestNivIwwV3+4Rce7va0KXX7aIj/bkhyQ2IrUoq1BRl9tyz+68gKttstm4OEUsoh
         zeFjzQH/M0bTsku701KQjbD4EeyHX2gheidHdhnmghahnhkfrYz1op/OjMBSHS04uKK0
         M38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365716; x=1776970516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krdyOM9ukFLYYn2YIwb972SKISC7V1uF7ZqrEut126w=;
        b=DSdQPBLA2eVQKUUGdy/9mvTOP1pTDFpOw8ictzlxcCR3gpVY7ADTFUiytt9I8G8Dlg
         BVNv902ld++Eak9Eg0GL9n0giuopuvO+fN8bUx41+QJDSuw6kAKgi+Jo2itzhyp1PgE7
         mNi2J/zQhq/l1Q/Q7vP0/v+06+wbBOkNlkvLE9H2qchv1OLpONxLZ7FU4REErWvJqo+q
         WM8ObnE9eDWmg4GYuPVF0wm5TbVpnPZ19HqmYV4TQWGhLu9h2vtD9fYgVvyYmdvvssJS
         t5O8wq9r4YUvynCr3apl+jMPxiTbxGZoNq/mIvTdEaCBKtEBxOMGL0+/6Nj7TwQcX2Yf
         rGnA==
X-Forwarded-Encrypted: i=1; AFNElJ9uid0sojAZ1cFTIzDn+/Ax4+Awh21tdK3YwCB73Zs2jmUJW/8sJHkxP1S/2Jy4fRXqNCpfvBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy472XiNRIDyPdWiCNStjhWW1gHcBFCvE2LuPz0G5RlDTRigZ4s
	sTWilmCC6kk6msDM1Q9yuX0Sa2GqU6I3H76uv+FgJ3Y2Nk9MYb78kNNn
X-Gm-Gg: AeBDietxe1Ux8Lv5akSPB3U3OckA+YhtuGaTn89/HNwA6EmYZ/HgvUSQR3geP597wYJ
	Q76GWo23NzFfu7zJVfzQeXpUB2/4cwq9myiBQ5XEOP2YWJdx55Sf0IfxqbFJdn0V0xGJV9KC5hO
	vA2FR7tVWZxdEXmzvmhujPlgD96kycuk38nGmPSjdV8oTsbarYpvssLQ6ExQW71uDakXwVhUvVj
	HlP8crP4tfzHKyTHhwccdZ8OMK+yJuWUuYYZ8GmofrQKXsOJCfmqS+chdyX0kGup+m83NBJSKN+
	Whb6eQBhH6j77eZ5GHx1FvJISbLin7xVZuaHkntk85ci9UIqYrKHYYYleN8YKv9aL2o08JdC757
	gBSnnW9IgiCdRRYcSzYQh46FtkLx8/3IMaw3MBtuE7Kf5cTnJl4FhaNTN+lKZB4ANTHbWBfITB8
	sZpPKi2LwiUmn6sEOLwJAHPHkC07/WWzolBB3L/m26NEbBlA24pYhm75EGSJ/qVVmCUNB7+4lyW
	tnoZuL3n8YZJF4+aeAzsQc=
X-Received: by 2002:a05:6a00:3692:b0:82f:1b42:11d0 with SMTP id d2e1a72fcca58-82f88807affmr591113b3a.15.1776365716365;
        Thu, 16 Apr 2026 11:55:16 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6744b350sm5668181b3a.54.2026.04.16.11.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:55:15 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: jhs@mojatatu.com,
	vinicius.gomes@intel.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: horms@kernel.org,
	vladimir.oltean@nxp.com,
	xmei5@asu.edu,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v4 0/2] net/sched: taprio: fix NULL pointer dereference in class dump
Date: Fri, 17 Apr 2026 02:55:00 +0800
Message-ID: <20260416185501.647884-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,asu.edu,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-279112-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88501413E53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix a NULL pointer dereference in taprio_dump_class() reachable by an
unprivileged local user on kernels with unprivileged user namespaces
enabled and CONFIG_NET_SCH_TAPRIO=y. The bug allows a local DoS via a
crafted sequence of taprio child-qdisc graft, delete, and class dump.

Patch 1/2 is the fix: replace NULL entries in q->qdiscs[] with the
global &noop_qdisc singleton so that control-plane dump paths, as well
as the existing NULL guards in the data-plane enqueue/dequeue paths,
cannot deref a NULL child qdisc.

Patch 2/2 is a tdc regression test that drives the graft + delete +
class-dump sequence on a multi-queue netdevsim device. It panics the
vulnerable kernel and passes on the fixed one.

v4:
  add selftests/tc-testing regression test (patch 2/2) (Jamal).
  add Assisted-by tag.
v3: https://lore.kernel.org/netdev/20260414104311.74115-2-bestswngs@gmail.com/
    fix broken patch
v2: https://lore.kernel.org/netdev/20260410153902.955227-2-bestswngs@gmail.com/
    also update NULL guards in taprio_enqueue() and
    taprio_dequeue_from_txq() to avoid qlen/backlog inflation (Paolo).
v1: https://lore.kernel.org/netdev/20260330102904.2677818-5-bestswngs@gmail.com/

Weiming Shi (2):
  net/sched: taprio: fix NULL pointer dereference in class dump
  selftests/tc-testing: add taprio test for class dump after child
    delete

 net/sched/sch_taprio.c                        | 11 +++++---
 .../tc-testing/tc-tests/qdiscs/taprio.json    | 26 +++++++++++++++++++
 2 files changed, 33 insertions(+), 4 deletions(-)

-- 
2.43.0


