Return-Path: <netdev+bounces-280585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBwwM9+T6WkreAIAu9opvQ
	(envelope-from <netdev+bounces-280585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 05:37:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7304144C8B7
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 05:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3D7630067B1
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 03:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CB73CBE66;
	Thu, 23 Apr 2026 03:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DM0wNMUM"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFD53C3436
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 03:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776915419; cv=none; b=SlJOen6rTrz+w+hYGnOlquL4TPiyYH+vdZ66CyJDiR+TYIpXYfeVNLVz/Np67h3vqjPuI874iiiTGzpsnG3fKwZ1Elh8eZDzqwyEbJjSx2TicrpZOdCCwqRb1HvxVLjswk8X0a4qvBnLdyouvmdeNOknc72TQzqZKJFCvJg9vJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776915419; c=relaxed/simple;
	bh=iWODNI82mMhKf0rzooGjoeuD1PXmFMHx7nO+rUJOp+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeNKT0GSt/SXEVEYyXrPj5loATzurpYR6/WpyTIlWFqov1ey1fcR6PS3zU42hojUJxKuFxtDzLTQd9Y2GtPX6rayYNn1dfXDwlHAaxynmiIeSjIml4t6dV7NGBHq6DsZJmfghUwZlj/ytFv9GuYt/YAEnFHofj1O6UxpqmHzp3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DM0wNMUM; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776915415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RHL4dh/eT/KWU2zVMuDgHmZpWw8uwLt0ejeEgsGg/C8=;
	b=DM0wNMUMHA/IhbSAgX6/VFRfkqDfHDlM8e+HxgnNQmZ7YWOHQTnL/W44pUqnhMwRU9QeYa
	lBMLtLAlKI2etRaBMiItGIoNDk/s4fhZI1H/FFWphyKy1u/K8lqtYnC23XWaVoCZILE0iU
	aXmJop297HhTmueK28EK8kQSbYjL0ro=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf, tcx: reject offloaded programs on attach
Date: Thu, 23 Apr 2026 11:36:05 +0800
Message-ID: <20260423033609.252464-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260423033609.252464-1-jiayuan.chen@linux.dev>
References: <20260423033609.252464-1-jiayuan.chen@linux.dev>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280585-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,hust.edu.cn,iogearbox.net,blackwall.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,fomichev.me,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7304144C8B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

An offloaded prog's bpf_func is replaced by bpf_prog_warn_on_exec(),
since it's supposed to run on the NIC, not the host. But tcx doesn't
check this and happily attaches it to the software path, so the first
packet hits the WARN.

XDP already guards this in dev_xdp_attach(); tcx just never got the
same check. Add it to both tcx_prog_attach() and tcx_link_attach().

Use bpf_prog_is_offloaded() instead of bpf_prog_is_dev_bound() so that
dev-bound-only programs (still JITed for host) keep working.

Fixes: e420bed025071 ("bpf: Add fd-based tcx multi-prog infra with link support")
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/64d8e2b5-a214-4f3c-b9e8-bcedbcb2c602@hust.edu.cn/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/tcx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
index 02db0113b8e7c..86f4636d5a677 100644
--- a/kernel/bpf/tcx.c
+++ b/kernel/bpf/tcx.c
@@ -16,6 +16,9 @@ int tcx_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	struct net_device *dev;
 	int ret;
 
+	if (bpf_prog_is_offloaded(prog->aux))
+		return -EINVAL;
+
 	rtnl_lock();
 	dev = __dev_get_by_index(net, attr->target_ifindex);
 	if (!dev) {
@@ -315,6 +318,9 @@ int tcx_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	struct tcx_link *tcx;
 	int ret;
 
+	if (bpf_prog_is_offloaded(prog->aux))
+		return -EINVAL;
+
 	rtnl_lock();
 	dev = __dev_get_by_index(net, attr->link_create.target_ifindex);
 	if (!dev) {
-- 
2.43.0


