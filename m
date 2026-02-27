Return-Path: <netdev+bounces-261766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMfEG9JUoWk+sQQAu9opvQ
	(envelope-from <netdev+bounces-261766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:24:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7F21B47E8
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDB6A3056D9C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15023815E6;
	Fri, 27 Feb 2026 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eLVRspse"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AB93019D9;
	Fri, 27 Feb 2026 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180558; cv=none; b=ur/GGL/n2rgLU67+o/s6Oun7QE6OjYwTW6RaXZ7YGQe2Ey+hbmEmbzhTtT4Qr/qCjDDocAZTx0AIrO/O8wI53wXsJ4SypNNs0Lt4ghQmBrZCXGjNO4QDKB1ZrVTzNK6fKsYJEL6wubaRBqx7SBXmNWcBNO+qxmUjsuQaMy3rKGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180558; c=relaxed/simple;
	bh=n15ZVh+yuOZvVFW0tr5J935i5t6IIMxIk1tYWO4WMcA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PUqOgAhSYvbZ5BsS//4WZGvFZS++KCoqWEanyewXXqZ9xUdB9SNw8OPQdbMaScmvvQFXhXOPxegH6/bBTFGTYilJZpWn6lWYPdOcdCEU5uG/YlS0c79kafOFb2JYOWpw0A9qAaz26GGtvhwjgKOBI1i8PN44cfQpEM9vAVnJ1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eLVRspse; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9E
	tGc7t4BhXs16wGg2NagQqwtRrEVw0UKxRfysY8Zvw=; b=eLVRspseSTlsXP4fvQ
	WH+UtVZbQlIxNHvXMC1/+iOKAzWzLtRMHuUeNdX7rMSlhWdLJtz0nI+jtuSVKH3p
	8VqJ8ehA2h98Mj8jQtaQpBiYP/dBiUQvgSfEJZSn9OXmNd493UWUsW1hfq+J7uDN
	xuddNXVAky5AxodCgcua4cNn4=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDXP+oOVKFpNzWPNg--.30755S2;
	Fri, 27 Feb 2026 16:21:35 +0800 (CST)
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
Subject: [PATCH v8 bpf-next 0/2] Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
Date: Fri, 27 Feb 2026 16:21:31 +0800
Message-Id: <20260227082133.96951-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXP+oOVKFpNzWPNg--.30755S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFy3AFWkGr1rJFWDCrWxZwb_yoW8Xr1fpF
	WUXrZ5Ww4rtw17tFs3Ga13ZFyFga1rJw1Fgw1xAw1YyF4UZryUJw1I9w4YgFnIqrZruw48
	Z3ZYqF17Ka4jva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRFoGQUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC0BDbVGmhVBAP+gAA32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261766-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangfeng59949@163.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1B7F21B47E8
X-Rspamd-Action: no action

From: Feng Yang <yangfeng@kylinos.cn>

Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap

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

 net/bpf/test_run.c                            | 13 ++++++++++++
 .../selftests/bpf/progs/verifier_lwt.c        | 20 +++++++++++++++++++
 2 files changed, 33 insertions(+)

-- 
2.43.0


