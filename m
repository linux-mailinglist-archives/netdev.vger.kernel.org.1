Return-Path: <netdev+bounces-280979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFt3BHBJ62mWKgAAu9opvQ
	(envelope-from <netdev+bounces-280979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 12:44:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A7945D4D3
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 12:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFEC0302A7CF
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 10:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06BA38BF81;
	Fri, 24 Apr 2026 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TJ2F6pv8"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0131D5AD4
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027364; cv=none; b=RU8CUOIDt2eNn4uUDtqkMkCxGBSTpnOiDqxM4wRfjhVDuH+7oFIQLNIOauoI8WprCHeVvutme9C7EvOG8EzRvR0KQBRj458nZefpC/JysVqu7AmD1s4DIJJ1gw935e+9XJ8qqbRH2h9U5rvPE6IKK3vb3qW75f31egyVtaah6ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027364; c=relaxed/simple;
	bh=wpabQn1ol/qItAAjOBPAvpNVjKrZhE/WdQTRvEr4a78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAcNzK7/K2dBQhzs0O73WFL4FoddnlD86+upPip8Mjr/u+y0hJYcDwDvYwVJNNO/VpIJ89ZRwHoksuUdUrIwA0vodfGcKqPIJQhcs683C6oUIJz55sA3dEQjP3Xw1wxRDcalLgO5lP3o493XLskX1yQwSuntYchLf3atj7F2n5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TJ2F6pv8; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777027361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jk7ozpk8BJdqj1K1xG4zup/ZZJh6Q5ZPNMKI0G/5YVU=;
	b=TJ2F6pv8tfnL3d8biVvAVVopk33/6mK7bR+gtjdDvF0cBiNmG9u+ahJPTZn934Ig7jbqWE
	An/JgFz9B4Mq6XI99mwkUdJs2KxvH9f17sMaz2lni0DvKZxZDnnyJoMq0gzvlePjsmVim1
	TdVkc0i7rlyroI+gnDdGNGddffpa/TY=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
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
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 2/3] bpf, netkit: reject offloaded programs on attach
Date: Fri, 24 Apr 2026 18:41:41 +0800
Message-ID: <20260424104201.217604-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260424104201.217604-1-jiayuan.chen@linux.dev>
References: <20260424104201.217604-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: C0A7945D4D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,blackwall.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,fomichev.me,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-280979-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]

Same issue as the tcx fix: netkit accepts SCHED_CLS programs but never
checks if they were loaded for hardware offload. If someone loads a
program with prog_ifindex pointing to an offload-capable device and then
attaches it to a netkit peer, the bpf_func is bpf_prog_warn_on_exec()
and the first packet triggers the WARN.

Reject offloaded programs in netkit_prog_attach(), netkit_link_attach()
and netkit_link_update().

Fixes: 35dfaad7188cd ("netkit, bpf: Add bpf programmable net device")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 drivers/net/netkit.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 5c0e01396e064..dae4d7b24d80e 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -533,6 +533,9 @@ int netkit_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	struct net_device *dev;
 	int ret;
 
+	if (bpf_prog_is_offloaded(prog->aux))
+		return -EINVAL;
+
 	rtnl_lock();
 	dev = netkit_dev_fetch(current->nsproxy->net_ns, attr->target_ifindex,
 			       attr->attach_type);
@@ -683,6 +686,9 @@ static int netkit_link_update(struct bpf_link *link, struct bpf_prog *nprog,
 	struct net_device *dev;
 	int ret = 0;
 
+	if (bpf_prog_is_offloaded(nprog->aux))
+		return -EINVAL;
+
 	rtnl_lock();
 	dev = nkl->dev;
 	if (!dev) {
@@ -788,6 +794,9 @@ int netkit_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	struct net_device *dev;
 	int ret;
 
+	if (bpf_prog_is_offloaded(prog->aux))
+		return -EINVAL;
+
 	rtnl_lock();
 	dev = netkit_dev_fetch(current->nsproxy->net_ns,
 			       attr->link_create.target_ifindex,
-- 
2.43.0


