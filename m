Return-Path: <netdev+bounces-271119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJOvEKmqwmkyggQAu9opvQ
	(envelope-from <netdev+bounces-271119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:15:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7E2317D5C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2718A31549D9
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F26402BB9;
	Tue, 24 Mar 2026 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R7QRd39k"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23DB4035DB
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364736; cv=none; b=IL1FCSkKjRRIfDw6iPIrw4jTdLOO7Tl+R7u/P5lZW921c7EciBnJPUfE4VPsH8rhEV0XS9mNfmxCyespH4PtRphtzptHuZq2+VwXhENFeZU5veNY/jEoWATvzrXbjFrEZQjNNfZRzDrPqNFc4SWOqmOygjzinbvzS2fEq4QCcXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364736; c=relaxed/simple;
	bh=1OUXSxliGxs2W5u+A/o5NRDqjqs0xKl/4cLd/mJKN9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tr+1tSmSTiDa0SpJnsqZmvZErUlxellH/XfklQW0fRPVqg6FxHtne0hs9EV2d0v/I33XotRiE4quxiFB/Vk/n9qE/qfaGeUcVmkDhXe8NXVfUJsByKns8NngJOmDJyIckFnaJeUke9VJSs6fURgQdr7YsEtvbCnnvyYgavUZaOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R7QRd39k; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774364731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8OYL681E9dxdDA5qL/B2G4Dr49rI/KGwvFW7ZoQDW0=;
	b=R7QRd39kfR8Cv3zgj1iUp2UQOeZb12NKDSqi5aodhoPat9lZEW1gtIRV4Qk5VEVGufz5u8
	OouFM4dVUfzcO2aNerjBz3NT7r5gqcSuOPP+Bj8C4w64YhBx9Jn9wGR8bgIVwuLfe8XE0Z
	QSgqDuAb+UNXZEy/MBY+4j0ZOfkW1yw=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 1/3] bpf: Disallow freplace on XDP with mismatched xdp_has_frags values
Date: Tue, 24 Mar 2026 23:04:42 +0800
Message-ID: <20260324150444.68166-2-leon.hwang@linux.dev>
In-Reply-To: <20260324150444.68166-1-leon.hwang@linux.dev>
References: <20260324150444.68166-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-271119-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: DF7E2317D5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xdp_has_frags was introduced by the commit
c2f2cdbeffda ("bpf: introduce BPF_F_XDP_HAS_FRAGS flag in prog_flags loading the ebpf program").

The commit f45d5b6ce2e8 ("bpf: generalise tail call map compatibility check")
was to ensure backwards compatibility against tail calls. However, it
missed that XDP progs can be extended by freplace progs, which could break
the backwards compatibility, e.g. xdp_has_frags=true freplace progs are
allowed to attach to xdp_has_frags=false XDP progs.

To avoid breaking the backwards compatibility via freplace, disallow
freplace on XDP programs with different xdp_has_frags values.

Cc: Toke Hoiland-Jorgensen <toke@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Fixes: c2f2cdbeffda ("bpf: introduce BPF_F_XDP_HAS_FRAGS flag in prog_flags loading the ebpf program")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cd008b146ee5..12330466d58b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25519,6 +25519,10 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		 */
 		env->ops = bpf_verifier_ops[tgt_prog->type];
 		prog->expected_attach_type = tgt_prog->expected_attach_type;
+		if (prog->aux->xdp_has_frags != tgt_prog->aux->xdp_has_frags) {
+			verbose(env, "Extension program cannot have different xdp_has_frags value with target prog\n");
+			return -EINVAL;
+		}
 	}
 
 	/* store info about the attachment target that will be used later */
-- 
2.53.0


