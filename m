Return-Path: <netdev+bounces-293154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMZlM1W4GWpByggAu9opvQ
	(envelope-from <netdev+bounces-293154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:01:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4406053A3
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08F0B367D5FD
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 15:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E323559F8;
	Fri, 29 May 2026 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VTHlJIA7"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25DD33B6D3
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067693; cv=none; b=lNBvCWyMCStly8srYIrCUX45tYvlmSYHgOz0oJ4gxJFunV6BWi4qxncRfk6q8zXQVm89JgwXPSUAt7SJj2UOl7sC7bFuDKCbe9nCrrKFzN7fnlOtpAYSoAY9ZDXEoLhW5C11gBJAQKrYQmYhQtN7V8PbENOMHuNW+GKrEsxAaMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067693; c=relaxed/simple;
	bh=XSCO5CSVCnzEfuZMtOvLgrM/19YC/n7GmkNMoqE9KlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGYJXMh5jYgyKouK0yyU6JrqZNxTrNKujmGP+GDDYAp62HL+3tHHW/qQkMH4yrQtmMDSbr90QKBhGUI4982ZlciM1uD0iS/R1Qv1tGdvBLjS1TWUQ5zReDqN/S/CvtjLo79QP4hEK9ylACNVdVdFXrV+b/67tnGmiQKrE3iaFSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VTHlJIA7; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780067689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOd4RhJzsfLP0kB2sEsBt46YxR8Ub6JYiYOL9mjFn8M=;
	b=VTHlJIA7y2WLB3S+aHCKwgmOPsRftcpaWhLdgola1SXKsAl8YWC5Pd7e6NtuZ6RjbN72l+
	y0smBbjxQid+H9wDKtT+m+0bkdtOzPD2hlaqUc2ukzPI8645nXAHZiQEF8ia5Fqtz0Logm
	P1baahfKfWKu3ozjRLZosLg2Sfhy4aw=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Ido Schimmel <idosch@nvidia.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Peter Oskolkov <posk@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf v2 1/4] bpf: Fix TOCTOU issue in lwt
Date: Fri, 29 May 2026 23:13:48 +0800
Message-ID: <20260529151351.69911-2-leon.hwang@linux.dev>
In-Reply-To: <20260529151351.69911-1-leon.hwang@linux.dev>
References: <20260529151351.69911-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,nvidia.com,suse.de,vger.kernel.org,fb.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293154-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 0E4406053A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko pointed out [1]:
The hdr pointer passed to bpf_lwt_push_ip_encap() can point to concurrently
mutable memory such as a BPF map value.

So, the memory of hdr pointer can be updated after skb_postpush_rcsum().

To fix it, memcpy() the hdr to a local buffer, which will be used for the
following checks and updates.

[1] https://lore.kernel.org/bpf/20260525150010.CDEBA1F000E9@smtp.kernel.org/

Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 net/core/lwt_bpf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index f71ef82a5f3d..8009e427851f 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -599,6 +599,7 @@ static int handle_gso_encap(struct sk_buff *skb, bool ipv4, int encap_len)
 
 int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 {
+	u8 buff[LWT_BPF_MAX_HEADROOM];
 	struct iphdr *iph;
 	bool ipv4;
 	int err;
@@ -606,8 +607,10 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 	if (unlikely(len < sizeof(struct iphdr) || len > LWT_BPF_MAX_HEADROOM))
 		return -EINVAL;
 
+	memcpy(buff, hdr, len);
+
 	/* validate protocol and length */
-	iph = (struct iphdr *)hdr;
+	iph = (struct iphdr *)buff;
 	if (iph->version == 4) {
 		ipv4 = true;
 		if (unlikely(len < iph->ihl * 4))
@@ -637,7 +640,7 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 	if (ingress)
 		skb_postpush_rcsum(skb, iph, len);
 	skb_reset_network_header(skb);
-	memcpy(skb_network_header(skb), hdr, len);
+	memcpy(skb_network_header(skb), buff, len);
 	bpf_compute_data_pointers(skb);
 	skb_clear_hash(skb);
 
-- 
2.54.0


