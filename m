Return-Path: <netdev+bounces-268643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD5gLHtvuWm8EgIAu9opvQ
	(envelope-from <netdev+bounces-268643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:12:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB182ACC01
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E620300A3B9
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9743EBF2D;
	Tue, 17 Mar 2026 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQMudSae"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E133D3E928A;
	Tue, 17 Mar 2026 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759887; cv=none; b=hwJBbp9PdKswXYq/bpWumd9C4O/2kfzLhFFs2pOLTI+cVR3eXCFruvBTvdamEsNCWln4RCSGsKAhxCFyfQLeGLER9iKSji7QlJm1k5Le/hS1F/duGDTNNpth8DaxkkKlOA2E6/rxO28tuKI58Pxw9LvdMI1VSr30CUl8H2eRW84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759887; c=relaxed/simple;
	bh=mvbTCT9oZuKgIjAfId10KTxCViW0Z75S+wpElFT6Ag4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RH/okgvg198Pl6IHtC/Fht6WQxIF89GdA6yyZ07WqwXpDMHmMxkzyTFW6oUS0YeAUHvnbmO/CXo63E0F5v6kK2/EwbeBibe/sOvfRhczZ5DHvT+YQt+iXPolEpbPDMZOHR/1/sEseOD6no06pUGJrpwMdjIl/+uOsHAQLKAD1uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQMudSae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2154C19424;
	Tue, 17 Mar 2026 15:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773759886;
	bh=mvbTCT9oZuKgIjAfId10KTxCViW0Z75S+wpElFT6Ag4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iQMudSaeGVodzHbGRJZ/tY0VpNU1rqfSJM9DBCck291pCmoItxQqAY1n4sQzTP62r
	 I/nvA5zMxDRIQH77PwwsYG3U4396FUF6TT0ikTC78kijX7en8SY7Zy5e0efXXSYRGH
	 G7pEpv5kIL2mb4AWgSchMpZBjI14x411kO0d9CCNyeyqrPO76Mm5jm3qJa8vZWU5ZV
	 odC9QnyvRu/YJ51ZTUgUKpnZTWB6VzMETRde5pwT6TRo3woviCLzbAINkNtJeMsIDZ
	 TS1brNgRe1oKFQUY3ul55pS1I+QQ/ZtbyI+uXEnhWwkinVNg+9+T+ctu4dttaB02pU
	 sBRa0VUpVhz2Q==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 17 Mar 2026 11:04:16 -0400
Subject: [PATCH PATCH net-next v4 3/8] tls: Fix dangling skb pointer in
 tls_sw_read_sock()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-tls-read-sock-v4-3-ab1086ec600f@oracle.com>
References: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
In-Reply-To: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=WmgXzZq5D9MSoBw3hB8UIgm+pezKCNTdwkRs3+5yxgo=;
 b=kA0DAAoBM2qzM29mf5cByyZiAGm5bYqiL4OonVdZhDFuWB508Q44FAKcDz3UcmtM4Gsajyt+h
 4kCMwQAAQoAHRYhBCiy5bASht8kPPI+/jNqszNvZn+XBQJpuW2KAAoJEDNqszNvZn+Xo98QAKv0
 2ammD/qhva99c/7wTIYZu3zMBb323IVJjyswjP7bdqPGfPkitqjFh46MPYlGJMW8ASWt5jbFUd2
 AnM0hxwJStuzLgw31/M7s7l7RKpWsc3WKX0BvrNB8/i419T69E0/nVJBX5Wb2N9Ky0pd+rYQ7EZ
 9eFUzNH+9z+WZuL9aDi5XiUcvUluDx0BUUprq/OApAY/kXLpz3M4bpfiF6FXUQUY6u+M6vBQYMB
 T8wbk7HUnbXYmQhzxGKV6N/A+6qb95finFDHuXmuvElYL5GmeY7dZFZzVMqR8IqiqjAoN20cq4G
 tUcyk7rvdX5xn/YT2hIinc3jmJGiPq87BllNvaZobzyGwjjRGj82QvedUQPcXgT1nWYub1/DTO6
 YpJ3Zj59qBMqY0JgjT58RkHZAQceTUYMgIEr0g4V2y7gJ8Z81FnEeXYZPhubbCTBRQmhNi0F7+o
 Zb7uMVIjzP/CxkGQxNoa549gXc6XEnSthsiI1daEjkmiUf4cnZrJcLuVs9SJ7NbEfiV8pHnLnGZ
 Z1lm2rV/Nz5u1Bh5qEIkOZNNo5CBuOJBfPaLqmnJ+HXUC3G7uM4E6LP1GJQwXkcIR+ii9Ke9nh5
 0uDhnpkpznHPdiXlQCfkPKangykeqCj/exITmBlBsfz3QkfozolWvHChIhtaD+3XI69eNmZ+F1v
 Eu/VY
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268643-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 5FB182ACC01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Per ISO/IEC 9899:2011 section 6.2.4p2, a pointer value becomes
indeterminate when the object it points to reaches the end of its
lifetime; Annex J.2 classifies the use of such a value as undefined
behavior. In tls_sw_read_sock(), consume_skb(skb) in the
fully-consumed path frees the skb, but the "do { } while (skb)"
loop condition then evaluates that freed pointer. Although the
value is never dereferenced -- the loop either continues and
overwrites skb, or exits -- any future change that adds a
dereference between consume_skb() and the loop condition would
produce a silent use-after-free.

Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index bdbdaf40b3384298c80082c3acabcdb9a2becfc8..07f4a3d1a6f854acc7762608cc7741b3de95c195 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2364,7 +2364,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		goto read_sock_end;
 
 	decrypted = 0;
-	do {
+	for (;;) {
 		if (!skb_queue_empty(&ctx->rx_list)) {
 			skb = __skb_dequeue(&ctx->rx_list);
 			rxm = strp_msg(skb);
@@ -2413,10 +2413,11 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 				goto read_sock_requeue;
 		} else {
 			consume_skb(skb);
+			skb = NULL;
 			if (!desc->count)
-				skb = NULL;
+				break;
 		}
-	} while (skb);
+	}
 
 read_sock_end:
 	tls_rx_reader_release(sk, ctx);

-- 
2.53.0


