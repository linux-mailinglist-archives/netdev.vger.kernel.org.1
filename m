Return-Path: <netdev+bounces-216651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 345A5B34C31
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DCE37B5E03
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7359F29AAFD;
	Mon, 25 Aug 2025 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xnmBf/xw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EF7299923
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154527; cv=none; b=Ltw4rfa9afzJdDAPR2E0njm/3s2Hjex0RiDmiOUkQkkGw31OlZblW9cN9c2adI1QCj5WNrG+C6oBKztzS6WZOfZMFVeCx8sVT36ILQ3oTAuPqgJ3e9QdFfDTY3ZMT2lM7dRVyMY8RNvZWKks9rAHcoGGzBiyD6ubwRW8K4gOnV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154527; c=relaxed/simple;
	bh=4rXmMRFD64XHpP5U2HG6+KlmRMHsrl66jIkUtOubPRk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aISVJB0SWOqwBOweRRM0Jyf7M/wT9Kajp0id1IbbxLn+upzzT/lHQ+9YJ/ODwCv/lZhzy7nQFTvYCtMWd9U60zQ9GdzAQm55gNIc5BSF6He9kDtY0Nx8qB/lOIjVrAPO7g+EPpT2O6CiRIPtd3c1XEpHhJUB8Gfk07nIvq48kM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xnmBf/xw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445805d386so55154915ad.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756154525; x=1756759325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1iEMvNSSHEK3UBfywaJhFVsUiqhT5a2Kaw2G5DT8bE=;
        b=xnmBf/xw0aLcD+TsSfHGazl0w6oFJbU0oXksm2Rz6Zumbqd0CWDot/BUd2hx0cP+ye
         y6eAozsK0MWnuV2nbkKHHWREtJ4ZGJcr47aDPLFRuaYTDovGW8Ry7xgUiqlEVrSkkc6Y
         092dqADTWHpQE7EjBPu3d8RA4x9TjZAH4xaDlVu7q+ddxPEaePKJzPub81T/LWmPiz/i
         eE6GJQ2+gQECeKwwlLqBd0Wqgx5tDdOrpw1gySiiCpVVB0Ll6baaDpW5ONwKL65643tV
         +9aA6CXSvK8BU5lP3FTJusrKvKNkZoA05huayD2tI5xrJJtLSZItGW0aYR8CAuOXRONw
         2OIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756154525; x=1756759325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1iEMvNSSHEK3UBfywaJhFVsUiqhT5a2Kaw2G5DT8bE=;
        b=T9QviYuI8BSwr2o545af8fSqd4ROSOFVJRiA975LAPx8BxxmThlnMXDfQYR7Md5Oio
         UZugfq6NpgMv7vAtVWOXcyaQ9R8oIVwyaRhi8LSxK5x+MAb/41c00fMZ78ZjNYLO5LSV
         akn4/msF3+uy+7d+Pn5qGvOQLfIokyZe6ouljmib/vbjRwbpAg5JL8BQ7FTuYjH8Qm4b
         Tl+FWFnDr4xRCWj1LjPbyv9wNbxGJp1h9xx5C2ladKMqKGdGnuHRi4uhj00iOim/YaVn
         rK4Cdtb35IPJoxie8dIjeZQOBG638VsTveh4zWcF5JNPqLHMNPEbU96FCk/VpQXOspWn
         IQsA==
X-Forwarded-Encrypted: i=1; AJvYcCUVUW0qDyPlr0/qfVb10HCEB2jeifp922MPbQeVqJgWTfM7yLfly+cx8LDcvXEcBIrRD7dhdns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWxOxRYhEfIch6Gx8iNwgHrVy/p47/zUPORq1PiJwdBmhcHyxl
	G2S23JWTT6UMKAmQDq1TP0Yg0DnAIEFGdV4T+uOpFhsk8s+m+lSTY1l/VuCWTA1g/dEuxyMSpSj
	KKTtluA==
X-Google-Smtp-Source: AGHT+IEEx5IvnJax79C6l0WqmcNrk0h1qJqQQotsVTVYudQ+lM8kKGwGvQUv5XZ3YaB7jHef6d1SHrw8UK4=
X-Received: from plbv20.prod.google.com ([2002:a17:903:44d4:b0:234:bca4:b7b3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32ce:b0:246:d385:233a
 with SMTP id d9443c01a7336-246d3852679mr52943455ad.25.1756154525223; Mon, 25
 Aug 2025 13:42:05 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:41:26 +0000
In-Reply-To: <20250825204158.2414402-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825204158.2414402-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825204158.2414402-4-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 3/8] libbpf: Support BPF_CGROUP_INET_SOCK_ACCEPT.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Let's support the new attach_type for cgroup prog to
hook in __inet_accept().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8f5a81b672e1..c1b28a3e6d6f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -81,6 +81,7 @@ static const char * const attach_type_name[] = {
 	[BPF_CGROUP_INET_INGRESS]	= "cgroup_inet_ingress",
 	[BPF_CGROUP_INET_EGRESS]	= "cgroup_inet_egress",
 	[BPF_CGROUP_INET_SOCK_CREATE]	= "cgroup_inet_sock_create",
+	[BPF_CGROUP_INET_SOCK_ACCEPT]	= "cgroup_inet_sock_accept",
 	[BPF_CGROUP_INET_SOCK_RELEASE]	= "cgroup_inet_sock_release",
 	[BPF_CGROUP_SOCK_OPS]		= "cgroup_sock_ops",
 	[BPF_CGROUP_DEVICE]		= "cgroup_device",
@@ -9584,6 +9585,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("cgroup_skb/egress",	CGROUP_SKB, BPF_CGROUP_INET_EGRESS, SEC_ATTACHABLE_OPT),
 	SEC_DEF("cgroup/skb",		CGROUP_SKB, 0, SEC_NONE),
 	SEC_DEF("cgroup/sock_create",	CGROUP_SOCK, BPF_CGROUP_INET_SOCK_CREATE, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/sock_accept",	CGROUP_SOCK, BPF_CGROUP_INET_SOCK_ACCEPT, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/sock_release",	CGROUP_SOCK, BPF_CGROUP_INET_SOCK_RELEASE, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/sock",		CGROUP_SOCK, BPF_CGROUP_INET_SOCK_CREATE, SEC_ATTACHABLE_OPT),
 	SEC_DEF("cgroup/post_bind4",	CGROUP_SOCK, BPF_CGROUP_INET4_POST_BIND, SEC_ATTACHABLE),
-- 
2.51.0.261.g7ce5a0a67e-goog


