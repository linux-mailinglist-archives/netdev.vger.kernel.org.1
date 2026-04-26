Return-Path: <netdev+bounces-281173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LcCKQAm7mn0qwAAu9opvQ
	(envelope-from <netdev+bounces-281173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:49:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA2F46A719
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7877D301411E
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF5136AB4B;
	Sun, 26 Apr 2026 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NenE3BRc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0749A368958
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214943; cv=none; b=Xm0GYvt+ndAvwz6r6hXoLEgFVoJ2Utj/XDRgKQvNDByhu/bVXcnkGqgGkSVdh3fX3J5mOsV+xgsTPMsuTJQqL+cVYk77u9cO/cHAHQOmubBBsFXxcrjY/WrYGpsXV26XFNg+Ti0yYqf3ayVCwW7qVw9V9HsVhCRiOm1ajzIrUeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214943; c=relaxed/simple;
	bh=vsm/Vin6fhEHMK5Rg/gfXmdGW6NjOiPfcld3a7a7Zqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r26mUiG8zqB5H8qSMzZbya9QuiYPa8Ck7AEg4F27Ddd4FIN94ceRh5Tvgmw6HwAU1Rv7vXjAWkUAbTZFVwHyzx0VYkDzz7ECQ9waTOGEi8dW81JjBnfwB/m34k6Q1Md0DIibwbSop0l78c9A3kZbXgOw2YhP+WS2RkHbaYdUHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NenE3BRc; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8acae26e564so113142746d6.2
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 07:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214941; x=1777819741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLYe3X7mIdfpi7a+4xLOp68gaR+hsDkG8LtdUaDQjF4=;
        b=NenE3BRcLW34Jayeyr81Rdt1Zunk2n3OcSKDbKUkSndZ0irM9vsWGeFB2cTG+SK39g
         f2ZRdW8UlOO/tGmmespooz6WOSBI1CBQoYWX6oLnkpqeEQDp3hcU3LwsU1RNTpd1nI7o
         /WNuy3zwMo751bQ3AJW7Ij0y8BrNIT0M+Js8Thf89EX03zHW3f0+CLdB9/yweyKi7m0g
         vcByteO/ISTpDr+pQcDLCovC6WC3LJBMdP8s0IgY2ic+pJg6DowPYqoL60Oyt4qSd3By
         1AiR1DnQuGNNmmHfmtw55B5QLnq8xQx3vMqTQBjEd7M3mn8C4pJsQ7bXphAUzPtcv88g
         rE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214941; x=1777819741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZLYe3X7mIdfpi7a+4xLOp68gaR+hsDkG8LtdUaDQjF4=;
        b=jK75PB6rauVTE032uPIviZg97cv/T9owoKb1aLE3u1waMtmIgdKpwc6aRaXDzsyHoS
         TEgT5wHogdPkAXpQroZfMCgzCeO6AT5/YgA5iOYHQMyJKjEKRTBl9MFQ62BmYcnXJMd5
         CqmrJP1RCT9pLdUJqgHXnqsZp+eeE5R5y0H1a2HqyOXQ/DJs+i6JH0y+90vWhNH/xqLd
         /lCA8fDptLkoBFkmvonHTqid94fDARfutMTFzYWfR7H5FiekfqwM1eUkykMp6qmhVOxk
         ELYscRjsuNVzcXmS32KF+Ep+wr6+636O62CU6Yuvbc4tx1X1fiT5z5JCgxsGE+JxmSrH
         dfgA==
X-Gm-Message-State: AOJu0YxBRPTFaNrnqRZHyXcrH5uS3PMpw5swi8RclzkiaB0lQlFnz7bR
	wATGj/CkAjhEekT6Ri+XUzJ/eIwaDHlVPG1TJX82cxq1nQTm1RN65OHFIMOOpIX2
X-Gm-Gg: AeBDieuzwyFHG8d2ziDNCQUVbDr1qw2At/VRlvkqC/D+v3XP9PBqd22vWIyrP8jgpFu
	SCKf3+6Ev6o/8RU2n4AfwoDMqLmalMRMWSCKYwbVYb0Pa6JM9tQQ/zm4JqvRhJv67RbZmJPrCUU
	zyY6bGJwrrKC1wT8Lk8ayv8MgOjBFtPXT7fRfkEowUep71H2g3sEdtuo/dimHWLoV3o/bLzlD0y
	N4LWbu7iRd+tcXmBsrcDP68FvTNb6WqgPvR1Y9OWSsXRca3/b1+vO6Z16Oeqra7Grk0B1kngXYx
	ecmDTNLo1CE3f/vx8Hrtupzpp6IX42t2bnKn/1BPbxDNKFyrnIJMfcOKqPI8lI9indDhBm/BIKC
	F1e96EiNLRoO5pIWwQpn1LmV5zek+GZ4pJdkrHlgwT0pehPH/ZPkLgtAD3z2CuLyV+Mioluq6TW
	SXPHV53hE1uHVBaxbc80DGStB9Ni5TRoswzgvnlULV/CMMsttV6ESOysAcUdK0CXP89VOWOiRWp
	dFw9NUw8H6Hj1ZZwIYvZ9F9ODeWQPNenqrtv1K74b5aV0147AAciHPVjGDIreLeRwkjJxLmhI4=
X-Received: by 2002:ad4:5bef:0:b0:8ac:ae21:46e with SMTP id 6a1803df08f44-8b03a1885ecmr509647676d6.31.1777214940620;
        Sun, 26 Apr 2026 07:49:00 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aebc655sm232579146d6.48.2026.04.26.07.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:48:59 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	netfilter-devel@vger.kernel.org,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Yi Chen <yiche.cy@gmail.com>
Subject: [PATCH net v2 2/2] sctp: discard stale INIT after handshake completion
Date: Sun, 26 Apr 2026 10:46:41 -0400
Message-ID: <5788c76c1ee122a3ed00189e88dcf9df1fba226c.1777214801.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1777214801.git.lucien.xin@gmail.com>
References: <cover.1777214801.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5EA2F46A719
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281173-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,netfilter.org,strlen.de,nwl.cc,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

After an association reaches ESTABLISHED, the peer’s init_tag is already
known from the handshake. Any subsequent INIT with the same init_tag is
not a valid restart, but a delayed or duplicate INIT.

Drop such INIT chunks in sctp_sf_do_unexpected_init() instead of
processing them as new association attempts.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
v2:
  - Fix INIT tag comparison by converting the on-wire init_tag to host byte
    order before comparing it with asoc->peer.i.init_tag.
---
 net/sctp/sm_statefuns.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 7b823d759141..8e89a870780c 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -1556,6 +1556,12 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
 	/* Tag the variable length parameters.  */
 	chunk->param_hdr.v = skb_pull(chunk->skb, sizeof(struct sctp_inithdr));
 
+	if (asoc->state >= SCTP_STATE_ESTABLISHED) {
+		/* Discard INIT matching peer vtag after handshake completion (stale INIT). */
+		if (ntohl(chunk->subh.init_hdr->init_tag) == asoc->peer.i.init_tag)
+			return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
+	}
+
 	/* Verify the INIT chunk before processing it. */
 	err_chunk = NULL;
 	if (!sctp_verify_init(net, ep, asoc, chunk->chunk_hdr->type,
-- 
2.47.1


