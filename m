Return-Path: <netdev+bounces-306386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3IB5NLIkUGoBuQIAu9opvQ
	(envelope-from <netdev+bounces-306386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 00:46:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB6D7361F7
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 00:46:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=purestorage.com header.s=google2022 header.b=SAeOjeJV;
	dmarc=pass (policy=quarantine) header.from=purestorage.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306386-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306386-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 015603009CC4
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 22:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AA633CE8A;
	Thu,  9 Jul 2026 22:45:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7404315F
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 22:45:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637159; cv=none; b=krDprzz747PANFmn+xp0AV3cq5e+BMZY5s0AQ2RPD8V2+gDHUA52ve8NfkV2KMMFsX/SR/0StMjSWLcwLxs8sak+eQ6jPwr2hxfzs6y6WuEbNmGfore9x5AgN5AQ1S1s22W/kc1fvDVIG7rbM8rhSn3GF1tfWK6RnaWauADYARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637159; c=relaxed/simple;
	bh=MGMNdJLo25LAzcpT5SeLIiyZDEx6Ib234ZVeZgxVkEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XKITjKYkvnSsjeYg9GLNL8q++H9HU1josSCUyuKdTSKCbM8unVhTKR92LwC9TIcWcmvtWxqNFJ9a0wwPqAF6dC7T2bhxiegCcadyztGBDI63yMFKCEQnXYPhQ1+WqGU8X1VDxP9NBOh10So0PIm9AiYGcQKPibZeDvLuM+mww1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SAeOjeJV; arc=none smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47d6c634f45so227725f8f.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 15:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783637156; x=1784241956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wLN12DgRS88lTiZTocaolG1YOhh4+rIwZ/HTAPUgOKI=;
        b=SAeOjeJVzj09ro4zy6yyqZLEmRmjobvOF4Gk1jsV0hNmFI2Kk2qjdFu0SEoNc5D9jZ
         eQX0t0NqaxJGe0ZiBr+Ggf03paGdPcwuyo2hnrVtPq7duIbwhuOZZDtTRAf5QtMQ6s0N
         +02dHIWfX2MZdy+9ewX3q6OVki9AjrDBsi5lhL3J6B0+GiqNA3vsTOxrMV3+8K8KK+3T
         ES5IKLuhezLNULk0vrOfXft/UiBN0Y/B8CQO7L9LZYh2/Dc7/na347KzpWjGXd9bAcRb
         +bIB6ZgNe28kUYcGwM2jZyx164MxYoU00rTb3JN71QoS4DTHuUsJvH13q4nPg3E9HY/N
         up6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783637156; x=1784241956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wLN12DgRS88lTiZTocaolG1YOhh4+rIwZ/HTAPUgOKI=;
        b=Yw0jkIR0syiul+o8zyeQUXUYbwNtvmsV4Lixn/MYmU4E5yXBWYJqjn4lmeyjHgCzCZ
         Qd3Gylo8X5ZR6aLw85L5spPz8gGUYThk14RP3omA9lK6aGsJ4y8eQYKGxz9uDdc1nUc3
         c6Gg9fbiI6IRgLZYYvO5GDaoPgx+0W3pQxWCl4p1pihwLoGJSzHdH803amNpu/amilqn
         pjXcMUQH63YxCnueQ+eS0X5+iWuFcDMPipp6+T5roQ5wq+/iCQCmjdVNORAkCQZ321jj
         6d9j9SnFsoS2yag3+G/1v/p1k39PVTmpGMuTzfTZzVvMRQ8E4mllGWPXs9FX/MJc7ltm
         h31g==
X-Gm-Message-State: AOJu0Yy0PwcmcgIfBsmCGEh8ANAvHm8hxTrt52oSLxcs0y1N3P1IJdoj
	c34RydbphcyBe4yXLINgTkXxG+Ex+xsA/tk45RH2+Z5ahhOTKNibooP0WRMDC2lJAWPPJjolA+q
	b2Q5yOsBtEpJHSXteJP7HuTshG4gIvkqAJ9cy/9XQKcWfLIjHAS6KCl/AInVJF9vf2cdr9iDm1a
	NocsBBmZZI9X6BOZnzu5Boe8PAxeODnhCZLvJff8cT0PH6mQ0=
X-Gm-Gg: AfdE7clLPE22+ANX7A3pl0nwpCgm0v7NB3cw3IUlvRENKVfD63K+RL+FeetkdmlA4fV
	njyabxrZZMnp7jMadz0YRf5rhjje63LlS3btEoMyfahGXCYF+ebHPLS0MMUIS12DVO59Ec3Ij3D
	LtX5S2yqjiBXAVHy5MJDN843WY3kMU4QQ0YumXrkRScZ9S63n+RNWfDuu/ieaA1jVX5zd3uusZB
	a+jRZCMWlNyNyt7uX3vLc/Aijsoiy6CdX8MpErAkVZBWOZbMnrtUT4cHyubo01L3tFfaK6xHVuf
	IMQ/6Oaj5nDpnkDDjKXswms4MQOVA5sKuibUJAUXwAJPhjdO1k5BCgJV6WZC6gM6vx6/a47rK1t
	zjh9IkXogzZ5ghvayjSDkLM6Bbkq6a964eXavU/k4Zuze2fWk2JvmaY4F0MRh+Emzs0NpD6ju4H
	2SN2NMNUecq5CzDNscf/CKRVcumXkvEg069kPOKRF9kISrdzSBu6eLcVE3L9WYCKP7EnarChprM
	yHnC67jUgJqugRuRq9CirunRmnGeAmgNe0vM27E/5LHtO65H/Y0IP+23eYnZ6sMfXcXthJWxyMD
	IW1rmco/a8MNkxtMCFC5I9eoFW6umP80h0U=
X-Received: by 2002:a05:6000:1844:b0:475:f0c2:5b04 with SMTP id ffacd0b85a97d-47df07a2b2cmr9810845f8f.58.1783637155496;
        Thu, 09 Jul 2026 15:45:55 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm54918142f8f.5.2026.07.09.15.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 15:45:55 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	nils.juenemann@gmail.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH 1/1] tls: device: push pending open record on splice EOF
