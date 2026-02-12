Return-Path: <netdev+bounces-258506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGPvFao/jmk3BQEAu9opvQ
	(envelope-from <netdev+bounces-258506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:01:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD0A1311BF
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 22:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5751F31385EB
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 20:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3732C32B9BB;
	Thu, 12 Feb 2026 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQpyyM2i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJodiQqm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C731A044
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770929973; cv=none; b=igHhaerFrGHgTXpI+mhW9MT6SoK5Rr5DkJWooFlx2o24oQp1vJehHYkEehZy9Cglxu+aJVYub2FD6RyB2uokdIykmq9jF5lqMCiINovKrhfjpOUO/u1BnUjkSrPkRXCnAVLAMs1evN43pT4g3IZGzZX6VvbtaMZIC+3sRtRTxX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770929973; c=relaxed/simple;
	bh=2HJhD4jwEiQd+Sw0gop1LZRkZ9dv9Da9YU2irp8nJI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCvqMO1XvpymGXsOsj2P/9QZ3qjYt0PgqF7ZBTpFUeviZyGTPevFdv6wvZpZkEjiLxGLu3FvbSslWDwoTu+10EQozr9y0WyNANPcQyy6CMdRXd9zt/Y51ywbZzFOy8g6dlQ6kBezM7le/QwoERz9mmt0JlLd5LuKEO8bxe02sCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQpyyM2i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJodiQqm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770929971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDtloKc54TB42uRGUdYvHpL+cAu7dip36yXl2Un1+Yk=;
	b=gQpyyM2ikhWKTlJZkd/LiR0AMcoQzMlAFFdMBvb1OwAtt99pGz4nDzq6uJUQUCo34q8XDI
	oLpdZv+uEHI1/zojfLsFN/tR4bCkNZKMo5tpo9V7W2rs8rqURf8Umpdqrx1apXz9FWPBQW
	MYMLihDjWio61pLKu8QQl81rj/XseDI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-j45oE7gGNCGXOk_QZDy55A-1; Thu, 12 Feb 2026 15:59:29 -0500
X-MC-Unique: j45oE7gGNCGXOk_QZDy55A-1
X-Mimecast-MFC-AGG-ID: j45oE7gGNCGXOk_QZDy55A_1770929969
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4806fa4a180so1747415e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 12:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770929968; x=1771534768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDtloKc54TB42uRGUdYvHpL+cAu7dip36yXl2Un1+Yk=;
        b=aJodiQqmaPN4wHiXG/PenXixnZslUo33SQzmS+S5QhmxK9Q2vGSydnS/qsYvG81r+N
         2kRwkrUmW6WHIK989q/6KO28dt4ZYBOOqijhBwyrHu6QSUbvhDtJLScDDZX1/iFhBdug
         qYZRciNAmLlldtBe9Ldv/RyWgKyWrxM/v/X6+mH285glPeboB9706H8uNDwKEHuXOOAJ
         wjABoZFSlG+EfN5LhaRVp7w5HkMA233jNEFX4X+Sm2768oYMyy5xsdyyR2npMnmo1GPR
         637C1NoWp8EjSehmTbZiJg3Ti1QU5vz3ydZ8c1dW/aImxHIdO0SFiQ1Eq2dqsk9b6RDI
         5HFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770929968; x=1771534768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EDtloKc54TB42uRGUdYvHpL+cAu7dip36yXl2Un1+Yk=;
        b=l390l6zVJfi7BQSq3wBheF/WvlFpRd8NM116nezcINr84icvgX9ob7Bs2LruBzyhKl
         aXttTOpZ1gNiXF2EsnaT650zNTEzbAbLWrT58P1YRIYZuUfBYdt3rlYQVjSxnJUlwBjf
         NCo96VPraVOBJjQpzwjFUCIRtwheZPtJhdkcZCMWauKmsryuzg3uQfe8fqIPrKq66+WR
         o2pxJ4XNXtffwz78WdkydoD5dlIysevoHBUoFRNlSvPFWvH0yhNHTtFImud0zTfNZyB6
         Qk01SJ5QKfddP2K/7HXiHYbqBiAMWnv26L7OSIDYBNS0956JdlBHc/8OdoZY7uw1Ywu/
         +ApQ==
X-Gm-Message-State: AOJu0YyUIVICVq3tDf9D+jIZFzscblmGaK0WWCR4SoSG/QDqzGTI6x/i
	jy3SDcHw0ttqsRjNbufrcsUxHNM1XadoBNbutQu2AC7f0ZOez3rWl432YhUInsdn2ErPJquvUnb
	5obfEbtjyfbZxkEdTaTwqTBNuH+AezskuvTcV6vxSv2ptFbgLya0srFiCEFkg9LLYmgrlRwwm+p
	qBIVD1AaIWUh+5G0PvYy3aIH1bj/wrdyWc4OFOm9JI/w==
X-Gm-Gg: AZuq6aKA6QEugkBb/IFs6FRH8nef+OhnkwNzO0uL0AtGoJfb1GfWn6Lad69+XfMeS4a
	Inu/DE3YBNbk8L2UYM4ALC4wiZLVVwohxDFy1G8GRAYpacRzOBGI3pEyjqLfRbp2kEvIAAQvpiB
	hFm70qs0eoGutefqVRADwLkxJHVcrLgggBCSqq/su8wl28qGbSrh33Be1WAVw7VByBfdYjh2yFW
	Ws4jeImll/mmMcgRvJRyVDILv32C1h1uxMSafo/dPtxePD6skZhkg5jY3QGtTK22z/y0W1lIOGK
	ZJac7hT05nYGHi0NiWXt/lte1CBRpU7OCX+uTWDsCCj1pu9SBqs258IudJWmnf8Zukg2q1QVr/M
	RKW2PwnhCGPHL8FVhgG4ixRN5pA73U3pKsnkAyJoRltMDfRnJuS2NxmgmPg==
X-Received: by 2002:a05:600c:444d:b0:480:1b65:b741 with SMTP id 5b1f17b1804b1-48370e305e6mr6147385e9.15.1770929967964;
        Thu, 12 Feb 2026 12:59:27 -0800 (PST)
X-Received: by 2002:a05:600c:444d:b0:480:1b65:b741 with SMTP id 5b1f17b1804b1-48370e305e6mr6146965e9.15.1770929967362;
        Thu, 12 Feb 2026 12:59:27 -0800 (PST)
Received: from stex1 (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483709fdd39sm5618975e9.0.2026.02.12.12.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 12:59:26 -0800 (PST)
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
Subject: [PATCH net 2/2] vsock: prevent child netns mode switch from local to global
Date: Thu, 12 Feb 2026 21:59:16 +0100
Message-ID: <20260212205916.97533-3-sgarzare@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258506-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: BBD0A1311BF
X-Rspamd-Action: no action

From: Stefano Garzarella <sgarzare@redhat.com>

A "local" namespace can change its `child_ns_mode` sysctl to "global",
allowing nested namespaces to access global CIDs. This can be exploited
by an unprivileged user who gained CAP_NET_ADMIN through a user
namespace.

Prevent this by rejecting writes that attempt to set `child_ns_mode` to
"global" when the current namespace's mode is "local".

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Cc: bobbyeshleman@meta.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 3b629b4a0359..9880756d9eff 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -95,8 +95,9 @@
  *     the namespace's own ns_mode.
  *
  *   Changing child_ns_mode only affects newly created namespaces, not the
- *   current namespace or existing children. At namespace creation, ns_mode
- *   is inherited from the parent's child_ns_mode.
+ *   current namespace or existing children. A "local" namespace cannot set
+ *   child_ns_mode to "global". At namespace creation, ns_mode is inherited
+ *   from the parent's child_ns_mode.
  *
  *   The init_net mode is "global" and cannot be modified.
  *
@@ -2844,8 +2845,16 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
 	if (ret)
 		return ret;
 
-	if (write)
+	if (write) {
+		/* Prevent a "local" namespace from escalating to "global",
+		 * which would give nested namespaces access to global CIDs.
+		 */
+		if (vsock_net_mode(net) == VSOCK_NET_MODE_LOCAL &&
+		    new_mode == VSOCK_NET_MODE_GLOBAL)
+			return -EPERM;
+
 		vsock_net_set_child_mode(net, new_mode);
+	}
 
 	return 0;
 }
-- 
2.53.0


