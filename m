Return-Path: <netdev+bounces-305140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3wquIfveS2oobwEAu9opvQ
	(envelope-from <netdev+bounces-305140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:59:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9819C7139D5
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:59:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=USww8SF7;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305140-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305140-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69471304AA3C
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 16:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B66F432BD2;
	Mon,  6 Jul 2026 16:24:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DFE3ACA7C
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 16:24:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355075; cv=none; b=C5aLJ6rJKRELnYiF89WWATodTu5dbbCFLeuQ5wI6JNQbsvgpGYfr1lHBpwR3OlTCUI6Xlz7HYsc9R/2ScS9PWLl9Lny3l1J7x9sFdm8WAhh8kbBD5477UZjTFptuCB6Kjlmulv9JxdUNrUP6a9AHmItUs1IV5j7XuSHSt1o8zZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355075; c=relaxed/simple;
	bh=kYjyZKOu5BuvTQeegraRp8HuW0OwQSiyPN8ROmlETNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZU/ZW8avg8EEVSQZt0+htefD8LRPGWnCJYtIRrCpv/Aig2iIfw2XU/3gROOLSa4i0h/lNIMvdVJOGFqlwbKfDKNXhHTFcvAj/4EXOwhO/m2NDWB/O0vtI1y4tAKkFRqOVE6anqlHZb3R2lnLyN9vHX6lRmZAOAkJzzfMHHmEaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=USww8SF7; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so24827625e9.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783355070; x=1783959870; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B3vq7ymDFM9EX/uHn2Ys6Oqxy7HM2kIJcIzJVFHBep0=;
        b=USww8SF7GY0pwQsyk+Qy8cUGc6QkXOu+aXZfUxpJxGj3XzhsaiZi7jycGTIpMdeJ4u
         TDl/d46ypXJmrD9xglW0qD6zaAsbLzMHyxX8tqeSBrPdzmeFv/TnS0ezIGxPqAyYYhgr
         O0qigw2xqRuDeVz1ZZcxTTOoEFPGMwzQzSLme85JvN7zgTbIVXkh1Q+RseiAiiTvLU1b
         qOX3J5up6cYPkQM4TPUOgGFovc1AOb1wA9GaHfEgDYmYqvEOsXAmDMQ700ViITmrgkTc
         +vR7O38V2FY6ZH65kLnq3nlMVZBAJra4CLSCUi4xnkCyxWbYixVlrX+8M7q2kzddPEzb
         SbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783355070; x=1783959870;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B3vq7ymDFM9EX/uHn2Ys6Oqxy7HM2kIJcIzJVFHBep0=;
        b=YikKDtWOEPf3i1LPDV43PTpzexMuyW6xXejZkKnUcBhz8Qune4HYBJvatzuvu+Xqcn
         O97Tm6cDY+C/qZMxW9s/YMyS3ycBMG2Mk8RftwUru5zRQ605ZSJ1WpFsa/tCK8f7y0Bh
         I7MXFSTUeovwkXb5sk9yqgb2B7umBfIxjfTp0hc8gnAx2lRVHGCXC3a0kr7d6FrL6bmD
         FOqPLnLzbPykeyRb+1jofOM+WFAcwdJBz4S/hKiR07bj9YlmvAXW6300Zi3ZiBQBKGfy
         OAyZgEiKWgk9VMI2d+NUZUUD3nsgbYGdWDsz9Vb8WvwXUurb3qg4CnuYjuUHLMsBRcDj
         k++Q==
X-Gm-Message-State: AOJu0YzTItal1ch6liyeabHh2+PowRLu3I6zQENTqXqIL1NtrfJVT/rk
	OsuIgjn0xfWTJmdtEbbzR+zv5zk2vuxnaAzqxg9miTWvbO9W/vpDL4vjZrI4SYwcpyI=
X-Gm-Gg: AfdE7cnn8hfO0Tr2nELfVKt/G6KHRMnoD4VZRcYJI0u8XH6sumhV6/LnuhD4jiyBgzg
	pkdMyhudk86I1iCsE3jmZyYoote7WTNFK9z/et3fXOHPmEdtlGmJNrBjVt/7+I9rIUcIJ5PRm26
	JT0qE+V5otV3Yb4+m+kErFklztUp7vc+JGzofMh67V7gs6QxLWtpR9zHdld/gbPnlxFZXyejNFJ
	xk2UrHsRpPPUf+0TpnZlVdkZeC3P7rpzjg1+ncxmhD12d6ye+k2LrnP03T62PS1HOy9tLS5R87c
	aKKnvEsOTNdIGPtbuZT+p/zIT4PpSer2UKHJRz26P+dHexd5T+zxy1yD5bio8SXYrvqYxRr5Ipd
	U0YeLrjs6KJ7RlvrhygacWStLtN0TxHrelDdjh2GF7I15ReJlXeshI47kot4Gu0N4pb3XVvO40p
	zXlA==
X-Received: by 2002:a05:600d:110:b0:493:c337:db18 with SMTP id 5b1f17b1804b1-493df042299mr10585915e9.16.1783355069970;
        Mon, 06 Jul 2026 09:24:29 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:157e:cc5f:6c4b:db0a:5d2a])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-969839dc37esm6075296241.8.2026.07.06.09.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:24:29 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Mon, 06 Jul 2026 13:24:04 -0300
