Return-Path: <netdev+bounces-305365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IyasI1TETGqXpQEAu9opvQ
	(envelope-from <netdev+bounces-305365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:18:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEAE719A0C
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:18:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="N/w1nAY2";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305365-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305365-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30B55306A53F
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 09:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12AE39657B;
	Tue,  7 Jul 2026 09:11:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000E7391512
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 09:11:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415485; cv=none; b=EVMVEye4176r20sDbarkLVqBcRraJt8oTu3QNpm+9N1Z+Pil/5bA6ktoc2bo03/tw+kFNBSxnKG28nv3Es8zRUpn2sTLf2UkKeaVEeLqWHoCME7gGIA/0QKiAnLXYnCAd+Q//jAtOaC24oiR1u7ciebLM29RERIG+k4Z350cH4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415485; c=relaxed/simple;
	bh=YBNEZ0JuBYpp39J19uIA6JD+g8DwilN2ygweuBY+Wvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1R7FtWxri4SERyhNx8gAdZK36YqmOGxzZujqu07QrRZ7K+atlFp6Gu9RiSMcZh7e/VLSo3ZjgbaHWKyj5Z/wzug+Jqy1e1ICSTj5SQcmeEnfMeQWOPvFmA/rm1k25tIrJEfoN2cpBlDeI5udayxIGjzQgPxiX/bL+n1Nvp6vls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/w1nAY2; arc=none smtp.client-ip=209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba3e6so6812437a12.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 02:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415481; x=1784020281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ab4D2p/3Z+QNLOMIvIrg+NC0XFgS2lOf5VtGliLMbQ=;
        b=N/w1nAY2yQOsx7RdrILWrIFBBO3VoguSM2c3VRV2k9KxGeGPN26eyIC7RXxSokqwCK
         SMI3ZGh7pFU2ducfiGxGNGjtcUAlMaNnO8Zx+ReOJTpeSAZKHiVqwpKOzdkOQ43+9lR2
         P0rs2uqFhQikOJE3XMIo/YGe6CRb9iqBfAdtYILL1RNys8o4rbqMQG0x+Lyodf2FwJA+
         7wejT7MfoLLTjQzN3nVYkWRP/ydur5+4pL/6MAcO0BhoGQ3cnpnandE+Fw9S1yilysEz
         DDr2ruBn5W6j4i+vlcXa6i6FcYzsBhsVllRIK25YKdYomw+NakM53Gy/reZfLW6R6OZ/
         hrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415481; x=1784020281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ab4D2p/3Z+QNLOMIvIrg+NC0XFgS2lOf5VtGliLMbQ=;
        b=MwYa4ySVUXYh2NjbfFRhU6wPn/M5ZHH/QbF7IhhUyGHs8Oas+8k5dwAbutrAirr5MF
         FMNukDlVth2Ho44+sck4MikyMxkt+U09NrLBiTJKhOuU3o3N+vrOfznvN+g2SUoE1g2j
         cqregZ7xEUh2Nm0m+hwmvxerroShkFy0ih1ulcMoXR8TYm+vSMEYHzMzHrUX4SiIQ3ag
         Cz6ZuBNzToqif4x6Z9S4Fi0zwtm7jflb42AKDIdQK3eSqi18n/0ylSMap0IfREWZ4QsY
         HhIGHNVaEtMOmZze2HR0tN0QLw4Ddx3QVp8DGLUOMLW/evhIXo88AtVPYWj6RDIsHMZj
         K1FA==
X-Gm-Message-State: AOJu0YxpW2T9UKbdFIwG4n1Jfce2lr7OXBAJ6Yael18sGHuy3it1eCXE
	EKjrj5p7SOu0MfzS/rqHRnUnDZ7a+06LE5Ey5AdvGhxF1ke9U5KhTTfC
X-Gm-Gg: AfdE7cmnf8Qjt55l+OsU8tqiDLhCc1CzC69hKatlmDZiKO1i0F4LCHaCVOXS1B/4KTp
	KwZ/Cid+rR0ab/KlmzkidDltVeYvR+/tohx4wqYxjV16WWRndr+QYKtGvwfOvS5nYBvAgTbzutB
	m5yP15Tx/ym84Yiaqjz7uWubMIGAjtjCeaLw8guiJ9ivaTn6uS6ICP0qM3upz0ZahSPHd5i0szD
	blgTG4AJanJOb8lWGGEJW05K2wzM9CSu8c6JfJXyAlFpkpsS8FXN6d0YzPljxoCaiQfWQCXGXgu
	cy5ZNJshWH8+lhefFCfvxyD2CuDfVPvlcvloZXyQkxDWjg8VhvZ4YLf6DkGXpYR5gBYp515VsRx
	/oCon53bA7XcK0OORTLZ5JA0UMqCB+7vJF8tT4Oh3EHrrGULxURIqi9vk+vls0yhyFUjmvAW39m
	SBSq5lt5A9NZD6zsIfVGPW9ErNrZSw0x/RdRxxgREmGBHhecigv5NRjCTU7ZJqo4lOGubv011BD
	1mypUjbfmp6yLwEe3voy80FwbAoyNm7aGWJLmeZsRJX
X-Received: by 2002:a05:6402:1d55:b0:698:e595:a5c with SMTP id 4fb4d7f45d1cf-69a85651f63mr2079368a12.6.1783415481357;
        Tue, 07 Jul 2026 02:11:21 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd87d6sm5297152a12.6.2026.07.07.02.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:11:20 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v12 nf-next 5/7] netfilter: nft_flow_offload: nft_flow_offload_eval: check thoff==0
Date: Tue,  7 Jul 2026 11:10:43 +0200
Message-ID: <20260707091045.967678-6-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707091045.967678-1-ericwouds@gmail.com>
References: <20260707091045.967678-1-ericwouds@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305365-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,netfilter.org,strlen.de,nwl.cc,blackwall.org,nvidia.com,gmail.com,uwaterloo.ca];
	FORGED_SENDER(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:razor@blackwall.org,m:idosch@nvidia.com,m:kuniyu@google.com,m:sdf.kernel@gmail.com,m:skhawaja@google.com,m:liuhangbin@gmail.com,m:krikku@gmail.com,m:mkarsten@uwaterloo.ca,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:bridge@lists.linux.dev,m:ericwouds@gmail.com,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BEAE719A0C

In case of flow through bridge, when evaluating traffic with double vlan,
pppoe and pppoe-in-q. In this case thoff will be valid only when meta has
been processed. If meta was not processed in nftables, thoff is zero.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_flow_offload.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index f8c7f9f631e48..4f68fb64f1657 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -59,7 +59,7 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 	struct flow_offload *flow;
 	enum ip_conntrack_dir dir;
 	struct nf_conn *ct;
-	int ret;
+	int ret, thoff;
 
 	if (nft_flow_offload_skip(pkt->skb, nft_pf(pkt)))
 		goto out;
@@ -70,8 +70,11 @@ static void nft_flow_offload_eval(const struct nft_expr *expr,
 
 	switch (ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.protonum) {
 	case IPPROTO_TCP:
-		tcph = skb_header_pointer(pkt->skb, nft_thoff(pkt),
-					  sizeof(_tcph), &_tcph);
+		thoff = nft_thoff(pkt);
+		if (thoff == 0)
+			goto out;
+		tcph = skb_header_pointer(pkt->skb, thoff, sizeof(_tcph),
+					  &_tcph);
 		if (unlikely(!tcph || tcph->fin || tcph->rst ||
 			     !nf_conntrack_tcp_established(ct)))
 			goto out;
-- 
2.53.0


