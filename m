Return-Path: <netdev+bounces-263061-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMTOBjuSpmnxRAAAu9opvQ
	(envelope-from <netdev+bounces-263061-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 08:48:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8731EA59F
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 08:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6712030C0FEB
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 07:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975E9337BA3;
	Tue,  3 Mar 2026 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fTDaUN37"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E782D8393;
	Tue,  3 Mar 2026 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772523929; cv=none; b=PZKqX2a3yp6UBSI5TV6DFsgH22TUugmNIpC1nGdBDjVPvoGDaJeTYzJhTJwQkFgiGpU5mlwt1eUpgVajqtrCGKtK13ujh7++vRJmvK+34GyMVjN2bX5bLljBPMc8c3TLQdu+SIVxnFU3v2s3TUc4212xne/Xd2CVmamfqbIbyJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772523929; c=relaxed/simple;
	bh=LDZ94JtoHMM1UEYU5Q90klCQ7sVAFPEQpBpyLjSIKFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ri43N5Q53fT5mEwMbCQb/9nLCDLeX4LuP1iFNNBgm+hHZDWveNFLH2XtX8elZqaVCtpjERJljvaABKKe/J0EYPxqGglzTdqTbPbUp//6WOnMdhlPTGRobcaqijLmV1LxQKeE6H3nEMcrAXEI8PhUAV0Dn33Cnd51uYOU3kk+ZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fTDaUN37; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4e
	RwFhUgku6857Z68xn0kodvZ/XzFvUeVFNaJo7REB4=; b=fTDaUN37j7LQblpzhQ
	DbPHjErirghu2RARK1IMFY/2gwP6hORlyqk715+iS8srriwnvY3rOV6WTq9bvhT7
	HVjCiKIpaonK5dssYzDa+C1GwzOgn+q8g/GFeMgZBnijxDNspue4cWTerH7A1QAK
	HcZbdUhEQ5p3SzmXmv4VZ+740=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAXXjhXkaZpm2IBPA--.46718S4;
	Tue, 03 Mar 2026 15:44:28 +0800 (CST)
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
Subject: [PATCH v9 bpf-next 2/2] selftests/bpf: Add selftests for the invocation of bpf_lwt_xmit_push_encap
Date: Tue,  3 Mar 2026 15:44:23 +0800
Message-Id: <20260303074423.172680-3-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260303074423.172680-1-yangfeng59949@163.com>
References: <20260303074423.172680-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXXjhXkaZpm2IBPA--.46718S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF4kCFWxXF4rArW3Wr48JFb_yoWkWrg_tr
	sYga4kCrWxGFnIyayjkr1UCryakwsxWr9rJFsrJr1kCw4UX3Z8GFs7Gr1DJas2g3y3Kr9x
	Aa909F1Iyr42qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRA73vDUUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC0Bx-92mmkVxs5QAA3P
X-Rspamd-Queue-Id: 9C8731EA59F
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
	TAGGED_FROM(0.00)[bounces-263061-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Feng Yang <yangfeng@kylinos.cn>

Calling bpf_lwt_xmit_push_encap will not cause a crash when dst is missing.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 .../selftests/bpf/progs/verifier_lwt.c        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_lwt.c b/tools/testing/selftests/bpf/progs/verifier_lwt.c
index 5ab746307309..9cef07e6eceb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_lwt.c
+++ b/tools/testing/selftests/bpf/progs/verifier_lwt.c
@@ -231,4 +231,24 @@ __naked void not_permitted_for_lwt_prog(void)
 	: __clobber_all);
 }
 
+SEC("lwt_xmit")
+__description("missing dst when calling bpf_lwt_xmit_push_encap")
+__success __retval(0)
+__naked void missing_dst_call_bpf_lwt_xmit_push_encap(void)
+{
+	asm volatile ("					\
+	r9 = 69;					\
+	r3 = r10;					\
+	r3 += -32;					\
+	*(u64 *)(r3 + 0) = r9;				\
+	r2 = 2;						\
+	r4 = 20;					\
+	call %[bpf_lwt_push_encap];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_lwt_push_encap)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


