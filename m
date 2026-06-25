Return-Path: <netdev+bounces-301874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4dP8HuDRPGowswgAu9opvQ
	(envelope-from <netdev+bounces-301874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 08:59:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 133B96C32DF
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 08:59:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=N7NaVACi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301874-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301874-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81C1F302678D
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 06:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972053C0A08;
	Thu, 25 Jun 2026 06:59:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479B53BE638
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 06:59:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782370782; cv=none; b=nBiFoJCyD9FYjQIGfAMnh7jVJLi+uLiOzSMb0spcxxSXKkwYsBS05uEtjmMI9Ja5I9yse9Ba0/16+/83Qv7ZNdBRAOmye24EQHmvsAW/mNINTRDBwTC6BWUfIGaJ9SgfSeoUN0QQLBlrfTJ7TCAkoBVVSi0tf+5/+e0PXRtXOWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782370782; c=relaxed/simple;
	bh=wChWizkaddeoNk0iFxSTLzVndDbJYHtAJiYtqLaaDDA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CV2BZCBLXEXniPPYLRgIJaa4LdKdVUVvsbh3tOps4gpUEb57m3Y6q298Zwd5PzBBdKkumSM+DojtgCF/7+NcI47/A7S0nmZ6X34YCVlrlQRQhP50yULD6Ywgvn2d/cBTGzAbU8A5FoaGVX+2DDHTpesbsMEUka44Rp/l6v4o9us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N7NaVACi; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-51a05146054so22755661cf.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 23:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782370780; x=1782975580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LH5bkThl/3c0aXolNUt6un7v2/4jYI9hx/7E1PfnL4o=;
        b=N7NaVACid0oQRRu540hLT+mIvXr2AMDo6FIsrdfSCJlCixRFi9cw811l8eRTV9Mju+
         J5AcI9GYbXLS9aECp9/Bf+GQuffrI5U1EPoGPyfjGGrPXrcFknzTvs2Sabzv7BoMboqL
         2WpvHps9Sa4+GryovT/TUs+mTaQYQZIMhD1DuMoU0nQMjMYXzZTw+aK0+KXaNcucVUfQ
         L/wzwSuQlcJWVsb2EezGqm3VfcVusHbwkxVozGjdT0yUJRknwr0SoBTFXYSReJ2ps2Ke
         KF7/DqvV5rXTm5Smm1cl3mqoFbQfy+5JAViD8Eu6byrugvXGziC43Qqprof89beAUsiN
         MZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782370780; x=1782975580;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LH5bkThl/3c0aXolNUt6un7v2/4jYI9hx/7E1PfnL4o=;
        b=LOfQ4d7IJiRIVYFtNB4n/1tHumyIf9lvEeR2xPDyYz3TmqjATaiDJgkxjAh3TH+mA+
         1MnA6rU9O2469rxmbOGXodHSVxHl4wglVf0eO88sSugwieXNNtT1sYYeaNcGeTJWpFkv
         kvPHr07s3Dkk73yCIJZvg7aYRGNqfNYVza6MICvGSkOT9C6Z0kCN5U6WMv+5HvrlMWQs
         QMpm85vrjSexNFu/OORs8NtCI9DPpUQwybHmR1Ka1yVwFK22qS+vWiZvXKzcGykOFn8a
         9sNT8hsdmGK36sjBhDSs0w6BBDQ/VqN6I7gCUynhgN9R2mn71Svov6Y/kGV0lU8kCnH9
         wE5g==
X-Forwarded-Encrypted: i=1; AFNElJ+Hd+JoQRQxGmggRvVn4GwLhmSdmZEmgsukKtPuDakBVZk7gCT/QgucbWjunRSuI4XJUNJ1hHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3tejLwB/cADidmpo1ETzTyHpTbs1vg4fayWaRFJSDpf+dfaQQ
	BPbkiEUIEPZXBoEZLsLMYy9JXZdWS/HeKAfm6UA72BcWm+mggOyHQJyerAW5giZPoYVJYmqGV76
	NAEhnYjRDsSRx7g==
X-Received: from qtbg22.prod.google.com ([2002:ac8:7d16:0:b0:514:c2a9:36f2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:400a:b0:517:9095:c329 with SMTP id d75a77b69052e-51a727eb43cmr15489861cf.45.1782370779985;
 Wed, 24 Jun 2026 23:59:39 -0700 (PDT)
Date: Thu, 25 Jun 2026 06:59:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625065938.654652-1-edumazet@google.com>
Subject: [PATCH v2 net 0/3] net: udp_tunnel: fix races and use-after-free
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Yue Sun <samsun1006219@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,fomichev.me,vger.kernel.org,google.com];
	TAGGED_FROM(0.00)[bounces-301874-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:samsun1006219@gmail.com,m:sdf@fomichev.me,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 133B96C32DF

Yue Sun reported a use-after-free and debugobjects warning in
udp_tunnel_nic_device_sync_work() when concurrently creating and
destroying netdevsim and geneve devices.

This series resolves the UAF and the underlying data races that
make the fix vulnerable.

The core issue is a workqueue re-queue race combined with data races
introduced by the lock-splitting in commit 1ead7501094c ("udp_tunnel:
remove rtnl_lock dependency"). That commit allowed the device reset
path (reset_ntf) to run without holding the RTNL lock (using only
utn->lock), while the port addition paths (add_port) still run under
RTNL without acquiring utn->lock.

This series fixes these issues in three steps:

1. Patch 1 (Jakub's fix) addresses the UAF by preventing double-queueing
   of the sync work. If work_pending is already set, we return early
   in device_sync(), blocking a second work item from entering the
   queue while the first is blocked on RTNL.

2. Patch 2 converts the state flags (need_sync, need_replay, work_pending)
   from bitfields to atomic bitops. Because these flags share a single
   byte, concurrent RMW writes from the RTNL-locked path and the RTNL-less
   reset path corrupt the byte. This corruption could clear work_pending,
   defeating the UAF fix.

3. Patch 3 fixes a similar data race on the 'missed' bitmap. Writes
   (__set_bit) happen under RTNL, while reads (should_replay) happen
   under utn->lock without RTNL. We convert this to use atomic set_bit(),
   READ_ONCE() for the fast-path read, and WRITE_ONCE() for clearing.

Reported-by: Yue Sun <samsun1006219@gmail.com>

Eric Dumazet (3):
  net: udp_tunnel: prevent double queueing in udp_tunnel_nic_device_sync
  net: udp_tunnel: convert state flags to atomic bitops
  net: udp_tunnel: use atomic bitops for missed bitmap

 net/ipv4/udp_tunnel_nic.c | 51 +++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog


