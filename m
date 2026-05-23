Return-Path: <netdev+bounces-291062-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J8VG2tmEWoelgYAu9opvQ
	(envelope-from <netdev+bounces-291062-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:33:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9175BDF09
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFEC33040961
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FBF35676B;
	Sat, 23 May 2026 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2pWUlh3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C829E35A3A4
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525017; cv=none; b=uzSWu6jPAv9fn+sRqEkcHWMx8qvBbYBkiaxOHrSKZcHfqMp9py/TAVLsWl/egq4TFd/CZ0LyNvUhLnsylUOngMNltSxWpCR9eT/V6zVCD4bknZil0pAZn4e1Nfa5uPu9yGh+ErNv56Yur0y3KfMoj1X1OFrC1EEGKyCqz4MToTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525017; c=relaxed/simple;
	bh=ZP/yjWLcyFfoXbQ0mJcb3h6qRhbU/40iNjGIRkuIu8s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HhP8xrNDmttiyljEpicPW3rBsQv2zlQKeMTj/VfzTTQcOOox3dkEoTRPx/o3vYi544kAtEC/5B016QB12osIfh2d6ChfkjddUHVgZUfK+qED9HLNKnsk3UmuC6lBIx40a5DT6LP1nYVao6lwsXGU/HdWg1E0SV+lzN6EzppPiFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a2pWUlh3; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba5f794825so62980355ad.0
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779525010; x=1780129810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KdKvW6OTT1gS2YCnhs238bIchf/eYZIj5lDxHn+nM0Q=;
        b=a2pWUlh3afwNwYFewJfamuXu/PoIiH051jgNMUi28DQ43MrBPr8/FEIvqMyFhRA/ed
         QQG12aoGAmKzchLzqMgNzWHAi79g8XAOy9NdeevldfHFHujw5h3qgC1t5j3fqbX8NjP7
         10q/nAjLD++hhCOIIB1PzVyTAiR0onsBugCJQDCfZeXt5AkQDZHKLs4/2L0u7ofuUtIj
         8UC8nHc2/C76zSiXDRPxQOWQ2r+FLIyF1akI2uELGlBDnavu9lrtKptxffBAN1puEw7t
         F4IQ9GnSzMYcHW0Kr3GmGu583jwiCNrBibwmjnkeu7j7RC+H+U5V76h7moiaT20LiN3i
         Vxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525010; x=1780129810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdKvW6OTT1gS2YCnhs238bIchf/eYZIj5lDxHn+nM0Q=;
        b=S1PowjKpQ/NMQFIA9ePu+kV0Sh3+FBLZvhR9Trxry3LV1AlzF27AWoQPk9lvgNgrkL
         NheWesm43a82T7afw02cvACmkRgBJfzcCpgqjIiuVZsViOOJyfoN7sFJycZRNgrQalaO
         1bCKj7+etIuAItS0mITc7WK0KPhHIDrSN4p9db36M8/pkF42LJLVrh4He5LCiqGpeUb5
         o6djZnHsDu5H2jIF8VmaGgqAYM/4gMKT3/ekpKkMcB8OUzvGxDbeO6Qu+3StC/nrWJOg
         VOs1H8NN+maG05f5MCLODkz0cN8g9fCiqt5AanYHdZRe+wcrbOCOyT5g+R+pL2XT1tl4
         WBFQ==
X-Forwarded-Encrypted: i=1; AFNElJ/V/vhSoyF5KnIvYK/0wpCrAiED4RKPAVbUds/Z1rI1O3GE8QgpecVJEAGANS0bHiRtCgHXIsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8FzHuqWdfzImFLVbt0/ngyWg+JhAInhlYVlDr7Fs7IQY7l3VK
	ahr1dZsZSCDVHp7LKTRQiw/C2bsCaSAvo5MiCluDcF293EqPElWQD/tvXYUtu3zYwFLY0T068vS
	iXTJPnA==
X-Received: from plbmj8.prod.google.com ([2002:a17:903:2b88:b0:2bd:4ef9:f6a4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce88:b0:2bd:a3c5:6d96
 with SMTP id d9443c01a7336-2beb0756707mr72213045ad.14.1779525009896; Sat, 23
 May 2026 01:30:09 -0700 (PDT)
Date: Sat, 23 May 2026 08:29:36 +0000
In-Reply-To: <20260523083001.2911931-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523083001.2911931-8-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 07/11] bpf: mptcp: Don't support BPF_SOCK_OPS_RCVQ_CB.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291062-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.822];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0D9175BDF09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MPTCP has its own sock->ops->set_rcvlowat() / mptcp_set_rcvlowat().

We should not allow calling __tcp_set_rcvlowat() for MPTCP subflows.

Let's disable BPF_SOCK_OPS_RCVQ_CB for MPTCP for now.

If needed in the future, bpf_sock_ops_tcp_set_rcvlowat() could be
extended to properly support MPTCP.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 1fb63b264b18..82ec2291d6f0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5390,6 +5390,9 @@ static int __bpf_sock_ops_cb_flags_set(struct sock *sk, int val)
 		return 0;
 	}
 
+	if (unlikely(sk_is_mptcp(sk)))
+		return -EOPNOTSUPP;
+
 	write_lock_bh(&sk->sk_callback_lock);
 
 	if (unlikely(tcp_in_sockmap(sk))) {
-- 
2.54.0.746.g67dd491aae-goog


