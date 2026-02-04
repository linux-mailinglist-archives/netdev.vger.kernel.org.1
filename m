Return-Path: <netdev+bounces-256861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBZ0CuDNg2kFugMAu9opvQ
	(envelope-from <netdev+bounces-256861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:53:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAC9ED1A1
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 327D83004C84
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18423393DCC;
	Wed,  4 Feb 2026 22:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="g0FwEj3J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74AD2F83A2
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770245592; cv=none; b=S0SA2+M718LqStC5HNp7TqeseSUHNFIeNgz18xXWGptUqK6YMgD/FQJFwFbJiExNgfwXfxGqX71h0ka6sUpdWhLHQSF1nb8l1lHDL7Q1n4fOxdTUVKQDLQuvJwQBiZVhEQ0xoOWdGJFJy7A+fdEt1xzFmrrUkWo7Td9o40+oQcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770245592; c=relaxed/simple;
	bh=8ZfjQlZIrGZv+8qrI9/hknHEVCm91kVdPcJc052ah6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bsgoa7jFzf0lgY862X2MMcVzGA4tDPr/1GseqRouufTQA+L77/1dXy1nmEpBAOYL5eCTzkuGPhzzWIiY9a0kWqIyAPXknXTGp2JB6+QTxEXbmHBBj4oNMvc7Oq3stmSZt5OLpn2rXOpI6lXSQWTGVfB1+RnEDho0f3T1EwNlRi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=g0FwEj3J; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12460a7caa2so489883c88.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 14:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770245591; x=1770850391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uhV7MNswbWoOfPP7JwFpe4L9Q+zeQVQWZQm23TloSs=;
        b=g0FwEj3Jt49I6c6Po4VO4P6HaZTDVJxZ9Aq/aJ7mQ3+lu+9Zdx3SrBiNEzcg6D8c0/
         Qkgq8R1AqvPpHxZbdGy37X03OI1vt6AQp7ZZ5syr0oEDoOipr5rhK8a+dH5PeZxH8xZw
         5iDDmSN2umDrtqlfc3NQ090mlm3fIEhIqt2rRc+ruI5nkgZKe/mHfmzugRLTbpzr6nqR
         AcMkkof1YMKgxV9sbF6Fn0HC6OXzrVZsQRfqQu80tH3TQWlyqjoJT0P3KX8Q9ujEVFaL
         NKieWkIIOc53ankYI8axv6cvPpji0DZiSdulQbURFs5K1luu6GzYyUpo818T17h740Of
         GWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770245591; x=1770850391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3uhV7MNswbWoOfPP7JwFpe4L9Q+zeQVQWZQm23TloSs=;
        b=LVQ8HT2y7L1FrLjLMi83Xg1SWV1OPstOMuJN4VPdSTDMfor5H8kmgByWj0ledwHshf
         94+Jh1HVKVk0VBwYFbgYp/kBehTEd3/jaPOWnTpYBLiVp3XP/lnA9O/24Q4WpiibhPHr
         tyd22SGw6NfufpWP0f8L/si1cmOKHnUg7IEke67UrrBUDIgvC2wb6IMc8xJbrxI3MCgL
         NGtSBERYg6FzDcr3vS9+2NOHzwVA4YxZjP+YxI8EqlouF2S9VsSWQSRzLylxVqA828Wh
         lZnN5ZGsVp2adYzotreMWkwE4mpm45D4cHxq7TajMiWVUiA7RiaZchqcD2iQaOncSSYH
         8vOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYPTcGtYhQ9uHsj28VrHMgvtAxqVyQ0SKSXSRJ1AWDuFfE4H4tLU9wtXGHeZ/6TPTqYLMCgWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoNEjI/eQZuTXu8A02gxL+ANPVPftLsbaKzGmwwopHicJ9PKEr
	ooXxPuIc83paMl4uXuF6UsCbXG7g2bejiaZ+tZnBESzDFYmQbiRIKlhHekzGr9vMDQ==
X-Gm-Gg: AZuq6aK3rZPBT1Qsy27Rmv0i6pbN2oGV+ULdHQxjfqoHCILo6lxh+qwzxZAHqW50n3C
	+gjnzdB7zenAi4CgBPTCTI6ayKYfn42MjAIWk7INxcl666InN0IKqsblzkgzK3iJQystIE0qZVU
	AvUkHKx7VvOZ+IY/cne7Deuxds8znPxwn4c17DkH6joey7Li6GbBR0PmGMmiJBax6UMdlMR7D4F
	zK5EIl9nwSLSrqPApthZ55QWgZAEgdtcrBJdjWK3D4SZy5rrJCx913PlhWRLq2gGYl9FsGTAKv9
	8yLhyySLTD16zme3hmhvk9UOgcZxiDqtraqkaT62GAgHBNdi1NlInijFquPbyP1Qcof+A+K3qNo
	Xhnjz5U9BR44wWbVlcyg6m5mQtoBbCMvqxQFhuzg45y7QCLQdyk6eq0+B0ohsx0bil2m37QCP8E
	vI7O6i2S+S9u6gcPypq1z7wcFgLUOG70JF9jMiIZNe1jlOcccIHs6CFT+x
X-Received: by 2002:a05:7022:24a8:b0:11b:9386:8264 with SMTP id a92af1059eb24-126f48d476fmr2200167c88.41.1770245590878;
        Wed, 04 Feb 2026 14:53:10 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:5ee7:5720:1d16:9b50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832feacc6sm2587040eec.35.2026.02.04.14.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 14:53:10 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v7 03/10] ipv6: Add case for IPV6_TLV_TNL_ENCAP_LIMIT in EH TLV switch
Date: Wed,  4 Feb 2026 14:51:47 -0800
Message-ID: <20260204225154.58245-4-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204225154.58245-1-tom@herbertland.com>
References: <20260204225154.58245-1-tom@herbertland.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-256861-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FAC9ED1A1
X-Rspamd-Action: no action

IPV6_TLV_TNL_ENCAP_LIMIT is a recognized Destination option that is
processed in ip6_tunnel.c. Add a case for it in the switch in
ip6_parse_tlv so that it is recognized as a known option.

Also remove the unlikely around the check for max_count < 0 since the
default limits for HBH and Destination options can be less than zero.

Signed-off-by: Tom Herbert <tom@herbertland.com>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv6/exthdrs.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 6cc18f35216f..bfce1ddab1c5 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -122,7 +122,7 @@ static bool ip6_parse_tlv(bool hopbyhop,
 	int tlv_count = 0;
 	int padlen = 0;
 
-	if (unlikely(max_count < 0)) {
+	if (max_count < 0) {
 		disallow_unknowns = true;
 		max_count = -max_count;
 	}
@@ -202,6 +202,16 @@ static bool ip6_parse_tlv(bool hopbyhop,
 					if (!ipv6_dest_hao(skb, off))
 						return false;
 					break;
+#endif
+#if IS_ENABLED(CONFIG_IPV6_TUNNEL)
+				case IPV6_TLV_TNL_ENCAP_LIMIT:
+					/* The tunnel encapsulation option.
+					 * This is handled in ip6_tunnel.c so
+					 * we don't need to do anything here
+					 * except to accept it as a recognized
+					 * option
+					 */
+					break;
 #endif
 				default:
 					if (!ip6_tlvopt_unknown(skb, off,
-- 
2.43.0


