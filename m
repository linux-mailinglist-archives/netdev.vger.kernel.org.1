Return-Path: <netdev+bounces-296108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eyoKOakbJGog3QEAu9opvQ
	(envelope-from <netdev+bounces-296108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 15:07:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5704B64D95B
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 15:07:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=al7NfwL0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296108-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296108-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A857D3010EE2
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 13:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32FC3AF657;
	Sat,  6 Jun 2026 13:07:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2AC3AFB19
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 13:07:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780751235; cv=none; b=pff3FeISKjxzs9wZoV8uFuZtSKaUcwHcphkWkH+dsaRbRrl+tuJfwJRfZfHayq67jYpnePXYu57E8WtbAI7tYKTx9I4omQ3CareH3AY3BG/vhSmsEzJSleaezqsJDR6Su3GcScBQhTHMu1DQD9/QTCcBODQnzaooqyNPOuTfRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780751235; c=relaxed/simple;
	bh=pRgco4WNNdgR8495tajkq9qSwa/BIpevqW2Y2olzEAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=km8x/t46GycaDunPMVFHkryNnulodaJqEP+0JTCQKNi81whf2qKSuls+Q2DeF1k0Il6WnEweHZQpnQJlWfbmpDnKp6cUqsYsBjesWrIdU1VY3WqXbuEKsz+01z2aBv1uuDrVEeHvcy5NAbEL7CjOyzkRIObRMw8fUs+4KXnqhNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al7NfwL0; arc=none smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf0ddaf50fso19440165ad.1
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 06:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780751233; x=1781356033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0v1mafeerf+0c330SrsP+aoq+1EhfoexoEg8eIBj6Kg=;
        b=al7NfwL0Nmap2ftQADwAt6SgPt70R1Y8jO0c+xb0lCwpJGORIbEv9cKjhCsD2SD0NF
         0mLTmD3u49Gc0/bLX2cEthT5plFk97HuXPiN9ggDhigAMCwmV/42sVz5fQTDZiepYZbj
         kSjeAAsJteLq9tIVmuf6b34Af46SHkWzcEFLtMtmuuN5x7IOOR5gc9WoqsEjJlJQsOmy
         n2jbMfohxKioEqME3HpGznpNY6HrZnFoCUOX1Kb9TcAwOaL5mr2HrDvzuLf/7RT2/fh8
         WFyuV6kGlZzQ4F5KSrzBxWQL9PzeTczKc/UfTedMw+4sf1P/JpOu8h+P7oD+Cp8PQvee
         XwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780751233; x=1781356033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0v1mafeerf+0c330SrsP+aoq+1EhfoexoEg8eIBj6Kg=;
        b=iwaeVDHprpj17GFSquFppJOCaqvp1SSH+JlrrPirdbenAnHPWyAzmpV2YiGRTP1CU4
         piFcfbnYlEuL2TB8PLa/F00aa7tK4TXnak65SV2Q2UWt6y6tHEpQPoHqOqzonszVXSAq
         Qwb2cMiubiTtJ+IRvsvWZ5wK7LIOEf4Q3eds8SMZHqNKrKxr1F1ha8Y0KvAf1Z8yCJ/V
         XaxgJXHBUKmngFo51ERI+d5lXjzLszPaWPf4AT4yWAfSuFbgPI4dL9tCZsWc+JfccPKJ
         y5MwLmVQqXCopLb5h7Pv+A12n+MTQ44XP9NLzHpmmo7NW2YD6x3UB91wvqfrYMO8/r2A
         uzXA==
X-Gm-Message-State: AOJu0YxKg+aMRBVfvUgGYki4kbgycwy0xhK2J6iwE3mTGbsBq2f+BrSG
	mGiOmtKafhdJ3QNQ9aQPNqMqqFapDES2kdIFhD8rCWC5fPkjWQtp+YjkfQRR54IX
X-Gm-Gg: Acq92OH5udGbFJhWYz39swJ+tQ7foBa7jSLlxKtoG6+zrLQsIpx32L61QbZi+/gCxdR
	JMbfvylgzMHq0FP0b0kaAEhRHnok29cfNXSW9ncgxB5a4MBT2+n020Sgb6SZYc1mUVAmtVCZrF3
	aAi2YunPeifyb8xU+ZfJR/k3g9xbUkdPLfhnN1l0MBAIATsyL5poqmFs39JN0eriUqZ8idP1gsR
	nXb6by+hyMaxylt64HUthbnJgmDwncIQM226wT/xLC3VAp9nLIbnP1oKb+f2rzC8cvkmap8KIAP
	CSDM2R28EdboSWznGGL1JRD8RA1UEMZ34X0XOZuERlpq9fiAyhHIATJ8o/Zl4+dgBOv2Zyk8TYZ
	1PEn72yjcuIjbXEBu9Nwuk18SpKfUZLKoKRIJuPO2fZEP/WqoABJ5IV5qQflqy2wWu1IpDhmHGj
	wValzJduhszdcpEaS05q0F+g66b3pt2hALKNnrUItGaAqd5ai4aNbmIVcAVFZV
X-Received: by 2002:a17:902:f611:b0:2c0:b5c1:8e3e with SMTP id d9443c01a7336-2c1e78e4f03mr98989835ad.8.1780751233100;
        Sat, 06 Jun 2026 06:07:13 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661b:3046::4cf:38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e627sm126349745ad.52.2026.06.06.06.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 06:07:09 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 1/2] net: dsa: tag_yt921x: handle ACL tag code
Date: Sat,  6 Jun 2026 21:00:06 +0800
Message-ID: <20260606130011.307812-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606130011.307812-1-mmyangfl@gmail.com>
References: <20260606130011.307812-1-mmyangfl@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296108-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5704B64D95B

This prepares for upcoming ACL features that use forward
redirection in ACL rules.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/dsa/tag_yt921x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
index aefef8c770e3..f3ced99b1c85 100644
--- a/net/dsa/tag_yt921x.c
+++ b/net/dsa/tag_yt921x.c
@@ -49,6 +49,7 @@
  */
 enum yt921x_tag_code {
 	YT921X_TAG_CODE_FORWARD = 0,
+	YT921X_TAG_CODE_ACL = 0x17,
 	YT921X_TAG_CODE_UNK_UCAST = 0x19,
 	YT921X_TAG_CODE_UNK_MCAST = 0x1a,
 	YT921X_TAG_CODE_PORT_COPY = 0x1b,
@@ -129,6 +130,7 @@ yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
 			/* Already forwarded by hardware */
 			dsa_default_offload_fwd_mark(skb);
 			break;
+		case YT921X_TAG_CODE_ACL:
 		case YT921X_TAG_CODE_UNK_UCAST:
 		case YT921X_TAG_CODE_UNK_MCAST:
 			/* NOTE: hardware doesn't distinguish between TRAP (copy
-- 
2.53.0


