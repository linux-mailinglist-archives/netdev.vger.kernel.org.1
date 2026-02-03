Return-Path: <netdev+bounces-256043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PftBxNGgWnNFAMAu9opvQ
	(envelope-from <netdev+bounces-256043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:49:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BD6D3234
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8E06300DD6B
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 00:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0501E1391;
	Tue,  3 Feb 2026 00:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Ql+5sS3u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830221F75A6
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 00:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770079759; cv=none; b=WydX870NqdH0Ta62YQS6EO9v8pyrcm/rdUThF4sHk9vHb8wTijSujsa4ygN/3b8YV2Epl3Ue7FiUI2XoQQQh33dR0t4Hibz/u5lgh1/u7bYno7zQhKQcMVVYJtC+K0muZ8/Hc6DmB/M7OmdFq8nHzuAftb9RsWMAuWYKE/NlRvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770079759; c=relaxed/simple;
	bh=anUcLDNTJUQ71jArGdLAaT2fS1aB2o6T9oLaLBaovG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7vrj6pXKrI5yf0oAt7HdFZnTAvy0vOghTw2p/xAt4V4ZeyUXwGGQuFR6eh3Ues6e4Y+OhYQzOVRXzl+bFS+Mosa/EsW9+PuFLs5j6wfxzHpDDmGXMl40TuIHY6J5Y3xQwRziAqCpuW8EndIAX2qk6ci/76YtRkkY4RZ/QbF5CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Ql+5sS3u; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b73112ab62so4742133eec.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 16:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770079758; x=1770684558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjYGhnRJqJWnDFMnnx3nyDtij7LsYN4Y5gfjZ1Dl91w=;
        b=Ql+5sS3udd4moLJQmfSiRJeyz8sIZMbz7Wn7gzHv/xaeWCASsE34rFCcRwwBIH5xSQ
         djxuPFc52k+z+eo8rJNcNBzye6cA2NZX7Qvatql1+0fcSrt0MzHYxNLdjLQ7LIR9bqUr
         IJAAVylkQyD2qqmFG8cCkGwdCZqh48o0PqrgwAfEvMzdkxOBNQNop8zOLYVUw/xrzl2V
         Wt9DYZU57XwE6nrAUll0TMGR6YHQrwtseLtpommY6LCzEotKPA2M0zXRlgMxhCBnJ5bg
         loabRy0HiZhsg/D8nNpmrRbUyqB6GDlgKBD+a9OGGm7GAT4IffMucFEsL2pHqfdhgfpl
         Zh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770079758; x=1770684558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JjYGhnRJqJWnDFMnnx3nyDtij7LsYN4Y5gfjZ1Dl91w=;
        b=bq8uQd1tkjJVckviT1j69S+Lk8klIAUzWxm7nryEtRLK3hieMO33//0XygwrBx/kqx
         k2c60cnhSWuA0lb1lpJQucl9nds0BBbt07gntpZj2OtBjYUxpeHCxpDAnhviDOx+WJxS
         FhXXYWdEvlIGV7I6ohUXX6lUgwL0x75JrYqL8mgLJYq4wzsXwsXHc/HicjeeoelaJnG7
         +HZYkDln3CsxooevuurCY0Q+9vUY9a5JLZ6Z7YRXGLP82BjFQ1XA5+PwqFMMIGh2b9gO
         X9rTOWaqFZH5snY3Y0qZHWrZHdeG7PGhyRRJJqqyo4d1XE4ZwhQI/gLplneT0oarjYkV
         Zotw==
X-Forwarded-Encrypted: i=1; AJvYcCX2RfycQUQBdnV4+sY/lrgCu6KCdK9EEw09xmciWBMF2uVOfsf8B/3ihzYrjoYjs5f7FGpv5aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRXUVYI0IfBiBKDpCMfKmeM91tJT1ze6F5XDQZNL+wjO4mxPR1
	IXQUpuD0XdLnezu040g6dnWLwyDUBK9l0wNXAaSn7yp53gU11l3HmKVk7kSjdTZcxw==
X-Gm-Gg: AZuq6aKhjkWhn0b8AQZtUmes/wvvHKJj3HFEkmauhN7C2luSzSd4BW0lxrxTJm5xxL6
	1ioWs98+dQvJ4BhLwTM9aD/QLgl0rmNDK3SGD6RqpSiFHBHMaf5ou9bb4kYGhKFawlHrqra5nMz
	bm9BON0Jye4705s30Ni6ercl3pXz/hOApk+QOMv6t066Kc7hNFu8a5a7bqd/xVcCRq7Xdw0e1nD
	6hwexR8i8dSSBtdDBstV0f/9ot2OZFBoe0t0O3ZER2R6FlFR19Qx5kWNWQpmo7IydTac+Y4dI1D
	A9C/QKv5MhzBWVV2CzqdHLD8BOF9XxyCl5WQHmBDi3GsAOhtwCarPUEJtld2liWWz2EaADOs54/
	gHyXqPPA69NzetBSOrovB13u5K0yLIBl1ipgvv+MS7cTKC+Bef3aYuUj4nEyJoXenSlRhl20MPm
	R0ym9nEQx5kejMIe0K0OYA7/CEFkuyxuuaDUdsGw5Y2zHXytPY/Mrz7+Gm9o+IHS9BCdc=
X-Received: by 2002:a05:693c:3004:b0:2b7:3240:5412 with SMTP id 5a478bee46e88-2b7c8909a53mr6011896eec.39.1770079757537;
        Mon, 02 Feb 2026 16:49:17 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:d7c2:35ea:5a4f:74f9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe92dsm21017016eec.17.2026.02.02.16.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 16:49:17 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [PATCH net-next v6 01/10] ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
Date: Mon,  2 Feb 2026 16:48:44 -0800
Message-ID: <20260203004853.94438-2-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203004853.94438-1-tom@herbertland.com>
References: <20260203004853.94438-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com];
	TAGGED_FROM(0.00)[bounces-256043-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,herbertland.com:email,herbertland.com:dkim,herbertland.com:mid]
