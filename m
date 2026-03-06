Return-Path: <netdev+bounces-264919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKsCAIJDq2nJbgEAu9opvQ
	(envelope-from <netdev+bounces-264919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:13:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4287F227C74
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DB27301F683
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 21:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31DE481FAC;
	Fri,  6 Mar 2026 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFbYNN4G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A814481AB9
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831600; cv=none; b=W+xpYy3N2VvODyqsRd+el/pix9bTugaxw9uKl4hQ6qDC9/QJMX+RAVWS+G9z3dGwFuJDWZHHCqd8TrL55d60pEUlCr22XCP3tCiUdwcw9KbN5KInkbbW7K+Afc9yFiQa6DGNr0yADW0V8OPR/W9Y/YUUhI0qG/VgIyEZzpb/jWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831600; c=relaxed/simple;
	bh=4ogALURRHmkBa3kJFR4OzsKE3FkMnZ+GeL96aI0IW8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CuEmVnWJBHVFGOD+TPsAr8vRQc10eQXmHMpfKK0WZaovOZWJzyLwfbxxxNxnXS9xZIS5Ajwl/kkMqxCS1S7kvI6C0qXychSgdIQ8tG9lKbUy/NLiNmn3NE1znSMnvRgrNxSeM+hLSBORj6l6TKQXqZdyOAML4FcT/IAx18eZ+tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFbYNN4G; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a13e1cfa45so859284e87.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 13:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772831598; x=1773436398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+wVFXDJqFGNNH+A2DIP/hdXRUUa1ETvoAO9jfbvYfc=;
        b=XFbYNN4GMlsHd11bulc2VhNR5IGollN7ESbcPYRuKpTnLuSqqQey2Lyhz/AwFvzoT5
         rM1npqbtqjo2C7izY8TzWWC0LtBQ84KvZG3NxNeKmuu0+ux4igoFQbkE6TR8+jRO0NvY
         I4jcacn4kl7giiuo65W+B2IcTuyslTOZq/mw7Gx2mdLiNtC884vArftJNOISnEL3//Dr
         YPKxQdr/90RKZzO4IDxkGB1BlXkh8xSoSgv30VNkBtLu5vyywM5T/bZE5OlY9L9q42FH
         cKJchXLxtWMcsstAXY7PKvcWKAKlL+KWCVrCNMcr5gS7LsTCBqR2xwIh+HrMIgoq5vgJ
         720g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831598; x=1773436398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j+wVFXDJqFGNNH+A2DIP/hdXRUUa1ETvoAO9jfbvYfc=;
        b=iH+ngmW9jD+wU0Hm1OAiBewpfGw0yDCGDbkctm8ZTlp/ZbeW9U+XPP011bKZCiZyBX
         d/5v1Ijq114gJzhOmhEz+++etGSwRVj/ej/56uy7CnCerqyRGIuQNBO7nhgCWcCoJjr8
         8fVoTCmRHibZCNBr2z0mw/bGXgDNJvLGnPr9IFuWJp7sZjjra7hqq579Ub+WEhT9SfwA
         HMssLa8FbjQt3P4DpPGY5PDzPJndsQDw9e22zvbrlyjhqwsEXjZozHgV9pMv3vdBS6H5
         8YLwAq6idHTWBEVgdLDy5RPbhgGzTok6AEF7fPIFf4ghU89uXwMhsh8RQ0xp0qe2sVxB
         VJGw==
X-Gm-Message-State: AOJu0YxJXIJh3lMv88dTkq0oad4iG0gb0Ya0NRdrrWq4ZErBgNLRV6xX
	l+q2MT2lhOCWoXRaAXg/rqKU8HFba3lzwVVRoszEu15+3XRBAbrAnEXT
X-Gm-Gg: ATEYQzzY41lOM5kRuBHu81GAVe1YZ8Lfzr0xeSCs3ZN5lbKQnI9ge0RVI44rKO7xJoD
	HTtivs9ZQSiyzlgofoKJrwWyH6NxaQgACqW5YM56if89PRpiG5Yk0Mieu9ESXp/dyMvwJrt+24L
	VT8xius3oiZmpW9IWBZ3l2BAMYYTxZK8vsT/MSotFISZK7RPB3fIf6FIqdNkI765yJS8Z6xbjqR
	dDzAtb1K791TQ+CVyMZyNAdiul3Bag0xJ+/RXIyiL/zB6508Mo8Go+5pFsF338NCO5XFk2534pt
	eSWyud9DHBxhpcraev+DTm22QlNCocgAZLJOm8QlNn8/k8f3zVHH4CBO31/2vMRi+X5FVHu5WxI
	f/GKVWRHYbOXx870sQRhW6YD1cJXXPEABTAIYW/HSJqZWyJc1MvPJ2u74pusFg0MsC+UneqIhZo
	TSeOxloNI9ccJ+Rkg=
X-Received: by 2002:a05:6512:22c7:b0:5a1:4c8:a632 with SMTP id 2adb3069b0e04-5a13cab84f8mr850239e87.13.1772831597351;
        Fri, 06 Mar 2026 13:13:17 -0800 (PST)
Received: from router-0001 ([2a01:4f9:3080:2e0f::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d07e0f1sm554433e87.58.2026.03.06.13.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:13:16 -0800 (PST)
From: Alex Dvoretsky <advoretsky@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org,
	kurt@linutronix.de,
	maciej.fijalkowski@intel.com,
	Alex Dvoretsky <advoretsky@gmail.com>
Subject: [PATCH net 1/3] igb: check __IGB_DOWN in igb_clean_rx_irq_zc()
Date: Fri,  6 Mar 2026 22:13:08 +0100
Message-ID: <20260306211310.1213330-2-advoretsky@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306211310.1213330-1-advoretsky@gmail.com>
References: <20260306211310.1213330-1-advoretsky@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4287F227C74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,linutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-264919-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[advoretsky@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.933];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

When an AF_XDP zero-copy application terminates abruptly (e.g.,
kill -9), the XSK buffer pool is destroyed but NAPI polling continues.
igb_clean_rx_irq_zc() repeatedly returns the full budget (no
descriptors, no buffers to allocate, xsk_buff_alloc() returns NULL)
which makes napi_complete_done() re-arm the poll indefinitely.

Meanwhile igb_down() calls napi_synchronize(), which waits for a NAPI
poll cycle that completes with done < budget. This never happens, so
igb_down() blocks indefinitely. The 5-second TX watchdog fires because
no TX completions are processed while NAPI is stuck. Since igb_down()
never finishes, igb_up() is never called, and the TX queue remains
permanently stalled.

Fix this by adding an __IGB_DOWN check at the top of
igb_clean_rx_irq_zc(), returning 0 immediately when the adapter is
going down. This allows napi_synchronize() in igb_down() to complete,
matching the pattern already used in igb_clean_tx_irq().

Fixes: 2c6196013f84 ("igb: Add AF_XDP zero-copy Rx support")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Dvoretsky <advoretsky@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_xsk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index 30ce5fbb5b77..ca4aa4d935d5 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -351,6 +351,9 @@ int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
 	u16 entries_to_alloc;
 	struct sk_buff *skb;
 
+	if (test_bit(__IGB_DOWN, &adapter->state))
+		return 0;
+
 	/* xdp_prog cannot be NULL in the ZC path */
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 
-- 
2.51.0


