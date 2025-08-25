Return-Path: <netdev+bounces-216652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55F7B34C32
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176B33ACF8F
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC15629BD82;
	Mon, 25 Aug 2025 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O+qz9KxU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F8629AAE3
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154528; cv=none; b=QHjx4IsDmBrj89rpCQGzfymz307wmJGTqLYNzRwhfpuHW16yZZL+8givfkO6eu4iQuYg3xFRojGMjgDGq9IDydInqrTJX1cEkSHYoSJ7el0ZDUfivzSHu0tKzX/uZfNRSo69CN36pyXdmzwI2ZNSVouLkOIdMLtzOwEADL4OUTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154528; c=relaxed/simple;
	bh=LS671NhhQdD8carTwkBj4ybZXZ/YovJU9pOCUsy5dgc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ENfm/bQqb6PhqjpMl6ptgNRqn1BXO7OJO5R/sr5Zx6gSw2o32EAjW0RSfIEYNWRMq59U8AA1ZFgqH0ojUhvJnJwUmzYztc/EAJM38DMrOzqko1Elo2ZFsB1/1uaDr2CaaXElwetjm1OBjkITl2i8vRXTHOmV4n5uCOlA2EalVC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O+qz9KxU; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-325228e9bf0so3631296a91.2
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756154527; x=1756759327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+cMygPmSM6dCzNwKSL7a/sRqPm0XfUojhTDtJh8dGVo=;
        b=O+qz9KxUIiTdXT7fk+yD1xMhS1kJYVDohUVqQ205MTuPT/AN2YCAriXL8ki3mdOyDt
         aX3Vt9zHXRehnhGOr+c9fN2RReHTwt2O8u1UPctiEkSvsmlEN4ouU6e21Nx+Qpre4UhU
         4lZLGCuCMAIDOxEa45XYOHFs5RTqRFw/aJat9SRaCbOHN+0/2i9yU3of9NmEDgZzkpAH
         a1KosLST1WZUbk5GzZGpZii8pOpN9LDrujYKsIPmBGRnhG+PGADSonItcIvbMJ2TcQzR
         cKOgrTVRrxOoLJ3ws5qN98PReOkc0XCyI69vP3JRIGMhBhfmamjCihcWr6ise8E6Cawm
         a0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756154527; x=1756759327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cMygPmSM6dCzNwKSL7a/sRqPm0XfUojhTDtJh8dGVo=;
        b=D3E+h0HyAm7zEh3lh7LbTFh9LFvcO9+a2l5jJ6jQOmr3runlBir7PanF0diU1a5KJs
         RDcO/odKQEgtB1B3g826RR2tvpRkh3xMZeY5OYcI4jRoUu7RTkxyhSZYanWaetcYDLnT
         dbKJnI5wvlkXrMGrduwJY8s+VJ3Ig7RwnfPdeQksCcWT5ngNKceSEYoYuBSLZI0BI/ey
         mDhcOU/cUX181ls1Rg2/n31f36tsLLuuyd+TOJ158RhCEaGuuEHet13IsvXPAumQtUtM
         0k85gtf+lEUk/sAdPnghg7CHA/9MwmiDYPkfH4Yr1otTLGjb1WKlhDqLQWSzWGwqzKoY
         MvZw==
X-Forwarded-Encrypted: i=1; AJvYcCU+LYhJDyTH5IxgNXNt4rNrHGiS8PFDgINS+u3D9y4VfBnuuJ1bRbmbJVty8AhH27aLXp/Vvaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv62kam6MsACvbWes/E3d9jcyB1L6Rj7CHJX0HSAygCELzTRXb
	ib8cxhfabgX9/mhfioktCLANyowhf5Ocig4J5mvVrXX89sK61nBl0Dok7yyQyr9o1WcJELlQSmE
	i8T4l8A==
X-Google-Smtp-Source: AGHT+IFD/FRGMPp/I7HaEhHJuo7Brtmh1xzlKhB4uWOGVmrBs3e9LUIXIMVuyKYEXZQfTl5Y8mnc1DtPKgc=
X-Received: from pjur3.prod.google.com ([2002:a17:90a:d403:b0:325:74fd:b81])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b47:b0:246:9a64:8cbe
 with SMTP id d9443c01a7336-2469a648de7mr89403205ad.36.1756154526828; Mon, 25
 Aug 2025 13:42:06 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:41:27 +0000
In-Reply-To: <20250825204158.2414402-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825204158.2414402-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825204158.2414402-5-kuniyu@google.com>
Subject: [PATCH v2 bpf-next/net 4/8] bpftool: Support BPF_CGROUP_INET_SOCK_ACCEPT.
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
2.51.0.261.g7ce5a0a67e-goog


