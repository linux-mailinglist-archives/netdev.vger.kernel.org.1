Return-Path: <netdev+bounces-102336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1E49027F8
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 19:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A37B21F92
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 17:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5EF1422A2;
	Mon, 10 Jun 2024 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="B4eb/UWl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A431EA85
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041764; cv=none; b=c6KwNULsxbXjnegpez2hdaawjn4Ws/Cm0Q5TZ+O5N6R4yGOMVTJ4zcbKOI/ji+IEg5pYYEpax70nOjIx+FAU3Cy18xUMTgJ9BSQ0BshU7JkT1MoOHOAHGn4tEYEsuL+DgW0449nk86oIXANZhQBB03WZzmMWoWufZxxmLg9lD9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041764; c=relaxed/simple;
	bh=Wn7s5r2JjiZ4GOOzN7DyWFDxQLRnpwRqMwiu9nlSt4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Md1VdYisddr1IQO7x56udz3rKM4jdNhbo2PiD7ZHOxPBXK9217sdMExO/JBkP2uxouTRGYtebPsbt0EktuC0GOZQfsCch9Mog7ve6HK/npl5XcaapLnC2UQKO/1RZVRu80ZLCM/JiH4Gf2JjLJEyGEc+Icn4tHGqSh+XS1Y7+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=B4eb/UWl; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718041759; x=1749577759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9tmlubi+Yiavj8N3FqCtngF9YPYqQoecZbHATLm5Fl4=;
  b=B4eb/UWl0o7j/U3939AvyFJTMWzRcyU0n5riFKg01r+ost7d4dH9/1XZ
   /earFdRRsm+a8pOddm6sOynhAnpTavAaVC1t09u9N50qDj0gyWuZXxlUL
   8Ua45CzKM+XN3h8CTm0lv0KuYBx7vIfx4D8wBoscZ7rfhuGxqjBGABzEY
   8=;
X-IronPort-AV: E=Sophos;i="6.08,227,1712620800"; 
   d="scan'208";a="95734468"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 17:49:17 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:18019]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.85:2525] with esmtp (Farcaster)
 id c493672e-a981-4394-a83d-4942580e7162; Mon, 10 Jun 2024 17:49:17 +0000 (UTC)
X-Farcaster-Flow-ID: c493672e-a981-4394-a83d-4942580e7162
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 17:49:16 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 17:49:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <mhal@rbox.co>
CC: <cong.wang@bytedance.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net 01/15] af_unix: Set sk->sk_state under unix_state_lock() for truly disconencted peer.
Date: Mon, 10 Jun 2024 10:49:06 -0700
Message-ID: <20240610174906.32921-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cc8a0165-f2e9-43a7-a1a2-28808929d27e@rbox.co>
References: <cc8a0165-f2e9-43a7-a1a2-28808929d27e@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 10 Jun 2024 14:55:08 +0200
> On 6/9/24 23:03, Kuniyuki Iwashima wrote:
> > (...)
> > Sorry, I think I was wrong and we can't use smp_store_release()
> > and smp_load_acquire(), and smp_[rw]mb() is needed.
> > 
> > Given we avoid adding code in the hotpath in the original fix
> > 8866730aed510 [0], I prefer adding unix_state_lock() in the SOCKMAP
> > path again.
> >
> > [0]: https://lore.kernel.org/bpf/6545bc9f7e443_3358c208ae@john.notmuch/
> 
> You're saying smp_wmb() in connect() is too much for the hot path, do I
> understand correctly?

Yes, and now I think WARN_ON_ONCE() would be enough because it's unlikely
that the delay happens between the two store ops and concurrent bpf()
is in progress.

If syzkaller was able to hit this on vanilla kernel, we can revisit.

Then, probably we could just do s/WARN_ON_ONCE/unlikely/ because users
who call bpf() in such a way know that the state was TCP_CLOSE while
calling bpf().

---8<---
diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index bd84785bf8d6..46dc747349f2 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -181,6 +181,9 @@ int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool r
 	 */
 	if (!psock->sk_pair) {
 		sk_pair = unix_peer(sk);
+		if (WARN_ON_ONCE(!sk_pair))
+			return -EINVAL;
+
 		sock_hold(sk_pair);
 		psock->sk_pair = sk_pair;
 	}
---8<---