X-Rspamd-Queue-Id: E5BD6D3234
X-Rspamd-Action: no action

In IPv6 Destination options processing function check if
net->ipv6.sysctl.max_dst_opts_cnt is zero up front. If it is zero then
drop the packet since Destination Options processing is disabled.

Similarly, in IPv6 hop-by-hop options processing function check if
net->ipv6.sysctl.max_hbh_opts_cnt is zero up front. If it is zero then
drop the packet since Hop-by-Hop Options processing is disabled.

Signed-off-by: Tom Herbert <tom@herbertland.com>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
---
 net/ipv6/exthdrs.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index cd318ff0dcd8..f7f7bcf9395a 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -301,9 +301,11 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
 #endif
 	struct dst_entry *dst = skb_dst(skb);
 	struct net *net = dev_net(skb->dev);
-	int extlen;
+	int extlen, max_opts_cnt;
 
-	if (!pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
+	max_opts_cnt = READ_ONCE(net->ipv6.sysctl.max_dst_opts_cnt);
+	if (!max_opts_cnt ||
+	    !pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
 	    !pskb_may_pull(skb, (skb_transport_offset(skb) +
 				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
 		__IP6_INC_STATS(dev_net(dst_dev(dst)), idev,
@@ -322,8 +324,7 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
 	dstbuf = opt->dst1;
 #endif
 
-	if (ip6_parse_tlv(false, skb,
-			  READ_ONCE(net->ipv6.sysctl.max_dst_opts_cnt))) {
+	if (ip6_parse_tlv(false, skb, max_opts_cnt)) {
 		skb->transport_header += extlen;
 		opt = IP6CB(skb);
 #if IS_ENABLED(CONFIG_IPV6_MIP6)
@@ -1033,7 +1034,7 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
 {
 	struct inet6_skb_parm *opt = IP6CB(skb);
 	struct net *net = dev_net(skb->dev);
-	int extlen;
+	int extlen, max_opts_cnt;
 
 	/*
 	 * skb_network_header(skb) is equal to skb->data, and
@@ -1041,7 +1042,9 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
 	 * sizeof(struct ipv6hdr) by definition of
 	 * hop-by-hop options.
 	 */
-	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
+	max_opts_cnt = READ_ONCE(net->ipv6.sysctl.max_hbh_opts_cnt);
+	if (!max_opts_cnt ||
+	    !pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
 	    !pskb_may_pull(skb, (sizeof(struct ipv6hdr) +
 				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
 fail_and_free:
@@ -1054,8 +1057,7 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
 		goto fail_and_free;
 
 	opt->flags |= IP6SKB_HOPBYHOP;
-	if (ip6_parse_tlv(true, skb,
-			  READ_ONCE(net->ipv6.sysctl.max_hbh_opts_cnt))) {
+	if (ip6_parse_tlv(true, skb, max_opts_cnt)) {
 		skb->transport_header += extlen;
 		opt = IP6CB(skb);
 		opt->nhoff = sizeof(struct ipv6hdr);
-- 
2.43.0


