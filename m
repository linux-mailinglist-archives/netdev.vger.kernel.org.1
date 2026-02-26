Return-Path: <netdev+bounces-261266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJokD+AZoGmzfgQAu9opvQ
	(envelope-from <netdev+bounces-261266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:01:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1632F1A3E2E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 058C8313FE7A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F603A0B19;
	Thu, 26 Feb 2026 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="l1o3uSn4"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC4D3A0B21;
	Thu, 26 Feb 2026 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099602; cv=none; b=JLCe5MmyA65Shj5J0SOTis2pyRWccPzfdviY1VB5owDnZgp1C4MxUM0T6kd7PZ0ER7UOUgGB+gedPEt+XDQ/5LlSNal/6Vcmblbt1MFK/7c36KjqUOwREZBqxElmkMVSBCHmT1kidpZWwNWKOORLqu4J/pE0pSWi5/CPRww8dt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099602; c=relaxed/simple;
	bh=eDjgoQckfBk/1LqsvZlpMrdjYiSff2kJicrYxPnu+Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qX7GPDoRYQsYRUrvRPu59x+/r+yRd/oeWKNTh+E812JW3KQ4PzWrf5VJyNJntgSn9byY+q2KOen0v3Utnc/oNKUaiJvYztZGgJ5hDCeEMI+zXeg9cw4XcMPdrn8459w+DDWdHXelf7oHh1Pz+KPvY0zPK0tuQT+K2qH/FHQlofM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=l1o3uSn4; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nj
	pI2OhELvS/FVob2kMirqE/3cNZpdVyGbqW92Wuwjg=; b=l1o3uSn4nb5Hdc4dzQ
	tkX5yAJEIg2dhigeSEQPQwbxKVY/up+waz45n78Wg+lXd+G//Hbz1AxqYHNbk291
	Z3Dq/ZwKknZkQjgycxnjB2wTpts2I5qS9z8RV5jOUtG+jGHpKnxOa2N1Hf6P5b/P
	YxdLM6SM2+if7FZm4lSNg4OcU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDHcY68F6Bpat7wMg--.59449S4;
	Thu, 26 Feb 2026 17:51:59 +0800 (CST)
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
Subject: [PATCH v7 bpf-next 2/2] selftests/bpf: Add selftests for the invocation of bpf_lwt_xmit_push_encap
Date: Thu, 26 Feb 2026 17:51:56 +0800
Message-Id: <20260226095156.117996-3-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260226095156.117996-1-yangfeng59949@163.com>
References: <20260226095156.117996-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHcY68F6Bpat7wMg--.59449S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF4kCFWxXF4rWw13ur43GFg_yoWkXFc_tr
	sYga4kCrWxGFsIyayjkryUuryak39xWrZrGFZrJrn7C3yUX3Z8GFs7Gr1DJas2ga1fKr9x
	Za909FyIyr42qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRCrWFDUUUUU==
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8R9372mgF78GtAAA3l
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261266-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1632F1A3E2E
X-Rspamd-Action: no action

From: Feng Yang <yangfeng@kylinos.cn>

Calling bpf_lwt_xmit_push_encap will not cause a crash when dst is missing.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 .../selftests/bpf/progs/verifier_lwt.c        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_lwt.c b/tools/testing/selftests/bpf/progs/verifier_lwt.c
index 5ab746307309..a2b45e3e1542 100644
--- a/tools/testing/selftests/bpf/progs/verifier_lwt.c
+++ b/tools/testing/selftests/bpf/progs/verifier_lwt.c
@@ -231,4 +231,23 @@ __naked void not_permitted_for_lwt_prog(void)
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
+	exit;						\
+"	:
+	: __imm(bpf_lwt_push_encap)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


