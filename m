Return-Path: <netdev+bounces-296551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ro2YI6TAJmqvdgIAu9opvQ
	(envelope-from <netdev+bounces-296551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:16:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 012AB656841
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:16:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=K8ev+tbW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296551-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296551-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE1C13072459
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A78322B72;
	Mon,  8 Jun 2026 13:09:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533B92F5A13
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 13:09:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924195; cv=none; b=rdCHEkgptuULJD5VPG3UyVBD2vF//mxGGuFLRbIsAzAM3exfC3u0kWIiClNx9Gjrka4kokIdzEbj5QIVJ5vELIbAlhV0xDz6H/bHLdgULjSraUfvmyK7TwvJdAlO6Qqai9GKaQY9bnfvMHfD428HLFTDLXrLz/y96tZ+c9H5xF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924195; c=relaxed/simple;
	bh=tzVwwRRbFLLzumo0f8liPG8O/DKy01uFcLs2GENjTM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgSNNRHMcIZC/LW3mawje49vRmzoxa3/c1OoKQ95+TY/7yblP3LqZXmcduM4bX+O5vwsRsEUiv6kr02m7BnLXSPKsRx5yLvZHr69MsMiubZ2tAnRNjMWiVAJw4/WjKB06UOesXdpzIieYWl82IPbuYQlgWAjRQJhwu3c8lS+FkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8ev+tbW; arc=none smtp.client-ip=209.85.221.67
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-45ef93a0b0fso252201f8f.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 06:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780924193; x=1781528993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nmwh3iU0hu2a/gd6hj28lDa9UinTdJEZ2h8QCwx2/8E=;
        b=K8ev+tbWfEDAZ7xZBNznCYPcMGUbyOaSHbEVit3Pnf/2+iZiGYHH6GkkjjY2l222q4
         aSf8e/hw5+nyGmIrT4vKBNBI6KBllWjtz8EM4ZZqukm9+CLUoOGMRQ3ztLqY/kMYrKKf
         AzAdhdIYeOLNPeoJTPNR91lXqm4RWiYjwTqXB2PuDI5tSdLocZY8JOfRpNrDvPKeD0vC
         h5C1mJSz5884rfER2YS3ykuhSbkTwycfN2Buu5AZorywk4aBqhJeWlZf0A4OoBY3b9BT
         Kddb3htv/1v0sPhqibiARrBk+7ok+j01JnMTLZznzS63IsaNVjMFuQYxW1tTbZdZfG8e
         5IWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924193; x=1781528993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nmwh3iU0hu2a/gd6hj28lDa9UinTdJEZ2h8QCwx2/8E=;
        b=fA1DIfQRrSdVZ/Huo2JZztbjNvPLMq4iCJA62mXwp39FciO2o/+00JeRyiN9I5aLfn
         TP9hXVivBOYY1wXybD8CK+udBhvJf3zwQunlNwANJrphYkduMVtVPGqcLAWeNjOsUdu8
         cduBnTLGB38SalxO/Zee4FQelVMXEB6ZRSBPbVr0MM851DclbyjNRUIE+dcRDBS/0/dD
         p1jxmnzNCqCu3A214JXszfw0u2xwJjMXf9DgR5Vlu24oQ5gskw8sXIZoFb482ns4tlDv
         V5e5IaOCvvylPRVnjcO7m7RhrQYLuN3YsV/T9wGDsCsb3yoWblFnGW6a6v4iqf17Ongx
         6Swg==
X-Gm-Message-State: AOJu0YwE8d3I/H6QsFoAy0ui5ttxgKiC8d80107wUvitUTkM/u3Aw6bU
	dGpUzZw76wpDlKC+ucTdkGGe5C1mlNb8g8N/Gzbp6m/Kr6L5UzWARJIEEwvQiBN7
X-Gm-Gg: Acq92OGmHr6kFb6Hx2kWrOgs3kXgG6GDIYzTCmsM8bw6IbTPuJLKoc6iLDDVgdYAD0w
	nr0kmZRz2fqZz5CRWUQZ9swm4GqOkmM5hU9D3oHHQDXrvJMFd9mM4dJJjqyw8UG+bpY4Wzn+UMP
	oXnIH0yYKEQ+SoaDkDK0xI3LNkspN8KJ1DGgkmK8sr8LOT8yo4ghGUizD+GZRnMPF0X0B9obeLN
	JkyaEeBS2y4MSOjDJ/5O/Qyz2HCPBpg1rl1RUk9W8YJV6yuDt0QLLil5NX9fv/gDmY2TD+jsWvU
	to5jrW20WlPK2gXLKvSB6E0+VVtmm2XqiMikTbZRkWwkVP63Mpo0qnFJoz1iol7A09SFHqHxosT
	2fdZ9P/NPjS0Kj+AJA8Hys3kB91fZs3x+ArP9AAXsrps3AClAZMAqtr3NBz3mgBLaEpGXslHnkW
	r/qN2Dv4eLpR2LZpz5QzBwdIZupP5bbn0=
X-Received: by 2002:a05:600c:540f:b0:490:b71f:2ed with SMTP id 5b1f17b1804b1-490c2603746mr116565455e9.5.1780924192618;
        Mon, 08 Jun 2026 06:09:52 -0700 (PDT)
Received: from localhost ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm300135675e9.2.2026.06.08.06.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:09:52 -0700 (PDT)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	ncardwell@google.com,
	shuah@kernel.org,
	kuniyu@google.com,
	alice@isovalent.com,
	Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next 05/10] tcp: split jumbograms with urgent pointer correctly
Date: Mon,  8 Jun 2026 15:07:50 +0200
Message-ID: <20260608130755.5626-6-maklimek97@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608130755.5626-1-maklimek97@gmail.com>
References: <20260608130755.5626-1-maklimek97@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296551-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,isovalent.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:ncardwell@google.com,m:shuah@kernel.org,m:kuniyu@google.com,m:alice@isovalent.com,m:maklimek97@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.105.105.114:from];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[209.85.221.67:received,172.105.105.114:from,100.90.174.1:received,104.28.193.185:received];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,209.85.221.67:received];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DWL_DNSWL_BLOCKED(0.00)[gmail.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 012AB656841

This patch fixes urgent-pointer handling for TCP jumbograms. According to
RFC2674, if the urgent pointer offset from the seq number is greater than
65535 but less than the length of the TCP data, the packet should be split
into at least two pieces, with a new packet starting at the urgent offset.

Though the optimal solution is to split the packet into exactly two
packets, not sending jumbograms in the first place is a much simpler
implementation which only requires capping the size returned from
tcp_xmit_size_goal when large_allowed is false. Considering that urgent
pointer is rarely used with jumbograms, this solution should suffice.

Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
---
 net/ipv4/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5ac2befbdc58..8a2e256913c8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -963,7 +963,7 @@ static unsigned int tcp_xmit_size_goal(struct sock *sk, u32 mss_now,
 	u16 gso_size;
 
 	if (!large_allowed)
-		return mss_now;
+		return min(IPV6_MAXPLEN, mss_now);
 
 	/* Note : tcp_tso_autosize() will eventually split this later */
 	new_size_goal = tcp_bound_to_half_wnd(tp, sk->sk_gso_max_size);
-- 
2.47.3


