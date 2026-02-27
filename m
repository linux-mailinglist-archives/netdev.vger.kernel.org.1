Return-Path: <netdev+bounces-261686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPKpGdkIoWlXpwQAu9opvQ
	(envelope-from <netdev+bounces-261686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:00:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A111B2262
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B52DE3076B6C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59263302151;
	Fri, 27 Feb 2026 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wuvEMzW5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8823019C3
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772161205; cv=none; b=cb3a5TZDID9gQbNKu2KmBrsT36NaAJz7Vmx6vWExGEL/MNVfwsGXSZGdY1BBM1K1qG99FhHIJqzZz78wG8pXmkVxFmGS/qMRlxxpuVgoiqVzBPJLPNyMNbqy4YUP+weRO4zYeJM7YoztG66RWKarbF2Zvx9nG9mUlxSY7BEAq+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772161205; c=relaxed/simple;
	bh=5hkSc7MOOP+Ix5AXbXobx1Y0ayCvvlVMxg/JMbz5tJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sOtPWWYJN/Speo/qvp0OpAeS5PNcG4Np/gD8ZSvKDc8rkMkx0hB8E7A5j4ZLrNc9n14tHHkWS01reQqH6Dtu3M6Svgngu7+rjV50frju3v4UXS0/PNFkJiq8ZSAzqzYt6btArkka5nTB06RCqxE5nOZThhTyS4Znvcb3mpiyE8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srutherford.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wuvEMzW5; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srutherford.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdd4ce8dc3so23654369eec.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772161203; x=1772766003; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aag84U4bQMRgEK4LMJHj0ESGi8aRjj2bE+3e30KaXgc=;
        b=wuvEMzW5GDDo82fRb/xs8DMzQZ3dJlQwuRMfEyyhPriOWUvQsaKJtlkIJjdvqRHIc2
         fVy+HKRwGBc82DAhE1icQ/IChOi4zKo8eiYuTMfakz3+PDJUn72CytPZ31173LJKkG+n
         t4zH8Kj5NjcLY87kMD812NjZveVgmFVc25/33n40wqMF8DKu1GWhWHrqZCf1w2PrNHv5
         mgKGrYs1Ekl2StXznFoKOI7tcYb/L2bh7ZFlZZoTkCnW5N5nXOtL9trpO1UtHy9NHJ78
         IQwDiN7N8J7Nwe2jJR1SoNR0k4RpQg6igHPiPbGMMEX5Q8fY00J5R+VzN3FdKvFlIFYM
         2+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772161203; x=1772766003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aag84U4bQMRgEK4LMJHj0ESGi8aRjj2bE+3e30KaXgc=;
        b=KBtPlyFMMQx7OI7nr37VoIf3Ls0tEgZvHfu1ksCTzu+V85eiqxd8xKZ8dteJSTDe1W
         GlOGzrvkdDoxCpyBnI8/OvoJnDuy3ujJCKYD51lOkryHdJuUn2CnXJfiaMAtp6WKYj1n
         pfPFr9Jkw08QCYw65B1AdUbil4h0fLYJA2/GsrA7WbzBeek2u8/k60JVgAi7S30wGjG6
         mKrTD1rO9r6DL6dAloduwzfiEx/zYR6oVi5XHFoX1xBbDRBYlPMYt9SH8M9ADz9FRJ30
         9VoXVKlwLn+S8VY81RZQLudwQPdlH6uD0CEut36U8G9EoMy7wpKu5PiHNT/12bSu6r3J
         nmOg==
X-Forwarded-Encrypted: i=1; AJvYcCVMMWpHcINxwEYLrtyyQRi4LzxfjsrsXylb+Y9Cyz7fzf7/sb+cWI9iopyRNpcUPER+RFhlMC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxShUftIo1isWp4sHzUP1JmWsBrXQBLTLIXk3XxTsKe84jOaiFI
	qSnYy9meug3fMPef5hcvltxSQFUP3jmkqJMLMnixpdhbqvQ2ZlGlAgtNjkshaRToGKvc9TfVajz
	+f2bN9avROHcIBMWiEty/YSa2kQ==
X-Received: from dybkk8.prod.google.com ([2002:a05:7301:3c88:b0:2bd:b12b:3839])
 (user=srutherford job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:2325:b0:2b8:66f3:2522 with SMTP id 5a478bee46e88-2bde1c0ef97mr761496eec.3.1772161203130;
 Thu, 26 Feb 2026 19:00:03 -0800 (PST)
Date: Fri, 27 Feb 2026 02:59:50 +0000
In-Reply-To: <20260227025950.174755-1-srutherford@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227025950.174755-1-srutherford@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227025950.174755-2-srutherford@google.com>
Subject: [RFC PATCH 1/1] Fix header clobber in IDPF with SWIOTLB enabled
From: Steve Rutherford <srutherford@google.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	aleksander.lobakin@intel.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Steve Rutherford <srutherford@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-261686-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srutherford@google.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6A111B2262
X-Rspamd-Action: no action

When SWIOTLB and header split are enabled, IDPF sees empty packets in the
rx queue.

This is caused by libeth_rx_sync_for_cpu clobbering the synthesized header
in the workaround (i.e. overflow) path. After the header is synthesized by
idpf_rx_hsplit_wa, the sync call pulls from the empty SWIOTLB buffer,
effectively zeroing out the buffer.

This skips the extra sync in the workaround path in most cases. The one
exception is that it calls sync to trigger a recycle for the header buffer
when it fails to find a header in the payload.

Signed-off-by: Steve Rutherford <srutherford@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 3ddf7b1e85ef..b02195fa2813 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3007,9 +3007,14 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 			u64_stats_update_begin(&rxq->stats_sync);
 			u64_stats_inc(&rxq->q_stats.hsplit_buf_ovf);
 			u64_stats_update_end(&rxq->stats_sync);
-		}
 
-		if (libeth_rx_sync_for_cpu(hdr, hdr_len)) {
+			/* Recycle the hdr buffer if unused */
+			if (!hdr_len)
+				libeth_rx_sync_for_cpu(hdr, 0);
+		} else if (!libeth_rx_sync_for_cpu(hdr, hdr_len))
+			hdr_len = 0;
+
+		if (hdr_len) {
 			skb = idpf_rx_build_skb(hdr, hdr_len);
 			if (!skb)
 				break;
-- 
2.53.0.473.g4a7958ca14-goog


