Return-Path: <netdev+bounces-203422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE79AF5E12
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32A73AFD67
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A412F0E40;
	Wed,  2 Jul 2025 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fipUxRVm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA082D0C96
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751472470; cv=none; b=VKJncgdVDhdMGK1QiqicNglvt4KU1f8/hDQxgAFOst+YpEUnR6V2QvtICtevbbfMoRY+5/rLhOMZN3sk0bbEtqPBp38GgQEQmIxhK75Zn2GNZTFw/U/p4Rk3zGH/ky9KUSYxV/qD4UMuUmMhBEoNXsbTvjdyIErOwaBh8SWYQtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751472470; c=relaxed/simple;
	bh=O6by9/0kauJYWEkgSglvXw/V8coiyjeIzxGi9vuHvLY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UBu2pMGyt/QZNiH6i1U/IJlt6JOGAa6eW5skSHP8ZjYva1lmop+0RkGo8JwVmjOSRD1KtJzlemK1MD7rp1Gnqpxjc/qysJZGAgOavTSKY2vFEo+mF9cwMKImVuRMm6IhHCCP4JsxClObt5YKoetgDaPFOcrAq+uiBWuLiIJFcxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gfengyuan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fipUxRVm; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gfengyuan.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6fac45de153so109105386d6.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751472467; x=1752077267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SpkubWRCAgA3n9kTQKYoyEm6Wf3b95Ji8UJpkdBVSfE=;
        b=fipUxRVmy6wVOCKuvi82XMq93LABnoVVGyqkqJALogfYlsso3sQLDZlLzyYT+Z/B2s
         fEHhucflZPzO+gUKjBzv63h3Scb5a5MAx1ORmKjoF9CL81HNbgpX6QyS7ej3yu2jAMom
         Pipn7mRimJ2OEGNL1X68JH8EF84CfrdIhhyfFuvISEjbM84K2E9szCwKvFz4V1R/voVD
         dRgxQ2wnRpTcrHvE0x/mWWbT93J53vqwRUh6nGV0kVaUyICSWvgMywJudf3EJ1QE7GlQ
         NGCYS89J68EcgZuOUwkfuFpqdKbRsghFA0S70GFsGV0tXUY223gjyt4lTfNrciLKSCAg
         Kwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751472467; x=1752077267;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SpkubWRCAgA3n9kTQKYoyEm6Wf3b95Ji8UJpkdBVSfE=;
        b=RzYlBaxGaDfhNk+EUZDaCJY+dVFUlkW+Yfc17TAEuRHoy5wXeJ13yIfnvcoJFxVcQs
         JoDmvxwVbA/rXp7kH1c8jyFqWwI+2xYI6IejJtMK/xjwKZ1ew+4XFWpKDTq+fHuUTqnp
         Eyui9B/ol/h7zFMiDySyoMQbrF1sOIAK+XAzJDvNBpEfgkiBoR0EhA2qMvoAGsA5jQ2M
         NJ5DWORGv+eF9jUbB4jyxkTeLHeYw+i2zvzW687AzoXGwEfJYIUn7YYf1wuB79TOio5B
         w5abYDquzwO35cUJ7d5lU5sEwQvP0lhou4Nerc7BFWe3D6WlGbsGxr/bQmmDMaByPBma
         DWrw==
X-Forwarded-Encrypted: i=1; AJvYcCVkuQ0Vcexe2RvWmU0EpZQOe4mf8swfJbdukye03G3WbrBQfWqWPrjTDoIyTUZxKC2lM2w7c5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTwFpZAm76LQYKvmMkrmdkE0crNAmMJDyHk8WRANutDv5u+oUe
	LOyc4I9u1JAlNRHuSKWBN9uPxCHrrpkWn0lCDHQ6lvgMwq9w5HyVw/FcHb+mj8VyMia9h50hUqM
	zUVDnk1MxikObEdH5Zg==
X-Google-Smtp-Source: AGHT+IHGNihSVZdYeWYYvtq4JoWLcrdHbmonFDlPgo0zGbDWddFZcCsax7mf8uhd5h7l7WG3jcryV6vZXPJM6UE=
X-Received: from qvbpj1.prod.google.com ([2002:a05:6214:4b01:b0:6fd:50bd:be0a])
 (user=gfengyuan job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5e8a:0:b0:6fb:25f:ac8c with SMTP id 6a1803df08f44-702b1b71361mr56520516d6.31.1751472466382;
 Wed, 02 Jul 2025 09:07:46 -0700 (PDT)
Date: Wed,  2 Jul 2025 16:07:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702160741.1204919-1-gfengyuan@google.com>
Subject: [PATCH net-next] net: account for encap headers in qdisc pkt len
From: Fengyuan Gong <gfengyuan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	toke@toke.dk, edumazet@google.com, "David S . Miller" <davem@davemloft.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Stanislav Fomichev <sdf@fomichev.me>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Ahmed Zaki <ahmed.zaki@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cake@lists.bufferbloat.net, willemb@google.com, 
	Fengyuan Gong <gfengyuan@google.com>
Content-Type: text/plain; charset="UTF-8"

Refine qdisc_pkt_len_init to include headers up through
the inner transport header when computing header size
for encapsulations. Also refine net/sched/sch_cake.c
borrowed from qdisc_pkt_len_init().

Signed-off-by: Fengyuan Gong <gfengyuan@google.com>
---
 net/core/dev.c       | 5 ++++-
 net/sched/sch_cake.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 11da1e272ec20..dfec541f68e3a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3944,7 +3944,10 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
 		unsigned int hdr_len;
 
 		/* mac layer + network layer */
-		hdr_len = skb_transport_offset(skb);
+		if (!skb->encapsulation)
+			hdr_len = skb_transport_offset(skb);
+		else
+			hdr_len = skb_inner_transport_offset(skb);
 
 		/* + transport layer */
 		if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 48dd8c88903fe..dbcfb948c8670 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1407,7 +1407,10 @@ static u32 cake_overhead(struct cake_sched_data *q, const struct sk_buff *skb)
 		return cake_calc_overhead(q, len, off);
 
 	/* borrowed from qdisc_pkt_len_init() */
-	hdr_len = skb_transport_offset(skb);
+	if (!skb->encapsulation)
+		hdr_len = skb_transport_offset(skb);
+	else
+		hdr_len = skb_inner_transport_offset(skb);
 
 	/* + transport layer */
 	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 |
-- 
2.50.0.727.gbf7dc18ff4-goog


