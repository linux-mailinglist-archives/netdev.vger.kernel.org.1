Return-Path: <netdev+bounces-302435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s92iA1SqQWr+tAkAu9opvQ
	(envelope-from <netdev+bounces-302435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 01:12:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFCB6D53E5
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 01:12:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XHF4ywJu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302435-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302435-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A5E33011134
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 23:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC9C369211;
	Sun, 28 Jun 2026 23:10:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764583749E4
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 23:09:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782688202; cv=none; b=SBwaIPvhzlRvPEpj1UYh5eNUc4BPvvIYAgpxSQnQAeXZ28kACTl/wZq9pV1U/f4MyebdSs0LH2TFqZgCm6MgcdueLYQO39Eq8VfVt+C0aGUh0dSoXusF/9SzCv39laJt15X7B10u3a4/kLDSJDfO6CP+7vrVCIkW69NBET3oTxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782688202; c=relaxed/simple;
	bh=8hxuXTTZXT6Wc4B3sIsuemeGr47k4Dd+hEsKaSACrTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzoHVkcwVJxOkk7QMYrf/YXINj48YBY8giwkV7CA9X082a43ljY02jdTLqUL7W8eD9C2gxYT4ehrmqHuc6cihdGDmxfi30oaSkfKH7FNUKTn04pvUvt8xbNP9pSek5a1xf154APB0L4GQE/Qb9HpvoNIBFObnWvpZ47pcQieuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHF4ywJu; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37fb434c547so923905a91.0
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 16:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782688191; x=1783292991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xd+9YCaMMJY0u/th5I1l3CpeHyUJ3UN/zpLGzdMsshE=;
        b=XHF4ywJuugBj/ap8zKG5rOrl5nQQx6ttwUEJvQlRIdXxvLoAs9eLElmrLxZ/QCHoex
         b/2dPmdnZogZ2wSh6r87BetrD46rYBbpBliGHcHNz1Qtkoiv8QaJ96xMo4Hscsw7Det7
         Su35eyWLVN/DmglVH+W8JedNXNfXYhhz6dY603x/PU7SqhpcpMT2gqGdIyk0honXe6sO
         JsI6i6edvW6qpXken0uQUYugfaD+KeTfttomK3zKyTf+csd5g5vraLB3o7sehmXtmh1d
         Baqucp3zkm9eDgEU98zm4liENhWCQobpIcMxLkreJPaq7rMIbipg28xDgq33XMAakjq4
         yRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782688191; x=1783292991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xd+9YCaMMJY0u/th5I1l3CpeHyUJ3UN/zpLGzdMsshE=;
        b=XLTL+ZCy7jzs13zHwBeobJUW37YD9aCtHGY3WfgPUNpCCEZP9CaRckGbYjQ/38SvpW
         xnxIWijAKx04DxGEkjmQ/zUOT4g/7ukXBrm4d/XRZKWtQxotGEJktzlC1jF18Y/yFwuW
         Kf3fI42Dq+O3EGbgCzEcVM3O1EnkV5FvZKBY5uViqvo38PaaXGaSat+R/Pdm6sio3TZD
         YbjeGezrB0sHXIGKp5lCTJEmT2Qn0K3ktF+K5NSZaM9i+K9VzICD4rhgJOoM3lD/1Bh8
         fZZi3IMCq0VS/A/PJ8Pnxiv5PMJ81X6LZcNWaeSvpUzlZnwtUv7MycmsDul9n/HYzEWy
         t0Vw==
X-Gm-Message-State: AOJu0YzmJRqtvjcRZKbzSgOSnFVcWpPDMzkssiDyioMgfdD0WlMfDa1Q
	s6S/1AvJ/nuZU9HubOOxpLEv932baSbU59LLbnUv7T7Q7uZ52sA5UJ48DBP2eg==
X-Gm-Gg: AfdE7clgrup7MY0NIBS003pJRAIvPvNUELMPtq7QZLhkAvcnLCwnyBZwfDj0FuqI4WC
	azjloOucIkGGGPn2hov3OLmgACMx18oueVyqDEJez55X4rAYc/FZv7xP38e4BWKGSshs+NBn+k3
	REoKnwOlpJDX0mV0GetPmDggotjbfcgsBuIPa6Ua+HWQD06c+apeg6UwhLzMhSt3J8XCdc22FWz
	G43GXgbzT+frVtKrNjVg4yC7hCw5BKjqhHKU0R71MyrDvs2Vv9JomOKYDtU0QcV/clKGu3zhDby
	qkI1r8dLPgMgSApqsqgvAJSr+5hsW10m/c+cbq3085hwZVOWFvrv0xDEdihNaKQ+uFxidvXc2WC
	Dc0SockhkeA9p6GAQxw5f5OcK8l1VMB22fKrPdYXb0pDFNalSS3coUNH1U0WtDBsYCHaCTfAeSj
	zc6Qsm6IzKsIfsoZZOaFS5yo4UtT3sDru0HSZCb9SKdQm4nBJLZIQuhCmAKtnM+jx3hSaj4CiQ6
	7bNFOi8LA==
X-Received: by 2002:a17:90b:380d:b0:380:1481:3b3f with SMTP id 98e67ed59e1d1-38014813ef8mr587232a91.3.1782688190707;
        Sun, 28 Jun 2026 16:09:50 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3800b9c834dsm606960a91.6.2026.06.28.16.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 16:09:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] net: ag71xx: re-enable TX interrupts on RX OOM
Date: Sun, 28 Jun 2026 16:09:44 -0700
Message-ID: <20260628230944.1244501-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628230944.1244501-1-rosenp@gmail.com>
References: <20260628230944.1244501-1-rosenp@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302435-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:chris.snook@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:chrissnook@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5FFCB6D53E5

When the RX ring runs out of buffers the OOM path calls
napi_complete() but does not re-enable interrupts.  Because
INT_POLL masks both RX and TX events, TX completions are
blocked until the OOM timer fires (~100 ms), which can cause
TX ring exhaustion and dropped packets.

Restore TX interrupt delivery so the engine can drain completed
descriptors while NAPI waits for RX buffer memory.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 77f8e75e98ac..a4e52bc42091 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1720,6 +1720,7 @@ static int ag71xx_poll(struct napi_struct *napi, int limit)
 
 	mod_timer(&ag->oom_timer, jiffies + AG71XX_OOM_REFILL);
 	napi_complete(napi);
+	ag71xx_int_enable(ag, AG71XX_INT_TX);
 	return 0;
 }
 
-- 
2.54.0


