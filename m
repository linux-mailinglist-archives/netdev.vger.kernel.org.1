Return-Path: <netdev+bounces-295705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sQUXFaJ/ImqcYwEAu9opvQ
	(envelope-from <netdev+bounces-295705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:49:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAE1646220
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:49:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=openai.com header.s=google header.b=X8UGYNcD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295705-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295705-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=openai.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0CCF30107D3
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C8047AF4D;
	Fri,  5 Jun 2026 07:34:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD6F40B6C6
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:34:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644896; cv=none; b=WrNvajXrHefkdki5qbhdkdm5W0HwJati92SCcgp57232Sqm+VVYDVGQifjgsWFpaCvc1n14/FxLqgqW4eUXwdIheCEwpX0+1/WuDfj611WXYDnoIg1HQQ2kgKGMzOGmXse6fgAFZf20JAJ9Y699CGm7x+HGG+MZuPZfAVrrpMOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644896; c=relaxed/simple;
	bh=4YkuH/20ddloB7rQpzC10m9FvF4PFxifV0BITwwAaaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sbleUQQJkT7iZ5gjsVD1/wzoVebyIk2S6+82bQkChsqG7jRVe3URbJNcmEDRNIhsJgymqYwS+scH5CCCXTjvPZDjObCBACIvgXUn3SC0vjRVrWABPpI0OhpiXYHEM7sgwHVYB1sAprIOcEpHBYD+VnDE4NdwZ3t/8Rckvl3Am/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=X8UGYNcD; arc=none smtp.client-ip=74.125.82.174
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3075ce9c05aso2836777eec.1
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 00:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1780644894; x=1781249694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qv4s7nh4O5cJPT2nRf5sTYU6UWNN7nkuzOL8ObkoYHU=;
        b=X8UGYNcDyLN8Rq+VoVEAWH4sZQf+RtA+vlqKSUhS1oCRAhzDS5OEvIdzTqb7DaGUld
         nUZbCIvafdQNER8c/HjKBLqpKCDqR0q0YQHT5nacp2DLKSM5jxmdlBU4R5sj9FXCOSFV
         CSHU0LBlLfdLXOd+NbVUy/7iCd/WN6pLcZ8WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780644894; x=1781249694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qv4s7nh4O5cJPT2nRf5sTYU6UWNN7nkuzOL8ObkoYHU=;
        b=UHi8m8qEBft8ahhudOsx5keHG5X/JIT6m/ApOi5INJ0IzKjb7IWZG7Y0eMZnczWIA5
         Gk/gDNrx8aKJZkEmMsA71nphNmsKgarFH8MBVgwdNEY3QYBoBY7LFRAxcg57Vuv1+ljm
         XV9Ikj04jbpFhtg+xJqjXDw+dZ8XZzt5ccRqEFno9ArbAinUhdLCeQXM4e8+RtfbuoJU
         AcQZHUPcsOR7XN6B2SoWjjUcJZJiGzb3RFtuXUOCEGZhESLuKnPM5llWnSOvH3uHyI1Z
         pe9ZVB+PEJlT8ho7E1G9JGAG75AQ8AwwyTVRegQeDFpSFYrRWt9CYE/s+MKrHdbOv4/2
         td/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8OgfDUdBANaf2E8ESGR+AtMvW6RuxWlfEked3/XYwdPhM2CoVxiTOhS+adtWYB6s5E5e9SYcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4qIBV41ESpr+8y1Ne5u6QYGxhYDZLt+XISEYNgzeThRAXi/P2
	UQBZ6wcy68QdthxqVumo0M7XJEPZd+V3y5ME+BzVhKzkuSdbgAdWmnjGp5PY03ap7Gs=
X-Gm-Gg: Acq92OFHSlKfMlHgplIXcr3NoftWsHrBRce9mqd2XNlSyfiRunQQsPOyEqP+56Gnybc
	csAt833+a0omirDCgbPhmqBQDEWuGs9NZme9ITaXQCBJ0dWqT1JfaEFYciq2XD6q52uhCJipkNh
	hHa6mJScmpDm4AnnH2net0At0lHw62G+KX4KNC4IUAEy1nK79p3Oy7injgDQOfg6cEN5N2l//Mh
	s0YvQL+CcqxS0yu4Qz+XNDNMWdybE+dpplPtWQEhHe+DTNiWAaQMagYnFRGP+IEffrC3rKIEOgs
	LnedYWdainnWvDFZLUFpz/JbUtOLCCdiEK/blN1UmfQiZm3swtCJ7mo29o8fTADaxYHNDVdiX5k
	ujpy+FqDPYANsrL/ljxRLVcz5lnx5F8JHA11fFLuy+gdMy/9b/6+BvfQa0UJv3q8cuoMocKO9Xr
	+zKcLqUUrBQ2O5ZZdva9umMV8dKWXV2Fu0SQKr/W65a4FB9skivKi7NRr21rrtFOt2vejktVQHe
	nRZugJm+rpNbBrBpuQ8T1cSBsfbAftrb85Qiwh7HMGQ
X-Received: by 2002:a05:7300:730a:b0:304:4f23:68d3 with SMTP id 5a478bee46e88-3077b1d5f98mr1105898eec.18.1780644894015;
        Fri, 05 Jun 2026 00:34:54 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([104.241.0.233])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074deaab1asm6737032eec.17.2026.06.05.00.34.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Jun 2026 00:34:53 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH] ipv6: sit: reload inner IPv6 header after GSO offloads
Date: Fri,  5 Jun 2026 00:34:48 -0700
Message-ID: <20260605073448.6524-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295705-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:kylebot@openai.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kylebot@openai.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[kylebot@openai.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[openai.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,openai.com:mid,openai.com:dkim,openai.com:from_mime,openai.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFAE1646220

ipip6_tunnel_xmit() caches the inner IPv6 header pointer at function
entry and continues using it after iptunnel_handle_offloads().

For GSO skbs, iptunnel_handle_offloads() calls skb_header_unclone().
When the skb header is cloned, skb_header_unclone() can call
pskb_expand_head(), which may move the skb head. The pskb_expand_head()
contract requires pointers into the skb header to be reloaded after the
call.

If the later skb_realloc_headroom() branch is not taken, SIT uses the
stale iph6 pointer to read the inner hop limit and DS field. That can
read from a freed skb head after the old head's remaining clone is
released.

Reload iph6 after the offload helper succeeds and before subsequent
reads from the inner IPv6 header. Keep the existing reload after
skb_realloc_headroom(), since that branch can also replace the skb.

Fixes: 14909664e4e1 ("sit: Setup and TX path for sit/UDP foo-over-udp encapsulation")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 net/ipv6/sit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 07d416df93ed..ef8705093472 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -961,6 +961,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 		ip_rt_put(rt);
 		goto tx_error;
 	}
+	iph6 = ipv6_hdr(skb);
 
 	if (df) {
 		mtu = dst4_mtu(&rt->dst) - t_hlen;
-- 
2.49.0


