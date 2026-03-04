Return-Path: <netdev+bounces-263701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C+tAHkAqGnynAAAu9opvQ
	(envelope-from <netdev+bounces-263701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:50:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBE81FDE4A
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBC8330B102E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 09:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00DD39D6D0;
	Wed,  4 Mar 2026 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qOD/mkbd"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE56386425;
	Wed,  4 Mar 2026 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772617550; cv=none; b=RDlj3aEX+iW9TrR3pS6Ytxwrcn9elEvHY1Y9sm5RBq9GwFJyeJYc60OE+NjteQXgVTSRuicnEeeorkJPSmNT0d/KG3OcSnGBCzXBNk33VKlwFCVJjE70n0NltPi7QjE0qJntl+SmS27w+uXcfoL9+J7WmhXoSjb35se78lc9wSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772617550; c=relaxed/simple;
	bh=DHcRKnTdSBMPwyItzgqFFwuKKqQc6Iary+f3kqe3ZFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hm0zkCUjuMKO4AHAQY240Xj793Y246m98t5o3+YtsrloT4GotDUWmBKfLtOEc7G6DHxxPqF88QZRjICjELdv5k9b/D0TJeU6LB57+cQJtRflzcd4k+SKwyinRh+Vl3bX1yntrSP0rnmPF5luGzM8rX3jVQ9DNRk2++BujMHlhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qOD/mkbd; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jD
	+Sp4wtwMkRsgqj6ZVTSMoYWYf5p6y+YL87jla0SGA=; b=qOD/mkbdLmVaDfMjvh
	kh6dgkW4xF3Fx7h3tOHuxqVTSvmYP7jLUuJmuIjujM/xVFSEHD/5SLXMjqC4KC0G
	U8jiN9z89ee3EaxLaik5Y22XOmrCN56BOSBl+bSBOG3wLbNWExtOzl+fvZ1t83f/
	RJoic4nfls5VX7kJ1Y8kZmZ+k=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgC3f179_qdpB89zRQ--.55S2;
	Wed, 04 Mar 2026 17:44:33 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	posk@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yangfeng59949@163.com
Subject: [PATCH v10 bpf-next 0/2] Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
Date: Wed,  4 Mar 2026 17:44:27 +0800
Message-Id: <20260304094429.168521-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgC3f179_qdpB89zRQ--.55S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ury3tFWrZr4Dtr45Zr1UWrg_yoW8tr4DpF
	W0qrZ5Gw1rtw1SqFs3Ca13XFyFgan5Gr1Ygw1xA345AF4DZryUJryIkw4agFnIgrZrur4r
	A3ZaqF13Ka4jva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRFoGQUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8gJEvGmn-wIxVQAA3f
X-Rspamd-Queue-Id: 5BBE81FDE4A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263701-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangfeng59949@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Feng Yang <yangfeng@kylinos.cn>

Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap

Changes in v10:
- Optimization patch. Thanks, Martin KaFai Lau.
- Link to v9: https://lore.kernel.org/all/20260303074423.172680-1-yangfeng59949@163.com/
Changes in v9:
- Use dst_hold() and skb_dst_set().
  !skb_dst skip.
  Move all changes into the IS_ENABLED(CONFIG_IPV6).
  Use #if IS_ENABLED(CONFIG_IPV6); otherwise, a compilation error will occur when ipv6 is not enabled.
  Thanks, Martin KaFai Lau.
- Link to v8: https://lore.kernel.org/all/20260227082133.96951-1-yangfeng59949@163.com/
Changes in v8:
- set ret to an error code before goto out.
- Link to v7: https://lore.kernel.org/all/20260226095156.117996-1-yangfeng59949@163.com/
Changes in v7:
- Use ip6_null_entry to avoid. Thanks, Martin KaFai Lau.
Changes in v6:
- Modify the bpf_lwt_xmit_push_encap function and add selftests for it.
  Thanks, Martin KaFai Lau.
- Link to v5: https://lore.kernel.org/all/20260210090657.86977-1-yangfeng59949@163.com/
Changes in v5:
- Refer to the bpf_lwt_xmit_reroute function to configure the dst parameter.
- Link to v4: https://lore.kernel.org/all/20260209015111.28144-1-yangfeng59949@163.com/
Changes in v4:
- add rcu lock
- Link to v3: https://lore.kernel.org/all/20260206055113.63476-1-yangfeng59949@163.com/
Changes in v3:
- use dst_init
- Link to v2: https://lore.kernel.org/all/20260205092227.126665-1-yangfeng59949@163.com/
Changes in v2:
- Link to v1: https://lore.kernel.org/all/20260127084520.13890-1-luyun_611@163.com/

Feng Yang (2):
  bpf: test_run: Fix the null pointer dereference issue in
    bpf_lwt_xmit_push_encap
  selftests/bpf: Add selftests for the invocation of
    bpf_lwt_xmit_push_encap

 net/bpf/test_run.c                            | 14 ++++++++++++
 .../selftests/bpf/prog_tests/lwt_misc.c       |  9 ++++++++
 tools/testing/selftests/bpf/progs/lwt_misc.c  | 22 +++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lwt_misc.c
 create mode 100644 tools/testing/selftests/bpf/progs/lwt_misc.c

-- 
2.43.0


