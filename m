Return-Path: <netdev+bounces-216158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA7FB324F7
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 00:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2F11BA7FFF
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31982F0688;
	Fri, 22 Aug 2025 22:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4yTXJxh4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C212EAB8C
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755901137; cv=none; b=iJFKNPGmDUbC9qwOMFMkgQJ80yPdCNccsCHQuPus9d1EnDUSMpAa/ZbwUpkzsX/FlgNB7oCXBUAcLHrIU1PfP3G75dPUTsZvwApXHffGMR9+jO49zkxMeXj+yQufIKJZ4k4elmtH9dCQcSFGTR3p2ImzBcIrYdkIVTTUmd74eCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755901137; c=relaxed/simple;
	bh=WRKfdTf+6dx6menaKtk6L+6QVIcFPTAKy1lGHA2eLgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sZ3kzOZC9aZYHU2iY+lC9yOGoY4ZyQGKhXV9auJc0pwzIAfAlJZ8q/Elq1TMEQ5l1fOSSeIELX+zFAunn8KaohU0x6wqcccWAJKSu5fxNA8ESxOKP5wcjlkn+QQMQ749gBkBS48isreFBPqx3IgiYM0eKISxOvGOhxfqIfA8h7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4yTXJxh4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4716fa1e59so2137622a12.0
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 15:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755901135; x=1756505935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jnoE+2KIOrxMmHLE80mPq4ihdeC2ql7TNzCz0bDr1kM=;
        b=4yTXJxh4A/D1uYZmtlFNzn1M26AQKnguhYNPTaaXmgXftoNUX04wamOxD08LnR7WTV
         dPPTjpd2nlfAW7pHnYI7OMPS+7i5YP4yPl1iaMaYPaTmfIsIqhBUnzbhFAK6BoBqtPND
         VhB6stAuwRtiIgoNQExaocqxYlHerkAXLJHF1WJU4VtjI7UMbn682PHLap/jqAR7B8+f
         jdf2i+UfzUCGENHnUWjJ0xXReGmBazSfO6rbJGyJ8VTBZ+qkmBmsTRu8n/KxNjTfAnQ3
         tuZDjM/ny59xIfnQ4d4c449gPCskAyk2PQ8Hwgn1qAEGQ2ztjuJlQeV8eCcUlas/JyYE
         5RHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755901135; x=1756505935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnoE+2KIOrxMmHLE80mPq4ihdeC2ql7TNzCz0bDr1kM=;
        b=hvdkCcbftO5NEvXQav1i7eNQrRc43pAdN2DV19PiXLbY4oG34Jc/GrwFcPTuyj6a5h
         GdRWTachbmBkMr57RrSSVI8nSxstk7afwVRometvOXszylHsIxgRT3klpgHdvD5/sCRf
         IBXJHetAIoq40CsUo6mnNGPw7WxPW84awbJG9v6UBMyIWe/5Tr3/9IjosD9i0Qr+vzjb
         V9gAc8RBRLLuROYGEH5lTgaCaIELCunGzjUk9XzC0uUmbQULXx+fmvYB2z8OpEF9RXUR
         SMnXgQ7Y5Uabs8dEw2/IK/oH8Ha9vien8QPCc5DzUDnMZaPSxHhT7TNyP6/FBRlkhxwD
         dhwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2CZYzH6sJHmRKi4Kpq0aVpZDUMHVKjhsH2XWG+51SHZzak6wIwnH9LCQ0KzBi9SHiiOlOTio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4DOFc871Uv8MRkmtgJyjnaivo/V7Zn94zl5WQoB1lubca5VdM
	/CyozV5iRrfb1vSFI30Mo3lEyAtxwQNn4K4JRRFyVeEgqL0We5XTZCMBPbWcWXhje4+YMuYfs2W
	H1nUHnw==
X-Google-Smtp-Source: AGHT+IHb3wu/nQozE1W+K24i5H+qBWvG3lslX8qo3cGFshtCA6AwF/yPMQ2jgjjVbhTSV9sh9oV+yJBDuUM=
X-Received: from pjee11.prod.google.com ([2002:a17:90b:578b:b0:31f:37f:d381])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2585:b0:243:78a:82a3
 with SMTP id adf61e73a8af0-24340e4a4edmr6680164637.60.1755901135658; Fri, 22
 Aug 2025 15:18:55 -0700 (PDT)
Date: Fri, 22 Aug 2025 22:17:59 +0000
In-Reply-To: <20250822221846.744252-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822221846.744252-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822221846.744252-5-kuniyu@google.com>
Subject: [PATCH v1 bpf-next/net 4/8] bpftool: Support BPF_CGROUP_INET_SOCK_ACCEPT.
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

Now we can specify BPF_CGROUP_INET_SOCK_ACCEPT as
cgroup_inet_sock_accept:

  # bpftool cgroup attach /sys/fs/cgroup/test \
      cgroup_inet_sock_accept pinned /sys/fs/bpf/sk_memcg_accept

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/bpf/bpftool/cgroup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 944ebe21a216..593dabcf1578 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -48,7 +48,8 @@ static const int cgroup_attach_types[] = {
 	BPF_CGROUP_SYSCTL,
 	BPF_CGROUP_GETSOCKOPT,
 	BPF_CGROUP_SETSOCKOPT,
-	BPF_LSM_CGROUP
+	BPF_LSM_CGROUP,
+	BPF_CGROUP_INET_SOCK_ACCEPT,
 };
 
 #define HELP_SPEC_ATTACH_FLAGS						\
@@ -68,7 +69,8 @@ static const int cgroup_attach_types[] = {
 	"                        cgroup_unix_sendmsg | cgroup_udp4_recvmsg |\n" \
 	"                        cgroup_udp6_recvmsg | cgroup_unix_recvmsg |\n" \
 	"                        cgroup_sysctl | cgroup_getsockopt |\n" \
-	"                        cgroup_setsockopt | cgroup_inet_sock_release }"
+	"                        cgroup_setsockopt | cgroup_inet_sock_release |\n" \
+	"                        cgroup_inet_sock_accept }"
 
 static unsigned int query_flags;
 static struct btf *btf_vmlinux;
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


