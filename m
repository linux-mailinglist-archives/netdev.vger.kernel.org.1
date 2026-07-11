Return-Path: <netdev+bounces-306790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CMjXEHULUmoKLgMAu9opvQ
	(envelope-from <netdev+bounces-306790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:23:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3572E741080
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:23:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oUG1QddS;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306790-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306790-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9EBD300AD4E
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C8D386C2A;
	Sat, 11 Jul 2026 09:22:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E8B388868
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:22:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761774; cv=none; b=YLG0IwoCq/P5HUsqy764a3sBLvJuTnECdIfbEXc4qRlP0lLAsZcGOAKtz7eTJiMxu9rqojRDHmbFV1V8KOdtZIRVgw0Xz/zu1V4EscvxmdejNEIBXSZeKIjMlBgyILqwSf+llZHu411mlrUCKPDkrz7CaPhqynLqlU+uflOEtoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761774; c=relaxed/simple;
	bh=mDM9Ligu7A+i1c5bQaZxxOVFQ0ClldFLx74pGEaA+oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaM72bsEheU/nFNgC3a/ril1mvU6MqNfyAMytZdfKx6hp5AIP21nukeFhvbd+/MH/hMg8TQxEfpk26SmsbvYsTGa1BKkB75ucNXYCGfMMcjyjzdjM9s3Rhvv7UIObPiHce3p+/aWm1nj8fI9X9LsfMrNW91KYIZJaNiYvtdrvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oUG1QddS; arc=none smtp.client-ip=209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15ec1da77aso195032466b.2
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783761771; x=1784366571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ndWdMIRoZiw7wrosi/rRhBvTDxisTiXVuV4qMbAvHHc=;
        b=oUG1QddSZxU2P/GoR7KtrYkA6/vz5MVJNA/7KUzR2GQsRWBwoOmH4SgeAcxy8BEz1n
         B4LYwmPKEGT9oJZEgcb2bijvA6TyXZaSQbI+i6FYR30lrAnTMvhlXABwE/BHnqe8N3ET
         16+wqOwSTPrvH++ucEzqoDbet/uZUp2QMSDyA9rZ1L1mi/UepvG57lhFDaV7s3CEwWin
         b81Hx3qhm/Eb3EyrqNUe8H5DibGUkUVBqy2rLyPuWCUKHKH9twSM2k7HoZ/T3JWzecI2
         kAdDHgqHjaq7ovXHCaJBq2WlWH7k9vm5N5o5RJnhLLYtpDH/KE/s9xsjbY91nN2gsm+V
         tUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761771; x=1784366571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ndWdMIRoZiw7wrosi/rRhBvTDxisTiXVuV4qMbAvHHc=;
        b=JREw9wZ0VgUDYuXSlCBAiJi7+OGYspE1Yvjw/pHmem8LkiCuI2LB394UqS4698Xses
         7+p2JvKaWKCSxShdeYKR88GKzyJMno501Ccl2gDjB9VmHUOHzO6xttr2mZJcMUi0Qqgm
         xRL3nVCwXpaIUb4FegVnePflgdQ5GMm6cPo/jUhjdoS4tpwKsvPI1OW7npPViVoYgXT7
         SSkdckFn3kp+31NlBpRVIaMCNJWSGAkWWw2TlIXHRA+VRnbcENHBJ2fTbrmGbSVw2da1
         AM6XtB/cCOzQ3PbH02Yr3M8IQXeysBDpbLtwSOsCmGw+6alDzskGKd6LcJtLOzWtX9XQ
         soxQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq6KP9x+WZGq1Y3FIOi+9zTob4wQdrGD9K8T74ti3zgWd+GKlkIjqAj/d0v957Wk2PM+F/95GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNQhQT+C516BcrDcY/ib7PHGwXjYWwBSrLc6Cx2/ym8Dlk4cuC
	pPM6AOXG8fyCANVE5ZF1u/5vmwqJoXbBq20on768wsc3AxL9Nmg7Dtxs
X-Gm-Gg: AfdE7clo9XzuBnqGVdxAeoAaFC+pnaCmzBoW/WS8NDjqFllBSYZG6FVrMSKMHwS8nGo
	OuCFswgrH3HoyyUAlEEWQRW41/8uxRwVwpH2h+O3yqZpWYTNb6YG6Wnrpm8TQyBiz2mcYXJp7C/
	2mpRl1usLHuF9v3DR89skqGL0uW9pQinF5GoDyuR1JTWkGG8zjD+95Zl7n4Zb6lqklYjiTBRfTJ
	JUzxwKYvFYd4M0tbPFW2DBijvbiz+wcXQlfYuqc0smtqHlsUMlZsiVaTb5gNh2th4kGWpEP+cdU
	/OgMP31Km4fT+hOFAjHA+6PAur15SFThxBXZMj/bL6jOx4Ve2bDwq9ZRhzT6mIa2z7dmy3XJx8A
	PYQ+bHEJ907mynwbAu6v0p6eOMM9eJSFkbnaL/xbN0C8CRy6mejyLnoYMTXl41zsMy68TWBh7wp
	8gT/WP3niwBdsPUz1+LcTiDEKMshCTF1JboeYtAzH0/3KQqQi5dv1F+F2txBmxG5qD7x29M9bWA
	GNjIYAUio6enZgCLRuBaGWgMqLqZ36JqQ6qj8D67mI8F1I=
X-Received: by 2002:a17:907:6d07:b0:c12:73fd:a6cd with SMTP id a640c23a62f3a-c161f35cd90mr79405366b.52.1783761771294;
        Sat, 11 Jul 2026 02:22:51 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-221-54.dab.02.net. [82.132.221.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d3859f69sm517493566b.27.2026.07.11.02.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:22:50 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org,
	asml.silence@gmail.com
Subject: [RFC 4/9] io_uring/zcrx: split frag handling loop
Date: Sat, 11 Jul 2026 10:22:14 +0100
Message-ID: <3a52d7adf84dcf6f3182c4a64e34cd186e3e729a.1783619193.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783619193.git.asml.silence@gmail.com>
References: <cover.1783619193.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306790-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:io-uring@vger.kernel.org,m:asml.silence@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3572E741080

A preparation patch splitting the frag array handling loop into two,
where first we skip frags below the requested offset. It makes further
changes more readable.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 816a169b848e..162e67287916 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1877,23 +1877,29 @@ static int __zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 		const skb_frag_t *frag = &shi->frags[i];
 		unsigned frag_end = start + skb_frag_size(frag);
 
+		if (offset < frag_end)
+			break;
+		start = frag_end;
+	}
+
+	for (; i < shi->nr_frags; i++) {
+		const skb_frag_t *frag = &shi->frags[i];
+		unsigned frag_end = start + skb_frag_size(frag);
+		unsigned copy = min(frag_end - offset, len);
+		unsigned frag_off = offset - start;
+
 		if (WARN_ON(start > offset + len))
 			return -EFAULT;
+		start = frag_end;
 
-		if (offset < frag_end) {
-			unsigned copy = min(frag_end - offset, len);
-			unsigned frag_off = offset - start;
-
-			ret = io_zcrx_recv_frag(req, ifq, frag, frag_off, copy);
-			if (ret < 0)
-				goto out;
+		ret = io_zcrx_recv_frag(req, ifq, frag, frag_off, copy);
+		if (ret < 0)
+			goto out;
 
-			offset += ret;
-			len -= ret;
-			if (len == 0 || ret != copy)
-				goto out;
-		}
-		start = frag_end;
+		offset += ret;
+		len -= ret;
+		if (len == 0 || ret != copy)
+			goto out;
 	}
 
 	skb_walk_frags(skb, frag_iter) {
-- 
2.54.0


