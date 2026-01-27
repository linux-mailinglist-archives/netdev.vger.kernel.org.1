Return-Path: <netdev+bounces-253957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FBXKF36eGlfuQEAu9opvQ
	(envelope-from <netdev+bounces-253957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:48:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2763A989F0
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F3AB30078A7
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AD327B35F;
	Tue, 27 Jan 2026 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhU9phzT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BA31A9F9B
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769536089; cv=none; b=S4vopwY+Pk6OYdT+6yO6W47heovPcbI2qx3cBHMloUM4UeqOcM0/V0lNqbAzvz6Jewr1zS3VDsFP8EEpp2Eu0GkEfuWBH3QJ65pLT+U11bGjZCtlEXwI98QZXtf6Pfp0EgW+NmZ+UavQiVB0yH/nBhL9KnmmMeLGSYV6dKeHZ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769536089; c=relaxed/simple;
	bh=S1SsZh4LH96XLdQy5FqCDpEFSGkcfcAS64t3HhskAVo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Lzc1MfOZno10E2tx1e0b8ZcmtZ6DvalvaUppDa+lze1ayEoOqzecF2CY4O601dAse+dBWEPxf6MuBPJjBkhQNh7yj2uEfTkL01upSUbZPmqZIg9eqoBG8b+Mvp0eAHrvA3/kL1qWUzVh+7xCPBID9eNtgR8odxXjSDNPJUA3+Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OhU9phzT; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c52af6855fso745114885a.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 09:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769536087; x=1770140887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cPUMlfdemxhl+1SfXFwiQvKy6zYDAxDdo0Z5DvulR9E=;
        b=OhU9phzTg4N7PUg696Lfk3sUoUjlrYzKAt1hX24bScULF3WwwLoQGJ2jzFMj00M8TG
         mpV3r297j92bF+mRNJX3d3Q+uQ40udGBczEeWyn1arq6RoijcQcIftoeG10rhw7rlRjn
         XMg+KFQWi/jbKBvgX2z+2u5u4EcS2Nh5m86UhbJIeW3fyH4V+Va8oFkX+rrJQnlh4vU5
         1iLrrcXCV+VSnhGN8SuWNF5C8H6vRgz8xGnsv9raJgvqTjLd6Zdi7uy2YTdEQICTxyQR
         5frl2NteeDXUN2yJDl5YblXH8M54kRnvi8bjVjqEGniLgstEn21zgZLfq+6HpfwTU8H3
         tJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769536087; x=1770140887;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cPUMlfdemxhl+1SfXFwiQvKy6zYDAxDdo0Z5DvulR9E=;
        b=Hj5x9FmMxOqG6M+MkECOo94Xt+oioT4Z+7WC9YDvXUYn+YjrqQfAoqSlkNV4zkBgFu
         LxVUXZbIK6cnAjxR893mQb/hJmRHcguDmEyi3h5T+ub/9biiCJ9iNZin1/OtpH7wb+h4
         gR4s9ptkCWsJreQXkZOavk09RZQSKHtkhKw1N4I9LvHlMr967ukV9wzyqnvgLoy8Gr7M
         RVlMTxo0uehufj+u7c7jAVVO3KxMaAjStap15332Iak/n15yPfWj9pjidbGSOQWdnRqj
         2pZwM64oGMz8XZAK9T2KecAccs0SIUNoK9lvKy5N6bbEwlzIhRD1VSi+RmXTZnu300e9
         zIMg==
X-Forwarded-Encrypted: i=1; AJvYcCV66OvfzeMgu895Fth+MRAtTb0SCeWRaxGQ+6TdtIE6tw4NlBpCnM6n53/j+FFQFFEMdrRwSd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrig59M/wGljNXapPX88f/BqYLXdftsVn6dOmK81jr30tEDcSK
	1a5IRezlcsdH711yBRLx+qmJW/GZrmQlNNGA1+g1GhfXZkv9UzA6vrDWiAqlEo+2+coJGi20Oiz
	mUMYfOkcYwpDkiQ==
X-Received: from qkntq1.prod.google.com ([2002:a05:620a:3d01:b0:892:1657:c8ca])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:254a:b0:8be:dd2c:a0fd with SMTP id af79cd13be357-8c70b8f9717mr306255085a.44.1769536087408;
 Tue, 27 Jan 2026 09:48:07 -0800 (PST)
Date: Tue, 27 Jan 2026 17:48:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.217.geba53bf80e-goog
Message-ID: <20260127174806.886561-1-edumazet@google.com>
Subject: [PATCH net-next] selftests: drv-net: toeplitz: accept bigger rss keys
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253957-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2763A989F0
X-Rspamd-Action: no action

/proc/sys/net/core/netdev_rss_key got bigger (256 bytes instead of 52)

Fixes: 37b0ea8fef56 ("net: expand NETDEV_RSS_KEY_LEN to 256 bytes")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 tools/testing/selftests/drivers/net/hw/toeplitz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.c b/tools/testing/selftests/drivers/net/hw/toeplitz.c
index 285bb17df9c2f875c6073b8a0fa2619007b62962..cd4bf58a44ee7c14bceaf5c8749387f3d9cfe0e9 100644
--- a/tools/testing/selftests/drivers/net/hw/toeplitz.c
+++ b/tools/testing/selftests/drivers/net/hw/toeplitz.c
@@ -59,7 +59,7 @@
 #include "../../../net/lib/ksft.h"
 
 #define TOEPLITZ_KEY_MIN_LEN	40
-#define TOEPLITZ_KEY_MAX_LEN	60
+#define TOEPLITZ_KEY_MAX_LEN	256
 
 #define TOEPLITZ_STR_LEN(K)	(((K) * 3) - 1)	/* hex encoded: AA:BB:CC:...:ZZ */
 #define TOEPLITZ_STR_MIN_LEN	TOEPLITZ_STR_LEN(TOEPLITZ_KEY_MIN_LEN)
-- 
2.53.0.rc1.217.geba53bf80e-goog