Date: Thu,  9 Jul 2026 16:44:36 -0600
Message-Id: <20260709224436.1608993-2-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260709224436.1608993-1-rjethwani@purestorage.com>
References: <20260709224436.1608993-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306386-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:leon@kernel.org,m:nils.juenemann@gmail.com,m:rjethwani@purestorage.com,m:johnfastabend@gmail.com,m:nilsjuenemann@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:from_mime,purestorage.com:email,purestorage.com:mid,purestorage.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2AB6D7361F7

On kTLS device-offload sockets, sendfile() with count > EOF can reach
->splice_eof() with a fully assembled but still-open TLS record left
pending. tls_device_splice_eof() only flushes partially sent records,
so an abrupt close() can drop the final record and the peer receives
a short file.

Fix tls_device_splice_eof() to also push pending open records.
This matches the software path, where splice EOF already flushes
pending open records.

Fixes: d4c1e80b0d1b ("tls/device: Use splice_eof() to flush")
Link: https://lore.kernel.org/netdev/CAMPsyauZ+jzG9AysO0FWv6ZY0kvCUpjX_U7o=oOjCuOQ87BCgg@mail.gmail.com/
Reported-by: Nils Juenemann <nils.juenemann@gmail.com>
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 741aef09bfd3..37bb06a8e8f5 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -595,13 +595,15 @@ void tls_device_splice_eof(struct socket *sock)
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct iov_iter iter = {};
 
-	if (!tls_is_partially_sent_record(tls_ctx))
+	if (!tls_is_partially_sent_record(tls_ctx) &&
+	    !tls_is_pending_open_record(tls_ctx))
 		return;
 
 	mutex_lock(&tls_ctx->tx_lock);
 	lock_sock(sk);
 
-	if (tls_is_partially_sent_record(tls_ctx)) {
+	if (tls_is_partially_sent_record(tls_ctx) ||
+	    tls_is_pending_open_record(tls_ctx)) {
 		iov_iter_bvec(&iter, ITER_SOURCE, NULL, 0, 0);
 		tls_push_data(sk, &iter, 0, 0, TLS_RECORD_TYPE_DATA);
 	}
-- 
2.25.1


