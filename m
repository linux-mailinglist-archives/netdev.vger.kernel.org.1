Return-Path: <netdev+bounces-258505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKHbInM/jmk3BQEAu9opvQ
	(envelope-from <netdev+bounces-258505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:00:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E56261311B0
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD5DA30B0A97
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 20:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD3230E0E5;
	Thu, 12 Feb 2026 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBN3OgNQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Az2hU/wp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E029A2D4805
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770929969; cv=none; b=fuZfI5i6S86Q3NpJ6agl6iWNG3L1lZCWHk4xX0aWIoGDY4zFlLsfGQ41rJhgjk/l24NI//lgQ1zqkk/53NW2hZLDojY+V/g1O0EUuHZoCnmTwaDzQGEDzF5VVNASwQLk9MdtfL5SFGEtYTVZ5HHJEnGD3CPQaWLQACmsvEUhFpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770929969; c=relaxed/simple;
	bh=GfXVbSIiCSvAfNsvXZFkw5pPzo6pnCYgQ7VhFaW9av4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAxSGkADW/DvAE+rgwuUP/zmNUbqbs4qpglzZytwLvPAEKKzp//+zymqBFkMH6fUNmwIJq0tGfcKhJhg36RJgLlYC5yCRiLLpOPw3dBw58tbKtLmvN5Pafisd/DQQtQLfSYrES9ZpXScyYqQERZ1UzlzWoAb3oD/YNPtYGqLkXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBN3OgNQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Az2hU/wp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770929967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1qRvoym6nLJZOIFftihpZCiMWAoHUET6JGe7MHQ2xs4=;
	b=eBN3OgNQ0TzuHJNu4Qkcx+id3TNZ4BnYIy+l15xD8atLCDgHOW3kmoYNHSIMHwMKK5itXP
	BvXVTPVoUjNekTDzxWmVneJAg2hayBMeXL93gwEEIgaZTYcHwtNXkpIedDkbGr/kxr5ojE
	s40PSanUzZhaITwTqrRJ2QfSCzN7pow=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-piXgKI-aOPGiiS2rdUPcHg-1; Thu, 12 Feb 2026 15:59:25 -0500
X-MC-Unique: piXgKI-aOPGiiS2rdUPcHg-1
X-Mimecast-MFC-AGG-ID: piXgKI-aOPGiiS2rdUPcHg_1770929964
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43623cfb160so188645f8f.1
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 12:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770929964; x=1771534764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qRvoym6nLJZOIFftihpZCiMWAoHUET6JGe7MHQ2xs4=;
        b=Az2hU/wpRDbv8sNYPDDkqR1bO3SAsUoAdD3h0n9HVTDFuSP+KGgclcavoPKQJGwY3T
         mlMHmkNXY2LjImus5i02wujNFS3zE2nC52MKMP6QfZBhVxomPhnzluJguj6+1sARo55C
         kOezZfmUhfh5figB3fi5K/Bu2uovtTw1Dg5zBXcpm6Rhks/spPiYT/keEpB+PRuAV0IG
         M2NSkdj3s0oQcP860ExRek3U1OrmKgulPvA1i5BS7eY4rFgBl1NxdXZFaBY4cNLzQ+56
         Hueez8WygkOoqgMNgHWAijrXw3nBsW7M0YN31yWaquG2GDpUKrSS/SWY6k9fJ5LoCC3v
         +/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770929964; x=1771534764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1qRvoym6nLJZOIFftihpZCiMWAoHUET6JGe7MHQ2xs4=;
        b=LzkfcmNgPdx4KIEze9zbNUR7QktbrBHaNoYsoRvgttBckLIHoHh/Q3ITsVH3AwFyF0
         qxDK23ByWaNcP16i2dgp+wHEdHYPKK+BFnNWwBN1g5cU4Ok+y6vz7ev3os88UM0FI6RK
         fLBl+DiJLzzFsBVhpQYeYuB/zIBdIIP387o6EiZ5Q+UlRmwP2p5tfGyrkO/MBYLapERo
         6HTpKRSXtOAUZoXO85fL2usDwQ2Bf0k/9SczTe93/29ImtF1stB4HynLQgV8N2r8vY28
         Cfuem9jG9NIB9wFeXq/VyK24iVQCOwxOvxiMfWvuL00x9b9rF0m2ziK41OryECwcf9CM
         Q4hw==
X-Gm-Message-State: AOJu0YyQ7OEiIXwtYyQvimVgFF8WQHxVcw998AenS/WITOsAmayC/ELa
	ZB6Aw6pCKDH96T6wI7kRb/RuCv+LwaoLXdbMakEKjH/8J24ecmMk9qEs5G671a+E45C6knJQsGG
	jfJukl6W33qP4jW55ccfoFBgOW/dMlh5H3540qppncjK8GmUm+caC+OAa8luuVsVw9al7q4e/NL
	UzevWJHLj90a8BboqWqppIfJk19cCpOE1HjTdpCg3OyA==
X-Gm-Gg: AZuq6aK53Q4HNiIJbFVv4UjqEeHzMYBS/R2YQ69BjTzMgbpIm7XeKOeZX152KpBiujQ
	PtOorEFtDzPihwebIcX0scLwv3ZjlBfoBXhXmZKTZGJaG3evT0qOG2F+S5lktmmWo/30U4xcXBX
	snQzNKnpT6KHh82ERXZQT2d2QbMVrCq3eJfmdQYTDtstmfSnHbI+Wc4s39bdg2ykPK2incDRFzS
	sqWe1nTM6VSaYLA324Z85c45Fzb5ySPn+UXDQWC2AWJgZXZAZ211NbDf8/gzWDNNKwtCmh0KETU
	ifiMwR+WibsZaSRDD0Ba5UkEhh0R5SfxEQqkTMETKP7+DUe+nF+cKnoFOC6VMK1T3WcRLp1+OmT
	VM8RYrlbaKk9JNM1sMLoCvmiOGey5xClAjvRhGLFJiTDQxbNIey1T0dXRaQ==
X-Received: by 2002:a05:6000:2003:b0:435:8aa1:ff4d with SMTP id ffacd0b85a97d-43796aa67c4mr421871f8f.22.1770929963828;
        Thu, 12 Feb 2026 12:59:23 -0800 (PST)
X-Received: by 2002:a05:6000:2003:b0:435:8aa1:ff4d with SMTP id ffacd0b85a97d-43796aa67c4mr421834f8f.22.1770929963268;
        Thu, 12 Feb 2026 12:59:23 -0800 (PST)
Received: from stex1 (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abd793sm465791f8f.25.2026.02.12.12.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 12:59:22 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH net 1/2] vsock: fix child netns mode initialization
Date: Thu, 12 Feb 2026 21:59:15 +0100
Message-ID: <20260212205916.97533-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260212205916.97533-1-sgarzare@redhat.com>
References: <20260212205916.97533-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258505-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: E56261311B0
X-Rspamd-Action: no action

From: Stefano Garzarella <sgarzare@redhat.com>

When a new network namespace is created, vsock_net_init() correctly
initializes the namespace's mode by reading the parent's `child_ns_mode`
via vsock_net_child_mode(). However, the `child_ns_mode` of the new
namespace was always hardcoded to VSOCK_NET_MODE_GLOBAL, regardless of
its own mode.

This means that if a parent namespace has `child_ns_mode` set to "local",
the child namespace correctly gets mode "local", but its `child_ns_mode`
is reset to "global". As a result, further nested namespaces will
incorrectly get mode "global" instead of inheriting "local", breaking
the expected propagation of the mode through nested namespaces.

Fix this by initializing `child_ns_mode` to the namespace's own mode,
so the setting propagates correctly through all levels of nesting.

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Cc: bobbyeshleman@meta.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 20ad2b2dc17b..3b629b4a0359 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -91,7 +91,8 @@
  *   - /proc/sys/net/vsock/ns_mode (read-only) reports the current namespace's
  *     mode, which is set at namespace creation and immutable thereafter.
  *   - /proc/sys/net/vsock/child_ns_mode (writable) controls what mode future
- *     child namespaces will inherit when created. The default is "global".
+ *     child namespaces will inherit when created. The initial value matches
+ *     the namespace's own ns_mode.
  *
  *   Changing child_ns_mode only affects newly created namespaces, not the
  *   current namespace or existing children. At namespace creation, ns_mode
@@ -2912,7 +2913,7 @@ static void vsock_net_init(struct net *net)
 	else
 		net->vsock.mode = vsock_net_child_mode(current->nsproxy->net_ns);
 
-	net->vsock.child_ns_mode = VSOCK_NET_MODE_GLOBAL;
+	net->vsock.child_ns_mode = net->vsock.mode;
 }
 
 static __net_init int vsock_sysctl_init_net(struct net *net)
-- 
2.53.0


