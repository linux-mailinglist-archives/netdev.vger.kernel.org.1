Return-Path: <netdev+bounces-274838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IETuJd4Zz2nDswYAu9opvQ
	(envelope-from <netdev+bounces-274838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:37:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 144FC390186
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 03:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A98F2305464D
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 01:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC6E346A14;
	Fri,  3 Apr 2026 01:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-sg.20251104.gappssmtp.com header.i=@starlabs-sg.20251104.gappssmtp.com header.b="beXRCr7V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68E5345CA8
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 01:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775180225; cv=none; b=FTE8rAcZCsBYYN0rZ8UxfsA7N7xbof61bdZUzulYmjR3KM8NB0TCUXP23MhWMurN7Pms5oHyLM9LdgGrHnq9LWIE0Ly8Ify5bhGKd/UnnHvrGQQwWfBxs5E0+nmPNlmFCw8nrSzsR4lLc193CK9sZApMvwCYCFT7x4skGF15cds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775180225; c=relaxed/simple;
	bh=IYFkw8oljp4nyG98JJ4c07/8WieLbCh+uS+oBqqBHso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqbFvCOiYszPwaemD2YvvmxvE1MiK/wMC/Qix6SyjRNUOOL3ao99tWz9ZUdX6F7EcKa9Adf2+9PSvQVehYHH+q8v33Pzu3zqBtQ445h4Y7TnCKU0Tr0+DI8JtGHPgNXRKRhh6zuX/OjHKICHdv3/zWoKm7buaSGz7WhHBS1FLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starlabs.sg; spf=pass smtp.mailfrom=starlabs.sg; dkim=pass (2048-bit key) header.d=starlabs-sg.20251104.gappssmtp.com header.i=@starlabs-sg.20251104.gappssmtp.com header.b=beXRCr7V; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starlabs.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.sg
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82cf83bf375so631430b3a.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 18:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-sg.20251104.gappssmtp.com; s=20251104; t=1775180223; x=1775785023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=94FIw1CabjzT89bVE5z8v3hqiWvqsDssKUWaYlLNlCU=;
        b=beXRCr7VTPWq2VHPZLMiLsVtYQjgRKcdP7vqaeQNyJOgcsbpHJ8cyrAf9Dtk4WLRIS
         APgcgPcJgXwLuwRNURMV0XMMQcxDCQc1j39T3+S+aM712zXBF213sic/yZFkSjjuSoII
         Q/wU2X60Css32ypwqRxCeHYd+PnvnezMJA10pRuA8mbg1mbp7/ff++Sgo9kaXlYltZqT
         l8c/5DyO5SG9lMDyr7qhtadBe38frGe/bZUHX5osNS8iQVRacZslCdifRLwL5B9bNBHQ
         1cnJRu+1/fr8XtmONWssirLEUCfQSrSq035KCevuMhQmNHzYWAFaYFFuLy7VLytCp1ey
         2l8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775180223; x=1775785023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94FIw1CabjzT89bVE5z8v3hqiWvqsDssKUWaYlLNlCU=;
        b=CIs4r7HDqLw46FT8g4GASwDVvJvC/OZvO/+HohJXF034n0uzbxU/8qAnifU7BBZJjl
         FAyFG2iMLKNO7r76bFdftp22gxpog1Ii0q2ZpL0cQlSFzrx5MhgyiIcDzEytWbKYdK6y
         J5/FSxs4u0CilSGe+avieFEwPaXpk1TVBe+TVKfe36SZdlzZw9SJ6HkaFEp9NzKm/Fb0
         Cy4ke8BEfof77z7L/vhg6TTSihmiKprVYEd3eFZuQLEYgWmMrqPqJpJ7MEkHWp5A+ogy
         0tkNrdHpQTkQKbc4wCd2QOhry6LQZfXgkE9rBhOicv7E2+Meyxbcf9QrWLfEzWDRlFlu
         y/+A==
X-Gm-Message-State: AOJu0Yyvqd8pO8gMULOXlsWseynJNo2fey645XTfiNGswVUHwPrQAMZ2
	AUvAfuuf3bdsxzUp1/gWvinPprY1APmPm9tnh1DSzkkvsE4F9PEedJ37FTZ30b8iiGqSC7Kt2m0
	sDXsYthLWjnU=
X-Gm-Gg: ATEYQzwiZzGU6QB0fTPdoZSdeOPtfHSIlNUTIxNjgwJ4fLEgJGRDaA22rXndvAb7+d3
	grSbTPOanw8gvciI9u/gGDBZLAWXY401cq+lgu0I84NCUvrxNYwqI3hbYL7JbsYzqegIzPp9v93
	zSQ5n3vpJlb/npGi1q1SMD28/7e5uvPje4LX6abdCZDAKlvJoNgCZlj7BHC36gfrypRIC1Fd37b
	kyvFXVwOu4bMuLfAfqkny2DRnF0WqxcQt/hXhlN/MAaJ2LuyR9N8IGcWDCsG4xSbvraSryCJkuK
	fFmpWs4JZU/2Hc9wIbUA5k0VBEGY90iMQo0TDQynbMkJi9AINPdxMV/9RVJwlERbNMmyCRh4N3L
	A5VkyAUHxN38rU8NaiegXYZjPDixtQDk5nKStmD8pUkawavtBDcOi2bsVlh1PecRC0UwpUe7nD5
	XA8Ylpg80fFsKlHADwzRsW6qtYCnRMXzRuaJY=
X-Received: by 2002:a05:6a00:124e:b0:81f:5ec1:8bcd with SMTP id d2e1a72fcca58-82d0da59d14mr1143380b3a.20.1775180222995;
        Thu, 02 Apr 2026 18:37:02 -0700 (PDT)
Received: from localhost.localdomain ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c9ba21sm6042331b3a.51.2026.04.02.18.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 18:37:02 -0700 (PDT)
From: Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	john.fastabend@gmail.com,
	info@starlabs.sg,
	Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>,
	stable@vger.kernel.org
Subject: [PATCH] net/tls: fix use-after-free in -EBUSY error path of tls_do_encryption
Date: Fri,  3 Apr 2026 09:36:17 +0800
Message-ID: <20260403013617.2838875-1-ramdhan@starlabs.sg>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[starlabs-sg.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com,gmail.com,starlabs.sg,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[starlabs.sg];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274838-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[starlabs-sg.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ramdhan@starlabs.sg,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 144FC390186
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The -EBUSY handling in tls_do_encryption(), introduced by commit
859054147318 ("net: tls: handle backlogging of crypto requests"), has
a use-after-free due to double cleanup of encrypt_pending and the
scatterlist entry.

When crypto_aead_encrypt() returns -EBUSY, the request is enqueued to
the cryptd backlog and the async callback tls_encrypt_done() will be
invoked upon completion. That callback unconditionally restores the
scatterlist entry (sge->offset, sge->length) and decrements
ctx->encrypt_pending. However, if tls_encrypt_async_wait() returns an
error, the synchronous error path in tls_do_encryption() performs the
same cleanup again, double-decrementing encrypt_pending and
double-restoring the scatterlist.

The double-decrement corrupts the encrypt_pending sentinel (initialized
to 1), making tls_encrypt_async_wait() permanently skip the wait for
pending async callbacks. A subsequent sendmsg can then free the
tls_rec via bpf_exec_tx_verdict() while a cryptd callback is still
pending, resulting in a use-after-free when the callback fires on the
freed record.

Fix this by skipping the synchronous cleanup when the -EBUSY async
wait returns an error, since the callback has already handled
encrypt_pending and sge restoration.

Fixes: 859054147318 ("net: tls: handle backlogging of crypto requests")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>
---
 net/tls/tls_sw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -584,6 +584,16 @@ static int tls_do_encryption(struct sock *sk,
 	if (rc == -EBUSY) {
 		rc = tls_encrypt_async_wait(ctx);
 		rc = rc ?: -EINPROGRESS;
+		/*
+		 * The async callback tls_encrypt_done() has already
+		 * decremented encrypt_pending and restored the sge on
+		 * both success and error. Skip the synchronous cleanup
+		 * below on error, just remove the record and return.
+		 */
+		if (rc != -EINPROGRESS) {
+			list_del(&rec->list);
+			return rc;
+		}
 	}
 	if (!rc || rc != -EINPROGRESS) {
 		atomic_dec(&ctx->encrypt_pending);
--
2.43.0