Subject: [PATCH net] selftests/net: Fix tun IPv6 test addresses to avoid
 6to4 range
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260706-b4-net_tun_addr-v1-1-3d3cb2473560@suse.com>
X-B4-Tracking: v=1; b=H4sIAKPWS2oC/yWMUQrCMBAFr1L222BakipeRaRsktWu4CrZVITSu
 5vo5wzz3gpKmUnh1K2Q6c3KT6nQ7zqIM8qNDKfKMNhhtAc7muCMUJnKIhOmlI31PjnvMBx7C3X
 1ynTlz+/xDLWEy1/qEu4US/tqWUAlEzJKnJuq4f6BLLBtXwWvXEuTAAAA
X-Change-ID: 20260706-b4-net_tun_addr-055d454ab810
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Xu Du <xudu@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1783355066; l=2310;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=kYjyZKOu5BuvTQeegraRp8HuW0OwQSiyPN8ROmlETNw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGsxImto4BLYWX83ENgbi9BRJw4aGnVNlX0lWSyKU6KEtZYd0Yt+oOYh3CVT/jHst93iAhQHFGj
 tBVJGl8iocwc=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305140-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:xudu@redhat.com,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rbm@suse.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rbm@suse.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rbm@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.com:from_mime,suse.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9819C7139D5

The IPv6 addresses used for the tun_vnet_udptnl fixture currently fall in
the 2002::/16 prefix, which is reserved for the 6to4 transition mechanism
(RFC 3056).

On systems where the sit module is loaded, the kernel automatically claims
2002::/16 as a 6to4 tunnel prefix. When the test assigns a 2002:: address
to a TUN interface, sit registers a competing local route for the same
address. This ambiguity breaks the GENEVE decapsulation path: packets
injected via the TUN fd are not delivered to the test socket, causing the
IPv6-outer gtgso send_gso_packet variants to fail.

Replace all four IPv6 test addresses with addresses from the fd00:db8::/32
range, which is part of the ULA space (fc00::/7, RFC 4193) and carries no
special kernel semantics.

Fixes: 24e59f26eef2 ("selftest: tun: Add helpers for GSO over UDP tunnel")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/net/tun.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index cf106a49b55e..abe488bac50b 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -42,19 +42,19 @@ static struct in_addr param_ipaddr4_inner_src = {
 };
 
 static struct in6_addr param_ipaddr6_outer_dst = {
-	{ { 0x20, 0x02, 0x0d, 0xb8, 0x01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 } },
+	{ { 0xfd, 0x00, 0x0d, 0xb8, 0x01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 } },
 };
 
 static struct in6_addr param_ipaddr6_outer_src = {
-	{ { 0x20, 0x02, 0x0d, 0xb8, 0x01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 } },
+	{ { 0xfd, 0x00, 0x0d, 0xb8, 0x01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 } },
 };
 
 static struct in6_addr param_ipaddr6_inner_dst = {
-	{ { 0x20, 0x02, 0x0d, 0xb8, 0x02, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 } },
+	{ { 0xfd, 0x00, 0x0d, 0xb8, 0x02, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 } },
 };
 
 static struct in6_addr param_ipaddr6_inner_src = {
-	{ { 0x20, 0x02, 0x0d, 0xb8, 0x02, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 } },
+	{ { 0xfd, 0x00, 0x0d, 0xb8, 0x02, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2 } },
 };
 
 #ifndef BIT

---
base-commit: 56abdaebbf0da304b860bed1f2b5a85f5a6a16a0
change-id: 20260706-b4-net_tun_addr-055d454ab810

Best regards,
--  
Ricardo B. Marlière <rbm@suse.com>


