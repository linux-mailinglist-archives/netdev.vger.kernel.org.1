Return-Path: <netdev+bounces-272937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJrQDttQyWnrxQUAu9opvQ
	(envelope-from <netdev+bounces-272937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:18:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9421A352D66
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AB87301547A
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40C637DE9C;
	Sun, 29 Mar 2026 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt1CAXSE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6674D18EB0
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801092; cv=none; b=umvYyo6x2CD+wnmKmANKMmIGUrLOD7avjtrL/Hbgf5NpE+1bq3js6wHRita6EIESClfvuls14zkg0tTNDDY11Z6qhGBIV+PJpHquDWsO6fuxpfAY2uV2kckBWb+ei1sZiROLZ95wndQnA88YnApg1Il4MUXA5o6w1/GNxGmIZbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801092; c=relaxed/simple;
	bh=vA7FGZ4QgImw8H7FwAwRGPAFqoafQa4yOe2ds6Od3rU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TmQjjGxPWJ6H7V1/PXRndh1E9+4sf4TdRpPIK0YP2HB5N0Nrufnwq9csxawJJ+x2yRHjlpx1Z06JhJ47sRJwScfJyaOYGUS07rE9bSCY1iI6+dViz3D2eMXY+fzQMMXhXiD8NzdBP4fUNMU77IiJF0xZJIZxO3QjOvERkfxo+gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt1CAXSE; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64edf260b49so6367725d50.0
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774801089; x=1775405889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a83TUsskxy1VkF8Vg9eln+jbw7jfWEDWtbMcqUkZ9fM=;
        b=gt1CAXSEcqSMUTCq4NvcKCfGmVvMF3qN1b9CQoHH28GLay64l9eB6scxUgJIjsMCFU
         kBLwWUQF1ebkikqZ1+XW8T/prpRtQx5bqth0JE7X8ZFqF9gMuOnRJnQlH3weUw8vyayM
         ntvBru3B6TP7TxC5p9AxCNP8g+/xFuDVOa9DBc3EFR5NSE0mWaQSUUwJogPnC3peNgsQ
         y8eo3zFUtc+54yEquulqa9MYjxhS188WvPaEhmL5kZ+/tFPJ2dKEeus0rtUGxH20ETAw
         A38ny0uIQURiZzQzvqnrwzg9zd4ZpQ1aSA42X6YHbsnAxaJ9J1mKclU79JqBz91kjhoF
         Q98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774801089; x=1775405889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a83TUsskxy1VkF8Vg9eln+jbw7jfWEDWtbMcqUkZ9fM=;
        b=WlVZPfrrLravDEB+vQtaNE61e64A8UqwwKyWRorsl1xUTmEEHIuwdJRMDrVpIOsJPq
         VOU214wArpg0QXG7RvhXymQs/bitK+tBhL6rYkdGWMxpCSgwAU/J45p1h3lCJDmDpC9m
         kbtMepsmYc0pHPhx2BfZ61u3mUbpSRPKby+qfrTeU0IVMANd7gJrD8PVmP3AXmhOp0tD
         uiYl5AYzWwfEHl9rG6NotGLo0eZIKUlJxKQCtTUFl13k9bj9JXdcAoOEqZfjsvlw2MTe
         vipba2TmAuUd8HewJsJ8aZej++frYhWVA67fodgo6sxcbI/S/Gw4Gvp4SYeY8LQDy8mY
         qOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX8xRLMY4ClTxeQ+WLLFFvkjh/R5BVXgKHeJg+R0Y1fHhIemkMcdI3IXSz3jNmOhtAX8c1HUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4T0F2GfIAFbIoNI+EJAbqEBJ9JkijRFNB5bLnmBZF2ImOZcL5
	Gqh7Orc737AcAAPiZ/6Wpxc1ihKjd7qaxAe90s4bYn6QZt/RPBUeCznW
X-Gm-Gg: ATEYQzyHSVW3sw4iYzLcD8jvBNGphpTnSx6AJYhszWkoA/NbF0JpIHHxpu+HMkw2Lj+
	ZysBC7Jp3P62mj0jlaVNyPy9xONQ5CZY0//DNBpnIJOU5ekfcjqa4y63WhQimiaifJv52h8KHN0
	LJXm5wBq1h4zCljxPmk5oxc4vdbcxwly+y1aL/mf5NyaZTC+x2ISuORWUFb2aF67Fa3/eKQ2G0o
	yAF4F65fEYDOovxKR63DE2Y8RDylcvzhX8eePHybCK8PyReML/pcEXiTHmAUXcKppvCx65ieq8W
	6EBkNSeLYO+gswMy3+THbRKMxIMxXZ0eYe+yzaplEarWx47ZK+lcWD/v4S01MIZqHSpdxhRtxDX
	58UwYBJ2gmsRsqyYQFekk5wH3avsp35nCTdlvkHdY/ZcPmtVy24iVUxrDFJ1HnSCCJWX9JBtfi1
	mAWnaxAEXyLfRPgD/qMCCOzCWNoGmz1qj74s+jfsicLBf2CGzZHf4FyRRgugY0fxEjE4sopPldH
	lo/+/q6uMMIAIEjME46kU8dwM5Il6u0tUWxs8MNkoBUM5Om0No6Xh3Sr3ckJxpT6EQ=
X-Received: by 2002:a05:690e:4092:b0:64e:e833:337a with SMTP id 956f58d0204a3-64fee1b61a5mr10432402d50.2.1774801089372;
        Sun, 29 Mar 2026 09:18:09 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6500936f692sm2638216d50.19.2026.03.29.09.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:18:09 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>,
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Subject: [PATCH v2] selftests/bpf: Reject malformed IPv4/IPv6 skb test input
Date: Mon, 30 Mar 2026 00:17:51 +0800
Message-ID: <20260329161751.1914272-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272937-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,619b9ef527f510a57cfc];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 9421A352D66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bpf_prog_test_run_skb() derives skb->protocol from the Ethernet header
through eth_type_trans(), but it does not verify that the provided
linear input is long enough to contain the corresponding L3 base header.

This can result in an inconsistent skb being passed to test_run helpers
such as bpf_skb_adjust_room(), where inferred protocol offsets can lead
to operating on uninitialized memory, triggering KMSAN errors.

To reject such malformed test input, we check that the linear head is
sufficiently large to contain the corresponding L3 base header (IPv4
or IPv6) before running the program.

Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=619b9ef527f510a57cfc
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
v2:
 - Ensured that the linear head is large enough to accommodate the corresponding L3 base header (IPv4 or IPv6), before running the program.

Link: <https://lore.kernel.org/bpf/129d235b04aca276c0a57c7c3646ce48644458cdc85d9b92b25f405e2d58a9ae@mail.kernel.org/>

 net/bpf/test_run.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 178c4738e63b..4790bee535b9 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1118,6 +1118,25 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	skb->protocol = eth_type_trans(skb, dev);
 	skb_reset_network_header(skb);
 
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		if (skb_headlen(skb) < sizeof(struct iphdr)) {
+			ret = -EINVAL;
+			goto out;
+		}
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case htons(ETH_P_IPV6):
+		if (skb_headlen(skb) < sizeof(struct ipv6hdr)) {
+			ret = -EINVAL;
+			goto out;
+		}
+		break;
+#endif
+	default:
+		break;
+	}
+
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		sk->sk_family = AF_INET;

base-commit: cbfffcca2bf0622b601b7eaf477aa29035169184
-- 
2.43.0


