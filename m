Return-Path: <netdev+bounces-274002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLJsNcPlzGnuXgYAu9opvQ
	(envelope-from <netdev+bounces-274002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:30:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B720377A3F
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 185313086295
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A8F3CFF56;
	Wed,  1 Apr 2026 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqrFnAio";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvCfjZD9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A953D0921
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035324; cv=none; b=FFJmeuiCAsKSfPe59mMkV9/eAExuXH3AAXpbFnc2qx73boEfHfs99HayXuo5HlQ4IPFluIBSnifQ8BhWMqXpV78ZTslj267Ik0S9yqJhjMa9m0FaPpNZPI5BvfrTVVeeo0j5NND2OHiW6/8sSmbL5I3358EoVL5sUACkGKrSJaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035324; c=relaxed/simple;
	bh=5n2wUfF38eHe2KG7fl6sKQK4heAIadpsxH8OnzLRvl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b4nXQ1UASqT7XhzeOZH9fZC5rrhw2dIIwvglGb3av+aiyA2VUTOavaTGlNydYMyFXIwjrwACdA8SSZduNnhm6Q0l6456bgmOU4Y/hn+7yumhiTT+CVcVEk9zdVJVIZZRV9IGde6rb509TWgyk72srrg6urB/XPnU9oktUpOaXBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MqrFnAio; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvCfjZD9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775035319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5Q6ei+ntkpvDAF7nzvhz0eKbU/9b0wmVLzSpYnM4X8M=;
	b=MqrFnAioSDDUKu3PzYH22sB2SXC2aXr16eAs/6nRp5iToF/K06cpsyt3IaCs2YpLHG2Bm0
	Z3kYeGFvuBTXzteQ3qLi0PooSzypWL7P1twYhZThdPvWxbBKuDlQcAGYWpG9DMVrpv6qnW
	Mbf8c9xkWZM0dnC6C1EYKGtjseIBCqo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-deWPwZmHOxuGjCRSIOglTA-1; Wed, 01 Apr 2026 05:21:58 -0400
X-MC-Unique: deWPwZmHOxuGjCRSIOglTA-1
X-Mimecast-MFC-AGG-ID: deWPwZmHOxuGjCRSIOglTA_1775035317
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48881eac1f2so5691215e9.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775035316; x=1775640116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Q6ei+ntkpvDAF7nzvhz0eKbU/9b0wmVLzSpYnM4X8M=;
        b=XvCfjZD98im5Td+m49bEcdvqtx8XSsjuOMZ/ILr5oxlcvQFhkXNJ4DDMRoATsKEE/Z
         q4wkF0RkVQYgFr6Cha0H+d+7vnRLFLqN7DhrcZtCrEtmlw8h9utlcTogYdlEh+i43Ijx
         aCEZuA5x1aSedInLSI0YjkhcSt5UJSrWkZIcOp32f201k/CcC09EM8fwm8g+DQfU1XbG
         QLeLtCY9RP2i5kzG/hWm9e4XQbVkRnMWorFc2PKdKJzr5EAE0BjNc/vNi1K6FIxoHBgs
         oY02k2ll+Bcp0iJojtEN4vk4TC+jjX8LJXbVbWO9hbL1goo64So6+a5ZgWLSV31wxJ/6
         ml9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775035316; x=1775640116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Q6ei+ntkpvDAF7nzvhz0eKbU/9b0wmVLzSpYnM4X8M=;
        b=TSNRfUzy84APdO94Ow768obMoK25OJxjML0R6ph/IBOi0ERiAZFKwQGjObQe+2yzE9
         atcvOQlZU4VYO/PMucLUC/L5d7Sdj0rmK7mfPDufKzQ53Od2jZm+DWfwRErFFvHhW3ud
         sUs26n8E7FUSlMr0nSk445AfykfQ3YX5isjcUaRJ4nhJE6mFx+sLaE+5wCUiXfSgi+oT
         SuurTyk8G6CUWfvt8xiI9vivbzTjFeK0hp05U31Y6MEh05ev0I/+W0aEBU6Mj0idsgEF
         zsotrdDdgr69QpwXbB2+btcZoO1Bo/M4Yx0zX78jtfBE9GgWdgc8usQM+mXG2UDjU07z
         ubQQ==
X-Gm-Message-State: AOJu0Yy5Frz7pUEpDbG6zeO+YXQ4+KcO5K/Jo3rU1R9/4bhzA+Nh9nC2
	hQqwFnJQtNWKNH53wDZdO27y/OyihZS0K50pR1PbjLFt/B6y9z8Elo8YDTC28DuTnejTLXfl8Dd
	EjvPQ/EXej9vk4PRmicMccdj+LRIoM/5hbXPgLfpOwliBPdE7iKwWwrJKPDQ7DG+G1+hDayuWsI
	VOd4LBYCBwCEOHUSLD5x8v7G7B74cRaJTCQu9oeoI3RA==
X-Gm-Gg: ATEYQzw7KCWnOv5XGdi85fTsRXPIjXhm+LRlnpui7rPSf8I6ieMpLVHZ22fqtcpijn0
	kkDa/LoFvPMD9vtFWCBbA74Nwfu9GqaMcB8S7LeuE0XuUzc3gVWmgOwnMlhDNvlBlRdCah0OccU
	ZxF9gvTWx35G0mVkMNvhWh1hvNM5D926Ubm/pyE6wS4qx6feXRuPvZzxipPcObhMWC420m1rt9j
	lWKpnEatKXg8w0CZQEU3a1vI4cm6/8pGkqm3tlHfWbRyLjFWmHx3sztVCdqcnOfS83qZo+cFbZk
	oprAaVhhGl6/HMF5inpFJhyQLJHhawmqWfsocb33wZe3cmBsNVdKse9xRb9jUsl1k0gJtqWRRn+
	5ocYOzqbaoVE7Bvj23CShWZBBkjL2eX3e9phkPYNRiQH2PCiiIYP4tNzQXFB2mAs=
X-Received: by 2002:a05:600c:3ba5:b0:471:700:f281 with SMTP id 5b1f17b1804b1-4888359db41mr42391115e9.25.1775035316329;
        Wed, 01 Apr 2026 02:21:56 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba5:b0:471:700:f281 with SMTP id 5b1f17b1804b1-4888359db41mr42390465e9.25.1775035315693;
        Wed, 01 Apr 2026 02:21:55 -0700 (PDT)
Received: from stex1 (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887ad477f6sm38285485e9.7.2026.04.01.02.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 02:21:55 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jin Liu <jinl@redhat.com>
Subject: [PATCH net] vsock: initialize child_ns_mode_locked in vsock_net_init()
Date: Wed,  1 Apr 2026 11:21:53 +0200
Message-ID: <20260401092153.28462-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274002-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 7B720377A3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Stefano Garzarella <sgarzare@redhat.com>

The `child_ns_mode_locked` field lives in `struct net`, which persists
across vsock module reloads. When the module is unloaded and reloaded,
`vsock_net_init()` resets `mode` and `child_ns_mode` back to their
default values, but does not reset `child_ns_mode_locked`.

The stale lock from the previous module load causes subsequent writes
to `child_ns_mode` to silently fail: `vsock_net_set_child_mode()` sees
the old lock, skips updating the actual value, and returns success
when the requested mode matches the stale lock. The sysctl handler
reports no error, but `child_ns_mode` remains unchanged.

Steps to reproduce:
    $ modprobe vsock
    $ echo local > /proc/sys/net/vsock/child_ns_mode
    $ cat /proc/sys/net/vsock/child_ns_mode
    local
    $ modprobe -r vsock
    $ modprobe vsock
    $ echo local > /proc/sys/net/vsock/child_ns_mode
    $ cat /proc/sys/net/vsock/child_ns_mode
    global    <--- expected "local"

Fix this by initializing `child_ns_mode_locked` to 0 (unlocked) in
`vsock_net_init()`, so the write-once mechanism works correctly after
module reload.

Fixes: 102eab95f025 ("vsock: lock down child_ns_mode as write-once")
Cc: bobbyeshleman@meta.com
Reported-by: Jin Liu <jinl@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2f7d94d682cb..d912ed2f012a 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2928,6 +2928,7 @@ static void vsock_net_init(struct net *net)
 		net->vsock.mode = vsock_net_child_mode(current->nsproxy->net_ns);
 
 	net->vsock.child_ns_mode = net->vsock.mode;
+	net->vsock.child_ns_mode_locked = 0;
 }
 
 static __net_init int vsock_sysctl_init_net(struct net *net)
-- 
2.53.0


